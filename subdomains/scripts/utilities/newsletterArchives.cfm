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
	method="GetXMLRecords" returnvariable="AllMailingLists">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MailingLists">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="orderbystatement" value=" order by pagename">
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

<cfif NewsletterAction is "preview">
<h1>Preview A Newsletter</h1>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="previewnewsletter">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="newsletters">
		<cfinvokeargument name="IDFieldName" value="NewsletterID">
		<cfinvokeargument name="IDFieldValue" value="#NewsletterID#">
	</cfinvoke>
	<style>.newP {color:black}</style>
	<cfoutput query="previewnewsletter">
		<cfset tNLHeader=replacenocase(#NLHeader#,"<p>","<p class=newP>","ALL")>
		<cfif tNLHeader is "none"><cfset tNLHeader=""></cfif>
		<cfset tNLBody=replacenocase(#NLBody#,"<p>","<p class=newP>","ALL")>
		<cfset tNLBody=#replace(tNLBody,"~",",","ALL")#>
		<cfset tNLFooter=replacenocase(#NLFooter#,"<p>","<p class=newP>","ALL")>
		<cfif tNLFooter is "none"><cfset tNLFooter=""></cfif>
	<TABLE bgcolor=white cellpadding="0" cellspacing="0" border="0" width="100%" style="color: black;">
		<TR>
		<style>.newP {color:black}</style>
		<TD style="color: black;">
			#replace(tNLHeader,"~",",","ALL")#<br>
			<Cfset tContent7=#tNLBody#>
				<cfset tPos=findnocase("ScriptIs",#tContent7#)>
				<cfif tPos gt 0>
					<cfset tLen = len(trim(#tContent7#))>
					<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
					<cfif #tpos# is 2>
						<cfset FirstHalf=''>
						<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
						<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfif lpos neq tlen>
							<cfset SecondHalf=#tContent7#>
						<cfelse>
							<cfset SecondHalf=''>
						</cfif>
					<cfelse>
						<cfset scriptLen=lPos - tPos >
						<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
						<cfoutput>#FirstHalf#</cfoutput>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
					</cfif>
					<cfif #SecondHalf# neq ''>
						<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
						<cfif tPos gt 0>
							<cfset tLen = len(trim(#SecondHalf#))>
							<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
							<cfif #tpos# is 2>
								<cfset FirstHalf=''>
								<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
								<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfif lpos neq tlen>
									<cfset ThirdHalf=#SecondHalf#>
								<cfelse>
									<cfset ThirdHalf=''>
								</cfif>
								<cfoutput>#ThirdHalf#</cfoutput>
							<cfelse>
								<cfset scriptLen=lPos - tPos >
								<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
								<cfoutput>#FirstHalf#</cfoutput>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
								<cfoutput>#ThirdHalf#</cfoutput>
							</cfif>
						<cfelse>
							<cfoutput>#SecondHalf#</cfoutput>
						</cfif>
					</cfif>
				<cfelse>
					<cfoutput>#tContent7#</cfoutput>
				</cfif><br>
			#replace(tNLFooter,"~",",","ALL")# </font>
		</td>
		</tr>
	</TABLE>
	<table><tr>
	<td><a href= "adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Delete&action=#action#">Delete</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Preview&action=#action#">Preview</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Send&action=#action#">Send</a></td>
	</tr></table>
	</CFOUTPUT>
</cfif>

<cfif NewsletterAction is "send">

	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="GetNewsLetter">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="newsletters">
		<cfinvokeargument name="IDFieldName" value="NewsletterID">
		<cfinvokeargument name="IDFieldValue" value="#NewsletterID#">
	</cfinvoke>

	<cfinclude template="../utilities/sendnewsletter.cfm">
	<cfif isdefined('form.sendit')>
		<cfset NewsletterID=0>
		<cfset NewsletterAction="List">
	</cfif>
</cfif>

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
		
<cfif NewsletterAction is "edit">
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
		<cfset ReturnURL=#replace(ReturnURL,"~",",","ALL")#>
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
	<cfset form.REturnURL=replace(#form.REturnURL#,",","~","ALL")>
	<cfif trim(form.returnurl) is ""><cfset form.returnurl="homepage"></cfif>
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

<cfif NewsletterAction is "Add" or NewsletterAction is "Update">
<h1>Create A Newsletter</h1>
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
		<cfquery name="MailListName" dbtype="query">
			select MLDescription from AllMailingLists
			where ListName='#Newslettersentto#'
		</cfquery>
		<cfif #MaillistName.recordcount# gt 0>
			#MailListName.MLDescription#
		<cfelse>
			#NewsletterSentTo#
		</cfif>
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
	<TD valign="top"> Email Address to send this newsletter from: </TD>
    <TD>
	
		<INPUT type="text" name="ReturnEmailAddress" value="#ReturnEmailAddress#" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Show on page: </TD>
    <TD>
	<select name="REturnURL" size="10" multiple>
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #listfindnocase(REturnURL,Pagename)#>selected</cfif>>#Pagename#
		</cfloop>
		</select>
		
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
<h1>Newsletters</h1>

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
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Delete&action=#action#')">Delete</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Preview&action=#action#">Preview</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NewsletterID=#NewsletterID#&NewsletterAction=Send&action=#action#">Send</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

