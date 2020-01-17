<cfparam name="NameID" default=0>
<cfparam name="ForumNameAction" default="List">
<cfparam name="NameDescription" default="">
<cfparam name="ForumName" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumNames">
</cfinvoke>

<cfif ForumNameAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumNames">
		<cfinvokeargument name="XMLFields" value="NameID,NameDescription,ForumName">
		<cfinvokeargument name="XMLIDField" value="NameID">
		<cfinvokeargument name="XMLIDValue" value="#NameID#">
	</cfinvoke>
	<cfset NameID=0>
	<cfset ForumNameAction="List">
</cfif>
		
<cfif NameID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ForumNames">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumNames">
		<cfinvokeargument name="IDFieldName" value="NameID">
		<cfinvokeargument name="IDFieldValue" value="#NameID#">
	</cfinvoke>
	<cfoutput query="ForumNames">
		<cfset NameDescription=#replace(NameDescription,"~",",","ALL")#>
		<cfset ForumName=#replace(ForumName,"~",",","ALL")#>
	</cfoutput>
	<cfset ForumNameAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.NameDescription=replace(#form.NameDescription#,",","~","ALL")>
	<cfset form.ForumName=replace(#form.ForumName#,",","~","ALL")>
	<cfif NameID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumNames">
<cfinvokeargument name="XMLFields" value="NameDescription,ForumName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.NameDescription)#,#XMLformat(form.ForumName)#">
			<cfinvokeargument name="XMLIDField" value="NameID">
			<cfinvokeargument name="XMLIDValue" value="#NameID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumNames">
			<cfinvokeargument name="XMLFields" value="NameDescription,ForumName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.NameDescription)#,#XMLformat(form.ForumName)#">
			<cfinvokeargument name="XMLIDField" value="NameID">
		</cfinvoke>
	</cfif>
	<cfset ForumNameAction="list">
	<cfset NameID = 0>
	<cfset NameDescription=''>
	<cfset ForumName=''>
</cfif>

<cfoutput>
<h1>Discussion Forum Names</h1>

<cfif ForumNameAction is "Add" or ForumNameAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="NameID" value="#NameID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ForumNameAction" value="#ForumNameAction#">
<TABLE>
	
	<TR>
	<TD valign="top"> Forum Name: </TD>
    <TD>
		<cfinput name="ForumName" type="text" value="#ForumName#" size="40" maxlength="100" required="yes" message="Please enter a Category Name">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<textarea cols=40 rows=5 name="NameDescription">#NameDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif ForumNameAction is "list">

<a href="adminheader.cfm?Action=#Action#&ForumNameAction=Add">Add A Discussion Forum Name</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="ForumNames">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllForumNames">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumNames">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Forum Names</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Descripition</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllForumNames">
		<tr>
		<td><p>#int(NameID)#</p></td>
		<td><p>#replace(ForumName,"~",",","ALL")#</p></td>
		<td><p>#replace(NameDescription,"~",",","ALL")#</p></td>
		<td><a href= "adminheader.cfm?NameID=#NameID#&ForumNameAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NameID=#NameID#&ForumNameAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
