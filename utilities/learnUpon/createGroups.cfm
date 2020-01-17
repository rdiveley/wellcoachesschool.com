<cfinclude template="credentials.cfm">
<!--- Learn Upon Group Ids:

86550 = Fundamentals of Lifestyle Medicine 
92767 = NBC-HWC Exam Preparation 2018 
121229 = Core Coach Training - Knowledge Assessment for September 2018 Cohort 
122134 = Core Coach Training - 18 Week Teleclasses
122751 = Core Coach Training - 4-day Residential 
124692 = Member Classes
132795 = Core Coach Training: Module 1 - January 2019
132796 = Core Coach Training: Module 1 (Mar 2019 Cohort)
133227 = Core Coach Training: Module 2
134579 = Professional Coach Training 2019
135804 = Burnout Prevention Program for Physicians
133731 = Core Coach Training: Module 1  (University of California of PA)
133732 = Core Coach Training: Module 1  (University of Wisconsin)
138684 = Core Coach Training: Module 1  (May 2019 cohort)
143303 = Core Coach Training: Module 1 (August 2019: 4-day residential)
158563 = Core Coach Training: Module 1  (September 2019 cohort)
165525 = Core Coach Training: Module 1 (Singapore 2019)
--->

<!--- IS tags:

1382 Wellcoaches Operations Team
1384 Wellcoaches Faculty
1826 I have a Membership Paid
3054 I have a Membership Free
7892 Free Trainee Membership Access to CH
9821 LM Mod 4 Complimentary
9831 LM Mod 4 Course Access
9777 NBC-HWC Preparation Course
10371 Core Jan2019 Mod 1*
10145 PCTP Jan 2019
10910	Res Apr2019 [Marina CA] Mod 1*
10480 Res Dec2018 [Bemidji] Mod 1
10610 Res Feb2019 [Ft Worth] Mod 1*
10706 Knowledge Assessment_Sep2018
10732 Core Mar2019 Mod 1*
11372 CalU Jan2019 [714]
11108 Res Aug2019 [Indy IN] Mod 1*
11384 CalU Jan2019 Final Notice
11420 UWM Core Jan2019        
11649 LU Access to Mod 1 [Universities] 
11909 Core Sep2019 Mod 1*
9617  CH LearnUpon Access to Module 2
11448 Burnout Prevention Program (BPP)
11458  Core May2019 Mod 1*
11012 Res Jun2019 [Asheville NC] Mod 1*
11669	Core Jul2019 Mod 1*
11204	Res Oct2019 [Naples FL] Mod 1*
12383	Res Jul2019 [Singapore] Mod 1*
12229	Core Nov2019 Mod 1*







--->

<cfif structKeyExists(form,'email')>
	<cfset URL.email = FORM.email>
</cfif>


