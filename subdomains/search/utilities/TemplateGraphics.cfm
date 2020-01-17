<cfparam name="GraphicsID" default=0>
<cfparam name="GraphicsAction" default="Add">
<cfparam name="TemplateID" default="1">
<cfparam name="TemplateName" default="">
<cfparam name="FileName" default="">
<cfparam name="Description" default="">
<cfparam name="GraphicsTypeID" default=0>

<cfif GraphicsID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Graphics">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#graphics">
		<cfinvokeargument name="IDFieldName" value="GraphicsID">
		<cfinvokeargument name="IDFieldValue" value="#GraphicsID#">
	</cfinvoke>
	<cfoutput query="Graphics">
		<cfset FileName=#Content#>
		<cfset GraphicsTypeID=#DisplayTypeID#>
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
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.Filename="#Application.UploadPath#\images\#image#">
	</cfif>
	<cfif GraphicsID gt 0>
		<cfif GraphicsAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#form.GraphicsTypeID#,#form.description#">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
				<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
			</cfinvoke>
		<cfelseif GraphicsAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
				<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="#templateName#graphics">
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

<cfoutput>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="GraphicsID" value="#GraphicsID#">
<input type="hidden" name="TemplateID" value="#TemplateID#">
<input type="hidden" name="TemplateName" value="#TemplateName#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="Filename" value="#filename#">
<cfif #Action# is "Update">
<input type="hidden" name="FileName" value="#Filename#">
</cfif>
</cfoutput>
<table width="450" cellspacing="4" cellpadding="2" align="CENTER">

<tr>
	<td colspan="3"><font face="arial" size="3">
	<span class=title>Template Graphics</span>
	</td>
</tr>
<tr>
	<td colspan="3">
	Template Graphics are those graphics that are vital to the format of the template.  These would be the background images whether for the page, tables or table cells, and all the other graphics that make this template look the way you designed it that are not general web site graphics that are selectable by page. Such as a page title graphic, that would be selectable by page and not a template only graphic.  Page selectable graphics are uploaded in "Graphics" on your administration menu
	</td>
</tr>
<cfoutput>
<tr>
	<td><font face="arial" size="2">Upload Graphic: <font color="Yellow">#Filename#</font></font></td>
	<td colspan=2 align=center><input type="file" name="image" size="20" value="#filename#"></td>
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
		<cfinvokeargument name="FileName" value="#TemplateName#">
		<cfinvokeargument name="ThisPath" value="Templates">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllGraphics">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#graphics">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Template Graphics</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Description - Click to view graphic</p></td>
<td><p>Graphic Type</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllGraphics">
<tr>
<td><p>#GraphicsID#</p></td>
<td><p><a href="#Filename#" target="MSM">#description#</a></p></td>
<td>
	<cfset TypeCount=ArrayLen(#GraphicsTypes#)>
	<cfloop index="gg" from="1" to="#TypeCount#">
		<cfif #GraphicsTypeID# is #GraphicsTypes[gg][1]#>
			<p>#GraphicsTypes[gg][2]#</p>
		</cfif>
	</cfloop>
</td>

<td><a href= "adminheader.cfm?GraphicsID=#GraphicsID#&Action=Edit&TemplateID=#TemplateID#&TemplateName=#Trim(TemplateName)#&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?GraphicsID=#GraphicsID#&Action=Delete&TemplateID=#TemplateID#&TemplateName=#Trim(TemplateName)#&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

