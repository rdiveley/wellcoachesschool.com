<cfinclude template="credentials.cfm">

<!--- Handle form email input --->
<cfif structKeyExists(form, "email")>
    <cfset URL.email = FORM.email>
</cfif>

<!--- Default error message --->
<cfset local.message = "An Error has occurred, Wellcoaches IT has been informed and will get back to you shortly." />

<!--- Define tag mappings for groups (simplified example, full list omitted for brevity) --->
<cfset local.tagMappings = {
    "86550": "9831,1382,1384,9821",
    "92767": "9777,1382,1384",
    "122134": "10163,1382,1384",
    "122751": "10480,10610,10910,1382,1384",
    "124692": "1382,1384,7892",
    "132795": "10371,1382,1384",
    "132796": "10732,1382,1384",
    "133227": "22712,17886,9617,1382,1384,18672,9617",
    "134579": "1382,1384,10145",
    "135804": "1382,1384,11448,12319",
    "133732": "11420,1382,1384",
    "138684": "1382,1384,11458",
    "143303": "11108,1382,1384",
    "149768": "11012,1382,1384",
    "149769": "11669,1382,1384",
    "151620": "11204,1382,1384",
    "158563": "11909,1382,1384",
    "165525": "12383,1382,1384",
    "166587": "12229,1382,1384",
    "172370": "12649,1382,1384",
    "177643": "12877,1382,1384",
    "179908": "12771,1382,1384",
    "179925": "13001,1382,1384",
    "166047": "12535,1382,1384",
    "196765": "13237,1382,1384",
    "200614": "13091,1382,1384",
    "200727": "13343,1382,1384",
    "133730": "19658,19056,18990,17760,16438,15445,13673,1382,1384",
    "133731": "21412,19526,18990,11372,12583,16436,16438,15443,15445,12858,13671,13673,1382,1384,17762",
    "204039": "13489,1382,1384",
    "204048": "13577,1382,1384",
    "215036": "13975,1382,1384",
    "215044": "13887,1382,1384",
    "270378": "14557,1382,1384",
    "310295": "14383,1382,1384",
    "311207": "14711,1382,1384",
    "326955": "14845,1382,1384",
    "331102": "14935,1382,1384",
    "331706": "15023,1382,1384",
    "335393": "15217,1382,1384",
    "335420": "15311,1382,1384",
    "357954": "15506,1382,1384",
    "345594": "15644,15660,1382,1384,15646",
    "383008": "15762,1382,1384",
    "394270": "15942,1382,1384",
    "397128": "16138,1382,1384",
    "399396": "16044,1382,1384",
    "415521": "16516,1382,1384",
    "415904": "16600,1382,1384",
    "417007": "16886,1382,1384",
    "418067": "16962,1382,1384",
    "418135": "16748,1382,1384",
    "443398": "17232,1382,1384",
    "443399": "17256,1382,1384",
    "444680": "17192,1382,1384",
    "457195": "17344,1382,1384",
    "467705": "17420,1382,1384",
    "467704": "17436,1382,1384",
    "467702": "17612,1382,1384",
    "457198": "17328,1382,1384",
    "475536": "17706,1382,1384",
    "476136": "17468,1382,1384",
    "476138": "17516,1382,1384",
    "497171": "17532,1382,1384",
    "497231": "17484,1382,1384",
    "517484": "17500,1382,1384",
    "517483": "17548,1382,1384",
    "531867": "17922,1382,1384",
    "537709": "17938,18056,1382,1384",
    "539861": "18004,1382,1384",
    "539864": "18020,1382,1384",
    "546704": "18194,1382,1384",
    "545173": "18074,18154,1382,1384",
    "555223": "18242,1382,1384",
    "555224": "18216,1382,1384",
    "569228": "18338,1382,1384",
    "569236": "18364,1382,1384",
    "570659": "18420,1382,1384",
    "570664": "18446,18472,1382,1384",
    "550736": "18128,18602,1382,1384",
    "583849": "18510,18562,18536,1382,1384",
    "588117": "18714,18688,1382,1384",
    "595986": "18773,18748,1382,1384",
    "607295": "18840,18814,1382,1384",
    "611521": "19102,18910,1382,1384",
    "625819": "19006,1382,1384",
    "638088": "19180,19154,1382,1384",
    "645020": "19288,19262,1382,1384",
    "647797": "19376,19350,1382,1384",
    "650725": "19450,19476,1382,1384",
    "651296": "19076,1382,1384",
    "654892": "19614,19530,19556,1382,1384",
    "674596": "19960,19672,1382,1384",
    "704813": "19832,1382,1384",
    "715258": "20620,20340,19884,19858,1382,1384",
    "720428": "20570,20118,1382,1384",
    "720840": "20084,19934,19910,1382,1384",
    "728278": "20950,20272,20182,1382,1384",
    "729855": "20320,20288,20198,1382,1384",
    "731913": "20510,20304,1382,1384",
    "747386": "20990,1382,1384",
    "744246": "20662,1382,1384",
    "748578": "20642,1382,1384",
    "748581": "20902,1382,1384",
    "752456": "21360,20788,20716,1382,1384",
    "756033": "21528,20812,20740,1382,1384",
    "756035": "20836,20764,1382,1384",
    "760391": "20992,1382,1384",
    "764037": "21256,1382,1384",
    "764200": "20578,1382,1384",
    "770351": "21098,21026,1382,1384",
    "775645": "21918,21122,21050,1382,1384",
    "776255": "21146,21074,1382,1384",
    "785081": "21458,21460,1382,1384",
    "793682": "21426,1382,1384",
    "793691": "21436,1382,1384",
    "793693": "21446,1382,1384",
    "793694": "21456,1382,1384",
    "804985": "21728,21626,1382,1384",
    "804987": "21762,21660,1382,1384",
    "804988": "21796,21694,1382,1384",
    "816040": "21962,1382,1384",
    "846327": "22112,22010,1382,1384",
    "846335": "22146,22044,1382,1384",
    "846340": "22180,22078,1382,1384",
    "855397": "22304,1382,1384",
    "856229": "21540,1382,1384",
    "856231": "21546,1382,1384",
    "871061": "22352,1382,1384",
    "893208": "22380,1382,1384",
    "893209": "22414,1382,1384",
    "893210": "22448,1382,1384",
    "893888": "22482,1382,1384",
    "894855": "1826,3054,1382,1384",
    "900067": "22516,1382,1384",
    "900069": "22550,1382,1384",
    "901768": "22756,1382,1384",
    "905522": "22788,1382,1384",
    "906887": "22916,1382,1384",
    "906878": "22852,1382,1384",
    "907872": "22948,1382,1384",
    "907870": "22884,1382,1384",
    "919766": "23096,23098,1382,1384",
    "929339": "23172,1382,1384",
    "929340": "23236,1382,1384",
    "929341": "23204,1382,1384",
    "929342": "23268,1382,1384"
} />

