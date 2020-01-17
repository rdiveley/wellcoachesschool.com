<cfcomponent>
	
	<cffunction name="GetResume" access="remote" returntype="query" output="true">
		<cfargument name="EmployeeID" type="numeric" default="0" required="true">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Resume">
			<cfinvokeargument name="ThisPath" value="files/resumes">
			<cfinvokeargument name="ThisFileName" value="r#trim(arguments.EmployeeID)#">
		</cfinvoke>
		<cfreturn Resume>
		
	</cffunction>
	
	<cffunction name="SaveResume" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="ResumeID" type="numeric" required="true" default=0>
		<cfargument name="EmployeeID" type="numeric" required="true" default=0>
		<cfargument name="Resume" type="string" required="true" default="">
		<cfargument name="Title" type="string" required="true" default="">
		
		<cfset ResumeID=#trim(arguments.ResumeID)#>
		<cfset Title=#trim(replace(arguments.Title,',','~','ALL'))#>
		<cfset NewID=ResumeID>
		<cfset EmployeeID=#trim(arguments.EmployeeID)#>
		<cfset Resume="#trim(replace(arguments.Resume,',','~','ALL'))# ">
		
		<CFSET FieldList = "ConnectID,Resume,title">
		<CFSET FieldValues = "#EmployeeID#,#Resume# ,#title# ">
		<cfset NewID=#arguments.resumeID#>
		<Cfif int(ResumeID) is 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files/resumes">
				<cfinvokeargument name="ThisFileName" value="r#trim(employeeID)#">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="ResumeID">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/resumes">
				<cfinvokeargument name="ThisFileName" value="r#trim(employeeID)#">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="ResumeID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
		</cfif>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="GetEmployeePhone" access="remote" returntype="query" output="true">
		<cfargument name="EmployeeID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeephone">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployeeID#">
		</cfinvoke>
		<cfquery name="EmployeePhone" dbtype="query">
			select * from Phone
			<cfif #Arguments.PhoneTypeID# neq 0>
			where Phonetypeid='#arguments.phonetypeid#'
			</cfif>
		</cfquery>
		<cfreturn EmployeePhone>
		
	</cffunction>
	
	<cffunction name="GetEmployee" access="remote" output="true" returntype="query">
		<cfargument name="EmployeeID" default="0" type="numeric" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employee">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="IDFieldName" value="EmployeeID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployeeID#">
		</cfinvoke>

		<cfreturn Employee>
	</cffunction>
	
	<cffunction name="GetEmployeeAddressbyID" access="remote" output="true" returntype="query">
		<cfargument name="AddressID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployeeAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="EmployeeAddress">
			<cfinvokeargument name="IDFieldName" value="addressID">
			<cfinvokeargument name="IDFieldName" value="#Arguments.AddressID#">
		</cfinvoke>
		<cfreturn EmployeeAddress>
	</cffunction>
	
	<cffunction name="GetEmployeeAddress" access="remote" output="true" returntype="query">
		<cfargument name="EmployeeID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployeeAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="EmployeeAddress">
			<cfinvokeargument name="selectstatement" value=" where connectid='#Arguments.EmployeeID#'">
		</cfinvoke>
		<cfif #EmployeeAddress.RecordCount# gt 0>
		<cfquery name="tEmployeeAddress" dbtype="query">
			select * from EmployeeAddress 
			<cfif #Arguments.addresstypeid# gt 0>where addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfelse>
			<cfset tEmployeeAddress=querynew("addressid,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,TableID,Country")>
		</cfif>
		<cfreturn tEmployeeAddress>
	</cffunction>
	
	<cffunction name="GetEmployeeEmail" access="remote" output="true" returntype="query">
		<cfargument name="EmployeeID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">
			
		<cfif #Arguments.EMAILTYPEID# neq 0>
			<cfset WhereStatement="where EMAILTYPEID='#Arguments.EMAILTYPEID#'">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeeemail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployeeID#">
		</cfinvoke>
		<cfquery name="EmployeeEmail" dbtype="query">
			select * from Email 
		</cfquery>
		<cfreturn EmployeeEmail>
	</cffunction>
	
	
	<cffunction name="AddEmployeeAddress" access="remote" returntyhpe="numeric" output="true">
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
			<cfinvokeargument name="ThisFileName" value="Employeeaddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="addressid">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateEmployeeAddress" access="remote" output="false">
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
				<cfinvokeargument name="ThisFileName" value="Employeeaddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
				<cfinvokeargument name="XMLIDValue" value="#addressid#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeeaddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
			</cfinvoke>
		</cfif>
	</cffunction>

	<cffunction name="UpdateEmployeeEmail" access="remote" output="false">
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
		
		<cfif #int(arguments.emailid)# is 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeeemail">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="emailID">
			</cfinvoke>
		<Cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeeemail">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="emailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
			</cfinvoke>
		</cfif>
	</cffunction>
	
	<cffunction name="AddEmployeeEmail" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailTypeID=#arguments.EmailTypeID#>
		<cfset ConnectID=#trim(arguments.ConnectID)#>
		<cfset EmailAddress="#trim(arguments.EmailAddress)#">
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress# ">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newid">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="EmployeeEmail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="AddEmployeePhone" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="PhoneTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#trim(arguments.PhoneTypeID)#>
		<cfset ConnectID=#trim(arguments.ConnectID)#>
		<cfset PhoneNumber="#trim(arguments.PhoneNumber)#">
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber# ">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeephone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PhoneID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateEmployeePhone" access="remote" output="false">
		<cfargument name="PhoneID" type="string" required="true" default=0>
		<cfargument name="PhoneTypeID" type="string" required="true" default=0>
		<cfargument name="ConnectID" type="string" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#arguments.PhoneTypeID#>
		<cfset ConnectID=#arguments.ConnectID#>
		<cfset PhoneNumber="#arguments.PhoneNumber#">

		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber# ">

		<cfif #int(arguments.phoneID)# gt 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeephone">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="PhoneID">
				<cfinvokeargument name="XMLIDVAlue" value="#arguments.PHoneID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeephone">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="PhoneID">
			</cfinvoke>
		</cfif>
	</cffunction>
	
	<cffunction name="AddEmployee" access="remote" returntype="numeric" output="true">
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="">
		<cfargument name="CCExpire" type="string" required="true" default="">
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true"default="">
		<cfargument name="JobCategoryID" type="string" required="true"default="">
		<cfargument name="StartDate" type="date" required="true" default="">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="">
		<cfargument name="Password" type="string" required="true" default="">
		<cfargument name="StateID" type="string" required="true" default="">
		<cfargument name="LocationCity" type="string" required="true" default="0">
		<cfargument name="MilesFromHome" type="string" required="true" default="0">
		<cfargument name="websiteURL" type="string" required="true" default="0">
		<cfargument name="Title" type="string" required="true" default="0">
		<cfargument name="typeid" type="string" required="true" default="0">
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<Cfif active is ""><cfset active=0></Cfif>
		<cfset JobCategoryID=#XMLFormat(arguments.JobCategoryID)#>
		<Cfif JobCategoryID is ""><cfset JobCategoryID=0></Cfif>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset StateID=#XMLFormat(arguments.StateID)#>
		<Cfif StateID is ""><cfset StateID=0></Cfif>
		<cfset LocationCity="#XMLFormat(arguments.LocationCity)# ">
		<cfset MilesFromHome="#XMLFormat(arguments.MilesFromHome)# ">
		<cfset websiteURL="#XMLFormat(arguments.websiteURL)# ">
		<cfset title="#XMLFormat(arguments.title)# ">
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,JobCategoryID,StartDate,firstname,lastname,username,password,StateID,LocationCity,MilesFromHome,websiteURL,title,typeid">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#JobCategoryID#,#startdate#,#firstname#,#lastname# ,#username#,#password#,#StateID#,#LocationCity#,#MilesFromHome#,#websiteURL#,#title#,#arguments.typeid#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="EmployeeID">
		</cfinvoke>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="GetFullEmployee" access="remote" output="true" returntype="query">
		<cfargument name="EmployeeID" type="numeric" required="true" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployeeInfo">

			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="IDFieldName" value="Employeeid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployeeID#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AddressInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeeaddress">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployeeID#">
		</cfinvoke>
		
		<cfquery name="Employee" dbtype="query">
			select * from EmployeeInfo, EmployeeAddress
			where EmployeeAddress.connectid=EmployeeInfo.Employeeid
			and EmployeeAddress.addresstypeid=1
		</cfquery>

		<cfreturn Employee>
	</cffunction>
	
	<cffunction name="GetAllEmployee" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" type="numeric" required="false" default="0">
		<cfargument name="Alphabet" type="string" required="false" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="tEmployee">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="Employees">
		</cfinvoke>

		<cfif #tEmployee.recordcount# gt 0>
			<cfif #Arguments.alphabet# neq ''>
				<cfquery name="Employee" dbtype="query">
					select * from tEmployee
					where lastname like '#Arguments.alphabet#%'
					<cfif #Arguments.typeid# neq '0'>
						and Typeid='#arguments.typeid#'
					</cfif>
				</cfquery>
			<cfelse>
				<cfquery name="Employee" dbtype="query">
					select * from tEmployee
					<cfif #Arguments.typeid# neq '0'>
						where Typeid='#arguments.typeid#'
					</cfif>
				</cfquery>
			</cfif>
			<cfreturn Employee>
		<cfelse>
			<cfset Employee=querynew("CardName,Active,CCExpire,CCNo,CCType,JobCategoryID,StartDate,firstname,lastname,username,password,StateID,LocationCity,MilesFromHome,websiteURL")>
		</cfif>
		<cfreturn Employee>
	</cffunction>
	
	<cffunction name="UpdateEmployee" access="remote" output="true">
		<cfargument name="EmployeeID" type="numeric" required="true" default=0>
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="0">
		<cfargument name="CCExpire" type="string" required="true" default="0">
		<cfargument name="CCNo" type="string" required="true" default="0">
		<cfargument name="CCType" type="string" required="true"default="0">
		<cfargument name="JobCategoryID" type="string" required="true"default="0">
		<cfargument name="StartDate" type="date" required="true" default="0">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="StateID" type="string" required="true" default="0">
		<cfargument name="LocationCity" type="string" required="true" default="0">
		<cfargument name="MilesFromHome" type="string" required="true" default="0">
		<cfargument name="websiteURL" type="string" required="true" default="0">
		<cfargument name="title" type="string" required="true" default="0">
		<cfargument name="typeid" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<Cfif active is ""><cfset active=0></Cfif>
		<cfset JobCategoryID=#XMLFormat(arguments.JobCategoryID)#>
		<Cfif JobCategoryID is ""><cfset JobCategoryID=0></Cfif>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset StateID=#XMLFormat(arguments.StateID)#>
		<Cfif StateID is ""><cfset StateID=0></Cfif>
		<cfset LocationCity="#XMLFormat(arguments.LocationCity)# ">
		<cfset MilesFromHome="#XMLFormat(arguments.MilesFromHome)# ">
		<cfset websiteURL="#XMLFormat(arguments.websiteURL)# ">
		<cfset title="#XMLFormat(arguments.title)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,JobCategoryID,StartDate,firstname,lastname,username,password,StateID,LocationCity,MilesFromHome,websiteURL,title,typeid">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#JobCategoryID#,#startdate#,#firstname#,#lastname#,#username#,#password#,#StateID#,#LocationCity#,#MilesFromHome#,#websiteURL#,#title#,#arguments.typeid#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="EmployeeID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmployeeID#">
		</cfinvoke>
		<cfreturn #arguments.EmployeeID#>
	</cffunction>
	
	<cffunction name="CheckEmployeeLogin" access="remote" output="true" returntype="numeric">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employee">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="SelectStatement" value=" where Password='#trim(arguments.Password)#'">
		</cfinvoke>
		<cfset tEmployee=0>
		<cfif #Employee.RecordCount# gt 0 and #arguments.username# neq ''>
			<cfif #trim(arguments.username)# is #trim(Employee.username)#>
				<cfif #Employee.Active# gt 0>
					<cfset tEmployee=#Employee.Employeeid#>
				</cfif>
			</cfif>
		<cfelseif #Employee.RecordCount# gt 0>
			<cfif #Employee.Active# gt 0>
				<cfset tEmployee=#Employee.Employeeid#>
			</cfif>
		</cfif>
		<cfreturn tEmployee>
	</cffunction>
	
	<cffunction name="GetEmployeeByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employee">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employees">
			<cfinvokeargument name="IDFieldName" value="password">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.PWord#">
		</cfinvoke>
		<cfreturn Employee>
	</cffunction>
	
	<cffunction name="GetEmployerPhone" access="remote" returntype="query" output="true">
		<cfargument name="EmployerID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employerphone">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployerID#">
		</cfinvoke>
		<cfquery name="EmployerPhone" dbtype="query">
			select * from Phone
			<cfif #Arguments.PhoneTypeID# neq 0>
			where Phonetypeid='#arguments.phonetypeid#'
			</cfif>
		</cfquery>
		<cfreturn EmployerPhone>
		
	</cffunction>
	
	<cffunction name="GetEmployer" access="remote" output="true" returntype="query">
		<cfargument name="EmployerID" type="numeric" default="0" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="IDFieldName" value="EmployerID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployerID#">
		</cfinvoke>

		<cfreturn Employer>
	</cffunction>
	
	<cffunction name="GetEmployerAddressbyID" access="remote" output="true" returntype="query">
		<cfargument name="AddressID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployerAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="EmployerAddress">
			<cfinvokeargument name="IDFieldName" value="addressID">
			<cfinvokeargument name="IDFieldName" value="#Arguments.AddressID#">
		</cfinvoke>
		<cfreturn EmployerAddress>
	</cffunction>
	
	<cffunction name="GetEmployerAddress" access="remote" output="true" returntype="query">
		<cfargument name="EmployerID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployerAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="EmployerAddress">
			<cfinvokeargument name="selectstatement" value=" where connectid='#Arguments.EmployerID#'">
		</cfinvoke>
		<cfif #EmployerAddress.RecordCount# gt 0>
		<cfquery name="tEmployerAddress" dbtype="query">
			select * from EmployerAddress 
			<cfif #Arguments.addresstypeid# gt 0>where addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfelse>
			<cfset tEmployerAddress=querynew("addressid,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,TableID,Country")>
		</cfif>
		<cfreturn tEmployerAddress>
	</cffunction>
	
	<cffunction name="GetEmployerEmail" access="remote" output="true" returntype="query">
		<cfargument name="EmployerID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">
			
		<cfif #Arguments.EMAILTYPEID# neq 0>
			<cfset WhereStatement="where EMAILTYPEID='#Arguments.EMAILTYPEID#'">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeremail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployerID#">
		</cfinvoke>
		<cfquery name="EmployerEmail" dbtype="query">
			select * from Email 
		</cfquery>
		<cfreturn EmployerEmail>
	</cffunction>
	
	
	<cffunction name="AddEmployerAddress" access="remote" returntyhpe="numeric" output="true">
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
			<cfinvokeargument name="ThisFileName" value="Employeraddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="addressid">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateEmployerAddress" access="remote" output="false">
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
				<cfinvokeargument name="ThisFileName" value="Employeraddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
				<cfinvokeargument name="XMLIDValue" value="#addressid#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Employeraddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
			</cfinvoke>
		</cfif>
	</cffunction>

	<cffunction name="UpdateEmployerEmail" access="remote" output="false">
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
			<cfinvokeargument name="ThisFileName" value="Employeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="AddEmployerEmail" access="remote" returntyhpe="numeric" output="true">
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
			<cfinvokeargument name="ThisFileName" value="Employeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="AddEmployerPhone" access="remote" returntyhpe="numeric" output="true">
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
			<cfinvokeargument name="ThisFileName" value="Employerphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateEmployerPhone" access="remote" output="false">
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
			<cfinvokeargument name="ThisFileName" value="Employerphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDVAlue" value="#arguments.PHoneID#">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="AddEmployer" access="remote" returntype="numeric" output="true">
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="">
		<cfargument name="CCExpire" type="string" required="true" default="">
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true"default="">
		<cfargument name="ContactName" type="numeric" required="true"default="">
		<cfargument name="StartDate" type="date" required="true" default="">
		<cfargument name="username" type="string" required="true" default="">
		<cfargument name="Password" type="string" required="true" default="">
		<cfargument name="StateID" type="numeric" required="true" default="">
		<cfargument name="LocationCity" type="string" required="true" default="0">
		<cfargument name="CompanyName" type="string" required="true" default="0">
		<cfargument name="websiteURL" type="string" required="true" default="0">
		<cfargument name="typeid" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<Cfif active is ""><cfset active=0></Cfif>
		<cfset ContactName=#XMLFormat(arguments.ContactName)#>
		<Cfif ContactName is ""><cfset ContactName=0></Cfif>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset StateID=#XMLFormat(arguments.StateID)#>
		<Cfif StateID is ""><cfset StateID=0></Cfif>
		<cfset LocationCity="#XMLFormat(arguments.LocationCity)# ">
		<cfset CompanyName="#XMLFormat(arguments.CompanyName)# ">
		<cfset websiteURL="#XMLFormat(arguments.websiteURL)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,ContactName,StartDate,username,password,StateID,LocationCity,CompanyName,websiteURL,typeid">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#ContactName#,#startdate#,#username#,#password#,#StateID#,#LocationCity#,#CompanyName#,#websiteURL#,#arguments.typeid#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="EmployerID">
		</cfinvoke>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="GetFullEmployer" access="remote" output="true" returntype="query">
		<cfargument name="EmployerID" type="numeric" required="true" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="EmployerInfo">

			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="IDFieldName" value="Employerid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployerID#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AddressInfo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employeraddress">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmployerID#">
		</cfinvoke>
		
		<cfquery name="Employer" dbtype="query">
			select * from EmployerInfo, EmployerAddress
			where EmployerAddress.connectid=EmployerInfo.Employerid
			and EmployerAddress.addresstypeid=1
		</cfquery>

		<cfreturn Employer>
	</cffunction>
	
	<cffunction name="GetAllEmployer" access="remote" output="true" returntype="query">
		<cfargument name="Alphabet" type="string" required="false" default="all">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="tEmployer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="Employers">
		</cfinvoke>

		<cfif #tEmployer.recordcount# gt 0>
			<cfif #Arguments.alphabet# is 'all'>
				<cfquery name="Employer" dbtype="query">
					select * from tEmployer
					order by companyname
				</cfquery>
			<cfelseif #Arguments.alphabet# is "recent">
				<cfquery name="Employer" dbtype="query" maxrows="25">
					select * from tEmployer
					order by StartDate desc
				</cfquery>
			<cfelse>
				<cfquery name="Employer" dbtype="query">
					select * from tEmployer
					where (companyname like '#ucase(arguments.alphabet)#%' or companyname like '#lcase(arguments.alphabet)#%')
					order by companyname
				</cfquery>
			</cfif>
			<cfreturn Employer>
		<cfelse>
			<cfset Employer=querynew("EmployerID,CardName,Active,CCExpire,CCNo,CCType,ContactName,StartDate,username,password,StateID,LocationCity,CompanyName,websiteURL")>
		</cfif>
		<cfreturn Employer>
	</cffunction>
	
	<cffunction name="UpdateEmployer" access="remote" output="true">
		<cfargument name="EmployerID" type="numeric" required="true" default=0>
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="0">
		<cfargument name="CCExpire" type="string" required="true" default="0">
		<cfargument name="CCNo" type="string" required="true" default="0">
		<cfargument name="CCType" type="string" required="true"default="0">
		<cfargument name="ContactName" type="numeric" required="true"default="0">
		<cfargument name="StartDate" type="date" required="true" default="0">
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="StateID" type="string" required="true" default="0">
		<cfargument name="LocationCity" type="string" required="true" default="0">
		<cfargument name="CompanyName" type="string" required="true" default="0">
		<cfargument name="websiteURL" type="string" required="true" default="0">
		<cfargument name="typeID" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<Cfif active is ""><cfset active=0></Cfif>
		<cfset ContactName=#XMLFormat(arguments.ContactName)#>
		<Cfif ContactName is ""><cfset ContactName=0></Cfif>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset StateID=#XMLFormat(arguments.StateID)#>
		<Cfif StateID is ""><cfset StateID=0></Cfif>
		<cfset LocationCity="#XMLFormat(arguments.LocationCity)# ">
		<cfset CompanyName="#XMLFormat(arguments.CompanyName)# ">
		<cfset websiteURL="#XMLFormat(arguments.websiteURL)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,ContactName,StartDate,username,password,StateID,LocationCity,CompanyName,websiteURL,typeid">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#ContactName#,#startdate#,#username#,#password#,#StateID#,#LocationCity#,#CompanyName#,#websiteURL#,#arguments.typeid#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="EmployerID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmployerID#">
		</cfinvoke>
		<cfreturn #arguments.EmployerID#>
	</cffunction>
	
	<cffunction name="CheckEmployerLogin" access="remote" output="true" returntype="numeric">
		<cfargument name="Password" default="" type="string" required="true">
		<cfargument name="username" default="" type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employer">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="SelectStatement" value=" where Password='#trim(arguments.Password)#'">
		</cfinvoke>
		
		<cfset enddate=dateadd("m",-1,now())>
		<cfset enddate=dateformat(enddate,'yyyy/mm/dd')>
		<cfset tEmployer=0>
		<cfif #Employer.RecordCount# gt 0 and #trim(arguments.username)# neq ''>
			<cfif #trim(arguments.username)# is #trim(Employer.username)#>
				<cfif #Employer.Active# gt 0>
					<cfset tEmployer=#Employer.Employerid#>
					<cfoutput>#tEmployer#<br></cfoutput>
				</cfif>
			</cfif>
		<cfelseif #Employer.RecordCount# gt 0>
			<cfif #Employer.Active# gt 0>
				<cfset tEmployer=#Employer.Employerid#>
			</cfif>
		</cfif>
		<cfif #employer.startdate# lt #enddate#>
			<cfset temployer='#employer.employerid#0'>
		</cfif>
		<cfreturn tEmployer>
	</cffunction>
	
	<cffunction name="GetEmployerByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Employer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="IDFieldName" value="password">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.PWord#">
		</cfinvoke>

		<cfreturn Employer>
	</cffunction>

	<cffunction name="jobBoardConfig" access="remote" returntype="string" output="true">
		<cfargument name="ConfigAction" required="true" default="no">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="jobBoardConfig">
				<cfinvokeargument name="ThisPath" value="utilities">
		</cfinvoke>
		
		<cfparam name="EmailFrom" default='#application.email#'>
		<cfparam name="EmployeeThankYouPage" default='homepage'>
		<cfparam name="EmployeeCheckOutPage" default='homepage'>
		<cfparam name="EmployeeHomePage" default='homepage'>
		<cfparam name="EmployeeLoginPage" default='homepage'>
		<cfparam name="EmployeeSearchPage" default='homepage'>
		<cfparam name="EmployeeSearchResultsPage" default='homepage'>
		<cfparam name="JobSearchPage" default='homepage'>
		<cfparam name="JobSearchResultsPage" default='homepage'>
		<cfparam name="EmployeeRegistrationPage" default='homepage'>
		<cfparam name="EmployeeWelcome" default=''>
		<cfparam name="EmployeeDisclaimer" default=''>
		<cfparam name="EmployerThankYouPage" default='homepage'>
		<cfparam name="EmployerCheckOutPage" default='homepage'>
		<cfparam name="EmployerHomePage" default='homepage'>
		<cfparam name="EmployerLoginPage" default='homepage'>
		<cfparam name="EmployerSearchPage" default='homepage'>
		<cfparam name="EmployerSearchResultsPage" default='homepage'>
		<cfparam name="EmployerRegistrationPage" default='homepage'>
		<cfparam name="EmployerWelcome" default=''>
		<cfparam name="EmployerDisclaimer" default=''>
		<cfparam name="HotJobsPrice" default='0'>
		<cfparam name="HotJobsPricePer" default='0'>
		<cfparam name="StandardJobsPrice" default='0'>
		<cfparam name="StandardJobsPricePer" default='0'>
		<cfparam name="EmployerEmailText" default=''>
		<cfparam name="EmployeeEmailTExt" default=''>
		<cfparam name="PostCompanyTkuPage" default='homepage'>
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="jobBoardConfig">
				<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
				<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
				<cfinvokeargument name="IDFieldName" value="configID">
				<cfinvokeargument name="IDFieldValue" value="0000000001">
			</cfinvoke>
			<cfoutput query="jobBoardConfig">
				<cfset EmailFrom='#EmailFrom#'>
				<cfset EmployeeThankYouPage='#trim(EmployeeThankYouPage)#'>
				<cfset EmployeeCheckOutPage='#trim(EmployeeCheckOutPage)#'>
				<cfset EmployeeHomePage='#trim(EmployeeHomePage)#'>
				<cfset EmployeeLoginPage='#trim(EmployeeLoginPage)#'>
				<cfset EmployeeSearchPage='#trim(EmployeeSearchPage)#'>
				<cfset EmployeeSearchResultsPage='#trim(EmployeeSearchResultsPage)#'>
				<cfset EmployeeRegistrationPage='#trim(EmployeeRegistrationPage)#'>
				<cfset EmployeeWelcome='#replace(EmployeeWelcome,"~",",","ALL")#'>
				<cfset EmployeeDisclaimer='#replace(EmployeeDisclaimer,"~",",","ALL")#'>
				<cfset EmployerThankYouPage='#trim(EmployerThankYouPage)#'>
				<cfset EmployerCheckOutPage='#trim(EmployerCheckOutPage)#'>
				<cfset EmployerHomePage='#trim(EmployerHomePage)#'>
				<cfset EmployerLoginPage='#trim(EmployerLoginPage)#'>
				<cfset EmployerSearchPage='#trim(EmployerSearchPage)#'>
				<cfset EmployerSearchResultsPage='#trim(EmployerSearchResultsPage)#'>
				<cfset EmployerRegistrationPage='#trim(EmployerRegistrationPage)#'>
				<cfset EmployerWelcome='#replace(EmployerWelcome,"~",",","ALL")#'>
				<cfset EmployerDisclaimer='#replace(EmployerDisclaimer,"~",",","ALL")#'>
				<cfset HotJobsPrice='#HotJobsPrice#'>
				<cfset HotJobsPricePer='#HotJobsPricePer#'>
				<cfset StandardJobsPrice='#StandardJobsPrice#'>
				<cfset StandardJobsPricePer='#StandardJobsPricePer#'>
				<cfset JobSearchPage='#trim(JobSearchPage)#'>
				<cfset JobSearchResultsPage='#trim(JobSearchResultsPage)#'>
				<cfif isdefined('jobBoardConfig.EmployerEmailText')>
				<cfset EmployerEmailText='#replace(EmployerEmailText,"~",",","ALL")#'>
				<cfset EmployeeEmailText='#replace(EmployeeEmailText,"~",",","ALL")#'>
				<Cfset PostCompanyTkuPage=#PostCompanyTkuPage#>				
				</cfif>
			</cfoutput>
		</cfif>
		
		<cfif #arguments.ConfigAction# is "YES">
			<cfset ConfigID="0000000001">
			<cfif not isdefined('form.PostCompanyTkuPage')>
				<cfset form.PostCompanyTkuPage="homepage">
			</cfif>
			<cfif #TheFileExists# is "true">
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
					<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
					<cfinvokeargument name="XMLFields" value="EmailFrom,EmployeeThankYouPage,EmployeeCheckOutPage,EmployeeHomePage,EmployeeLoginPage,EmployeeSearchPage,EmployeeSearchResultsPage,EmployeeRegistrationPage,EmployeeWelcome,EmployeeDisclaimer,EmployerThankYouPage,EmployerCheckOutPage,EmployerHomePage,EmployerLoginPage,EmployerSearchPage,EmployerSearchResultsPage,EmployerRegistrationPage,EmployerWelcome,EmployerDisclaimer,JobSearchPage,JobSearchResultsPage,HotJobsPrice,HotJobsPricePer,StandardJobsPrice,StandardJobsPricePer,EmployerEmailText,EmployeeEmailText,PostCompanyTkuPage">
					<cfinvokeargument name="XMLFieldData" value="#form.EmailFrom#,#form.EmployeeThankYouPage#,#form.EmployeeCheckOutPage#,#form.EmployeeHomePage#,#form.EmployeeLoginPage#,#form.EmployeeSearchPage#,#form.EmployeeSearchResultsPage#,#form.EmployeeRegistrationPage#,#replace(form.EmployeeWelcome,',','~','ALL')# ,#replace(form.EmployeeDisclaimer,',','~','ALL')# ,#form.EmployerThankYouPage#,#form.EmployerCheckOutPage#,#form.EmployerHomePage#,#form.EmployerLoginPage#,#form.EmployerSearchPage#,#form.EmployerSearchResultsPage#,#form.EmployerRegistrationPage#,#replace(form.EmployerWelcome,',','~','ALL')# ,#replace(form.EmployerDisclaimer,',','~','ALL')# ,#form.JobSearchPage#,#form.JobSearchResultsPage#,#form.HotJobsPrice#,#form.HotJobsPricePer#,#form.StandardJobsPrice#,#form.StandardJobsPricePer#,#replace(form.EmployerEmailText,',','~','ALL')# ,#replace(form.EmployeeEmailText,',','~','ALL')# ,#form.PostCompanyTkuPage#">
					<cfinvokeargument name="XMLIDField" value="configID">
					<cfinvokeargument name="XMLIDValue" value="0000000001">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
					<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
					<cfinvokeargument name="XMLFields" value="EmailFrom,EmployeeThankYouPage,EmployeeCheckOutPage,EmployeeHomePage,EmployeeLoginPage,EmployeeSearchPage,EmployeeSearchResultsPage,EmployeeRegistrationPage,EmployeeWelcome,EmployeeDisclaimer,EmployerThankYouPage,EmployerCheckOutPage,EmployerHomePage,EmployerLoginPage,EmployerSearchPage,EmployerSearchResultsPage,EmployerRegistrationPage,EmployerWelcome,EmployerDisclaimer,JobSearchPage,JobSearchResultsPage,HotJobsPrice,HotJobsPricePer,StandardJobsPrice,StandardJobsPricePer,EmployerEmailText,EmployeeEmailText,PostCompanyTkuPage">
					<cfinvokeargument name="XMLFieldData" value="#form.EmailFrom#,#form.EmployeeThankYouPage#,#form.EmployeeCheckOutPage#,#form.EmployeeHomePage#,#form.EmployeeLoginPage#,#form.EmployeeSearchPage#,#form.EmployeeSearchResultsPage#,#form.EmployeeRegistrationPage#,#replace(form.EmployeeWelcome,',','~','ALL')# ,#replace(form.EmployeeDisclaimer,',','~','ALL')# ,#form.EmployerThankYouPage#,#form.EmployerCheckOutPage#,#form.EmployerHomePage#,#form.EmployerLoginPage#,#form.EmployerSearchPage#,#form.EmployerSearchResultsPage#,#form.EmployerRegistrationPage#,#replace(form.EmployerWelcome,',','~','ALL')# ,#replace(form.EmployerDisclaimer,',','~','ALL')# ,#form.JobSearchPage#,#form.JobSearchResultsPage#,#form.HotJobsPrice#,#form.HotJobsPricePer#,#form.StandardJobsPrice#,#form.StandardJobsPricePer#,#replace(form.EmployerEmailText,',','~','ALL')# ,#replace(form.EmployeeEmailText,',','~','ALL')# ,#form.PostCompanyTkuPage#">
					<cfinvokeargument name="XMLIDField" value="configID">
				</cfinvoke>
			</cfif>
			<cflocation url="adminheader.cfm?action=jobBoardConfig&ConfigAction=NO">
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="pages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		<h1>Reservations Configuration</h1>
		<cfoutput>

		<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
		  <input type="hidden" name="configAction" value="YES">
		  <input type="hidden" name="Action" value="#Action#">
		  <div align="center"><center>
		  <table>
		  <tr><td colspan=2><strong>Jobs</strong></td></tr>
			<tr>
			  <td>Enter the email address all job mail will be sent from <br>This email address must exist in your web mail:</td>
			  <td><input type="text" name="emailfrom" value="#trim(EmailFrom)#"></td>
			 </tr>
			 <tr>
			  <td>Hot Jobs Pricing</td>
			  <td><input type="text" name="hotJobsprice" value="#trim(hotJobsprice)#"></td>
			 </tr>
			 <tr>
			  <td>Hot Jobs Price Per</td>
			  <td><select name="hotJobsPricePer">
			  	<option value="day"<cfif #HotJobsPricePer# is "day"> selected</cfif>>Per Day</option>
				<option value="week"<cfif #HotJobsPricePer# is "week"> selected</cfif>>Per Week</option>
				<option value="30"<cfif #HotJobsPricePer# is "30"> selected</cfif>>30 Days</option>
				<option value="45"<cfif #HotJobsPricePer# is "45"> selected</cfif>>45 Days</option>
				<option value="90"<cfif #HotJobsPricePer# is "90"> selected</cfif>>90 Days</option>
			  </select>
			  </td>
			 </tr>
			 <tr>
			  <td>Standard Jobs Pricing</td>
			  <td><input type="text" name="StandardJobsprice" value="#trim(StandardJobsprice)#"></td>
			 </tr>
			 <tr>
			  <td>Standard Jobs Price Per</td>
			  <td><select name="StandardJobsPricePer">
			  	<option value="day"<cfif #StandardJobsPricePer# is "day"> selected</cfif>>Per Day</option>
				<option value="week"<cfif #StandardJobsPricePer# is "week"> selected</cfif>>Per Week</option>
				<option value="30"<cfif #StandardJobsPricePer# is "30"> selected</cfif>>30 Days</option>
				<option value="45"<cfif #StandardJobsPricePer# is "45"> selected</cfif>>45 Days</option>
				<option value="90"<cfif #StandardJobsPricePer# is "90"> selected</cfif>>90 Days</option>
			  </select>
			  </td>
			 </tr>
			 <tr>
			<td>Job Search Page</td>
		<td><select name="JobSearchPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #JobSearchPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Job Search Results Page</td>
		<td><select name="JobSearchResultsPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #JobSearchResultsPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			  <tr><td colspan=2><strong>Employees</strong></td></tr>
				<tr>
			<td>Employee Home Page<br>
			  <td><select name="EmployeeHomePage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeHomePage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			</tr>
			</tr><tr>
			  <td>Employee Check out page</td>
			  <td><select name="EmployeeCheckOutPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeCheckOutPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr><tr>
		<td>Employee Thank You Page<br></td>
			  <td><select name="EmployeeThankYouPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeThankYouPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr>
			<tr>
			<td>Employee Login Page</td>
		<td><select name="EmployeeLoginPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeLoginPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Registration Page</td>
		<td><select name="EmployeeRegistrationPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeRegistrationPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Search Page</td>
		<td><select name="EmployeeSearchPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeSearchPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Search Results Page</td>
		<td><select name="EmployeeSearchResultsPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployeeSearchResultsPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Email Text</td>
		<td><a href="javascript:GetEditor('thisform','EmployeeEmailText')"  class=box>Click here for the editor</a><br><textarea name="EmployeeEmailText" cols=40 rows=7>#EmployeeEmailText#</textarea>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Welcome</td>
		<td><a href="javascript:GetEditor('thisform','EmployeeWelcome')"  class=box>Click here for the editor</a><br><textarea name="EmployeeWelcome" cols=40 rows=7>#EmployeeWelcome#</textarea>
			  </td>
				  
			</tr>
			<tr>
			<td>Employee Disclaimer</td>
		<td><a href="javascript:GetEditor('thisform','EmployeeDisclaimer')"  class=box>Click here for the editor</a><br><textarea name="EmployeeDisclaimer" cols=40 rows=7>#EmployeeDisclaimer#</textarea>
			  </td>
				  
			</tr>
			
			<tr><td colspan=2><strong>Employers</strong></td></tr>
			<tr>
			<td>Employer Home Page<br>
			  <td><select name="EmployerHomePage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerHomePage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			</tr>
			</tr><tr>
			  <td>Employer Check out page</td>
			  <td><select name="EmployerCheckOutPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerCheckOutPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr><tr>
		<td>Employer Thank You Page<br></td>
			  <td><select name="EmployerThankYouPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerThankYouPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr>
			<tr>
			<td>Employer Login Page</td>
		<td><select name="EmployerLoginPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerLoginPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Registration Page</td>
		<td><select name="EmployerRegistrationPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerRegistrationPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Search Page</td>
		<td><select name="EmployerSearchPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerSearchPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Search Results Page</td>
		<td><select name="EmployerSearchResultsPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #EmployerSearchResultsPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Email Text</td>
		<td><a href="javascript:GetEditor('thisform','EmployerEmailText')"  class=box>Click here for the editor</a><br><textarea name="EmployerEmailText" cols=40 rows=7>#EmployerEmailText#</textarea>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Welcome</td>
		<td><a href="javascript:GetEditor('thisform','EmployerWelcome')"  class=box>Click here for the editor</a><br><textarea name="EmployerWelcome" cols=40 rows=7>#EmployerWelcome#</textarea>
			  </td>
				  
			</tr>
			<tr>
			<td>Employer Disclaimer</td>
		<td><a href="javascript:GetEditor('thisform','EmployerDisclaimer')"  class=box>Click here for the editor</a><br><textarea name="EmployerDisclaimer" cols=40 rows=7>#EmployerDisclaimer#</textarea>
			  </td>
				  
			</tr>
		<tr>
			<td>Careers Resouces Post a company Thank You page</td>
		<td><select name="PostCompanyTkuPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #PostCompanyTkuPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			  <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
			  </td>
			  <td></td>
			</tr>
		  </table>
		  </center></div>
		</form>
		
		</cfoutput>
		
		<cfreturn ConfigAction>
	</cffunction>
	
</cfcomponent>