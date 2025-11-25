<cfoutput>
<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
CURL_PATH = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;

// Tag IDs
TAG_SEPT2025_COHORT = 23506;
TAG_HABITS_COMPLETE = 16876;
TAG_FEEDBACK_COMPLETE = 16874;
TAG_ALL_SURVEYS_COMPLETE = 16692;

// Survey IDs
HABITS_SURVEY_ID = "8344775";
FEEDBACK_SURVEY_ID = "1013764";

// Tracking
local.processedCount = 0;
local.fixedCount = 0;
local.alreadyCorrectCount = 0;
local.errorCount = 0;
local.fixedStudents = [];

// Helper function to call Keap API with retry logic
function callKeapAPI(myArray, retryCount = 0) {
    try {
        var myPackage = "";
        var myResult = "";

        // Convert to XML-RPC format
        invokeMethod = createObject("component", "utilities/XML-RPC");
        myPackage = invokeMethod.CFML2XMLRPC(myArray);

        // Make HTTP request
        cfhttp(method="post", url="https://api.infusionsoft.com/crm/xmlrpc/v1/", result="myResult", timeout="30") {
            cfhttpparam(type="HEADER", name="X-Keap-API-Key", value=API_KEY);
            cfhttpparam(type="XML", value=myPackage.Trim());
        }

        // Check for HTTP errors
        if (myResult.statusCode != "200 OK") {
            throw(message="HTTP Error: #myResult.statusCode#", type="APIError");
        }

        // Parse response
        var theData = invokeMethod.XMLRPC2CFML(myResult.Filecontent);
        return { success: true, data: theData };

    } catch (any e) {
        // Retry logic
        if (retryCount < MAX_RETRIES) {
            sleep(RETRY_DELAY_MS);
            return callKeapAPI(myArray, retryCount + 1);
        } else {
            return { success: false, error: e.message, detail: e.detail };
        }
    }
}

// Helper function to add contact to group
function addContactToGroup(memberID, groupID) {
    var myArray = [
        "ContactService.addToGroup",
        API_KEY,
        "(int)#memberID#",
        "(int)#groupID#"
    ];
    return callKeapAPI(myArray);
}

// Helper function to clean survey list
function cleanFeedbackSurveyList(surveyList) {
    var cleanList = rematch("[\d]+", surveyList);

    // Remove zeros if found
    var zeroIndex = arrayFind(cleanList, "0");
    if (zeroIndex) {
        arrayDeleteAt(cleanList, zeroIndex);
    }

    // Convert to list and remove duplicates
    var listVersion = arrayToList(cleanList, "^");
    return listRemoveDuplicates(listVersion, "^");
}
</cfscript>

<h2>Sept 2025 Survey Reprocessing Tool</h2>
<p><strong>Started:</strong> #now()#</p>
<hr>

