<!---<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>--->

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

	<cfset local.tagList =  theData.Params[1]['Groups'] />
   
    <cfmodule template="inc/habits/july2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/aug2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/sept2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/nov2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/dec2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/feb2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />


    <cfmodule template="inc/residential/aug2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/dec2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/feb2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/apr2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />

    <cfmodule template="inc/core/july2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/sept2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/nov2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />

    
    <cfif listFindNoCase(local.tagList,9783) AND listFindNoCase(local.tagList,9673) AND listFindNoCase(local.tagList,9693)>
		<!-- THEN 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]
			AS WELL AS 9769 which delivers the Certificate of Attendance [Core Jul2018 Mod 1 ALL Surveys Complete] -->

		<!-- 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]  -->
		<cfset myArray = ArrayNew(1)>
	  	<cfset myArray[1]="ContactService.addToGroup">
        <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
        <cfset myArray[3]="(int)#attributes.memberID#">
        <cfset myArray[4]="(int)9707">

           <cfinvoke component="utilities/XML-RPC"
               method="CFML2XMLRPC"
               data="#myArray#"
               returnvariable="myPackage">

           <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
               <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
           </cfhttp>
    </cfif>
    

</cfoutput>