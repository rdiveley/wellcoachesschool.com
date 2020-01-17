<cfparam name="DealerID" default=0>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMembers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Members">
	<cfinvokeargument name="OrderByStatement" value="order by lastname">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="AffCustomers">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllAffCustomers">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffCustomers">
	</cfinvoke>
</cfif>

<cfoutput>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Affiliates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Affiliates">
	<cfinvokeargument name="IDFieldName" value="DealerID">
	<cfinvokeargument name="IDFieldValue" value="#DealerID#">
</cfinvoke>
<cfset DealerName="#Affiliates.firstname# #Affiliates.Lastname#">
<h1>Affiliate Program Customers for #DealerName#</h1>

</cfoutput>

<cfif #TheFileExists#>

<table border="1" align="CENTER">

<tr>
<td><p>ID</p></td>
<td><p>Company name</p></td>
<td><p>Contact name</p></td>
<td><p>Start Date</p></td>
<td><p>Status</p></td>
</tr>
<cfoutput query="AllAffCustomers">
<cfquery name="GetCustomer" dbtype="query">
	select * from AllMembers where memberid='#UserID#'
</cfquery>
<tr>
<td><p>#int(AffCustID)#</p></td>
<td><p>#GetCustomer.companyname#</p></td>
<td><p>#GetCustomer.firstname# #GetCustomer.lastname#</p></td>
<td><p>#dateformat(datestarted,"mm/dd/yyyy")#</p></td>
<td><p><cfif #GetCustomer.active#>Active<cfelse>Not Active</cfif></p></td>
</tr>
</cfoutput>
</table>

</cfif>