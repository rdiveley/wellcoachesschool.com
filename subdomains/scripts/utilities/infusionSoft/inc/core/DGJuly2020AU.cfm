<cfif !structKeyExists(attributes,'runstep')>
    <cfif listFindNoCase(attributes.tagList,14263) AND listFindNoCase(attributes.tagList,14257) >
        <!-- [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete  -->
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup">
        <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
        <cfset myArray[3]="(int)#attributes.memberID#">
        <cfset myArray[4]="(int)14269">

            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">

            <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>
            <cfset local.tag14269 = 1 />
    </cfif>
</cfif>    

<cfif (listFindNoCase(attributes.tagList,14263) OR structKeyExists(local,'tag14269'))
        AND listFindNoCase(attributes.tagList,14259) >
    <!-- [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete  -->
      <cfset myArray = ArrayNew(1)>
      <cfset myArray[1]="ContactService.addToGroup">
      <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
      <cfset myArray[3]="(int)#attributes.memberID#">
      <cfset myArray[4]="(int)14269">

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        <cfset local.tag13519 = 1 />
</cfif>