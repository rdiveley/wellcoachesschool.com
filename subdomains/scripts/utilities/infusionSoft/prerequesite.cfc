<cffunction nameg="getPrereq" access="remote" returntype="any">
	<cfset key = "fb7d1fc8a4aab143f6246c090a135a41" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.Email>
    <cfset myArray[4]=selectedFieldsArray>

	<cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">


        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult1">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    	<cfinvoke component="utilities/XML-RPC"
	        method="XMLRPC2CFML"
	        data="#myResult1.Filecontent#"
	        returnvariable="theData2">

		<cfif !ArrayLen(theData2.Params[1])>
          	<h1>There is no user with that email address in our records.</h1><cfabort>
        </cfif>


		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Groups">
        <cfset selectedFieldsArray[2] = "Id">

        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='Contact'>
        <cfset myArray[4]='(int)10'>
        <cfset myArray[5]='(int)0'>
        <cfset myArray[6]=selectedFieldStruct>
        <cfset myArray[7]=selectedFieldsArray>

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

          <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData3">

       <cfset memberTags =  theData3.Params[1][1]['Groups']>

		<cfif listFind(memberTags,'2099')>
			<cfset returnString = "Thank you, your prerequisite proof has been uploaded. Please check back in two or three days to further confirm your submission. Once your document has been reviewed and approved, a ‘YES CHWC’ or ‘YES CPC’ will be listed at the Certification Results page in your Wellcoaches Customer Hub account.">
		<cfelse>
			<cfset returnString = 'Your prerequisite document(s) has/have NOT been received'>
		</cfif>
	<cfreturn returnString>
</cffunction>




