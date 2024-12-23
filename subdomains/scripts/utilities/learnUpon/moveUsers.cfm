<cfsetting requesttimeout="600"> <!-- Set to 60 seconds -->

<cfinclude template="credentials.cfm">
<cfset local.apiKey = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093"> <!-- Replace with your actual API key -->
<cfset local.apiPassword = "a511a727948adedc512f9251240f46"> <!-- Replace with your actual API password -->
<cfset local.groupId = "124692"> <!-- Replace with your actual group ID -->
<cfset local.curlPath = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe">

<!-- Construct the API URL to fetch users from the group there are 6 pages for these user FYI 6th page ends at 179 -->
<cfset local.apiUrl = "https://wellcoaches.learnupon.com/api/v1/group_memberships?group_id=#local.groupId#&page=2">

<!-- Execute the curl command to get the users of the group -->
<cftry>
 

    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# #local.apiURl#"
			variable="myResult"
			timeout = "800">
		</cfexecute>
 
    <!--- Deserialize the JSON response --->
    <cfset local.responseData = deserializeJSON(myResult)>


    <!--- Check if the response contains user data --->
    <cfif structKeyExists(local.responseData, "user")>
        <cfoutput>
            <h3>List of Users in Group #local.groupId#:</h3>
            <ul>
                <cfset count = 1 />
            <cfloop array="#local.responseData.user#" index="local.user">

                <li>
                    #count++#
                    ID: #local.user.id# - #local.user.email#
                     
                   
                </li>

                <cfset local.groupMemberShip =
                        {"GroupMembership":
                            { 'group_id' : '894855'
                            ,'user_id' : local.user.id
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




            </cfloop>
            </ul>
        </cfoutput>
    <cfelse>
        <cfoutput>No users found for this group or an error occurred.</cfoutput>
    </cfif>

<cfcatch type="any">
    <cfoutput>An error occurred: #cfcatch.message#</cfoutput>
</cfcatch>
</cftry>
