	<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
    <cfset myArray[4]=selectedFieldsArray>

	<!-- format code to xml -->
    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

    <!-- send to infusionsoft -->
	<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult1">
    	<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>

	<!-- decode IS response back to struct -->
    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

		<!-- set memberID -->
		<cfset memberID =  theData2.Params[1][1]['Id']>

		<!--- get their tags --->
	<cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Groups">

    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!----Service.method always first param---->
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]='(int)#memberID#'>
    <cfset myArray[4]=selectedFieldsArray>

	<!-- convert call to xml -->
    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">

	<!-- send to IS -->
    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

	<!-- convert return from IS to structure -->
    <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#result.Filecontent#"
            returnvariable="theData">

    <cfset local.tagList =  theData.Params[1]['Groups'] />

	<!-- find 1828 "I am Certified" in tag list, if found, update field -->
	<!--- <cfif listFind(local.tagList,1828)> --->
		<!-- create a call to update field -->
        <cfset updateField = structNew()>
        <cfset updateField['_LMSurveyJul2018Fwd']="Y">
		<cfset updateField['_LMExamCompletionDate']="#now()#">

         <cfset myArray = ArrayNew(1)>
         <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
         <cfset myArray[2]=key>
         <cfset myArray[3]='(int)#memberID#'>
         <cfset myArray[4]=updateField>

		 <!-- convert 'myArray' to xml -->
         <cfinvoke component="utilities/XML-RPC"
              method="CFML2XMLRPC"
              data="#myArray#"
              returnvariable="myPackage4">

		<!-- send converted xml to IS -->
         <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
              <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
          </cfhttp>

		<!-- apply Tag ID 9833 [LM Mod 4 Survey/Training Complete  -->
		<cfset myArray = ArrayNew(1)>
		<cfset myArray[1]="ContactService.addToGroup">
        <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
        <cfset myArray[3]='(int)#memberID#'>
        <cfset myArray[4]="(int)9833">

           <!-- convert to xml -->
			<cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">
			<!-- send to IS -->
            <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

	<!--- </cfif> --->

         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


