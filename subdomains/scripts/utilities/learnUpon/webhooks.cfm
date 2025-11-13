<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
CURL_PATH = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;
ERROR_EMAIL = "rdiveley@wellcoaches.com";

local.datasource = 'wellcoachesschool';
local.insert = FALSE;

// Helper function to log and email errors
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    try {
        var emailBody = "
            <h3>LearnUpon Webhook Error Report</h3>
            <p><strong>File:</strong> webhooks.cfm</p>
            <p><strong>Error Type:</strong> #errorType#</p>
            <p><strong>User Email:</strong> #userEmail#</p>
            <p><strong>Error Message:</strong> #errorMessage#</p>
            <p><strong>Error Detail:</strong> #errorDetail#</p>
            <p><strong>Timestamp:</strong> #now()#</p>
            <p><strong>URL:</strong> #cgi.script_name#?#cgi.query_string#</p>
        ";

        cfmail(to=ERROR_EMAIL, from="noreply@wellcoaches.com", subject="LearnUpon Webhook Error", type="html") {
            writeOutput(emailBody);
        }
    } catch (any e) {
        // Silent fail - don't break the page if email fails
    }
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

// Get payload from request
_payload = "{}";
if (structKeyExists(URL, "payload")) {
    _payload = URL.payload;
} else if (structKeyExists(FORM, "payload")) {
    _payload = FORM.payload;
} else {
    _payload = getHttpRequestData().content;
}

// Parse JSON payload
if (isJSON(_payload)) {
    local.requestpayload = deserializeJSON(_payload);
    local.insert = TRUE;
} else {
    local.requestpayload = {};
}
</cfscript>

