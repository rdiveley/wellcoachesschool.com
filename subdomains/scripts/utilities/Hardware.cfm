
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="HardwareID" default=0>
<cfparam name="HardwareAction" default="List">
<cfparam name="HardwareName" default="">
<cfparam name="HardwareDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PriceAdjustment" default="0">
<cfparam name="HardwareImage" default="">

<cfif HardwareAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Hardware">
		<cfinvokeargument name="XMLFields" value="Hardwareid,HardwareDescription,HardwareName,DateCreated,PriceAdjustment,HardwareImage">
		<cfinvokeargument name="XMLIDField" value="HardwareID">
		<cfinvokeargument name="XMLIDValue" value="#HardwareID#">
	</cfinvoke>
	<cfset HardwareID=0>
	<cfset HardwareAction="List">
</cfif>
		
<cfif HardwareID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Hardware">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Hardware">
		<cfinvokeargument name="IDFieldName" value="HardwareID">
		<cfinvokeargument name="IDFieldValue" value="#HardwareID#">
	</cfinvoke>
	<cfoutput query="Hardware">
		<cfset HardwareName=#HardwareName#>
		<cfset DateCreated=#DateCreated#>
		<cfset HardwareDescription=#HardwareDescription#>
		<cfset PriceAdjustment=#PriceAdjustment#>
		<cfset HardwareImage=#HardwareImage#>
	</cfoutput>
	<cfset HardwareAction="update">
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
		<cfset Form.HardwareImage="images/Products/#image#">
	</cfif>
	<cfif #form.HardwareImage# is ''><cfset form.HardwareImage="none"></cfif>
	<cfif HardwareID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Hardware">
			<cfinvokeargument name="XMLFields" value="HardwareDescription,HardwareName,DateCreated,PriceAdjustment,HardwareImage">
		<cfinvokeargument name="XMLFieldData" value="#form.HardwareDescription#,#form.HardwareName#,#form.DateCreated#,#form.PriceAdjustment#,#form.HardwareImage#">
			<cfinvokeargument name="XMLIDField" value="HardwareID">
			<cfinvokeargument name="XMLIDValue" value="#HardwareID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Hardware">
			<cfinvokeargument name="XMLFields" value="HardwareDescription,HardwareName,DateCreated,PriceAdjustment,HardwareImage">
			<cfinvokeargument name="XMLFieldData" value="#form.HardwareDescription#,#form.HardwareName#,#form.DateCreated#,#form.PriceAdjustment#,#form.HardwareImage#">
			<cfinvokeargument name="XMLIDField" value="HardwareID">
		</cfinvoke>
	</cfif>
	<cfset HardwareAction="list">
	<cfset HardwareName="">
	<cfset DateCreated = #now()#>
	<cfset HardwareID = 0>
	<cfset HardwareDescription=''>
	<cfset HardwareName=#HardwareName#>
	<cfset PriceAdjustment='0'>
	<cfset HardwareImage=''>
</cfif>

<cfoutput>
<h1>Hardware</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="HardwareID" value="#HardwareID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="HardwareAction" value="#HardwareAction#">
<input type="hidden" name="HardwareImage" value="#HardwareImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Product Hardware Name: </TD>
    <TD>
	
		<INPUT type="text" name="HardwareName" value="#HardwareName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Product Hardware Description: </TD>
    <TD>
	
		<TEXTAREA name="HardwareDescription" cols=50 rows=5>#HardwareDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Product Hardware Image: </TD>
    <TD>
		<input type="file" name="image"><br>#HardwareImage#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Price Adjustment</td>
	<td><input type="text" value="#PriceAdjustment#" name="PriceAdjustment"></td>
	</tr>
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="Hardware">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllHardware">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Hardware">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Hardware</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Adj</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllHardware">
<tr>
<td><p>#HardwareID#</p></td>
<td><p>#HardwareName#</p></td>
<td><p>#dollarformat(PriceAdjustment)#</p></td>
<td><p><img src="../#HardwareImage#"></p></td>

<td><a href= "adminheader.cfm?HardwareID=#HardwareID#&HardwareAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?HardwareID=#HardwareID#&HardwareAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

