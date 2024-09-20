<!-- 	1 through 4 Residential lesson surveys are completed -->
<!-- 	a Y is entered into the Res Training Surveys [Aug2018 Fwd] field -->
<!-- 	IF 9783 is in place [Residential 4-day [Aug2018 Fwd] � generic statement Ray will use to make a �query� BEFORE applying any of the following program specific tags] -->
<!-- 	THEN 9705 can be applied [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete]  -->
<!--- CFDUMP: Debugging by rdiveley --->


<cfif structKeyExists(attributes,'email')>
    <cfset local.email = attributes.email />
</cfif>
<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfif  thisTag.ExecutionMode is 'start'>

	
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=local.email>
    <cfset myArray[4]=selectedFieldsArray>


    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">




        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

        <cfif !arrayLen(theData2.Params[1])>
            The email you entered <cfoutput><em>#local.email#</em></cfoutput> does not exist in our records.  Please contact your concierge for further assistance.<cfabort />
        </cfif>

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "_ResidentialTrainingSurveysCompleteAug2018Fwd">
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

       

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult3">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData">

        <cfparam name="theData.Params[1][1]['_ResidentialTrainingSurveysCompleteAug2018Fwd']" default=" ">

        <cfset updateList = theData.Params[1][1]['_ResidentialTrainingSurveysCompleteAug2018Fwd']>
	
        <cfset updateList = listRemoveDuplicates(updateList,'^') />

		<!-- if we have the complete list, apply restraining tag -->
		<cfif listLen(updateList,'^') GTE 4 OR updateList eq "Y">
          	<cfset updateField = structNew()>
          	<cfset updateField['_ResidentialTrainingSurveysCompleteAug2018Fwd']="Y">
			<cfset myArray = ArrayNew(1)>
	        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
	        <cfset myArray[2]=key>
	        <cfset myArray[3]='(int)#memberID#'>
	        <cfset myArray[4]=updateField>

	         <cfinvoke component="utilities/XML-RPC"
	              method="CFML2XMLRPC"
	              data="#myArray#"
	              returnvariable="myPackage4">

	        

              <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

               <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]=key>
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)16874">

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                
                 <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>

	  		
         </cfif>

 </cfif>       
        

       
         
      
           
       


