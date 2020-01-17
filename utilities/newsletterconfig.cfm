
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="NewsletterConfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="orderbystatement" value=" order by pagename">
</cfinvoke>

<cfparam name="NewsletterTkuPage" default='none'>
<cfparam name="ArchivesPage" default='none'>
<cfparam name="TheHeader" default='none'>
<cfparam name="TheFooter" default='none'>
<cfparam name="NoOfColumns" default='none'>
<cfparam name="SignUpText" default='Sign Up For Our Newsletter !!'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="NewsletterConfig">
		<cfinvokeargument name="IDFieldName" value="NewsletterConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset NewsletterTkuPage=#NewsletterTkuPage#>
		<cfset ArchivesPage=#replace(ArchivesPage,"~",",","ALL")#>
		<cfset TheHeader=#replace(TheHeader,"~",",","ALL")#>
		<cfset TheFooter=#replace(TheFooter,"~",",","ALL")#>
		<cfset NoOfColumns=#NoOfColumns#>
		<cfset SignUpText=#SignUpText#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.SignUpText=replace(#form.SignUpText#,",","~","ALL")>
	<cfset form.ArchivesPage=replace(#form.ArchivesPage#,",","~","ALL")>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="NewsletterConfig">
			<cfinvokeargument name="XMLFields" value="NewsletterTkuPage,ArchivesPage,TheHeader,TheFooter,NoOfColumns,SignUpText">
			<cfinvokeargument name="XMLFieldData" value="#form.NewsletterTkuPage#,#form.ArchivesPage#,#replace(form.TheHeader,',','~','ALL')#,#replace(form.TheFooter,',','~','ALL')#,#form.NoOfColumns#,#form.SignUpText# ">
			<cfinvokeargument name="XMLIDField" value="NewsletterConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="NewsletterConfig">
			<cfinvokeargument name="XMLFields" value="NewsletterTkuPage,ArchivesPage,TheHeader,TheFooter,NoOfColumns,SignUpText">
			<cfinvokeargument name="XMLFieldData" value="#form.NewsletterTkuPage#,#form.ArchivesPage#,#replace(form.TheHeader,',','~','ALL')#,#replace(form.TheFooter,',','~','ALL')#,#form.NoOfColumns#,#form.SignUpText# ">
			<cfinvokeargument name="XMLIDField" value="NewsletterConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>
<cfoutput>
<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table align="CENTER">
	<tr>
      <td valign="top">
		Thank you/unsubscibe page for signing up for the newsletter</td><td>
	   	<select name="NewsletterTkuPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #NewsletterTkuPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
<br></td></tr>
	<tr>
	<td>Enter in the text for the email that goes to new subscribers.</td>
	  <td>
	  <a href="javascript:GetEditor('thisform','archivesPage')" class=box>Click here to open the editor</a><br>
	  <textarea name="archivesPage" cols=40 rows=5>#archivespage#</textarea>
	  </td>
	</tr>
	
	<TR>
	<td valign="TOP"> Build the default header for your newsletters:<br></TD>
    <TD>
		<a href="javascript:GetEditor('thisform','TheHeader')" class=box>Click here to open the editor</a><br>
		<TEXTAREA name="TheHeader" cols=40 rows=5>#TheHeader#</TEXTAREA>
	
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> Build the default footer for your newsletters:<br>
	</TD>
	<td><a href="javascript:GetEditor('thisform','TheFooter')" class=box>Click here to open the editor</a><br> 
			<textarea name="TheFooter" cols="40" rows="5">#TheFooter#</textarea>

	</TD>
	</TR>
	
	<tr>
		<td valign="top">## of columns for your newsletter</td>
      </td>
      <td>
	  <select name="NoOfColumns">
	  	<option value="1" <cfif #NoOfColumns# is 1>selected</cfif>>1</option>
		<option value="2" <cfif #NoOfColumns# is 2>selected</cfif>>2</option>
		<option value="3" <cfif #NoOfColumns# is 3>selected</cfif>>3</option>
	  </select>
    </tr>
	<TR>
	<TD valign="top"> Enter the "title" for the newsletter subscription script:<br>
	</TD>
	<td><a href="javascript:GetEditor('thisform','SignUpTExt')" class=box>Click here to open the editor</a><br> 
			<textarea name="SignUpTExt" cols="40" rows="5">#SignUpTExt#</textarea>

	</TD>
	</TR>
	<tr>
      </td>
      <td><Input type="submit" name="submit" value="APPLY">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="reset">
      </td>
    </tr>
	
	
  </table>
  </center></div>
</form>

</cfoutput>

