

<cfset local.deleteGroup =
			{"GroupMembership":
				{ 'group_id' :270378
				,'user_id' : 3305186
				}
			}
		/>

        <cfset local.deleteGroup = serializeJSON(local.deleteGroup) />

    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
            arguments = '-X DELETE -H "Content-Type: application/json" --user 011073a0763e9b439509:a511a727948adedc512f9251240f46 -d #ReplaceNoCase(local.deleteGroup,'"','\"','all')#  https://wellcoaches.learnupon.com/api/v1/group_memberships/0'>
    </cfexecute>