<cfparam name="NewsletterID" default=0>
<cfparam name="NewsletterAction" default="List">
<cfparam name="NewsletterName" default="none">
<cfparam name="NLHeader" default="none">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="DateLastSent" default="">
<cfparam name="NLBody" default="none">
<cfparam name="newslettersentTo" default="0">
<cfparam name="NLFooter" default="none">
<cfparam name="ReturnEmailAddress" default="none">
<cfparam name="ReturnURL" default="none">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllNewsletters">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="newsletters">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Utilities">
	<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
	<cfinvokeargument name="ThisFileName" value="NewsletterConfig">
	<cfinvokeargument name="IDFieldName" value="NewsletterConfigID">
	<cfinvokeargument name="IDFieldValue" value="0000000001">
</cfinvoke>
<cfoutput query="Utilities">
	<cfset NewsletterTkuPage=#NewsletterTkuPage#>
	<cfset ArchivesPage=#ArchivesPage#>
	<cfset TheHeader=#TheHeader#>
	<cfif NLHeader is "" or NLHeader is "none"><cfset NLHeader=TheHeader></cfif>
	<cfset TheFooter=#TheFooter#>
	<cfif NLFooter is "" or NLFooter is "none"><cfset NLFooter=TheFooter></cfif>
	<cfset NoOfColumns=#NoOfColumns#>
	<cfif NLBody is "" or NLBody is "none">
		<cfif #NoOfColumns# is 2>
			<cfset NLBody="<Table width=100% cellpadding=0 cellspacing=0 border=0><tr><td width=50%>left column</td><td width=50%>right column</td></tr></table>">
		<cfelseif #NoOfColumns# is 3>
			<cfset NLBody="<Table width=100% cellpadding=0 cellspacing=0 border=0><tr>left column<td width=33%></td><td width=33%>center column</td><td width=33%>right column</td></tr></table>">
		<cfelse>
			<cfset NLBody="<Table width=100% cellpadding=0 cellspacing=0 border=0><tr><td width=100%>Start typing here</td></tr></table>">
		</cfif>
	</cfif>
</cfoutput>

<cfif NewsletterAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="newsletters">
		<cfinvokeargument name="XMLFields" value="NewsletterID,DateCreated,NewsletterName,NLHeader,DateLastSent,NLBody,newslettersentTo,NLFooter,ReturnEmailAddress,ReturnURL">
		<cfinvokeargument name="XMLIDField" value="NewsletterID">
		<cfinvokeargument name="XMLIDValue" value="#NewsletterID#">
	</cfinvoke>
	<cfset NewsletterID=0>
	<cfset NewsletterAction="List">
</cfif>
		
