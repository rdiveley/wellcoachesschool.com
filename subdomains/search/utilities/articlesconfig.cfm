
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="articlesconfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfparam name="ShowAuthor" default='none'>
<cfparam name="ShowSummary" default='none'>
<cfparam name="ShowIcons" default='none'>
<cfparam name="BackToLibGraphic" default='none'>
<cfparam name="ShowCategoryGraphic" default='none'>
<cfparam name="ShowBreadCrumbs" default='none'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="articlesconfig">
		<cfinvokeargument name="IDFieldName" value="ArticleConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset ShowAuthor=#ShowAuthor#>
		<cfset ShowSummary=#ShowSummary#>
		<cfset ShowIcons=#ShowIcons#>
		<cfset BackToLibGraphic=#BackToLibGraphic#>
		<cfset ShowCategoryGraphic=#ShowCategoryGraphic#>
		<cfset ShowBreadCrumbs=#ShowBreadCrumbs#>
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
		<cfset Form.BackToLibGraphic="#Application.UploadPath#\images\#image#">
	</cfif>
	<cfif not isdefined('form.showauthor')><cfset form.showauthor=0></cfif>
	<cfif not isdefined('form.ShowIcons')><cfset form.ShowIcons=0></cfif>
	<cfif not isdefined('form.ShowSummary')><cfset form.ShowSummary=0></cfif>
	<cfif not isdefined('form.ShowCategoryGraphic')><cfset form.ShowCategoryGraphic=0></cfif>
	<cfif not isdefined('form.ShowBreadCrumbs')><cfset form.ShowBreadCrumbs=0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="articlesconfig">
			<cfinvokeargument name="XMLFields" value="ShowAuthor,ShowSummary,ShowIcons,BackToLibGraphic,ShowCategoryGraphic,ShowBreadCrumbs">
			<cfinvokeargument name="XMLFieldData" value="#form.ShowAuthor#,#form.ShowSummary#,#form.ShowIcons#,#form.BackToLibGraphic#,#form.ShowCategoryGraphic#,#form.ShowBreadCrumbs#">
			<cfinvokeargument name="XMLIDField" value="ArticleConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="articlesconfig">
			<cfinvokeargument name="XMLFields" value="ShowAuthor,ShowSummary,ShowIcons,BackToLibGraphic,ShowCategoryGraphic,ShowBreadCrumbs">
			<cfinvokeargument name="XMLFieldData" value="#form.ShowAuthor#,#form.ShowSummary#,#form.ShowIcons#,#form.BackToLibGraphic#,#form.ShowCategoryGraphic#,#form.ShowBreadCrumbs#">
			<cfinvokeargument name="XMLIDField" value="ArticleConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>


<h1>Articles Configuration</h1>

<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <input type="hidden" name="BackToLibGraphic" value="#BackToLibGraphic#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Show Author on Article Listing?:</td>
	  <td><cfif #ShowAuthor# is 1><input type="checkbox" name="ShowAuthor" value="1" checked><cfelse><input type="checkbox" name="ShowAuthor" value="1"></cfif></td>
	</tr><tr>
	  <td>Show icon of file type (i.e. if the article was an uploaded Word Document the icon would be the MS Word symbol)</td>
	  <td><cfif #ShowIcons# is 1><input type="checkbox" name="ShowIcons" value="1" checked><cfelse><input type="checkbox" name="ShowIcons" value="1"></cfif></td>
	</tr><tr>
	<td>Show article summary on Article Listing?:<br></td>
	  <td><cfif #ShowSummary# is 1><input type="checkbox" name="ShowSummary" value="1" checked><cfelse><input type="checkbox" name="ShowSummary" value="1"></cfif></td>
	</tr>
	<tr>
	<td>Show bread crumbs?:<br></td>
	  <td><cfif #showBreadCrumbs# is 1><input type="checkbox" name="showBreadCrumbs" value="1" checked><cfelse><input type="checkbox" name="showBreadCrumbs" value="1"></cfif></td>
	</tr><tr>
		<td>Show Category image on Article Listing?:<br>
      <td><cfif #ShowCategoryGraphic# is 1><input type="checkbox" name="ShowCategoryGraphic" value="1" checked><cfelse><input type="checkbox" name="ShowCategoryGraphic" value="1"></cfif></td>
    </tr>
	<tr>
	<td>Upload the graphic for the "Back to Library" button</td>
	  <td><input type="file" name="image"><cfif #BackToLibGraphic# neq "none"><br>Editing: #BackToLibGraphic#</cfif></td>
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