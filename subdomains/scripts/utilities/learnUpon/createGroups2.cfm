<cfinclude template="credentials.cfm">

<cfif structKeyExists(form, 'email')>
    <cfset URL.email = FORM.email>
</cfif>

<cfset local.message = "An error has occurred. Wellcoaches IT has been informed and will get back to you shortly." />

<!--- Group and Tag Definitions: Consolidate into a structure for better management --->
<cfset local.LU = {
    "86550": ["9831", "1382", "1384", "9821"], <!--- Fundamentals of Lifestyle Medicine --->
    "92767": ["9777", "1382", "1384"], <!--- NBC-HWC Exam Preparation 2018 --->
    "122134": ["10163", "1382", "1384"], <!--- Core Nov2018 Mod 1 --->
    "122751": ["10480", "10610", "10910", "1382", "1384"], <!--- Res Dec2018 and Feb2019 --->
    "124692": ["1382", "1384", "7892"], <!--- Membership Free and Paid --->
    "132795": ["10371", "1382", "1384"], <!--- Core Jan2019 Mod 1 --->
    "132796": ["10732", "1382", "1384"], <!--- Core Mar2019 Mod 1 --->
    "133227": ["17886", "9617", "1382", "1384", "18672", "9617"], <!--- Core Coach Training Module 2 --->
    "134579": ["1382", "1384", "10145"], <!--- Professional Coach Training 2019 --->
    "135804": ["1382", "1384", "11448", "12319"], <!--- Burnout Prevention Program for Physicians --->
    "133732": ["11420", "1382", "1384"], <!--- Core Coach Training: Module 1 (University of Wisconsin) --->
    "138684": ["1382", "1384", "11458"], <!--- Core Coach Training: Module 1 (May 2019 cohort) --->
    "143303": ["11108", "1382", "1384"], <!--- Core Coach Training: Module 1 (August 2019) --->
    "149768": ["11012", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2019) --->
    "149769": ["11669", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2019 cohort) --->
    "151620": ["11204", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2019) --->
    "158563": ["11909", "1382", "1384"], <!--- Core Sep2019 Mod 1 --->
    "165525": ["12383", "1382", "1384"], <!--- Res Jul2019 Singapore Mod 1 --->
    "166587": ["12229", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2019 cohort) --->
    "172370": ["12649", "1382", "1384"], <!--- Res Feb2020 Mod 1 --->
    "177643": ["12877", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2019) --->
    "179908": ["12771", "1382", "1384"], <!--- Core Jan2020 Mod 1 --->
    "179925": ["13001", "1382", "1384"], <!--- Core Feb2020 Mod 1 --->
    "166047": ["12535", "1382", "1384"], <!--- PCTP Jan2020 --->
    "196765": ["13237", "1382", "1384"], <!--- Res Apr2020 FL Mod 1 --->
    "200614": ["13091", "1382", "1384"], <!--- Core Mar 2020 cohort --->
    "200727": ["13343", "1382", "1384"], <!--- Core Apr 2020 cohort --->
    "133730": ["19658", "19056", "18990", "17760", "16438", "15445", "13673", "1382", "1384"], <!--- Core Mod 2 CA Univ of PA --->
    "133731": ["21412", "19526", "18990", "11372", "12583", "16436", "16438", "15443", "15445", "12858", "13671", "13673", "1382", "1384", "17762"], <!--- Core Mod 1 CA Univ of PA --->
    "204039": ["13489", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2020) --->
    "204048": ["13577", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2020) --->
    "215036": ["13975", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2020) --->
    "215044": ["13887", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2020) --->
    "270378": ["14557", "1382", "1384"], <!--- Core Coach Training: Module 1 (April 2020 Singapore) --->
    "310295": ["14383", "1382", "1384"], <!--- Core Coach Training: Module 1 (Aug 2020 cohort) --->
    "311207": ["14711", "1382", "1384"], <!--- Core Coach Training: Module 1 (Monarch Dedicated 2020 cohort) --->
    "326955": ["14845", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sept 2020) --->
    "331102": ["14935", "1382", "1384"], <!--- Core Oct2020 Mod 1 --->
    "331706": ["15023", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2020) --->
    "335393": ["15217", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2020 4-day) --->
    "335420": ["15311", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2020 4-day) --->
    "357954": ["15506", "1382", "1384"], <!--- Core Coach Training: Module 1 (Jan 2021) --->
    "345594": ["15644", "15660", "1382", "1384", "15646"], <!--- Behavior Change Agent --->
    "383008": ["15762", "1382", "1384"], <!--- Core Coach Training: Module 1 (Feb 2021) --->
    "394270": ["15942", "1382", "1384"], <!--- Core Mar2021 Mod 1 --->
    "397128": ["16138", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2021) --->
    "399396": ["16044", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2021) --->
    "415521": ["16516", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2021 cohort) --->
    "415904": ["16600", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2021) --->
    "417007": ["16886", "1382", "1384"], <!--- Core Coach Training: Module 1 (Mar 2021) --->
    "418067": ["16962", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2021) --->
    "418135": ["16748", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2021) --->
    "443398": ["17232", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2021) --->
    "443399": ["17256", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2021 4-day) --->
    "444680": ["17192", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2021 9-week) --->
    "457195": ["17344", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sept 2021) --->
    "467705": ["17420", "1382", "1384"], <!--- Core Coach Training: Module 1 (August 2021 9-week) --->
    "467704": ["17436", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sept 2021 4-week) --->
    "467702": ["17612", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sept 2021) --->
    "457198": ["17328", "1382", "1384"], <!--- Professional Coach Training 2022 --->
    "475536": ["17706", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2021 9-week) --->
    "476136": ["17468", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2021) --->
    "476138": ["17516", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2021 4-day) --->
    "497171": ["17532", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2021 9-week) --->
    "497231": ["17484", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2021 9-week) --->
    "517484": ["17500", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2021 4-day) --->
    "517483": ["17548", "1382", "1384"], <!--- Core Coach Training: Module 1 (Jan 2022 9-week) --->
    "531867": ["17922", "1382", "1384"], <!--- Core Coach Training: Module 1 (Jan 2022 4-day) --->
    "537709": ["17938", "18056", "1382", "1384"], <!--- Core Coach Training: Module 1 (Feb 2022 9-week) --->
    "539861": ["18004", "1382", "1384"], <!--- Core Coach Training: Module 1 (Feb 2022 4-week) --->
    "539864": ["18020", "1382", "1384"], <!--- Holiday Extra Credit Offer --->
    "546704": ["18194", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2022) --->
    "545173": ["18074", "18154", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2022) --->
    "555223": ["18242", "1382", "1384"], <!--- Core Coach Training: Module 1 (April 2022 4-week) --->
    "555224": ["18216", "1382", "1384"], <!--- Core Coach Training: Module 1 (April 2022 9-week) --->
    "569228": ["18338", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2022 9-week) --->
    "569236": ["18364", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2022 4-day) --->
    "570659": ["18420", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2022 9-week) --->
    "570664": ["18446", "18472", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2022 4-week) --->
    "550736": ["18128", "18602", "1382", "1384"], <!--- Core Coach Training: Module 1 (Mar 2022 4-day) --->
    "583849": ["18510", "18562", "18536", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2022 4-day) --->
    "588117": ["18714", "18688", "1382", "1384"], <!--- Core Coach Training: Module 1 (Aug 2022) --->
    "595986": ["18773", "18748", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sept 2022) --->
    "607295": ["18840", "18814", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2022) --->
    "611521": ["19102", "18910", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2022) --->
    "625819": ["19006", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2022) --->
    "638088": ["19180", "19154", "1382", "1384"], <!--- Core Coach Training: Module 1 (Jan 2023) --->
    "645020": ["19288", "19262", "1382", "1384"], <!--- Core Coach Training: Module 1 (Feb 2023) --->
    "647797": ["19376", "19350", "1382", "1384"], <!--- Core Coach Training: Module 1 (Mar 2023) --->
    "650725": ["19450", "19476", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2023) --->
    "651296": ["19076", "1382", "1384"], <!--- Professional Coach Training 2023 --->
    "654892": ["19614", "19530", "19556", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2023) --->
    "674596": ["19960", "19672", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2023) --->
    "704813": ["19832", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2023) --->
    "715258": ["20620", "20340", "19884", "19858", "1382", "1384"], <!--- Core Coach Training: Module 1 (Aug 2023) --->
    "720428": ["20570", "20118", "1382", "1384"], <!--- Coaching for Mental Well-being --->
    "720840": ["20084", "19934", "19910", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sep 2023) --->
    "728278": ["20950", "20272", "20182", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2023) --->
    "729855": ["20320", "20288", "20198", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2023) --->
    "731913": ["20510", "20304", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2023) --->
    "747386": ["20374", "1382", "1384"], <!--- Coaching for Social Resources and Health Equity --->
    "744246": ["20662", "1382", "1384"], <!--- Professional Coach Training 2024 --->
    "748578": ["20642", "1382", "1384"], <!--- Collection Offering #1 --->
    "748581": ["20902", "1382", "1384"], <!--- Collection Offering #2 --->
    "752456": ["21360", "20788", "20716", "1382", "1384"], <!--- Core Coach Training: Module 1 (Jan 2024) --->
    "756033": ["21528", "20812", "20740", "1382", "1384"], <!--- Core Coach Training: Module 1 (Feb 2024) --->
    "756035": ["20836", "20764", "1382", "1384"], <!--- Core Coach Training: Module 1 (Mar 2024) --->
    "760391": ["20992", "1382", "1384"], <!--- Coaching for Social Resources and Health Equity --->
    "764037": ["21256", "1382", "1384"], <!--- Coaching Clients to a Healthy Weight (on-demand) --->
    "764200": ["20578", "1382", "1384"], <!--- Coaching for Mental Well-being (Dec 2023) --->
    "770351": ["21098", "21026", "1382", "1384"], <!--- Core Coach Training: Module 1 (Apr 2024) --->
    "775645": ["21918", "21122", "21050", "1382", "1384"], <!--- Core Coach Training: Module 1 (May 2024) --->
    "776255": ["21146", "21074", "1382", "1384"], <!--- Core Coach Training: Module 1 (June 2024) --->
    "785081": ["21458", "21460", "1382", "1384"], <!--- Cut Through the Noise --->
    "793682": ["21426", "1382", "1384"], <!--- Coaching for Mental Well-being - Feb 2024 --->
    "793691": ["21436", "1382", "1384"], <!--- Coaching for Mental Well-being - May 2024 --->
    "793693": ["21446", "1382", "1384"], <!--- Coaching for Mental Well-being - Sep 2024 --->
    "793694": ["21456", "1382", "1384"], <!--- Coaching for Mental Well-being - Nov 2024 --->
    "804985": ["21728", "21626", "1382", "1384"], <!--- Core Coach Training: Module 1 (July 2024) --->
    "804987": ["21762", "21660", "1382", "1384"], <!--- Core Coach Training: Module 1 (Aug 2024) --->
    "804988": ["21796", "21694", "1382", "1384"], <!--- Core Coach Training: Module 1 (Sep 2024) --->
    "816040": ["21962", "1382", "1384"], <!--- Professional Coach Training 2025 --->
    "846327": ["22112", "22010", "1382", "1384"], <!--- Core Coach Training: Module 1 (Oct 2024) --->
    "846335": ["22146", "22044", "1382", "1384"], <!--- Core Coach Training: Module 1 (Nov 2024) --->
    "846340": ["22180", "22078", "1382", "1384"], <!--- Core Coach Training: Module 1 (Dec 2024) --->
    "855397": ["22304", "1382", "1384"], <!--- NBC-HWC Preparation Course 2.0 --->
    "856229": ["21540", "1382", "1384"], <!--- Coaching for Social Resources and Health Equity - Aug 2024 --->
    "856231": ["21546", "1382", "1384"], <!--- Coaching for Social Resources and Health Equity - Nov 2024 --->
    "871061": ["22352", "1382", "1384"], <!--- USCF - Module 1 4-day Training, September 2024 --->
    "893208": ["22380", "1382", "1384"], <!--- Core Coach Training: Module 1 - 9 week (January 2025) --->
    "893209": ["22414", "1382", "1384"], <!--- Core Coach Training: Module 1 - 9 week (February 2025) --->
    "893210": ["22448", "1382", "1384"], <!--- Core Coach Training: Module 1 - 9 week (March 2025) --->
    "893888": ["22482", "1382", "1384"], <!--- Core Coach Training: Module 1 - 4 week (January 2025) --->
    "894855": ["1826", "3054", "1382", "1384"], <!--- Wellcoaches Membership: Upcoming Classes and Recorded Continuing Education --->
    "900067": ["22516","1382","1384"],<!---   Core Coach Training: Module 1 - 4 week (February 2025) --->
    "900069":["22550","1382","1384"]<!---   Core Coach Training: Module 1 - 4 week (March 2025) --->
} />

