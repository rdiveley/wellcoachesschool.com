<!---
    Scheduled Task Setup Script
    Creates weekly scheduled tasks for batch survey processors

    Run this script ONCE to create the scheduled tasks in ColdFusion Administrator
    Access: http://scripts.wellcoachesschool.com/utilities/infusionsoft/setup_scheduled_tasks.cfm
--->

<cfscript>
// Auto-detect environment based on server name
IS_LOCAL = (cgi.server_name CONTAINS ".loc" OR cgi.server_name EQ "localhost");

// Configuration - Use HTTP for local, HTTPS for production
if (IS_LOCAL) {
    TASK_BASE_URL = "http://scripts.wellcoachesschool.loc/utilities/infusionsoft/";
    ENVIRONMENT = "LOCAL";
} else {
    TASK_BASE_URL = "https://scripts.wellcoachesschool.com/utilities/infusionsoft/";
    ENVIRONMENT = "PRODUCTION";
}

// Scheduled task settings
FEEDBACK_TASK_NAME = "DailyFeedbackSurveyProcessor";
FEEDBACK_TASK_URL = TASK_BASE_URL & "surveyCompleteALL.cfm";

MODULE2_TASK_NAME = "DailyModule2AddOnProcessor";
MODULE2_TASK_URL = TASK_BASE_URL & "module2AddOnALL.cfm";

// Schedule: Daily at midnight
SCHEDULE_INTERVAL = "daily";
START_TIME = "12:00 AM";

// Results tracking
results = [];
</cfscript>

<h2>Scheduled Task Setup</h2>
<cfoutput>
<p><strong>Environment:</strong> #ENVIRONMENT#</p>
<p><strong>Base URL:</strong> #TASK_BASE_URL#</p>
</cfoutput>
<p><strong>Setting up daily batch processors...</strong></p>
<hr>

<!--- Create Feedback Survey Batch Processor Task (18 surveys) --->
<cftry>
    <cfschedule
        action="update"
        task="#FEEDBACK_TASK_NAME#"
        operation="HTTPRequest"
        url="#FEEDBACK_TASK_URL#"
        startdate="#dateFormat(now(), 'mm/dd/yyyy')#"
        starttime="#START_TIME#"
        interval="daily"
        requesttimeout="600"
        resolveurl="true">

    <cfset arrayAppend(results, {
        task: FEEDBACK_TASK_NAME,
        status: "SUCCESS",
        url: FEEDBACK_TASK_URL,
        schedule: "Daily at 12:00 AM (midnight)",
        message: "Task created successfully"
    })>

    <cfcatch>
        <cfset arrayAppend(results, {
            task: FEEDBACK_TASK_NAME,
            status: "FAILED",
            url: FEEDBACK_TASK_URL,
            schedule: "Daily at 12:00 AM (midnight)",
            message: cfcatch.message & " - " & cfcatch.detail
        })>
    </cfcatch>
</cftry>

<!--- Create Module 2 Add-on Batch Processor Task --->
<cftry>
    <cfschedule
        action="update"
        task="#MODULE2_TASK_NAME#"
        operation="HTTPRequest"
        url="#MODULE2_TASK_URL#"
        startdate="#dateFormat(now(), 'mm/dd/yyyy')#"
        starttime="#START_TIME#"
        interval="daily"
        requesttimeout="600"
        resolveurl="true">

    <cfset arrayAppend(results, {
        task: MODULE2_TASK_NAME,
        status: "SUCCESS",
        url: MODULE2_TASK_URL,
        schedule: "Daily at 12:00 AM (midnight)",
        message: "Task created successfully"
    })>

    <cfcatch>
        <cfset arrayAppend(results, {
            task: MODULE2_TASK_NAME,
            status: "FAILED",
            url: MODULE2_TASK_URL,
            schedule: "Daily at 12:00 AM (midnight)",
            message: cfcatch.message & " - " & cfcatch.detail
        })>
    </cfcatch>
</cftry>

<!--- Display Results --->
<h3>Setup Results:</h3>
<cfloop array="#results#" index="result">
    <cfoutput>
        <div style="padding: 10px; margin: 10px 0; border: 1px solid ##ccc; background-color: <cfif result.status EQ 'SUCCESS'>##d4edda<cfelse>##f8d7da</cfif>">
            <h4 style="margin: 0 0 5px 0; color: <cfif result.status EQ 'SUCCESS'>##155724<cfelse>##721c24</cfif>">#result.status#: #result.task#</h4>
            <p><strong>URL:</strong> #result.url#</p>
            <p><strong>Schedule:</strong> #result.schedule#</p>
            <p><strong>Message:</strong> #result.message#</p>
        </div>
    </cfoutput>
</cfloop>

<hr>
<h3>Next Steps:</h3>
<ul>
    <li>Tasks have been registered in ColdFusion's scheduled task system</li>
    <li>Both tasks will run daily at midnight (12:00 AM)</li>
    <li>Each task processes only that day's survey submissions</li>
    <li>To view/manage tasks, go to ColdFusion Administrator > Debugging & Logging > Scheduled Tasks</li>
    <li>To run a task immediately for testing, use the "Run" button in the CF Administrator</li>
</ul>

<h3>Manual Verification:</h3>
<p>You can verify the tasks were created by checking:</p>
<ul>
    <li><strong>ColdFusion Administrator URL:</strong> http://localhost:8500/CFIDE/administrator/</li>
    <li><strong>Location:</strong> Debugging & Logging > Scheduled Tasks</li>
    <li><strong>Look for tasks named:</strong>
        <ul>
            <li>DailyFeedbackSurveyProcessor (18 feedback surveys)</li>
            <li>DailyModule2AddOnProcessor (3 Module 2 Add-on surveys)</li>
        </ul>
    </li>
</ul>
