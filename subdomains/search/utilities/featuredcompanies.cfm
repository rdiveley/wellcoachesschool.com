
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
<cfparam name="PositionID" default="1">
<cfparam name="tPositionID" default="1">
<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="featuredCompanies">
		<cfinvokeargument name="XMLFields" value="TypeID,TypeDescription,TypeName,DateToStart,DateToEnd,PositionID">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="featuredCompanies">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="featuredCompanies">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="featuredCompanies">
		<cfset TypeName=#TypeName#>
		<cfset DateToStart=#DateToStart#>
		<cfset TypeDescription=#TypeDescription#>
		<cfset DateToEnd=#DateToEnd#>
		<cfset PositionID=#PositionID#>
		<cfif not isnumeric(PositionID)><cfset tPositionID=0><cfelse><cfset tPositionID=#PositionID#></cfif>
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
	<cfset NewID=#form.PositionID#>
	<cfset tLen=Len(NewID)>
	<cfloop index="XX" from="#tLen#" to="9">
		<cfset NewID="0#NewID#">
	</cfloop>
	<cfset PositionID=#NewID#>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="featuredCompanies">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateToStart,DateToEnd,PositionID">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateToStart#,#form.DateToEnd#,#PositionID#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="featuredCompanies">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,DateToStart,DateToEnd,PositionID">
			<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.DateToStart#,#form.DateToEnd#,#PositionID#">
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
	<cfset PositionID=1>
</cfif>

<cfoutput>
<h1>Featured Companies</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<TABLE>

	<TR>
	<TD valign="top"> Company Name: </TD>
    <TD>
	
		<INPUT type="text" name="TypeName" value="#TypeName#" size=50 maxLength="125">
		
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> URL: </TD>
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
	<tr>
	<TD valign="top"> Position in list: </TD>
    <TD>
	<select name="positionid">
		<cfloop index="i" from="1" to="100">
			<option value="#i#"<cfif #i# is #int(tPositionID)#> selected</cfif>>#i#</option>
		</cfloop>
	</select>
	</TD>
	</TR>
	
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="featuredCompanies">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllfeaturedCompanies">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="featuredCompanies">
		<cfinvokeargument name="orderbystatement" value=" order by positionID">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Your Member Types</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Date To Start</p></td>
<td><p>Date To End</p></td>
<td><p>Position</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllfeaturedCompanies">
<tr>
<td><p>#TypeID#</p></td>
<td><p>#TypeName#</p></td>
<td><p><cfif isdate(#datetostart#)>#dateformat(DateToStart,'mm/dd/yyyy')#</cfif></p></td>
<td><p><cfif isdate(#datetoend#)>#dateformat(DateToEnd,'mm/dd/yyyy')#</cfif></p></td>
<td><p><cfif isNumeric(PositionID)>#int(PositionID)#<cfelse>0</cfif></p></td>
<td><a href= "adminheader.cfm?TypeID=#TypeID#&TypeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

