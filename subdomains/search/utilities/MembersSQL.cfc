<cfcomponent>
	
	<cffunction name="GetMemberPhone" access="remote" returntype="query" output="true">
		<cfargument name="MemberID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">
		
		<cfset WhereStatement=" where connectid=#arguments.memberid#">
		<cfif #Arguments.PhoneTypeID# neq 0>
			<cfset WhereStatement="#Wherestatement# and PhoneTypeID=#Arguments.PhoneTypeID#">
		</cfif>
		<cfquery name="phone" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from phonenumbers #Wherestatement#
		</cfquery>
		<cfreturn phone>
		
	</cffunction>
	
	<cffunction name="GetMember" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" default="0" type="numeric" required="true">

		<cfquery name="Member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from members Where memberid=#arguments.memberid#
		</cfquery>
		<cfreturn Member>
	</cffunction>
	
	
	<cffunction name="GetMemberAddress" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="MemberAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="MemberAddress">
		</cfinvoke>
		<cfquery name="tMemberAddress" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from addresses 
			where connectid=#Arguments.memberid#
			<cfif #Arguments.addresstypeid# gt 0>and addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfreturn tMemberAddress>
	</cffunction>
	
	<cffunction name="GetMemberEmail" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">

		<cfquery name="MemberEmail" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from email 
			where connectid=#Arguments.memberid#
			<cfif #Arguments.emailtypeid# gt 0>and websiteid='#arguments.emailtypeid#'</cfif>
		</cfquery>
		<cfreturn MemberEmail>
	</cffunction>
	
	
	<cffunction name="AddAddress" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="AddressTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="Address1" type="string" required="true" default="">
		<cfargument name="Address2" type="string" required="true" default="">
		<cfargument name="City" type="string" required="true" default="">
		<cfargument name="State" type="string" required="true"default="">
		<cfargument name="PostalCode" type="string" required="true" default="">
		<cfargument name="Country" type="string" required="true" default="">
		
		<cfset Address1=#arguments.Address1#>
		<cfset Address2=#arguments.Address2#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#arguments.AddressTypeID#>
		<cfset City=#arguments.City#>
		<cfset ConnectID=#arguments.ConnectID#>
		<cfset PostalCode=#arguments.PostalCode#>
		<cfset State=#arguments.State#>
		<cfset Country=#arguments.Country#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#Address1#','#Address2#',#AddressTypeID#,'#City#',#ConnectID#,'#PostalCode#','#State#','#Country#'">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			insert into addresses (#fieldlist#) values(#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="NewAddressID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select max(addressID) as NewID from addresses
		</cfquery>
		<cfset NewID=#NewAddressID.NewID#>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateAddress" access="remote" output="false">
		<cfargument name="AddressID" type="numeric" required="true" default=0>
		<cfargument name="AddressTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="TableID" type="numeric" required="true" default=0>
		<cfargument name="Address1" type="string" required="true" default="">
		<cfargument name="Address2" type="string" required="true" default="">
		<cfargument name="City" type="string" required="true" default="">
		<cfargument name="State" type="string" required="true"default="">
		<cfargument name="PostalCode" type="string" required="true" default="">
		<cfargument name="Country" type="string" required="true" default="">
		
		<cfset Address1=#arguments.Address1#>
		<cfset Address2=#arguments.Address2#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#arguments.AddressTypeID#>
		<cfset City=#arguments.City#>
		<cfset ConnectID=#arguments.ConnectID#>
		<cfset PostalCode=#arguments.PostalCode#>
		<cfset State=#arguments.State#>
		<cfset Country=#arguments.Country#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "address1='#Address1#',address2='#Address2#',addresstypeid=#AddressTypeID#,city='#City#',connectid=#ConnectID#,postalcode='#PostalCode#',state='#State#',country='#Country#'">
		<cfquery name="MemberEmail" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update addresses set #preservesinglequotes(fieldValues)# where addressid=#arguments.addressid#
		</cfquery>

	</cffunction>

	<cffunction name="UpdateEmail" access="remote" output="false">
		<cfargument name="EmailID" type="numeric" required="true" default=0>
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailID=#XMLFormat(arguments.EmailID)#>
		<cfset EmailTypeID=#XMLFormat(arguments.EmailTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset EmailAddress=#XMLFormat(arguments.EmailAddress)#>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "emailtypeid=#EmailTypeID#,connectid=#ConnectID#,emailaddress='#EmailAddress#'">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update email set #preservesinglequotes(fieldValues)# where emailid=#arguments.emailid#
		</cfquery>
	</cffunction>
	
	<cffunction name="AddEmail" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailTypeID=#XMLFormat(arguments.EmailTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset EmailAddress=#XMLFormat(arguments.EmailAddress)#>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			insert into email (#fieldlist#) values(#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="NewemailID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select max(emailid) as NewID from email
		</cfquery>
		<cfset NewID=#NewemailID.NewID#>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="AddPhone" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="PhoneTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#XMLFormat(arguments.PhoneTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PhoneNumber=#XMLFormat(arguments.PhoneNumber)#>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber#">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			insert into phonenumbers (#fieldlist#) values(#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="NewPhoneID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select max(phoneID) as NewID from phonenumbers
		</cfquery>
		<cfset NewID=#NewPhoneID.NewID#>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdatePhone" access="remote" output="false">
		<cfargument name="PhoneID" type="numeric" required="true" default=0>
		<cfargument name="PhoneTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#arguments.PhoneTypeID#>
		<cfset ConnectID=#arguments.ConnectID#>
		<cfset PhoneNumber=#XMLFormat(arguments.PhoneNumber)#>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "PhoneTypeID=#PhoneTypeID#,ConnectID=#ConnectID#,PhoneNumber='#PhoneNumber#'">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update phonenumbers set #preservesinglequotes(fieldValues)# where PHoneID=#arguments.PHoneID#
		</cfquery>

	</cffunction>
	
	<cffunction name="AddMember" access="remote" returntype="numeric" output="true">
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="0">
		<cfargument name="CCExpire" type="string" required="true" default="0">
		<cfargument name="CCNo" type="string" required="true" default="0">
		<cfargument name="CCType" type="string" required="true"default="0">
		<cfargument name="OnMailList" type="numeric" required="true"default="0">
		<cfargument name="StartDate" type="date" required="true" default="0">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="AffiliateID" type="string" required="true" default="0">
		<cfargument name="companyname" type="string" required="true" default="">
		<cfargument name="displayname" type="string" required="true" default="">
		<cfargument name="accesslevel" type="string" required="true" default="">
		<cfargument name="typeid" type="string" required="true" default="0">
		<cfargument name="pricingid" type="string" required="true" default="0">
		<cfargument name="rebilldate" type="date" required="true" default="">
		<cfargument name="lastmodified" type="date" required="true" default="">
		<cfargument name="websiteurl" type="string" required="true" default="">
		<cfargument name="occupation" type="string" required="true" default="0">
		<cfargument name="online" type="numeric" required="true" default="0">
		<cfargument name="feepaid" type="numeric" required="true" default="0">
		<cfargument name="maritalstatus" type="string" required="true" default="">
		<cfargument name="sex" type="string" required="true" default="">
		<cfargument name="age" type="numeric" required="true" default="">
		<cfargument name="birthdate" type="date" required="true" default="">
		
		<cfset CardName=#XMLFormat(arguments.CardName)#>
		<cfset CCExpire=#XMLFormat(arguments.CCExpire)#>
		<cfset CCNo=#XMLFormat(arguments.CCNo)#>
		<cfset CCType=#XMLFormat(arguments.CCType)#>
		<cfset firstname=#XMLFormat(arguments.firstname)#>
		<cfset username=#XMLFormat(arguments.username)#>
		<cfset password=#XMLFormat(arguments.password)#>
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,companyname,displayname,websiteurl,typeid,pricingid,rebilldate,accesslevel,online,lastmodified,occupation,feepaid,maritalstatus,sex,age,birthdate">
		<CFSET FieldValues = "#CardName#,#arguments.active#,#CCExpire#,#CCNo#,#CCType#,#arguments.OnMailList#,#arguments.startdate#,#firstname#,#lastname#,#username#,#password#,#arguments.AffiliateID#,#arguments.companyname#,#arguments.displayname#,#arguments.websiteurl#,#arguments.typeid#,#arguments.pricingid#,#arguments.rebilldate#,#arguments.accesslevel#,#arguments.online#,#arguments.lastmodified#,#arguments.occupation#,#arguments.feepaid#,#arguments.maritalstatus#,#arguments.sex#,#arguments.age#,#arguments.birthdate#">

		<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			insert into members (#fieldlist#) values(#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="NewMemberID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select max(MemberID) as NewID from members
		</cfquery>
		<cfset NewID=#NewMemberID.NewID#>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="GetFullMember" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" type="string" required="true" default="">
		<cfquery name="Member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from members, addresses, phonenumbers, email
			where memberid=#arguments.memberid# 
			and members.memberid=addresses.connectid 
			and addresses.addresstypeid=1
			and members.memberid=phonenumbers.connectid 
			and phonenumbers.phonetypeid=1
			and members.memberid=email.connectid 
			and email.websiteid=1
		</cfquery>

		<cfreturn Member>
	</cffunction>
	
	<cffunction name="GetAllMember" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" type="numeric" required="false" default="0">
		<cfargument name="Alphabet" type="string" required="false" default="a">

		<cfif #Arguments.alphabet# neq 'all'>
        	<!--- <cfoutput>select * from members
				where (lastname like '#ucase(left(Arguments.alphabet,1))#%'
				or lastname like '#lcase(left(Arguments.alphabet,1))#%'
				or companyname like '#ucase(left(Arguments.alphabet,1))#%'
				or companyname like '#lcase(left(Arguments.alphabet,1))#%'
				)
				<cfif #Arguments.typeid# neq '0'>
                	<cfif arguments.typeid is 3>
                    and (members.subtypeid in (3,8,9,10,11,12,15,16) or members.occupation like '%#TypeID#%' or members.occupation like '8' or members.occupation like '9' or members.occupation like '10' or members.occupation like '11' or members.occupation like '12' or members.occupation like '15' or members.occupation like '16')
                    <cfelseif arguments.typeid is 1>
                    	and subtypeid=1
                    <cfelseif arguments.typeid is 2>
                    	and subtypeid=2
                    <cfelse>
					and (subTypeid=#arguments.typeid# or occupation like '%#arguments.typeid#%')
                    </cfif>
				</cfif>
                order by lastname<br><br></cfoutput> --->
			<cfquery name="Member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from members
				where (lastname like '#ucase(left(Arguments.alphabet,1))#%'
				or lastname like '#lcase(left(Arguments.alphabet,1))#%'
				or companyname like '#ucase(left(Arguments.alphabet,1))#%'
				or companyname like '#lcase(left(Arguments.alphabet,1))#%'
				)
				<cfif #Arguments.typeid# neq '0'>
                	<cfif arguments.typeid is 3>
                    and (members.subtypeid in (3,8,9,10,11,12,15,16) or members.occupation like '%#TypeID#%' or members.occupation like '8' or members.occupation like '9' or members.occupation like '10' or members.occupation like '11' or members.occupation like '12' or members.occupation like '15' or members.occupation like '16')
                    <cfelseif arguments.typeid is 1>
                    	and subtypeid=1
                    <cfelseif arguments.typeid is 2>
                    	and subtypeid=2
                    <cfelse>
					and (subTypeid=#arguments.typeid# or occupation like '%#arguments.typeid#%')
                    </cfif>
				</cfif>
                order by lastname
			</cfquery>
		<cfelse>
        	<!--- <cfoutput>select * from members
				<cfif #Arguments.typeid# neq '0'>
                	<cfif arguments.typeid is 3>
                    	where (members.subtypeid in (3,8,9,10,11,12,15,16) or members.occupation like '%#TypeID#%' or members.occupation like '8' or members.occupation like '9' or members.occupation like '10' or members.occupation like '11' or members.occupation like '12' or members.occupation like '15' or members.occupation like '16')
                    <cfelseif arguments.typeid is 1>
                    	where subtypeid=1
                    <cfelseif arguments.typeid is 2>
                    	where subtypeid=2
                    <cfelse>
					where (subTypeid=#arguments.typeid# or occupation like '%#arguments.typeid#%')
                    </cfif>
				</cfif>
				order by lastname<br><br></cfoutput> --->
			<cfquery name="Member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from members
				<cfif #Arguments.typeid# neq '0'>
                	<cfif arguments.typeid is 3>
                    	where (members.subtypeid in (3,8,9,10,11,12,15,16) or members.occupation like '%#TypeID#%' or members.occupation like '8' or members.occupation like '9' or members.occupation like '10' or members.occupation like '11' or members.occupation like '12' or members.occupation like '15' or members.occupation like '16')
                    <cfelseif arguments.typeid is 1>
                    	where subtypeid=1
                    <cfelseif arguments.typeid is 2>
                    	where subtypeid=2
                    <cfelse>
					where (subTypeid=#arguments.typeid# or occupation like '%#arguments.typeid#%')
                    </cfif>
				</cfif>
				order by lastname
			</cfquery>
		</cfif>
		<cfreturn Member>
	</cffunction>
	
	<cffunction name="UpdateMember" access="remote" output="false">
		<cfargument name="MemberID" type="string" required="true" default=0>
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="0">
		<cfargument name="CCExpire" type="string" required="true" default="0">
		<cfargument name="CCNo" type="string" required="true" default="0">
		<cfargument name="CCType" type="string" required="true"default="0">
		<cfargument name="OnMailList" type="numeric" required="true"default="0">
		<cfargument name="StartDate" type="date" required="true" default="0">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="AffiliateID" type="string" required="true" default="0">
		<cfargument name="companyname" type="string" required="true" default="">
		<cfargument name="displayname" type="string" required="true" default="">
		<cfargument name="accesslevel" type="string" required="true" default="">
		<cfargument name="typeid" type="string" required="true" default="0">
		<cfargument name="pricingid" type="string" required="true" default="0">
		<cfargument name="rebilldate" type="date" required="true" default="">
		<cfargument name="lastmodified" type="date" required="true" default="">
		<cfargument name="websiteurl" type="string" required="true" default="">
		<cfargument name="occupation" type="string" required="true" default="0">
		<cfargument name="online" type="numeric" required="true" default="0">
		<cfargument name="feepaid" type="numeric" required="true" default="0">
		<cfargument name="maritalstatus" type="string" required="true" default="">
		<cfargument name="sex" type="string" required="true" default="">
		<cfargument name="age" type="numeric" required="true" default=0>
		<cfargument name="birthdate" type="date" required="true" default="">

		<cfset CardName=#XMLFormat(arguments.CardName)#>
		<cfset CCExpire=#XMLFormat(arguments.CCExpire)#>
		<cfset CCNo=#XMLFormat(arguments.CCNo)#>
		<cfset CCType=#XMLFormat(arguments.CCType)#>
		<cfset firstname=#XMLFormat(arguments.firstname)#>
		<cfset username=#XMLFormat(arguments.username)#>
		<cfset password=#XMLFormat(arguments.password)#>
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,companyname,displayname,websiteurl,typeid,pricingid,rebilldate,accesslevel,online,lastmodified,occupation,feepaid,maritalstatus,sex,age,birthdate">
		
		<CFSET FieldValues = "CardName='#CardName#',active=#arguments.active#,CCEXpire='#CCExpire#',CCNO='#CCNo#',CCType='#CCType#',OnMailList=#arguments.OnMailList#,StartDate='#arguments.startdate#',firstname='#firstname#',lastname='#lastname#',username='#username#',password='#password#',AffiliateID=#arguments.AffiliateID#,companyname='#arguments.companyname#',displayname='#arguments.displayname#',websiteurl='#arguments.websiteurl#',typeid=#arguments.typeid#,pricingid=#arguments.pricingid#,rebilldate='#arguments.rebilldate#',accesslevel=#arguments.accesslevel#,online=#arguments.online#,lastmodified='#arguments.lastmodified#',occupation='#arguments.occupation#',feepaid='#arguments.feepaid#',maritalstatus=#arguments.maritalstatus#,sex=#arguments.sex#,age=#arguments.age#,birthdate='#arguments.birthdate#'">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update members set #preservesinglequotes(fieldValues)# where MemberID=#arguments.MemberID#
		</cfquery>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="MemberID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.MemberID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="CheckUser" access="remote" output="true" returntype="query">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">
		<cfquery name="member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select firstname,lastname,subtypeid,memberid,occupation from members
			where password='#arguments.Password#' and logon='#arguments.username#'
		</cfquery>
		<cfreturn member>
	</cffunction>
	
	<cffunction name="CheckLogin" access="remote" output="true" returntype="numeric">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">
		<cfquery name="member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select memberid from members
			where password='#arguments.Password#' and logon='#arguments.username#'
		</cfquery>
		<cfif member.recordcount is 0>
			<cfset tMember=0>
		<cfelse>
			<cfset tMember=member.memberid>
		</cfif>
		<cfreturn tMember>
	</cffunction>
	
	<cffunction name="GetMemberByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfquery name="member" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select memberid from members
			where password='#arguments.PWord#'
		</cfquery>
		<cfreturn Member>
	</cffunction>
	
	<cffunction name="UpdateLogin" access="remote" output="true" returntype="string">
		<cfargument name="password" default="0" type="string" required="yes">
		<cfargument name="username" default="0" type="string" required="yes">
		<cfargument name="MemberID" default="0" type="string" required="yes">
		
		<CFSET FieldValues = "logon='#Arguments.username#',password='#Arguments.password#'">

		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update members set #preservesinglequotes(fieldValues)# where MemberID=#Arguments.MemberID#
		</cfquery>

		<cfreturn arguments.memberid>
	</cffunction>
	
	<cffunction name="UpdateActive" access="remote" output="true" returntype="query">
		<cfargument name="memberid" default="0" type="string" required="true">
		<cfargument name="CardName" default="0" type="string" required="true">
		<cfargument name="CCExpire" default="0" type="string" required="true">
		<cfargument name="CCNo" default="0" type="string" required="true">
		<cfargument name="CCType" default="0" type="string" required="true">
		
		<cfinvoke method="GetMember" returnvariable="TheMember">
			<cfinvokeargument name="MemberID" value="#Arguments.MemberID#">
		</cfinvoke>
		<CFSET FieldValues = "cardname='#arguments.CardName#',active=1,ccexpire='#arguments.CCExpire#',ccno='#arguments.CCNo#',cctype='#arguments.CCType#'">

		<cfquery name="TheMember" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update members set #preservesinglequotes(fieldValues)# where MemberID=#arguments.MemberID#
		</cfquery>

		<cfreturn TheMember>
	</cffunction>
	
	<cffunction name="CreateInvoice" access="remote" returntype="numeric" output="true">
		<cfargument name="memberid" type="string" required="true" default=0>
		<cfargument name="Cardname" type="string" required="true" default=0>
		<cfargument name="CCExpire" type="string" required="true" default=0>
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true" default="">
		<cfargument name="FeePaid" type="string" required="true" default="">
		<cfargument name="TypeID" type="string" required="true"default="">
		<cfargument name="Address1" type="string" required="true" default="">
		<cfargument name="City" type="string" required="true" default="">
		<cfargument name="State" type="string" required="true" default="">
		<cfargument name="PostalCode" type="string" required="true" default="">
		<cfargument name="Country" type="string" required="true" default="">
		<cfargument name="Proddescription" type="string" required="true" default="">
		
		<cfset memberid=#XMLFormat(arguments.memberid)#>
		<cfset Cardname=#XMLFormat(arguments.Cardname)#>
		<cfset CCExpire=#XMLFormat(arguments.CCExpire)#>
		<cfset CCNo=#XMLFormat(arguments.CCNo)#>
		<cfset CCType=#XMLFormat(arguments.CCType)#>
		<cfset FeePaid=#XMLFormat(arguments.FeePaid)#>
		<cfset TypeID=#XMLFormat(arguments.TypeID)#>
		<cfset Address1=#XMLFormat(arguments.Address1)#>
		<cfset City=#XMLFormat(arguments.City)#>
		<cfset State=#XMLFormat(arguments.State)#>
		<cfset PostalCode=#XMLFormat(arguments.PostalCode)#>
		<cfset Country=#XMLFormat(arguments.Country)#>
		<cfset DateCreated=#dateformat(now(),'mm/dd/yyyy')#>
		
		<CFSET FieldList = "CARDNAME, CARDNO, CARDTYPE, CUSTID, DATECLOSED, DATECREATED, DATEORDERED, DATESHIPPED, DATESTARTED,  EXPIRATION,  WEBSITEID ">
		<CFSET FieldValues = "'#Cardname#','#CCNo#','#CCType#',#memberid#,'#DateCreated#','#DateCreated#','#DateCreated#','#DateCreated#','#DateCreated#','#CCExpire#',1">
		<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			insert into orders (#fieldlist#) values(#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="NewInvoice" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select max(invoice) as NewID from orders
		</cfquery>
		<cfset NewID=#NewInvoice.NewID#>
        <cfquery name="UpdateOrderDetail" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			insert into orddtl (
			DESCRIPTION,DISCOUNT,DISCOUNTTYPE,INVOICE,PRICE,PRODNAME,PRODUCTID,
			QTYORDERED)
			values (
			'#arguments.ProdDescription#',0,#TypeID#,#NewID#,#FeePaid#,
			'#arguments.ProdDescription#',#arguments.TypeID#,1)
		</cfquery>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction access="remote" name="GetInvoices" returntype="query" output="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberinvoices">
		</cfinvoke>
		<cfquery name="records" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from orders order by invoice desc
		</cfquery>
		<cfreturn records>
	</cffunction>
	
	<cffunction access="remote" name="GetHomePages" returntype="query" output="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="pages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="studenthome">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="studentconfig">
		</cfinvoke>
		<cfquery name="student" dbtype="query">
			select pagename from pages where pageid='#studenthome.studentHome#'
		</cfquery>
		<cfset studenthomePage=#student.pagename#>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="traineehome">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="traineeconfig">
		</cfinvoke>
		<cfquery name="trainee" dbtype="query">
			select pagename from pages where pageid='#traineehome.traineehome#'
		</cfquery>
		<cfset traineehomePage=#trainee.pagename#>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="licenseehome">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="licenseeConfig">
		</cfinvoke>
		<cfquery name="licensee" dbtype="query">
			select pagename from pages where pageid='#licenseehome.licenseehome#'
		</cfquery>
		<cfset licenseehomePage=#licensee.pagename#>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="memberhome">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberconfig">
		</cfinvoke>
		
		<cfset homePages=QueryNew("studentHome,traineehome,licenseehome,loginpage,memberhome")>
		<cfset newRow=QueryAddRow(homePages,1)>
		<CFSET temp = QuerySetCell(homePages, "studentHome","#studenthomePage#", #newRow#)>
		<CFSET temp = QuerySetCell(homePages, "traineehome","#traineehomePage#", #newRow#)>
		<CFSET temp= QuerySetCell(homePages, "licenseehome","#licenseehomePage#", #newRow#)>
		<CFSET temp = QuerySetCell(homePages, "loginpage","#memberhome.LoginPage#", #newRow#)>
		<CFSET temp= QuerySetCell(homePages, "memberhome","#memberhome.AfterLoginPage#", #newRow#)>
		<cfreturn homePages>
	</cffunction>
	
	<cffunction name="getFieldValue" access="remote" output="true" returntype="string">
		<cfargument name="ThisFileName" default="0" type="string" required="true">
		<cfargument name="FieldName" default="0" type="string" required="true">
		<cfargument name="IDFieldName" default="0" type="string" required="true">
		<cfargument name="IDFieldValue" default="0" type="string" required="true">
		
		<cfquery name="MemberEmail" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select #FieldName# as ThisField from #thisFileName# 
			where #IDFieldName#=#Arguments.IDFieldValue#
		</cfquery>
		<cfreturn MemberEmail.ThisField>
	</cffunction>
	
	<cffunction name="getPhoto" access="remote" output="true" returntype="string">
		<cfargument name="MemberID" required="yes" type="string">
		<cfquery name="GetPhoto" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#" maxrows=1>
			select imagename from Images
			where connectid=#arguments.MemberID#
			and ImageTypeID < 4
			order by ImageName
		</cfquery>
		<cfreturn getPhoto.imagename>
	</cffunction>
	
	<cffunction name="getFacultyProfile" access="remote" output="true" returntype="query">
		<cfargument name="memberid" required="yes" type="string">
		<cfset SurveyID=1>
		<cfquery name="profile" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#">
			select connectid,responsetext from responses
			where connectid in (1,2,3,4)
			and userid=#arguments.memberid#
			order by connectid, responseid
		</cfquery>
		<cfoutput>
		<cfset responses=QueryNew("education,experience,other,biography")>
		<cfquery name="response" dbtype="query">
			select * from profile where connectid=1
		</cfquery>
			<cfset newRow=QueryAddRow(responses,1)>
			<CFSET temp = QuerySetCell(responses, "education","#response.responsetext#", #newRow#)>
		<cfquery name="response" dbtype="query">
			select * from profile where connectid=2
		</cfquery>
			<CFSET temp = QuerySetCell(responses, "experience","#response.responsetext#", #newRow#)>
		<cfquery name="response" dbtype="query">
			select * from profile where connectid=3
		</cfquery>
			<CFSET temp = QuerySetCell(responses, "other","#response.responsetext#", #newRow#)>
		<cfquery name="response" dbtype="query">
			select * from profile where connectid=4
		</cfquery>
			<CFSET temp = QuerySetCell(responses, "biography","#response.responsetext#", #newRow#)>
		</cfoutput>
		<cfreturn responses>
	</cffunction>
	
</cfcomponent>