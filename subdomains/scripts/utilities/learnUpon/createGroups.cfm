<cfinclude template="credentials.cfm">


<cfif structKeyExists(form,'email')>
	<cfset URL.email = FORM.email>
</cfif>


<!--- 1. add the Learn Upon group IDs here --->
<cfset local.group_id = "517483,517484,497231,497171,476138,476136,475536,457198,467705,467704,467702,457195,444680,443399,443398,418135,418067,417007,415904,415521,399396,397128,394270,383008,357954,345594,335420,335393,331706,331102,326955,311207,310295,270378,215044,215036,204048,204039,133730,200727,200614,86550,92767,121229,122134,122751,124692,132795,132796,133227,134579,135804,133731,133732,138684,143303,149768,149769,158563,165525,166587,135804,151620,172370,177643,179908,179925,166047,196765">
<cfset local.group_id = listRemoveDuplicates(local.group_id) />
<!--- 2. create the associated tags to the groups --->

<!--- IS tags for Learn Upon 86550 Fundamentals of Lifestyle Medicine--->
<cfset local.LU86550_tags = "9831,1382,1384,9821">
<!--- IS tags for 92767 NBC-HWC Exam Preparation 2018--->
<cfset local.LU92767_tags = "9777,1382,1384">
<!--- IS tags for 10706 Core Coach Training - Knowledge Assessment for September 2018 Cohort --->
<cfset local.LU121229_tags = "10706,1382,1384">
<!--- IS tags for #10163 (Core Nov2018 Mod 1*) --->
<cfset local.LU122134_tags = "10163,1382,1384">
<!--- IS tags for #10480 Res Dec2018 [Bemidji] Mod 1* and #10610 Res Feb2019 [Ft Worth] Mod 1* --->
<cfset local.LU122751_tags = "10480,10610,10910,1382,1384">
<!--- #3054 – I have a Membership Free #1826 – I have a Membership Paid --->
<cfset local.LU124692_tags = "3054,1826,1382,1384,7892">
<!--- #10371 (Core Jan2019 Mod 1*) for  Core Coach Training - 18 Week Teleclasses --->
<cfset local.LU132795_tags = "10371,1382,1384">
<!--- #10732 Core Mar2019 Mod 1* --->
<cfset local.LU132796_tags = "10732,1382,1384">
<!--- #133227 Core Coach Training: Module 2 --->
<cfset local.LU133227_tags = "9617,1382,1384">
<!--- #134579 Professional Coach Training 2019 --->
<cfset local.LU134579_tags = "1382,1384,10145">
<!--- 135804 = Burnout Prevention Program for Physicians --->
<cfset local.LU135804_tags = "1382,1384,11448,12319">
<!--- 133732 = Core Coach Training: Module 1  (University of Wisconsin) --->
<cfset local.LU133732_tags="11420,1382,1384" >
<!--- 138684 = Core Coach Training: Module 1  (May 2019 cohort) --->
<cfset local.LU138684_tags = "1382,1384,11458">
<!--- 143303 = Core Coach Training: Module 1 (August 2019: 4-day residential) --->
<cfset local.LU143303_tags = "11108,1382,1384">
<!--- Core Coach Training: Module 1 (June 2019: 4-day residential) --->
<cfset local.LU149768_tags = "11012,1382,1384">
<!--- Core Coach Training: Module 1 (July 2019 cohort) --->
<cfset local.LU149769_tags = "11669,1382,1384">
<!--- Core Coach Training: Module 1 (Oct 2019: 4-day residential) --->
<cfset local.LU151620_tags = "11204,1382,1384">
<!--- Core Coach Training: Core Sep2019 Mod 1* --->
<cfset local.LU158563_tags = "11909,1382,1384">
<!--- Res Jul2019 [Singapore] Mod 1* --->
<cfset local.LU165525_tags = "12383,1382,1384">
<!--- Core Coach Training: Module 1  (Nov 2019 cohort) --->
<cfset local.LU166587_tags = "12229,1382,1384">
<!--- 12649 Res Feb2020 [AZ] Mod 1* --->
<cfset local.LU172370_tags = "12649,1382,1384">
<!--- Core Coach Training: Module 1 (Dec 2019: 4-day residential) --->
<cfset local.LU177643_tags = "12877,1382,1384">
<!--- Core Jan2020 Mod 1* --->
<cfset local.LU179908_tags = "12771,1382,1384">
<!--- Core Feb2020 Mod 1* --->
<cfset local.LU179925_tags = "13001,1382,1384">
<!--- PCTP Jan2020 --->
<cfset local.LU166047_tags = "12535,1382,1384">
<!--- 	Res Apr2020 [FL] Mod 1* --->
<cfset local.LU196765_tags = "13237,1382,1384">
<!--- 200614 	Core Coach Training: Module 1  (Mar 2020 cohort) --->
<cfset local.LU200614_tags = "13091,1382,1384">
<!--- Core Coach Training: Module 1  (April 2020 cohort) --->
<cfset local.LU200727_tags = "13343,1382,1384">
<!--- Core Coach Training: Module 2 (California University of PA) --->
<cfset local.LU133730_tags = "17760,16438,15445,13673,1382,1384">
<!--- Core Coach Training: Module 1  (California Univ of PA) --->
<cfset local.LU133731_tags = "11372,12583,16436,16438,15443,15445,12583,13671,13673,1382,1384">
<!---Core Coach Training: Module 1  (May 2020 cohort) --->
<cfset local.LU204039_tags = "13489,1382,1384">
<!--- Core Coach Training: Module 1 (June 2020: 4-day residential) --->
<cfset local.LU204048_tags = "13577,1382,1384">
<!---  Core Coach Training: Module 1  (July 2020 cohort)--->
<cfset local.LU215036_tags = "13975,1382,1384">
<!---  Core Coach Training: Module 1  (June 2020 cohort) --->
<cfset local.LU215044_tags = "13887,1382,1384">
<!--- Core Coach Training: Module 1 (April 2020 Singapore) --->
<cfset local.LU270378_tags = "14557,1382,1384">
<!--- core Coach Training: Module 1  (Aug 2020 cohort) --->
<cfset local.LU310295_tags = "14383,1382,1384" >
<!--- Core Coach Training: Module 1  (Monarch Dedicated 2020 cohort)  --->
<cfset local.LU311207_tags = "14711,1382,1384" >
<!--- Core Coach Training: Module 1  (Sept 2020 cohort) --->
<cfset local.LU326955_tags = "14845,1382,1384" >
<!--- 14935	Core Oct2020 Mod 1* --->
<cfset local.LU331102_tags = "14935,1382,1384" >
<!--- Core Coach Training: Module 1  (Nov 2020 cohort) --->
<cfset local.LU331706_tags = "15023,1382,1384" >
<!--- Core Coach Training: Module 1  (Oct 2020 4-day) --->
<cfset local.LU335393_tags = "15217,1382,1384" >
<!--- Core Coach Training: Module 1  (Dec 2020 4-day)  --->
<cfset local.LU335420_tags = "15311,1382,1384" >
<!--- Core Coach Training: Module 1  (Jan 2021 cohort)--->
<cfset local.LU357954_tags = "15506,1382,1384" />
<!--- behavior change agent --->
<cfset local.LU345594_tags = "15644,15660,1382,1384" />
<!--- Core Coach Training: Module 1  (Feb 2021 9-wk cohort)s --->
<cfset local.LU383008_tags = "15762,15646,1382,1384" />
<!--- 15942	Core Mar2021 Mod 1* --->
<cfset local.LU394270_tags = "15942,1382,1384" />
<!--- 16436 Core Coach Training: Module 1 (California Univ of PA) --->
<cfset local.LU397128_tags = "16138,1382,1384" />
<!--- Core Coach Training: Module 1  (Apr 2021, 4-Friday  cohort) --->
<cfset local.LU399396_tags = "16044,1382,1384" />
<!--- Core Coach Training: Module 1  (May 2021 cohort) --->
<cfset local.LU415521_tags = "16516,1382,1384" />
<!--- Core Coach Training: Module 1  (June 2021 9-wk cohort) --->
<cfset local.LU415904_tags = "16600,1382,1384" />
<!--- Core Coach Training: Module 1 (March 2021 4-day)--->
<cfset local.LU417007_tags = "16886,1382,1384" />
<!--- Core Coach Training: Module 1 (March 2021 4-day)--->
<cfset local.LU418067_tags = "16962,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2021 4-week)--->
<cfset local.LU418135_tags = "16748,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2021 4-day)--->
<cfset local.LU443398_tags = "17232,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2021 4-day) --->
<cfset local.LU443399_tags = "17256,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2021 9-week) --->
<cfset local.LU444680_tags = "17192,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 4-week) --->
<cfset local.LU457195_tags = "17344,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 9-week)  --->
<cfset local.LU467705_tags = "17420,1382,1384" />
<!--- Core Coach Training: Module 1 (Sept 2021 4-day) --->
<cfset local.LU467704_tags = "17436,1382,1384" />
<!--- Core Coach Training: Module 1 (Sept 2021 4-week) --->
<cfset local.LU467702_tags = "17612,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 9-week) --->
<cfset local.LU457198_tags = "17328,1382,1384" />
<!--- Professional Coach Training 2022 --->
<cfset local.LU475536_tags = "17706,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2021 9-week) --->
<cfset local.LU476136_tags = "17468,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2021 4-week)  --->
<cfset local.LU476138_tags = "17516,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2021 4-day) --->
<cfset local.LU497171_tags = "17532,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2021 9-week) --->
<cfset local.LU497231_tags = "17484,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2021 9-week) --->
<cfset local.LU517484_tags = "17500,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2021 9-week) --->
<cfset local.LU517483_tags = "17548,1382,1384" />


<!--- creates the structure that holds the tags as the key to the structure named using LU{group} --->
<cfloop list="#local.group_id#" index="local.id">
	<cfset 'local.LU#local.id#' = {} />
	<cfloop list="#evaluate('local.LU'&local.id&'_tags')#" index="local.tag">
		<cfset local.LU[local.id][local.tag] = '' >
	</cfloop>
</cfloop>


    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
		arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
		variable="myResult1"
		timeout = "200">
	</cfexecute>


	 <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1#"
        returnvariable="theData2">

	<cfif !arrayLen(theData2['Params'][1])>
		User <cfoutput>#URL.email#</cfoutput> does not exist in our records.<br /><cfabort />
	</cfif>

	<cfset local.userInfo = theData2.Params[1][1]>
	<cfset local.tagList =  theData2.Params[1][1]['Groups'] />


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

<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


