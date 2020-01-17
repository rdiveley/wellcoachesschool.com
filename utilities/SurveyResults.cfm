<cfparam name="SurveyNameID" default=0>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Surveys">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Surveys">
	<cfinvokeargument name="IDFieldName" value="SurveyID">
	<cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
</cfinvoke>

<cfloop query="Surveys">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Questions">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
	<cfinvokeargument name="IDFieldName" value="SurveyNameID">
    <cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Results">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="SurveyResults">
	<cfinvokeargument name="IDFieldName" value="TheSurveyID">
	<cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
</cfinvoke>
	
<cfoutput><h2>#Surveys.SurveyName# Results</h2></cfoutput>
<table class=toptable bgcolor="#F5F5DC">
<cfset QuestionCounter=0>
<cfset GrandResponses=0>

<cfoutput query="Questions">
	<cfset QuestionCounter=#QuestionCounter# + 1>
	<cfset tQID=#QuestionID#>
	<cfset tQuestion=#trim(Question)#>
	<cfquery name="Responses" dbtype="query">
		select * from Results where surveyquestionid='#tQID#'
	</cfquery>

	<tr><td width=30%>#QuestionCounter# #tQuestion#:</td>
	<td width=70%>
	
	<cfloop query="Responses">
		<cfset Response=#Responses.SurveyAnswerID#>
		<cfif #questions.Answers# neq "none">
			<cfif isnumeric(#response#)>
				<cfset memberAnswer=listgetat(#questions.answers#,#response#,"~")>
			<cfelse>
				<cfset MemberAnswer=#Response#>
			</cfif>
		<cfelse>
			<cfset MemberAnswer="#Response#">
		</cfif>
		<cfset GrandResponses=#GrandResponses# + 1>
		<a href="adminheader.cfm?action=individualresults&MemberID=#MemberAnswer#&SurveyNameID=#SurveyNameID#" class=hidden>#responses.email#</a>: #MemberAnswer#</font><br>
	</cfloop>
	</td>
	</tr>
	
</cfoutput>
<cfoutput>
<tr><th>Total Responses:</th><tH>#GrandResponses#</tH></tr></cfoutput>
</table>
</cfloop>

</body>

</html>