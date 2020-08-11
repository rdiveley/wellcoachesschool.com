<!---<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>--->
<!-- Core Coach Training - 18-week program - Lesson Feedback Survey, comes here when completed 18 surveys -->
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

    <cfmodule template="inc/core/july2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/sept2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/nov2018.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/jan2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/mar2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/may2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/july2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/sept2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/nov2019.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/jan2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/feb2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/mar2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/apr2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" />
    <cfmodule template="inc/core/may2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" /> 
    <cfmodule template="inc/core/may2020Monarch.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" /> 
    <cfmodule template="inc/core/june2020.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" /> 
    <cfmodule template="inc/core/DGApr2020SG.cfm" memberid="#attributes.memberid#" tagList="#local.tagList#" /> 
    




<!---   NOV2014_3567|3533:3569:3571:3587
   NOV2014 name of the tag HWCT_NOV2014 (program identified)
   3567 = NOV2014 feedback surveys complete
   3533 = Generic tag assignment part of NOV2014
   3569 = I've been trained
   3571 = No tag numbered
   3587 = no tag numbered

   --->



   <cfset group1 = "JAN2017_6670|6660:6668,SEP2016_6584|6434:6466,NOV2016_6804|6744:6770,APR2017_7440|7430:7438,JAN2017_6972|6914:6938,MAR2017_7386|7144:7168,JUN2017_7270|7260:7268,AUG2017_7320|7310:7318,AUG2017_8262|8266:8260,SEP2017_8060|8050:8058,MAY2017_7692|7634:7656,NOV2017_8126|8116:8124,NOV2017_8406|8396:8404,JUL2017_7884|7834:7848,JAN2018_8462|8452:8460,JAN2018_8807|8783:8791,SEP2017_8242|8168:8184,NOV2017_8388|8336:8352,JAN2018_8672|8616:8632,AUG2018_9705|9707:9771,JUN2018_9253|9229:9237,MAR2018_8775|8721:8735,JUL2018_8933|8909:8917,MAY2018_9343|9289:9303" />

   <cfset paramList = "JAN2017_6792,MAR2017_7386,JUN2017_7270,AUG2017_7320,AUG2017_8262,SEP2017_8060,MAY2017_7692,NOV2017_8126,NOV2017_8406,JUL2017_7884,JAN2018_8462,JAN2018_8807,SEP2017_8242,NOV2017_8388" />

   <cfloop list="#paramList#" index="class">
  		<cfset "HWCT_#listFirst(class,'_')#" = 0 />
   		<cfset "HWCT_#listFirst(class,'_')#_trained" = 0 />
   </cfloop>

   <!---group 1 has two values after pipe--->

<!-- 1. gets the list of the users tags -->
<!-- 2. if the user has either firsttag or secondTag, then we apply the firsttag to their account -->
   <cfloop list="#group1#" index="class">
  	   	<cfset firstTag = listFirst(listLast(class,'_'),"|") />
        <cfset secondTag =listFirst(ListLast(listLast(class,'_'),"|"),":") />
        <cfset thirdTag =listLast(ListLast(listLast(class,'_'),"|"),":")/>

   	   	<cfset preClass = "HWCT_#listFirst(class,'_')#" />
        <cfset postClass = "HWCT_#listFirst(class,'_')#_trained" />

  		<cfset preClass = listFind(local.tagList,firstTag)/>
  	 	<cfset postClass = listFind(local.tagList,secondTag)/>

		<cfif preClass OR postClass>

       	  <cfset myArray = ArrayNew(1)>
		  <cfset myArray[1]="ContactService.addToGroup">
            <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
            <cfset myArray[3]="(int)#attributes.memberID#">
            <cfset myArray[4]="(int)#firstTag#">

            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">

            <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

        </cfif>
   </cfloop>






</cfoutput>

