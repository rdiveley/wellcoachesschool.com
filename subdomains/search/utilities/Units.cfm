
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="UnitID" default=0>
<cfparam name="UnitAction" default="List">
<cfparam name="UnitName" default="">
<cfparam name="UnitDescription" default="">
<cfparam name="DateCreated" default="#now()#">

<cfif UnitAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Units">
		<cfinvokeargument name="XMLFields" value="UnitID,UnitDescription,UnitName,DateCreated">
		<cfinvokeargument name="XMLIDField" value="UnitID">
		<cfinvokeargument name="XMLIDValue" value="#UnitID#">
	</cfinvoke>
	<cfset UnitID=0>
	<cfset UnitAction="List">
</cfif>
		
<cfif UnitID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Units">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Units">
		<cfinvokeargument name="IDFieldName" value="UnitID">
		<cfinvokeargument name="IDFieldValue" value="#UnitID#">
	</cfinvoke>
	<cfoutput query="Units">
		<cfset UnitName=#UnitName#>
		<cfset DateCreated=#DateCreated#>
		<cfset UnitDescription=#UnitDescription#>
	</cfoutput>
	<cfset UnitAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif UnitID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Units">
			<cfinvokeargument name="XMLFields" value="UnitDescription,UnitName,DateCreated">
		<cfinvokeargument name="XMLFieldData" value="#form.UnitDescription#,#form.UnitName#,#form.DateCreated#">
			<cfinvokeargument name="XMLIDField" value="UnitID">
			<cfinvokeargument name="XMLIDValue" value="#UnitID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Units">
			<cfinvokeargument name="XMLFields" value="UnitDescription,UnitName,DateCreated">
			<cfinvokeargument name="XMLFieldData" value="#form.UnitDescription#,#form.UnitName#,#form.DateCreated#">
			<cfinvokeargument name="XMLIDField" value="UnitID">
		</cfinvoke>
	</cfif>
	<cfset UnitAction="list">
	<cfset UnitName="">
	<cfset DateCreated = #now()#>
	<cfset UnitID = 0>
	<cfset UnitDescription=''>
	<cfset UnitName=#UnitName#>
</cfif>

<cfoutput>
<h1>Units</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="UnitID" value="#UnitID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="UnitAction" value="#UnitAction#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Unit of Measure Name: </TD>
    <TD>
	
		<INPUT type="text" name="UnitName" value="#UnitName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Unit of Measure Description: </TD>
    <TD>
	
		<TEXTAREA name="UnitDescription" cols=50 rows=5>#UnitDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="Units">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllUnits">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Units">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Units</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Description</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllUnits">
<tr>
<td><p>#UnitID#</p></td>
<td><p>#UnitName#</p></td>
<td><p>#UnitDescription#</p></td>

<td><a href= "adminheader.cfm?UnitID=#UnitID#&UnitAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?UnitID=#UnitID#&UnitAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

