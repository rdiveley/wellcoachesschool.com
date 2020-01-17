<cfparam name="CategoryID" default=0>
<cfparam name="ForumCatAction" default="List">
<cfparam name="CatDescription" default="">
<cfparam name="CategoryName" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumCategories">
</cfinvoke>

<cfif ForumCatAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumCategories">
		<cfinvokeargument name="XMLFields" value="CategoryID,CatDescription,CategoryName">
		<cfinvokeargument name="XMLIDField" value="CategoryID">
		<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
	</cfinvoke>
	<cfset CategoryID=0>
	<cfset ForumCatAction="List">
</cfif>
		
<cfif CategoryID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ForumCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumCategories">
		<cfinvokeargument name="IDFieldName" value="CategoryID">
		<cfinvokeargument name="IDFieldValue" value="#CategoryID#">
	</cfinvoke>
	<cfoutput query="ForumCategories">
		<cfset CatDescription=#replace(CatDescription,"~",",","ALL")#>
		<cfset CategoryName=#replace(CategoryName,"~",",","ALL")#>
	</cfoutput>
	<cfset ForumCatAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.CatDescription=replace(#form.CatDescription#,",","~","ALL")>
	<cfset form.CategoryName=replace(#form.CategoryName#,",","~","ALL")>
	<cfif CategoryID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumCategories">
<cfinvokeargument name="XMLFields" value="CatDescription,CategoryName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.CatDescription)#,#XMLformat(form.CategoryName)#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
			<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumCategories">
			<cfinvokeargument name="XMLFields" value="CatDescription,CategoryName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.CatDescription)#,#XMLformat(form.CategoryName)#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
		</cfinvoke>
	</cfif>
	<cfset ForumCatAction="list">
	<cfset CategoryID = 0>
	<cfset CatDescription=''>
	<cfset CategoryName=''>
</cfif>

<cfoutput>
<h1>Discussion Forum Categories</h1>

<cfif ForumCatAction is "Add" or ForumCatAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="CategoryID" value="#CategoryID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ForumCatAction" value="#ForumCatAction#">
<TABLE>
	
	<TR>
	<TD valign="top"> CategoryName: </TD>
    <TD>
		<cfinput name="CategoryName" type="text" value="#CategoryName#" size="40" maxlength="100" required="yes" message="Please enter a Category Name">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Category Description: </TD>
    <TD>
	
		<textarea cols=40 rows=5 name="CatDescription">#CatDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif ForumCatAction is "list">

<a href="adminheader.cfm?Action=#Action#&ForumCatAction=Add">Add A Discussion Forum Category</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="ForumCategories">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllForumCategories">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ForumCategories">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Forum Categories</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Descripition</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllForumCategories">
		<tr>
		<td><p>#int(CategoryID)#</p></td>
		<td><p>#replace(CategoryName,"~",",","ALL")#</p></td>
		<td><p>#replace(CatDescription,"~",",","ALL")#</p></td>
		<td><a href= "adminheader.cfm?CategoryID=#CategoryID#&ForumCatAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CategoryID=#CategoryID#&ForumCatAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
