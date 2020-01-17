
<cfset Today=#dateformat(now())#>
<cfset Tomorrow=#dateadd("d",365,#today#)#>
<cfparam name="MemberAction" default="list">
<cfparam name="memberID" default="0">
<cfparam name="TypeID" default="0">
<cfparam name="alphabet" default="a">

<CFif #MemberAction# is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="members">
		<cfinvokeargument name="XMLFields" value="MemberID,Active,CardName,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,Password,AffiliateID,companyname,displayname,accesslevel,typeid,pricingid,rebilldate,lastmodified,websiteurl,occupation,online,feepaid,maritalstatus,sex,age,birthdate">
		<cfinvokeargument name="XMLIDField" value="MemberID">
		<cfinvokeargument name="XMLIDValue" value="#MemberID#">
	</cfinvoke>
	<cfset MemberID=0>
	<cfset MemberAction="List">
</cfif>

<CFif #MemberAction# is "update">
	<cfset goahead=0>
    <cfset checkemail=#form.EmailAddress#>
	<cfset atPos=findnocase("@",#checkemail#)>
	<cfset dotPost=findnocase(".",#checkemail#)>
	<cfif atPos gt 0><cfset goahead=1></cfif>
	<cfif dotPost gt 0><cfset goahead=1><cfelse><cfset goahead=0></cfif>
	<cfif goahead is 0>
		<cfoutput><p>You need to enter a properly formatted email address<br>
		<a href="javascript:history.go(-1)">Click here to correct</a></p></cfoutput>
	<cfelse>
		<Cfif #form.cardname# is ''><cfset form.cardname="none"></Cfif>
		<Cfif #form.CCExpire# is ''><cfset form.CCExpire="none"></Cfif>
		<Cfif #form.CCNo# is ''><cfset form.CCNo="none"></Cfif>
		<Cfif #form.CCType# is ''><cfset form.CCType="none"></Cfif>
		<Cfif #form.companyname# is ''><cfset form.companyname="none"></Cfif>
		<cfset form.companyname=replace(#form.companyname#,",","~","ALL")>
		<Cfif #form.phonenumber# is ''><cfset form.phonenumber="none"></Cfif>
		<cfif not isdefined('form.displayname')><cfset form.displayname="none"></cfif>
		<Cfif #form.displayname# is ''><cfset form.displayname="none"></Cfif>
		<cfset form.displayname=replace(#form.displayname#,",","~","ALL")>
		<Cfif #form.lastname# is ''><cfset form.lastname="none"></Cfif>
		<cfset form.lastname=replace(#form.lastname#,",","~","ALL")>
		<Cfif #form.firstname# is ''><cfset form.firstname="none"></Cfif>
		<cfset form.firstname=replace(#form.firstname#,",","~","ALL")>
		<cfif isdefined('form.pricingid')><cfset Pricingid=#form.pricingid#><cfelse><cfset Pricingid=0></cfif>
		<Cfif #form.MemberURL# is ''><cfset form.MemberURL="none"></Cfif>
		<cfif isdefined('form.occupation')><cfset occupation=#form.occupation#><cfelse><cfset occupation='none'></cfif>
		<Cfif #occupation# is ''><cfset occupation="none"></Cfif>
		<cfif isdefined('form.online')><cfset online=#form.online#><cfelse><cfset online='0'></cfif>
		<Cfif not isnumeric(#form.feepaid#)><cfset form.feepaid=0></Cfif>
		<Cfif #form.maritalstatus# is ""><cfset form.maritalstatus='none'></Cfif>
		<Cfif #form.sex# is ""><cfset form.sex='none'></Cfif>
		<Cfif not isnumeric(#form.age#)><cfset form.age=0></Cfif>
		<cfif not isdate(#form.birthdate#)><cfset form.birthdate="01/01/1900"></cfif>
		<cfif not isdate(#form.startdate#)><cfset form.startdate=#dateformat(now())#></cfif>
		<cfif not isdate(#form.ReBillDate#)>
		<cfset form.ReBillDate=#dateformat(dateadd("d",3650,form.startdate))#></cfif>
		<cfif not isdefined('form.membertypeid')><cfset form.membertypeid=0></cfif>
	
		<cfinvoke method="UpdateMember" 
			component="#Application.WebSitePath#.utilities.membersXML">
			<cfinvokeargument name="MemberID" value="#form.memberID#">
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
			<cfinvokeargument name="Password" value="#form.pWord#">
			<cfinvokeargument name="AffiliateID" value="#form.AffiliateID#">
			<cfinvokeargument name="companyname" value="#form.companyname#">
			<cfinvokeargument name="displayname" value="#form.displayname#">
			<cfinvokeargument name="accesslevel" value="#form.accesslevel#">
			<cfinvokeargument name="typeid" value="#form.membertypeid#">
			<cfinvokeargument name="pricingid" value="#pricingid#">
			<cfinvokeargument name="rebilldate" value="#form.rebilldate#">
			<cfinvokeargument name="lastmodified" value="#form.lastmodified#">
			<cfinvokeargument name="websiteurl" value="#form.MemberURL#">
			<cfinvokeargument name="occupation" value="#occupation#">
			<cfinvokeargument name="online" value="#online#">
			<cfinvokeargument name="feepaid" value="#form.feepaid#">
			<cfinvokeargument name="maritalstatus" value="#form.maritalstatus#">
			<cfinvokeargument name="sex" value="#form.sex#">
			<cfinvokeargument name="age" value="#form.age#">
			<cfinvokeargument name="birthdate" value="#form.birthdate#">
		</cfinvoke>
		<cfoutput>Email address=#form.emailaddress#</cfoutput>
		<cfinvoke method="UpdateEmail" component="#Application.WebSitePath#.utilities.membersXML" 
			returnvariable="NewEmailID">
			<cfinvokeargument name="EmailID" value="#form.EmailID#">
			<cfinvokeargument name="EmailTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#form.memberid#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="EmailAddress" value="#form.EmailAddress#">
		</cfinvoke>
		<cfinvoke method="UpdateAddress" component="#Application.WebSitePath#.utilities.membersXML" 
			returnvariable="NewAddressID">
			<cfinvokeargument name="AddressID" value="#form.AddressID#">
			<cfinvokeargument name="AddressTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#form.memberid#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="Address1" value="#form.Address1#">
			<cfinvokeargument name="Address2" value="#form.Address2#">
			<cfinvokeargument name="City" value="#form.City#">
			<cfinvokeargument name="State" value="#form.State#">
			<cfinvokeargument name="PostalCode" value="#form.PostalCode#">
			<cfinvokeargument name="Country" value="#form.Country#">
		</cfinvoke>
		<cfif #form.PhoneID# gt 0>
			<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneID" value="#form.PhoneID#">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#form.memberid#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.PhoneNumber#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#form.memberid#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.PhoneNumber#">
			</cfinvoke>
		</cfif>
		<cfif #Form.FaxPhoneID# gt 0>
			<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneID" value="#form.FaxPhoneID#">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
			</cfinvoke>
		<cfelseif #form.FaxPhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
			</cfinvoke>
		</cfif>
		<cfif #Form.OfficePhoneID# gt 0>
			<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneID" value="#form.OfficePhoneID#">
				<cfinvokeargument name="PhoneTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.OfficePhone#">
			</cfinvoke>	
		<cfelseif #form.OfficePhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.OfficePhone#">
			</cfinvoke>
		</cfif>
		<cfif #Form.CellPhoneID# gt 0>
			<cfinvoke method="UpdatePhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneID" value="#form.CellPhoneID#">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.CellPhone#">
			</cfinvoke>	
		<cfelseif #form.CellPhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.CellPhone#">
			</cfinvoke>
		</cfif>
		<cfif #form.AltEmailID# gt 0>
			<cfinvoke method="UpdateEmail" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewEmailID">
				<cfinvokeargument name="EmailID" value="#form.AltEmailID#">
				<cfinvokeargument name="EmailTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="EmailAddress" value="#form.AltEmailAddress#">
			</cfinvoke>
		<cfelseif #form.AltEmailAddress# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="EmailTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#form.memberID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.AltEmailAddress#">
			</cfinvoke>
		</cfif>
		<cfif isdefined('form.memberlist')><cflocation url="adminheader.cfm?action=memberslistview&alphabet=#alphabet#&typeid=#typeid#"></cfif>
	</cfif>
</cfif>

<CFif #MemberAction# is "Insert">
	<cfset goahead=0>
    <cfset checkemail=#form.EmailAddress#>
	<cfset atPos=findnocase("@",#checkemail#)>
	<cfset dotPost=findnocase(".",#checkemail#)>
	<cfif atPos gt 0><cfset goahead=1></cfif>
	<cfif dotPost gt 0><cfset goahead=1><cfelse><cfset goahead=0></cfif>
	<cfif goahead is 0>
		<cfoutput><p>You need to enter a properly formatted email address<br>
		<a href="javascript:history.go(-1)">Click here to correct</a></p></cfoutput>
	<cfelse>
		<cfinvoke method="AddMember" 
			component="#Application.WebSitePath#.utilities.membersXML" 
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
			<Cfif #form.companyname# is ''><cfset form.companyname="none"></Cfif>
			<cfset form.companyname=replace(#form.companyname#,",","~","ALL")>
			<cfinvokeargument name="companyname" value="#form.companyname#">
			<cfif not isdefined('form.displayname')><cfset form.displayname="none"></cfif>
			<Cfif #form.displayname# is ''><cfset form.displayname="none"></Cfif>
			<cfset form.displayname=replace(#form.displayname#,",","~","ALL")>
			<cfinvokeargument name="displayname" value="#form.displayname#">
			<cfinvokeargument name="accesslevel" value="#form.accesslevel#">
			<cfinvokeargument name="typeid" value="#form.membertypeid#">
			<cfif isdefined('form.pricingid')><cfset Pricingid=#form.pricingid#><cfelse><cfset Pricingid=0></cfif>
			<cfinvokeargument name="pricingid" value="#pricingid#">
			<cfif isdate(form.rebilldate)>
				<cfinvokeargument name="rebilldate" value="#form.rebilldate#">
			<cfelse>
				<cfset form.rebilldate=dateadd("d",3650,#form.startdate#)>
				<cfset form.rebilldate=dateformat(#form.rebilldate#,"mm/dd/yyyy")>
				<cfinvokeargument name="rebilldate" value="#form.rebilldate#">
			</cfif>
			<cfinvokeargument name="lastmodified" value="#form.lastmodified#">
			<Cfif #form.MemberURL# is ''><cfset form.MemberURL="none"></Cfif>
			<cfinvokeargument name="websiteurl" value="#form.MemberURL#">
			<cfif isdefined('form.occupation')><cfset occupation=#form.occupation#><cfelse><cfset occupation='none'></cfif>
			<Cfif #occupation# is ''><cfset occupation="none"></Cfif>
			<cfset occupation=replace(#occupation#,",","~","ALL")>
			<cfinvokeargument name="occupation" value="#occupation#">
			<cfif isdefined('form.online')><cfset online=#form.online#><cfelse><cfset online='0'></cfif>
			<cfinvokeargument name="online" value="#online#">
			<Cfif not isnumeric(#form.feepaid#)><cfset form.feepaid=0></Cfif>
			<cfinvokeargument name="feepaid" value="#form.feepaid#">
			<Cfif #form.maritalstatus# is ""><cfset form.maritalstatus='none'></Cfif>
			<cfinvokeargument name="maritalstatus" value="#form.maritalstatus#">
			<Cfif #form.sex# is ""><cfset form.sex='none'></Cfif>
			<cfinvokeargument name="sex" value="#form.sex#">
			<Cfif not isnumeric(#form.age#)><cfset form.age=0></Cfif>
			<cfinvokeargument name="age" value="#form.age#">
			<cfif not isdate(#form.birthdate#)><cfset form.birthdate="01/01/1900"></cfif>
			<cfinvokeargument name="birthdate" value="#form.birthdate#">
		</cfinvoke>
		<cfinvoke method="AddEmail" component="#Application.WebSitePath#.utilities.membersXML" 
			returnvariable="NewEmailID">
			<cfinvokeargument name="EmailTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#NewID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="EmailAddress" value="#form.EmailAddress#">
		</cfinvoke>
		<cfif #form.altemailaddress# neq ''>
		<cfinvoke method="AddEmail" component="#Application.WebSitePath#.utilities.membersXML" 
			returnvariable="NewAltEmailID">
			<cfinvokeargument name="EmailTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#NewID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="EmailAddress" value="#form.altemailaddress#">
		</cfinvoke>
		</cfif>
		<cfinvoke method="AddAddress" component="#Application.WebSitePath#.utilities.membersXML" 
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
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#NewID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.PhoneNumber#">
			</cfinvoke>
		</cfif>
		<cfif #form.OfficePHone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="2">
				<cfinvokeargument name="ConnectID" value="#NewID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.OfficePHone#">
			</cfinvoke>
		</cfif>
		<cfif #form.CellPhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="4">
				<cfinvokeargument name="ConnectID" value="#NewID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.CellPhone#">
			</cfinvoke>
		</cfif>
		<cfif #form.FaxPhone# neq ''>
			<cfinvoke method="AddPhone" component="#Application.WebSitePath#.utilities.membersXML" 
				returnvariable="NewPhoneID">
				<cfinvokeargument name="PhoneTypeID" value="3">
				<cfinvokeargument name="ConnectID" value="#NewID#">
				<cfinvokeargument name="TableID" value="15">
				<cfinvokeargument name="PhoneNumber" value="#form.FaxPhone#">
			</cfinvoke>	
		</cfif>
		<cfif isdefined('form.memberlist')><cflocation url="adminheader.cfm?action=memberslistview&alphabet=#alphabet#&typeid=#typeid#"></cfif>
	</cfif>
</CFIF>

