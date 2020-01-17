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

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "_Module2SurveysComplete">
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
            returnvariable="theData">
            

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