<cfset local.LU = {} />
<cfloop collection="#local.lu#" item="local.id">
    <!--- Dynamically create a struct for each group ID --->
    <cfset "local.LU#local.id#" = {} />
    
    <!--- Loop through the tags in the group and add them to the nested struct --->
    <cfloop array="#local.lu[local.id]#" index="local.tag">
        <cfset local.LU[local.id][local.tag] = "" />
    </cfloop>
</cfloop>
<!--- CFDUMP: Debugging by rdiveley --->
<cfdump var="#local#" abort="true" format="html" output="" top="3">

<cfloop list="#local.group_id#" index="local.id">
		<cfset 'local.LU#local.id#' = {} />
		<cfloop list="#evaluate('local.LU'&local.id&'_tags')#" index="local.tag">
			<cfset local.LU[local.id][local.tag] = '' >
		</cfloop>
	</cfloop>


	<cfset key = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
	<cfset selectedFieldsArray[4] = "Password">
	<cfset selectedFieldsArray[5] = "Groups">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!----Service.method always first param---->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
    <cfset myArray[4]=selectedFieldsArray>

	
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

		<!--- loop through all the tags, if you find a tag as a key to a structure/group, add that group to local.assignGroups --->
		<cfloop list="#local.tagList#" index="local.tag">
			<cfloop collection="#local.LU#" item="local.col">
				<cfif structKeyExists(local.LU[local.col],local.tag)>
					<cfset local.assignGroups = listAppend(local.assignGroups,local.col) />
				</cfif>
			</cfloop>
		</cfloop>

		<cfset local.assignGroups = listRemoveDuplicates(local.assignGroups)>

		<cfset local.id = "">

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URL.email#"
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
								, 'membership_type' : 'Learner'
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

			<cfif structKeyExists(local.messgeStruct,'message') AND local.messgeStruct.message contains 'user already exists'>

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
							arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_invites -H "Content-Type: application/json" -d #ReplaceNoCase(local.addUser,'"','\"','all')# '
							variable="myResult"
							timeout = "200">
						</cfexecute>
					</cfloop>
				</cfif>

				<h3>User invite was sent successfully!</h3>
				<cfabort>
			</cfif>

			<cfset local.id = deserializeJSON(myResult).id>
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
		<cfif structKeyExists(url,'redirectFromCH')>
				 <cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#URL.email#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" />
		</cfif>
		
		