<cfinclude template="credentials.cfm">

<cfif structKeyExists(form,'email')>
	<cfset URL.email = FORM.email>
</cfif>

<cfset local.message="An Error has occurred, Wellcoaches IT has been informed and will get back to you shortly." />

<!--- 1. Define the Learn Upon group IDs and their associated tags --->
<cfset local.LU_tags = {
	"1027429": ["24189", "1382", "1384"],
	"1027428": ["24157", "1382", "1384"],
	"1027427": ["24105", "1382", "1384"],
	"1027426": ["24073", "1382", "1384"],
	"1024985": ["23844", "1382", "1384"],
	"1024981": ["23812", "1382", "1384"],
	"1003949": ["23502", "1382", "1384"],
	"1003929": ["23936", "1382", "1384"],
	"1003926": ["23974", "1382", "1384"],
	"1003872": ["23904", "1382", "1384"],
	"1000501": ["23726", "1382", "1384"],
	"1000430": ["23728", "1382", "1384"],
	"999802": ["23658", "1382", "1384"],
	"999795": ["23626", "1382", "1384"],
	"988581": ["23748", "1382", "1384"],
	"986468": ["23594", "1382", "1384"],
	"965750": ["24189", "24157", "24105", "24073", "23936", "23904", "23974", "23658", "23626", "23594", "23408", "1382", "1384"],
	"986003": ["23700", "1382", "1384"],
	"971602": ["23408", "1382", "1384"],
	"971601": ["24189", "24157", "24105", "24073", "23844", "23812", "24029", "23998", "23936", "23904", "23974", "23658", "23626", "23594", "23408", "1382", "1384"],
	"966452": ["23536", "1382", "1384"],
	"959902": ["23408", "1382", "1384"],
	"929342": ["23268", "1382", "1384"],
	"929341": ["23204", "1382", "1384"],
	"929340": ["23236", "1382", "1384"],
	"929339": ["23172", "1382", "1384"],
	"919766": ["23096", "23098", "1382", "1384"],
	"907872": ["22948", "1382", "1384"],
	"907870": ["22884", "1382", "1384"],
	"906887": ["22916", "1382", "1384"],
	"906878": ["22852", "1382", "1384"],
	"905522": ["22788", "1382", "1384"],
	"901768": ["22756", "1382", "1384"],
	"900069": ["22550", "1382", "1384"],
	"900067": ["22516", "1382", "1384"],
	"894855": ["7706", "1826", "3054", "1382", "1384"],
	"893888": ["22482", "1382", "1384"],
	"893210": ["22448", "1382", "1384"],
	"893209": ["22414", "1382", "1384"],
	"893208": ["22380", "1382", "1384"],
	"871061": ["22352", "1382", "1384"],
	"856231": ["21546", "1382", "1384"],
	"856229": ["21540", "1382", "1384"],
	"855397": ["22304", "1382", "1384"],
	"846340": ["22180", "22078", "1382", "1384"],
	"846335": ["22146", "22044", "1382", "1384"],
	"846327": ["22112", "22010", "1382", "1384"],
	"816040": ["21962", "1382", "1384"],
	"804988": ["21796", "21694", "1382", "1384"],
	"804987": ["21762", "21660", "1382", "1384"],
	"804985": ["21728", "21626", "1382", "1384"],
	"793694": ["21456", "1382", "1384"],
	"793693": ["21446", "1382", "1384"],
	"793691": ["21436", "1382", "1384"],
	"793682": ["21426", "1382", "1384"],
	"785081": ["21458", "21460", "1382", "1384"],
	"776255": ["21146", "21074", "1382", "1384"],
	"775645": ["21918", "21122", "21050", "1382", "1384"],
	"770351": ["21098", "21026", "1382", "1384"],
	"764200": ["20578", "1382", "1384"],
	"764037": ["21256", "1382", "1384"],
	"760391": ["20992", "1382", "1384"],
	"756035": ["20836", "20764", "1382", "1384"],
	"756033": ["21528", "20812", "20740", "1382", "1384"],
	"752456": ["21360", "20788", "20716", "1382", "1384"],
	"748581": ["20902", "1382", "1384"],
	"748578": ["20642", "1382", "1384"],
	"747386": ["20990", "1382", "1384"],
	"744246": ["20662", "1382", "1384"],
	"731913": ["20510", "20304", "1382", "1384"],
	"729855": ["20320", "20288", "20198", "1382", "1384"],
	"728278": ["20950", "20272", "20182", "1382", "1384"],
	"720840": ["20084", "19934", "19910", "1382", "1384"],
	"720428": ["20570", "20118", "1382", "1384"],
	"715258": ["20620", "20340", "19884", "19858", "1382", "1384"],
	"704813": ["19832", "1382", "1384"],
	"674596": ["19960", "19672", "1382", "1384"],
	"654892": ["19614", "19530", "19556", "1382", "1384"],
	"651296": ["19076", "1382", "1384"],
	"650725": ["19450", "19476", "1382", "1384"],
	"647797": ["19376", "19350", "1382", "1384"],
	"645020": ["19288", "19262", "1382", "1384"],
	"638088": ["19180", "19154", "1382", "1384"],
	"625819": ["19006", "1382", "1384"],
	"611521": ["19102", "18910", "1382", "1384"],
	"607295": ["18840", "18814", "1382", "1384"],
	"595986": ["18773", "18748", "1382", "1384"],
	"588117": ["18714", "18688", "1382", "1384"],
	"583849": ["18510", "18562", "18536", "1382", "1384"],
	"570664": ["18446", "18472", "1382", "1384"],
	"570659": ["18420", "1382", "1384"],
	"569236": ["18364", "1382", "1384"],
	"569228": ["18338", "1382", "1384"],
	"555224": ["18216", "1382", "1384"],
	"555223": ["18242", "1382", "1384"],
	"550736": ["18128", "18602", "1382", "1384"],
	"546704": ["18194", "1382", "1384"],
	"545173": ["18074", "18154", "1382", "1384"],
	"539864": ["18020", "1382", "1384"],
	"539861": ["18004", "1382", "1384"],
	"537709": ["17938", "18056", "1382", "1384"],
	"531867": ["17922", "1382", "1384"],
	"517484": ["17500", "1382", "1384"],
	"517483": ["17548", "1382", "1384"],
	"497231": ["17484", "1382", "1384"],
	"497171": ["17532", "1382", "1384"],
	"476138": ["17516", "1382", "1384"],
	"476136": ["17468", "1382", "1384"],
	"475536": ["17706", "1382", "1384"],
	"467705": ["17420", "1382", "1384"],
	"467704": ["17436", "1382", "1384"],
	"467702": ["17612", "1382", "1384"],
	"457198": ["17328", "1382", "1384"],
	"457195": ["17344", "1382", "1384"],
	"444680": ["17192", "1382", "1384"],
	"443399": ["17256", "1382", "1384"],
	"443398": ["17232", "1382", "1384"],
	"418135": ["16748", "1382", "1384"],
	"418067": ["16962", "1382", "1384"],
	"417007": ["16886", "1382", "1384"],
	"415904": ["16600", "1382", "1384"],
	"415521": ["16516", "1382", "1384"],
	"399396": ["16044", "1382", "1384"],
	"397128": ["16138", "1382", "1384"],
	"394270": ["15942", "1382", "1384"],
	"383008": ["15762", "1382", "1384"],
	"345594": ["15644", "15660", "1382", "1384", "15646"],
	"357954": ["15506", "1382", "1384"],
	"335420": ["15311", "1382", "1384"],
	"335393": ["15217", "1382", "1384"],
	"331706": ["15023", "1382", "1384"],
	"331102": ["14935", "1382", "1384"],
	"326955": ["14845", "1382", "1384"],
	"311207": ["14711", "1382", "1384"],
	"310295": ["14383", "1382", "1384"],
	"270378": ["14557", "1382", "1384"],
	"215044": ["13887", "1382", "1384"],
	"215036": ["13975", "1382", "1384"],
	"204048": ["13577", "1382", "1384"],
	"204039": ["13489", "1382", "1384"],
	"133731": ["21412", "19526", "18990", "11372", "12583", "16436", "16438", "15443", "15445", "12858", "13671", "13673", "1382", "1384", "17762"],
	"133730": ["19658", "19056", "18990", "17760", "16438", "15445", "13673", "1382", "1384"],
	"200727": ["13343", "1382", "1384"],
	"200614": ["13091", "1382", "1384"],
	"196765": ["13237", "1382", "1384"],
	"166047": ["12535", "1382", "1384"],
	"179925": ["13001", "1382", "1384"],
	"179908": ["12771", "1382", "1384"],
	"177643": ["12877", "1382", "1384"],
	"172370": ["12649", "1382", "1384"],
	"166587": ["12229", "1382", "1384"],
	"165525": ["12383", "1382", "1384"],
	"158563": ["11909", "1382", "1384"],
	"151620": ["11204", "1382", "1384"],
	"149769": ["11669", "1382", "1384"],
	"149768": ["11012", "1382", "1384"],
	"143303": ["11108", "1382", "1384"],
	"138684": ["1382", "1384", "11458"],
	"133732": ["11420", "1382", "1384"],
	"135804": ["1382", "1384", "11448", "12319"],
	"134579": ["1382", "1384", "10145"],
	"133227": ["22712", "17886", "9617", "1382", "1384", "18672"],
	"132796": ["10732", "1382", "1384"],
	"132795": ["10371", "1382", "1384"],
	"124692": ["1382", "1384", "7892"],
	"122751": ["10480", "10610", "10910", "1382", "1384"],
	"122134": ["10163", "1382", "1384"],
	"92767": ["9777", "1382", "1384"],
	"86550": ["9831", "1382", "1384", "9821"]
}>
<cfset local.group_id = structKeyList(local.LU_tags)>

