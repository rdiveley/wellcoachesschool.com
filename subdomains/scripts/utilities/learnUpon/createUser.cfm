<cfinclude template="credentials.cfm">
<!--  86550 = Lifestyle Medicine for Coaching -->
<!--  92767 = NBC-HWC Exam Preparation 2018 -->

<cfset local.tagsToFind = "1382,123,456,789,1011">
<cfset local.group_id = 86550> <!-- Lifestyle Medicine for Coaching -->

<cfset local.86650 = {} />
<cfloop list="#local.tagsToFind#" index="local.tag">
	<cfset local.86650['#local.tag#'] = '' >
</cfloop>
<cfdump var="#local.86650#" label="cgi" abort="true" />



	<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
	<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
	<cfset selectedFieldsArray[4] = "Password">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

       <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult1">
			<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        	<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
       </cfhttp>

	 <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

	<cfset local.userInfo = theData2['Params'][1][1]>

	<!-- get their tags -->
	<cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Groups">

    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]='(int)#local.userInfo["Id"]#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">

    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
		<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#result.Filecontent#"
            returnvariable="theData">

   <cfset local.tagList =  theData.Params[1]['Groups'] />


	<!-- 1382 = Wellcoaches Operations Team, find the tag we are looking for in the users list of tags -->
	<cfset local.foundTag = false>

	<!-- loop all the tags to find and see if the user has that tag, if so create the account -->
	<cfloop list="#local.tagsToFind#" index="local.tag">
		<cfif listFind(local.tagList, local.tag)>
			<cfset local.foundTag = true>
			<cfbreak />
		</cfif>
	</cfloop>

	<!-- if we find the tag, create the user -->
	<cfif local.foundTag>

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

		<!-- this creates the user -->
		<cfhttp method="post" url="https://wellcoaches.learnupon.com/api/v1/users"
			result="myResult"
			username="#local.username#"
			password="#local.password#">

		    <cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
			<cfhttpparam type="body" value="#serializeJSON(local.user)#">

		</cfhttp>

		<cfset local.id = deserializeJSON(myResult.filecontent).id>

		<cfset local.groupMemberShip =
			{"GroupMembership":
				{ 'group_id' : local.group_id
				 ,'user_id' : local.id
				}
			}
		/>
		<!-- this applies the newly created user to a group -->
		<cfhttp method="post" url="https://wellcoaches.learnupon.com/api/v1/group_memberships"
			result="myResult"
			username="#local.username#"
			password="#local.password#">

		    <cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
			<cfhttpparam type="body"  value="#serializeJSON(local.groupMemberShip)#">

		</cfhttp>

		<cfset local.message = "User was added successfully to LearnUpon and belongs to Group Lifestyle Medicine for Coaching">
	<cfelse>
		<cfset local.message = "User did not have the proper Tag and therefore was not created or assinged to a group">
	</cfif>


<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