<cfif NewsletterID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="newsletters">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="newsletters">
		<cfinvokeargument name="IDFieldName" value="NewsletterID">
		<cfinvokeargument name="IDFieldValue" value="#NewsletterID#">
	</cfinvoke>
	<cfoutput query="newsletters">
		<cfset NewsletterName=#NewsletterName#>
		<cfset DateCreated=#DateCreated#>
		<cfset NLHeader=#replace(NLHeader,"~",",","ALL")#>
		<cfset DateLastSent=#replace(DateLastSent,"~",",","ALL")#>
		<cfset NLBody=#replace(NLBody,"~",",","ALL")#>
		<cfset newslettersentTo=#newslettersentTo#>
		<cfset NLFooter=#replace(NLFooter,"~",",","ALL")#>
		<cfset ReturnEmailAddress=#ReturnEmailAddress#>
		<cfset ReturnURL=#ReturnURL#>
	</cfoutput>
	<cfset NewsletterAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.NLHeader=#replace(form.NLHeader,",","~","ALL")#>
	<cfset form.NLFooter=#replace(form.NLFooter,",","~","ALL")#>
	<cfif #form.datelastsent# is ''><cfset form.datelastsent="none"></cfif>
	<cfif #form.newslettersentTo# is ''><cfset form.newslettersentTo="0"></cfif>
	<cfset form.NewsletterName=#replace(form.NewsletterName,",","~","ALL")#>
	<cfset form.NLBody=#replace(form.NLBody,",","~","ALL")#>
	<cfif NewsletterID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="newsletters">
			<cfinvokeargument name="XMLFields" value="DateCreated,NewsletterName,NLHeader,DateLastSent,NLBody,newslettersentTo,NLFooter,ReturnEmailAddress,ReturnURL">
			<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.NewsletterName#,#form.NLHeader#,#form.DateLastSent#,#form.NLBody#,#form.newslettersentTo#,#form.NLFooter#,#form.ReturnEmailAddress#,#form.ReturnURL#">
			<cfinvokeargument name="XMLIDField" value="NewsletterID">
			<cfinvokeargument name="XMLIDValue" value="#NewsletterID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="newsletters">
			<cfinvokeargument name="XMLFields" value="DateCreated,NewsletterName,NLHeader,DateLastSent,NLBody,newslettersentTo,NLFooter,ReturnEmailAddress,ReturnURL">
			<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.NewsletterName#,#form.NLHeader#,#form.DateLastSent#,#form.NLBody#,#form.newslettersentTo#,#form.NLFooter#,#form.ReturnEmailAddress#,#form.ReturnURL#">
			<cfinvokeargument name="XMLIDField" value="NewsletterID">
		</cfinvoke>
	</cfif>
	<cfset NewsletterAction="list">
	<cfset NewsletterName="none">
	<cfset DateCreated = #now()#>
	<cfset NewsletterID = 0>
	<cfset NLHeader='none'>
	<cfset DateLastSent=''>
	<cfset NLBody='0'>
	<cfset newslettersentTo="0">
	<cfset NLFooter='none'>
	<cfset ReturnEmailAddress='none'>
	<cfset ReturnURL='none'>
</cfif>

<cfoutput>
<h1>Create/Send A Newsletter</h1>

<cfif NewsletterAction is "Add" or NewsletterAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="NewsletterID" value="#NewsletterID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="NewsletterAction" value="#NewsletterAction#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="DateLastSent" value="#DateLastSent#">
<input type="hidden" name="newslettersentTo" value="#newslettersentTo#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date Created: </TD>
    <TD>
	
		#dateformat(DateCreated,'mm/dd/yyyy')#
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date Last Sent: </TD>
    <TD>
		<cfif DateLastSent is "none">
		<cfelse>
		#dateformat(DateLastSent,'mm/dd/yyyy')#
		</cfif>
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Mailing List(s) this newsletter last sent to: </TD>
    <TD>
	
		#newslettersentTo#
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Title of this Newsletter: </TD>
    <TD>
	
		<INPUT type="text" name="NewsletterName" value="#NewsletterName#" maxLength="100">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Header: </TD>
    <TD>
	<a href="javascript:GetEditor('thisform','NLHeader')" class=box>Click here to edit the Header</a><br>
		<textarea name="NLHeader" cols="50" rows="5">#NLHeader#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Body: </TD>
    <TD><a href="javascript:GetEditor('thisform','NLBody')" class=box>Click here to edit the Body</a><br>
		<textarea name="NLBody" cols="50" rows="5">#NLBody#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Footer: </TD>
    <TD><a href="javascript:GetEditor('thisform','NLFooter')" class=box>Click here to edit the Footer</a><br>
		<textarea name="NLFooter" cols="50" rows="5">#NLFooter#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Email Address to sent this newsletter from: </TD>
    <TD>
	
		<INPUT type="text" name="ReturnEmailAddress" value="#ReturnEmailAddress#" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> URL to attach to the newsletter to send a viewer to your site: </TD>
    <TD>
	
		<INPUT type="text" name="REturnURL" value="#REturnURL#" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>
</CFOUTPUT>

<cfif NewsletterAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&NewsletterAction=Add">Create A New Newsletter</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="newsletters">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllNewsletters">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="newsletters">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your NewsLetters</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>Date Created</p></td>
	<td><p>Date Last Sent</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllNewsletters">
	<tr>
	<td><p>#NewsletterID#</p></td>
	<td><p>#NewsletterName#</p></td>
	<td><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p></td>
	<td><cfif #DateLastSent# neq "none"><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p><cfelse>&nbsp;</cfif></td>
	<td><a href= "adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Delete&action=#action#">Delete</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Send&action=#action#">Send</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

