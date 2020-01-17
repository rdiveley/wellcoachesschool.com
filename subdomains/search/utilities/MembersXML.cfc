<cfcomponent>
	
	<cffunction name="GetMemberPhone" access="remote" returntype="query" output="true">
		<cfargument name="MemberID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">
		
		<cfif #Arguments.PhoneTypeID# neq 0>
			<cfset WhereStatement="Where PhoneTypeID=#Arguments.PhoneTypeID#">
		</cfif>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberphone">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#MemberID#">
		</cfinvoke>
		<cfif #phone.recordcount# gt 0>
		<cfquery name="MemberPhone" dbtype="query">
			select * from Phone
			<cfif #arguments.PhoneTypeID# neq 0>
			where phonetypeid='#arguments.phonetypeid#'
			</cfif>
		</cfquery>
		<cfelse>
			<cfset memberphone=querynew("PHoneID,PhoneTypeID,ConnectID,PhoneNumber")>
		</cfif>
		<cfreturn MemberPhone>
		
	</cffunction>
	
	<cffunction name="GetMember" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" default="0" type="numeric" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Member">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="IDFieldName" value="MemberID">
			<cfinvokeargument name="IDFieldVAlue" value="#MemberID#">
		</cfinvoke>

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
		<cfif #MemberAddress.RecordCount# gt 0>
		<cfquery name="tMemberAddress" dbtype="query">
			select * from MemberAddress 
			where connectid='#Arguments.memberid#'
			<cfif #Arguments.addresstypeid# gt 0>and addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfelse>
			<cfset tMemberAddress=querynew("addressid,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,TableID,Country")>
		</cfif>
		<cfreturn tMemberAddress>
	</cffunction>
	
	<cffunction name="GetMemberEmail" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">
			
		<cfif #Arguments.EMAILTYPEID# neq 0>
			<cfset WhereStatement="where EMAILTYPEID='#Arguments.EMAILTYPEID#'">
		<cfelse>
			<cfset WhereStatement="">
		</cfif>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Memberemail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#MemberID#">
		</cfinvoke>
		<cfquery name="MemberEmail" dbtype="query">
			select * from Email 
			#preservesinglequotes(WhereStatement)#
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
		
		<cfset Address1=#XMLFormat(arguments.Address1)#>
		<cfif Address1 is ''><cfset Address1="none"></cfif>
		<cfset Address2=#XMLFormat(arguments.Address2)#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City=#XMLFormat(arguments.City)#>
		<cfif City is ''><cfset City="none"></cfif>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode=#XMLFormat(arguments.PostalCode)#>
		<cfset State=#XMLFormat(arguments.State)#>
		<cfif State is ''><cfset State="none"></cfif>
		<cfset Country=#XMLFormat(arguments.Country)#>
		<cfif Country is ''><cfset Country="none"></cfif>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		<cfoutput><br>#fieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Memberaddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="addressid">
		</cfinvoke>
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
		
		<cfset Address1=#XMLFormat(arguments.Address1)#>
		<cfset Address2=#XMLFormat(arguments.Address2)#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City=#XMLFormat(arguments.City)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode=#XMLFormat(arguments.PostalCode)#>
		<cfset State=#XMLFormat(arguments.State)#>
		<cfset Country=#XMLFormat(arguments.Country)#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Memberaddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="addressid">
			<cfinvokeargument name="XMLIDValue" value="#arguments.addressid#">
		</cfinvoke>

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
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Memberemail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>
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
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newid">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Memberemail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
		</cfinvoke>
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
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
		</cfinvoke>
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
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.PHoneID#">
		</cfinvoke>

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
			<cfoutput>#FieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="MemberID">
		</cfinvoke>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="GetFullMember" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" type="string" required="true" default="">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="MemberInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="IDFieldName" value="memberid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.MemberID#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AddressInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberaddress">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.MemberID#">
		</cfinvoke>
		
		<cfquery name="Member" dbtype="query">
			select * from MemberInfo, AddressInfo
			where AddressInfo.connectid=MemberInfo.MemberID
			and AddressInfo.addresstypeid='1'
		</cfquery>

		<cfreturn Member>
	</cffunction>
	
	<cffunction name="GetAllMember" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" type="numeric" required="false" default="0">
		<cfargument name="Alphabet" type="string" required="false" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="tMember">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="members">
		</cfinvoke>

		<cfif #tMember.recordcount# gt 0>
			<cfif #Arguments.alphabet# neq 'all'>
				<cfquery name="Member" dbtype="query">
					select * from tMember
					where (lastname like '#ucase(left(Arguments.alphabet,1))#%'
					or lastname like '#lcase(left(Arguments.alphabet,1))#%'
					or companyname like '#ucase(left(Arguments.alphabet,1))#%'
					or companyname like '#lcase(left(Arguments.alphabet,1))#%'
					)
					<cfif #Arguments.typeid# neq '0'>
						and Typeid='#arguments.typeid#'
					</cfif>
				</cfquery>
			<cfelse>
				<cfquery name="Member" dbtype="query">
					select * from tMember
					<cfif #Arguments.typeid# neq '0'>
						where Typeid='#arguments.typeid#'
					</cfif>
					order by StartDate desc
				</cfquery>
			</cfif>
			<cfreturn Member>
		<cfelse>
			<cfset Member=querynew("CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,companyname,displayname,websiteurl,typeid,pricingid,rebilldate,accesslevel,online,lastmodified,occupation,feepaid,maritalstatus,sex,age,birthdate")>
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
		<CFSET FieldValues = "#CardName#,#arguments.active#,#CCExpire#,#CCNo#,#CCType#,#arguments.OnMailList#,#arguments.startdate#,#firstname#,#lastname#,#username#,#password#,#arguments.AffiliateID#,#arguments.companyname#,#arguments.displayname#,#arguments.websiteurl#,#arguments.typeid#,#arguments.pricingid#,#arguments.rebilldate#,#arguments.accesslevel#,#arguments.online#,#arguments.lastmodified#,#arguments.occupation#,#arguments.feepaid#,#arguments.maritalstatus#,#arguments.sex#,#arguments.age#,#arguments.birthdate#">

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
	
	<cffunction name="CheckLogin" access="remote" output="true" returntype="numeric">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="uMember">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>
		<cfquery name="member" dbtype="query">
			select * from umember
			where password='#arguments.Password#'
		</cfquery>
		
		<cfset tMember=0>
		<cfif #Member.RecordCount# gt 0 and #arguments.username# neq ''>
			<cfif #arguments.username# is #Member.username#>
				<cfif #Member.Active# gt 0>
					<cfset tMember=#Member.Memberid#>
				</cfif>
			</cfif>
		<cfelseif #Member.RecordCount# gt 0>
			<cfif #Member.Active# gt 0>
				<cfset tMember=#Member.Memberid#>
			</cfif>
		</cfif>
		<cfreturn tMember>
	</cffunction>
	
	<cffunction name="GetMemberByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Member">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="IDFieldName" value="password">
			<cfinvokeargument name="IDFieldVAlue" value="#PWord#">
		</cfinvoke>

		<cfreturn Member>
	</cffunction>
	
	<cffunction name="UpdateLogin" access="remote" output="true" returntype="query">
		<cfargument name="password" default="0" type="string" required="true">
		<cfargument name="username" default="0" type="string" required="true">
		
		<cfinvoke method="GetMemberByPassword" returnvariable="TheMember">
			<cfinvokeargument name="PWord" value="#Arguments.password#">
		</cfinvoke>
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,companyname,displayname,websiteurl,typeid,pricingid,rebilldate,accesslevel,online,lastmodified,occupation,feepaid,maritalstatus,sex,age,birthdate">
		<CFSET FieldValues = "#TheMember.CardName#,#TheMember.active#,#TheMember.CCExpire#,#TheMember.CCNo#,#TheMember.CCType#,#TheMember.OnMailList#,#TheMember.startdate#,#TheMember.firstname#,#TheMember.lastname#,#TheMember.username#,#TheMember.password#,#TheMember.AffiliateID#,#TheMember.companyname#,#TheMember.displayname#,#TheMember.websiteurl#,#TheMember.typeid#,#TheMember.pricingid#,#TheMember.rebilldate#,#arguments.accesslevel#,#TheMember.online#,#TheMember.lastmodified#,#TheMember.occupation#,#TheMember.feepaid#,#TheMember.maritalstatus#,#TheMember.sex#,#TheMember.age#,#TheMember.birthdate#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="MemberID">
			<cfinvokeargument name="XMLIDValue" value="#TheMember.MemberID#">
		</cfinvoke>

		<cfreturn TheMember>
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
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,companyname,displayname,websiteurl,typeid,pricingid,rebilldate,accesslevel,online,lastmodified,occupation,feepaid,maritalstatus,sex,age,birthdate">
		<CFSET FieldValues = "#arguments.CardName#,1,#arguments.CCExpire#,#arguments.CCNo#,#arguments.CCType#,#TheMember.OnMailList#,#TheMember.startdate#,#TheMember.firstname#,#TheMember.lastname#,#TheMember.username#,#TheMember.password#,#TheMember.AffiliateID#,#TheMember.companyname#,#TheMember.displayname#,#TheMember.websiteurl#,#TheMember.typeid#,#TheMember.pricingid#,#TheMember.rebilldate#,#arguments.accesslevel#,#TheMember.online#,#TheMember.lastmodified#,#TheMember.occupation#,#TheMember.feepaid#,#TheMember.maritalstatus#,#TheMember.sex#,#TheMember.age#,#TheMember.birthdate#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="members">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="MemberID">
			<cfinvokeargument name="XMLIDValue" value="#TheMember.MemberID#">
		</cfinvoke>

		<cfreturn TheMember>
	</cffunction>
	
	<cffunction name="CreateInvoice" access="remote" returntyhpe="numeric" output="true">
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
		
		<CFSET FieldList = "memberid,Cardname,CCExpire,CCNo,CCType,FeePaid,TypeID,Address1,City,State,PostalCode,Country,DateCreated">
		<CFSET FieldValues = "#memberid#,#Cardname#,#CCExpire#,#CCNo#,#CCType#,#FeePaid#,#TypeID#,#Address1#,#City#,#state#,#PostalCode#,#State#,#Country#,#DateCreated#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberinvoices">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="Invoice">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction access="remote" name="GetInvoices" returntype="query" output="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="memberinvoices">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
</cfcomponent>