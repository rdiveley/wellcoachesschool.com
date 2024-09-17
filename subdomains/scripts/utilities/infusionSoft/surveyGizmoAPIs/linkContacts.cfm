	<cfif structkeyExists(url,'contactID1') and structKeyExists(url,'contactID2')>

		<cfif Compare(url.contactID1,url.contactID2) NEQ 0>
			<!--- link contacts --->
			
			<cfset local.key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
		    <cfset myArray = ArrayNew(1)>
		    <cfset myArray[1]="ContactService.linkContacts"><!---Service.method always first param--->
		    <cfset myArray[2]=local.key>
		    <cfset myArray[3]='(int)#URL.contactID1#'>
			<cfset myArray[4]='(int)#URL.contactID2#'>
			<cfset myArray[5]='(int)14'>

			<!--- convert to xmlrpc and post --->
		    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#"  returnvariable="myPackage">

			<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
				<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#local.key#"/>
				<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
			</cfhttp>

		    
			Success!
		<cfelse>
			Payor and Payee are the same ID
		</cfif>

	<cfelse>
		You Must Pass a both ContactID1 and ContactID2 to this script.
	</cfif>

