<!-- get top level survey IDs -->
<cfhttp url="https://restapi.surveygizmo.com/v4/survey" result="myResult" method="get">
	<cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
	<cfhttpparam type="url"  value="status" name="filter[field][1]"/>
    <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
    <cfhttpparam type="url"  value="Launched" name="filter[value][1]"/>
</cfhttp>

<cfset local.jsonData = deserializeJSON(myResult.fileContent).data />
<!-- loop all surveyIDs and get the title and surveyLink -->
<cfoutput>
	<cfloop array="#local.jsonData#" index="local.data">
		<cfhttp url="https://restapi.surveygizmo.com/v4/survey/#local.data.id#" result="local.surveyDetails" method="get">
			<cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
		</cfhttp>
		<cfset local.details = deserializeJSON(local.surveyDetails.fileContent).data />
		<a href="#local.details['links']['campaign']#?email=rdiveley@wellcoaches.com">#local.details['title']#</a><br />
	</cfloop>
</cfoutput>