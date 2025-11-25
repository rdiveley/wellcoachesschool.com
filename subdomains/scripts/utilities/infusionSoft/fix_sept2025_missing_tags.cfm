<cfoutput>
<cfscript>
// Configuration
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;

// Tag IDs
TAG_SEPT2025_COHORT = 23506;      // Sept 2025 cohort
TAG_HABITS_COMPLETE = 16876;      // Habits Complete
TAG_FEEDBACK_COMPLETE = 16874;    // Feedback Complete
TAG_ALL_SURVEYS_COMPLETE = 16692; // All Surveys Complete (goal)

// Tracking
local.processedCount = 0;
local.fixedCount = 0;
local.alreadyCorrectCount = 0;
local.errorCount = 0;
local.fixedStudents = [];

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
</cfscript>

<h2>Sept 2025 All Surveys Complete Tag Fix</h2>
<p><strong>Started:</strong> #now()#</p>
<p><strong>Logic:</strong> Find contacts with tags 23506 + 16876 + 16874 who are missing tag 16692</p>
<hr>

<!--- Step 1: Query for contacts with Sept 2025 cohort tag --->
<h3>Step 1: Querying Keap for Sept 2025 Students</h3>
<cfset selectedFieldStruct = {}>
<cfset myArray = [
    "DataService.query",
    API_KEY,
    "Contact",
    "(int)1000",
    "(int)0",
    {},
    ["Id", "FirstName", "LastName", "Email", "Groups"]
]>

<cfset queryResult = callKeapAPI(myArray)>

<cfif !queryResult.success>
    <p style="color:red;">Error querying Keap: #queryResult.error#</p>
    <cfabort>
</cfif>

<cfset allContacts = queryResult.data.Params[1]>
<p style="color:green;">✓ Retrieved #arrayLen(allContacts)# contacts from Keap</p>

<!--- Step 2: Filter for Sept 2025 students with both habits and feedback complete --->
<h3>Step 2: Checking Tags and Applying Fixes</h3>

<cfloop array="#allContacts#" index="contact">
    <cftry>
        <cfif !structKeyExists(contact, "Groups") OR !isArray(contact.Groups)>
            <cfcontinue>
        </cfif>

        <cfset memberID = contact.Id>
        <cfset memberTags = contact.Groups>
        <cfset firstName = structKeyExists(contact, "FirstName") ? contact.FirstName : "">
        <cfset lastName = structKeyExists(contact, "LastName") ? contact.LastName : "">
        <cfset email = structKeyExists(contact, "Email") ? contact.Email : "">

        <!--- Check if they have Sept 2025 cohort tag --->
        <cfif !arrayContains(memberTags, TAG_SEPT2025_COHORT)>
            <cfcontinue>
        </cfif>

        <!--- Check if they have habits complete tag --->
        <cfif !arrayContains(memberTags, TAG_HABITS_COMPLETE)>
            <cfcontinue>
        </cfif>

        <!--- Check if they have feedback complete tag --->
        <cfif !arrayContains(memberTags, TAG_FEEDBACK_COMPLETE)>
            <cfcontinue>
        </cfif>

        <!--- At this point, they have all three prerequisite tags --->
        <cfset local.processedCount++>

        <!--- Check if they already have the completion tag --->
        <cfif arrayContains(memberTags, TAG_ALL_SURVEYS_COMPLETE)>
            <cfset local.alreadyCorrectCount++>
            <p style="color:blue;">✓ #firstName# #lastName# (#email#) - Already has all tags</p>
        <cfelse>
            <!--- Apply the missing completion tag --->
            <cfset tagResult = addContactToGroup(memberID, TAG_ALL_SURVEYS_COMPLETE)>

            <cfif tagResult.success>
                <cfset local.fixedCount++>
                <cfset arrayAppend(local.fixedStudents, {
                    email: email,
                    name: "#firstName# #lastName#",
                    id: memberID
                })>
                <p style="color:green;"><strong>✓ FIXED:</strong> #firstName# #lastName# (#email#) - Applied tag 16692</p>
            <cfelse>
                <cfset local.errorCount++>
                <p style="color:red;">✗ ERROR: #firstName# #lastName# (#email#) - Failed to apply tag: #tagResult.error#</p>
            </cfif>
        </cfif>

        <cfcatch>
            <cfset local.errorCount++>
            <p style="color:red;">✗ ERROR processing contact ID #memberID#: #cfcatch.message#</p>
        </cfcatch>
    </cftry>
</cfloop>

<!--- Step 3: Display summary --->
<hr>
<h3>Processing Complete!</h3>
<p><strong>Completed:</strong> #now()#</p>
<p><strong>Total contacts retrieved:</strong> #arrayLen(allContacts)#</p>
<p><strong>Sept 2025 students with both habits + feedback complete:</strong> #local.processedCount#</p>
<p><strong>Students who needed fixing:</strong> #local.fixedCount#</p>
<p><strong>Students already correct:</strong> #local.alreadyCorrectCount#</p>
<p><strong>Errors encountered:</strong> #local.errorCount#</p>

<cfif arrayLen(local.fixedStudents) GT 0>
    <hr>
    <h3>Students Who Had Tag 16692 Applied:</h3>
    <table border="1" cellpadding="5" style="border-collapse:collapse;">
        <tr style="background-color:##f0f0f0;">
            <th>Name</th>
            <th>Email</th>
            <th>Contact ID</th>
        </tr>
        <cfloop array="#local.fixedStudents#" index="student">
            <tr>
                <td>#student.name#</td>
                <td>#student.email#</td>
                <td>#student.id#</td>
            </tr>
        </cfloop>
    </table>

    <hr>
    <h3>Summary for Julie:</h3>
    <p>The following Sept 2025 students completed both habits and feedback surveys but were missing the "All Surveys Complete" tag (16692). The tag has now been applied:</p>
    <ul>
        <cfloop array="#local.fixedStudents#" index="student">
            <li>#student.name# (#student.email#)</li>
        </cfloop>
    </ul>
</cfif>

</cfoutput>
