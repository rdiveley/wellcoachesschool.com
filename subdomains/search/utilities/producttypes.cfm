
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="TypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="TypeName" default="">
<cfparam name="TypeDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="TypePageName" default="homepage">
<cfparam name="TypeImage" default="">

<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductTypes">
		<cfinvokeargument name="XMLFields" value="TypeID,TypeDescription,TypeName,DateCreated,TypePageName,TypeImage">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductTypes">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="ProductTypes">
		<cfset TypeName=#TypeName#>
		<cfset DateCreated=#DateCreated#>
		<cfset TypeDescription=#TypeDescription#>
		<cfset TypePageName=#TypePageName#>
		<cfset TypeImage=#TypeImage#>
	</cfoutput>
	<cfset TypeAction="update">
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
		<cfset Form.TypeImage="images/Products/#image#">
	</cfif>
	<cfif #form.TypeImage# is ''><cfset form.TypeImage="none"></cfif>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateCreated,TypePageName,TypeImage">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateCreated#,#form.TypePageName#,#form.TypeImage#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateCreated,TypePageName,TypeImage">
			<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateCreated#,#form.TypePageName#,#form.TypeImage#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
	</cfif>
	<cfset TypeAction="list">
	<cfset TypeName="">
	<cfset DateCreated = #now()#>
	<cfset TypeID = 0>
	<cfset TypeDescription=''>
	<cfset TypeName=#TypeName#>
	<cfset TypePageName='homepage'>
	<cfset TypeImage=''>
</cfif>

<cfoutput>
<h1>ProductTypes</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<input type="hidden" name="TypeImage" value="#TypeImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Product Type Name: </TD>
    <TD>
	
		<INPUT type="text" name="TypeName" value="#TypeName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Product Type Description: </TD>
    <TD>
	
		<TEXTAREA name="TypeDescription" cols=50 rows=5>#TypeDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Product Type Logo: </TD>
    <TD>
		<input type="file" name="image"><br>#TypeImage#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Page Product Type Description will show on</td>
	<td><select name="TypePageName">
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #TypePageName# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select></td>
	</tr>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="ProductTypes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllProductTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductTypes">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Types</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Logo</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllProductTypes">
<tr>
<td><p>#TypeID#</p></td>
<td><p>#TypeName#</p></td>
<td><p><img src="../#TypeImage#"></p></td>

<td><a href= "adminheader.cfm?TypeID=#TypeID#&TypeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

