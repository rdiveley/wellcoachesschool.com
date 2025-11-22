<cfscript>
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
TEST_EMAIL = "rdiveley@wellcoaches.com";
COMPLETION_TAG_ID = 23744; // "Mod 2 Additional Courses 2025 Surveys Complete"

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

writeOutput("<h2>Checking Tags for Module 2 Add-on Completion</h2>");
writeOutput("<p><strong>Email:</strong> #TEST_EMAIL#</p>");
writeOutput("<p><strong>Looking for Tag ID:</strong> #COMPLETION_TAG_ID# (Mod 2 Additional Courses 2025 Surveys Complete)</p>");
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

// Check if completion tag is present
if (listFindNoCase(memberTags, COMPLETION_TAG_ID)) {
    writeOutput("<h3 style='color:green;'>✓ SUCCESS: Completion Tag Applied!</h3>");
    writeOutput("<p style='color:green; font-size:16px;'>Tag #COMPLETION_TAG_ID# is present in contact's tags.</p>");
} else {
    writeOutput("<h3 style='color:red;'>✗ Tag NOT Found</h3>");
    writeOutput("<p style='color:red;'>Tag #COMPLETION_TAG_ID# is NOT in the contact's tags.</p>");
}

writeOutput("<hr>");
writeOutput("<h4>All Tags for this Contact:</h4>");
writeOutput("<p>Total tags: #listLen(memberTags)#</p>");

if (listLen(memberTags) > 0) {
    writeOutput("<ul>");
    tagArray = listToArray(memberTags);
    for (tagId in tagArray) {
        if (tagId == COMPLETION_TAG_ID) {
            writeOutput("<li style='color:green; font-weight:bold;'>#tagId# ← COMPLETION TAG</li>");
        } else {
            writeOutput("<li>#tagId#</li>");
        }
    }
    writeOutput("</ul>");
} else {
    writeOutput("<p>No tags found.</p>");
}
</cfscript>
