<cfcomponent>
	
	<cffunction name="Getcustomerphone" access="remote" returntype="query" output="true">
		<cfargument name="CustomerID" type="string" default="0" required="true">
		<cfargument name="PhoneTypeID" type="string" default="0" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerphone">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.customerID#">
		</cfinvoke>
		<cfquery name="customerphone" dbtype="query">
			select * from Phone
			<cfif #Arguments.PhoneTypeID# neq 0>
			where Phonetypeid='#arguments.phonetypeid#'
			</cfif>
		</cfquery>
		<cfreturn customerphone>
		
	</cffunction>
	
	<cffunction name="GetCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" default="0" type="numeric" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="IDFieldName" value="customerID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.customerID#">
		</cfinvoke>

		<cfreturn Customer>
	</cffunction>
	
	<cffunction name="GetAddressbyID" access="remote" output="true" returntype="query">
		<cfargument name="AddressID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CustomerAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="IDFieldName" value="addressID">
			<cfinvokeargument name="IDFieldName" value="#Arguments.AddressID#">
		</cfinvoke>
		<cfreturn CustomerAddress>
	</cffunction>
	
	<cffunction name="GetCustomerAddress" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CustomerAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="selectstatement" value=" where connectid='#Arguments.CustomerID#'">
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

		<cfoutput>cid=#arguments.customerID# dmtid=#arguments.emailtypeid#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.customerID#">
		</cfinvoke>
		<cfquery name="CustomerEmail" dbtype="query">
			select * from Email 
			<cfif #arguments.emailtypeid# neq 0>
				where emailtypeid='#arguments.emailtypeid#'
			</cfif>
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
		
		<cfset Address1="#XMLFormat(arguments.Address1)# ">
		<cfset Address2="#XMLFormat(arguments.Address2)# ">
		<cfif Address2 is ''><cfset Address2=" "></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City="#XMLFormat(arguments.City)# ">
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode="#XMLFormat(arguments.PostalCode)# ">
		<cfset State="#XMLFormat(arguments.State)# ">
		<cfset Country="#XMLFormat(arguments.Country)# ">
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
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
		
		<cfset Address1="#XMLFormat(arguments.Address1)# ">
		<cfset Address2="#XMLFormat(arguments.Address2)# ">
		<cfif Address2 is ''><cfset Address2=" "></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City="#XMLFormat(arguments.City)# ">
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode="#XMLFormat(arguments.PostalCode)# ">
		<cfset State="#XMLFormat(arguments.State)# ">
		<cfset Country="#XMLFormat(arguments.Country)# ">
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		
		<cfif #Arguments.Addressid# gt 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFilename" value="CustomerAddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
				<cfinvokeargument name="XMLIDValue" value="#addressid#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFilename" value="CustomerAddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
			</cfinvoke>
		</cfif>
	</cffunction>

	<cffunction name="UpdateEmail" access="remote" output="false">
		<cfargument name="EmailID" type="numeric" required="true" default=0>
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailID=#XMLFormat(arguments.EmailID)#>
		<cfset EmailTypeID=#XMLFormat(arguments.EmailTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset EmailAddress="#XMLFormat(arguments.EmailAddress)# ">
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
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
		<cfset EmailAddress="#XMLFormat(arguments.EmailAddress)# ">
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newid">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
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
		<cfset PhoneNumber="#XMLFormat(arguments.PhoneNumber)# ">
		
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
		<cfargument name="ConnectID" type="string" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#XMLFormat(arguments.PhoneTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PhoneNumber="#XMLFormat(arguments.PhoneNumber)# ">

		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber# ">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDVAlue" value="#arguments.PHoneID#">
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
		<cfargument name="companyname" type="string" required="true" default="0">
		
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
		<cfset companyname="#XMLFormat(arguments.companyname)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#resellerstate#,#resellernumber#,#companyname#">
		
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
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CustomerInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="IDFieldName" value="customerid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.customerID#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AddressInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.customerID#">
		</cfinvoke>
		
		<cfquery name="customer" dbtype="query">
			select * from CustomerInfo, CustomerAddress
			where customerAddress.connectid=CustomerInfo.customerid
			and customerAddress.addresstypeid=1
		</cfquery>

		<cfreturn Customer>
	</cffunction>
	
	<cffunction name="GetAllCustomer" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" type="numeric" required="false" default="0">
		<cfargument name="Alphabet" type="string" required="false" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="tCustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
		</cfinvoke>

		<cfif #tCustomer.recordcount# gt 0>
			<cfif #Arguments.alphabet# neq ''>
				<cfquery name="Customer" dbtype="query">
					select * from tCustomer
					where lastname like '#Arguments.alphabet#%'
					<cfif #Arguments.typeid# neq '0'>
						and Typeid='#arguments.typeid#'
					</cfif>
				</cfquery>
			<cfelse>
				<cfquery name="Customer" dbtype="query">
					select * from tCustomer
					<cfif #Arguments.typeid# neq '0'>
						where Typeid='#arguments.typeid#'
					</cfif>
				</cfquery>
			</cfif>
			<cfreturn Customer>
		<cfelse>
			<cfset Customer=querynew("CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname")>
		</cfif>
		<cfreturn Customer>
	</cffunction>
	
	<cffunction name="UpdateCustomer" access="remote" output="true">
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
		<cfargument name="companyname" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<Cfif active is ""><cfset active=0></Cfif>
		<cfset OnMailList=#XMLFormat(arguments.OnMailList)#>
		<Cfif OnMailList is ""><cfset OnMailList=0></Cfif>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset AffiliateID=#XMLFormat(arguments.AffiliateID)#>
		<Cfif AffiliateID is ""><cfset AffiliateID=0></Cfif>
		<cfset resellerstate="#XMLFormat(arguments.resellerstate)# ">
		<cfset resellernumber="#XMLFormat(arguments.resellernumber)# ">
		<cfset companyname="#XMLFormat(arguments.companyname)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#resellerstate#,#resellernumber#,#companyname#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CustomerID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.customerID#">
		</cfinvoke>
		<cfreturn #arguments.CustomerID#>
	</cffunction>
	
	<cffunction name="CheckLogin" access="remote" output="true" returntype="numeric">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Customer">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="SelectStatement" value=" where Password='#arguments.Password#'">
		</cfinvoke>
		
		<cfset tCustomer=0>
		<cfif #Customer.RecordCount# gt 0 and #arguments.username# neq ''>
			<cfif #arguments.username# is #Customer.username#>
				<cfif #Customer.Active# gt 0>
					<cfset tCustomer=#customer.customerid#>
				</cfif>
			</cfif>
		<cfelseif #Customer.RecordCount# gt 0>
			<cfif #Customer.Active# gt 0>
				<cfset tCustomer=#customer.customerid#>
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
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.PWord#">
		</cfinvoke>

		<cfreturn Customer>
	</cffunction>
</cfcomponent>