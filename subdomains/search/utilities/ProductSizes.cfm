
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="SizeID" default=0>
<cfparam name="SizeAction" default="List">
<cfparam name="SizeName" default="">
<cfparam name="SizeDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PriceAdjustment" default="0">
<cfparam name="SizeImage" default="">

<cfif SizeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductSizes">
		<cfinvokeargument name="XMLFields" value="SizeID,SizeDescription,SizeName,DateCreated,PriceAdjustment,SizeImage">
		<cfinvokeargument name="XMLIDField" value="SizeID">
		<cfinvokeargument name="XMLIDValue" value="#SizeID#">
	</cfinvoke>
	<cfset SizeID=0>
	<cfset SizeAction="List">
</cfif>
		
<cfif SizeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductSizes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductSizes">
		<cfinvokeargument name="IDFieldName" value="SizeID">
		<cfinvokeargument name="IDFieldValue" value="#SizeID#">
	</cfinvoke>
	<cfoutput query="ProductSizes">
		<cfset SizeName=#SizeName#>
		<cfset DateCreated=#DateCreated#>
		<cfset SizeDescription=#SizeDescription#>
		<cfset PriceAdjustment=#PriceAdjustment#>
		<cfset SizeImage=#SizeImage#>
	</cfoutput>
	<cfset SizeAction="update">
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
		<cfset Form.SizeImage="images/Products/#image#">
	</cfif>
	<cfif #form.SizeImage# is ''><cfset form.SizeImage="none"></cfif>
	<cfif SizeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductSizes">
			<cfinvokeargument name="XMLFields" value="SizeDescription,SizeName,DateCreated,PriceAdjustment,SizeImage">
		<cfinvokeargument name="XMLFieldData" value="#form.SizeDescription#,#form.SizeName#,#form.DateCreated#,#form.PriceAdjustment#,#form.SizeImage#">
			<cfinvokeargument name="XMLIDField" value="SizeID">
			<cfinvokeargument name="XMLIDValue" value="#SizeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductSizes">
			<cfinvokeargument name="XMLFields" value="SizeDescription,SizeName,DateCreated,PriceAdjustment,SizeImage">
			<cfinvokeargument name="XMLFieldData" value="#form.SizeDescription#,#form.SizeName#,#form.DateCreated#,#form.PriceAdjustment#,#form.SizeImage#">
			<cfinvokeargument name="XMLIDField" value="SizeID">
		</cfinvoke>
	</cfif>
	<cfset SizeAction="list">
	<cfset SizeName="">
	<cfset DateCreated = #now()#>
	<cfset SizeID = 0>
	<cfset SizeDescription=''>
	<cfset SizeName=#SizeName#>
	<cfset PriceAdjustment='0'>
	<cfset SizeImage=''>
</cfif>

<cfoutput>
<h1>ProductSizes</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="SizeID" value="#SizeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="SizeAction" value="#SizeAction#">
<input type="hidden" name="SizeImage" value="#SizeImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Size Name: </TD>
    <TD>
	
		<INPUT type="text" name="SizeName" value="#SizeName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Size Description: </TD>
    <TD>
	
		<TEXTAREA name="SizeDescription" cols=50 rows=5>#SizeDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Size Image: </TD>
    <TD>
		<input type="file" name="image"><br>#SizeImage#

		
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
		<cfinvokeargument name="FileName" value="ProductSizes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllSizes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductSizes">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Sizes</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Adj</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllSizes">
<tr>
<td><p>#SizeID#</p></td>
<td><p>#SizeName#</p></td>
<td><p>#dollarformat(PriceAdjustment)#</p></td>
<td><p><img src="../#SizeImage#"></p></td>

<td><a href= "adminheader.cfm?SizeID=#SizeID#&SizeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SizeID=#SizeID#&SizeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

