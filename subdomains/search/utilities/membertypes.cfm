
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="TypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="TypeName" default="">
<cfparam name="TypeDescription" default="">
<cfparam name="DateToStart" default="#now()#">
<cfparam name="DateToEnd" default="">

<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberTypes">
		<cfinvokeargument name="XMLFields" value="TypeID,TypeDescription,TypeName,DateToStart,DateToEnd">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="MemberTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberTypes">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="MemberTypes">
		<cfset TypeName=#TypeName#>
		<cfset DateToStart=#DateToStart#>
		<cfset TypeDescription=#TypeDescription#>
		<cfset DateToEnd=#DateToEnd#>
	</cfoutput>
	<cfset TypeAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif #form.DateToEnd# is '' or #Form.DateToEnd# is "none"><cfset form.DateToEnd="#dateadd('d',3653,form.DateToStart)#"></cfif>
	<cfif #form.TypeDescription# is ''><cfset form.TypeDescription="none"></cfif>
	<cfset form.TypeDescription = replace(#form.TypeDescription#,",","~","ALL")>
	<cfif #form.TypeName# is ''><cfset form.TypeName="none"></cfif>
	<cfset form.TypeName = replace(#form.TypeName#,",","~","ALL")>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MemberTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateToStart,DateToEnd">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateToStart#,#form.DateToEnd#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MemberTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateToStart,DateToEnd">
			<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateToStart#,#form.DateToEnd#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
	</cfif>
	<cfset TypeAction="list">
	<cfset TypeName="">
	<cfset DateToStart = #now()#>
	<cfset TypeID = 0>
	<cfset TypeDescription=''>
	<cfset TypeName=#TypeName#>
	<cfset DateToEnd=''>
</cfif>

<cfoutput>
<h1>MemberTypes</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<TABLE>

	<TR>
	<TD valign="top"> Member Type: </TD>
    <TD>
	
		<INPUT type="text" name="TypeName" value="#TypeName#" size=50 maxLength="125">
		
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<TEXTAREA name="TypeDescription" cols=50 rows=5>#TypeDescription#</TEXTAREA>
	
	</TD>
	</TR>
	<tr>
	<td valign=top> Date To Start</td>
	<td><input type="text" name="DateToStart" value="<cfif isdate(#datetostart#)>#dateformat(DateToStart,'mm/dd/yyyy')#</cfif>"></td>
	</tr>
	<TR>
	<TD valign="top"> Date To End: </TD>
    <TD><cfif #DateToEnd# is "none"><cfset DateToEnd=''></cfif>
		<input type="text" name="datetoend" value="#dateformat(DateToEnd,'mm/dd/yyyy')#">
	</TD>
	</TR>
	
	
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="MemberTypes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllMemberTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberTypes">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Member Types</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Date To Start</p></td>
<td><p>Date To End</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllMemberTypes">
<tr>
<td><p>#TypeID#</p></td>
<td><p>#TypeName#</p></td>
<td><p><cfif isdate(#datetostart#)>#dateformat(DateToStart,'mm/dd/yyyy')#</cfif></p></td>
<td><p><cfif isdate(#datetoend#)>#dateformat(DateToEnd,'mm/dd/yyyy')#</cfif></p></td>

<td><a href= "adminheader.cfm?TypeID=#TypeID#&TypeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

