
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="StyleID" default=0>
<cfparam name="StyleAction" default="List">
<cfparam name="StyleName" default="">
<cfparam name="StyleDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PriceAdjustment" default="0">
<cfparam name="StyleImage" default="">

<cfif StyleAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductStyles">
		<cfinvokeargument name="XMLFields" value="StyleID,StyleDescription,StyleName,DateCreated,PriceAdjustment,StyleImage">
		<cfinvokeargument name="XMLIDField" value="StyleID">
		<cfinvokeargument name="XMLIDValue" value="#StyleID#">
	</cfinvoke>
	<cfset StyleID=0>
	<cfset StyleAction="List">
</cfif>
		
<cfif StyleID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductStyles">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductStyles">
		<cfinvokeargument name="IDFieldName" value="StyleID">
		<cfinvokeargument name="IDFieldValue" value="#StyleID#">
	</cfinvoke>
	<cfoutput query="ProductStyles">
		<cfset StyleName=#StyleName#>
		<cfset DateCreated=#DateCreated#>
		<cfset StyleDescription=#StyleDescription#>
		<cfset PriceAdjustment=#PriceAdjustment#>
		<cfset StyleImage=#StyleImage#>
	</cfoutput>
	<cfset StyleAction="update">
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
		<cfset Form.StyleImage="images/Products/#image#">
	</cfif>
	<cfif #form.StyleImage# is ''><cfset form.StyleImage="none"></cfif>
	<cfif StyleID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductStyles">
			<cfinvokeargument name="XMLFields" value="StyleDescription,StyleName,DateCreated,PriceAdjustment,StyleImage">
		<cfinvokeargument name="XMLFieldData" value="#form.StyleDescription#,#form.StyleName#,#form.DateCreated#,#form.PriceAdjustment#,#form.StyleImage#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
			<cfinvokeargument name="XMLIDValue" value="#StyleID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductStyles">
			<cfinvokeargument name="XMLFields" value="StyleDescription,StyleName,DateCreated,PriceAdjustment,StyleImage">
			<cfinvokeargument name="XMLFieldData" value="#form.StyleDescription#,#form.StyleName#,#form.DateCreated#,#form.PriceAdjustment#,#form.StyleImage#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
		</cfinvoke>
	</cfif>
	<cfset StyleAction="list">
	<cfset StyleName="">
	<cfset DateCreated = #now()#>
	<cfset StyleID = 0>
	<cfset StyleDescription=''>
	<cfset StyleName=#StyleName#>
	<cfset PriceAdjustment='0'>
	<cfset StyleImage=''>
</cfif>

<cfoutput>
<h1>ProductStyles</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="StyleID" value="#StyleID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="StyleAction" value="#StyleAction#">
<input type="hidden" name="StyleImage" value="#StyleImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Style Name: </TD>
    <TD>
	
		<INPUT type="text" name="StyleName" value="#StyleName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Style Description: </TD>
    <TD>
	
		<TEXTAREA name="StyleDescription" cols=50 rows=5>#StyleDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Style Image: </TD>
    <TD>
		<input type="file" name="image"><br>#StyleImage#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Price Adjustment </td>
	<td><input type="text" value="#PriceAdjustment#" name="PriceAdjustment"></td>
	</tr>
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="ProductStyles">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllStyles">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductStyles">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Styles</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Adj</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllStyles">
<tr>
<td><p>#StyleID#</p></td>
<td><p>#StyleName#</p></td>
<td><p>#dollarformat(PriceAdjustment)#</p></td>
<td><p><img src="../#StyleImage#"></p></td>

<td><a href= "adminheader.cfm?StyleID=#StyleID#&StyleAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?StyleID=#StyleID#&StyleAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

