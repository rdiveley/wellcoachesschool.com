<cfinclude template="credentials.cfm">

<!--- Handle form email input --->
<cfparam name="URL.email" default="">
<cfif structKeyExists(form, "email")>
    <cfset URL.email = FORM.email>
</cfif>

<!--- Configuration --->
<cfset local.config = {
    "defaultMessage": "An Error has occurred, Wellcoaches IT has been informed and will get back to you shortly.",
    "keapApiKey": "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093",
    "curlPath": "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe",
    "learnUponBaseUrl": "https://wellcoaches.learnupon.com/api/v1"
}>

<!--- Tag mappings (kept simplified as in original) --->
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
}>

<cftry>
    <!--- Function to initialize group-tag lookup --->
    <cffunction name="initGroupLookup" returntype="struct">
        <cfargument name="tagMappings" type="struct" required="true">
        <cfset var LU = {}>
        <cfloop collection="#arguments.tagMappings#" item="groupId">
            <cfset LU[groupId] = {}>
            <cfloop list="#arguments.tagMappings[groupId]#" index="tag">
                <cfset LU[groupId][tag] = "">
            </cfloop>
        </cfloop>
        <cfreturn LU>
    </cffunction>

    <!--- Function to get Keap user data --->
    <cffunction name="getKeapUserData" returntype="struct">
        <cfargument name="email" type="string" required="true">
		<cfargument name="local" type="struct" required="true">

        <cfset var selectedFields = ["Id", "FirstName", "LastName", "Password", "Groups"]>
        <cfset var myArray = ["ContactService.findByEmail", arguments.local.config.keapApiKey, arguments.email, selectedFields]>
        <cfinvoke component="utilities/XML-RPC" method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage">
        <cfexecute name="#arguments.local.config.curlPath#"
            arguments='-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #arguments.local.config.keapApiKey#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
            variable="result"
            timeout="200">
        <cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML" data="#result#" returnvariable="data">
        <cfreturn data>
    </cffunction>

    <!--- Initialize data structures --->
    <cfset local.LU = initGroupLookup(local.tagMappings)>
    <cfset local.message = local.config.defaultMessage>

    <!--- Validate email --->
    <cfif not len(trim(URL.email))>
        <cfoutput>Please provide a valid email address.</cfoutput>
        <cfabort>
    </cfif>

    <!--- Fetch and validate Keap user --->
    <cfset local.keapData = getKeapUserData(URL.email,local)>

    <cfif !isArray(local.keapData['Params'][1]) || !arrayLen(local.keapData['Params'][1])>
        <cfoutput>User #htmlEditFormat(URL.email)# does not exist in our records.</cfoutput>
        <cfabort>
    </cfif>

    <!--- Extract user info --->
    <cfset local.userInfo = local.keapData.Params[1][1]>
    <cfset local.tagList = local.userInfo['Groups']>
    <cfif !structKeyExists(local.userInfo, 'LastName') && arrayLen(local.keapData.Params[1]) gt 1>
        <cfset local.userInfo = local.keapData.Params[1][2]>
        <cfset local.tagList = local.userInfo['Groups']>
    </cfif>

    <!--- Calculate groups to assign --->
    <cfset local.assignGroups = "">
    <cfloop list="#local.tagList#" index="tag">
        <cfloop collection="#local.LU#" item="groupId">
            <cfif structKeyExists(local.LU[groupId], tag)>
                <cfset local.assignGroups = listAppend(local.assignGroups, groupId)>
            </cfif>
        </cfloop>
    </cfloop>
    <cfset local.assignGroups = listRemoveDuplicates(local.assignGroups)>

    <!--- Check LearnUpon user existence --->
    <cfexecute name="#local.config.curlPath#"
        arguments="-u #local.username#:#local.password# #local.config.learnUponBaseUrl#/users/search?email=#urlEncodedFormat(URL.email)#"
        variable="userResult"
        timeout="200">
    <cfset local.user = deserializeJSON(userResult)>
    <cfset local.userId = structKeyExists(local.user, 'response_code') ? "" : local.user.user[1].id>

    <!--- Create user if not exists --->
    <cfif not len(local.userId)>

        <cfset local.userData = {
            "User": {
                "last_name": local.userInfo['LastName'],
                "first_name": local.userInfo['FirstName'],
                "email": URL.email,
                "password": local.userInfo['Password'],
                "language": "en"
            }
        }>
        <cfset local.userJson = serializeJSON(local.userData)>
		<cfset local.userJson = serializeJSON(local.userData).replace('"', '\"', 'all').replace(' ', '-', 'all') />
        
        <cfexecute name="#local.config.curlPath#"
            arguments='-u #local.username#:#local.password# -X POST #local.config.learnUponBaseUrl#/users -H "Content-Type: application/json" -d #local.userJson#'
            variable="createResult"
            timeout="200">
           

        <cfset local.createResponse = deserializeJSON(createResult)>
        <cfif structKeyExists(local.createResponse, 'message') && local.createResponse.message contains 'user already exists'>
            <cfset local.message = "User invite was sent successfully!">
        <cfelse>
            <cfset local.userId = local.createResponse.id>
            <cfset local.message = "User created successfully!">
        </cfif>
    </cfif>

    <!--- Manage group memberships --->
    <cfif len(local.userId) && len(local.assignGroups)>
        <!--- Get current groups --->
        <cfexecute name="#local.config.curlPath#"
            arguments="-u #local.username#:#local.password# #local.config.learnUponBaseUrl#/group_memberships?user_id=#local.userId#"
            variable="groupResult"
            timeout="200">
        <cfset local.groups = deserializeJSON(groupResult)>
        <cfset local.currentGroupIds = arrayToList(arrayMap(local.groups['group'], function(group) { return group['id']; }))>

        <!--- Add to new groups --->
        <cfloop list="#local.assignGroups#" index="groupId">
            <cfif not listFind(local.currentGroupIds, groupId)>
                <cfset local.groupMembership = {"GroupMembership": {"group_id": groupId, "user_id": local.userId}}>
                <cfset local.groupJson = serializeJSON(local.groupMembership)>
                <cfexecute name="#local.config.curlPath#"
                    arguments='-u #local.username#:#local.password# -X POST #local.config.learnUponBaseUrl#/group_memberships -H "Content-Type: application/json" -d #local.groupJson#'
                    variable="addResult"
                    timeout="200">
            </cfif>
        </cfloop>

        <!--- Remove from old groups --->
        <cfloop list="#local.currentGroupIds#" index="groupId">
            <cfif not listFind(local.assignGroups, groupId)>
                <cfset local.deleteMembership = {"GroupMembership": {"group_id": groupId, "user_id": local.userId}}>
                <cfset local.deleteJson = serializeJSON(local.deleteMembership)>
                <cfexecute name="#local.config.curlPath#"
                    arguments='-X DELETE -H "Content-Type: application/json" --user #local.username#:#local.password# #local.config.learnUponBaseUrl#/group_memberships/0 -d #local.deleteJson#'
                    timeout="200">
            </cfif>
        </cfloop>
        
        <cfset local.message = "User group memberships updated successfully!">
    </cfif>

    <!--- Handle redirect --->
    <cfif structKeyExists(url, 'redirectFromCH')>
        <cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#urlEncodedFormat(URL.email)#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" addtoken="false">
    </cfif>

    <cfcatch type="any">
        <!---<cfmail to="rdiveley@wellcoaches.com" 
                subject="LearnUpon Create Groups Error" 
                from="wellcoaches@wellcoaches.com" 
                type="html">
            <h2>Error Details</h2>
            <cfdump var="#cfcatch#" format="html">
            <h2>URL Parameters</h2>
            <cfdump var="#url#" format="html">
        </cfmail> --->
        <cfrethrow>
    </cfcatch>
</cftry>

<cfoutput><h3>#local.message#</h3></cfoutput>