
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfparam name="TypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="password" default="none">
<cfparam name="Description" default="none">
<cfparam name="username" default="none">
<cfparam name="TypePageName" default="homepage">
<cfparam name="NoOfArticleTypes" default="0">
<cfparam name="Summary" default="none">
<cfparam name="filename" default="none">
<cfparam name="listingtype" default="1">

<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ArticleTypes">
		<cfinvokeargument name="XMLFields" value="TypeID,Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingtype">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ArticleTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ArticleTypes">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="ArticleTypes">
		<cfset password=#password#>
		<cfset Description=#Description#>
		<cfset username=#username#>
		<cfset TypePageName=#replace(TypePageName,"~",",","ALL")#>
		<cfset NoOfArticleTypes=#NoOfArticleTypes#>
		<cfset Summary=#replace(Summary,"~",",","ALL")#>
		<cfset filename=#filename#>
		<cfset ListingType=#listingtype#>
	</cfoutput>
	<cfset TypeAction="update">
</cfif>

<cfif isDefined('form.submit')>
		<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Articles\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="200"
			nameofimages="image"
			nameConflict="overwrite"
			accept="application/*"
			default="na">
		<cfset Form.filename="images/Articles/#image#">
	</cfif>
	<cfset form.summary=replace(#form.summary#,",","~","ALL")>
	<cfset form.TypePageName=replace(#form.TypePageName#,",","~","ALL")>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ArticleTypes">
			<cfinvokeargument name="XMLFields" value="Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingtype">
		<cfinvokeargument name="XMLFieldData" value="#form.Description#,#form.password#,#form.username#,#form.TypePageName#,#form.NoOfArticleTypes#,#form.Summary#,#form.filename#,#form.listingtype#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ArticleTypes">
			<cfinvokeargument name="XMLFields" value="Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingtype">
		<cfinvokeargument name="XMLFieldData" value="#form.Description#,#form.password#,#form.username#,#form.TypePageName#,#form.NoOfArticleTypes#,#form.Summary#,#form.filename#,#form.listingtype#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
	</cfif>
	<cfset TypeAction="list">
	<cfset password="none">
	<cfset TypeID = 0>
	<cfset Description='none'>
	<cfset username='none'>
	<cfset TypePageName='homepage'>
	<cfset NoOfArticleTypes = 0>
	<cfset Summary='none'>
	<cfset filename='none'>
	<cfset listingtype=1>
</cfif>

<cfoutput>
<h1>Article Categories</h1>

<cfif TypeAction is "Add" or TypeAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<input type="hidden" name="filename" value="#filename#">
<TABLE>

	<TR>
	<TD valign="top"> Upload an image for this Article Category: </TD>
    <TD>
	
		<INPUT type="file" name="image"><br>
		#Filename#
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Category Name: </TD>
    <TD>
	
		<INPUT type="text" name="Description" value="#Description#" maxLength="250">
		
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> No. of Articles in this Category: </TD>
    <TD>
	
		<INPUT type="text" name="NoOfArticleTypes" value="#NoOfArticleTypes#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Select Page to View this Article Type on: </TD>
    <TD>
		<select name="TypePageName" multiple>
			<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #listfind(TypePageName,pagename)#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		
	</TD>
	</TR>
	
	<tr><td colspan=2>If you are allowing others to enter Articles in this category, please enter the username and password that will allow entry to those who will be allowed to enter Articles</td></tr>
	<TR>
	<TD valign="top"> User Name: </TD>
    <TD>
	
		<INPUT type="text" name="username" value="#username#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> Password: </TD>
    <TD>
	
		<INPUT type="Password" name="Password" value="#Password#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Brief Description that will show on the listing page: </TD>
    <TD>
		<textarea name="summary" cols=35 rows=5>#summary#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td>Listing Type for Articles:<br></td>
	  <td><cfif #listingType# is 1><input type="radio" name="listingType" value="1" checked> Continuous List <input type="radio" name="ListingType" value="0"> with Pagination<cfelse><input type="radio" name="listingType" value="1"> Continuous List <input type="radio" name="ListingType" value="0" checked> with pagination</cfif></td>
	</tr><tr>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</cfif>
</CFOUTPUT>

<cfif TypeAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&TypeAction=Add">Add A New Article Category</a></cfoutput>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="ArticleTypes">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllArticleTypes">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ArticleTypes">
			<cfinvokeargument name="OrderByStatement" value=" order by Description">
		</cfinvoke>
		<Cfif not isdefined('AllArticleTypes.listingtype')>
			<cfset records=queryNew("TypeID,Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingtype")>
			<cfloop query="AllArticleTypes">
				<CFSET newRow  = QueryAddRow(records, 1)>
				<CFSET temp = QuerySetCell(records, "TypeID","#TypeID#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "Description","#Description#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "password","#password#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "username","#username#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "TypePageName","#TypePageName#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "NoOfArticleTypes","#NoOfArticleTypes#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "Summary","#Summary#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "filename","#filename#", #newRow#)>
				<CFSET temp = QuerySetCell(records, "listingtype","1", #newRow#)>
			</cfloop>
			<cfwddx action="cfml2wddx"
				input="#Records#"
				output="NewRecords">
			
			<cffile action="WRITE" file="#application.uploadpath#\files\ArticleTypes.xml" 
				output="#NewRecords#" addnewline="No">
		</Cfif>
	<table border="1" align="CENTER">
	<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Your Article Categories</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>## of Articles</p></td>
	<td><p>Page to Show On</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllArticleTypes">
	<tr>
	<td><p>#TypeID#</p></td>
	<td><p>#description#</p></td>
	<td><p>#NoOfArticleTypes#</p></td>
	<td><p>#TypePageName#</p></td>
	
	<td><a href= "adminheader.cfm?TypeID=#TypeID#&TypeAction=Edit&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#')">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

