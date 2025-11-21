<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

// Tag IDs
REQUIRED_TAG_ID = 23728; // "LU Access to Mod 2 Additional Classes ONLY [Sep25 fwd]"
COMPLETION_TAG_ID = 23744; // "Mod 2 Additional Courses 2025 Surveys Complete"
REQUIRED_SURVEY_COUNT = 3; // Number of surveys required for completion

// Helper function to log and email errors
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    try {
        var emailBody = "
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> module2AddOn.cfm</p>
            <p><strong>Error Type:</strong> #errorType#</p>
            <p><strong>User Email:</strong> #userEmail#</p>
            <p><strong>Error Message:</strong> #errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorDetail#</p>
            <p><strong>Timestamp:</strong> #now()#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        ";

        cfmail(to=ERROR_EMAIL, from="noreply@wellcoaches.com", subject="Survey Error: module2AddOn.cfm", type="html") {
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

<!--- Step 2: Verify contact has required tag --->
<cfif !hasTag(memberID, REQUIRED_TAG_ID)>
    <cfscript>
        logAndEmailError("Access Denied", "Contact does not have required tag ID #REQUIRED_TAG_ID#", "This file is only for Module 2 Add-on Stand-Alone participants", URL.email);
    </cfscript>
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<!--- Step 3: Query for Module 2 Add-on Stand-Alone surveys complete field --->
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
    <cfscript>
        logAndEmailError("API Error", "Failed to query survey data", queryResult.error, URL.email);
    </cfscript>
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<!--- Step 4: Get current survey completion status --->
<cfset currentSurveys = structKeyExists(queryResult.data.Params[1][1], '_Mod2AddonStandAlone') ? queryResult.data.Params[1][1]['_Mod2AddonStandAlone'] : "">

<!--- Step 5: Process the current lesson and update survey list --->
<cfset updateList = currentSurveys>
<cfset updateField = structNew()>

<cfif updateList NEQ "Y">
    <!--- Append the new lesson --->
    <cfset updateList = trim(listAppend(updateList, URL.Lesson, "^"))>

    <!--- Clean and deduplicate the list --->
    <cfset updateList = cleanSurveyList(updateList)>

    <!--- Prepare update field --->
    <cfset updateField['_Mod2AddonStandAlone'] = updateList>
</cfif>

<!--- Step 6: Check if all 3 surveys are complete --->
<cfset surveyCount = listLen(updateList, "^")>

<cfif surveyCount GTE REQUIRED_SURVEY_COUNT OR updateList EQ "Y">
    <!--- Mark as complete --->
    <cfset updateField['_Mod2AddonStandAlone'] = "Y">

    <!--- Apply completion tag --->
    <cfset tagResult = applyTag(memberID, COMPLETION_TAG_ID)>

    <cfif !tagResult.success>
        <cfscript>
            logAndEmailError("Tag Error", "Could not apply completion tag #COMPLETION_TAG_ID#", tagResult.error, URL.email);
        </cfscript>
    </cfif>
</cfif>

<!--- Step 7: Update the contact record --->
<cfset updateResult = updateContactField(memberID, "_Mod2AddonStandAlone", updateField['_Mod2AddonStandAlone'])>

<cfif !updateResult.success>
    <cfscript>
        logAndEmailError("Update Error", "Could not update survey record", updateResult.error, URL.email);
    </cfscript>
</cfif>

<!--- Step 8: Display success message --->
<p>
    Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
    If not, please contact your Coach Concierge for assistance. Thank you!
</p>
