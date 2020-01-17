<cfparam name="ForumUserID" default=0>
<cfparam name="ForumUserAction" default="List">
<cfparam name="ForumUserName" default="">
<cfparam name="ForumUserPassword" default="">
<cfparam name="AccessLevel" default="0">
<cfparam name="AccessForums" default="0">
<cfparam name="ForumUserEmail" default="">
<cfparam name="ForumUserFirst" default="">
<cfparam name="ForumUserLast" default="">
<cfparam name="ForumUserIP" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumUsers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumUsers">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumNames">
</cfinvoke>

<cfif ForumUserAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumUsers">
		<cfinvokeargument name="XMLFields" value="ForumUserID,ForumUserName,ForumUserPassword,AccessLevel,AccessForums,ForumUserEmail,ForumUserFirst,ForumUserLast,ForumUserIP">
		<cfinvokeargument name="XMLIDField" value="ForumUserID">
		<cfinvokeargument name="XMLIDValue" value="#ForumUserID#">
	</cfinvoke>
	<cfset ForumUserID=0>
	<cfset ForumUserAction="List">
</cfif>
		
<cfif ForumUserID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ForumUserPasswords">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumUsers">
		<cfinvokeargument name="IDFieldName" value="ForumUserID">
		<cfinvokeargument name="IDFieldValue" value="#ForumUserID#">
	</cfinvoke>
	<cfoutput query="ForumUserPasswords">
		<cfset ForumUserName=#ForumUserName#>
		<cfset ForumUserPassword=#ForumUserPassword#>
		<cfset AccessLevel=#AccessLevel#>
		<cfset AccessForums=#AccessForums#>
		<cfset ForumUserEmail=#ForumUserEmail#>
		<cfset ForumUserFirst=#ForumUserFirst#>
		<cfset ForumUserLast=#ForumUserLast#>
		<cfset ForumUserIP=#ForumUserIP#>
	</cfoutput>
	<cfset ForumUserAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.AccessForums=replace(#Form.AccessForums#,",","~","ALL")>
	<cfif form.ForumUserIP is ""><cfset Form.ForumUserID="none"></cfif>
	<cfif ForumUserID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumUsers">
			<cfinvokeargument name="XMLFields" 
			value="ForumUserName,ForumUserPassword,AccessLevel,AccessForums,ForumUserEmail,ForumUserFirst,ForumUserLast,ForumUserIP">
			<cfinvokeargument name="XMLFieldData" 
			value="#form.ForumUserName#,#form.ForumUserPassword#,#form.AccessLevel#,#form.AccessForums#,#form.ForumUserEmail#,#form.ForumUserFirst#,#form.ForumUserLast#,#form.ForumUserIP#">
			<cfinvokeargument name="XMLIDField" value="ForumUserID">
			<cfinvokeargument name="XMLIDValue" value="#ForumUserID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumUsers">
			<cfinvokeargument name="XMLFields" 
			value="ForumUserName,ForumUserPassword,AccessLevel,AccessForums,ForumUserEmail,ForumUserFirst,ForumUserLast,ForumUserIP">
			<cfinvokeargument name="XMLFieldData" 
			value="#form.ForumUserName#,#form.ForumUserPassword#,#form.AccessLevel#,#form.AccessForums#,#form.ForumUserEmail#,#form.ForumUserFirst#,#form.ForumUserLast#,#form.ForumUserIP#">
			<cfinvokeargument name="XMLIDField" value="ForumUserID">
		</cfinvoke>
	</cfif>
	<cfset ForumUserAction="list">
	<cfset ForumUserID = 0>
	<cfset ForumUserName=''>
	<cfset ForumUserPassword=''>
	<cfset AccessLevel="0">
	<cfset AccessForums="0">
	<Cfset ForumUserEmail="">
	<Cfset ForumUserFirst="">
	<Cfset ForumUserLast="">
	<Cfset ForumUserIP="">
</cfif>

<cfoutput>
<h1>Forum Users</h1>

<cfif ForumUserAction is "Add" or ForumUserAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="ForumUserID" value="#ForumUserID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ForumUserAction" value="#ForumUserAction#">
<TABLE>
	<TR>
	<TD valign="top"> First Name: </TD>
    <TD>
		<cfinput name="ForumUserFirst" type="text" value="#ForumUserFirst#" size="25" maxlength="50" required="yes" message="Please enter a First Name">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Last Name: </TD>
    <TD>
		<cfinput name="ForumUserLast" type="text" value="#ForumUserLast#" size="25" maxlength="50" required="yes" message="Please enter a Last Name">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> IP Address: </TD>
    <TD>
		<cfinput name="ForumUserIP" type="text" value="#ForumUserIP#" size="15" maxlength="20">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> User Email Address: </TD>
    <TD>
		<cfinput name="ForumUserEmail" type="text" value="#ForumUserEmail#" size="40" maxlength="250" required="yes" message="Please enter an Email Address">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> User Name: </TD>
    <TD>
		<cfinput name="ForumUserName" type="text" value="#ForumUserName#" size="15" maxlength="50" required="yes" message="Please enter a User Name">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Password: </TD>
    <TD>
		<cfinput name="ForumUserPassword" type="password" value="#ForumUserPassword#" size="15" maxlength="25" required="yes" message="Please enter a Password">
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<tr>
	<td valign=top> Access Level</td>
	<td><select name="AccessLevel">
	   	<option value="Administrator"<cfif #AccessLevel# is "Administrator"> selected</cfif>>Administrator</option>
		<option value="Moderator"<cfif #AccessLevel# is "Moderator"> selected</cfif>>Moderator</option>
		<option value="User"<cfif #AccessLevel# is "User"> selected</cfif>>User</option>
		</select></td>
	</tr>

	<tr>
	<td valign=top> If Moderator, moderator of which forums:</td>
	<td><select name="AccessForums" size="8" multiple>
		<option value="0"<cfif #AccessForums# is 0> selected</cfif>>None</option>
		<cfloop query="AllForumNames">
	   	<option value="#NameID#"<cfif #ListFind(AccessForums,NameID,"~")#> selected</cfif>>#forumName#</option>
		</cfloop>
		</select></td>
	</tr>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif ForumUserAction is "list">

<a href="adminheader.cfm?Action=#Action#&ForumUserAction=Add">Add A User</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="ForumUsers">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllForumUsers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumUsers">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Forum Users</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>User Name</p></td>
		<td><p>Email</p></td>
		<td><p>Access Level</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllForumUsers">
		<tr>
		<td><p>#int(ForumUserID)#</p></td>
		<td><p>#ForumUserFirst# #ForumUserLast#</p></td>
		<td><p>#ForumUserName#</p></td>
		<td><p>#ForumUserEmail#</p></td>
		<td><p>#AccessLevel#</p></td>
		<td><a href= "adminheader.cfm?ForumUserID=#ForumUserID#&ForumUserAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ForumUserID=#ForumUserID#&ForumUserAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
