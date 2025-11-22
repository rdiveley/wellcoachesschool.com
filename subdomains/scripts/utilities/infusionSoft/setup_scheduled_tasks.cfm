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
HABITS_TASK_NAME = "WeeklyHabitsSurveyProcessor";
HABITS_TASK_URL = TASK_BASE_URL & "habitsSurveyALL.cfm";

MODULE2_TASK_NAME = "WeeklyModule2AddOnProcessor";
MODULE2_TASK_URL = TASK_BASE_URL & "module2AddOnALL.cfm";

// Schedule: Every Sunday at 2:00 AM
SCHEDULE_INTERVAL = "weekly";
START_TIME = "2:00 AM";

// Results tracking
results = [];
</cfscript>

<h2>Scheduled Task Setup</h2>
<cfoutput>
<p><strong>Environment:</strong> #ENVIRONMENT#</p>
<p><strong>Base URL:</strong> #TASK_BASE_URL#</p>
</cfoutput>
<p><strong>Setting up weekly batch processors...</strong></p>
<hr>

<!--- Create Habits Survey Batch Processor Task --->
<cftry>
    <cfschedule
        action="update"
        task="#HABITS_TASK_NAME#"
        operation="HTTPRequest"
        url="#HABITS_TASK_URL#"
        startdate="#dateFormat(now(), 'mm/dd/yyyy')#"
        starttime="#START_TIME#"
        interval="weekly"
        requesttimeout="600"
        resolveurl="true">

    <cfset arrayAppend(results, {
        task: HABITS_TASK_NAME,
        status: "SUCCESS",
        url: HABITS_TASK_URL,
        schedule: "Every Sunday at 2:00 AM",
        message: "Task created successfully"
    })>

    <cfcatch>
        <cfset arrayAppend(results, {
            task: HABITS_TASK_NAME,
            status: "FAILED",
            url: HABITS_TASK_URL,
            schedule: "Every Sunday at 2:00 AM",
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
        interval="weekly"
        requesttimeout="600"
        resolveurl="true">

    <cfset arrayAppend(results, {
        task: MODULE2_TASK_NAME,
        status: "SUCCESS",
        url: MODULE2_TASK_URL,
        schedule: "Every Sunday at 2:00 AM",
        message: "Task created successfully"
    })>

    <cfcatch>
        <cfset arrayAppend(results, {
            task: MODULE2_TASK_NAME,
            status: "FAILED",
            url: MODULE2_TASK_URL,
            schedule: "Every Sunday at 2:00 AM",
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
    <li>Both tasks will run every Sunday at 2:00 AM</li>
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
            <li>WeeklyHabitsSurveyProcessor</li>
            <li>WeeklyModule2AddOnProcessor</li>
        </ul>
    </li>
</ul>
