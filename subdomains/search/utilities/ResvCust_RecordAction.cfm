
<cfset Today=#dateformat(now())#>
<cfset Tomorrow=#dateadd("d",365,#today#)#>
<cfparam name="ResvCustAction" default="list">
<cfparam name="ResvCustID" default="0">
<cfparam name="TypeID" default="0">
<cfparam name="alphabet" default="a">

<CFif #ResvCustAction# is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ResvCusts">
		<cfinvokeargument name="XMLFields" value="ResvCustID,Active,CardName,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,Password,AffiliateID,Title,displayname,accesslevel,typeid,pricingid,rebilldate,lastmodified,websiteurl,occupation,online,feepaid,maritalstatus,sex,age,birthdate">
		<cfinvokeargument name="XMLIDField" value="ResvCustID">
		<cfinvokeargument name="XMLIDValue" value="#ResvCustID#">
	</cfinvoke>
	<cfset ResvCustID=0>
	<cfset ResvCustAction="List">
</cfif>

<CFif #ResvCustAction# is "update">

	<Cfif #form.cardname# is ''><cfset form.cardname="none"></Cfif>
	<Cfif #form.CCExpire# is ''><cfset form.CCExpire="none"></Cfif>
	<Cfif #form.CCNo# is ''><cfset form.CCNo="none"></Cfif>
	<Cfif #form.CCType# is ''><cfset form.CCType="none"></Cfif>
	<Cfif #form.Title# is ''><cfset form.Title="none"></Cfif>
	<cfset form.Title=replace(#form.Title#,",","~","ALL")>
	<Cfif #form.phonenumber# is ''><cfset form.phonenumber="none"></Cfif>
	<Cfif #form.lastname# is ''><cfset form.lastname="none"></Cfif>
	<cfset form.lastname=replace(#form.lastname#,",","~","ALL")>
	<Cfif #form.firstname# is ''><cfset form.firstname="none"></Cfif>
	<cfset form.firstname=replace(#form.firstname#,",","~","ALL")>
	<Cfif #form.height# is ""><cfset form.height='none'></Cfif>
	<Cfif not isnumeric(#form.weight#)><cfset form.weight=0></Cfif>
	<cfif not isdate(#form.startdate#)><cfset form.startdate=#dateformat(now())#></cfif>

	<cfinvoke method="UpdateResvCust" 
		component="#Application.WebSitePath#.utilities.reservations">
		<cfinvokeargument name="ResvCustID" value="#form.ResvCustID#">
		<cfinvokeargument name="Active" value="#form.Active#">
		<cfinvokeargument name="CardName" value="#form.CardName#">
		<cfinvokeargument name="CCExpire" value="#form.CCExpire#">
		<cfinvokeargument name="CCNo" value="#form.CCNo#">
		<cfinvokeargument name="CCType" value="#form.CCType#">
		<cfinvokeargument name="OnMailList" value="#form.OnMailList#">
		<cfinvokeargument name="StartDate" value="#form.StartDate#">
		<cfinvokeargument name="firstname" value="#form.firstname#">
		<cfinvokeargument name="lastname" value="#form.lastname#">
		<cfinvokeargument name="username" value="#form.username#">
		<cfinvokeargument name="Password" value="#form.Pword#">
		<cfinvokeargument name="AffiliateID" value="#form.AffiliateID#">
		<cfinvokeargument name="title" value="#form.title#">
		<cfinvokeargument name="height" value="#form.height#">
		<cfinvokeargument name="weight" value="#form.weight#">
	</cfinvoke>
	<cfinvoke method="UpdateEmail" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewEmailID">
		<cfinvokeargument name="EmailID" value="#form.EmailID#">
		<cfinvokeargument name="EmailTypeID" value="1">
		<cfinvokeargument name="ConnectID" value="#form.ResvCustid#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="EmailAddress" value="#form.EmailAddress#">
	</cfinvoke>
	<cfinvoke method="UpdateAddress" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewAddressID">
		<cfinvokeargument name="AddressID" value="#form.AddressID#">
		<cfinvokeargument name="AddressTypeID" value="1">
		<cfinvokeargument name="ConnectID" value="#form.ResvCustid#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="Address1" value="#form.Address1#">
		<cfinvokeargument name="Address2" value="#form.Address2#">
		<cfinvokeargument name="City" value="#form.City#">
		<cfinvokeargument name="State" value="#form.State#">
		<cfinvokeargument name="PostalCode" value="#form.PostalCode#">
		<cfinvokeargument name="Country" value="#form.Country#">
	</cfinvoke>
	<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewPhoneID">
		<cfinvokeargument name="PhoneID" value="#form.PhoneID#">
		<cfinvokeargument name="PhoneTypeID" value="1">
		<cfinvokeargument name="ConnectID" value="#form.ResvCustid#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="PhoneNumber" value="#form.PhoneNumber#">
	</cfinvoke>
	<cfif #Form.FaxPhoneID# gt 0>
		<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneID" value="#form.FaxPhoneID#">
			<cfinvokeargument name="PhoneTypeID" value="3">
			<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
		</cfinvoke>
	<cfelseif #form.FaxPhone# neq ''>
		<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneTypeID" value="3">
			<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
		</cfinvoke>
	</cfif>
	<cfif #Form.OfficePhoneID# gt 0>
		<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneID" value="#form.OfficePhoneID#">
			<cfinvokeargument name="PhoneTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.OfficePhone#">
		</cfinvoke>	
	<cfelseif #form.OfficePhone# neq ''>
		<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneTypeID" value="3">
			<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.OfficePhone#">
		</cfinvoke>
	</cfif>
	<Cfif isdefined('form.cellphoneid')>
		<cfif #Form.CellPhoneID# gt 0>
			<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.reservations" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneID" value="#form.CellPhoneID#">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.CellPhone#">
			</cfinvoke>	
		<cfelseif #form.CellPhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.CellPhone#">
			</cfinvoke>
		</cfif>
	</Cfif>
	<cfif isdefined('form.altemailid')>
		<cfif #form.AltEmailID# gt 0>
			<cfinvoke method="UpdateEmail" component="#Application.WebSitePath#.utilities.reservations" 
				returnvariable="NewEmailID">
				<cfinvokeargument name="EmailID" value="#form.AltEmailID#">
				<cfinvokeargument name="EmailTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="EmailAddress" value="#form.AltEmailAddress#">
			</cfinvoke>
		<cfelseif #form.AltEmailAddress# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="EmailTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#form.ResvCustID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.AltEmailAddress#">
			</cfinvoke>
		</cfif>
	</cfif>
	<cfset alphabet=left(form.lastname,1)>
	<cfif isdefined('form.ResvCustlist')><cflocation url="adminheader.cfm?action=ResvCustlistview&alphabet=#alphabet#&typeid=#typeid#"></cfif>
</cfif>

<CFif #ResvCustAction# is "Insert">
	<cfinvoke method="AddResvCust" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewID">
		<cfinvokeargument name="Active" value="#form.Active#">
		<Cfif #form.cardname# is ''><cfset form.cardname="none"></Cfif>
		<cfinvokeargument name="CardName" value="#form.CardName#">
		<Cfif #form.CCExpire# is ''><cfset form.CCExpire="none"></Cfif>
		<cfinvokeargument name="CCExpire" value="#form.CCExpire#">
		<Cfif #form.CCNo# is ''><cfset form.CCNo="none"></Cfif>
		<cfinvokeargument name="CCNo" value="#form.CCNo#">
		<Cfif #form.CCType# is ''><cfset form.CCType="none"></Cfif>
		<cfinvokeargument name="CCType" value="#form.CCType#">
		<cfinvokeargument name="OnMailList" value="#form.OnMailList#">
		<cfif isdate(form.startdate)>
			<cfinvokeargument name="StartDate" value="#form.StartDate#">
		<cfelse>
			<cfset form.startdate=#dateformat(now(),'mm/dd/yyyy')#>
			<cfinvokeargument name="StartDate" value="#dateformat(now(),'mm/dd/yyyy')#">
		</cfif>
		<cfset form.firstname=replace(#form.firstname#,",","~","ALL")>
		<cfinvokeargument name="firstname" value="#form.firstname#">
		<cfset form.lastname=replace(#form.lastname#,",","~","ALL")>
		<cfinvokeargument name="lastname" value="#form.lastname#">
		<cfinvokeargument name="username" value="#form.username#">
		<cfinvokeargument name="Password" value="#form.pWord#">
		<cfinvokeargument name="AffiliateID" value="#form.AffiliateID#">
		<Cfif #form.Title# is ''><cfset form.Title="none"></Cfif>
		<cfset form.Title=replace(#form.Title#,",","~","ALL")>
		<cfinvokeargument name="Title" value="#form.Title#">
		<Cfif #form.height# is ""><cfset form.height='none'></Cfif>
		<cfinvokeargument name="height" value="#form.height#">
		<Cfif #form.weight# is ""><cfset form.weight=0></Cfif>
		<cfinvokeargument name="weight" value="#form.weight#">
	</cfinvoke>
	<cfinvoke method="AddEmail" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewEmailID">
		<cfinvokeargument name="EmailTypeID" value="1">
		<cfinvokeargument name="ConnectID" value="#NewID#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="EmailAddress" value="#form.EmailAddress#">
	</cfinvoke>
	<cfif #form.altemailaddress# neq ''>
	<cfinvoke method="AddEmail" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewAltEmailID">
		<cfinvokeargument name="EmailTypeID" value="2">
		<cfinvokeargument name="ConnectID" value="#NewID#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="EmailAddress" value="#form.altemailaddress#">
	</cfinvoke>
	</cfif>
	<cfinvoke method="AddAddress" component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="NewAddressID">
		<cfinvokeargument name="AddressTypeID" value="1">
		<cfinvokeargument name="ConnectID" value="#newID#">
		<cfinvokeargument name="TableID" value="15">
		<cfinvokeargument name="Address1" value="#form.Address1#">
		<cfinvokeargument name="Address2" value="#form.Address2#">
		<cfinvokeargument name="City" value="#form.City#">
		<cfinvokeargument name="State" value="#form.State#">
		<cfinvokeargument name="PostalCode" value="#form.PostalCode#">
		<cfinvokeargument name="Country" value="#form.Country#">
	</cfinvoke>
	<cfif #form.PHoneNumber# neq ''>
		<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#NewID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.PhoneNumber#">
		</cfinvoke>
	</cfif>
	<cfif #form.OfficePHone# neq ''>
		<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#NewID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.OfficePHone#">
		</cfinvoke>
	</cfif>
	<cfif #form.FaxPhone# neq ''>
		<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.reservations" 
			returnvariable="NewPhoneID">
			<cfinvokeargument name="PhoneTypeID" value="3">
			<cfinvokeargument name="ConnectID" value="#NewID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
		</cfinvoke>	
	</cfif>
	<cfset alphabet=left(form.lastname,1)>
	<cfif isdefined('form.ResvCustlist')><cflocation url="adminheader.cfm?action=ResvCustslistview&alphabet=#alphabet#"></cfif>
</CFIF>

