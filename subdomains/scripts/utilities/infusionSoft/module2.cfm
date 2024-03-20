	<cfparam  name="URL.Lesson" default="">
    
    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset selectedFieldsArray[4] = "_Module2SurveysComplete">
    <cfset selectedFieldsArray[5] = "Groups">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
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
        returnvariable="theData">

        <cfset memberID =  theData.Params[1][1]['Id']>
        
        <cfif !ArrayLen(theData.Params[1])>
            There is no user with that email address in our records. <cfabort>
        </cfif>

        <cfparam name="theData.Params[1][1]['_Module2SurveysComplete']" default=" ">
        <cfset updateList = theData.Params[1][1]['_Module2SurveysComplete']>

        <cfif updateList NEQ "Y">
			<cfset updateList = trim(listAppend(updateList,URL.Lesson,"^"))>
			<cfset updateField = structNew()>
	        <cfset updateField['_Module2SurveysComplete']=Replace(updateList.trim(),",","^","all")>
        </cfif>
        
        <cfset updateList = listRemoveDuplicates(updateList,'^') />

        <cfif listLen(updateList,'^') GTE 4 OR updateList EQ 'Y'>
          	<cfset updateField = structNew()>
          	<cfset updateField['_Module2SurveysComplete']="Y">

            <cfset memberTags =  theData.Params[1][1]['Groups']>

            <cfif listFindNoCase(memberTags,16878)>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)16696">

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
                
            <cfelseif listFindNoCase(memberTags,9987)>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)9615">

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
                
            <cfelseif listFindNoCase(memberTags,21348)>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)17646">

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>    
            </cfif>

	  		<cfmodule template="applyModule2Complete.cfm" memberID="#memberID#" />
         </cfif>

         <cfset myArray = ArrayNew(1)>
         <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
         <cfset myArray[2]=key>
         <cfset myArray[3]='(int)#memberID#'>
         <cfset myArray[4]=updateField>


         <cfinvoke component="utilities/XML-RPC"
              method="CFML2XMLRPC"
              data="#myArray#"
              returnvariable="myPackage4">

         <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
              <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
          </cfhttp>

         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


