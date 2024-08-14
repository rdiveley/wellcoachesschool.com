
<cfoutput>

<cfif isDefined('url.debug') and url.debug EQ 1>
	<cfdump var="#URL#">
</cfif>

<cfparam name="URL.lesson" default="">
<cfparam name="URL.cohort" default="">
<cfparam name="URL.faculty_member" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.faculty" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.lessonObj" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">
<cfparam name="URL.live" default="">
<cfset DSN = "wellcoachesSchool">

<cfif structKeyExists(url,'email')>
    <cfset local.email = url.email />
</cfif>

<cfif structKeyExists(url,'lesson')>
    <cfset local.lesson = url.lesson />
</cfif>

<cfif structKeyExists(url, 'emailForm')>
    <cfset local.email = url.emailForm />
</cfif>

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset selectedFieldsArray[4] = "_HWCTFeedbackSurveysComplete3">
<cfset selectedFieldsArray[5] = "_HabitsSurveysComplete">
<cfset selectedFieldsArray[6] = "Groups">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=local.email>
<cfset myArray[4]=selectedFieldsArray>

<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">

    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
        variable="myResult"
        timeout = "200">
    </cfexecute>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult#"
        returnvariable="theData">

		<cfif !ArrayLen(theData.Params[1])>
          	There is no user with that email address in our records. <cfabort>
        </cfif>

		<cfset memberID =  theData.Params[1][1]['Id']>

        <cfparam name="theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']" default="">
        <cfparam name="URL.Lesson" default="">

        <cfset updateList = theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']>

        <cfset updateList = listAppend(updateList,URL.Lesson,"^")>
        <cfset updateList = rematch("[\d]+",updateList)>
        <cfif arrayFind(updateList,"0")>
            <cfset arrayDeleteAt(updateList,arrayFind(updateList,"0")) />
        </cfif>
        <cfset updateList = arrayToList(updateList, "^") />
        <cfset updateList = listRemoveDuplicates(updateList,"^") />

        <cfif !FindNoCase('Y',updateList)> 
            <cfset updateList = listChangeDelims(updateList,"^") />
            <cfset memberTags =  theData.Params[1][1]['Groups']>
            <cfif listLen(updateList,"^") GTE 18>
                <cfset updateList = 'Y' />
                <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

                <cfset myArray2 = ArrayNew(1)>
                <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                <cfset myArray2[2]=key>
                <cfset myArray2[3]="(int)#memberID#">
                <cfset myArray2[4]="(int)16874">
            
                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray2#"
                    returnvariable="myPackage2">

                

                <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                    arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                    variable="myResult2"
                    timeout = "200">
                </cfexecute>
                

                <cfif structKeyExists(theData.Params[1][1], '_HabitsSurveysComplete') AND theData.Params[1][1]['_HabitsSurveysComplete'] EQ 'Y'>

                    <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
                    <cfset myArray2 = ArrayNew(1)>
                    <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                    <cfset myArray2[2]=key>
                    <cfset myArray2[3]="(int)#memberID#">
                    <cfset myArray2[4]="(int)16692">
                
                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray2#"
                        returnvariable="myPackage2">
                

                    

                    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                        variable="myResult2"
                        timeout = "200">
                    </cfexecute>

                </cfif>
            </cfif>

            <cfif updateList NEQ "Y">
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']=Replace(updateList.trim(),",","^","all")>
            <cfelse>
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']="Y">

			   <!-- 9781 [Core 18-Week Teleclass [Jul2018 Fwd] -->
			   <cfif listFindNoCase(memberTags,9781) and listFindNoCase(memberTags,9531) AND listFindNoCase(memberTags,9553) >
					<cfset local.hasInviteToMod3 = true>
			   <cfelse>
			   		<cfset local.hasInviteToMod3 = false>
			   </cfif>

			   <!-- IF 9781 is in place [Core 18-Week Teleclass [Jul2018 Fwd] � generic statement Ray will use to make a �query� BEFORE applying any of the following program specific tags]
					THEN 9557 can be applied [Core Jul2018 Mod 1 Lesson Surveys Complete] -->
			   <cfif local.hasInviteToMod3>
			   		<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
					<cfset myArray = ArrayNew(1)>
					<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
					<cfset myArray[2]=key>
					<cfset myArray[3]="(int)#memberID#">
					<cfset myArray[4]="(int)9557">

					<cfinvoke component="utilities/XML-RPC"
						method="CFML2XMLRPC"
						data="#myArray#"
						returnvariable="myPackage">
				

					
                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
			   </cfif>


            </cfif>
            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
            <cfset myArray[2]=key>
            <cfset myArray[3]='(int)#memberID#'>
            <cfset myArray[4]=updateField>

            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage4">

            
            <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
                variable="result"
                timeout = "200">
            </cfexecute>

        </cfif>

        <cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#" />

    
</cfoutput>