<!--- Step 1: Fetch ALL feedback survey responses from SurveyGizmo --->
<h3>Step 1: Fetching Feedback Survey Data (Survey #FEEDBACK_SURVEY_ID#)</h3>
<cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/#FEEDBACK_SURVEY_ID#/surveyresponse">
<cfset local.params = "filter[field][0]=status&filter[operator][0]==&filter[value][0]=complete&resultsperpage=500">

<cftry>
    <cfexecute name="#CURL_PATH#"
        arguments='-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca -d #local.params#'
        variable="local.feedbackResult"
        timeout="60">
    </cfexecute>

    <cfif !isDefined("local.feedbackResult") OR trim(local.feedbackResult) EQ "">
        <p style="color:red;">Error: Unable to fetch feedback survey data.</p>
        <cfabort>
    </cfif>

    <cfset feedbackData = deserializeJSON(local.feedbackResult)>

    <cfif !structKeyExists(feedbackData, "data") OR !isArray(feedbackData.data)>
        <p style="color:red;">Error: Invalid feedback survey data format.</p>
        <cfabort>
    </cfif>

    <p style="color:green;">✓ Fetched #arrayLen(feedbackData.data)# feedback survey responses</p>

    <cfcatch>
        <p style="color:red;">Error fetching feedback surveys: #cfcatch.message#</p>
        <cfabort>
    </cfcatch>
</cftry>

<!--- Step 2: Group feedback responses by email --->
<h3>Step 2: Processing Feedback Survey Responses</h3>
<cfset local.emailFeedbackMap = {}>

<cfloop array="#feedbackData.data#" index="local.response">
    <cftry>
        <!--- Extract email from question 50 --->
        <cfset local.email = "">
        <cfif structKeyExists(local.response, "[question(50)]")>
            <cfset local.email = trim(local.response["[question(50)]"])>
        </cfif>

        <!--- Skip if no valid email --->
        <cfif local.email EQ "" OR !isValid("email", local.email)>
            <cfcontinue>
        </cfif>

        <!--- Extract lesson numbers from question 8 --->
        <cfset local.lessonNumbers = "">
        <cfif structKeyExists(local.response, "[question(8)]")>
            <cfset local.lessonNumbers = local.response["[question(8)]"]>
        </cfif>

        <!--- Initialize email entry if not exists --->
        <cfif !structKeyExists(local.emailFeedbackMap, local.email)>
            <cfset local.emailFeedbackMap[local.email] = "">
        </cfif>

        <!--- Append lesson numbers to this email's survey list --->
        <cfset local.emailFeedbackMap[local.email] = listAppend(local.emailFeedbackMap[local.email], local.lessonNumbers)>

        <cfcatch>
            <cfset local.errorCount++>
        </cfcatch>
    </cftry>
</cfloop>

<p>✓ Found #structCount(local.emailFeedbackMap)# unique emails with feedback surveys</p>

<!--- Step 3: Fetch habits survey responses --->
<h3>Step 3: Fetching Habits Survey Data (Survey #HABITS_SURVEY_ID#)</h3>
<cfset SGurl = "https://restapi.surveygizmo.com/v5/survey/#HABITS_SURVEY_ID#/surveyresponse">
<cfset local.params = "resultsperpage=500">

<cftry>
    <cfexecute name="#CURL_PATH#"
        arguments='-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca&api_token_secret=8pYECEqF7GMGJx9ZVsFP5SSkxbKXZ8Xx -d #local.params#'
        variable="local.habitsResult"
        timeout="60">
    </cfexecute>

    <cfif !isDefined("local.habitsResult") OR trim(local.habitsResult) EQ "">
        <p style="color:red;">Error: Unable to fetch habits survey data.</p>
        <cfabort>
    </cfif>

    <cfset habitsData = deserializeJSON(local.habitsResult)>

    <cfif !structKeyExists(habitsData, "data") OR !isArray(habitsData.data)>
        <p style="color:red;">Error: Invalid habits survey data format.</p>
        <cfabort>
    </cfif>

    <p style="color:green;">✓ Fetched #arrayLen(habitsData.data)# habits survey responses</p>

    <cfcatch>
        <p style="color:red;">Error fetching habits surveys: #cfcatch.message#</p>
        <cfabort>
    </cfcatch>
</cftry>

<!--- Step 4: Group habits responses by email --->
<h3>Step 4: Processing Habits Survey Responses</h3>
<cfset local.emailHabitsMap = {}>

<cfloop array="#habitsData.data#" index="local.response">
    <cftry>
        <!--- Extract email from survey response --->
        <cfset local.email = "">
        <cfif structKeyExists(local.response, "survey_data")>
            <cfloop collection="#local.response.survey_data#" item="questionID">
                <cfset question = local.response.survey_data[questionID]>

                <!--- Find email field --->
                <cfif structKeyExists(question, "answer") AND findNoCase("email", question.question)>
                    <cfset local.email = question.answer>
                    <cfbreak>
                </cfif>
            </cfloop>
        </cfif>

        <!--- Skip if no valid email --->
        <cfif local.email EQ "" OR !isValid("email", local.email)>
            <cfcontinue>
        </cfif>

        <!--- Mark that this email has habits survey --->
        <cfset local.emailHabitsMap[local.email] = true>

        <cfcatch>
            <cfset local.errorCount++>
        </cfcatch>
    </cftry>
</cfloop>

<p>✓ Found #structCount(local.emailHabitsMap)# unique emails with habits surveys</p>

<!--- Step 5: Combine all unique emails --->
<h3>Step 5: Processing All Sept 2025 Students</h3>
<cfset local.allEmails = {}>

<cfloop collection="#local.emailFeedbackMap#" item="email">
    <cfset local.allEmails[email] = true>
</cfloop>

<cfloop collection="#local.emailHabitsMap#" item="email">
    <cfset local.allEmails[email] = true>
</cfloop>

<p><strong>Total unique emails to process:</strong> #structCount(local.allEmails)#</p>
<hr>

<!--- Step 6: Process each unique email --->
<h3>Step 6: Checking and Fixing Missing Tags</h3>

<cfloop collection="#local.allEmails#" item="local.email">
    <cftry>
        <!--- Find contact by email --->
        <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "Groups"]>
        <cfset myArray = [
            "ContactService.findByEmail",
            API_KEY,
            local.email,
            selectedFieldsArray
        ]>

        <cfset contactResult = callKeapAPI(myArray)>

        <cfif !contactResult.success OR !ArrayLen(contactResult.data.Params[1])>
            <p style="color:orange;">⚠ #local.email# - Not found in Keap</p>
            <cfset local.errorCount++>
            <cfcontinue>
        </cfif>

        <cfset memberID = contactResult.data.Params[1][1]['Id']>
        <cfset memberTags = contactResult.data.Params[1][1]['Groups']>
        <cfset firstName = contactResult.data.Params[1][1]['FirstName']>
        <cfset lastName = contactResult.data.Params[1][1]['LastName']>

        <!--- Skip if not Sept 2025 cohort --->
        <cfif !listFindNoCase(memberTags, TAG_SEPT2025_COHORT)>
            <cfcontinue>
        </cfif>

        <cfset local.processedCount++>
        <cfset local.needsFix = false>
        <cfset local.tagsApplied = []>

        <!--- Check feedback surveys --->
        <cfset local.hasFeedbackSurveys = structKeyExists(local.emailFeedbackMap, local.email)>
        <cfif local.hasFeedbackSurveys>
            <cfset local.surveyList = cleanFeedbackSurveyList(local.emailFeedbackMap[local.email])>
            <cfset local.surveyCount = listLen(local.surveyList, "^")>

            <!--- Check if they should have feedback complete tag --->
            <cfif local.surveyCount GTE 18 AND !listFindNoCase(memberTags, TAG_FEEDBACK_COMPLETE)>
                <cfset tagResult = addContactToGroup(memberID, TAG_FEEDBACK_COMPLETE)>
                <cfif tagResult.success>
                    <cfset arrayAppend(local.tagsApplied, "16874 (Feedback Complete)")>
                    <cfset local.needsFix = true>
                    <!--- Update memberTags for subsequent checks --->
                    <cfset memberTags = listAppend(memberTags, TAG_FEEDBACK_COMPLETE)>
                </cfif>
            </cfif>
        </cfif>

        <!--- Check habits surveys --->
        <cfset local.hasHabitsSurveys = structKeyExists(local.emailHabitsMap, local.email)>
        <cfif local.hasHabitsSurveys AND !listFindNoCase(memberTags, TAG_HABITS_COMPLETE)>
            <cfset tagResult = addContactToGroup(memberID, TAG_HABITS_COMPLETE)>
            <cfif tagResult.success>
                <cfset arrayAppend(local.tagsApplied, "16876 (Habits Complete)")>
                <cfset local.needsFix = true>
                <!--- Update memberTags for subsequent checks --->
                <cfset memberTags = listAppend(memberTags, TAG_HABITS_COMPLETE)>
            </cfif>
        </cfif>

        <!--- Check if they should have all surveys complete tag --->
        <cfif listFindNoCase(memberTags, TAG_HABITS_COMPLETE) AND listFindNoCase(memberTags, TAG_FEEDBACK_COMPLETE) AND !listFindNoCase(memberTags, TAG_ALL_SURVEYS_COMPLETE)>
            <cfset tagResult = addContactToGroup(memberID, TAG_ALL_SURVEYS_COMPLETE)>
            <cfif tagResult.success>
                <cfset arrayAppend(local.tagsApplied, "16692 (All Surveys Complete)")>
                <cfset local.needsFix = true>
            </cfif>
        </cfif>

        <!--- Report results --->
        <cfif local.needsFix>
            <cfset local.fixedCount++>
            <cfset arrayAppend(local.fixedStudents, {
                email: local.email,
                name: "#firstName# #lastName#",
                id: memberID,
                tags: arrayToList(local.tagsApplied, ", ")
            })>
            <p style="color:green;">✓ FIXED: #firstName# #lastName# (#local.email#) - Applied: #arrayToList(local.tagsApplied, ", ")#</p>
        <cfelse>
            <cfset local.alreadyCorrectCount++>
        </cfif>

        <cfcatch>
            <p style="color:red;">✗ ERROR: #local.email# - #cfcatch.message#</p>
            <cfset local.errorCount++>
        </cfcatch>
    </cftry>
</cfloop>

<!--- Step 7: Display summary --->
<hr>
<h3>Processing Complete!</h3>
<p><strong>Completed:</strong> #now()#</p>
<p><strong>Sept 2025 students processed:</strong> #local.processedCount#</p>
<p><strong>Students fixed:</strong> #local.fixedCount#</p>
<p><strong>Students already correct:</strong> #local.alreadyCorrectCount#</p>
<p><strong>Errors encountered:</strong> #local.errorCount#</p>

<cfif arrayLen(local.fixedStudents) GT 0>
    <hr>
    <h3>Students Who Had Tags Applied:</h3>
    <table border="1" cellpadding="5" style="border-collapse:collapse;">
        <tr style="background-color:##f0f0f0;">
            <th>Name</th>
            <th>Email</th>
            <th>Contact ID</th>
            <th>Tags Applied</th>
        </tr>
        <cfloop array="#local.fixedStudents#" index="student">
            <tr>
                <td>#student.name#</td>
                <td>#student.email#</td>
                <td>#student.id#</td>
                <td>#student.tags#</td>
            </tr>
        </cfloop>
    </table>
</cfif>

</cfoutput>
