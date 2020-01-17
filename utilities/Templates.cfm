<cfparam name="Filename" default='none'>
<cfparam name="Description" default='none'>
<cfparam name="PageTypeID" default='0'>
<cfparam name="TemplateID" default="0">
<cfparam name="TemplateAction" default="list">
<cfif TemplateAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="templates">
		<cfinvokeargument name="ThisFileName" value="templates">
		<cfinvokeargument name="XMLFields" value="TemplateID,Filename,Description,PageTypeid">
		<cfinvokeargument name="XMLIDField" value="TemplateID">
		<cfinvokeargument name="XMLIDValue" value="#TemplateID#">
	</cfinvoke>
	<cfset TemplateAction="list">
	<cfset TemplateID=0>
</cfif>
<cfif TemplateID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="templates">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="templates">
		<cfinvokeargument name="IDFieldName" value="TemplateID">
		<cfinvokeargument name="IDFieldValue" value="#TemplateID#">
	</cfinvoke>
	<cfoutput query="templates">
		<cfset Filename=#Filename#>
		<cfset Description=replace(#Description#,"~",",","ALL")>
		<cfset PageTypeID=#PageTypeID#>
	</cfoutput>
	<cfset TemplateAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif TemplateID gt 0>
		<cfset form.description=replace(#form.description#,",","~","ALL")>
		<cfif TemplateAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="templates">
				<cfinvokeargument name="XMLFields" value="Filename,Description,PageTypeid">
				<cfinvokeargument name="XMLFieldData" value="#form.FileName#,#form.Description#,#form.PageTypeID#">
				<cfinvokeargument name="XMLIDField" value="TemplateID">
				<cfinvokeargument name="XMLIDValue" value="#TemplateID#">
			</cfinvoke>
		<cfelseif TemplateAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="templates">
				<cfinvokeargument name="XMLFields" value="Filename,Description,PageTypeid">
				<cfinvokeargument name="XMLIDField" value="TemplateID">
				<cfinvokeargument name="XMLIDValue" value="#TemplateID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="templates">
			<cfinvokeargument name="XMLFields" value="Filename,Description,PageTypeid">
			<cfinvokeargument name="XMLFieldData" value="#form.FileName#,#form.Description#,#form.PageTypeID#">
			<cfinvokeargument name="XMLIDField" value="TemplateID">
		</cfinvoke>
	</cfif>
	<cfset TemplateAction="list">
	<cfset FileName="none">
	<cfset Description="none">
	<cfset PageTypeID=0>

</cfif>
<cfoutput> <h1>Templates</h1> <br>
<form action="../#application.thefilespath#/adminheader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="TemplateID" value="#TemplateID#">
<input type="Hidden" name="Action" value="#Action#">
<input type="hidden" name="TemplateAction" value="#TemplateAction#">

<table width="450" cellspacing="4" cellpadding="2" align="CENTER">

<tr>
	<td colspan="3"><font face="arial" size="2">
	<p class=legal>Templates are the look and feel of your web site.  The general areas where things go on any one page and the standard graphics that go in those sections.  You can create as many templates as needed for your site.  These templates would reflect the type of page content.  For instance, a page where a person would check out after selecting the products he wishes to buy would need a fairly large text content area for the large form necessary for gathering all the information about the person making the purchase, but a page devoted to contact information could be split up into several small sections with each section containing specific contact information.</font>
	</td>
</tr>
<tr>
	<td><font face="arial" size="2">Name of this template:</font> </td><td><input type="text" name="filename" value="#trim(filename)#" size=40 maxlength=250></td>
</tr>

<tr>
	<td><font face="arial" size="2">Description of this template:</font> </td><td><textarea name="Description" cols="40" rows="5">#trim(Description)#</textarea></td>
</tr>

 <tr>
	<td><font face="arial" size="2">Page category that best represents the use of this template:</font> </td><td>
		<select name="PageTypeID">
			<cfinvoke method="GetArrayRecords" 
				component="#Application.WebSitePath#.utilities.arrayhandler" 
				returnvariable="pagetypes">
				<cfinvokeargument name="ThisPath" value="#application.TheFilespath#">
				<cfinvokeargument name="ThisFileName" value="pagetypes">
			</cfinvoke>
			<cfset TypeCount=ArrayLen(#pagetypes#)>
			<cfloop index="TT" from="1" to="#TypeCount#">
			<option value="#pagetypes[TT][1]#" <cfif #PageTypeID# is #pagetypes[TT][1]#>selected</cfif>>#pagetypes[TT][2]#
			</cfloop>
		</select></td>
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
		<cfinvokeargument name="FileName" value="templates">
		<cfinvokeargument name="ThisPath" value="Templates">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="alltemplates">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="templates">
	</cfinvoke>
	<table class=toptable>
	<th colspan="6" align="CENTER" bgcolor="#800040">Your Templates</th>
	<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Description</th>
	<th>Actions</th>
	</tr>
	
	<cfoutput query="alltemplates">
		<tr>
		<td><p>#templateID#</p></td>
		<td><p>#filename#</p></td>
		<td><p>#description#</p></td>
		
		<td>
		<a href= "adminheader.cfm?TemplateID=#Templateid#&TemplateAction=edit&Action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<a href="javascript:confirmDelete('adminheader.cfm?TemplateID=#Templateid#&TemplateAction=Delete&Action=#action#')">Delete</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<br>
		<a href="adminheader.cfm?TemplateID=#Templateid#&TemplateName=#filename#&Action=TemplateDetails">Add Details to this Template</a><br>

		<a href="adminheader.cfm?TemplateID=#Templateid#&TemplateName=#filename#&Action=ViewTemplate">View Completed Template</a></td>
		</tr>
	</cfoutput>
	
	</table>
</cfif>