<!--- Process webhook if valid JSON and matches criteria --->
<cfif local.insert
    AND structKeyExists(local.requestpayload, 'header')
    AND structKeyExists(local.requestpayload.header, 'webhookType')
    AND findNoCase('exam_completion', local.requestpayload.header.webhookType)
    AND structKeyExists(local.requestpayload, 'courseName')
    AND findNoCase('Module 1', local.requestpayload.courseName)>

    <cftry>
        <!--- Extract values with defaults --->
        <cfset local.email = structKeyExists(local.requestpayload, 'user') AND structKeyExists(local.requestpayload.user, 'email') ? local.requestpayload.user.email : "">
        <cfset local.courseName = structKeyExists(local.requestpayload, 'courseName') ? local.requestpayload.courseName : "">
        <cfset local.courseId = structKeyExists(local.requestpayload, 'courseId') ? local.requestpayload.courseId : 0>
        <cfset local.percentage = structKeyExists(local.requestpayload, 'percentage') ? local.requestpayload.percentage : 0>
        <cfset local.webhookId = structKeyExists(local.requestpayload.header, 'webhookId') ? local.requestpayload.header.webhookId : 0>
        <cfset local.webhookType = structKeyExists(local.requestpayload.header, 'webhookType') ? local.requestpayload.header.webhookType : "">
        <cfset local.examName = structKeyExists(local.requestpayload, 'examName') ? local.requestpayload.examName : "">
        <cfset local.passPercentage = structKeyExists(local.requestpayload, 'passPercentage') ? local.requestpayload.passPercentage : 0>
        <cfset local.attemptsTaken = structKeyExists(local.requestpayload, 'attemptsTaken') ? local.requestpayload.attemptsTaken : 0>
        <cfset local.status = structKeyExists(local.requestpayload, 'status') ? local.requestpayload.status : "">
        <cfset local.lastAttemptAt = structKeyExists(local.requestpayload.header, 'lastAttemptAt') ? local.requestpayload.header.lastAttemptAt : "">

        <!--- Check if this webhook record already exists to prevent duplicates --->
        <!--- IMPORTANT: Add index for performance: CREATE NONCLUSTERED INDEX IX_webhook_duplicate
              ON learnuponwebhook(webhookid, emailaddress, lastAttemptAt, examName) --->
        <cfquery name="local.checkDuplicate" datasource="#local.datasource#">
            SELECT TOP 1 1 AS exists_flag
            FROM [wellcoachesSchool].[dbo].[learnuponwebhook] WITH (NOLOCK)
            WHERE webhookid = <cfqueryparam value="#local.webhookId#" cfsqltype="cf_sql_integer">
            AND emailaddress = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
            AND lastAttemptAt = <cfqueryparam value="#local.lastAttemptAt#" cfsqltype="CF_SQL_TIMESTAMP">
            AND examName = <cfqueryparam value="#local.examName#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <!--- Only insert if this is a new record --->
        <cfif local.checkDuplicate.recordCount EQ 0>
            <cfquery name="local.insertLU" datasource="#local.datasource#">
                INSERT INTO [wellcoachesSchool].[dbo].[learnuponwebhook]
                (   emailaddress
                    ,coursename
                    ,courseId
                    ,exampercentage
                    ,webhookid
                    ,webhooktype
                    ,examName
                    ,passPercentage
                    ,attemptsTaken
                    ,examstatus
                    ,lastAttemptAt
                )
                VALUES
                (
                    <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
                    ,<cfqueryparam value="#local.courseName#" cfsqltype="cf_sql_varchar">
                    ,<cfqueryparam value="#local.courseId#" cfsqltype="cf_sql_integer">
                    ,<cfqueryparam value="#local.percentage#" cfsqltype="cf_sql_integer">
                    ,<cfqueryparam value="#local.webhookId#" cfsqltype="cf_sql_integer">
                    ,<cfqueryparam value="#local.webhookType#" cfsqltype="cf_sql_varchar">
                    ,<cfqueryparam value="#local.examName#" cfsqltype="cf_sql_varchar">
                    ,<cfqueryparam value="#local.passPercentage#" cfsqltype="cf_sql_integer">
                    ,<cfqueryparam value="#local.attemptsTaken#" cfsqltype="cf_sql_integer">
                    ,<cfqueryparam value="#local.status#" cfsqltype="cf_sql_varchar">
                    ,<cfqueryparam value="#local.lastAttemptAt#" cfsqltype="CF_SQL_TIMESTAMP">
                )
            </cfquery>
        </cfif>

        <!--- Get Module 1 KA data count and average - OPTIMIZED VERSION --->
        <!--- IMPORTANT: Add indexes for performance:
              CREATE NONCLUSTERED INDEX IX_webhook_email_exam ON learnuponwebhook(emailaddress, examName, lastAttemptAt) INCLUDE (exampercentage)
              CREATE NONCLUSTERED INDEX IX_webhook_examname ON learnuponwebhook(examName) WHERE examName LIKE 'Lesson Knowledge Assessment%' --->
        <cfquery name="local.get_ModOneKADataCount" datasource="#local.datasource#">
            WITH LatestAttempts AS (
                SELECT
                    examName,
                    emailaddress,
                    exampercentage,
                    ROW_NUMBER() OVER (PARTITION BY examName, emailaddress ORDER BY lastAttemptAt DESC) AS rn
                FROM [wellcoachesSchool].[dbo].[learnuponwebhook] WITH (NOLOCK)
                WHERE emailaddress = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
                AND examName LIKE 'Lesson Knowledge Assessment%'
            )
            SELECT
                COUNT(DISTINCT examName) as countRecord,
                CAST(AVG(CAST(exampercentage AS DECIMAL(10,2))) AS DECIMAL(10,2)) as average
            FROM LatestAttempts
            WHERE rn = 1
        </cfquery>

        <cfcatch type="any">
            <cfscript>
                logAndEmailError("Database Error", cfcatch.message, cfcatch.detail, local.email);
            </cfscript>
        </cfcatch>
    </cftry>

    <!--- Update Keap if 4+ assessments completed --->
    <cfif structKeyExists(local, 'get_ModOneKADataCount') AND local.get_ModOneKADataCount.recordCount GT 0 AND local.get_ModOneKADataCount.countRecord GTE 4>

        <!--- Find contact by email --->
        <cfset myArray = [
            "ContactService.findByEmail",
            API_KEY,
            local.email,
            ["Id", "FirstName", "LastName"]
        ]>

        <cfset contactResult = callKeapAPI(myArray)>

        <cfif contactResult.success AND structKeyExists(contactResult.data, 'params') AND arrayLen(contactResult.data.params[1]) GT 0>
            <cfset memberID = contactResult.data.params[1][1]['Id']>

            <!--- Update Mod1KAData field --->
            <cfset updateField = {}>
            <cfset updateField['_Mod1KAData'] = int(local.get_ModOneKADataCount.average)>

            <cfset myArray = [
                "ContactService.update",
                API_KEY,
                "(int)#memberID#",
                updateField
            ]>

            <cfset updateResult = callKeapAPI(myArray)>

            <cfif !updateResult.success>
                <cfscript>
                    logAndEmailError("Keap Update Error", "Failed to update Mod1KAData", updateResult.error, local.email);
                </cfscript>
            </cfif>
        <cfelse>
            <cfscript>
                logAndEmailError("Contact Not Found", "Could not find contact in Keap", contactResult.error, local.email);
            </cfscript>
        </cfif>
    </cfif>

    <!--- Process Habits course (courseId 4447857) --->
    <cfif local.courseId EQ 4447857>
        <!--- IMPORTANT: Add index for performance: CREATE NONCLUSTERED INDEX IX_webhook_habits
              ON learnuponwebhook(emailaddress, courseId, lastAttemptAt DESC) INCLUDE (exampercentage) --->
        <cfquery name="local.get_HabitKAScore" datasource="#local.datasource#">
            SELECT TOP 1 exampercentage
            FROM [wellcoachesSchool].[dbo].[learnuponwebhook] WITH (NOLOCK)
            WHERE emailaddress = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
            AND courseId = <cfqueryparam value="4447857" cfsqltype="cf_sql_integer">
            ORDER BY lastAttemptAt DESC
        </cfquery>

        <cfif local.get_HabitKAScore.recordCount GT 0>
            <!--- Find contact by email --->
            <cfset myArray = [
                "ContactService.findByEmail",
                API_KEY,
                local.email,
                ["Id", "FirstName", "LastName"]
            ]>

            <cfset contactResult = callKeapAPI(myArray)>

            <cfif contactResult.success AND structKeyExists(contactResult.data, 'params') AND arrayLen(contactResult.data.params[1]) GT 0>
                <cfset memberID = contactResult.data.params[1][1]['Id']>

                <!--- Update HabitsKAData field --->
                <cfset updateField = {}>
                <cfset updateField['_HabitsKAData'] = int(local.get_HabitKAScore.exampercentage)>

                <cfset myArray = [
                    "ContactService.update",
                    API_KEY,
                    "(int)#memberID#",
                    updateField
                ]>

                <cfset updateResult = callKeapAPI(myArray)>

                <cfif !updateResult.success>
                    <cfscript>
                        logAndEmailError("Keap Update Error", "Failed to update HabitsKAData", updateResult.error, local.email);
                    </cfscript>
                </cfif>
            <cfelse>
                <cfscript>
                    logAndEmailError("Contact Not Found", "Could not find contact in Keap for Habits", contactResult.error, local.email);
                </cfscript>
            </cfif>
        </cfif>
    </cfif>

</cfif>
