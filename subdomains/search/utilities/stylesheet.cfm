<cfparam name="Filename" default='none'>
<cfparam name="Content" default='none'>
<cfparam name="StyleID" default='0'>
<cfparam name="StyleAction" default="list">

<cfif StyleAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="stylesheets">
		<cfinvokeargument name="XMLFields" value="StyleID,Filename,Content">
		<cfinvokeargument name="XMLIDField" value="StyleID">
		<cfinvokeargument name="XMLIDValue" value="#StyleID#">
	</cfinvoke>
	<cfset StyleAction="list">
	<cfset StyleID=0>
</cfif>
		
<cfif StyleID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="stylesheets">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="stylesheets">
		<cfinvokeargument name="IDFieldName" value="StyleID">
		<cfinvokeargument name="IDFieldValue" value="#StyleID#">
	</cfinvoke>
	<cfoutput query="stylesheets">
		<cfset Filename=#Filename#>
		<cfset Content=#Content#>
		<cfset Content=replace(#content#,"~",",","ALL")>
		<cfset Content=replacenocase(#content#,"<style>","","ALL")>
		<cfset Content=replacenocase(#content#,"</style>","","ALL")>
		<cfset Content=replacenocase(#content#,">","","ALL")>
		<cfset Content=replacenocase(#content#,">","","ALL")>
		<cfset Content=replace(#content#,"~",",","ALL")>
	</cfoutput>
	<cfset StyleAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.Content=replace(#form.content#,",","~","ALL")>
	<cfif StyleID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfinvokeargument name="XMLFields" value="Filename,Content">
			<cfinvokeargument name="XMLFieldData" value="#form.FileName#,#form.Content#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
			<cfinvokeargument name="XMLIDValue" value="#StyleID#">
		</cfinvoke>
		<cffile action="WRITE"
		file="#application.uploadpath#\#application.TheFilesPath#\#form.Filename#.css"
		output="#replace(form.Content,'~',',','ALL')#"
		addnewline="No">
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfinvokeargument name="XMLFields" value="Filename,Content">
			<cfinvokeargument name="XMLFieldData" value="#form.FileName#,#form.Content#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
		</cfinvoke>
		<cffile action="WRITE"
			file="#application.uploadpath#\#application.TheFilesPath#\#form.Filename#.css"
			output="#replace(form.Content,'~',',','ALL')#"
			addnewline="No">
	</cfif>
	<cfset StyleAction="list">
	<cfset FileName="none">
	<cfset Content="none">
	<cfset StyleID=0>
</cfif>
<cfoutput> <h1>Style Sheets</h1> <p>A stylesheet is a list of instructions for your web site.  These instructions govern how your text looks and keep the text on the entire site consistent.  If you didn't use a style sheet you would have to tell each page or even each paragraph of text what font, font size, font color, etc is supposed to look like.   Please get some help from someone who understands style sheets for this area if you wish to use a stylesheet for your site or <a href="adminheader.cfm?action=buildstylesheet">Click Here</a> for the easy style sheet creator.</p>
<form action="../#application.thefilespath#/adminheader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="StyleID" value="#StyleID#">
<input type="Hidden" name="Action" value="#Action#">
<input type="hidden" name="StyleAction" value="#StyleAction#">

<table width="450" cellspacing="4" cellpadding="2" align="CENTER">
<tr>
	<td><font face="arial" size="2">Name of this stylesheet:</font> </td><td><input type="text" name="filename" value="#trim(filename)#" size=40 maxlength=250></td>
</tr>

<tr>
	<td><font face="arial" size="2">Content of this stylesheet:</font> </td><td><textarea name="Content" cols="50" rows="10">#trim(Content)#</textarea></td>
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
		<cfinvokeargument name="FileName" value="stylesheets">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllStylesheets">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="stylesheets">
	</cfinvoke>
	<table class=toptable>
	<th colspan="6" align="CENTER" bgcolor="#800040">Your Stylesheets</th>
	<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Content</th>
	<th>Actions</th>
	</tr>
	
	<cfoutput query="AllStylesheets">
		<tr>
		<td><p>#StyleID#</p></td>
		<td><p>#filename#</p></td>
		<cfset tContent=replace(#content#,"~",",","ALL")>
		<td><p>#tContent#</p></td>
		
		<td>
		<a href= "adminheader.cfm?StyleID=#StyleID#&StyleAction=edit&Action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<a href="javascript:confirmDelete('adminheader.cfm?StyleID=#StyleID#&StyleAction=Delete&Action=#action#')">Delete</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
	</cfoutput>
	
	</table>
</cfif>