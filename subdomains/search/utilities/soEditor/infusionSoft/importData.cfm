    <cfspreadsheet 
        action = "read" 
        src = "C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\feedbackSurvey.xlsx" 
  		headerrow=1
        query="excelquery" 
        sheet="1" 
        columns="1,2,3,4,5,6,7,8,9,10,11"> 

<cfset DSN = "wellcoachesSchool">
<cfoutput query="excelquery" startrow="20">

    <cfset key = "74e097c5980ebb52ebfae71b0e575154">
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='#excelquery.email#'>
    <cfset myArray[4]=selectedFieldsArray>
    
    
    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">
  
      <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>
    
    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult.Filecontent#"
        returnvariable="theData">
 
 
 <cfquery name="insertResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        INSERT INTO coachInPracticeFeedback
        (lesson,lessonYear,email,classTitle,coachingSkills,businessDev,faculty,valuableSkills,summarize,awareOf,dateSubmitted,infusionSoftID)
        VALUES
        (
             <cfqueryparam value="#lesson#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#year#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#email#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#classTitle#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#coachingSkills#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#businessDev#" cfsqltype="cf_sql_varchar"/> 
            ,<cfqueryparam value="#faculty#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#valuableSkills#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#summary#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#awareOF#" cfsqltype="cf_sql_varchar"/>
            ,<cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_date"/>
            ,<cfqueryparam value="#theData.Params[1][1]['id']#" cfsqltype="cf_sql_varchar"/>
        )
      </cfquery>
</cfoutput>
<!--- use a simple database query to check the results of the import - dumping query to screen --->
<cfquery name="rscsvdemo"  datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
         SELECT * FROM surveyResults
</cfquery>
<!---<cfdump var="#rscsvdemo#">


 
<cfdump var="#myExcelData#">
--->