<!--- We enter here when the user has completed 4 of the module 2 surveys--->

<cfparam name="attributes.memberID" type="numeric" default="93408" />

<cfoutput>
<!---<cfif thisTag.executionMode is "start" >--->

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
   <cfset tagList =  theData.Params[1]['Groups'] />

   <cfmodule template="inc/module2/july2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/aug2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/sept2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/nov2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/dec2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/feb2019.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />





</cfoutput>