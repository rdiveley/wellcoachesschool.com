
<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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


    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult1">
        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>


    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

		<cfset memberID =  theData2.Params[1][1]['Id']>



<cfset updateField = structNew()>
<cfset updateField['_BCASurvey']="Y">
<cfset updateField['_BCACompleteDate']=DateFormat(now(),'mm/dd/yyyy')>

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
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>



<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]="(int)#memberID#">
<cfset myArray[4]="(int)15658">

<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">


    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>