<cftry>
    <!--- Initialize group-tag structure --->
    <cfset local.LU = {} />
    <cfloop collection="#local.tagMappings#" item="groupId">
        <cfset local.LU[groupId] = {} />
        <cfloop list="#local.tagMappings[groupId]#" index="tag">
            <cfset local.LU[groupId][tag] = "" />
        </cfloop>
    </cfloop>

    <!--- Keap API call to fetch user data --->
    <cfset key = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093" />
    <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "Password", "Groups"] />
    <cfset myArray = ["ContactService.findByEmail", key, URL.email, selectedFieldsArray] />

    <cfinvoke component="utilities/XML-RPC" method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage" />

    <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments='-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
        variable="myResult1"
        timeout="200" />

    <cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML" data="#myResult1#" returnvariable="theData2" />

    <!--- Check if user exists in Keap --->
    <cfif !isArray(theData2['Params'][1]) || !arrayLen(theData2['Params'][1])>
        <cfoutput>User #URL.email# does not exist in our records.</cfoutput><br />
        <cfabort />
    </cfif>

    <!--- Extract user info and tags --->
    <cfset local.userInfo = theData2.Params[1][1] />
    <cfset local.tagList = local.userInfo['Groups'] />
    <cfif !structKeyExists(local.userInfo, 'LastName')>
        <cfset local.userInfo = theData2.Params[1][2] />
        <cfset local.tagList = local.userInfo['Groups'] />
    </cfif>

    <!--- Determine groups to assign based on tags --->
    <cfset local.assignGroups = "" />
    <cfloop list="#local.tagList#" index="tag">
        <cfloop collection="#local.LU#" item="groupId">
            <cfif structKeyExists(local.LU[groupId], tag)>
                <cfset local.assignGroups = listAppend(local.assignGroups, groupId) />
            </cfif>
        </cfloop>
    </cfloop>
    <cfset local.assignGroups = listRemoveDuplicates(local.assignGroups) />

    <!--- Check if user exists in Learn Upon --->
    <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments="-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URL.email#"
        variable="myResult"
        timeout="200" />

    <cfset local.user = deserializeJSON(myResult) />
    <cfset local.id = structKeyExists(local.user, 'response_code') ? "" : local.user.user[1].id />

    <!--- Create user if not found --->
    <cfif !len(local.id)>
        <cfset local.userData = {
            "User": {
                "last_name": local.userInfo['LastName'],
                "first_name": local.userInfo['FirstName'],
                "email": URL.email,
                "password": local.userInfo['Password'],
                "language": "en"
            }
        } />

        <cfset local.userJson = serializeJSON(local.userData).replace('"', '\"', 'all').replace(' ', '-', 'all') />

        <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
            arguments='-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/users -H "Content-Type: application/json" -d #local.userJson#'
            variable="myResult"
            timeout="200" />

        <cfset local.messageStruct = deserializeJSON(myResult) />
        <cfif structKeyExists(local.messageStruct, 'message') && local.messageStruct.message contains 'user already exists'>
            <cfif listLen(local.assignGroups)>
                <cfloop list="#local.assignGroups#" index="groupId">
                    <cfset local.addUser = {"GroupInvite": {"email_addresses": URL.email, "group_id": groupId, "group_membership_type_id": 1}} />
                    <cfset local.userJson = serializeJSON(local.addUser).replace('"', '\"', 'all') />
                    <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments='-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_invites -H "Content-Type: application/json" -d #local.userJson#'
                        variable="myResult"
                        timeout="200" />
                </cfloop>
            </cfif>
            <cfoutput><h3>User invite was sent successfully!</h3></cfoutput>
            <cfabort />
        </cfif>
        <cfset local.id = deserializeJSON(myResult).id />
    </cfif>

    <!--- Fetch current group memberships --->
    <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments="-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships?user_id=#local.id#"
        variable="myGroups"
        timeout="200" />

    <cfset local.groups = deserializeJSON(myGroups) />
    <cfset local.groupIds = arrayToList(arrayMap(local.groups['group'], function(group) { return group['id']; })) />

    <!--- Assign user to new groups --->
    <cfif listLen(local.assignGroups)>
        <cfloop list="#local.assignGroups#" index="groupId">
            <cfif !listFind(local.groupIds, groupId)>
                <cfset local.groupMembership = {"GroupMembership": {"group_id": groupId, "user_id": local.id}} />
                <cfset local.groupJson = serializeJSON(local.groupMembership).replace('"', '\"', 'all') />
                <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                    arguments='-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_memberships -H "Content-Type: application/json" -d #local.groupJson#'
                    variable="myResult"
                    timeout="200" />
            </cfif>
        </cfloop>
    </cfif>

    <!--- Remove user from groups they shouldn't be in --->
    <cfset local.deleteUserFromGroup = "" />
    <cfloop list="#local.groupIds#" index="groupId">
        <cfif !listFind(local.assignGroups, groupId)>
            <cfset local.deleteUserFromGroup = listAppend(local.deleteUserFromGroup, groupId) />
        </cfif>
    </cfloop>

    <cfloop list="#local.deleteUserFromGroup#" index="deleteGroupId">
        <cfset local.deleteGroup = {"GroupMembership": {"group_id": deleteGroupId, "user_id": local.id}} />
        <cfset local.deleteJson = serializeJSON(local.deleteGroup).replace('"', '\"', 'all') />
        <cfexecute name="C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
            arguments='-X DELETE -H "Content-Type: application/json" --user #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships/0 -d #local.deleteJson#'
            timeout="200" />
    </cfloop>

    <cfset local.message = "User was added successfully to LearnUpon!" />
    <cfif structKeyExists(url, 'redirectFromCH')>
        <cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#URL.email#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" />
    </cfif>

    <cfcatch type="any">
        <cfmail to="rdiveley@wellcoaches.com" subject="LearnUpon Create Groups" from="wellcoaches@wellcoaches.com" type="html">
            <table>
                <tr><td><cfdump var="#cfcatch#" format="html"></td></tr>
                <tr><td><cfdump var="#url#" format="html"></td></tr>
            </table>
        </cfmail>
    </cfcatch>
</cftry>

<cfoutput><h3>#local.message#</h3></cfoutput>