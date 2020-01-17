<cfparam name="DetailID" default=0>
<cfparam name="DetailAction" default="Add">
<cfparam name="TemplateID" default="1">
<cfparam name="TemplateName" default="">
<cfparam name="Content" default="">
<cfparam name="PositionID" default=0>
<cfparam name="DisplayTypeID" default=0>

<cfif DetailAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#">
		<cfinvokeargument name="XMLFields" value="DetailID,Content,PositionID,DisplayTypeID">
		<cfinvokeargument name="XMLIDField" value="DetailID">
		<cfinvokeargument name="XMLIDValue" value="#DetailID#">
	</cfinvoke>
	<cfset DetailID=0>
	<cfset DetailAction="List">
</cfif>

<cfif DetailID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Details">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#">
		<cfinvokeargument name="IDFieldName" value="DetailID">
		<cfinvokeargument name="IDFieldValue" value="#DetailID#">
	</cfinvoke>
	<cfoutput query="Details">
		<cfset Content=#Content#>
		<cfset Content=replace(#content#,"~",",","ALL")>
		<cfset PositionID=#PositionID#>
		<cfset DisplayTypeID=#DisplayTypeID#>
	</cfoutput>
	<cfset DetailAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.Content=replace(#form.content#,",","~","ALL")>
	<cfif DetailID gt 0>
		<cfif DetailAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#">
				<cfinvokeargument name="XMLFields" value="Content,PositionID,DisplayTypeID">
			<cfinvokeargument name="XMLFieldData" value="#form.Content#,#form.PositionID#,#form.DisplayTypeID#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
				<cfinvokeargument name="XMLIDValue" value="#DetailID#">
			</cfinvoke>
		<cfelseif DetailAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#">
				<cfinvokeargument name="XMLFields" value="DetailID,Content,PositionID,DisplayTypeID">
				<cfinvokeargument name="XMLIDField" value="DetailID">
				<cfinvokeargument name="XMLIDValue" value="#DetailID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="#templateName#">
			<cfinvokeargument name="XMLFields" value="Content,PositionID,DisplayTypeID">
			<cfinvokeargument name="XMLFieldData" value="#form.Content#,#form.PositionID#,#form.DisplayTypeID#">
			<cfinvokeargument name="XMLIDField" value="DetailID">
		</cfinvoke>
	</cfif>
	<cfset DetailAction="list">
	<cfset Content="none">
	<cfset PositionID=0>
	<cfset DisplayTypeID = 0>
	<cfset DetailID = 0>
</cfif>
<cfoutput> <h1>Template Details</h1> <br>

<form action="../#application.TheFilespath#/adminheader.cfm"  method="post">
<input type="hidden" name="DetailID" value="#DetailID#">
<input type="hidden" name="TemplateID" value="#TemplateID#">
<input type="hidden" name="TemplateName" value="#TemplateName#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="DetailAction" value="#DetailAction#">
</cfoutput>
<table width="80%" cellspacing="4" cellpadding="2" align="CENTER">

<tr>
	<cfoutput><td colspan="3">
	Template Details are the contents of the template, that which the user is going to manipulate when he selects that template for his web site. <a class=nav href="javascript:popupPage('#application.ReturnPath#/templates/exampledetail.cfm')">Click here</a> for an example of how to enter in the "Content" template details. <a class=nav href="javascript:popupPage('#application.ReturnPath#/templates/detailhelp.cfm')">Click here</a> for the help file. 
	</td></cfoutput>
</tr>
<cfoutput>
<tr>
	<td>Content of this section of the template or instructions for the customer if this is a navigation choice section or an image choice: </td><td><textarea name="content" cols="45" rows="8">#content#</textarea></td>
</tr>

<tr>
	<td><font face="arial" size="2">Display type for this detail section:</font> </td><td><select name="DisplayTypeID">
			<cfinvoke method="GetArrayRecords" component="#Application.WebSitePath#.utilities.arrayhandler" returnvariable="DisplayTypes">
				<cfinvokeargument name="ThisPath" value="#application.TheFilespath#">
				<cfinvokeargument name="ThisFileName" value="displaytypes">
			</cfinvoke>
			<cfset TypeCount=ArrayLen(#DisplayTypes#)>
			<cf_ArrayTableSort
					arrayname = #DisplayTypes#
					sortcolumn=2
					sortorder='asc'>
			<cfset DisplayTypes=ArraySorted>
			<cfloop index="TT" from="1" to="#TypeCount#">
			<option value="#DisplayTypes[TT][1]#" <cfif #DisplayTypeID# is #DisplayTypes[TT][1]#>selected</cfif>>#DisplayTypes[TT][2]#
			</cfloop>
		</select></td>
</tr> 

 <tr>
	<td><font face="arial" size="2">Position on the template for this detail section:</font> </td><td><select name="PositionID">
			<cfloop index="x" from="1" to="80">
			<cfset NewID=#x#>
			<cfset tLen=Len(NewID)>
			<cfloop index="XX" from="#tLen#" to="9">
				<cfset NewID="0#NewID#">
			</cfloop>
			<option value="#NewID#" <cfif #PositionID# is #NewID#>selected</cfif>>#x#</option>
			</cfloop>
		</select></td>
</tr>

<tr>
	<td><font face="arial" size="2">Template this detail section belongs to:</font> </td>
	<td>#TemplateName#</td>
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
		method="GetXMLRecords" returnvariable="AllDetails">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#">
		<cfinvokeargument name="OrderByStatement" value="order by positionid">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Template Details</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Position</p></td>
<td><p>DisplayType</p></td>
<td><p>Actions</p></td>
</tr>

<cfoutput query="allDetails">
<tr>
<td><p>#DetailID#</p></td>
<td><p>#PositionID#</p></td>
<td>
	
	<cfset TypeCount=ArrayLen(#DisplayTypes#)>
	<cfloop index="gg" from="1" to="#TypeCount#">
		<cfif #DisplayTypeID# is #DisplayTypes[gg][1]#>
			<p>#DisplayTypes[gg][2]#</p>
		</cfif>
	</cfloop>
</td>

<td><a href= "adminheader.cfm?DetailID=#DetailID#&DetailAction=Edit&TemplateID=#TemplateID#&TemplateName=#Trim(TemplateName)#&Action=#Action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?DetailID=#DetailID#&DetailAction=delete&TemplateID=#TemplateID#&TemplateName=#Trim(TemplateName)#&Action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

