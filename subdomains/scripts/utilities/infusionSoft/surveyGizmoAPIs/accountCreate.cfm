
<!--- LOAD CONTACT DATA USING ID --->
	<cfset local.key =  "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Email">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
	<cfset selectedFieldsArray[4] = "Company">
	<cfset selectedFieldsArray[5] = "CompanyID">
	<cfset selectedFieldsArray[6] = "AccountId">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
    <cfset myArray[2]=local.key>
    <cfset myArray[3]='(int)#URL.contactID#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">


	 <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
		<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
		<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
	</cfhttp>

    <cfinvoke component="utilities/XML-RPC"  method="XMLRPC2CFML" data="#myResult1.Filecontent#"  returnvariable="Account">

	<cfset local.account = Account.params[1]>

	<cfif local.account.AccountId EQ 0>
		 <!--- SEARCH FOR EXISTING COMPANY RECORD USING COMPANY NAME FROM CONTACT RECORD --->
		<cfif structKeyExists(local.account,'company')>
			<cfset selectedFieldStruct =structNew()>
	        <cfset selectedFieldStruct["Company"] = local.account.company>

			<cfset selectedFieldsArray = ArrayNew(1)>
			<cfset selectedFieldsArray[1] = "CompanyID">
			<cfset selectedFieldsArray[2] = "AccountID">

		 	<cfset myArray = ArrayNew(1)>
	        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
	        <cfset myArray[2]=local.key>
	        <cfset myArray[3]='Company'>
	        <cfset myArray[4]='(int)5'>
	        <cfset myArray[5]='(int)0'>
	        <cfset myArray[6]=selectedFieldStruct>
	        <cfset myArray[7]=selectedFieldsArray>

			<cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

		   

			<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
				<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
				<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			</cfhttp>

		    <cfinvoke component="utilities/XML-RPC"  method="XMLRPC2CFML" data="#myResult.Filecontent#"  returnvariable="CompanyInfo">
			<!--- have company and account ID --->

			<cfset local.company = CompanyInfo.params[1]>
			<!--- company doesn't exit so we need to add it --->
			<cfif !arrayLen(local.company)>
				<cfset selectedFieldStruct =structNew()>
	        	<cfset selectedFieldStruct["Company"] = local.account.company>

				<cfset myArray = ArrayNew(1)>
		        <cfset myArray[1]="DataService.add"><!---Service.method always first param--->
		        <cfset myArray[2]=local.key>
		        <cfset myArray[3]='Company'>
		        <cfset myArray[4]=selectedFieldStruct>

				<cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			    

				<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
					<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
					<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
				</cfhttp>

			    <cfinvoke component="utilities/XML-RPC"  method="XMLRPC2CFML" data="#myResult.Filecontent#"  returnvariable="CompanyInfo">

		       <!---  RETURN THE NEWLY CREATED COMPANY INFO --->
		        <cfset selectedFieldStruct =structNew()>
		        <cfset selectedFieldStruct["Company"] = local.account.company>

				<cfset selectedFieldsArray = ArrayNew(1)>
				<cfset selectedFieldsArray[1] = "CompanyID">
				<cfset selectedFieldsArray[2] = "AccountId">

			 	<cfset myArray = ArrayNew(1)>
		        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
		        <cfset myArray[2]=local.key>
		        <cfset myArray[3]='Company'>
		        <cfset myArray[4]='(int)5'>
		        <cfset myArray[5]='(int)0'>
		        <cfset myArray[6]=selectedFieldStruct>
		        <cfset myArray[7]=selectedFieldsArray>

				<cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			    

				<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
					<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
					<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
				</cfhttp>

			    <cfinvoke component="utilities/XML-RPC"  method="XMLRPC2CFML" data="#myResult.Filecontent#"  returnvariable="CompanyInfo">
				<!--- //ATTACH CONTACT TO THE NEW COMPANY RECORD --->
				<cfset local.newCompany = CompanyInfo.params[1][1]>

				 <cfset selectedFieldStruct =structNew()>
		         <cfset selectedFieldStruct["CompanyID"] = 'int()#local.newCompany.companyID#'>
		         <cfset selectedFieldStruct["AccountId"] = 'int()#local.newCompany.accountId#'>

				<cfset myArray = ArrayNew(1)>
		        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
		        <cfset myArray[2]=local.key>
		        <cfset myArray[3]='(int)#URL.contactID#'>
		        <cfset myArray[4]=selectedFieldStruct>

		        <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			    
				<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
					<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
					<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
				</cfhttp>

			<cfelse>
				<!--- ATTACH CONTACT TO EXISTING COMPANY RECORD --->
				<cfset selectedFieldStruct =structNew()>
		        <cfset selectedFieldStruct["CompanyID"] = 'int()#local.company[1].companyID#'>
		        <cfset selectedFieldStruct["AccountId"] = 'int()#local.company[1].accountId#'>

				<cfset myArray = ArrayNew(1)>
		        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
		        <cfset myArray[2]=local.key>
		        <cfset myArray[3]='(int)#URL.contactID#'>
		        <cfset myArray[4]=selectedFieldStruct>

		        <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			    

				<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
					<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
					<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
				</cfhttp>

			</cfif>
		</cfif>
	</cfif>