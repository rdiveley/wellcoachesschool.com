<cfparam name="DealerID" default=0>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="AffDealerStats">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllAffDealerStats">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffDealerStats">
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
<h1>Affiliate Program Cummulative Statistics</h1>

</cfoutput>

<cfif #TheFileExists#>

<table border="1" align="CENTER">

<tr>
<td><p>Affiliate</p></td>
<td><p>Category ID</p></td>
<td><p>Due</p></td>
<td><p>YTD</p></td>
<td><p>Impressions Used</p></td>
<td><p>Last Check #</p></td>
<td><p>Last Amount Paid</p></td>
<td><p>Next Pay Date</p></td>
</tr>
<cfset TotalCommissionsDue=0>
<cfset TotalCOMMISSIONSYTD=0>
<cfset TotalIMPRESSIONSUSED=0>
<cfset TotalLASTPAIDAMT=0>
<cfoutput query="AllAffDealerStats" group="dealerid">
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Affiliates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Affiliates">
	<cfinvokeargument name="IDFieldName" value="DealerID">
	<cfinvokeargument name="IDFieldValue" value="#AllAffDealerStats.DealerID#">
</cfinvoke>
<tr>
<td><p>#affiliates.companyname# - #Affiliates.Firstname# #affiliates.lastname#</p></td>
<td><p>#int(CATEGORYID)#</p></td>
<td><p>#COMMISSIONSDUE#</p></td>
<td><p>#COMMISSIONSYTD#</p></td>
<td><p>#IMPRESSIONSUSED#</p></td>
<td><p>#LASTCHECKNO#</p></td>
<td><p>#LASTPAIDAMT#</p></td>
<td><p>#NextPayDate#</p></td>
<cfset TotalCommissionsDue=#TotalCommissionsDue# + #commissionsDue#>
<cfset TotalCOMMISSIONSYTD=#TotalCOMMISSIONSYTD# + #COMMISSIONSYTD#>
<cfset TotalIMPRESSIONSUSED=#TotalIMPRESSIONSUSED# + #IMPRESSIONSUSED#>
<cfset TotalLASTPAIDAMT=#TotalLASTPAIDAMT# + #LASTPAIDAMT#>
</tr>
</cfoutput>
<tr>
<td></td>
<cfoutput><th><p>Totals</p></th>
<th><p>#TotalCommissionsDue#</p></th>
<th><p>#TotalCOMMISSIONSYTD#</p></th>
<th><p>#TotalIMPRESSIONSUSED#</p></th>
<td></td>
<th><p>#TotalLASTPAIDAMT#</p></th></cfoutput>
<td></td>
</tr>
</table>
</cfif>
