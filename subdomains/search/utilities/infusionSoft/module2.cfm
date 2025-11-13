<cfscript>
// Configuration
API_KEY = "fb7d1fc8a4aab143f6246c090a135a41";
API_URL = "https://my982.infusionsoft.com/api/xmlrpc";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

// Helper function to log and email errors
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    try {
        var emailBody = "
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> module2.cfm</p>
            <p><strong>Error Type:</strong> #errorType#</p>
            <p><strong>User Email:</strong> #userEmail#</p>
            <p><strong>Error Message:</strong> #errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorDetail#</p>
            <p><strong>Timestamp:</strong> #now()#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        ";

        cfmail(to=ERROR_EMAIL, from="noreply@wellcoaches.com", subject="Survey Error: module2.cfm", type="html") {
            writeOutput(emailBody);
        }
    } catch (any e) {
        // Silent fail - don't break the page if email fails
    }
}

// Parse URL parameters
param name="URL.lesson" default="";
param name="URL.email" default="";

// Validate required parameters
if (URL.email == "") {
    logAndEmailError("Missing Email", "No email parameter provided", "", "N/A");
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
}

// Basic email validation
if (!isValid("email", URL.email)) {
    logAndEmailError("Invalid Email Format", "Invalid email format", "Email provided: #URL.email#", URL.email);
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
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
</cfscript>

<!--- Step 1: Find contact by email --->
<cfset myArray = [
    "ContactService.findByEmail",
    API_KEY,
    URL.email,
    ["Id", "FirstName", "LastName"]
]>

<cfset contactResult = callInfusionsoftAPI(myArray)>

<cfif !contactResult.success>
    <cfscript>
        logAndEmailError("API Error", "Failed to retrieve contact", contactResult.error, URL.email);
    </cfscript>
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<cfif !arrayLen(contactResult.data.Params[1])>
    <cfscript>
        logAndEmailError("Contact Not Found", "No user with email address in records", "", URL.email);
    </cfscript>
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<cfset memberID = contactResult.data.Params[1][1]['Id']>

<!--- Step 2: Query for Module 2 surveys complete field --->
<cfset selectedFieldStruct = {"Id": memberID}>
<cfset myArray = [
    "DataService.query",
    API_KEY,
    "Contact",
    "(int)10",
    "(int)0",
    selectedFieldStruct,
    ["_Module2SurveysComplete", "Id"]
]>

<cfset queryResult = callInfusionsoftAPI(myArray)>

<cfif !queryResult.success>
    <cfscript>
        logAndEmailError("API Error", "Failed to query survey data", queryResult.error, URL.email);
    </cfscript>
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<!--- Step 3: Get current survey completion status --->
<cfset currentModule2Surveys = structKeyExists(queryResult.data.Params[1][1], '_Module2SurveysComplete') ? queryResult.data.Params[1][1]['_Module2SurveysComplete'] : "">

<!--- Step 4: Process the current lesson and update survey list --->
<cfset updateList = currentModule2Surveys>
<cfset updateField = structNew()>

<cfif updateList NEQ "Y">
    <!--- Append the new lesson --->
    <cfset updateList = trim(listAppend(updateList, URL.Lesson, "^"))>

    <!--- Clean and deduplicate the list --->
    <cfset updateList = cleanSurveyList(updateList)>

    <!--- Prepare update field --->
    <cfset updateField['_Module2SurveysComplete'] = updateList>
</cfif>

<!--- Step 5: Check if all 4 surveys are complete --->
<cfset surveyCount = listLen(updateList, "^")>

<cfif surveyCount GTE 4 OR updateList EQ "Y">
    <!--- Mark as complete --->
    <cfset updateField['_Module2SurveysComplete'] = "Y">

    <!--- Apply module 2 completion logic (tags, groups, etc.) --->
    <cftry>
        <cfmodule template="applyModule2Complete.cfm" memberID="#memberID#">
        <cfcatch>
            <cfscript>
                logAndEmailError("Module Error", "applyModule2Complete.cfm failed", cfcatch.message, URL.email);
            </cfscript>
        </cfcatch>
    </cftry>
</cfif>

<!--- Step 6: Update the contact record --->
<cfset updateResult = updateContactField(memberID, "_Module2SurveysComplete", updateField['_Module2SurveysComplete'])>

<cfif !updateResult.success>
    <cfscript>
        logAndEmailError("Update Error", "Could not update survey record", updateResult.error, URL.email);
    </cfscript>
</cfif>

<!--- Step 7: Display success message --->
<p>
    Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
    If not, please contact your Coach Concierge for assistance. Thank you!
</p>
