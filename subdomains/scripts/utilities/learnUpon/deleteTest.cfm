
<cfinclude template="credentials.cfm">
<cfset local.user =
					{"User": {    'last_name' : 'Diveley-2'
								, 'first_name' : 'Raymond'
								, 'email' : 'rdiveley@hotmail.com'
								, 'password' : "PooKie*95!"
								, 'language' : 'en'
								, 'membership_type' : 'Learner'
							}
					}
			/>

			<!--- this creates the user  --->
			<cfset local.user = serializeJSON(local.user) />

			<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
				arguments = '-u 011073a0763e9b439509:a511a727948adedc512f9251240f46s -X POST https://wellcoaches.learnupon.com/api/v1/users -H "Content-Type: application/json" -d #ReplaceNoCase(local.user,'"','\"','all')# '
				variable="myResult"
				timeout = "200">
			</cfexecute>

			<!--- CFDUMP: Debugging by rdiveley --->
<cfdump var="#myResult#" abort="true" format="html" output="" top="3">
