<cfparam name="subscriberID" default=0>
<cfparam name="viewFormReplies" default="List">
<cfparam name="Firstname" default="none">
<cfparam name="Lastname" default="none">
<cfparam name="DateSubscribed" default="#now()#">
<cfparam name="EmailAddress" default="none">
<cfparam name="Status" default="homepage">
<cfparam name="ListName" default="">
<cfparam name="alphabet" default="a">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForms">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="forms">
	<cfinvokeargument name="SElectStatement" value=" where formfilename='#listname#'">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Subscribers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="#ListName#">
</cfinvoke>
<cfoutput>
<p>No. Of Subscribers for <strong>#AllForms.FormTitle#</strong>: #Subscribers.recordcount#</p>

<cfset column_headers=#Subscribers.columnlist#>
<cfset HeaderCount=Listlen(#column_headers#)>
<cfset ColumnCount=#headerCount# + 1>
<cfset query_name="Subscribers">
<table border="1" align="CENTER">
<th colspan="#ColumnCount#" align="CENTER" bgcolor="Maroon"><p>Your Subscribers</p></th>
<tr>
<cfloop index="theFieldname" list="#column_headers#">
	<td><p>#theFieldname#</p></td>
</cfloop>
<td><p>Actions</p></td>
</tr>
</cfoutput>

<cfoutput query="Subscribers">
<tr>
<cfloop index="theFieldname" list="#column_headers#">
	<cfset theField=#query_name# & "." & #theFieldname#>
	<cfset theVAlue=#evaluate(thefield)#>
	<td><p>#theVAlue#</p></td>
</cfloop>

<td><a href= "adminheader.cfm?subscriberID=#subscriberID#&viewFormReplies=Edit&&action=#action#&ListName=#ListName#&Alphabet=#Alphabet#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?subscriberID=#subscriberID#&viewFormReplies=Delete&action=#action#&ListName=#ListName#&Alphabet=#Alphabet#">Delete</a></td>
</tr>
</cfoutput>

</table>

