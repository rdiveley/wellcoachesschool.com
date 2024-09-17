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

    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result">
        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

    

    <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#result.Filecontent#"
            returnvariable="theData">
   <cfset tagList =  theData.Params[1]['Groups'] />


<!---   NOV2014_3567|3533:3569:3571:3587
   NOV2014 name of the tag HWCT_NOV2014 (program identified)
   3567 = NOV2014 feedback surveys complete
   3533 = Generic tag assignment part of NOV2014
   3569 = I've been trained
   3571 = No tag numbered
   3587 = no tag numbered

   --->
<!---

9007 Res Aug2018 Indy IN Feedback Survey Complete -> applied when completed once user has Y --->



   <cfset group1 = "AUG2018_9705|9673:9693" />

   <cfset paramList = "AUG2018_9705" />

  <!---  <cfloop list="#paramList#" index="class">
  		<cfset "<strong>RESTraining_</strong>#listFirst(class,'_')#" = 0 />
   		<cfset "RESTraining_#listFirst(class,'_')#_trained" = 0 />
   </cfloop> --->



   <!---group 1 has two values after pipe--->
   <cfloop list="#group1#" index="class">
  	   	<cfset firstTag = listFirst(listLast(class,'_'),"|") /><!--- marks survey complete tag --->
        <cfset secondTag =listFirst(ListLast(listLast(class,'_'),"|"),":") /><!--- generic tag assignment  --->
        <cfset thirdTag =listLast(ListLast(listLast(class,'_'),"|"),":")/>

       	  <cfset myArray = ArrayNew(1)>
		  <cfset myArray[1]="ContactService.addToGroup">
          <cfset myArray[2]=key>
          <cfset myArray[3]="(int)#attributes.memberID#">
          <cfset myArray[4]="(int)#firstTag#">

            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">

            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

   </cfloop>



</cfoutput>