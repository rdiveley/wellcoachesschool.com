<!---
    AFTER 1 through 8 Habits surveys are completed
    a Y is added to the Habits Surveys [Jul2018 Fwd] field
    AS LONG AS 9705 is in place [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete]
    THEN 9707 can be applied [Res Aug2018 [Indy] Mod 1 Habits Surveys Complete]
    AS WELL AS 9771 which delivers the Certificate of Attendance [ Res Aug2018 [Indy] Mod 1 ALL Surveys Complete
--->

<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

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

// Parse URL parameters
param name="URL.lesson" default="";
param name="URL.email" default="";

// Validate required parameters
if (URL.email == "") {
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
}

// Basic email validation
if (!isValid("email", URL.email)) {
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

// Helper function to get unique survey lessons from list
function cleanSurveyList(surveyList) {
    // Create a struct to deduplicate (structs have unique keys)
    var uniqueSurveys = {};
    var cleanList = "";
    var i = 0;
    var item = "";
    var listLength = listLen(surveyList, "^");

    for (i = 1; i <= listLength; i++) {
        item = trim(listGetAt(surveyList, i, "^"));
        // Skip empty items and items with periods
        if (item != "" && !find(".", item)) {
            // Convert to integer if numeric
            if (isNumeric(item)) {
                item = int(item);
            }
            uniqueSurveys[item] = item;
        }
    }

    // Return as caret-delimited list
    cleanList = structKeyList(uniqueSurveys);
    return replace(cleanList, ",", "^", "all");
}
</cfscript>

<!--- Step 1: Find contact by email --->
<cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "_HabitsSurveysComplete", "_HWCTFeedbackSurveysComplete3", "Groups"]>
<cfset myArray = [
    "ContactService.findByEmail",
    API_KEY,
    URL.email,
    selectedFieldsArray
]>

<cfset contactResult = callKeapAPI(myArray)>

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
    <cfoutput>
        <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    </cfoutput>
    <cfabort>
</cfif>

<cfset memberID = contactResult.data.Params[1][1]['Id']>
<cfset memberTags = contactResult.data.Params[1][1]['Groups']>
<cfset currentHabitsSurveys = structKeyExists(contactResult.data.Params[1][1], '_HabitsSurveysComplete') ? contactResult.data.Params[1][1]['_HabitsSurveysComplete'] : "">

<!--- Step 2: Process the current lesson and update survey list --->
<cfset updateList = currentHabitsSurveys>

<cfif updateList NEQ 'Y' AND listLen(updateList, "^") LT 8 AND updateList NEQ 'STANDALONE'>
    <!--- Append the new lesson --->
    <cfset updateList = listAppend(updateList, URL.Lesson, "^")>

    <!--- Clean and deduplicate the list --->
    <cfset updateList = cleanSurveyList(updateList)>

    <!--- Update the contact record --->
    <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", updateList)>

    <cfif !updateResult.success>
        <cfoutput>
            <p>Warning: Could not update survey list. Please contact your Coach Concierge.</p>
        </cfoutput>
    </cfif>
</cfif>

<!--- Step 3: Add to feedback group if feedback surveys are complete --->
<cfif structKeyExists(contactResult.data.Params[1][1], '_HWCTFeedbackSurveysComplete3') AND contactResult.data.Params[1][1]['_HWCTFeedbackSurveysComplete3'] EQ 'Y'>
    <cfset groupResult = addContactToGroup(memberID, 16874)>
</cfif>

<!--- Step 4: Process completion scenarios (8+ surveys or already marked complete) --->
<cfset surveyCount = listLen(updateList, "^")>

<cfif surveyCount GTE 8 OR updateList EQ "Y">
    <!--- Mark surveys as complete if not already --->
    <cfif updateList NEQ "Y">
        <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", "Y")>
    </cfif>

    <!--- Add to completion group 16876 --->
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

<!--- Step 5: Re-fetch contact to get updated tags --->
<cfset myArray = [
    "ContactService.findByEmail",
    API_KEY,
    URL.email,
    ["Id", "Groups"]
]>

<cfset finalContactResult = callKeapAPI(myArray)>

<cfif finalContactResult.success AND arrayLen(finalContactResult.data.Params[1])>
    <cfset updatedMemberTags = finalContactResult.data.Params[1][1]['Groups']>

    <!--- Scenario #1: If both tags 16874 and 16876 exist, add tag 16692 --->
    <cfif listFindNoCase(updatedMemberTags, 16874) AND listFindNoCase(updatedMemberTags, 16876)>
        <cfset groupResult = addContactToGroup(memberID, 16692)>
    </cfif>

    <!--- Special case: Tag 24027 + specific survey (8344775) = Y in habits survey field AND tag 18682 --->
    <cfif listFindNoCase(updatedMemberTags, 24027) AND structKeyExists(URL, "survey_id") AND URL.survey_id EQ 8344775>
        <cfset groupResult = addContactToGroup(memberID, 18682)>
        <cfset updateResult = updateContactField(memberID, "_HabitsSurveysComplete", "Y")>
    </cfif>
</cfif>

<!--- Step 6: Display success message --->
<p>
    Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
    If not, please contact your Coach Concierge for assistance. Thank you!
</p>

<!--- Send error emails if any errors were logged --->
<cfif structKeyExists(request, "surveyErrors") AND arrayLen(request.surveyErrors) GT 0>
    <cfloop array="#request.surveyErrors#" index="errorInfo">
        <cfmail to="#ERROR_EMAIL#" from="noreply@wellcoaches.com" subject="Survey Error: habitsSurvey.cfm" type="html">
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> habitsSurvey.cfm</p>
            <p><strong>Error Type:</strong> #errorInfo.errorType#</p>
            <p><strong>User Email:</strong> #errorInfo.userEmail#</p>
            <p><strong>Error Message:</strong> #errorInfo.errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorInfo.errorDetail#</p>
            <p><strong>Timestamp:</strong> #errorInfo.timestamp#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        </cfmail>
    </cfloop>
</cfif>
