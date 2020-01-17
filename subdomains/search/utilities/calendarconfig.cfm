
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="calendarconfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfparam name="StartWith" default=1>
<cfparam name="ShowSummary" default=1>
<cfparam name="ShowIcons" default=1>
<cfparam name="BackToCalGraphic" default='none'>
<cfparam name="AllowAdditions" default=1>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="calendarconfig">
		<cfinvokeargument name="IDFieldName" value="calendarconfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset StartWith=#StartWith#>
		<cfset ShowSummary=#ShowSummary#>
		<cfset ShowIcons=#ShowIcons#>
		<cfset BackToCalGraphic=#BackToCalGraphic#>
		<cfset AllowAdditions=#AllowAdditions#>
	</cfoutput>
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
		<cfset Form.BackToCalGraphic="#Application.UploadPath#\images\#image#">
	</cfif>
	<cfif not isdefined('form.StartWith')><cfset form.StartWith=0></cfif>
	<cfif not isdefined('form.ShowIcons')><cfset form.ShowIcons=0></cfif>
	<cfif not isdefined('form.ShowSummary')><cfset form.ShowSummary=0></cfif>
	<cfif not isdefined('form.AllowAdditions')><cfset form.AllowAdditions=0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="calendarconfig">
			<cfinvokeargument name="XMLFields" value="StartWith,ShowSummary,ShowIcons,BackToCalGraphic,AllowAdditions">
			<cfinvokeargument name="XMLFieldData" value="#form.StartWith#,#form.ShowSummary#,#form.ShowIcons#,#form.BackToCalGraphic#,#form.AllowAdditions#">
			<cfinvokeargument name="XMLIDField" value="calendarconfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="calendarconfig">
			<cfinvokeargument name="XMLFields" value="StartWith,ShowSummary,ShowIcons,BackToCalGraphic,AllowAdditions">
			<cfinvokeargument name="XMLFieldData" value="#form.StartWith#,#form.ShowSummary#,#form.ShowIcons#,#form.BackToCalGraphic#,#form.AllowAdditions#">
			<cfinvokeargument name="XMLIDField" value="calendarconfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>


<h1>Calendar Configuration</h1>

<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <input type="hidden" name="BackToCalGraphic" value="#BackToCalGraphic#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Start calendar view with:</td>
	  <td><cfif #StartWith# is 1><input type="radio" name="StartWith" value="1" checked> Daily<cfelse><input type="radio" name="StartWith" value="1">Daily</cfif>
	  <cfif #StartWith# is 4><input type="radio" name="StartWith" value="4" checked> Weekly<cfelse><input type="radio" name="StartWith" value="4">Weekly</cfif>
	  <cfif #StartWith# is 2><input type="radio" name="StartWith" value="2" checked> Monthly<cfelse><input type="radio" name="StartWith" value="2">Monthly</cfif>
	  <cfif #StartWith# is 3><input type="radio" name="StartWith" value="3" checked> Events Only<cfelse><input type="radio" name="StartWith" value="3">Events Only</cfif>
	  </td>
	</tr><tr>
	  <td>Show event icon on monthly calendar?</td>
	  <td><cfif #ShowIcons# is 1><input type="checkbox" name="ShowIcons" value="1" checked><cfelse><input type="checkbox" name="ShowIcons" value="1"></cfif></td>
	</tr><tr>
	<td>Show Event Description on monthly calendar?:<br></td>
	  <td><cfif #ShowSummary# is 1><input type="checkbox" name="ShowSummary" value="1" checked><cfelse><input type="checkbox" name="ShowSummary" value="1"></cfif></td>
	</tr><tr>
		<td>Allow users to add events?:<br>
      <td><cfif #AllowAdditions# is 1><input type="checkbox" name="AllowAdditions" value="1" checked><cfelse><input type="checkbox" name="AllowAdditions" value="1"></cfif></td>
    </tr>
	<tr>
	<td>Upload the graphic for the "Back to Calendar" button</td>
	  <td><input type="file" name="image"><cfif #BackToCalGraphic# neq "none"><br>Editing: #BackToCalGraphic#</cfif></td>
	</tr>
    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit1" value="Reset"> <br>
      </td>
      <td></td>
    </tr>
  </table>
  </center></div>
</form>

</cfoutput>