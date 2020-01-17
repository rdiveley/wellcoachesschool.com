
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="ProductCategories">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductCategories">
	</cfinvoke>
</cfif>

<cfparam name="CategoryID" default=0>
<cfparam name="CategoryAction" default="List">
<cfparam name="CategoryName" default="">
<cfparam name="CategoryDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="CategoryPageName" default="homepage">
<cfparam name="CategoryImage" default="">
<cfparam name="ParentCatID" default="">

<cfif CategoryAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductCategories">
		<cfinvokeargument name="XMLFields" value="CAtegoryID,CategoryDescription,CategoryName,CategoryPageName,CategoryImage,ParentCatID">
		<cfinvokeargument name="XMLIDField" value="CategoryID">
		<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
	</cfinvoke>
	<cfset CategoryID=0>
	<cfset CategoryAction="List">
</cfif>
		
<cfif CategoryID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductCategories">
		<cfinvokeargument name="IDFieldName" value="CategoryID">
		<cfinvokeargument name="IDFieldValue" value="#CategoryID#">
	</cfinvoke>
	<cfoutput query="ProductCategories">
		<cfset CategoryName=#CategoryName#>
		<cfset DateCreated=#DateCreated#>
		<cfset tCategoryDescription=#CategoryDescription#>
		<cfset CategoryDescription=replace(#tCategoryDescription#,"~",",","ALL")>
		<cfset CategoryPageName=#CategoryPageName#>
		<cfset CategoryImage=#CategoryImage#>
		<cfset ParentCatID=#ParentCatID#>
	</cfoutput>
	<cfset CategoryAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Products\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.CategoryImage="images/Products/#image#">
	</cfif>
	<cfif #form.CategoryImage# is ''><cfset form.CategoryImage="none"></cfif>
	<cfset form.CategoryDescription=replace(#form.CategoryDescription#,",","~","ALL")>
	<Cfif #trim(form.CategoryDescription)# is ''><cfset form.CategoryDescription="none"></Cfif>
	<cfif #form.ParentCatID# is ''><cfset form.ParentCatID="none"></cfif>
	<cfif CategoryID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductCategories">
			<cfinvokeargument name="XMLFields" value="CategoryDescription,CategoryName,CategoryPageName,CategoryImage,ParentCatID">
		<cfinvokeargument name="XMLFieldData" value="#form.CategoryDescription#,#form.CategoryName#,#form.CategoryPageName#,#form.CategoryImage#,#form.ParentCatID#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
			<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductCategories">
			<cfinvokeargument name="XMLFields" value="CategoryDescription,CategoryName,CategoryPageName,CategoryImage,ParentCatID">
			<cfinvokeargument name="XMLFieldData" value="#form.CategoryDescription#,#form.CategoryName#,#form.CategoryPageName#,#form.CategoryImage#,#form.ParentCatID#">
			<cfinvokeargument name="XMLIDField" value="CategoryID">
		</cfinvoke>
	</cfif>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductCategories">
	</cfinvoke>
	<cfset TheFileExists="true">
	<cfset CategoryAction="list">
	<cfset CategoryName="">
	<cfset DateCreated = #now()#>
	<cfset CategoryID = 0>
	<cfset CategoryDescription=''>
	<cfset CategoryName=#CategoryName#>
	<cfset CategoryPageName='homepage'>
	<cfset CategoryImage=''>
	<cfset ParentCatID="none">
</cfif>

<cfoutput>
<h1>ProductCategories</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="CategoryID" value="#CategoryID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CategoryAction" value="#CategoryAction#">
<input type="hidden" name="CategoryImage" value="#CategoryImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Product Category Name: </TD>
    <TD>
	
		<INPUT type="text" name="CategoryName" value="#CategoryName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Product Category Description: </TD>
    <TD>
	
		<TEXTAREA name="CategoryDescription" cols=50 rows=5>#CategoryDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Product Category Logo: </TD>
    <TD>
		<input type="file" name="image"><br>#CategoryImage#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Category Status</td>
	<td>
	   	<cfif #CategoryPageName# is 1>
			<input type="radio" name="CategoryPageName" value="0"> Not Active<br>
			<input type="radio" name="CategoryPageName" value="1" checked>Active
		<cfelse>
			<input type="radio" name="CategoryPageName" value="0" checked> Not Active<br>
			<input type="radio" name="CategoryPageName" value="1">Active
		</cfif>
		</td>
	</tr>
	
	<cfif #TheFileExists# is "true">
		<tr>
		<td valign=top> If this is a sub-Category, please select the parent category</td>
		<td><select name="ParentCatID">
			<option value="0">None</option>
			<cfloop query="AllCategories">
				<option value="#AllCategories.CategoryID#" <cfif #ParentCatID# is #AllCategories.CategoryID#>selected</cfif>>#AllCategories.CategoryName#
			</cfloop>
			</select></td>
		</tr>
	<cfelse>
		<input type="hidden" name="ParentCatID" value="none">
	</cfif>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfif #TheFileExists# is "true">
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Categories</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Logo</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllCategories">
<tr>
<td><p>#CategoryID#</p></td>
<td><p>#CategoryName#</p></td>
<td><p><img src="../#CategoryImage#"></p></td>

<td><a href= "adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

