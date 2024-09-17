<cfinclude template="credentials.cfm">
<!---  86550 = Lifestyle Medicine for Coaching --->
<!---  92767 = NBC-HWC Exam Preparation 2018 --->

<cfif structKeyExists(form,'email')>
	<cfset URL.email = FORM.email>
</cfif>


<!--- 1. add the group IDs here --->
<cfset local.group_id = "86550,92767">

<!--- 2. create the associated tags to the groups --->

<!--- tags for 86550 --->
<cfset local.LU86550_tags = "9523">
<!--- tags for 92767 --->
<cfset local.LU92767_tags = "9777">

<!--- creates the structure that holds the tags as the key to the structure named using LU{group} --->
<cfloop list="#local.group_id#" index="local.id">
	<cfset 'local.LU#local.id#' = {} />
	<cfloop list="#evaluate('local.LU'&local.id&'_tags')#" index="local.tag">
		<cfset local.LU[local.id][local.tag] = '' >
	</cfloop>
</cfloop>

	<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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

	    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
			<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
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
    <cfset myArray[2]=key>
    <cfset myArray[3]='(int)#local.userInfo["Id"]#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">

	<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result">
		<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
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

	<cfif listLen(local.assignGroups)>

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

			<cfset local.id = deserializeJSON(myResult.filecontent).id>
		</cfif>

		<!--- get all groups --->
		<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/groups"
				result="myResult"
				username="#local.username#"
				password="#local.password#">

		</cfhttp>

		<cfloop array="#deserializeJSON(myResult.filecontent).groups#" index="local.group">

			<cfset local.deleteGroup =

				{"GroupMembership":
					{ 'group_id' : local.group['id']
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


		<cfhttp url="https://wellcoaches.learnupon.com/api/v1/group_memberships/0" timeout="5"
		    method="DELETE" result="apiCall"
		    throwonerror="No"
		    username="#local.username#" password="#local.password#">
		    <cfhttpparam type="header" name="Accept" value="application/json" />
		    <cfhttpparam type="header" name="Content-Type" value="application/json" />
		    <cfhttpparam type="body"  value="#serializeJSON(local.deleteGroup)#">

		</cfhttp>

		<cfloop list="#local.assignGroups#" index="local.groupId">
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
		</cfloop>

		<cfset local.message = "User was added successfully to LearnUpon!">
	<cfelse>
		<cfset local.message = "User <strong>did not have</strong> the proper Tag and therefore was not created or assinged to a group">
	</cfif>


<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


