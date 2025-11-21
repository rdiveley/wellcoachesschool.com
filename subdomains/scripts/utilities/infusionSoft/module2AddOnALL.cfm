<cfscript>
// Configuration
API_KEY = "fb7d1fc8a4aab143f6246c090a135a41";
API_URL = "https://my982.infusionsoft.com/api/xmlrpc";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

// Tag IDs
REQUIRED_TAG_ID = 23728; // "LU Access to Mod 2 Additional Classes ONLY [Sep25 fwd]"
COMPLETION_TAG_ID = 23744; // "Mod 2 Additional Courses 2025 Surveys Complete"
REQUIRED_SURVEY_COUNT = 3; // Number of surveys required for completion

// SurveyGizmo Configuration
SURVEYGIZMO_API_TOKEN = "your_surveygizmo_token"; // Update with actual token
SURVEYGIZMO_API_SECRET = "your_surveygizmo_secret"; // Update with actual secret
SURVEY_ID = "8397154"; // Module 2 courses NEW Courses only 2025

// Helper function to log and email errors
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    try {
        var emailBody = "
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> module2AddOnALL.cfm</p>
            <p><strong>Error Type:</strong> #errorType#</p>
            <p><strong>User Email:</strong> #userEmail#</p>
            <p><strong>Error Message:</strong> #errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorDetail#</p>
            <p><strong>Timestamp:</strong> #now()#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        ";

        cfmail(to=ERROR_EMAIL, from="noreply@wellcoaches.com", subject="Survey Error: module2AddOnALL.cfm", type="html") {
            writeOutput(emailBody);
        }
    } catch (any e) {
        // Silent fail - don't break the page if email fails
    }
}

// Helper function to call Infusionsoft API with retry logic
function callInfusionsoftAPI(myArray, retryCount = 0) {
    try {
        var myPackage = "";
        var myResult = "";

        // Convert to XML-RPC format
        invokeMethod = createObject("component", "utilities/XML-RPC");
        myPackage = invokeMethod.CFML2XMLRPC(myArray);

        // Make HTTP request
        cfhttp(method="post", url=API_URL, result="myResult", timeout="30") {
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
            return callInfusionsoftAPI(myArray, retryCount + 1);
        } else {
            return { success: false, error: e.message, detail: e.detail };
        }
    }
}

// Helper function to update contact field
function updateContactField(memberID, fieldName, fieldValue) {
    var updateField = {};
    updateField[fieldName] = fieldValue;

    var myArray = [
        "ContactService.update",
        API_KEY,
        "(int)#memberID#",
        updateField
    ];
    return callInfusionsoftAPI(myArray);
}

// Helper function to clean and deduplicate survey list
function cleanSurveyList(surveyList) {
    var cleanList = listRemoveDuplicates(trim(surveyList), "^");
    return replace(cleanList, ",", "^", "all");
}

// Helper function to apply tag to contact
function applyTag(memberID, tagID) {
    var myArray = [
        "ContactService.addToGroup",
        API_KEY,
        "(int)#memberID#",
        "(int)#tagID#"
    ];
    return callInfusionsoftAPI(myArray);
}

// Helper function to check if contact has a specific tag
function hasTag(memberID, tagID) {
    var myArray = [
        "ContactService.load",
        API_KEY,
        "(int)#memberID#",
        ["Id", "Groups"]
    ];

    var result = callInfusionsoftAPI(myArray);

    if (!result.success) {
        return false;
    }

    // Check if Groups key exists and contains the tag
    if (structKeyExists(result.data.Params[1], "Groups") && isArray(result.data.Params[1].Groups)) {
        return arrayContains(result.data.Params[1].Groups, tagID);
    }

    return false;
}
</cfscript>

<!--- Fetch all survey responses from SurveyGizmo for survey ID 8397154 --->
<cfset surveyGizmoURL = "https://restapi.surveygizmo.com/v5/survey/#SURVEY_ID#/surveyresponse?api_token=#SURVEYGIZMO_API_TOKEN#&api_token_secret=#SURVEYGIZMO_API_SECRET#&resultsperpage=500">

