<cfoutput>

<cfif structKeyExists(url,'email')>
    <cfset local.email = url.email />
</cfif>

<cfif structKeyExists(url,'lesson')>
    <cfset local.lesson = url.lesson />
</cfif>

<cfif structKeyExists(url, 'emailForm')>
    <cfset local.email = url.emailForm />
</cfif>

<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
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
        <cfset memberTags =  theData.Params[1][1]['Groups']>


<cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/1013764/surveyresponse">

<cfset emailParam = "[question(50)]" />
<cfset local.params = "filter[field][0]=#urlEncodedFormat(emailParam)#&filter[operator][0]=in&filter[value][0]=#trim(urlEncodedFormat(url.email))#&filter[field][1]=status&filter[operator][1]==&filter[value][1]=complete&resultsperpage=500" />

<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments = '-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca -d #local.params#'
        variable="local.myResult"
        timeout = "200">
</cfexecute>

<cfset jsonData = deserializeJSON(local.myResult) />

<cfset local.updateList = "" />
<cfset local.newList = "" />

<cfloop array="#jsonData.data#" index="local.field">
    <cfset local.updateList = arrayToList(rematch("[\d]+",local.field['[question(8)]']))>
    <cfset local.newList = listAppend(local.newList,local.updateList) />
</cfloop>

<cfset local.newList = listChangeDelims(listRemoveDuplicates(local.newList),"^") />
<cfset local.updateList = "" />



<cfif listLen(local.newList,"^") GTE 18>
    <cfset local.updateList = 'Y' />
    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
        variable="myResult2"
        timeout = "200">
    </cfexecute>
    

    <cfif structKeyExists(theData.Params[1][1], '_HabitsSurveysComplete') AND theData.Params[1][1]['_HabitsSurveysComplete'] EQ 'Y'>

        <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
            arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
            variable="myResult2"
            timeout = "200">
        </cfexecute>

    </cfif>  
</cfif>

<cfif local.updateList NEQ "Y">
    <cfset updateField = structNew()>
    <cfset updateField['_HWCTFeedbackSurveysComplete3']=local.newList>
<cfelse>
    <cfset updateField = structNew()>
    <cfset updateField['_HWCTFeedbackSurveysComplete3']="Y">

    <!-- 9781 [Core 18-Week Teleclass [Jul2018 Fwd] -->
    <cfif listFindNoCase(memberTags,9781) and listFindNoCase(memberTags,9531) AND listFindNoCase(memberTags,9553) >
        <cfset local.hasInviteToMod3 = true>
    <cfelse>
        <cfset local.hasInviteToMod3 = false>
    </cfif>

    <!-- IF 9781 is in place [Core 18-Week Teleclass [Jul2018 Fwd] � generic statement Ray will use to make a query BEFORE applying any of the following program specific tags]
        THEN 9557 can be applied [Core Jul2018 Mod 1 Lesson Surveys Complete] -->
    <cfif local.hasInviteToMod3>
        <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#memberID#">
        <cfset myArray[4]="(int)9557">

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
    

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
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
    arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
    variable="result"
    timeout = "200">
</cfexecute>

<cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#" />

<p>
    Thank you! Please check the Completed Surveys page (under the Feedback Surveys menu at your CustomerHub home) within 10-15 minutes to verify that the survey has been saved and uploaded to your file. If not, please contact your Coach Concierge for assistance.
</p>
<p >   
    <FONT COLOR="##ff0000"> IMPORTANT: If you are going to complete another survey for a different lesson, DO NOT click the back button. Please exit this survey and click the survey link again to start a new survey. If you do not follow these instructions, you will override your survey entry and it will not be recorded.</font>
</p>


</cfoutput>