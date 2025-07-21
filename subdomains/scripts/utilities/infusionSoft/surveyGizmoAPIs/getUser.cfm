<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfset recordFound = false>
<cfset foundEmail = "">
<cfloop list="#local.email#" index="local.emailUser" delimiters=",">
    <cfif NOT recordFound>
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1] = "ContactService.findByEmail">
        <cfset myArray[2] = key>
        <cfset myArray[3] = local.emailUser>
        <cfset myArray[4] = selectedFieldsArray>

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

        <cfif ArrayLen(theData2.Params[1])>
            <cfset recordFound = true>
            <cfset foundEmail = local.emailUser>
            <cfset memberID = theData2.Params[1][1]['Id']>

            <cfset selectedFieldsArray = ArrayNew(1)>
            <cfset selectedFieldsArray[1] = "_CertificationStartDate2">
            <cfset selectedFieldsArray[2] = "_CertificationNumber1">
            <cfset selectedFieldsArray[3] = "_CertificationDesignation">
            <cfset selectedFieldsArray[4] = "_NameasitappearsonformalCertificates">
            <cfset selectedFieldsArray[5] = "_RecertificationExpiryDate">
            <cfset selectedFieldsArray[6] = "_InactiveDate">
            <cfset selectedFieldsArray[7] = "_INVALIDDate">
            <cfset selectedFieldsArray[8] = "_CCEHforPreviousPeriod">
            <cfset selectedFieldsArray[9] = "_OptedoutofRecertificationProcessbecause">
            <cfset selectedFieldsArray[10] = "_CertificationRenewedDate">
            <cfset selectedFieldsArray[11] = "_HabitsSurveysComplete">
            <cfset selectedFieldsArray[12] = "_Module2SurveysComplete">

            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1] = "DataService.query">
            <cfset myArray[2] = key>
            <cfset myArray[3] = "Contact">
            <cfset myArray[4] = 10>
            <cfset myArray[5] = 0>
            <cfset myArray[6] = structNew()>
            <cfset myArray[6]["Email"] = foundEmail>
            <cfset myArray[7] = selectedFieldsArray>

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

            <!--- Check if theData.Params[1] exists and has records --->
            <cfif structKeyExists(theData, "Params") AND ArrayLen(theData.Params) GT 0 AND ArrayLen(theData.Params[1]) GT 0>
                <cfset contactData = theData.Params[1][1]>
                
                <cfset Module2Complete = structKeyExists(contactData, '_Module2SurveysComplete') ? contactData['_Module2SurveysComplete'] : ''>
                <cfset habitsComplete = structKeyExists(contactData, '_HabitsSurveysComplete') ? contactData['_HabitsSurveysComplete'] : ''>
                <cfset certStartDate = structKeyExists(contactData, '_CertificationStartDate2') ? DateFormat(contactData['_CertificationStartDate2'], 'mm/dd/yyyy') : ''>
                <cfset certNo = structKeyExists(contactData, '_CertificationNumber1') ? contactData['_CertificationNumber1'] : ''>
                <cfset certDesignation = structKeyExists(contactData, '_CertificationDesignation') ? contactData['_CertificationDesignation'] : ''>
                <cfset nameAppears = structKeyExists(contactData, '_NameasitappearsonformalCertificates') ? contactData['_NameasitappearsonformalCertificates'] : ''>
                <cfset REcertEndDate = structKeyExists(contactData, '_RecertificationExpiryDate') ? DateFormat(contactData['_RecertificationExpiryDate'], 'mm/dd/yyyy') : ''>
                <cfset certInactive = structKeyExists(contactData, '_InactiveDate') ? DateFormat(contactData['_InactiveDate'], 'mm/dd/yyyy') : ''>
                <cfset certInvalid = structKeyExists(contactData, '_INVALIDDate') ? DateFormat(contactData['_INVALIDDate'], 'mm/dd/yyyy') : ''>
                <cfset previousPeriod = structKeyExists(contactData, '_CCEHforPreviousPeriod') ? contactData['_CCEHforPreviousPeriod'] : ''>
                <cfset optedOut = structKeyExists(contactData, '_OptedoutofRecertificationProcessbecause') ? contactData['_OptedoutofRecertificationProcessbecause'] : ''>
                <cfif structKeyExists(contactData, '_CertificationRenewedDate')>
                    <cfset renewedDate = DateFormat(contactData['_CertificationRenewedDate'], 'mm/dd/yyyy')>
                <cfelseif structKeyExists(contactData, '_CertificationStartDate2')>
                    <cfset renewedDate = DateFormat(contactData['_CertificationStartDate2'], 'mm/dd/yyyy')>
                <cfelse>
                    <cfset renewedDate = ''>
                </cfif>
            <cfelse>
                <!--- Handle case where no data is returned --->
                <cfset Module2Complete = ''>
                <cfset habitsComplete = ''>
                <cfset certStartDate = ''>
                <cfset certNo = ''>
                <cfset certDesignation = ''>
                <cfset nameAppears = ''>
                <cfset REcertEndDate = ''>
                <cfset certInactive = ''>
                <cfset certInvalid = ''>
                <cfset previousPeriod = ''>
                <cfset optedOut = ''>
                <cfset renewedDate = ''>
            </cfif>
        </cfif>
    </cfif>
</cfloop>

<cfif NOT recordFound>
    There is no user with that email address in our records.
    <cfabort>
</cfif>
</head>
</html>