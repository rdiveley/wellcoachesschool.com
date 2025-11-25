<cfoutput>
<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
CURL_PATH = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";
SURVEY_ID = "1013764"; // Feedback survey ID

// Date filter - process only today's submissions (for daily scheduled task)
// Format: YYYY-MM-DD
TODAY_DATE = dateFormat(now(), "yyyy-mm-dd");

// Helper function to log errors (email sent via tag at end of file)
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    // Store error info in request scope for email sending later
    if (!structKeyExists(request, "surveyErrors")) {
        request.surveyErrors = [];
    }

    arrayAppend(request.surveyErrors, {
        errorType: errorType,
        errorMessage: errorMessage,
        errorDetail: errorDetail,
        userEmail: userEmail,
        timestamp: now()
    });
}

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
    return callKeapAPI(myArray);
}

// Helper function to clean survey list - extracts numbers, removes zeros, deduplicates
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

<!--- Step 1: Fetch feedback survey responses from SurveyGizmo (today's submissions only) --->
<cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/#SURVEY_ID#/surveyresponse">
<cfset local.params = "filter[field][0]=status&filter[operator][0]==&filter[value][0]=complete&filter[field][1]=date_submitted&filter[operator][1]=>=&filter[value][1]=#urlEncodedFormat(TODAY_DATE & ' 00:00:00')#&filter[field][2]=date_submitted&filter[operator][2]=<=&filter[value][2]=#urlEncodedFormat(TODAY_DATE & ' 23:59:59')#&resultsperpage=500">

<cftry>
    <cfexecute name="#CURL_PATH#"
        arguments='-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca -d #local.params#'
        variable="local.myResult"
        timeout="60">
    </cfexecute>

    <!--- Validate we got a response --->
    <cfif !isDefined("local.myResult") OR trim(local.myResult) EQ "">
        <cfscript>
            logAndEmailError("SurveyGizmo Error", "No response from survey service", "", "System");
        </cfscript>
        <p>Error: Unable to fetch survey data.</p>
        <cfabort>
    </cfif>

    <cfset jsonData = deserializeJSON(local.myResult)>

    <!--- Validate JSON structure --->
    <cfif !structKeyExists(jsonData, "data") OR !isArray(jsonData.data)>
        <cfscript>
            logAndEmailError("SurveyGizmo Error", "Invalid survey data format", "Response: #left(local.myResult, 500)#", "System");
        </cfscript>
        <p>Error: Invalid survey data format.</p>
        <cfabort>
    </cfif>

    <cfcatch>
        <cfscript>
            logAndEmailError("SurveyGizmo Error", cfcatch.message, cfcatch.detail, "System");
        </cfscript>
        <p>Error fetching surveys: #cfcatch.message#</p>
        <cfabort>
    </cfcatch>
</cftry>

<!--- Step 2: Group survey responses by email --->
<cfset local.emailSurveyMap = {}>
<cfset local.processedCount = 0>
<cfset local.errorCount = 0>

<cfloop array="#jsonData.data#" index="local.response">
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
        <cfif !structKeyExists(local.emailSurveyMap, local.email)>
            <cfset local.emailSurveyMap[local.email] = "">
        </cfif>

        <!--- Append lesson numbers to this email's survey list --->
        <cfset local.emailSurveyMap[local.email] = listAppend(local.emailSurveyMap[local.email], local.lessonNumbers)>

        <cfcatch>
            <cfset local.errorCount++>
        </cfcatch>
    </cftry>
</cfloop>

<p><strong>Processing #structCount(local.emailSurveyMap)# unique email addresses...</strong></p>

<!--- Step 3: Process each unique email --->
<cfloop collection="#local.emailSurveyMap#" item="local.email">
    <cftry>
        <!--- Find contact by email --->
        <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "_HWCTFeedbackSurveysComplete3", "_HabitsSurveysComplete", "Groups"]>
        <cfset myArray = [
            "ContactService.findByEmail",
            API_KEY,
            local.email,
            selectedFieldsArray
        ]>

        <cfset contactResult = callKeapAPI(myArray)>

        <cfif !contactResult.success OR !ArrayLen(contactResult.data.Params[1])>
            <cfset local.errorCount++>
            <cfcontinue>
        </cfif>

        <cfset memberID = contactResult.data.Params[1][1]['Id']>
        <cfset memberTags = contactResult.data.Params[1][1]['Groups']>
        <cfset currentFeedbackSurveys = structKeyExists(contactResult.data.Params[1][1], '_HWCTFeedbackSurveysComplete3') ? contactResult.data.Params[1][1]['_HWCTFeedbackSurveysComplete3'] : "">
        <cfset currentHabitsSurveys = structKeyExists(contactResult.data.Params[1][1], '_HabitsSurveysComplete') ? contactResult.data.Params[1][1]['_HabitsSurveysComplete'] : "">

        <!--- Skip if already marked complete --->
        <cfif currentFeedbackSurveys EQ "Y">
            <cfset local.processedCount++>
            <cfcontinue>
        </cfif>

        <!--- Clean and deduplicate the survey list --->
        <cfset local.surveyList = cleanFeedbackSurveyList(local.emailSurveyMap[local.email])>
        <cfset local.surveyCount = listLen(local.surveyList, "^")>

        <!--- Check if 18+ surveys complete --->
        <cfif local.surveyCount GTE 18>
            <!--- Mark as complete --->
            <cfset updateResult = updateContactField(memberID, "_HWCTFeedbackSurveysComplete3", "Y")>

            <!--- Add to feedback completion group 16874 --->
            <cfset groupResult = addContactToGroup(memberID, 16874)>

            <!--- If habits surveys are also complete, add to group 16692 --->
            <cfif currentHabitsSurveys EQ 'Y' OR listFindNoCase(memberTags, 16876)>
                <cfset groupResult = addContactToGroup(memberID, 16692)>
            </cfif>

            <!--- Check for Module 3 invitation eligibility --->
            <cfset local.hasInviteToMod3 = listFindNoCase(memberTags, 9781)
                                            AND listFindNoCase(memberTags, 9531)
                                            AND listFindNoCase(memberTags, 9553)>

            <cfif local.hasInviteToMod3>
                <cfset groupResult = addContactToGroup(memberID, 9557)>
            </cfif>

            <cfoutput><p style="color: green;">✓ Completed: #local.email# (#local.surveyCount# surveys)</p></cfoutput>

        <cfelse>
            <!--- Update with the survey list (not yet complete) --->
            <cfset updateResult = updateContactField(memberID, "_HWCTFeedbackSurveysComplete3", local.surveyList)>

            <cfif !updateResult.success>
                <cfscript>
                    logAndEmailError("Update Error", "Could not update feedback survey field", updateResult.error, local.email);
                </cfscript>
                <cfset local.errorCount++>
            <cfelse>
                <cfoutput><p>Updated: #local.email# (#local.surveyCount# surveys)</p></cfoutput>
            </cfif>
        </cfif>

        <!--- Call allSurveysCompleted module --->
        <cftry>
            <cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#">
            <cfcatch>
                <cfscript>
                    logAndEmailError("Module Error", "allSurveysCompleted.cfm failed", cfcatch.message, local.email);
                </cfscript>
            </cfcatch>
        </cftry>

        <cfset local.processedCount++>

        <cfcatch>
            <cfscript>
                logAndEmailError("Processing Error", "Error processing contact", cfcatch.message, local.email);
            </cfscript>
            <cfset local.errorCount++>
        </cfcatch>
    </cftry>
</cfloop>

<!--- Step 4: Display summary --->
<hr>
<p><strong>Processing Complete!</strong></p>
<p>Total survey responses fetched: #arrayLen(jsonData.data)#</p>
<p>Unique emails processed: #local.processedCount#</p>
<p>Errors encountered: #local.errorCount#</p>

</cfoutput>

<!--- Send error emails if any errors were logged --->
<cfif structKeyExists(request, "surveyErrors") AND arrayLen(request.surveyErrors) GT 0>
    <cfloop array="#request.surveyErrors#" index="errorInfo">
        <cfmail to="#ERROR_EMAIL#" from="noreply@wellcoaches.com" subject="Survey Error: surveyCompleteALL.cfm" type="html">
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> surveyCompleteALL.cfm</p>
            <p><strong>Error Type:</strong> #errorInfo.errorType#</p>
            <p><strong>User Email:</strong> #errorInfo.userEmail#</p>
            <p><strong>Error Message:</strong> #errorInfo.errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorInfo.errorDetail#</p>
            <p><strong>Timestamp:</strong> #errorInfo.timestamp#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        </cfmail>
    </cfloop>
</cfif>
