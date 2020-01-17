<cfparam name="PollQuestionID" default=0>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Polls">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Polls">
	<cfinvokeargument name="IDFieldName" value="PollID">
	<cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="GetPollAnswers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="PollAnswers">
	<cfinvokeargument name="IDFieldName" value="PollQuestionID">
	<cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="GetPollResults">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="PollResults">
	<cfinvokeargument name="IDFieldName" value="PollQuestionID">
	<cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
</cfinvoke>
<cfset TotalVotes=#GetPollResults.RecordCount#>	
<cfoutput>
<table cellspacing="0" cellpadding="1" width=50% bgcolor="##F5F5DC">
	<tr><td><b>#Polls.PollQuestion#</b></td></tr>
</cfoutput>
<cfoutput query="GetPollAnswers"> 
	<cfquery name="TotalResults" dbtype="query">
		select * from GetPollResults where AnswerID='#GetPollAnswers.AnswerID#'
	</cfquery>
	<cfif #TotalResults.Recordcount# gt 0>
		<cfset VoteTotal=#totalResults.RecordCount#>
		<cfset Rowcounter=0>
		<!--- the answers --->
		<!--- Get the next graphic --->
		<cfset RowCounter=RowCounter + 1>
		<cfif #RowCounter# is 7><cfset RowCounter=1></cfif>
		<cfif #TotalVotes# gt 0>
			<cfset width=#VoteTotal# / #totalVotes# * 100>
		<cfelse>
			<cfset width=1>
		</cfif>
		<tr>
		<td>#answer#</td>
		<td><img src="../images/bar#RowCounter#.gif" height="10" width="#width#"></td>
		<td align=right>&nbsp;&nbsp;#VoteTotal#</td>
		<td align=right>#Width#%</td>
		</tr>
	<cfelse>
		<cfset RowCounter=RowCounter + 1>
		<cfif #RowCounter# is 7><cfset RowCounter=1></cfif>
		<cfset Width=0>
		<td>#answer#</td>
		<td><img src="../images/bar#RowCounter#.gif" height="10" width="#width#"></td>
		<td align=right>&nbsp;&nbsp;#VoteTotal#</td>
		<td align=right>#Width#%</td>
		</tr>
	</cfif>	
</cfoutput>
<cfoutput>	<tr><td></td><td></td><td align=right>#TotalVotes#</td><td align=right>100%</td></tr>
</table></cfoutput>