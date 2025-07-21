    <cfquery name="local.get_HabitKAScore" datasource="wellcoachesschool">
            SELECT  exampercentage
            FROM learnuponwebhook lwh
            where emailaddress = <cfqueryparam value="sample.student@wellcoaches.com" cfsqltype="cf_sql_varchar">
            and courseId = <cfqueryparam value="4447857" cfsqltype="cf_sql_integer">
           
        </cfquery> 

        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">

        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='sample.student@wellcoaches.com'>
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
        <cfset updateField['_HabitsKAData']= int(96) />
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
    <cfinclude  template="habitsSurvey.cfm">
     <cfinclude  template="habitsSurveyAll.cfm">
 