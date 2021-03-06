<!---<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>--->

<cfparam name="attributes.memberID" type="numeric" default="93408" />

<cfoutput>


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
	<!-- 9783 [Residential 4-day [Aug2018 Fwd]  -->
    <cfset local.hasInviteToMod3 = listFindNoCase(local.tagList,9783)>
    
    <cfmodule template="inc/residential/aug2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/dec2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/feb2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/apr2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
</cfoutput>