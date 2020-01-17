<cfparam name="subscriberID" default=0>
<cfparam name="SubscriberAction" default="List">
<cfparam name="Firstname" default="none">
<cfparam name="Lastname" default="none">
<cfparam name="DateSubscribed" default="#now()#">
<cfparam name="EmailAddress" default="none">
<cfparam name="Status" default="homepage">
<cfparam name="ListName" default="">
<cfparam name="alphabet" default="a">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllLists">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MailingLists">
</cfinvoke>

<cfif #ListName# is "">
	
	<form name="thisform" action="adminheader.cfm?action=<cfoutput>#action#</cfoutput>" method="post">
	<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Please select a Mailing List</font> 
	<select name="ListName" onChange="form.submit()">
		<cfoutput query="AllLists">
		<option value="#ListName#">#left(MLDescription,25)#</option>
		</cfoutput>
	</select> <input type="submit" name="gosubmit" value="GO">
	</form>
	<cfabort>
</cfif>

<cfif SubscriberAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="#ListName#">
		<cfinvokeargument name="XMLFields" value="subscriberID,DateSubscribed,Firstname,Lastname,EmailAddress,Status">
		<cfinvokeargument name="XMLIDField" value="subscriberID">
		<cfinvokeargument name="XMLIDValue" value="#subscriberID#">
	</cfinvoke>
	<cfset subscriberID=0>
	<cfset SubscriberAction="List">
</cfif>
		
<cfif subscriberID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="NLSubscribers">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="#ListName#">
		<cfinvokeargument name="IDFieldName" value="subscriberID">
		<cfinvokeargument name="IDFieldValue" value="#subscriberID#">
	</cfinvoke>
	<cfoutput query="NLSubscribers">
		<cfset Firstname=#Firstname#>
		<cfset DateSubscribed=#DateSubscribed#>
		<cfset Lastname=#replace(Lastname,"~",",","ALL")#>
		<cfset EmailAddress=#replace(EmailAddress,"~",",","ALL")#>
		<cfset Status=#Status#>
	</cfoutput>
	<cfset SubscriberAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.Lastname=#replace(form.Lastname,",","~","ALL")#>
	<cfset form.EmailAddress=#replace(form.EmailAddress,",","~","ALL")#>
	<cfset form.Firstname=#replace(form.Firstname,",","~","ALL")#>
	<cfif subscriberID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="#ListName#">
			<cfinvokeargument name="XMLFields" value="DateSubscribed,Firstname,Lastname,EmailAddress,Status">
		<cfinvokeargument name="XMLFieldData" value="#form.DateSubscribed#,#form.Firstname#,#form.Lastname#,#form.EmailAddress#,#form.Status#">
			<cfinvokeargument name="XMLIDField" value="subscriberID">
			<cfinvokeargument name="XMLIDValue" value="#subscriberID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="#ListName#">
			<cfinvokeargument name="XMLFields" value="DateSubscribed,Firstname,Lastname,EmailAddress,Status">
		<cfinvokeargument name="XMLFieldData" value="#form.DateSubscribed#,#form.Firstname#,#form.Lastname#,#form.EmailAddress#,#form.Status#">
			<cfinvokeargument name="XMLIDField" value="subscriberID">
		</cfinvoke>
	</cfif>
	<cfset SubscriberAction="list">
	<cfset Firstname="none">
	<cfset DateSubscribed = #now()#>
	<cfset subscriberID = 0>
	<cfset Lastname='none'>
	<cfset EmailAddress='none'>
	<cfset Status='homepage'>
</cfif>

<cfoutput>
<cfquery name="GetListDescription" dbtype="query">
	select MLDescription from AllLists where listname='#listname#'
</cfquery>
<h1>Subscribers for "#GetListDescription.MLDescription#"</h1>

