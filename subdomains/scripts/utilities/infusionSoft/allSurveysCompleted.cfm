<!---
    All Surveys Completed Module
    Checks for various survey completion scenarios and applies appropriate tags

    Called by: surveyComplete.cfm, surveyCompleteALL.cfm
    Requires: attributes.memberID
--->

<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

// Tag IDs with descriptions
TAG_MOD3_INVITATION = 9557;      // Mod 3 Invitation (prerequisite for 9769)
TAG_HABITS_COMPLETE = 9559;      // Mod 1 Habits Surveys Complete (prerequisite for 9769)
TAG_ALL_SURVEYS_CERT = 9769;     // Core Jul2018 Mod 1 ALL Surveys Complete (Certificate of Attendance)

TAG_FOURDAY_COMPLETE = 9705;     // Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete
TAG_HABITS_COMPLETE_RES = 9707;  // Res Aug2018 [Indy] Mod 1 Habits Surveys Complete
TAG_ALL_SURVEYS_CERT_RES = 9771; // Res Aug2018 [Indy] Mod 1 ALL Surveys Complete (Certificate of Attendance)

// Helper function to log errors (email sent via tag at end of file)
function logAndEmailError(errorType, errorMessage, errorDetail, memberID) {
    // Store error info in request scope for email sending later
    if (!structKeyExists(request, "surveyErrors")) {
        request.surveyErrors = [];
    }

    arrayAppend(request.surveyErrors, {
        errorType: errorType,
        errorMessage: errorMessage,
        errorDetail: errorDetail,
        memberID: memberID,
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

// Helper function to apply tag to contact
function applyTag(memberID, tagID) {
    var myArray = [
        "ContactService.addToGroup",
        API_KEY,
        "(int)#memberID#",
        "(int)#tagID#"
    ];
    return callKeapAPI(myArray);
}

// Validate required parameter
if (!structKeyExists(attributes, "memberID")) {
    logAndEmailError("Parameter Error", "memberID attribute is required", "", "Unknown");
    abort;
}

local.memberID = attributes.memberID;
</cfscript>

<cftry>
    <!--- Step 1: Load contact tags --->
    <cfset selectedFieldsArray = ["Groups"]>
    <cfset myArray = [
        "ContactService.load",
        API_KEY,
        "(int)#local.memberID#",
        selectedFieldsArray
    ]>

    <cfset contactResult = callKeapAPI(myArray)>

    <cfif !contactResult.success>
        <cfscript>
            logAndEmailError("API Error", "Failed to load contact tags", contactResult.error, local.memberID);
        </cfscript>
        <cfabort>
    </cfif>

    <!--- Step 2: Extract tag list --->
    <cfif !structKeyExists(contactResult.data.Params[1], 'Groups')>
        <!--- No tags found, nothing to process --->
        <cfabort>
    </cfif>

    <cfset local.tagList = contactResult.data.Params[1]['Groups']>

    <!--- Step 3: Scenario #1 - Core Module 1 ALL Surveys Complete --->
    <!--- If tags 9557 (Mod 3 Invitation) AND 9559 (Habits Complete) exist, apply 9769 (Certificate) --->
    <cfif listFindNoCase(local.tagList, TAG_MOD3_INVITATION) AND listFindNoCase(local.tagList, TAG_HABITS_COMPLETE)>
        <cfset tagResult = applyTag(local.memberID, TAG_ALL_SURVEYS_CERT)>

        <cfif !tagResult.success>
            <cfscript>
                logAndEmailError("Tag Application Error", "Failed to apply tag #TAG_ALL_SURVEYS_CERT#", tagResult.error, local.memberID);
            </cfscript>
        </cfif>
    </cfif>

    <!--- Step 4: Scenario #2 - Residential Module 1 ALL Surveys Complete --->
    <!--- If tags 9705 (Four-Day Complete) AND 9707 (Habits Complete) exist, apply 9771 (Certificate) --->
    <cfif listFindNoCase(local.tagList, TAG_FOURDAY_COMPLETE) AND listFindNoCase(local.tagList, TAG_HABITS_COMPLETE_RES)>
        <cfset tagResult = applyTag(local.memberID, TAG_ALL_SURVEYS_CERT_RES)>

        <cfif !tagResult.success>
            <cfscript>
                logAndEmailError("Tag Application Error", "Failed to apply tag #TAG_ALL_SURVEYS_CERT_RES#", tagResult.error, local.memberID);
            </cfscript>
        </cfif>
    </cfif>

    <cfcatch>
        <cfscript>
            logAndEmailError("System Error", "Error processing survey completion", cfcatch.message, local.memberID);
        </cfscript>
    </cfcatch>
</cftry>

<!--- Send error emails if any errors were logged --->
<cfif structKeyExists(request, "surveyErrors") AND arrayLen(request.surveyErrors) GT 0>
    <cfloop array="#request.surveyErrors#" index="errorInfo">
        <cfmail to="#ERROR_EMAIL#" from="noreply@wellcoaches.com" subject="Survey Error: allSurveysCompleted.cfm" type="html">
            <h3>Survey Error Report</h3>
            <p><strong>File:</strong> allSurveysCompleted.cfm</p>
            <p><strong>Error Type:</strong> #errorInfo.errorType#</p>
            <p><strong>Member ID:</strong> #errorInfo.memberID#</p>
            <p><strong>Error Message:</strong> #errorInfo.errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorInfo.errorDetail#</p>
            <p><strong>Timestamp:</strong> #errorInfo.timestamp#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        </cfmail>
    </cfloop>
</cfif>
