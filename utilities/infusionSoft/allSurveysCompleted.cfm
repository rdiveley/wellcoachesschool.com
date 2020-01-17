
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Groups">


<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
<cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
<cfset myArray[3]='(int)#attributes.memberID#'>
<cfset myArray[4]=selectedFieldsArray>

<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage4">

<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
    <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
</cfhttp>

<cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#result.Filecontent#"
        returnvariable="theData">

<cfset local.tagList =  theData.Params[1]['Groups'] />

<cfif listFindNoCase(local.tagList,9557) AND listFindNoCase(local.tagList,9559)>   
    <!-- 9769 which delivers the Certificate of Attendance [Core Jul2018 Mod 1 ALL Surveys Complete]  -->
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.addToGroup">
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]="(int)#attributes.memberID#">
    <cfset myArray[4]="(int)9769">

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>
</cfif> 

<!-- AS LONG AS 9705 is in place [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete] and 9707 apply 9771 -->
<cfif listFindNoCase(local.tagList,9705) AND listFindNoCase(local.tagList,9707)>
    <cfset myArray = ArrayNew(1)>
      <cfset myArray[1]="ContactService.addToGroup">
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]="(int)#attributes.memberID#">
    <cfset myArray[4]="(int)9771">

       <cfinvoke component="utilities/XML-RPC"
           method="CFML2XMLRPC"
           data="#myArray#"
           returnvariable="myPackage">

       <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
           <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
       </cfhttp>
</cfif>