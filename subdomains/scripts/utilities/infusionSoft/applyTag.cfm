<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>

<cfparam name="URL.email" default="rdiveley@wellcoaches.com">
<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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

<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>

<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">


<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]="(int)#theData.Params[1][1]['Id']#">
<cfset myArray[4]="(int)2099">


<cfinvoke component="utilities/XML-RPC"
	method="CFML2XMLRPC"
	data="#myArray#"
	returnvariable="myPackage">
<cfdump var="#myPackage#">

<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>

<cfdump var="#myResult#">
</cfoutput>

