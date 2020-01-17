
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllCurrentForums">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFilename" value="CurrentForums">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumIcons">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFilename" value="ForumIcons">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumUsers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFilename" value="ForumUsers">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFilename" value="ForumNames">
</cfinvoke>

<cfparam name="ThreadID" default=0>
<cfparam name="ThreadAction" default="List">
<cfparam name="DateSubmitted" default="#now()#">
<cfparam name="Message" default="none">
<cfparam name="UserID" default="0">
<cfparam name="MessageIcon" default="0">
<cfparam name="ForumID" default="0">
<cfparam name="Subject" default="none">
<cfparam name="attachment" default="none">

<cfif ThreadAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFilename" value="ForumThreads">
		<cfinvokeargument name="XMLFields" value="ThreadID,Message,DateSubmitted,UserID,MessageIcon,ForumID,Subject,attachment">
		<cfinvokeargument name="XMLIDField" value="ThreadID">
		<cfinvokeargument name="XMLIDValue" value="#ThreadID#">
	</cfinvoke>
	<cfset ThreadID=0>
	<cfset ThreadAction="List">
</cfif>
		
<cfif ThreadID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ForumThreads">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFilename" value="ForumThreads">
		<cfinvokeargument name="IDFieldName" value="ThreadID">
		<cfinvokeargument name="IDFieldValue" value="#ThreadID#">
	</cfinvoke>
	<cfoutput query="ForumThreads">
		<cfset DateSubmitted=#DateSubmitted#>
		<cfset Message=#Message#>
		<cfset UserID=#UserID#>
		<cfset MessageIcon=#MessageIcon#>
		<cfset ForumID=#ForumID#>
		<cfset Subject=#Subject#>
		<cfset attachment=#attachment#>
	</cfoutput>
	<cfset ThreadAction="update">
</cfif>

<cfif isDefined('form.submit')>
		<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Forums\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="200"
			nameofimages="image"
			nameConflict="overwrite"
			accept="application/*"
			default="na">
		<cfset Form.attachment="images/Articles/#image#">
	</cfif>
	<cfif ThreadID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="ForumThreads">
			<cfinvokeargument name="XMLFields" value="Message,DateSubmitted,UserID,MessageIcon,ForumID,Subject,attachment">
		<cfinvokeargument name="XMLFieldData" value="#form.Message#,#form.DateSubmitted#,#form.UserID#,#form.MessageIcon#,#form.ForumID#,#form.Subject#,#form.attachment#">
			<cfinvokeargument name="XMLIDField" value="ThreadID">
			<cfinvokeargument name="XMLIDValue" value="#ThreadID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="ForumThreads">
			<cfinvokeargument name="XMLFields" value="Message,DateSubmitted,UserID,MessageIcon,ForumID,Subject,attachment">
		<cfinvokeargument name="XMLFieldData" value="#form.Message#,#form.DateSubmitted#,#form.UserID#,#form.MessageIcon#,#form.ForumID#,#form.Subject#,#form.attachment#">
			<cfinvokeargument name="XMLIDField" value="ThreadID">
		</cfinvoke>
	</cfif>
	<cfset ThreadAction="list">
	<cfset DateSubmitted="none">
	<cfset ThreadID = 0>
	<cfset Message='none'>
	<cfset UserID='none'>
	<cfset MessageIcon='homepage'>
	<cfset ForumID = 0>
	<cfset Subject='none'>
	<cfset attachment='none'>
</cfif>

<cfoutput>
<h1>Forum Threads</h1>

<cfif ThreadAction is "Add" or ThreadAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="ThreadID" value="#ThreadID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ThreadAction" value="#ThreadAction#">
<input type="hidden" name="attachment" value="#attachment#">
<TABLE>

	<TR>
	<TD valign="top"> Message Attachment: </TD>
    <TD>
	
		<INPUT type="file" name="image">
		<cfif #Attachment# neq "none"><br>#attachment#</cfif>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Subject: </TD>
    <TD>
	
		<input type="text" name="subject" size="40" maxlength="255" value="#Subject#">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top">The Message: </TD>
    <TD>
	
		<INPUT type="text" name="Message" value="#Message#" maxLength="250">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Message Icon: </TD>
    <TD>
		<select name="MessageIcon">
			<option value="0">None</option>
	   	<cfloop query="AllForumIcons">
			<option value="#IconID#" <cfif #MessageIcon# is #IconID#>selected</cfif>>#IconName#</option>
		</cfloop>
		</select>
		
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> Forum this thread belongs to: </TD>
    <TD>
		<select name="ForumID">
			<option value="0">None</option>
	   	<cfloop query="AllCurrentForums">
			<cfquery name="GetForumName" dbtype="query">
				select forumname from allforumnames
				where NameID='#CurrentNameID#'
			</cfquery>
			<option value="#CurrentForumID#" <cfif #ForumID# is #CurrentForumID#>selected</cfif>>#GetForumName.forumname#</option>
		</cfloop>
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>
	

	<TR>
	<TD valign="top"> Message Submitter: </TD>
    <TD>
		<select name="UserID">
			<option value="0">None</option>
	   	<cfloop query="AllForumUsers">
			<option value="#ForumUserID#" <cfif #UserID# is #ForumUserID#>selected</cfif>>#ForumUserName#</option>
		</cfloop>
		</select>
		<INPUT type="text" name="UserID" value="#UserID#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> Date/Time Submitted: </TD>
    <TD>
	
		<INPUT type="DateSubmitted" name="DateSubmitted" value="#dateformat(DateSubmitted,'mm/dd/yyyy')# #timeformat(DateSubmitted,'HH:mm')#" maxLength="15"><br>This is a 24 hour clock
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</cfif>
</CFOUTPUT>

<cfif ThreadAction is "list">

	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="Filename" value="ForumThreads">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllForumThreads">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="ForumThreads">
		</cfinvoke>
	
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Forum Threads</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>User</p></td>
	<td><p>Date/Time Submitted</p></td>
	<td><p>Belongs to</p></td>
	<td><p>Attachment</p></td>
	<td><p>Actions</p></td>
	</tr>
	<cf_nextrecords Records="#AllForumThreads.RecordCount#"
			 ThisPageName="adminheader.cfm"
			 RecordsToDisplay="25"
			 DisplayText="Record"
			 DisplayFont="Arial"
			 FontSize=2
			 UseBold="Yes"
			 ExtraURL="&action=#action#">
	<cfoutput query="AllForumThreads" StartRow=#SR# MaxRows=#RecordsToDisplay#>
	<tr>
	<td><p>#int(ThreadID)#</p></td>
	<td><p>#userid#</p></td>
	<td><p>#dateformat(DateSubmitted,'mm/dd/yyyy')# #timeformat(DateSubmitted,'hh:mm tt')#</p></td>
	<td><p><img src="../#attachment#"></p></td>
	
	<td><a href= "adminheader.cfm?ThreadID=#ThreadID#&ThreadAction=Edit&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ThreadID=#ThreadID#&ThreadAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

