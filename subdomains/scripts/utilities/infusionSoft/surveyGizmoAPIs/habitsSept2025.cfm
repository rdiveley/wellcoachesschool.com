
    <cfparam  name="URL.lesson" default="">
	
    <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset selectedFieldsArray[4] = "_HabitsSurveysComplete">
    <cfset selectedFieldsArray[6] = "Groups">
    
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
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
        returnvariable="theData">

        <cfset memberID = theData.Params[1][1]['Id'] />
        <cfset memberTags =  theData.Params[1][1]['Groups']>

        <cfif !arrayLen(theData.Params[1])>
            The email you entered <cfoutput><em>#URL.email#</em></cfoutput> does not exist in our records.  Please contact your concierge for further assistance.<cfabort />
        </cfif>

        <cfparam name="theData.Params[1][1]['_HabitsSurveysComplete']" default=" ">

        <cfset updateField = structNew()>
        <cfset updateField['_HabitsSurveysComplete']="Y">
        
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#memberID#'>
        <cfset myArray[4]=updateField>
        
        <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage4">

            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
            </cfhttp>



