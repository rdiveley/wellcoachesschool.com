<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

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

		<cfif !ArrayLen(theData2.Params[1])>
          	There is no user with that email address in our records. <cfabort>
          </cfif>

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
       	<!--- Start Date --->
        <cfset selectedFieldsArray[1] = "_CertificationStartDate2">
          <!--- certification number --->
		<cfset selectedFieldsArray[2] = "_CertificationNumber1">
          <!--- certification designation --->
		<cfset selectedFieldsArray[3] = "_CertificationDesignation">
          <!--- Name as it appears on formal cert --->
		<cfset selectedFieldsArray[4] = "_NameasitappearsonformalCertificates">
		<!--- Expiration/Inactive Date --->
        <cfset selectedFieldsArray[5] = "_RecertificationExpiryDate">
		 <!--- Inactive Date --->
		<cfset selectedFieldsArray[6] = "_InactiveDate">
          <!--- Invalid Date --->
		<cfset selectedFieldsArray[7] = "_INVALIDDate">
          <!--- CCEH for Previous Period --->
		<cfset selectedFieldsArray[8] = "_CCEHforPreviousPeriod">
		 <!--- Opted out reason --->
		<cfset selectedFieldsArray[9] = "_OptedoutofRecertificationProcessbecause">
         <!---renewal date--->
         <cfset selectedFieldsArray[10] = "_CertificationRenewedDate">
		<!--- habits complete? --->
     <cfset selectedFieldsArray[11] = "_HabitsSurveysComplete">
     	<!--- module2 complete? --->
 		<cfset selectedFieldsArray[12] = "_Module2SurveysComplete">

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



      <cfif !structKeyExists(theData.Params[1][1], '_Module2SurveysComplete')>
              <cfset Module2Complete = '' />
      <cfelse>
             <cfset Module2Complete  = theData.Params[1][1]['_Module2SurveysComplete'] />
      </cfif>       


	   <cfif !structKeyExists(theData.Params[1][1], '_HabitsSurveysComplete')>
       		<cfset habitsComplete = '' />
       <cfelse>
	  		  <cfset habitsComplete  = theData.Params[1][1]['_HabitsSurveysComplete'] />
       </cfif>

       <cfif !structKeyExists(theData.Params[1][1], '_CertificationStartDate2')>
       	  <cfset certStartDate = '' />
       <cfelse>
	  	  <cfset certStartDate  = DateFormat(theData.Params[1][1]['_CertificationStartDate2'],'mm/dd/yyyy') />
       </cfif>
 	  <cfif !structKeyExists(theData.Params[1][1], '_CertificationNumber1')>
       	<cfset certNo = '' />
       <cfelse>
	 	<cfset certNo  = theData.Params[1][1]['_CertificationNumber1'] />
	   </cfif>
	   <cfif !structKeyExists(theData.Params[1][1], '_CertificationDesignation')>
       	<cfset certDesignation = '' />
       <cfelse>
	 	<cfset certDesignation  = theData.Params[1][1]['_CertificationDesignation'] />
	   </cfif>
        <cfif !structKeyExists(theData.Params[1][1], '_NameasitappearsonformalCertificates')>
       	<cfset nameAppears = '' />
       <cfelse>
	 	<cfset nameAppears  = theData.Params[1][1]['_NameasitappearsonformalCertificates'] />
	   </cfif>
	   <cfif !structKeyExists(theData.Params[1][1], '_RecertificationExpiryDate')>
       	<cfset REcertEndDate = '' />
       <cfelse>
	 	<cfset REcertEndDate  = DateFormat(theData.Params[1][1]['_RecertificationExpiryDate'],'mm/dd/yyyy') />
	   </cfif>
       <cfif !structKeyExists(theData.Params[1][1], '_InactiveDate')>
       	<cfset certInactive = ''/>
       <cfelse>
	 	<cfset certInactive = DateFormat(theData.Params[1][1]['_InactiveDate'],'mm/dd/yyyy') />
	   </cfif>

	  <cfif !structKeyExists(theData.Params[1][1], '_INVALIDDate')>
       	<cfset certInvalid = ''/>
       <cfelse>
	 	<cfset certInvalid  = DateFormat(theData.Params[1][1]['_INVALIDDate'],'mm/dd/yyyy') />
	   </cfif>
         <cfif !structKeyExists(theData.Params[1][1], '_CCEHforPreviousPeriod')>
       	<cfset previousPeriod = '' />
       <cfelse>
	 	<cfset previousPeriod  = theData.Params[1][1]['_CCEHforPreviousPeriod'] />
	   </cfif>

         <cfif !structKeyExists(theData.Params[1][1], '_OptedoutofRecertificationProcessbecause')>
       	<cfset optedOut = '' />
       <cfelse>
	 	<cfset optedOut  = theData.Params[1][1]['_OptedoutofRecertificationProcessbecause'] />
	   </cfif>

         <cfif !structKeyExists(theData.Params[1][1], '_CertificationRenewedDate')>
          	<cfif structKeyExists(theData.Params[1][1], '_CertificationStartDate2')>
               	<cfset renewedDate = DateFormat(theData.Params[1][1]['_CertificationStartDate2'],'mm/dd/yyyy') />
               <cfelse>
              		<cfset renewedDate = '' />
               </cfif>
       <cfelse>
	 	<cfset renewedDate  = DateFormat(theData.Params[1][1]['_CertificationRenewedDate'],'mm/dd/yyyy') />
	   </cfif>











