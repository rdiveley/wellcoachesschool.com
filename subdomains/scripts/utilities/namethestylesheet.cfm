
<cfparam name="SheetID" default=0>
<cfparam name="SheetAction" default="List">
<cfparam name="SheetName" default="">
<cfparam name="SheetDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="SheetFileName" default="">

<cfif SheetAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="XMLStyleSheets">
		<cfinvokeargument name="XMLFields" value="SheetDescription,SheetName,DateCreated,SheetFileName">
		<cfinvokeargument name="XMLIDField" value="SheetID">
		<cfinvokeargument name="XMLIDValue" value="#SheetID#">
	</cfinvoke>
	<cfset SheetID=0>
	<cfset SheetAction="List">
</cfif>
		
<cfif SheetID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="XMLStyleSheets">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="XMLStyleSheets">
		<cfinvokeargument name="IDFieldName" value="SheetID">
		<cfinvokeargument name="IDFieldValue" value="#SheetID#">
	</cfinvoke>
	<cfoutput query="XMLStyleSheets">
		<cfset SheetName=#SheetName#>
		<cfset DateCreated=#DateCreated#>
		<cfset SheetDescription=#SheetDescription#>
		<cfset SheetFileName=#SheetFileName#>
	</cfoutput>
	<cfset SheetAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.SheetDescription# is ''><cfset form.SheetDescription="none"></cfif>
	<cfset form.SheetDescription = replace(#form.SheetDescription#,",","~","ALL")>
	
	<cfif SheetID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="XMLStyleSheets">
			<cfinvokeargument name="XMLFields" value="SheetDescription,SheetName,DateCreated,SheetFileName">
		<cfinvokeargument name="XMLFieldData" value="#form.SheetDescription#,#form.SheetName#,#form.DateCreated#,#form.SheetFileName#">
			<cfinvokeargument name="XMLIDField" value="SheetID">
			<cfinvokeargument name="XMLIDValue" value="#SheetID#">
		</cfinvoke>
	<cfelse>
		<CF_agr_password mode="alpha" case="mixed" length="20" var="SheetFileName">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="XMLStyleSheets">
			<cfinvokeargument name="XMLFields" value="SheetDescription,SheetName,DateCreated,SheetFileName">
			<cfinvokeargument name="XMLFieldData" value="#form.SheetDescription#,#form.SheetName#,#form.DateCreated#,#SheetFileName#">
			<cfinvokeargument name="XMLIDField" value="SheetID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=#Action#">
</cfif>

<cfoutput>
<h1>XMLStyleSheets</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="SheetID" value="#SheetID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="SheetAction" value="#SheetAction#">
<input type="hidden" name="SheetFilename" value="#SheetFilename#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Name: </TD>
    <TD>
	
		<INPUT type="text" name="SheetName" value="#SheetName#" size=25 maxLength="25">
		
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<TEXTAREA name="SheetDescription" cols=50 rows=5>#SheetDescription#</TEXTAREA>
	
	</TD>
	</TR>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="XMLStyleSheets">
		<cfinvokeargument name="ThisPath" value="pages">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllXMLStyleSheets">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="XMLStyleSheets">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Basic Style Sheets</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Description</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllXMLStyleSheets">
<tr>
<td><p>#SheetID#</p></td>
<td><p>#SheetName#</p></td>
<td><p>#sheetdescription#</p></td>

<td><a href= "adminheader.cfm?SheetID=#SheetID#&SheetAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SheetID=#SheetID#&SheetAction=Delete&action=#action#">Delete</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SheetID=#SheetName#&StylesheetName=#SheetFilename#&action=buildstylesheet">Add Elements</a></td>
</tr>
</cfoutput>
</cfif>
</table>

