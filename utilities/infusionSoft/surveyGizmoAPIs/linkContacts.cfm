	<cfif structkeyExists(url,'contactID1') and structKeyExists(url,'contactID2')>

		<cfif Compare(url.contactID1,url.contactID2) NEQ 0>
			<!--- link contacts --->
			<cfset local.key = "fb7d1fc8a4aab143f6246c090a135a41">
		    <cfset myArray = ArrayNew(1)>
		    <cfset myArray[1]="ContactService.linkContacts"><!---Service.method always first param--->
		    <cfset myArray[2]=local.key>
		    <cfset myArray[3]='(int)#URL.contactID1#'>
			<cfset myArray[4]='(int)#URL.contactID2#'>
			<cfset myArray[5]='(int)14'>

			<!--- convert to xmlrpc and post --->
		    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

		    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
		         <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
		    </cfhttp>

		    <!--- add group tag to contact 1--->
		   <!---  <cfset myArray = ArrayNew(1)>
			<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
			<cfset myArray[2]=local.key>
			<cfset myArray[3]="(int)#URL.contactID1#">
			<cfset myArray[4]="(int)3605 ">

			<cfinvoke component="utilities/XML-RPC" method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage">

			<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
				<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			</cfhttp>

			<!--- add group tag to contact 2--->
			<cfset myArray = ArrayNew(1)>
			<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
			<cfset myArray[2]=local.key>
			<cfset myArray[3]="(int)#URL.contactID2#">
			<cfset myArray[4]="(int)3605">

			<cfinvoke component="utilities/XML-RPC" method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage">

			<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
				<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			</cfhttp>

			<!--- get contact name --->
		    <cfset selectedFieldsArray = ArrayNew(1)>
		    <cfset selectedFieldsArray[1] = "Id">
		    <cfset selectedFieldsArray[2] = "FirstName">
		    <cfset selectedFieldsArray[3] = "LastName">


		    <cfset myArray = ArrayNew(1)>
		    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
		    <cfset myArray[2]=local.key>
		    <cfset myArray[3]="(int)#URL.contactID2#">
		    <cfset myArray[4]=selectedFieldsArray>

		    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage">

 			<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
				<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			</cfhttp>

			<!--- convert back to cfm to use  --->
			<cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML"  data="#myResult.Filecontent#" returnvariable="theData2">


			<!--- get contact name --->
		    <cfset selectedFieldsArray = ArrayNew(1)>
		    <cfset selectedFieldsArray[1] = "ContactNotes">

		    <cfset myArray = ArrayNew(1)>
		    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
		    <cfset myArray[2]=local.key>
		    <cfset myArray[3]="(int)#URL.contactID1#">
		    <cfset myArray[4]=selectedFieldsArray>

		    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage2">

 			<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult2">
				<cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
			</cfhttp>
			<!--- convert back to cfm to use  --->
			<cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML"  data="#myResult2.Filecontent#" returnvariable="theData3">

			<!--- add note --->
			<cfset myArray = ArrayNew(1)>
			<cfset selectedFieldStruct =structNew()>
		    <cfset selectedFieldStruct["ContactNotes"] = '#theData3.Params[1]['ContactNotes']##chr(13)##chr(10)##chr(13)##chr(10)#***ID #theData2.Params[1]['Id']# / #theData2.Params[1]['FirstName']# #theData2.Params[1]['LastName']# paid this current registration fee***'>
			<cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
			<cfset myArray[2]=local.key>
			<cfset myArray[3]="(int)#URL.contactID1#">
			<cfset myArray[4]=selectedFieldStruct>

			 <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			 <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
			         <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			 </cfhttp> --->
			Success!
		<cfelse>
			Payor and Payee are the same ID
		</cfif>

	<cfelse>
		You Must Pass a both ContactID1 and ContactID2 to this script.
	</cfif>

