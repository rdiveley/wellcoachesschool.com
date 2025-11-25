<cfoutput>
<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
DSN = "wellcoachesSchool";
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
param name="URL.cohort" default="";
param name="URL.faculty_member" default="";
param name="URL.coachingSkills" default="";
param name="URL.faculty" default="";
param name="URL.VALUABLE" default="";
param name="URL.lessonObj" default="";
param name="URL.summarize" default="";
param name="URL.aware" default="";
param name="URL.live" default="";

// Debug mode
if (structKeyExists(url, 'debug') and url.debug EQ 1) {
    writeDump(var=URL);
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
    writeOutput("<p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>");
    abort;
}

// Basic email validation
if (!isValid("email", local.email)) {
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
    <p>Thank you for your submission. If you don't see your survey update within 15 minutes, please contact your Coach Concierge.</p>
    <cfabort>
</cfif>

<cfset memberID = contactResult.data.Params[1][1]['Id']>
<cfset memberTags = contactResult.data.Params[1][1]['Groups']>
<cfset currentFeedbackSurveys = structKeyExists(contactResult.data.Params[1][1], '_HWCTFeedbackSurveysComplete3') ? contactResult.data.Params[1][1]['_HWCTFeedbackSurveysComplete3'] : "">
<cfset currentHabitsSurveys = structKeyExists(contactResult.data.Params[1][1], '_HabitsSurveysComplete') ? contactResult.data.Params[1][1]['_HabitsSurveysComplete'] : "">

<!--- Step 2: Process the current lesson and update survey list --->
<cfset updateList = currentFeedbackSurveys>

<!--- Append the new lesson --->
<cfset updateList = listAppend(updateList, URL.Lesson, "^")>

<!--- Clean and deduplicate the list --->
<cfset updateList = cleanFeedbackSurveyList(updateList)>

<!--- Step 3: Check if already marked complete --->
<cfif !FindNoCase('Y', updateList)>
    <cfset surveyCount = listLen(updateList, "^")>

    <!--- Step 4: Process completion scenarios (18+ surveys) --->
    <cfif surveyCount GTE 18>
        <cfset updateList = 'Y'>

        <!--- Add to feedback completion group 16874 --->
        <cfset groupResult = addContactToGroup(memberID, 16874)>

        <!--- If habits surveys are also complete, add to group 16692 --->
        <cfif currentHabitsSurveys EQ 'Y' OR listFindNoCase(memberTags, 16876)>
            <cfset groupResult = addContactToGroup(memberID, 16692)>
        </cfif>
    </cfif>

    <!--- Step 5: Update the contact record --->
    <cfif updateList NEQ "Y">
        <!--- Update with the survey list --->
        <cfset cleanedList = replace(updateList.trim(), ",", "^", "all")>
        <cfset updateResult = updateContactField(memberID, "_HWCTFeedbackSurveysComplete3", cleanedList)>
    <cfelse>
        <!--- Mark as complete --->
        <cfset updateResult = updateContactField(memberID, "_HWCTFeedbackSurveysComplete3", "Y")>

        <!--- Step 6: Check for Module 3 invitation eligibility --->
        <!--- IF 9781 [Core 18-Week Teleclass [Jul2018 Fwd]], 9531, and 9553 are in place --->
        <!--- THEN 9557 can be applied [Core Jul2018 Mod 1 Lesson Surveys Complete] --->
        <cfset local.hasInviteToMod3 = listFindNoCase(memberTags, 9781)
                                        AND listFindNoCase(memberTags, 9531)
                                        AND listFindNoCase(memberTags, 9553)>

        <cfif local.hasInviteToMod3>
            <cfset groupResult = addContactToGroup(memberID, 9557)>
        </cfif>
    </cfif>

    <cfif !updateResult.success>
        <cfscript>
            logAndEmailError("Update Error", "Could not update feedback survey field", updateResult.error, local.email);
        </cfscript>
    </cfif>
</cfif>

<!--- Step 7: Check if all surveys are completed --->
<cftry>
    <cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#">
    <cfcatch>
        <cfscript>
            logAndEmailError("Module Error", "allSurveysCompleted.cfm failed", cfcatch.message, local.email);
        </cfscript>
    </cfcatch>
</cftry>

</cfoutput>

<!--- Send error emails if any errors were logged --->
<cfif structKeyExists(request, "surveyErrors") AND arrayLen(request.surveyErrors) GT 0>
    <cfloop array="#request.surveyErrors#" index="errorInfo">
        <cfmail to="#ERROR_EMAIL#" from="noreply@wellcoaches.com" subject="Survey Error: surveyComplete.cfm" type="html">
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> surveyComplete.cfm</p>
            <p><strong>Error Type:</strong> #errorInfo.errorType#</p>
            <p><strong>User Email:</strong> #errorInfo.userEmail#</p>
            <p><strong>Error Message:</strong> #errorInfo.errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorInfo.errorDetail#</p>
            <p><strong>Timestamp:</strong> #errorInfo.timestamp#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        </cfmail>
    </cfloop>
</cfif>
