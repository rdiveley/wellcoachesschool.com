<cfparam name="AnswerID" default=0>
<cfparam name="AnswerAction" default="List">
<cfparam name="PollQuestionID" default="">
<cfparam name="Answer" default="">
<cfparam name="Votes" default="0">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPollAnswers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="PollAnswers">
	<cfinvokeargument name="IDFieldName" value="PollQuestionID">
    <cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPolls">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Polls">
	<cfinvokeargument name="IDFieldName" value="pollID">
    <cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
</cfinvoke>

<cfif AnswerAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="PollAnswers">
		<cfinvokeargument name="XMLFields" value="AnswerID,PollQuestionID,Answer,Votes">
		<cfinvokeargument name="XMLIDField" value="AnswerID">
		<cfinvokeargument name="XMLIDValue" value="#AnswerID#">
	</cfinvoke>
	<cfset AnswerID=0>
	<cfset AnswerAction="List">
</cfif>
		
<cfif AnswerID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="PollAnswers">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="PollAnswers">
		<cfinvokeargument name="IDFieldName" value="AnswerID">
		<cfinvokeargument name="IDFieldValue" value="#AnswerID#">
	</cfinvoke>
	<cfoutput query="PollAnswers">
		<cfset Answer=#replace(Answer,"~",",","ALL")#>
		<cfset Answer=replace(#Answer#,"`","'","ALL")>
		<cfset PollQuestionID=#PollQuestionID#>
		<cfset Votes=#Votes#>
	</cfoutput>
	<cfset AnswerAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.Answer=replace(#form.Answer#,",","~","ALL")>
	<cfset form.Answer=replace(#form.Answer#,"'","`","ALL")>
	<cfif AnswerID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="PollAnswers">
			<cfinvokeargument name="XMLFields" value="PollQuestionID,Answer,Votes">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.PollQuestionID#,#XMLformat(form.Answer)#,#form.Votes#">
			<cfinvokeargument name="XMLIDField" value="AnswerID">
			<cfinvokeargument name="XMLIDValue" value="#AnswerID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="PollAnswers">
			<cfinvokeargument name="ThisFileName" value="PollAnswers">
			<cfinvokeargument name="XMLFields" value="PollQuestionID,Answer,Votes">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.PollQuestionID#,#XMLformat(form.Answer)#,#form.Votes#">
			<cfinvokeargument name="XMLIDField" value="AnswerID">
		</cfinvoke>
	</cfif>
	<cfset AnswerAction="list">
	<cfset AnswerID = 0>
	<cfset PollQuestionID=#PollQuestionID#>
	<cfset Answer=''>
	<cfset Votes=0>
</cfif>

<cfoutput>
<h1>Poll Answers for "#AllPolls.PollQuestion#"</h1>

<cfif AnswerAction is "Add" or AnswerAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="AnswerID" value="#AnswerID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="AnswerAction" value="#AnswerAction#">
<input type="hidden" name="PollQuestionID" value="#PollQuestionID#">
<TABLE>
	
	<TR>
	<TD valign="top"> Answer: </TD>
    <TD>
		<cfinput name="Answer" type="text" value="#Answer#" size="40" maxlength="100" required="yes" message="Please enter an Answer">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Votes: </TD>
    <TD>
	
		<input type="text" name="Votes" value="#Votes#">
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif AnswerAction is "list">

<a href="adminheader.cfm?Action=#Action#&AnswerAction=Add&PollQuestionID=#PollQuestionID#">Add An Answer for "#AllPolls.PollQuestion#"</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="PollAnswers">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPollAnswers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="PollAnswers">
			<cfinvokeargument name="IDFieldName" value="PollQuestionID">
		    <cfinvokeargument name="IDFieldValue" value="#PollQuestionID#">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Poll Answers for "#AllPolls.PollQuestion#"</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Question</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllPollAnswers">
		<tr>
		<td><p>#int(AnswerID)#</p></td>
		<td><p>#replace(Answer,"~",",","ALL")#</p></td>
		<td><p>#replace(PollQuestionID,"~",",","ALL")#</p></td>
		<td><a href= "adminheader.cfm?AnswerID=#AnswerID#&AnswerAction=Edit&&action=#action#&PollQuestionID=#PollQuestionID#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?AnswerID=#AnswerID#&AnswerAction=Delete&action=#action#&PollQuestionID=#PollQuestionID#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
<a href="adminheader.cfm?Action=polls">Return to Polls</a><br>
</cfoutput>