<cfparam name="CouponID" default=0>
<cfparam name="CouponAction" default="List">
<cfparam name="DateStarted" default="none">
<cfparam name="CouponAmount" default="none">
<cfparam name="DateEnded" default="none">
<cfparam name="CouponCode" default="homepage">
<cfparam name="CouponsRedeemed" default="0">

<cfif CouponAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Coupons">
		<cfinvokeargument name="XMLFields" value="CouponID,CouponAmount,DateStarted,DateEnded,CouponCode,CouponsRedeemed">
		<cfinvokeargument name="XMLIDField" value="CouponID">
		<cfinvokeargument name="XMLIDValue" value="#CouponID#">
	</cfinvoke>
	<cfset CouponID=0>
	<cfset CouponAction="List">
</cfif>
		
<cfif CouponID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Coupons">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Coupons">
		<cfinvokeargument name="IDFieldName" value="CouponID">
		<cfinvokeargument name="IDFieldValue" value="#CouponID#">
	</cfinvoke>
	<cfoutput query="Coupons">
		<cfset DateStarted=#DateStarted#>
		<cfset CouponAmount=#CouponAmount#>
		<cfset DateEnded=#DateEnded#>
		<cfset CouponCode=#CouponCode#>
		<cfset CouponsRedeemed=#CouponsRedeemed#>
	</cfoutput>
	<cfset CouponAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif CouponID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Coupons">
			<cfinvokeargument name="XMLFields" value="CouponAmount,DateStarted,DateEnded,CouponCode,CouponsRedeemed">
		<cfinvokeargument name="XMLFieldData" value="#form.CouponAmount#,#form.DateStarted#,#form.DateEnded#,#form.CouponCode#,#form.CouponsRedeemed#">
			<cfinvokeargument name="XMLIDField" value="CouponID">
			<cfinvokeargument name="XMLIDValue" value="#CouponID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Coupons">
			<cfinvokeargument name="XMLFields" value="CouponAmount,DateStarted,DateEnded,CouponCode,CouponsRedeemed">
		<cfinvokeargument name="XMLFieldData" value="#form.CouponAmount#,#form.DateStarted#,#form.DateEnded#,#form.CouponCode#,#form.CouponsRedeemed#">
			<cfinvokeargument name="XMLIDField" value="CouponID">
		</cfinvoke>
	</cfif>
	<cfset CouponAction="list">
	<cfset DateStarted="none">
	<cfset CouponID = 0>
	<cfset CouponAmount='none'>
	<cfset DateEnded='none'>
	<cfset CouponCode='homepage'>
	<cfset CouponsRedeemed = 0>
</cfif>

<cfoutput>
<h1>Coupons</h1>

<cfif CouponAction is "Add" or CouponAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="CouponID" value="#CouponID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CouponAction" value="#CouponAction#">
<TABLE>
	<TR>
	<TD valign="top"> Coupon Percent: </TD>
    <TD>
	
		<INPUT type="text" name="CouponAmount" value="#CouponAmount#" size="10" maxLength="10"><br>
		enter only a whole number with no percent sign (i.e. entering 10 means 10%)
		
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> No. of Coupons Redeemed: </TD>
    <TD>
	
		<INPUT type="text" name="CouponsRedeemed" value="#CouponsRedeemed#" maxLength="10">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Redemption Code: </TD>
    <TD>
		<INPUT type="text" name="CouponCode" value="#CouponCode#" maxLength="10">
		
	</TD>
	</TR>
	<TR>
	<TD valign="top"> Date to Start: </TD>
    <TD>
	
		<INPUT type="DateStarted" name="DateStarted" value="#DateStarted#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
	<tr>
	<TD valign="top"> Date to Retire Coupon: </TD>
    <TD>
	
		<INPUT type="text" name="DateEnded" value="#DateEnded#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
	
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</cfif>
</CFOUTPUT>

<cfif CouponAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&CouponAction=Add">Add A New Coupon</a></cfoutput>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="coupons">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>
	<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCoupons">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="coupons">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Your Coupons</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Coupon Amount</p></td>
	<td><p>## of Coupons Redeemed</p></td>
	<td><p>Code</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AllCoupons">
	<tr>
	<td><p>#CouponID#</p></td>
	<td><p>#CouponAmount#</p></td>
	<td><p>#CouponsRedeemed#</p></td>
	<td><p>#CouponCode#</p></td>
	
	<td><a href= "adminheader.cfm?CouponID=#CouponID#&CouponAction=Edit&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CouponID=#CouponID#&CouponAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

