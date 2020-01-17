<cfinclude template="credentials.cfm">
<cfhttp method="get" url="https://wellcoaches.learnupon.com/api/v1/enrollments/search?email=#URL.email#"
	result="myResult"
	username="#local.username#"
	password="#local.password#">
</cfhttp>

<cfset local.courses = deserializeJSON(myResult.filecontent).enrollments />
<!--- CFDUMP: Debugging by rdiveley
<cfdump var="#local.courses#" abort="false" format="html" output="" top="3">
 --->
 <cfoutput>
	<table border="1">
		<th>Course name</th>
		<th>Date Completed</th>
	<cfloop array="#local.courses#" index="local.course">
		<tr>
			<td>#local.course['course_name']#</td>
			<td>
				<cfif structKeyExists(local.course,'date_completed')>
					#DateFormat(local.course['date_completed'],'mm/dd/yyyy')#
				<cfelse>
					-	
				</cfif>
			</td>
		</tr>
		

	</cfloop>
</table>
</cfoutput>