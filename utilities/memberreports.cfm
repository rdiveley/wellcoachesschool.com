<cfparam name="ReportAction" default="MemberID">
<cfparam name="ascdesc" default="asc">

<cfif #ascdesc# is "asc"><cfset ascdesc="desc"><cfelse><cfset ascdesc="asc"></cfif>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="members">
	<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMemberPricing">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MemberPricing">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMemberTypes">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MemberTypes">
</cfinvoke>
	
<cfif #TheFileExists# is "true">
	<cfinvoke method="GetAllMember"  returnvariable="themembers"
		component="#Application.WebSitePath#.utilities.membersXML">
	</cfinvoke>
	<cfquery name="AllMembers" dbtype="query">
		select * from themembers
		order by #ReportAction# #ascdesc#
	</cfquery>
	<table border="1" align="CENTER">
	<tr><th colspan="7" align="CENTER" bgcolor="Maroon"><p>Member Report</p></th></tr>
	<cfoutput><tr><td bgcolor="maroon" colspan="7"><p>Click on column titles to sort - current sort is #reportaction# in #ascdesc# order</p></td></tr>
	<tr>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=memberid&ascdesc=#ascdesc#">ID</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=lastname&ascdesc=#ascdesc#">Member</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=feepaid&ascdesc=#ascdesc#">Fee Paid</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=startdate&ascdesc=#ascdesc#">Date Started</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=rebilldate&ascdesc=#ascdesc#">Re-bill Date</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=pricingid&ascdesc=#ascdesc#">Pricing Type</a></p></th>
	<th><p><a href="adminheader.cfm?action=#Action#&ReportAction=typeid&ascdesc=#ascdesc#">Member Category</a></p></th>
	</tr></cfoutput>
	
		<cfoutput query="allmembers">
		<tr>
		<td><p>#int(memberid)#</p></td>
		<td><p>#firstname# #lastname#</p></td>
		<td><p>#FeePaid#</p></td>
		<td><p>#Dateformat(startdate,"mm/dd/yyyy")#</p></td>
		<td><p>#Dateformat(rebilldate,"mm/dd/yyyy")#</p></td>
		<td><p>
		<cfquery name="Pricing" dbtype="query">
			select PricingName,PricingDescription from AllMemberPricing where PricingID='#PricingID#'
		</cfquery>
		#Pricing.PricingName#
		</p></td>
		<td><p>
		<cfquery name="Category" dbtype="query">
			select TypeName,TypeDescription from AllMemberTypes where TypeID='#TypeID#'
		</cfquery>
		#Category.TypeName#
		</p></td>
		</tr>
		</cfoutput>
	</table>
</cfif>