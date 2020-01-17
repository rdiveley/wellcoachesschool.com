<cfparam name="EventID" default=0>
<cfparam name="CalAction" default="List">
<cfparam name="nickname" default="none">
<cfparam name="EventDescription" default="none">
<cfparam name="DateStarted" default="#now()#">
<cfparam name="DateEnded" default="">
<cfparam name="EmailAddress" default="none">
<cfparam name="EventTitle" default="none">
<cfparam name="EventStatus" default="1">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Allcalevents">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="calevents">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllLinkCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="LinkCategories">
</cfinvoke>

<cfif CalAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="calevents">
		<cfinvokeargument name="XMLFields" value="EventID,DateStarted,nickname,EventDescription,DateEnded,EmailAddress,EventTitle,EventStatus">
		<cfinvokeargument name="XMLIDField" value="EventID">
		<cfinvokeargument name="XMLIDValue" value="#EventID#">
	</cfinvoke>
	<cfset EventID=0>
	<cfset CalAction="List">
</cfif>
		
<cfif EventID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="calevents">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="calevents">
		<cfinvokeargument name="IDFieldName" value="EventID">
		<cfinvokeargument name="IDFieldValue" value="#EventID#">
	</cfinvoke>
	<cfoutput query="calevents">
		<cfset nickname=#nickname#>
		<cfset DateStarted=#DateStarted#>
		<cfset EventDescription=#replace(EventDescription,"~",",","ALL")#>
		<cfset DateEnded=#DateEnded#>
		<cfset EmailAddress=#EmailAddress#>
		<cfset EventTitle=#replace(EventTitle,"~",",","ALL")#>
	</cfoutput>
	<cfset CalAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.EventStatus')><cfset form.EventStatus=0></cfif>
	<cfif form.emailaddress is ""><cfset form.emailaddress="none"></cfif>
	<cfset form.datestarting = "#form.DateStarted# #form.TimeStarted#">
	<cfset form.dateEnding = "#form.DateEnded# #form.TimeEnded#">
	<cfset form.eventdescription=replace(#form.eventdescription#,",","~","ALL")>
	<cfset form.EventTitle=replace(#form.EventTitle#,",","~","ALL")>
	<cfif EventID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="calevents">
<cfinvokeargument name="XMLFields" value="DateStarted,nickname,EventDescription,DateEnded,EmailAddress,EventTitle,EventStatus">
		<cfinvokeargument name="XMLFieldData" value="#form.datestarting#,#XMLformat(form.nickname)#,#XMLformat(form.EventDescription)#,#form.dateEnding#,#form.EmailAddress#,#XMLformat(form.EventTitle)#,#form.EventStatus#">
			<cfinvokeargument name="XMLIDField" value="EventID">
			<cfinvokeargument name="XMLIDValue" value="#EventID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="calevents">
<cfinvokeargument name="XMLFields" value="DateStarted,nickname,EventDescription,DateEnded,EmailAddress,EventTitle,EventStatus">
		<cfinvokeargument name="XMLFieldData" value="#form.datestarting#,#XMLformat(form.nickname)#,#XMLformat(form.EventDescription)#,#form.dateEnding#,#form.EmailAddress#,#XMLformat(form.EventTitle)#,#form.EventStatus#">
			<cfinvokeargument name="XMLIDField" value="EventID">
		</cfinvoke>
	</cfif>
	<cfset CalAction="list">
	<cfset nickname="homepage">
	<cfset DateStarted = #now()#>
	<cfset EventID = 0>
	<cfset EventDescription='none'>
	<cfset DateEnded=''>
	<cfset EmailAddress='0'>
	<cfset EventTitle="none">
	<cfset EventStatus=1>
</cfif>

<cfoutput>
<h1>Calendar Events</h1>

<cfif CalAction is "Add" or CalAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="EventID" value="#EventID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CalAction" value="#CalAction#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date/Time this event starts: </TD>
    <TD>
	
		<cfinput name="DateStarted" type="text" value="#dateformat(DateStarted,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Date" validate="date"> <cfinput name="TimeStarted" type="text" value="#timeformat(DateStarted,'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Time" validate="time"> (this is a 24 hour clock)
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date/Time this event ends: </TD>
    <TD>
		<cfinput name="DateEnded" type="text" value="#dateformat(DateEnded,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Date" validate="date"> <cfinput name="TimeEnded" type="text" value="#timeformat(DateEnded,'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Time" validate="time"> (this is a 24 hour clock)
	</TD>
	<!--- field validation --->
	</TR>
		
	<TR>
	<TD valign="top"> Authorized: </TD>
    <TD>
		<cfif #EventStatus# is 1>
		<input type="checkbox" name="EventStatus" value="1" checked>
		<cfelse>
		<input type="checkbox" name="EventStatus" value="0">
		</cfif>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Event Title: </TD>
    <TD>
		<cfinput name="EventTitle" type="text" value="#EventTitle#" size="40" maxlength="100" required="yes" message="Please enter a title">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Event Description: </TD>
    <TD>
	
		<textarea cols=40 rows=5 name="EventDescription">#EventDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Email Address of person managing this event: </TD>
    <TD>
	
		<input name="EmailAddress" type="text" value="#EmailAddress#" size=50 maxlength=255>
		
	</TD>
	<!--- field validation --->
	</TR>
	
		<tr>
	<td valign=top> Name of person managing this event</td>
	<td><cfinput name="nickname" type="text" value="#nickname#" required="yes" message="Please enter the nick name"></td>
	</tr>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>
</CFOUTPUT>

<cfif CalAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&CalAction=Add">Add An Event</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="calevents">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Allcalevents">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="calevents">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Events</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Title</p></td>
	<td><p>By</p></td>
	<td><p>Authorized</p></td>
	<td><p>Date to Start</p></td>
	<td><p>Date to End</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="Allcalevents">
	<tr>
	<td><p>#int(EventID)#</p></td>
	<td><p>#replace(EventTitle,"~",",","ALL")#</p></td>
	<td><p>#nickname#</p></td>
	<td align=center><p><cfif #EventStatus# is 1>Yes<cfelse>No</cfif></p></td>
	<td><p>#dateformat(DateStarted,'mm/dd/yyyy')# #timeformat(DateStarted,'hh:mm tt')#</p></td>
	<td><cfif #DateEnded# neq "none"><p>#dateformat(DateEnded,'mm/dd/yyyy')# #timeformat(DateEnded,'hh:mm tt')#</p><cfelse>&nbsp;</cfif></td>
	<td><a href= "adminheader.cfm?EventID=#EventID#&CalAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?EventID=#EventID#&CalAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

