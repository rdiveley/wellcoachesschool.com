
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="VendorID" default=0>
<cfparam name="VendorAction" default="List">
<cfparam name="VendorName" default="">
<cfparam name="VendorDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="FEIN" default="">
<cfparam name="VendorPageName" default="homepage">
<cfparam name="VendorLogo" default="">

<cfif VendorAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="vendors">
		<cfinvokeargument name="XMLFields" value="VendorID,VendorDescription,VendorName,DateCreated,FEIN,VendorPageName,VendorLogo">
		<cfinvokeargument name="XMLIDField" value="VendorID">
		<cfinvokeargument name="XMLIDValue" value="#VendorID#">
	</cfinvoke>
	<cfset VendorID=0>
	<cfset VendorAction="List">
</cfif>
		
<cfif VendorID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Vendors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="vendors">
		<cfinvokeargument name="IDFieldName" value="VendorID">
		<cfinvokeargument name="IDFieldValue" value="#VendorID#">
	</cfinvoke>
	<cfoutput query="vendors">
		<cfset VendorName=#VendorName#>
		<cfset DateCreated=#DateCreated#>
		<cfset VendorDescription=#VendorDescription#>
		<cfset FEIN=#FEIN#>
		<cfset VendorPageName=#VendorPageName#>
		<cfset VendorLogo=#VendorLogo#>
	</cfoutput>
	<cfset VendorAction="update">
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
		<cfset Form.VendorLogo="images/Products/#image#">
	</cfif>
	<cfif #form.VendorLogo# is ''><cfset form.VendorLogo="none"></cfif>
	<cfif VendorID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="vendors">
			<cfinvokeargument name="XMLFields" value="VendorDescription,VendorName,DateCreated,FEIN,VendorPageName,VendorLogo">
		<cfinvokeargument name="XMLFieldData" value="#form.VendorDescription#,#form.VendorName#,#form.DateCreated#,#form.FEIN#,#form.VendorPageName#,#form.VendorLogo#">
			<cfinvokeargument name="XMLIDField" value="VendorID">
			<cfinvokeargument name="XMLIDValue" value="#VendorID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="vendors">
			<cfinvokeargument name="XMLFields" value="VendorDescription,VendorName,DateCreated,FEIN,VendorPageName,VendorLogo">
			<cfinvokeargument name="XMLFieldData" value="#form.VendorDescription#,#form.VendorName#,#form.DateCreated#,#form.FEIN#,#form.VendorPageName#,#form.VendorLogo#">
			<cfinvokeargument name="XMLIDField" value="VendorID">
		</cfinvoke>
	</cfif>
	<cfset VendorAction="list">
	<cfset VendorName="">
	<cfset DateCreated = #now()#>
	<cfset VendorID = 0>
	<cfset VendorDescription=''>
	<cfset VendorName=#VendorName#>
	<cfset FEIN=''>
	<cfset VendorPageName='homepage'>
	<cfset VendorLogo=''>
</cfif>

<cfoutput>
<h1>Vendors</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="VendorID" value="#VendorID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="VendorAction" value="#VendorAction#">
<input type="hidden" name="VendorLogo" value="#VendorLogo#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Vendor Name: </TD>
    <TD>
	
		<INPUT type="text" name="VendorName" value="#VendorName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Vendor Description: </TD>
    <TD>
	
		<TEXTAREA name="VendorDescription" cols=50 rows=5>#VendorDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Vendor Federal Identification ##: </TD>
    <TD>
		<input type="text" name="FEIN" value="#FEIN#" size=25 maxlength=25>
		
	</TD>
	<!--- field validation --->
	</TR>	

	<TR>
	<TD valign="top"> Upload Vendor Logo: </TD>
    <TD>
		<input type="file" name="image"><br>#VendorLOgo#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Page Vendor Listing will show on</td>
	<td><select name="VendorPageName">
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #VendorPageName# is #Pagename#>selected</cfif>>#Pagename#
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
		<cfinvokeargument name="FileName" value="vendors">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllVendors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="vendors">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Vendors</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Logo</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllVendors">
<tr>
<td><p>#VendorID#</p></td>
<td><p>#vendorname#</p></td>
<td><p><img src="../#VendorLogo#"></p></td>

<td><a href= "adminheader.cfm?VendorID=#VendorID#&VendorAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?VendorID=#VendorID#&VendorAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

