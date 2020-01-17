<cfcomponent>
	
	<cffunction name="GetCustomerPhone" access="remote" returntype="query" output="true">
		<cfargument name="CustomerID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">
		
		<cfif #Arguments.PhoneTypeID# neq 0>
			<cfset WhereStatement="Where PhoneTypeID=#Arguments.PhoneTypeID#">
		</cfif>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerphones">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#customerID#">
		</cfinvoke>
		<cfquery name="CustomerPhone" dbtype="query">
			select * from Phone
		</cfquery>
		<cfreturn CustomerPhone>
		
	</cffunction>
	
	<cffunction name="GetCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" default="0" type="numeric" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="IDFieldName" value="customerID">
			<cfinvokeargument name="IDFieldVAlue" value="#customerID#">
		</cfinvoke>

		<cfreturn Customer>
	</cffunction>
	
	
	<cffunction name="GetCustomerAddress" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CustomerAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="IDFieldName" value="ConnectID">
			<cfinvokeargument name="IDFieldName" value="#Arguments.CustomerID#">
		</cfinvoke>
		<cfif #CustomerAddress.RecordCount# gt 0>
		<cfquery name="tCustomerAddress" dbtype="query">
			select * from CustomerAddress 
			<cfif #Arguments.addresstypeid# gt 0>where addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfelse>
			<cfset tCustomerAddress=querynew("addressid,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,TableID,Country")>
		</cfif>
		<cfreturn tCustomerAddress>
	</cffunction>
	
	<cffunction name="GetCustomerEmail" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">
			
		<cfif #Arguments.EMAILTYPEID# neq 0>
			<cfset WhereStatement="where EMAILTYPEID='#Arguments.EMAILTYPEID#'">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#customerID#">
		</cfinvoke>
		<cfquery name="CustomerEmail" dbtype="query">
			select * from Email 
		</cfquery>
		<cfreturn CustomerEmail>
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
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeraddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
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
			<cfinvokeargument name="ThisFileName" value="customeraddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="addressid">
			<cfinvokeargument name="XMLIDValue" value="#addressid#">
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
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
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
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
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
			<cfinvokeargument name="ThisFileName" value="customerphone">
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
		
		<cfset PhoneTypeID=#XMLFormat(arguments.PhoneTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PhoneNumber=#XMLFormat(arguments.PhoneNumber)#>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDField" value="#arguments.PHoneID#">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="AddCustomer" access="remote" returntype="numeric" output="true">
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="">
		<cfargument name="CCExpire" type="string" required="true" default="">
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true"default="">
		<cfargument name="OnMailList" type="numeric" required="true"default="">
		<cfargument name="StartDate" type="date" required="true" default="">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="">
		<cfargument name="Password" type="string" required="true" default="">
		<cfargument name="AffiliateID" type="numeric" required="true" default="">
		<cfargument name="resellerstate" type="string" required="true" default="0">
		<cfargument name="resellernumber" type="string" required="true" default="0">
		<cfargument name="CompanyName" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<cfset OnMailList=#XMLFormat(arguments.OnMailList)#>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset AffiliateID=#XMLFormat(arguments.AffiliateID)#>
		<cfset resellerstate="#XMLFormat(arguments.resellerstate)# ">
		<cfset resellernumber="#XMLFormat(arguments.resellernumber)# ">
		<cfset CompanyName="#XMLFormat(arguments.CompanyName)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,CompanyName">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#resellerstate#,#resellernumber#,#CompanyName#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CustomerID">
		</cfinvoke>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="GetFullCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="numeric" required="true" default="">
		
		<cfset selectStatement="select members.*, addresses.*, email.*, phonenumbers.* ">
		<cfset FromStatement="from members,addresses,email,phonenumbers ">
		<cfset WhereStatement="where addresses.connectid=memberid and addresses.addresstypeid=1 ">
		<cfset WhereStatement="#WhereStatement# and email.connectid=memberid and email.emailtypeid=1 ">
		<cfset WhereStatement="#WhereStatement# and phonenumbers.connectid=memberid and phonenumbers.phonetypeid=1 ">
		<cfset WhereStatement="#WhereStatement# and members.memberid=#arguments.customerID# ">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetRecords" returnvariable="Customer">
			<cfinvokeargument name="SelectStatement" value="#SelectStatement#">
			<cfinvokeargument name="FromStatement" value="#fromStatement#">
			<cfinvokeargument name="WhereStatement" value="#WhereStatement#">
		</cfinvoke>

		<cfreturn Customer>
	</cffunction>
	
	<cffunction name="GetAllCustomer" access="remote" output="true" returntype="query">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
		</cfinvoke>
		<cfquery name="customerEmail" dbtype="query">
			select customer.*, email.emailaddress
			from customer, email
			where email.connectid=customer.customerid
			and email.emailtypeid='1'
		</cfquery>
		<cfreturn customerEmail>
	</cffunction>
	
	<cffunction name="UpdateCustomer" access="remote" output="false">
		<cfargument name="CustomerID" type="numeric" required="true" default=0>
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
		<cfargument name="resellerstate" type="string" required="true" default="0">
		<cfargument name="resellernumber" type="string" required="true" default="0">
		<cfargument name="companyName" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<cfset OnMailList=#XMLFormat(arguments.OnMailList)#>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset AffiliateID=#XMLFormat(arguments.AffiliateID)#>
		<cfset resellerstate="#XMLFormat(arguments.resellerstate)# ">
		<cfset resellernumber="#XMLFormat(arguments.resellernumber)# ">
		<cfset companyName="#XMLFormat(arguments.companyName)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyName">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#resellerstate#,#resellernumber#,#companyName#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="IDFieldName" value="CustomerID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.customerID#">
		</cfinvoke>
		<cfreturn #arguments.CustomerID#>
	</cffunction>
	
	<cffunction name="CheckLogin" access="remote" output="true" returntype="boolean">
		<cfargument name="Username" default=" " type="string" required="true">
		<cfargument name="Password" default=" " type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="IDFieldName" value="username">
			<cfinvokeargument name="IDFieldValue" value="#arguments.username#">
		</cfinvoke>
		
		<cfset tCustomer=0>
		<cfif #Customer.RecordCount# gt 0>
			<cfquery name="CheckPassword" dbtype="query">
				select * from customer where password='#arguments.password#'
			</cfquery>
			<cfif #CheckPassword.RecordCount# gt 0>
				<cfif #CheckPassword.Active# gt 0>
					<cfset tCustomer=1>
				</cfif>
			</cfif>
		</cfif>
		<cfreturn tCustomer>
	</cffunction>
	
	<cffunction name="GetCustomerByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="IDFieldName" value="password">
			<cfinvokeargument name="IDFieldVAlue" value="#PWord#">
		</cfinvoke>

		<cfreturn Customer>
	</cffunction>
</cfcomponent>