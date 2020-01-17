
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="employeeTypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="TypeName" default="">
<cfparam name="TypeDescription" default="">
<cfparam name="priceper" default="month">
<cfparam name="typeprice" default="0">

<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeeTypes">
		<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,priceper,typeprice">
		<cfinvokeargument name="XMLIDField" value="employeeTypeID">
		<cfinvokeargument name="XMLIDValue" value="#employeeTypeID#">
	</cfinvoke>
	<cfset employeeTypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif employeeTypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employeeTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeeTypes">
		<cfinvokeargument name="IDFieldName" value="employeeTypeID">
		<cfinvokeargument name="IDFieldValue" value="#employeeTypeID#">
	</cfinvoke>
	<cfoutput query="employeeTypes">
		<cfset TypeName=#TypeName#>
		<cfset priceper=#priceper#>
		<cfset TypeDescription=#TypeDescription#>
		<cfset typeprice=#typeprice#>
	</cfoutput>
	<cfset TypeAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.TypeDescription# is ''><cfset form.TypeDescription="none"></cfif>
	<cfset form.TypeDescription = replace(#form.TypeDescription#,",","~","ALL")>
	<cfif #form.TypeName# is ''><cfset form.TypeName="none"></cfif>
	<cfset form.TypeName = replace(#form.TypeName#,",","~","ALL")>
	<cfif employeeTypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="employeeTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,priceper,typeprice">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.priceper#,#form.typeprice#">
			<cfinvokeargument name="XMLIDField" value="employeeTypeID">
			<cfinvokeargument name="XMLIDValue" value="#employeeTypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="employeeTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,priceper,typeprice">
			<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.priceper#,#form.typeprice#">
			<cfinvokeargument name="XMLIDField" value="employeeTypeID">
		</cfinvoke>
	</cfif>
	<cfset TypeAction="list">
	<cfset TypeName="">
	<cfset priceper = "month">
	<cfset employeeTypeID = 0>
	<cfset TypeDescription=''>
	<cfset TypeName=#TypeName#>
	<cfset typeprice='0'>
</cfif>

<cfoutput>
<h1>employeeTypes</h1>
<cfform action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="employeeTypeID" value="#employeeTypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<TABLE>

	<TR>
	<TD valign="top"> employee Type: </TD>
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
	<td valign=top> Price Per</td>
	<td>
	<select name="priceper">
		<option value="day">Day</option>
		<option value="week">Week</option>
		<option value="month">Month</option>
		<option value="quarter">Quarter</option>
		<option value="sixmonths">Six Months</option>
		<option value="annual">Year</option>
	</select>
	</td>
	</tr>
	<TR>
	<TD valign="top"> Price:<br>DO NOT enter a $ </TD>
    <TD>
		<cfinput name="typeprice" type="text" value="#typeprice#" required="no" validate="float">
	</TD>
	</TR>
	
	
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cfFORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="employeeTypes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllemployeeTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeeTypes">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your employee Types</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Per</p></td>
<td><p>Price</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllemployeeTypes">
<tr>
<td><p>#employeeTypeID#</p></td>
<td><p>#TypeName#</p></td>
<td><p>#priceper#</p></td>
<td><p>#typeprice#</p></td>

<td><a href= "adminheader.cfm?employeeTypeID=#employeeTypeID#&TypeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?employeeTypeID=#employeeTypeID#&TypeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

