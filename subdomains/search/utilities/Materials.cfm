
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="MaterialID" default=0>
<cfparam name="MaterialAction" default="List">
<cfparam name="MaterialName" default="">
<cfparam name="MaterialDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PriceAdjustment" default="0">
<cfparam name="MaterialImage" default="">

<cfif MaterialAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Materials">
		<cfinvokeargument name="XMLFields" value="MaterialID,MaterialDescription,MaterialName,DateCreated,PriceAdjustment,MaterialImage">
		<cfinvokeargument name="XMLIDField" value="MaterialID">
		<cfinvokeargument name="XMLIDValue" value="#MaterialID#">
	</cfinvoke>
	<cfset MaterialID=0>
	<cfset MaterialAction="List">
</cfif>
		
<cfif MaterialID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Materials">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Materials">
		<cfinvokeargument name="IDFieldName" value="MaterialID">
		<cfinvokeargument name="IDFieldValue" value="#MaterialID#">
	</cfinvoke>
	<cfoutput query="Materials">
		<cfset MaterialName=#MaterialName#>
		<cfset DateCreated=#DateCreated#>
		<cfset MaterialDescription=#MaterialDescription#>
		<cfset PriceAdjustment=#PriceAdjustment#>
		<cfset MaterialImage=#MaterialImage#>
	</cfoutput>
	<cfset MaterialAction="update">
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
		<cfset Form.MaterialImage="images/Products/#image#">
	</cfif>
	<cfif #form.MaterialImage# is ''><cfset form.MaterialImage="none"></cfif>
	<cfif MaterialID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Materials">
			<cfinvokeargument name="XMLFields" value="MaterialDescription,MaterialName,DateCreated,PriceAdjustment,MaterialImage">
		<cfinvokeargument name="XMLFieldData" value="#form.MaterialDescription#,#form.MaterialName#,#form.DateCreated#,#form.PriceAdjustment#,#form.MaterialImage#">
			<cfinvokeargument name="XMLIDField" value="MaterialID">
			<cfinvokeargument name="XMLIDValue" value="#MaterialID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Materials">
			<cfinvokeargument name="XMLFields" value="MaterialDescription,MaterialName,DateCreated,PriceAdjustment,MaterialImage">
			<cfinvokeargument name="XMLFieldData" value="#form.MaterialDescription#,#form.MaterialName#,#form.DateCreated#,#form.PriceAdjustment#,#form.MaterialImage#">
			<cfinvokeargument name="XMLIDField" value="MaterialID">
		</cfinvoke>
	</cfif>
	<cfset MaterialAction="list">
	<cfset MaterialName="">
	<cfset DateCreated = #now()#>
	<cfset MaterialID = 0>
	<cfset MaterialDescription=''>
	<cfset MaterialName=#MaterialName#>
	<cfset PriceAdjustment='0'>
	<cfset MaterialImage=''>
</cfif>

<cfoutput>
<h1>Materials</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="MaterialID" value="#MaterialID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="MaterialAction" value="#MaterialAction#">
<input type="hidden" name="MaterialImage" value="#MaterialImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Material Name: </TD>
    <TD>
	
		<INPUT type="text" name="MaterialName" value="#MaterialName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Material Description: </TD>
    <TD>
	
		<TEXTAREA name="MaterialDescription" cols=50 rows=5>#MaterialDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Material Image: </TD>
    <TD>
		<input type="file" name="image"><br>#MaterialImage#

		
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
		<cfinvokeargument name="FileName" value="Materials">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllMaterials">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Materials">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Materials</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Adj</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllMaterials">
<tr>
<td><p>#MaterialID#</p></td>
<td><p>#MaterialName#</p></td>
<td><p>#dollarformat(PriceAdjustment)#</p></td>
<td><p><img src="../#MaterialImage#"></p></td>

<td><a href= "adminheader.cfm?MaterialID=#MaterialID#&MaterialAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?MaterialID=#MaterialID#&MaterialAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

