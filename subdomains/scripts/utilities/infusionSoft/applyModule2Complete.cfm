<!--- We enter here when the user has completed 4 of the module 2 surveys--->

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

   <cfset tagList =  theData.Params[1]['Groups'] />

   <cfif listFindNoCase(tagList, 12129)>
      <cfset myArray = ArrayNew(1)>
      <cfset myArray[1]="ContactService.addToGroup">
      <cfset myArray[2]=key>
      <cfset myArray[3]="(int)#attributes.memberID#">
      <cfset myArray[4]="(int)9615">

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
   </cfif>


  <!--- <cfmodule template="inc/module2/july2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/aug2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/sept2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/nov2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/dec2018.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/feb2019.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/univjan2019.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/jan2019.cfm" memberid="#attributes.memberid#" tagList="#tagList#" /> 
   <cfmodule template="inc/module2/feb2019Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/mar2019Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2019Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/may2019Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/june2019res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/resapr2019isreal.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
--->
   <cfmodule template="inc/module2/invalidcert.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/mod2standalone.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/july2019core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/aug2019Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/sept2019Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/oct2019res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/nov2019core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/dec2019res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />

   <cfmodule template="inc/module2/jan2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/feb2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/feb2020Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/mar2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2020Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/DGApr2020SG.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/may2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/may2020Monarch.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/june2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/june2020Res.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/HUMBER.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/july2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/july2020AU.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/aug2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/oct2020Virtual.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/nov2020Australia.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/sept2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/oct2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/nov2020Core.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/dec2020-virtual.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/untexasOct2020.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />

   <cfmodule template="inc/module2/jan2021_18week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/feb2021_9week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/mar2021_4day.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/mar2021_18week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2021_4day.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2021_4week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/apr2021_9week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/may2021_18week.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/may2021_4day.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />

   <cfmodule template="inc/module2/nov2020Isreal.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/IsrealPartner.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/genericpartners.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/untOct2021.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />
   <cfmodule template="inc/module2/untJun2022.cfm" memberid="#attributes.memberid#" tagList="#tagList#" />


</cfoutput>