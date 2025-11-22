<cfscript>
API_KEY = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e";
TEST_EMAIL = "rdiveley@wellcoaches.com";

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

writeOutput("<h2>Testing Module 2 Add-on Stand-Alone Field</h2>");
writeOutput("<p><strong>Email:</strong> #TEST_EMAIL#</p><hr>");

// Find contact
myArray = [
    "ContactService.findByEmail",
    API_KEY,
    TEST_EMAIL,
    ["Id", "FirstName", "LastName"]
];

contactResult = callKeapAPI(myArray);

if (!contactResult.success || !arrayLen(contactResult.data.Params[1])) {
    writeOutput("<p style='color:red;'>Contact not found!</p>");
    abort;
}

memberID = contactResult.data.Params[1][1]['Id'];
writeOutput("<p><strong>Contact ID:</strong> #memberID#</p>");

// Query Module 2 Add-on Stand-Alone field
myArray = [
    "DataService.query",
    API_KEY,
    "Contact",
    "(int)10",
    "(int)0",
    {"Id": memberID},
    ["_Mod2AddonStandAlone", "Id"]
];

queryResult = callKeapAPI(myArray);

if (!queryResult.success) {
    writeOutput("<p style='color:red;'>Query failed: #queryResult.error#</p>");
    abort;
}

if (arrayLen(queryResult.data.Params[1]) > 0) {
    record = queryResult.data.Params[1][1];
    fieldValue = structKeyExists(record, '_Mod2AddonStandAlone') ? record['_Mod2AddonStandAlone'] : "";

    writeOutput("<h3>Module 2 Add-on Stand-Alone Field Value:</h3>");
    if (fieldValue == "Y") {
        writeOutput("<p style='color:green; font-size:18px; font-weight:bold;'>Y (COMPLETE - All 3 surveys done!)</p>");
    } else if (fieldValue == "") {
        writeOutput("<p style='color:orange;'>(empty - no surveys completed yet)</p>");
    } else {
        writeOutput("<p style='color:blue; font-weight:bold;'>#fieldValue#</p>");
        surveyCount = listLen(fieldValue, "^");
        writeOutput("<p><strong>Surveys Completed:</strong> #surveyCount# of 3</p>");
        writeOutput("<p><strong>Survey List:</strong></p><ul>");
        for (i = 1; i <= surveyCount; i++) {
            writeOutput("<li>#listGetAt(fieldValue, i, '^')#</li>");
        }
        writeOutput("</ul>");
    }
}
</cfscript>
