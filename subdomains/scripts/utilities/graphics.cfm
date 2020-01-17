<cfparam name="GraphicsID" default=0>
<cfparam name="GraphicsAction" default="Add">
<cfparam name="FileName" default="">
<cfparam name="Description" default="">
<cfparam name="GraphicsTypeID" default=0>

<cfif GraphicsAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="graphics">
		<cfinvokeargument name="XMLFields" value="GraphicsID,FileName,GraphicsTypeID,description">
		<cfinvokeargument name="XMLIDField" value="GraphicsID">
		<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
	</cfinvoke>
	<cfset GraphicsAction="list">
	<cfset GraphicsID=0>
</cfif>

<cfif GraphicsID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Graphics">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="graphics">
		<cfinvokeargument name="IDFieldName" value="GraphicsID">
		<cfinvokeargument name="IDFieldValue" value="#GraphicsID#">
	</cfinvoke>
	<cfoutput query="Graphics">
		<cfset FileName=#filename#>
		<cfset GraphicsTypeID=#GraphicsTypeID#>
		<cfset Description="#Description#">
	</cfoutput>
	<cfset GraphicsAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="200"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.Filename="images/#image#">
	</cfif>
	<cfif GraphicsID gt 0>
		<cfif GraphicsAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#form.GraphicsTypeID#,#form.description#">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
				<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
			</cfinvoke>
		<cfelseif GraphicsAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
				<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="graphics">
			<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
			<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#form.GraphicsTypeID#,#form.description#">
			<cfinvokeargument name="XMLIDField" value="GraphicsID">
		</cfinvoke>
	</cfif>
	<cfset GraphicsAction="list">
	<cfset FileName="">
	<cfset GraphicsTypeID = 0>
	<cfset GraphicsID = 0>
	<cfset Description=''>
</cfif>

<cfoutput><h1>Web Site Graphics</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="GraphicsID" value="#GraphicsID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="Filename" value="#filename#">
<input type="hidden" name="GraphicsAction" value="#GraphicsAction#">
</cfoutput>
<table width="450" cellspacing="4" cellpadding="2" align="CENTER">

<cfoutput>
<tr>
	<td><font face="arial" size="2">Upload Graphic: </font></td>
	<td colspan=2><input type="file" name="image" size="20" value="#filename#"><br>
	<font color="black"><strong>#Filename#</strong></font></td>
</tr>

<tr>
	<td><font face="arial" size="2">Graphic type :</font> </td><td><select name="GraphicsTypeID">
			<cfinvoke method="GetArrayRecords" 
				component="#Application.WebSitePath#.utilities.arrayhandler" returnvariable="GraphicsTypes">
				<cfinvokeargument name="ThisPath" value="#application.TheFilespath#">
				<cfinvokeargument name="ThisFileName" value="graphictypes">
			</cfinvoke>
			<cfset TypeCount=ArrayLen(#GraphicsTypes#)>
			<cfloop index="TT" from="1" to="#TypeCount#">
			<option value="#GraphicsTypes[TT][1]#" <cfif #GraphicsTypeID# is #GraphicsTypes[TT][1]#>selected</cfif>>#GraphicsTypes[TT][2]#
			</cfloop>
		</select></td>
</tr> 
<tr>
	<td><font face="arial" size="2">Brief Description of this graphic: </font></td>
	<td colspan=2 align=center><input type="text" name="description" size="50" value="#Description#"></td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" name="submit" value="Apply">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="submit" value="Done">
	</td>
</tr>
</table>
</form>
</cfoutput>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="graphics">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllGraphics">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="graphics">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Web Site Graphics</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Description - Click to view graphic</p></td>
<td><p>Graphic Type</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllGraphics">
<tr>
<td><p>#int(GraphicsID)#</p></td>
<td><p><a href="#application.returnpath#/#Filename#" target="MSM">#description#</a></p></td>
<td>
	<cfset TypeCount=ArrayLen(#GraphicsTypes#)>
	<cfloop index="gg" from="1" to="#TypeCount#">
		<cfif #GraphicsTypeID# is #GraphicsTypes[gg][1]#>
			<p>#GraphicsTypes[gg][2]#</p>
		</cfif>
	</cfloop>
</td>

<td><a href= "adminheader.cfm?GraphicsID=#GraphicsID#&graphicsAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?GraphicsID=#GraphicsID#&graphicsAction=Delete&action=#action#')">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

