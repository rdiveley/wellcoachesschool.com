<cfscript>
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
TEST_EMAIL = "marilynannjohnson@marilynannjohnson.net";

// Tag IDs to check
TAG_MOD3_INVITATION = 9557;      // Mod 3 Invitation (prerequisite for 9769)
TAG_HABITS_COMPLETE = 9559;      // Mod 1 Habits Surveys Complete (prerequisite for 9769)
TAG_ALL_SURVEYS_CERT = 9769;     // Core Jul2018 Mod 1 ALL Surveys Complete (Certificate of Attendance)

function callKeapAPI(myArray) {
    try {
        invokeMethod = createObject("component", "utilities/XML-RPC");
        myPackage = invokeMethod.CFML2XMLRPC(myArray);

        cfhttp(method="post", url="https://api.infusionsoft.com/crm/xmlrpc/v1/", result="myResult", timeout="30") {
            cfhttpparam(type="HEADER", name="X-Keap-API-Key", value=API_KEY);
            cfhttpparam(type="XML", value=myPackage.Trim());
        }

        if (myResult.statusCode != "200 OK") {
            throw(message="HTTP Error: #myResult.statusCode#", type="APIError");
        }

        theData = invokeMethod.XMLRPC2CFML(myResult.Filecontent);
        return { success: true, data: theData };
    } catch (any e) {
        return { success: false, error: e.message };
    }
}

writeOutput("<h2>Checking Tags for All Surveys Complete</h2>");
writeOutput("<p><strong>Email:</strong> #TEST_EMAIL#</p>");
writeOutput("<p><strong>Required Tags:</strong></p>");
writeOutput("<ul>");
writeOutput("<li>Tag #TAG_MOD3_INVITATION# - Mod 3 Invitation</li>");
writeOutput("<li>Tag #TAG_HABITS_COMPLETE# - Mod 1 Habits Surveys Complete</li>");
writeOutput("</ul>");
writeOutput("<p><strong>Expected Result:</strong> Tag #TAG_ALL_SURVEYS_CERT# (All Surveys Complete Certificate)</p>");
writeOutput("<hr>");

// Find contact with Groups field
myArray = [
    "ContactService.findByEmail",
    API_KEY,
    TEST_EMAIL,
    ["Id", "FirstName", "LastName", "Groups"]
];

contactResult = callKeapAPI(myArray);

if (!contactResult.success || !arrayLen(contactResult.data.Params[1])) {
    writeOutput("<p style='color:red;'>Contact not found!</p>");
    abort;
}

contact = contactResult.data.Params[1][1];
memberID = contact['Id'];
memberTags = contact['Groups'];

writeOutput("<p><strong>Contact ID:</strong> #memberID#</p>");
writeOutput("<p><strong>Name:</strong> #contact['FirstName']# #contact['LastName']#</p>");
writeOutput("<hr>");

// Check for required tags
hasModInvitation = listFindNoCase(memberTags, TAG_MOD3_INVITATION);
hasHabitsComplete = listFindNoCase(memberTags, TAG_HABITS_COMPLETE);
hasAllSurveysCert = listFindNoCase(memberTags, TAG_ALL_SURVEYS_CERT);

writeOutput("<h3>Tag Status:</h3>");
writeOutput("<ul>");
if (hasModInvitation) {
    writeOutput("<li style='color:green;'>✓ Has Tag #TAG_MOD3_INVITATION# (Mod 3 Invitation)</li>");
} else {
    writeOutput("<li style='color:red;'>✗ Missing Tag #TAG_MOD3_INVITATION# (Mod 3 Invitation)</li>");
}

if (hasHabitsComplete) {
    writeOutput("<li style='color:green;'>✓ Has Tag #TAG_HABITS_COMPLETE# (Habits Complete)</li>");
} else {
    writeOutput("<li style='color:red;'>✗ Missing Tag #TAG_HABITS_COMPLETE# (Habits Complete)</li>");
}

if (hasAllSurveysCert) {
    writeOutput("<li style='color:green;'>✓ Has Tag #TAG_ALL_SURVEYS_CERT# (All Surveys Certificate) ← GOAL</li>");
} else {
    writeOutput("<li style='color:orange;'>✗ Missing Tag #TAG_ALL_SURVEYS_CERT# (All Surveys Certificate) ← GOAL</li>");
}
writeOutput("</ul>");

writeOutput("<hr>");
writeOutput("<h3>Diagnosis:</h3>");
if (hasModInvitation && hasHabitsComplete && hasAllSurveysCert) {
    writeOutput("<p style='color:green; font-weight:bold;'>✓ Everything is correct! All required tags are present.</p>");
} else if (hasModInvitation && hasHabitsComplete && !hasAllSurveysCert) {
    writeOutput("<p style='color:red; font-weight:bold;'>✗ ISSUE FOUND: Both prerequisite tags exist, but the completion tag was NOT applied.</p>");
    writeOutput("<p>This means allSurveysCompleted.cfm either did not run or encountered an error.</p>");
} else if (!hasModInvitation && hasHabitsComplete) {
    writeOutput("<p style='color:orange; font-weight:bold;'>⚠ Missing Mod 3 Invitation tag (#TAG_MOD3_INVITATION#)</p>");
    writeOutput("<p>The completion tag cannot be applied without this prerequisite tag.</p>");
} else if (hasModInvitation && !hasHabitsComplete) {
    writeOutput("<p style='color:orange; font-weight:bold;'>⚠ Missing Habits Complete tag (#TAG_HABITS_COMPLETE#)</p>");
    writeOutput("<p>The completion tag cannot be applied without this prerequisite tag.</p>");
} else {
    writeOutput("<p style='color:red; font-weight:bold;'>✗ Missing both prerequisite tags</p>");
    writeOutput("<p>Neither Mod 3 Invitation nor Habits Complete tags are present.</p>");
}

writeOutput("<hr>");
writeOutput("<h4>All Tags for this Contact:</h4>");
writeOutput("<p>Total tags: #listLen(memberTags)#</p>");

if (listLen(memberTags) > 0) {
    writeOutput("<ul>");
    tagArray = listToArray(memberTags);
    for (tagId in tagArray) {
        if (tagId == TAG_MOD3_INVITATION) {
            writeOutput("<li style='color:green; font-weight:bold;'>#tagId# ← MOD 3 INVITATION (Required)</li>");
        } else if (tagId == TAG_HABITS_COMPLETE) {
            writeOutput("<li style='color:green; font-weight:bold;'>#tagId# ← HABITS COMPLETE (Required)</li>");
        } else if (tagId == TAG_ALL_SURVEYS_CERT) {
            writeOutput("<li style='color:green; font-weight:bold;'>#tagId# ← ALL SURVEYS CERTIFICATE (Goal)</li>");
        } else {
            writeOutput("<li>#tagId#</li>");
        }
    }
    writeOutput("</ul>");
} else {
    writeOutput("<p>No tags found.</p>");
}
</cfscript>
