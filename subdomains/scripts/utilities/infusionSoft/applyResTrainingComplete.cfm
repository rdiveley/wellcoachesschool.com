<!---<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>--->

<cfparam name="attributes.memberID" type="numeric" default="93408" />

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

<cfoutput>


	<cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Groups">


    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='(int)#attributes.memberID#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">

    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
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
    <cfmodule template="inc/residential/june2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/july2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/aug2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/oct2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/dec2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/feb2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/apr2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/jun2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/oct2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/dec2020-virtual.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/residential/mar2021-4_day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
</cfoutput>
