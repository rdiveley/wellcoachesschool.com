<cfparam name="GBID" default=0>
<cfparam name="GBAction" default="List">
<cfparam name="nickname" default="none">
<cfparam name="GBMessage" default="none">
<cfparam name="DateStarted" default="#now()#">
<cfparam name="DateEnded" default="">
<cfparam name="EmailAddress" default="none">
<cfparam name="GBTitle" default="none">
<cfparam name="GBStatus" default="1">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGBEntries">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="GBEntries">
</cfinvoke>

<cfif GBAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="GBEntries">
		<cfinvokeargument name="XMLFields" value="GBID,DateStarted,nickname,GBMessage,DateEnded,EmailAddress,GBTitle,GBStatus">
		<cfinvokeargument name="XMLIDField" value="GBID">
		<cfinvokeargument name="XMLIDValue" value="#GBID#">
	</cfinvoke>
	<cfset GBID=0>
	<cfset GBAction="List">
</cfif>
		
<cfif GBID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="GBEntries">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="GBEntries">
		<cfinvokeargument name="IDFieldName" value="GBID">
		<cfinvokeargument name="IDFieldValue" value="#GBID#">
	</cfinvoke>
	<cfoutput query="GBEntries">
		<cfset nickname=#nickname#>
		<cfset DateStarted=#DateStarted#>
		<cfset GBMessage=#replace(GBMessage,"~",",","ALL")#>
		<cfset DateEnded=#DateEnded#>
		<cfset EmailAddress=#EmailAddress#>
		<cfset GBTitle=#GBTitle#>
	</cfoutput>
	<cfset GBAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.gbstatus')><cfset form.gbstatus=0></cfif>
	<cfif form.emailaddress is ""><cfset form.emailaddress="none"></cfif>
	<cfif GBID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="GBEntries">
<cfinvokeargument name="XMLFields" value="DateStarted,nickname,GBMessage,DateEnded,EmailAddress,GBTitle,GBStatus">
		<cfinvokeargument name="XMLFieldData" value="#form.DateStarted#,#XMLformat(form.nickname)#,#XMLformat(form.GBMessage)#,#form.DateEnded#,#form.EmailAddress#,#XMLformat(form.GBTitle)#,#form.GBStatus#">
			<cfinvokeargument name="XMLIDField" value="GBID">
			<cfinvokeargument name="XMLIDValue" value="#GBID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="GBEntries">
<cfinvokeargument name="XMLFields" value="DateStarted,nickname,GBMessage,DateEnded,EmailAddress,GBTitle,GBStatus">
		<cfinvokeargument name="XMLFieldData" value="#form.DateStarted#,#XMLformat(form.nickname)#,#XMLformat(form.GBMessage)#,#form.DateEnded#,#form.EmailAddress#,#XMLformat(form.GBTitle)#,#form.GBStatus#">
			<cfinvokeargument name="XMLIDField" value="GBID">
		</cfinvoke>
	</cfif>
	<cfset GBAction="list">
	<cfset nickname="homepage">
	<cfset DateStarted = #now()#>
	<cfset GBID = 0>
	<cfset GBMessage='none'>
	<cfset DateEnded=''>
	<cfset EmailAddress='0'>
	<cfset GBTitle="none">
	<cfset GBStatus=1>
</cfif>

<cfoutput>
<h1>Guest Book Entries</h1>

<cfif GBAction is "Add" or GBAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="GBID" value="#GBID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="GBAction" value="#GBAction#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date to Start this entry: </TD>
    <TD>
	
		<cfinput name="DateStarted" type="text" value="#dateformat(DateStarted,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Start Date" validate="date">
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date to end this entry: </TD>
    <TD>
		<cfinput name="DateEnded" type="text" value="#dateformat(DateEnded,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the End Date" validate="date">
	</TD>
	<!--- field validation --->
	</TR>
		
	<TR>
	<TD valign="top"> Authorized: </TD>
    <TD>
		<cfif #GBStatus# is 1>
		<input type="checkbox" name="GBStatus" value="1" checked>
		<cfelse>
		<input type="checkbox" name="GBStatus" value="0">
		</cfif>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Title: </TD>
    <TD>
		<cfinput name="gbtitle" type="text" value="#GBTitle#" size="40" maxlength="100" required="yes" message="Please enter a title">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Content: </TD>
    <TD>
	
		<textarea cols=40 rows=5 name="GBMessage">#GBMessage#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Email Address: </TD>
    <TD>
	
		<input name="EmailAddress" type="text" value="#EmailAddress#" size=50 maxlength=255>
		
	</TD>
	<!--- field validation --->
	</TR>
	
		<tr>
	<td valign=top> Nick name of person making this entry</td>
	<td><cfinput name="nickname" type="text" value="#nickname#" required="yes" message="Please enter the nick name"></td>
	</tr>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>
</CFOUTPUT>

<cfif GBAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&GBAction=Add">Add A Guest Book Entry</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="GBEntries">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllGBEntries">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="GBEntries">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Guest Book Entries</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Title</p></td>
	<td><p>By</p></td>
	<td><p>Authorized</p></td>
	<td><p>Date to Start</p></td>
	<td><p>Date to End</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllGBEntries">
	<tr>
	<td><p>#GBID#</p></td>
	<td><p>#GBTitle#</p></td>
	<td><p>#nickname#</p></td>
	<td align=center><p><cfif #gbstatus# is 1>Yes<cfelse>No</cfif></p></td>
	<td><p>#dateformat(DateStarted,'mm/dd/yyyy')#</p></td>
	<td><cfif #DateEnded# neq "none"><p>#dateformat(DateEnded,'mm/dd/yyyy')#</p><cfelse>&nbsp;</cfif></td>
	<td><a href= "adminheader.cfm?GBID=#GBID#&GBAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?GBID=#GBID#&GBAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

