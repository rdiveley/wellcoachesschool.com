<cfparam name="INvoice" default=0>
<cfparam name="INvoiceAction" default="Add">
<cfparam name="MemberID" default="0">
<cfparam name="Cardname" default="">
<cfparam name="CCExpire" default="">
<cfparam name="FeePaid" default=0>
<cfparam name="TypeID" default=0>
<cfparam name="CCNo" default="">
<cfparam name="Country" default="">
<cfparam name="CCType" default="">
<cfparam name="Address1" default="">
<cfparam name="City" default="">
<cfparam name="State" default="">
<cfparam name="PostalCode" default="">
<cfparam name="DateCreated" default="">

<cfinvoke method="GetAllMember"  returnvariable="allmembers"
	component="#Application.WebSitePath#.utilities.membersXML">
</cfinvoke>

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
	
<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllInvoices">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="members">
		<cfinvokeargument name="orderbystatement" value=" order by StartDate desc">
	</cfinvoke>
	<!--- <cfinvoke component="#Application.WebSitePath#.utilities.membersXML" 
		method="getInvoices" returnvariable="AllInvoices">
	</cfinvoke> --->
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p><font color="#FFFFFF">Member Registration Fees Paid</font></p></th>
	<tr>
	<td><p>Member ID</p></td>
	<td><p>Member</p></td>
	<td><p>Fee Paid</p></td>
	<td><p>Date</p></td>
	<td><p>For</p></td>
	</tr>
		<cf_nextrecords Records="#AllInvoices.RecordCount#"
			 ThisPageName="adminheader.cfm"
			 RecordsToDisplay="25"
			 DisplayText="Record"
			 DisplayFont="Arial"
			 FontSize=2
			 UseBold="Yes"
			 ExtraURL="&action=#action#">
	<cfoutput query="AllInvoices" StartRow=#SR# MaxRows=25>
		<tr>
		<td><p>#int(memberID)#</p></td>
		<td><p>
		<cfquery name="Thismember" dbtype="query">
			select firstname, lastname from allmembers where memberid='#memberid#'
		</cfquery>
		#ThisMember.firstname# #thismember.lastname#
		</p></td>
		<td><p>#FeePaid#</p></td>
		<td><p>#Dateformat(StartDate,"mm/dd/yyyy")#</p>
		</td>
		<td><p>
		<cfquery name="Pricing" dbtype="query">
			select PricingName,PricingDescription from AllMemberPricing where PricingID='#TypeID#'
		</cfquery>
		#Pricing.PricingName#
		</p></td>
		</tr>
		</cfoutput>
	</table>
</cfif>