<!--- 1. add the Learn Upon group IDs here --->
 <cfset local.group_id = "86550,92767,121229,122134,122751,124692,132795,132796,133227,134579,135804,133731,133732,138684,143303,149768,149769,527046,158563,165525,166587">

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
<cfset local.LU135804_tags = "1382,1384,11448">
<!--- 133731 = Core Coach Training: Module 1  (University of California of PA) --->
<cfset local.LU133731_tags="11372,1382,1384" >
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
<cfset local.LU527046_tags = "11204,1382,1384">
<!--- Core Coach Training: Core Sep2019 Mod 1* --->
<cfset local.LU158563_tags = "11909,1382,1384">
<!--- Res Jul2019 [Singapore] Mod 1* --->
<cfset local.LU165525_tags = "12383,1382,1384">
<!--- Core Coach Training: Module 1  (Nov 2019 cohort) --->
<cfset local.LU166587_tags = "12229,1382,1384">


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
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!----Service.method always first param---->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

       <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult1">
           <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
       </cfhttp>

	 <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

	<cfif !arrayLen(theData2['Params'][1])>
		User <cfoutput>#URL.email#</cfoutput> does not exist in our records.<br /><cfabort />
	</cfif>

	<cfset local.userInfo = theData2['Params'][1][1]>

	<!--- get their tags --->
	<cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Groups">

    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!----Service.method always first param---->
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]='(int)#local.userInfo["Id"]#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">

    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#result.Filecontent#"
            returnvariable="theData">

    <cfset local.tagList =  theData.Params[1]['Groups'] />

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

		<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/users/search?email=#URL.email#"
			result="myResult"
			username="#local.username#"
			password="#local.password#">
		</cfhttp>

		<cfset local.user = deserializeJSON(myResult.filecontent)>


		<cfif !structKeyExists(local.user, 'response_code')>
			<cfset local.user = deserializeJSON(myResult.filecontent).user[1]>
			<cfset local.id = local.user.id>
		</cfif>

		<cfif !len(local.id)>
			<cfset local.user =
					{"User": {    'last_name' : local.userInfo['lastName']
								, 'first_name' : local.userInfo['firstName']
								, 'email' : URL.email
								, 'password' : local.userInfo['Password']
								, 'language' : 'en'
								, 'membership_type' : 'Learner'
							}
					}
			/>

			<!--- this creates the user --->
			<cfhttp method="post" url="https://wellcoaches.learnupon.com/api/v1/users"
				result="myResult"
				username="#local.username#"
				password="#local.password#">

			    <cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
				<cfhttpparam type="body" value="#serializeJSON(local.user)#">
			</cfhttp>

			<cfset local.messgeStruct = deserializeJSON(myresult.filecontent)>

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
						<!-- send invite to each group -->
						<cfhttp method="post" url="https://wellcoaches.learnupon.com/api/v1/group_invites"
							result="myResult"
							username="#local.username#"
							password="#local.password#">

						    <cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
							<cfhttpparam type="body" value="#serializeJSON(local.addUser)#">
						</cfhttp>

					</cfloop>

				</cfif>

				<h3>User invite was sent successfully!</h3>
				<cfabort>
			</cfif>

			<cfset local.id = deserializeJSON(myResult.filecontent).id>
		</cfif>


		<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/group_memberships?user_id=#local.id#"
			username="#local.username#"
			password="#local.password#"
			result="myGroups">
		</cfhttp>

		<cfset local.groups = deserializeJSON(myGroups.filecontent)>

		<cfset local.groupids = "" />

		<cfloop array="#local.groups['group']#" index="local.group">
			<cfset local.groupids = listAppend(local.groupids,local.group['id']) />
		</cfloop>

		<!-- assign the user to groups they should belong to -->
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
					<!--- this applies the newly created user to a group --->
					<cfhttp method="post" url="https://wellcoaches.learnupon.com/api/v1/group_memberships"
						result="myResult"
						username="#local.username#"
						password="#local.password#">

						<cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
						<cfhttpparam type="body"  value="#serializeJSON(local.groupMemberShip)#">
					</cfhttp>
				</cfif>	
			</cfloop>
		</cfif>

		<!--- get all groups --->
		<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/groups"
				result="Allgroups"
				username="#local.username#"
				password="#local.password#">
		</cfhttp>

		<cfset local.allgroups = "" />

		<cfloop array="#deserializeJSON(Allgroups.filecontent).groups#" index="local.group">
			<cfset local.allgroups = listappend(local.allgroups,local.group.id) />
		</cfloop>


		<cfset local.deleteUserFromGroup = "" />

		<!--- get list of ids user does not belong to --->
		<cfloop list="#local.allgroups#" index="local.currentid">
			<cfif !listFind(local.assignGroups,local.currentid)>
				<cfset local.deleteUserFromGroup = listAppend( local.deleteUserFromGroup,local.currentid) />
			</cfif>
		</cfloop>

		<!--- remove user from groups he doesn't belong to--->
	<cfloop list="#local.deleteUserFromGroup#" index="local.deletegroupid">

		<cfset local.deleteGroup =
			{"GroupMembership":
				{ 'group_id' : local.deletegroupid
				,'user_id' : local.id
				}
			}
		/>
		<!--- cfhttp method="delete" doesnt work for some reason, had to use this cfx tag--->
		<CFX_HTTP5
			url="https://wellcoaches.learnupon.com/api/v1/group_memberships/0"
			method="delete"
			user="#local.username#"
			pass="#local.password#"
			headers="Content-Type: application/json; charset=utf-8"
			body="#serializeJSON(local.deleteGroup)#"
			out="myResult"  >

	</cfloop>

		<cfset local.message = "User was added successfully to LearnUpon!">
		<cfif structKeyExists(url,'redirectFromCH')>
			<cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#URL.email#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" />
		</cfif>

<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


