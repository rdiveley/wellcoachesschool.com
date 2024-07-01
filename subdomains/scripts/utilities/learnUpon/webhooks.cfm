<cfscript>
    local.datasource= 'wellcoachesschool';
    local.insert = FALSE;

    _payload = "{}";  
    if (structKeyExists(URL,"payload")) {  
        // Get payload from GET Request
        _payload = URL.payload;
    } else if (structKeyExists(FORM,"payload")) {
        // Get payload from POST Request
        _payload = FORM.payload;
    } else {
        // Get payload from the Body of the Request
        _payload = getHttpRequestData().content;
    }

    if(isJSON(_payload)){
    // now turn our payload into a structure 
        local.requestpayload = deserializeJSON(_payload);  
        local.insert = TRUE;
    }else{
        local.requestpayload = {}; 
    }

</cfscript>

<!---
<cfset local.requestpayload.user.email = 'rdiveley@gmail.com' />
<cfset local.requestpayload.courseName = 'Core Coach Training: Module 2' />
<cfset local.requestpayload.percentage = '98' />
<cfset local.requestpayload.header.webhookId = '6498208' />
<cfparam name="local.requestpayload.header.webhookType" default="exam_completion" />
<cfset local.requestpayload.examName = 'a. Organize Your Mind Assessment' />
<cfset local.requestpayload.passPercentage = '80' />
<cfset local.requestpayload.courseid = '416952' />
<cfset local.requestpayload.attemptstaken = '1' />
<cfset local.requestpayload.status = 'pass' />
<cfset local.requestpayload.header.lastAttemptAt = '2023' />

<cfparam name="local.requestpayload.user.email" default="" />
<cfparam name="local.requestpayload.courseName" default="" />
<cfparam name="local.requestpayload.percentage" default="" />
<cfparam name="local.requestpayload.header.webhookId" default="" />
<cfparam name="local.requestpayload.header.webhookType" default="" />
<cfparam name="local.requestpayload.examName" default="" />
<cfparam name="local.requestpayload.passPercentage" default="" />
<cfparam name="local.requestpayload.courseid" default=""/>
<cfparam name="local.requestpayload.attemptstaken" default="" />
<cfparam name="local.requestpayload.status" default="" />
<cfparam name="local.requestpayload.header.lastAttemptAt" default="" />
<cfif local.insert 
    AND findNoCase('exam_completion', local.requestpayload.header.webhookType) 
    AND findNoCase('Module 1', local.requestpayload.courseName)>
--->
<cfif local.insert 
    AND findNoCase('exam_completion', local.requestpayload.header.webhookType) 
    AND findNoCase('Module 1', local.requestpayload.courseName)>
    <cftry>
        <cfquery name="local.insertLU" datasource="#local.datasource#">
            insert into [wellcoachesSchool].[dbo].[learnuponwebhook]
            (   emailaddress
                ,coursename
                ,courseId
                ,exampercentage
                ,webhookid
                ,webhooktype
                ,examName
                ,passPercentage
                ,attemptsTaken
                ,examstatus
                ,lastAttemptAt
            )
            values
            (
                <cfqueryparam value="#local.requestpayload.user.email#" cfsqltype="cf_sql_varchar">
                ,<cfqueryparam value="#local.requestpayload.courseName#" cfsqltype="cf_sql_varchar">
                ,<cfqueryparam value="#local.requestpayload.courseId#" cfsqltype="cf_sql_integer">
                ,<cfqueryparam value="#local.requestpayload.percentage#" cfsqltype="cf_sql_integer">
                ,<cfqueryparam value="#local.requestpayload.header.webhookId#" cfsqltype="cf_sql_integer">
                ,<cfqueryparam value="#local.requestpayload.header.webHookType#" cfsqltype="cf_sql_varchar">
                ,<cfqueryparam value="#local.requestpayload.examName#" cfsqltype="cf_sql_varchar">
                ,<cfqueryparam value="#local.requestpayload.passPercentage#" cfsqltype="cf_sql_integer">
                ,<cfqueryparam value="#local.requestpayload.attemptsTaken#" cfsqltype="cf_sql_integer">
                ,<cfqueryparam value="#local.requestpayload.status#" cfsqltype="cf_sql_varchar">
                ,<cfqueryparam value="#local.requestpayload.header.lastAttemptAt#" cfsqltype="CF_SQL_TIMESTAMP">
            )
        </cfquery>

        <cfquery name="local.get_ModOneKADataCount" datasource="#local.datasource#">
            SELECT  COUNT(distinct examName) as countRecord
                    ,CAST(AVG(exampercentage) as decimal(10,2)) as average
            FROM learnuponwebhook lwh
            where examName like 'Lesson Knowledge Assessment%'
            AND lastAttemptAt = (SELECT MAX(lastAttemptAt) from learnuponwebhook where examName = lwh.examName AND emailaddress = lwh.emailaddress )    
            AND emailaddress = <cfqueryparam value="#local.requestpayload.user.email#" cfsqltype="cf_sql_varchar">
            GROUP BY emailaddress
        </cfquery> 

        <cfcatch type="any">
            <cfmail to="rdiveley@wellcoaches.com" subject="LearnUpon webhooks" from="wellcoaches@wellcoaches.com" type="html">
                        <table>
                            <tr>
                                <td><cfdump var="#cfcatch#" format="html"></td>
                            </tr>
                            
                            <tr>
                                <td><cfdump var="#url#" format="html"></td>
                            </tr>
                        </table>
                    </cfmail>   
        </cfcatch>
    </cftry>

    <cfif local.get_ModOneKADataCount.countRecord GTE 4>
        
        <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">

        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='#local.requestpayload.user.email#'>
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

        <cfset memberID = theData['params'][1][1]['Id'] />

        <!--- start updating LU --->
        <cfset updateField['_Mod1KAData']= int(local.get_ModOneKADataCount.average) />
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#memberID#'>
        <cfset myArray[4]=updateField>

        <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

        <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
            arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
            variable="result"
            timeout = "200">
        </cfexecute>
    </cfif>
</cfif> 