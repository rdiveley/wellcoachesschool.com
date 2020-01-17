<cfparam name="CategoryID" default=0>
<cfparam name="CategoryAction" default="List">
<cfparam name="ShowOnPage" default="none">
<cfparam name="CatDescription" default="none">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="DateLastViewed" default="">
<cfparam name="NoOfLinks" default="0">
<cfparam name="Banner" default="none">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllLinkCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="LinkCategories">
	<cfinvokeargument name="OrderbyStatement" value=" order by catdescription">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfif CategoryAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="LinkCategories">
		<cfinvokeargument name="XMLFields" value="CategoryID,DateCreated,ShowOnPage,CatDescription,DateLastViewed,NoOfLinks,Banner">
		<cfinvokeargument name="XMLIDField" value="CategoryID">
		<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
	</cfinvoke>
	<cfset CategoryID=0>
	<cfset CategoryAction="List">
</cfif>
		
<cfif CategoryID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="LinkCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="LinkCategories">
		<cfinvokeargument name="IDFieldName" value="CategoryID">
		<cfinvokeargument name="IDFieldValue" value="#CategoryID#">
	</cfinvoke>
	<cfoutput query="LinkCategories">
		<cfset ShowOnPage=#ShowOnPage#>
		<cfset DateCreated=#DateCreated#>
		<cfset CatDescription=#replace(CatDescription,"~",",","ALL")#>
		<cfset DateLastViewed=#DateLastViewed#>
		<cfset NoOfLinks=#NoOfLinks#>
		<cfset Banner=#Banner#>
	</cfoutput>
	<cfset CategoryAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.CatDescription=#replace(form.CatDescription,",","~","ALL")#>
	<cfif #form.DateLastViewed# is ''><cfset form.DateLastViewed="none"></cfif>
	<Cfset form.showonpage=replace(#form.showonpage#,",","~","ALL")>
		<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Links\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.Banner="images/Links/#image#">
	</cfif>
	<cfif #form.Banner# is ''><cfset form.Banner="none"></cfif>
	<cfif CategoryID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="LinkCategories">
			<cfinvokeargument name="XMLFields" value="DateCreated,ShowOnPage,CatDescription,DateLastViewed,NoOfLinks,Banner">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.ShowOnPage#,#form.CatDescription#,#form.DateLastViewed#,#form.NoOfLinks#,#form.Banner#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
			<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="LinkCategories">
			<cfinvokeargument name="XMLFields" value="DateCreated,ShowOnPage,CatDescription,DateLastViewed,NoOfLinks,Banner">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.ShowOnPage#,#form.CatDescription#,#form.DateLastViewed#,#form.NoOfLinks#,#form.Banner#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
		</cfinvoke>
	</cfif>
	<cfset CategoryAction="list">
	<cfset ShowOnPage="homepage">
	<cfset DateCreated = #now()#>
	<cfset CategoryID = 0>
	<cfset CatDescription='none'>
	<cfset DateLastViewed=''>
	<cfset NoOfLinks='0'>
	<cfset Banner="none">
</cfif>

<cfoutput>
<h1>Link Categories</h1>

<cfif CategoryAction is "Add" or CategoryAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="CategoryID" value="#CategoryID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CategoryAction" value="#CategoryAction#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="DateLastViewed" value="#DateLastViewed#">
<input type="hidden" name="Banner" value="#Banner#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date Created: </TD>
    <TD>
	
		#dateformat(DateCreated,'mm/dd/yyyy')#
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date Last Viewed: </TD>
    <TD>
		<cfif DateLastViewed is "none">
		<cfelse>
		#dateformat(DateLastViewed,'mm/dd/yyyy')#
		</cfif>
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Category Image: </TD>
    <TD>
		<input type="file" name="image"><br>
		<cfif #Banner# neq "none">Editing: #Banner#</cfif>
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> List Description: </TD>
    <TD>
	
		<INPUT type="text" name="CatDescription" value="#CatDescription#" size="50" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
		<tr>
	<td valign=top> Select Page Category will show on</td>
	<td><select name="ShowOnPage" multiple>
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #listfindnocase(ShowOnPage,Pagename,"~")#>selected</cfif>>#Pagename#
		</cfloop>
		</select></td>
	</tr>
	
	<TR>
	<TD valign="top"> ## of Links in this category: </TD>
    <TD>
	
		<INPUT type="text" name="NoOfLinks" value="#NoOfLinks#" maxLength="25">
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</fORM>
</cfif>
</CFOUTPUT>

<cfif CategoryAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&CategoryAction=Add">Add A New Link Category</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="LinkCategories">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllLinkCategories">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="LinkCategories">
			<cfinvokeargument name="OrderbyStatement" value=" order by catdescription">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Link Categories</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Description</p></td>
	<td><p>Date Created</p></td>
	<td><p>Date Last Viewed</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllLinkCategories">
	<tr>
	<td><p>#CategoryID#</p></td>
	<td><p>#CatDescription#</p></td>
	<td><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p></td>
	<td><cfif #DateLastViewed# neq "none"><p>#dateformat(DateLastViewed,'mm/dd/yyyy')#</p><cfelse>&nbsp;</cfif></td>
	<td><a href= "adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