<cftry>
	<!--- creates the structure that holds the tags as the key to the structure named using LU{group} --->
	<cfloop collection="#local.LU_tags#" item="local.id">
		<cfset 'local.LU#local.id#' = {} />
		<cfloop array="#local.LU_tags[local.id]#" index="local.tag">
			<cfset local.LU[local.id][local.tag] = '' />
		</cfloop>
	</cfloop>

	<cfset key = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093" />
    <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "Password", "Groups"]>
    <cfset myArray = ["ContactService.findByEmail", key, URL.email, selectedFieldsArray]>

		<cfinvoke component="utilities/XML-RPC"
			method="CFML2XMLRPC"
			data="#myArray#"
			returnvariable="myPackage">

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
			variable="myResult1"
			timeout = "200">
		</cfexecute>

		<cfinvoke component="utilities/XML-RPC"
			method="XMLRPC2CFML"
			data="#myResult1#"
			returnvariable="theData2">

		<cfif !isArray(theData2['Params'][1]) || !arrayLen(theData2['Params'][1])>
			User <cfoutput>#URL.email#</cfoutput> does not exist in our records.<br /><cfabort />
		</cfif>

		<cfset local.userInfo = theData2.Params[1][1]>
		<cfset local.tagList =  theData2.Params[1][1]['Groups'] />

		<cfif !structKeyExists(local.userInfo,'LastName')>
			<cfset local.userInfo = theData2.Params[1][2]>
			<cfset local.tagList =  theData2.Params[1][2]['Groups'] />
		</cfif>

		<cfset local.assignGroups = "">

		<!--- Optimized: loop through groups once and check if ANY user tag matches --->
		<cfloop collection="#local.LU_tags#" item="local.groupId">
			<cfloop array="#local.LU_tags[local.groupId]#" index="local.requiredTag">
				<cfif listFind(local.tagList, local.requiredTag)>
					<cfset local.assignGroups = listAppend(local.assignGroups, local.groupId) />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfloop>

		<cfset local.id = "">

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URLEncodedFormat(URL.email)#"
			variable="myResult"
			timeout = "200">
		</cfexecute>


		<cfset local.user = deserializeJSON(myResult)>

		<cfif !structKeyExists(local.user, 'response_code')>
			<cfset local.user = deserializeJSON(myResult).user[1]>
			<cfset local.id = local.user.id>
		</cfif>


		<cfif !len(local.id)>

			<cfset local.user =
					{"User": {    'last_name' : local.userInfo['lastName']
								, 'first_name' : local.userInfo['firstName']
								, 'email' : URL.email
								, 'password' : "#local.userInfo['Password']#"
								, 'language' : 'en'

							}
					}
			/>

			<!--- this creates the user  --->
			<cfset local.user = serializeJSON(local.user) />
			<cfset local.user = ReplaceNoCase(local.user,'"','\"','all') />
			<cfset local.user = ReplaceNoCase(local.user,' ','-','all') />


			<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
				arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/users -H "Content-Type: application/json" -d #local.user#'
				variable="myResult"
				timeout = "200">
			</cfexecute>


			<cfset local.messgeStruct = deserializeJSON(myresult)>

			<cfif structKeyExists(local.messgeStruct,'message') AND (local.messgeStruct.message contains 'user already exists' OR local.messgeStruct.message contains 'already in use')>

				<cfif listLen(local.assignGroups)>
					<cfloop list="#local.assignGroups#" index="local.groupId">
						<!--- add to group --->
						<cfset local.addUser =
							{"GroupInvite": {
										  'email_addresses' : URL.email
										, 'group_id' : local.groupId
										, 'group_membership_type_id' : 1
									}
							}
						/>
						<!--- send invite to each group --->
						<cfset local.user = serializeJSON(local.addUser) />

						<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
							arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_invites -H "Content-Type: application/json" -d #ReplaceNoCase(serializeJSON(local.addUser),'"','\"','all')# '
							variable="myResult"
							timeout = "200">
						</cfexecute>
					</cfloop>
				</cfif>

				<!--- Try searching again for the user after delay --->
				<cfset sleep(1000)>
				<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
					arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URLEncodedFormat(URL.email)#"
					variable="myRetrySearch"
					timeout = "200">
				</cfexecute>

				<cfset local.retrySearchResult = deserializeJSON(myRetrySearch)>

				<cfif !structKeyExists(local.retrySearchResult, 'response_code') AND structKeyExists(local.retrySearchResult, 'user') AND arrayLen(local.retrySearchResult.user)>
					<!--- Found the user! Don't abort, let code continue --->
					<cfset local.id = local.retrySearchResult.user[1].id>
				<cfelse>
					<!--- Still can't find user --->
					<cfabort>
				</cfif>
			</cfif>

			<cfset local.createUserResponse = deserializeJSON(myResult)>
			<cfif structKeyExists(local.createUserResponse, 'id')>
				<cfset local.id = local.createUserResponse.id>
			<cfelseif structKeyExists(local.createUserResponse, 'message') AND (local.createUserResponse.message contains 'already in use' OR local.createUserResponse.message contains 'user already exists')>
				<!--- User already exists - this shouldn't happen since we searched earlier,
				      but if it does, we need to re-search with a small delay --->
				<cfset sleep(500)>
				<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
					arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URLEncodedFormat(URL.email)#"
					variable="myResultSearch"
					timeout = "200">
				</cfexecute>

				<cfset local.searchResult = deserializeJSON(myResultSearch)>
				<cfif !structKeyExists(local.searchResult, 'response_code')>
					<cfif structKeyExists(local.searchResult, 'user') AND arrayLen(local.searchResult.user)>
						<cfset local.id = local.searchResult.user[1].id>
					<cfelse>
						<h3>Error: Search succeeded but no users returned</h3>
						<cfdump var="#local.searchResult#" label="Search Result">
						<cfdump var="#URL.email#" label="Email searched">
						<cfabort>
					</cfif>
				<cfelse>
					<h3>Error: User exists in LearnUpon but search failed</h3>
					<p>This might be due to API permissions or the email format.</p>
					<cfdump var="#local.searchResult#" label="Search Result">
					<cfdump var="#URL.email#" label="Email searched">
					<cfdump var="#local.createUserResponse#" label="Create Response">
					<cfabort>
				</cfif>
			<cfelse>
				<h3>Error creating user. Response:</h3>
				<cfdump var="#local.createUserResponse#">
				<cfabort>
			</cfif>
		</cfif>

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships?user_id=#local.id#"
			variable="myGroups"
			timeout = "200">
		</cfexecute>

		<cfset local.groups = deserializeJSON(myGroups)>

		<cfset local.groupids = "" />


		<cfloop array="#local.groups['group']#" index="local.group">
			<cfset local.groupids = listAppend(local.groupids,local.group['id']) />
		</cfloop>

		<!--- assign the user to groups they should belong to --->
		<cfif listLen(local.assignGroups)>
			<cfloop list="#local.assignGroups#" index="local.groupId">

				<cfif !listFind(local.groupids,local.groupid)>

					<cfset local.groupMemberShip =
						{"GroupMembership":
							{ 'group_id' : local.groupId
							,'user_id' : local.id
							}
						}
					/>
					<!--- this applies the newly created user to a group  --->
					<cfset local.groupMemberShip = serializeJSON(local.groupMemberShip) />

					<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
						arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_memberships -H "Content-Type: application/json" -d #ReplaceNoCase(local.groupMemberShip,'"','\"','all')# '
						variable="myResult"
						timeout = "200">
					</cfexecute>

				</cfif>
			</cfloop>
		</cfif>

		<!--- Find group Ids user doesn't belong to --->
		<cfset local.deleteUserFromGroup = "" />
		<cfloop list="#local.groupids#" index="local.groupid">
			<cfif !listFind(local.assignGroups,local.groupid)>
				<cfset local.deleteUserFromGroup = listAppend(local.deleteUserFromGroup,local.groupid) />
			</cfif>
		</cfloop>


		<!--- remove user from groups he doesn't belong to --->
		<cfloop list="#local.deleteUserFromGroup#" index="local.deletegroupid">

			<cfset local.deleteGroup =
				{"GroupMembership":
					{ 'group_id' : local.deletegroupid
					,'user_id' : local.id
					}
				}
			/>

			<cfset local.deleteGroup = serializeJSON(local.deleteGroup) />

			<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
					arguments = '-X DELETE -H "Content-Type: application/json" --user #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships/0  -d #ReplaceNoCase(local.deleteGroup,'"','\"','all')# '>
			</cfexecute>

		</cfloop>

		<cfset local.message = "User was added successfully to LearnUpon!">

		<!--- Verify user exists in LearnUpon by doing a final search --->
		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URLEncodedFormat(URL.email)#"
			variable="myFinalCheck"
			timeout = "200">
		</cfexecute>

		<cfset local.finalCheckResult = deserializeJSON(myFinalCheck)>

		<cfif !structKeyExists(url,'redirectFromCH')>
			<!--- Show verification results --->
			<h3>Process Complete</h3>
			<cfif !structKeyExists(local.finalCheckResult, 'response_code')>
				<p style="color: green;">User successfully found in LearnUpon!</p>
				<h4>User Details:</h4>
				<ul>
					<li><strong>Email:</strong> <cfoutput>#URL.email#</cfoutput></li>
					<li><strong>User ID:</strong> <cfoutput>#local.finalCheckResult.user[1].id#</cfoutput></li>
					<li><strong>Name:</strong> <cfoutput>#local.finalCheckResult.user[1].first_name# #local.finalCheckResult.user[1].last_name#</cfoutput></li>
				</ul>
				<h4>Groups Assigned: <cfoutput>#listLen(local.assignGroups)#</cfoutput> total</h4>
				<ul>
					<cfloop list="#local.assignGroups#" index="local.groupId">
						<li>Group ID: <cfoutput>#local.groupId#</cfoutput></li>
					</cfloop>
				</ul>
			<cfelse>
				<p style="color: orange;">⚠ Warning: User was processed but cannot be found in LearnUpon search.</p>
				<p>This may mean:</p>
				<ul>
					<li>The user doesn't exist in LearnUpon yet</li>
					<li>Group invitations were sent but not yet accepted</li>
					<li>API search has limited permissions</li>
				</ul>
				<p><strong>Action Required:</strong> Please check LearnUpon directly at <a href="https://wellcoaches.learnupon.com/admin/users" target="_blank">LearnUpon Users</a> to verify if the user exists.</p>

				<h4>Debug Information:</h4>
				<cfdump var="#local.finalCheckResult#" label="Final Search Result">
			</cfif>
		<cfelse>
			<cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#URL.email#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" />
		</cfif>

	<cfcatch type="any">

		<cfmail to="rdiveley@wellcoaches.com" subject="LearnUpon Create Groups" from="wellcoaches@wellcoaches.com" type="html">
			<table>
				<tr>
					<td><cfdump var="#cfcatch#" format="html"></td>
				</tr>

				<tr>
					<td><cfdump var="#url#" format="html"></td>
				</tr>
			</table>
		</cfmail>
	</cfcatch>
</cftry>

<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


