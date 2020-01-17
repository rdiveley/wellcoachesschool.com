<cfparam name="PollID" default=0>
<cfparam name="PollAction" default="List">
<cfparam name="PollQuestion" default="">
<cfparam name="PollName" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPolls">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Polls">
</cfinvoke>

<cfif PollAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Polls">
		<cfinvokeargument name="XMLFields" value="PollID,PollQuestion,PollName">
		<cfinvokeargument name="XMLIDField" value="PollID">
		<cfinvokeargument name="XMLIDValue" value="#PollID#">
	</cfinvoke>
	<cfset PollID=0>
	<cfset PollAction="List">
</cfif>
		
<cfif PollID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Polls">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Polls">
		<cfinvokeargument name="IDFieldName" value="PollID">
		<cfinvokeargument name="IDFieldValue" value="#PollID#">
	</cfinvoke>
	<cfoutput query="Polls">
		<cfset PollQuestion=#replace(PollQuestion,"~",",","ALL")#>
		<cfset PollName=#replace(PollName,"~",",","ALL")#>
	</cfoutput>
	<cfset PollAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.PollQuestion=replace(#form.PollQuestion#,",","~","ALL")>
	<cfset form.PollName=replace(#form.PollName#,",","~","ALL")>
	<cfif PollID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Polls">
<cfinvokeargument name="XMLFields" value="PollQuestion,PollName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.PollQuestion)#,#XMLformat(form.PollName)#">
			<cfinvokeargument name="XMLIDField" value="PollID">
			<cfinvokeargument name="XMLIDValue" value="#PollID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Polls">
			<cfinvokeargument name="XMLFields" value="PollQuestion,PollName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.PollQuestion)#,#XMLformat(form.PollName)#">
			<cfinvokeargument name="XMLIDField" value="PollID">
		</cfinvoke>
	</cfif>
	<cfset PollAction="list">
	<cfset PollID = 0>
	<cfset PollQuestion=''>
	<cfset PollName=''>
</cfif>
<cfoutput> 
  <h1>Polls</h1>
  <cfif PollAction is "Add" or PollAction is "Update">
    <cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
      <input type="hidden" name="PollID" value="#PollID#">
      <input type="hidden" name="Action" value="#Action#">
      <input type="hidden" name="PollAction" value="#PollAction#">
      <TABLE>
        <TR> 
          <TD valign="top"> Name: </TD>
          <TD> <cfinput name="PollName" type="text" value="#PollName#" size="40" maxlength="100" required="yes" message="Please enter a Category Name"> 
          </TD>
          <!--- field validation --->
        </TR>
        <TR> 
          <TD valign="top"> Question: </TD>
          <TD> <textarea cols=40 rows=5 name="PollQuestion">#PollQuestion#</textarea> 
          </TD>
          <!--- field validation --->
        </TR>
      </TABLE>
      <!--- form buttons --->
      <INPUT type="submit" name="submit" value="    OK    ">
    </cffORM>
  </cfif><cfif PollAction is "list">
  <a href="adminheader.cfm?Action=#Action#&PollAction=Add">Add 
  A Poll</a><br>
  <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
    <cfinvokeargument name="FileName" value="Polls">
    <cfinvokeargument name="ThisPath" value="files">
  </cfinvoke><cfif #TheFileExists# is "true">
  <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPolls">
    <cfinvokeargument name="ThisPath" value="files">
    <cfinvokeargument name="ThisFileName" value="Polls">
  </cfinvoke>
  <p>This is where you enter the poll question and the possible choices that your 
  ad participants can select.</p>
  <p>Once the poll is entered, you'll see it listed at the bottom of this page, 
    and you can edit the poll questions and/or responses, or delete the poll from 
    your web site completely.</p>
  <p>Clicking &quot;View Results&quot; will show you the poll responses entered 
    by visitors to your ad.<br>
  </p>
  <table border="1" align="CENTER">
    <th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Polls</p></th>
    <tr> 
      <td><p>ID</p></td>
      <td><p>Name</p></td>
      <td><p>Question</p></td>
      <td><p>Actions</p></td>
    </tr>
    <cfloop query="AllPolls">
      <tr> 
        <td><p>#int(PollID)#</p></td>
        <td><p>#replace(PollName,"~",",","ALL")#</p></td>
        <td><p>#replace(PollQuestion,"~",",","ALL")#</p></td>
        <td><a href= "adminheader.cfm?PollID=#PollID#&PollAction=Edit&&action=#action#">Edit</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?PollID=#PollID#&PollAction=Delete&action=#action#">Delete</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?PollQuestionID=#PollID#&action=PollAnswers">Answers</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?PollQuestionID=#PollID#&action=PollResults">Results</a></td>
      </tr>
    </cfloop></cfif></cfif>
  </table>
</cfoutput>