<cfparam name="ListID" default=0>
<cfparam name="ListAction" default="List">
<cfparam name="ListName" default="none">
<cfparam name="MLDescription" default="none">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="DateLastSent" default="">
<cfparam name="NoOfSubscribers" default="0">
<cfparam name="NewsletterIDLastSent" default="0">
<cfparam name="AddToList" default="0">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMailingLists">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MailingLists">
</cfinvoke>

<cfif ListAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MailingLists">
		<cfinvokeargument name="XMLFields" value="ListID,DateCreated,ListName,MLDescription,DateLastSent,NoOfSubscribers,NewsletterIDLastSent,AddToList">
		<cfinvokeargument name="XMLIDField" value="ListID">
		<cfinvokeargument name="XMLIDValue" value="#ListID#">
	</cfinvoke>
	<cfset ListID=0>
	<cfset ListAction="List">
</cfif>
		
<cfif ListID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="MailingLists">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MailingLists">
		<cfinvokeargument name="IDFieldName" value="ListID">
		<cfinvokeargument name="IDFieldValue" value="#ListID#">
	</cfinvoke>
	<cfoutput query="MailingLists">
		<cfset ListName=#ListName#>
		<cfset DateCreated=#DateCreated#>
		<cfset MLDescription=#replace(MLDescription,"~",",","ALL")#>
		<cfset DateLastSent=#replace(DateLastSent,"~",",","ALL")#>
		<cfset NoOfSubscribers=#NoOfSubscribers#>
		<cfset NewsletterIDLastSent=#NewsletterIDLastSent#>
		<Cfset AddToList=#AddToList#>
	</cfoutput>
	<cfif ListAction neq "download">
	<cfset ListAction="update"></cfif>
</cfif>

<cfif ListAction is "download">
	<CF_aGr_password	MODE="ALPHA"
		CASE="MIXED"
		LENGHT="15"
		VAR="Download">
	<cfset TheFieldData=''>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Subscribers">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="#ListName#">
	</cfinvoke>
	<cfset theFieldData=#Subscribers.columnlist#>
	<cffile action="append" file="#Application.Uploadpath#\files\downloads\#Download#.csv" output="#TheFieldData#" addnewline="yes">
	<cfoutput query="subscribers">
		<cfset TheFieldData="#DateSubscribed#,#EmailAddress#,#Firstname#,#Lastname#,#Status#,#subscriberID#">
		<cffile action="append" file="#Application.Uploadpath#\files\downloads\#Download#.csv" output="#TheFieldData#" addnewline="yes">
	</cfoutput>
	<cfoutput><h1>Here is your file.  Click the file name to download. <a href="../files/downloads/#download#.csv">#Download#.csv</a></h1></cfoutput>
	<cfset ListAction="List">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.MLDescription=#replace(form.MLDescription,",","~","ALL")#>
	<cfset form.DateLastSent=#replace(form.DateLastSent,",","~","ALL")#>
	<cfif #form.datelastsent# is ''><cfset form.datelastsent="none"></cfif>
	<cfset form.ListName=#replace(form.ListName,",","~","ALL")#>
	<cfif ListID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MailingLists">
			<cfinvokeargument name="XMLFields" value="DateCreated,ListName,MLDescription,DateLastSent,NoOfSubscribers,NewsletterIDLastSent,AddToList">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.ListName#,#form.MLDescription#,#form.DateLastSent#,#form.NoOfSubscribers#,#form.NewsletterIDLastSent#,#form.AddToList#">
			<cfinvokeargument name="XMLIDField" value="ListID">
			<cfinvokeargument name="XMLIDValue" value="#ListID#">
		</cfinvoke>
	<cfelse>
		<CF_aGr_password
			MODE="ALPHA"
			CASE="MIXED"
			LENGHT=20
			VAR="ListName">
		<cfset form.listname=#listname#>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MailingLists">
			<cfinvokeargument name="XMLFields" value="DateCreated,ListName,MLDescription,DateLastSent,NoOfSubscribers,NewsletterIDLastSent,AddToList">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.ListName#,#form.MLDescription#,#form.DateLastSent#,#form.NoOfSubscribers#,#form.NewsletterIDLastSent#,#form.AddToList#">
			<cfinvokeargument name="XMLIDField" value="ListID">
		</cfinvoke>
	</cfif>
	<cfset ListAction="list">
	<cfset ListName="none">
	<cfset DateCreated = #now()#>
	<cfset ListID = 0>
	<cfset MLDescription='none'>
	<cfset DateLastSent=''>
	<cfset NoOfSubscribers='0'>
	<cfset NewsletterIDLastSent="0">
	<cfset AddToList=0>
</cfif>

<cfoutput>
<h1>Mailing Lists</h1>

<cfif ListAction is "Add" or ListAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="ListID" value="#ListID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ListAction" value="#ListAction#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="DateLastSent" value="#DateLastSent#">
<input type="hidden" name="NewsletterIDLastSent" value="#NewsletterIDLastSent#">
<input type="hidden" name="ListName" value="#ListName#">
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
	<TD valign="top"> Newsletter this list last sent to: </TD>
    <TD>
	
		#NewsletterIDLastSent#
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> List Description: </TD>
    <TD>
	
		<textarea name="MLDescription" cols="50" rows="5">#MLDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> ## of Subscribers: </TD>
    <TD>
	
		<INPUT type="text" name="noOfSubscribers" value="#noOfSubscribers#" maxLength="25">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Add to Listing on Newsletter Subscription Function: </TD>
    <TD>
		<select name="AddToList">
			<option value="0"<cfif #AddToList# is 0> selected</cfif>>No</option>
			<option value="1"<cfif #AddToList# is 1> selected</cfif>>Yes</option>
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</fORM>
</cfif>
</CFOUTPUT>

<cfif ListAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&ListAction=Add">Add A New Mailing List</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="MailingLists">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllMailingLists">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MailingLists">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Mailing Lists</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Description</p></td>
	<td><p>Date Created</p></td>
	<td><p>Date Last Sent</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllMailingLists">
	<tr>
	<td><p>#int(ListID)#</p></td>
	<td><p>#MLDescription#</p></td>
	<td><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p></td>
	<td><cfif #DateLastSent# neq "none"><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p><cfelse>&nbsp;</cfif></td>
	<td nowrap><a href= "adminheader.cfm?ListID=#ListID#&ListAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ListID=#ListID#&ListAction=Delete&action=#action#">Delete</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ListID=#ListID#&ListAction=download&action=#action#">Download</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

