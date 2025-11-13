<cfoutput>
<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
CURL_PATH = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

// Helper function to log and email errors
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    try {
        var emailBody = "
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> habitsSurveyALL.cfm</p>
            <p><strong>Error Type:</strong> #errorType#</p>
            <p><strong>User Email:</strong> #userEmail#</p>
            <p><strong>Error Message:</strong> #errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorDetail#</p>
            <p><strong>Timestamp:</strong> #now()#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        ";

        cfmail(to=ERROR_EMAIL, from="noreply@wellcoaches.com", subject="Survey Error: habitsSurveyALL.cfm", type="html") {
            writeOutput(emailBody);
        }
    } catch (any e) {
        // Silent fail - don't break the page if email fails
    }
}

// Parse email parameter from URL
local.email = "";
if (structKeyExists(url, 'email')) {
    local.email = trim(url.email);
} else if (structKeyExists(url, 'emailForm')) {
    local.email = trim(url.emailForm);
}

// Validate email parameter
if (local.email == "") {
    logAndEmailError("Missing Email", "No email parameter provided", "", "N/A");
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
}

// Basic email validation
if (!isValid("email", local.email)) {
    logAndEmailError("Invalid Email Format", "Invalid email format", "Email provided: #local.email#", local.email);
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
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
</cfscript>

<!--- Step 1: Find contact by email --->
<cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "_HWCTFeedbackSurveysComplete3", "_HabitsSurveysComplete", "Groups"]>
<cfset myArray = [
    "ContactService.findByEmail",
    API_KEY,
    local.email,
    selectedFieldsArray
]>

<cfset contactResult = callKeapAPI(myArray)>

<cfif !contactResult.success>
    <cfscript>
        logAndEmailError("API Error", "Failed to retrieve contact", contactResult.error, local.email);
    </cfscript>
    <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    <cfabort>
</cfif>

<cfif !ArrayLen(contactResult.data.Params[1])>
    <cfscript>
        logAndEmailError("Contact Not Found", "No user with email address in records", "", local.email);
    </cfscript>
    <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    <cfabort>
</cfif>

<cfset memberID = contactResult.data.Params[1][1]['Id']>
<cfset memberTags = contactResult.data.Params[1][1]['Groups']>
<cfset currentHabitsSurveys = structKeyExists(contactResult.data.Params[1][1], '_HabitsSurveysComplete') ? contactResult.data.Params[1][1]['_HabitsSurveysComplete'] : "">

<!--- Step 2: Fetch survey responses from SurveyGizmo --->
<cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/4051290/surveyresponse">
<cfset emailParam = "[question(93)]">
<cfset local.params = "filter[field][0]=#urlEncodedFormat(emailParam)#&filter[operator][0]=in&filter[value][0]=#trim(urlEncodedFormat(local.email))#&filter[field][1]=status&filter[operator][1]==&filter[value][1]=complete&resultsperpage=500">

<cftry>
    <cfexecute name="#CURL_PATH#"
        arguments='-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca -d #local.params#'
        variable="local.myResult"
        timeout="30">
    </cfexecute>

    <!--- Validate we got a response --->
    <cfif !isDefined("local.myResult") OR trim(local.myResult) EQ "">
        <cfscript>
            logAndEmailError("SurveyGizmo Error", "No response from survey service", "", local.email);
        </cfscript>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
        <cfabort>
    </cfif>

    <cfset jsonData = deserializeJSON(local.myResult)>

    <!--- Validate JSON structure --->
    <cfif !structKeyExists(jsonData, "data") OR !isArray(jsonData.data)>
        <cfscript>
            logAndEmailError("SurveyGizmo Error", "Invalid survey data format", "Response: #left(local.myResult, 500)#", local.email);
        </cfscript>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
        <cfabort>
    </cfif>

    <cfcatch>
        <cfscript>
            logAndEmailError("SurveyGizmo Error", cfcatch.message, cfcatch.detail, local.email);
        </cfscript>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
        <cfabort>
    </cfcatch>
</cftry>

<!--- Step 3: Process survey data --->
<cfset local.surveyList = "">
<cfloop array="#jsonData.data#" index="local.field">
    <cfset local.updateList = arrayToList(rematch("[\d]+", local.field['[question(89)]']))>
    <cfset local.surveyList = listAppend(local.surveyList, local.updateList)>
</cfloop>

<cfset local.surveyList = listChangeDelims(listRemoveDuplicates(local.surveyList), "^")>
<cfset local.surveyCount = listLen(local.surveyList, "^")>

<!--- Skip survey processing if specified --->
<cfif structKeyExists(local, 'skipSurveyAll')>
    <cfset local.surveyList = "Y">
    <cfset local.surveyCount = 999>
</cfif>

<!--- Step 4: Update habits survey field if less than 8 surveys and not already marked --->
<cfif local.surveyList NEQ 'Y' AND local.surveyCount LT 8 AND local.surveyList NEQ 'STANDALONE'>
    <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", local.surveyList)>
    <cfif !updateResult.success>
        <cfscript>
            logAndEmailError("Update Error", "Could not update survey count field", updateResult.error, local.email);
        </cfscript>
    </cfif>
</cfif>

<!--- Step 5: Add to feedback group if both surveys completed --->
<cfif structKeyExists(contactResult.data.Params[1][1], '_HWCTFeedbackSurveysComplete3') AND contactResult.data.Params[1][1]['_HWCTFeedbackSurveysComplete3'] EQ 'Y'>
    <cfset groupResult = addContactToGroup(memberID, 16874)>
</cfif>

<!--- Step 6: Process completion scenarios (8+ surveys) --->
<cfif local.surveyCount GTE 8>
    <!--- Mark surveys as complete --->
    <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", "Y")>

    <!--- Add to completion group --->
    <cfset groupResult = addContactToGroup(memberID, 16876)>

    <!--- Scenario #2: If tag 18680 exists, add tag 18682 --->
    <cfif listFindNoCase(memberTags, 18680)>
        <cfset groupResult = addContactToGroup(memberID, 18682)>
    </cfif>

    <!--- Scenario #3: Standalone course completion --->
    <cfif listFindNoCase(memberTags, 18680) OR listFindNoCase(memberTags, 18684)>
        <cfset groupResult = addContactToGroup(memberID, 18682)>
        <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", "STANDALONE")>
    </cfif>
</cfif>

<!--- Step 7: Check for both completion tags and add final group --->
<!--- Re-fetch to get updated tags --->
<cfset myArray = [
    "ContactService.findByEmail",
    API_KEY,
    local.email,
    ["Id", "Groups"]
]>

<cfset finalContactResult = callKeapAPI(myArray)>

<cfif finalContactResult.success AND ArrayLen(finalContactResult.data.Params[1])>
    <cfset updatedMemberTags = finalContactResult.data.Params[1][1]['Groups']>

    <!--- If both tags exist, add final completion tag --->
    <cfif listFindNoCase(updatedMemberTags, 16874) AND listFindNoCase(updatedMemberTags, 16876)>
        <cfset groupResult = addContactToGroup(memberID, 16692)>
    </cfif>
</cfif>

<!--- Step 8: Display success message --->
<cfif !structKeyExists(local, 'skipSurveyAll')>
    <p>
        Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
        If not, please contact your Coach Concierge for assistance. Thank you!
    </p>
</cfif>

</cfoutput>
