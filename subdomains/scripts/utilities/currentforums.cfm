<cfparam name="CurrentForumID" default=0>
<cfparam name="CurrentForumAction" default="List">
<cfparam name="CurrentNameID" default="">
<cfparam name="CurrentCatID" default="">
<cfparam name="ShowOnPage" default="homepage">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllCurrentForums">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="CurrentForums">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="Pages">
	<cfinvokeargument name="ThisFileName" value="Pages">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumCategories">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumNames">
</cfinvoke>

<cfif CurrentForumAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="CurrentForums">
		<cfinvokeargument name="XMLFields" value="CurrentForumID,CurrentNameID,CurrentCatID,ShowOnPage">
		<cfinvokeargument name="XMLIDField" value="CurrentForumID">
		<cfinvokeargument name="XMLIDValue" value="#CurrentForumID#">
	</cfinvoke>
	<cfset CurrentForumID=0>
	<cfset CurrentForumAction="List">
</cfif>
		
<cfif CurrentForumID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="CurrentCatIDs">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="CurrentForums">
		<cfinvokeargument name="IDFieldName" value="CurrentForumID">
		<cfinvokeargument name="IDFieldValue" value="#CurrentForumID#">
	</cfinvoke>
	<cfoutput query="CurrentCatIDs">
		<cfset CurrentNameID=#CurrentNameID#>
		<cfset CurrentCatID=#CurrentCatID#>
		<cfset ShowOnPage=#ShowOnPage#>
	</cfoutput>
	<cfset CurrentForumAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif CurrentForumID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CurrentForums">
			<cfinvokeargument name="XMLFields" value="CurrentNameID,CurrentCatID,ShowOnPage">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.CurrentNameID#,#form.CurrentCatID#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="CurrentForumID">
			<cfinvokeargument name="XMLIDValue" value="#CurrentForumID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CurrentForums">
			<cfinvokeargument name="XMLFields" value="CurrentNameID,CurrentCatID,ShowOnPage">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.CurrentNameID#,#form.CurrentCatID#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="CurrentForumID">
		</cfinvoke>
	</cfif>
	<cfset CurrentForumAction="list">
	<cfset CurrentForumID = 0>
	<cfset CurrentNameID=''>
	<cfset CurrentCatID=''>
	<cfset ShowOnPage="homepage">
</cfif>

<cfoutput>
<h1>Current Forums</h1>

<cfif CurrentForumAction is "Add" or CurrentForumAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="CurrentForumID" value="#CurrentForumID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CurrentForumAction" value="#CurrentForumAction#">
<TABLE>
	
	<TR>
	<TD valign="top"> Category: </TD>
    <TD>
		<select name="CurrentCatID">
	   	<cfloop query="AllForumCategories">
			<option value="#CategoryID#" <cfif #CurrentCatID# is #CategoryID#>selected</cfif>>#CategoryName#
		</cfloop>
		</select>
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Name: </TD>
    <TD>
		<select name="CurrentNameID">
	   	<cfloop query="AllForumNames">
			<option value="#NameID#" <cfif #ShowOnPage# is #CurrentNameID#>selected</cfif>>#ForumName#
		</cfloop>
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Select Page This Forum will show on</td>
	<td><select name="ShowOnPage">
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ShowOnPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select></td>
	</tr>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif CurrentForumAction is "list">

<a href="adminheader.cfm?Action=#Action#&CurrentForumAction=Add">Add A Current Forum</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="CurrentForums">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCurrentForums">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CurrentForums">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Current Forums</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Category</p></td>
		<td><p>Forum</p></td>
		<td><p>For Page</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllCurrentForums">
		<tr>
		<cfquery name="GetCatName" dbtype="query">
			select CategoryName from AllForumCategories
			where CategoryID='#CurrentCatID#'
		</cfquery>
		<cfquery name="GetForumName" dbtype="query">
			select ForumName from AllForumNames
			where NameID='#CurrentNameID#'
		</cfquery>
		<td><p>#int(CurrentForumID)#</p></td>
		<td><p>#GetCatName.CategoryName#</p></td>
		<td><p>#GetForumName.ForumName#</p></td>
		<td><p>#ShowOnPage#</p></td>
		<td><a href= "adminheader.cfm?CurrentForumID=#CurrentForumID#&CurrentForumAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CurrentForumID=#CurrentForumID#&CurrentForumAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