<cftry>
    <cfhttp url="#surveyGizmoURL#" method="GET" result="surveyData" timeout="30">
    </cfhttp>

    <cfif surveyData.statusCode NEQ "200 OK">
        <cfscript>
            logAndEmailError("SurveyGizmo Error", "Failed to fetch surveys", "Status: #surveyData.statusCode#", "System");
        </cfscript>
        <cfoutput>
            <p>Unable to fetch survey data at this time. Please try again later.</p>
        </cfoutput>
        <cfabort>
    </cfif>

    <!--- Parse JSON response --->
    <cfset surveyResponses = deserializeJSON(surveyData.fileContent)>

    <!--- Process each survey response --->
    <cfif structKeyExists(surveyResponses, "data") AND isArray(surveyResponses.data)>
        <cfloop array="#surveyResponses.data#" index="response">
            <cftry>
                <!--- Extract email and lesson name from survey response --->
                <cfset respondentEmail = "">
                <cfset lessonName = "">

                <!--- Parse survey data to extract email and lesson --->
                <cfif structKeyExists(response, "survey_data")>
                    <cfloop collection="#response.survey_data#" item="questionID">
                        <cfset question = response.survey_data[questionID]>

                        <!--- Find email field (adjust question ID as needed) --->
                        <cfif structKeyExists(question, "answer") AND findNoCase("email", question.question)>
                            <cfset respondentEmail = question.answer>
                        </cfif>

                        <!--- Find lesson/course name field (adjust question ID as needed) --->
                        <cfif structKeyExists(question, "answer") AND (findNoCase("lesson", question.question) OR findNoCase("course", question.question))>
                            <cfset lessonName = question.answer>
                        </cfif>
                    </cfloop>
                </cfif>

                <!--- Skip if no email found --->
                <cfif respondentEmail EQ "" OR !isValid("email", respondentEmail)>
                    <cfcontinue>
                </cfif>

                <!--- Step 1: Find contact by email --->
                <cfset myArray = [
                    "ContactService.findByEmail",
                    API_KEY,
                    respondentEmail,
                    ["Id", "FirstName", "LastName"]
                ]>

                <cfset contactResult = callInfusionsoftAPI(myArray)>

                <cfif !contactResult.success OR !arrayLen(contactResult.data.Params[1])>
                    <cfscript>
                        logAndEmailError("Contact Not Found", "No user with email in records", "", respondentEmail);
                    </cfscript>
                    <cfcontinue>
                </cfif>

                <cfset memberID = contactResult.data.Params[1][1]['Id']>

                <!--- Step 2: Verify contact has required tag --->
                <cfif !hasTag(memberID, REQUIRED_TAG_ID)>
                    <!--- Skip this contact - they don't have the required tag --->
                    <cfcontinue>
                </cfif>

                <!--- Step 3: Query for current survey status --->
                <cfset selectedFieldStruct = {"Id": memberID}>
                <cfset myArray = [
                    "DataService.query",
                    API_KEY,
                    "Contact",
                    "(int)10",
                    "(int)0",
                    selectedFieldStruct,
                    ["_Mod2AddonStandAlone", "Id"]
                ]>

                <cfset queryResult = callInfusionsoftAPI(myArray)>

                <cfif !queryResult.success>
                    <cfcontinue>
                </cfif>

                <!--- Step 4: Get current survey completion status --->
                <cfset currentSurveys = structKeyExists(queryResult.data.Params[1][1], '_Mod2AddonStandAlone') ? queryResult.data.Params[1][1]['_Mod2AddonStandAlone'] : "">

                <!--- Skip if already marked complete --->
                <cfif currentSurveys EQ "Y">
                    <cfcontinue>
                </cfif>

                <!--- Step 5: Process the lesson and update survey list --->
                <cfset updateList = currentSurveys>

                <!--- Append the new lesson --->
                <cfset updateList = trim(listAppend(updateList, lessonName, "^"))>

                <!--- Clean and deduplicate the list --->
                <cfset updateList = cleanSurveyList(updateList)>

                <!--- Step 6: Check if all 3 surveys are complete --->
                <cfset surveyCount = listLen(updateList, "^")>

                <cfif surveyCount GTE REQUIRED_SURVEY_COUNT>
                    <!--- Mark as complete --->
                    <cfset updateList = "Y">

                    <!--- Apply completion tag --->
                    <cfset tagResult = applyTag(memberID, COMPLETION_TAG_ID)>
                </cfif>

                <!--- Step 7: Update the contact record --->
                <cfset updateResult = updateContactField(memberID, "_Mod2AddonStandAlone", updateList)>

                <cfcatch>
                    <cfscript>
                        logAndEmailError("Processing Error", "Error processing survey for contact", cfcatch.message, respondentEmail);
                    </cfscript>
                </cfcatch>
            </cftry>
        </cfloop>

        <cfoutput>
            <p>Survey processing complete. Processed #arrayLen(surveyResponses.data)# responses.</p>
        </cfoutput>
    <cfelse>
        <cfoutput>
            <p>No survey responses found.</p>
        </cfoutput>
    </cfif>

    <cfcatch>
        <cfscript>
            logAndEmailError("System Error", "Error processing surveys", cfcatch.message, "System");
        </cfscript>
        <cfoutput>
            <p>An error occurred while processing surveys. The administrator has been notified.</p>
        </cfoutput>
    </cfcatch>
</cftry>
