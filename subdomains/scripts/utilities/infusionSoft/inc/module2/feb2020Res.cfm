<cfif listFindNoCase(attributes.tagList,12649) AND listFindNoCase(attributes.tagList,12683)>
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.addToGroup">
    <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
    <cfset myArray[3]="(int)#attributes.memberID#">
    <cfset myArray[4]="(int)12705">

      <cfinvoke component="utilities/XML-RPC"
          method="CFML2XMLRPC"
          data="#myArray#"
          returnvariable="myPackage">

      <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
          <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
      </cfhttp>
</cfif>