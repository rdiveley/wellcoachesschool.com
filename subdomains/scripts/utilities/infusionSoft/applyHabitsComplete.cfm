<!---<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>--->

<cfparam name="attributes.memberID" type="numeric" default="93408" />

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

<cfoutput>
<!---<cfif thisTag.executionMode is "start" >--->

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
   
    <!---<cfmodule template="inc/habits/july2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/aug2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/sept2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/nov2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/dec2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/jan2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/feb2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/mar2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/may2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/june2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" /> --->
    <cfmodule template="inc/habits/july2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/july2019-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/aug2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/sept2019-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/oct2019-res.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/nov2019-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/dec2019-res.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/jan2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/feb2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/feb2020-res.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/mar2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2020-res.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/may2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/may2020-monarch.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/jun2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/jun2020-res.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/DGApr2020SG.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/aug2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/july2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/sept2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/oct2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/oct2020-virtual.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/nov2020-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/dec2020-virtual.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/jan2021-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/feb2021-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/march2021-core.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/march2021-virtual.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />

    <cfmodule template="inc/habits/apr2021-9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2021-4week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/apr2021-4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/habits/standalone.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  />

   <!--- <cfmodule template="inc/residential/aug2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/dec2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/feb2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/apr2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/june2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" /> --->
    <cfmodule template="inc/residential/July2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/aug2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/oct2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/dec2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/feb2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/apr2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/jun2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/oct2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/dec2020-virtual.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/residential/mar2021-4_day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2"/>

    <!---
        <cfmodule template="inc/core/july2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/sept2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/nov2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/jan2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/mar2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/may2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" /> --->
    <cfmodule template="inc/core/july2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/sept2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/nov2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/jan2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/feb2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/mar2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/may2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/june2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/DGApr2020SG.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/sept2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/july2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/aug2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/sept2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/oct2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/nov2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />

    <cfmodule template="inc/core/jan2021.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/feb2021.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" runstep="2" />
    <cfmodule template="inc/core/march2021.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/march2021_4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/apr2021_9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/apr2021_4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/apr2021_4week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />

    <cfmodule template="inc/core/aug2021_4week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/aug2021_9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/july2021_4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/july2021_9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/jun2021_4week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/jun2021_9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/may2021_4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/may2021_18week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/sept2021_4day.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/sept2021_4week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    <cfmodule template="inc/core/sept2021_9week.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#"  runstep="2" />
    




    
    <cfif listFindNoCase(local.tagList,9783) AND listFindNoCase(local.tagList,9673) AND listFindNoCase(local.tagList,9693)>
		<!-- THEN 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]
			AS WELL AS 9769 which delivers the Certificate of Attendance [Core Jul2018 Mod 1 ALL Surveys Complete] -->

		<!-- 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]  -->
		<cfset myArray = ArrayNew(1)>
	  	<cfset myArray[1]="ContactService.addToGroup">
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#attributes.memberID#">
        <cfset myArray[4]="(int)9707">

           <cfinvoke component="utilities/XML-RPC"
               method="CFML2XMLRPC"
               data="#myArray#"
               returnvariable="myPackage">

           <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>
    </cfif>
    

</cfoutput>
