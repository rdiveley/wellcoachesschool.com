<cfinclude template="credentials.cfm">
<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/users/search?email=#URL.email#"
	result="myResult"
	username="#local.username#"
	password="#local.password#">
</cfhttp>

<cfset local.user = deserializeJSON(myResult.filecontent).user[1]>

<cfset local.id = local.user.id>

<cfset local.group_id = 86550> <!-- Lifestyle Medicine for Coaching -->

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
	username="011073a0763e9b439509"
	password="a511a727948adedc512f9251240f46">

    <cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8">
	<cfhttpparam type="body"  value="#serializeJSON(local.groupMemberShip)#">

</cfhttp>