<cfif SubscriberAction is "Add" or SubscriberAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="subscriberID" value="#subscriberID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="SubscriberAction" value="#SubscriberAction#">
<input type="hidden" name="ListName" value="#ListName#">
<input type="hidden" name="Alphabet" value="#Alphabet#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date Subscribed: </TD>
    <TD>
	
		<INPUT type="text" name="DateSubscribed" value="#dateformat(DateSubscribed,'mm/dd/yyyy')#" maxLength="16">
		(i.e. 12/31/1997)
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="DateSubscribed_date">
	</TR>
	
	<TR>
	<TD valign="top"> First name: </TD>
    <TD>
	
		<INPUT type="text" name="Firstname" value="#Firstname#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Last Name: </TD>
    <TD>
	
		<INPUT type="text" name="lastname" value="#lastname#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Email Address: </TD>
    <TD>
	
		<INPUT type="text" name="EmailAddress" value="#EmailAddress#" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Status: </TD>
    <TD>
	
		<select name="status">
			<option value="0"<cfif #Status# is 0> selected</cfif>>Pending</option>
			<option value="1"<cfif #Status# is 1> selected</cfif>>Active</option>
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</cfif>
</CFOUTPUT>

<cfif SubscriberAction is "list">

<cfoutput><a href="adminheader.cfm?Action=#Action#&SubscriberAction=Add&ListName=#ListName#">Add A New Subscriber</a></cfoutput><br>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="#ListName#">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Subscribers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="#ListName#">
		</cfinvoke>
	<p>No. Of Subscribers on this list: <cfoutput>#Subscribers.RecordCount#</cfoutput></p>
		<cfoutput>
	<form action="adminheader.cfm" method="post" name="findemail">
		<input type="hidden" name="SubscriberAction" value="List">
		<input type="hidden" name="action" value="#action#">
		<input type="hidden" name="ListName" value="#ListName#">
		<input type="text" name="alphabet"><input type="submit" name="emailsubmit" value="Find">
	</form>
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=a&ListName=#ListName#">A</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=b&ListName=#ListName#">B</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=c&ListName=#ListName#">C</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=d&ListName=#ListName#">D</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=e&ListName=#ListName#">E</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=f&ListName=#ListName#">F</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=g&ListName=#ListName#">G</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=h&ListName=#ListName#">H</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=i&ListName=#ListName#">I</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=j&ListName=#ListName#">J</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=k&ListName=#ListName#">K</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=l&ListName=#ListName#">L</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=m&ListName=#ListName#">M</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=n&ListName=#ListName#">N</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=o&ListName=#ListName#">O</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=p&ListName=#ListName#">P</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=q&ListName=#ListName#">Q</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=r&ListName=#ListName#">R</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=s&ListName=#ListName#">S</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=t&ListName=#ListName#">T</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=u&ListName=#ListName#">U</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=v&ListName=#ListName#">V</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=w&ListName=#ListName#">W</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=x&ListName=#ListName#">X</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=y&ListName=#ListName#">Y</a> | 
	<a href="adminheader.cfm?SubscriberAction=List&&action=#action#&alphabet=z&ListName=#ListName#">Z</a> |   <a href="adminheader.cfm?SubscriberAction=List&action=#action#&alphabet=showall&ListName=#ListName#">Show All</a>
		</cfoutput>
		<cfquery name="AllNLSubscribers" dbtype="query">
			select * from Subscribers
			<cfif #alphabet# neq "showall">
			where emailaddress like '#lcase(alphabet)#%' or emailaddress like '#ucase(alphabet)#%'
			</cfif>
			order by emailaddress
		</cfquery>
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Subscribers</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>Email Address</p></td>
	<td><p>Date Subscribed</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllNLSubscribers">
	<tr>
	<td><p>#int(subscriberID)#</p></td>
	<td><p>#Firstname# #lastname#</p></td>
	<td><p>#Emailaddress#</p></td>
	<td><p>#dateformat(datesubscribed,'mm/dd/yyyy')#</p></td>
	
	<td><a href= "adminheader.cfm?subscriberID=#subscriberID#&SubscriberAction=Edit&&action=#action#&ListName=#ListName#&Alphabet=#Alphabet#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?subscriberID=#subscriberID#&SubscriberAction=Delete&action=#action#&ListName=#ListName#&Alphabet=#Alphabet#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

