
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="galleryConfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfparam name="galleryName" default='none'>
<cfparam name="galleryDescription" default='none'>
<cfparam name="RequireAuthorization" default='none'>
<cfparam name="ShowOnPage" default='none'>
<cfparam name="ShowEmail" default='none'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="galleryConfig">
		<cfinvokeargument name="IDFieldName" value="galleryConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset galleryName=#galleryName#>
		<cfset galleryDescription=#galleryDescription#>
		<cfset RequireAuthorization=#RequireAuthorization#>
		<cfset ShowOnPage=#ShowOnPage#>
		<cfset ShowEmail=#ShowEmail#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.galleryName# is ""><cfset form.galleryName="none"></cfif>
	<cfif #form.galleryDescription# is ""><cfset form.galleryDescription="none"></cfif>
	<cfif not isdefined('form.RequireAuthorization')><cfset form.RequireAuthorization=0></cfif>
	<cfif not isdefined('form.ShowEmail')><cfset form.ShowEmail=0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="galleryConfig">
			<cfinvokeargument name="XMLFields" value="galleryName,galleryDescription,RequireAuthorization,ShowOnPage,ShowEmail">
			<cfinvokeargument name="XMLFieldData" value="#form.galleryName#,#form.galleryDescription#,#form.RequireAuthorization#,#form.ShowOnPage#,#form.ShowEmail#">
			<cfinvokeargument name="XMLIDField" value="galleryConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="galleryConfig">
			<cfinvokeargument name="XMLFields" value="galleryName,galleryDescription,RequireAuthorization,ShowOnPage,ShowEmail">
			<cfinvokeargument name="XMLFieldData" value="#form.galleryName#,#form.galleryDescription#,#form.RequireAuthorization#,#form.ShowOnPage#,#form.ShowEmail#">
			<cfinvokeargument name="XMLIDField" value="galleryConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>


<h1>Photo Gallery Configuration</h1>

<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Name your Gallery, this will show instead of "Galleries" on your site.</td>
	  <td><input type="text" size="40" maxlength="100" name="galleryName" value="#galleryName#"></td>
	</tr><tr>
	  <td>Do Gallery entries require authorization from you to show on the site?</td>
	  <td><cfif #RequireAuthorization# is 1><input type="checkbox" name="RequireAuthorization" value="1" checked><cfelse><input type="checkbox" name="RequireAuthorization" value="1"></cfif>	  </td>
	</tr><tr>
	<td>Select the page the Gallery will show on:<br>
	  <td>
	  <select name="ShowOnPage">
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ShowOnPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select></td>
	</tr><tr>
		<td>Description of your Gallery<br></td>
		<td><textarea name="galleryDescription" cols=40 rows=5>#galleryDescription#</textarea></td>
	</tr><tr>
	<td>Ask for Email Address of person making a Gallery entry<br>
	  <td><cfif #ShowEmail# is 1><input type="checkbox" name="ShowEmail" value="1" checked><cfelse><input type="checkbox" name="ShowEmail" value="1"></cfif>
      </td>
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