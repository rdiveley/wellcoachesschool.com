
<cfparam name="TypeAction" default="list">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="orderbystatement" value=" order by pagename">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="JobTypes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="JobTypes">
		<cfinvokeargument name="ORderbyStatement" value=" order by typename">
	</cfinvoke>
</cfif>

<cfparam name="TypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="TypeName" default="">
<cfparam name="TypeDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="TypePageName" default="homepage">

<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="JobTypes">
		<cfinvokeargument name="XMLFields" value="TypeID,TypeDescription,TypeName,TypePageNam">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="JobTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="JobTypes">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="JobTypes">
		<cfset TypeName=#TypeName#>
		<cfset DateCreated=#DateCreated#>
		<cfset tTypeDescription=#TypeDescription#>
		<cfset TypeDescription=replace(#tTypeDescription#,"~",",","ALL")>
		<cfset TypePageName=#TypePageName#>
	</cfoutput>
	<cfset TypeAction="update">
</cfif>

<cfif isDefined('form.submit')>
	
	<cfset form.TypeDescription=replace(#form.TypeDescription#,",","~","ALL")>
	<Cfif #trim(form.TypeDescription)# is ''><cfset form.TypeDescription="none"></Cfif>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="JobTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,TypePageName">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.TypePageName#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="JobTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,TypeName,TypePageName">
			<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.TypeName#,#form.TypePageName#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
	</cfif>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="JobTypes">
	</cfinvoke>
	<cfset TheFileExists="true">
	<cfset TypeAction="list">
	<cfset TypeName="">
	<cfset DateCreated = #now()#>
	<cfset TypeID = 0>
	<cfset TypeDescription=''>
	<cfset TypeName=#TypeName#>
	<cfset TypePageName='homepage'>
</cfif>

<cfoutput>
<h1>Job Types</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="TypeAction" value="#TypeAction#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Job Type Name: </TD>
	<TD>
	
		<INPUT type="text" name="TypeName" value="#TypeName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Job Type Description: </TD>
	<TD>
	
		<TEXTAREA name="TypeDescription" cols=50 rows=5>#TypeDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>


	
	<TR>
	<TD valign="top"> Select Page to View this Job Type on: </TD>
    <TD>
		<select name="TypePageName">
			<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #allpages.PageName# is #typepagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		
	</TD>
	</TR>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfif #TheFileExists# is "true">
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Job Types</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Search Page</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllCategories">
<tr>
<td><p align=right>#int(TypeID)#</p></td>
<td><p>#TypeName#</p></td>
<td><p>#typepagename#</p></td>
<td><a href= "adminheader.cfm?TypeID=#TypeID#&TypeAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>
<p>&nbsp;</p>
