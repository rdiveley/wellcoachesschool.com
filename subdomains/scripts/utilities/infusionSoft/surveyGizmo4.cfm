<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>

<cfparam name="URL.lesson" default="">
<cfparam name="URL.faculty_member" default="">
<cfparam name="URL.facultyExpertise" default="">
<cfparam name="URL.bestPart" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">
<cfset DSN = "wellcoachesSchool">

<!---<cfset lesson = URLEncodedFormat(URL.lesson)>--->
<cfset uniqueFileName = "#URL.email#_#URLEncodedFormat(lesson)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
<cfset copyFaculty = "#URL.faculty_member#_#URLEncodedFormat(lesson)#_#URL.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf"> 
 

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.email>
<cfset myArray[4]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">



<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>
<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">
        
  
  <cfdocument format="pdf" name="pdfGenerate">
  		<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
        	
        	<tr>
            	<td>Name: #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#</td>
            </tr>
             <tr><td>&nbsp;</td></tr> 
        	<tr>
            	<td width="500px">1. About which class are you providing feedback?</td>
           </tr>
           <tr>      
                <td>#URL.lesson#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>  
            
            <tr>
                <td>2. Who was the facilitator for this class? </td>
            </tr> 
           <tr>     
                <td>#URL.faculty_member#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>3. How would you rate the facilitator's presentation of the materials? (on a scale of 1-5, 5 being the highest): </td>
            </tr> 
           <tr>     
                <td>#URL.facultyExpertise#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>4. What were the best parts of this class? </td>
            </tr> 
                <td>#URL.bestPart# </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>5. What are the opportunities to make this class more valuable? </td>
            </tr> 
                <td>
                	#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#
                </td>
            </tr>    
            <tr> 
            <tr><td>&nbsp;</td></tr>
                <td>6. Please summarize the two most valuable elements gained from this class and how you will apply them to your life. </td>
            </tr> 
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>7. Please provide other feedback and suggestions. We want to hear from you! </td>
            </tr>
            <tr>    
                <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
            </tr>  
        </table>
  
  </cfdocument> 
  <cfset valuableLesson = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
  <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
  <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
 
  <cftry>
  <cfquery name="insertResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
  	INSERT INTO coachInPracticeFeedback
    (hours,lesson,email,faculty,coachingSkills,valuableSkills,summarize,awareOf,bestPart,dateSubmitted,infusionSoftID)
    VALUES
    (
    	1.5
        ,<cfqueryparam value="#URL.lesson#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.email#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.faculty_member#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.facultyExpertise#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#valuableLesson#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#summary#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#awareOF#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.bestPart#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp"/>
        ,<cfqueryparam value="#theData.Params[1][1]['id']#" cfsqltype="cf_sql_varchar"/>
    )
  </cfquery>
  <cfcatch type="any">
  <cfmail to="techsupport@wellcoaches.com" subject="Survey Gizmo 4 Error" from="#URL.email#">
  	#cfcatch.detail#<br />
    <cfdump var="#URL#">
  </cfmail>
  </cfcatch>
  </cftry>
  <cffile action="write"
  	file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#uniqueFileName#"
    output="#pdfGenerate#" >
    
     <cffile action="write"
        file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#RereplaceNocase(copyFaculty," ","_","ALL")#"
        output="#pdfGenerate#" >
        
        
   <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
   <cffile action="readbinary" file="#expandPath('./temp/#uniqueFileName#')#" variable="readFile">
   
    <cfif URL.email Contains "_">
   		<cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
    	<cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
    	<cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
   	</cfif> 
   
   
   		
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="FileService.uploadFile"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#theData.Params[1][1]['id']#">
        <cfset myArray[4]="#URLDecode(ListGetAt(uniqueFileName,'2','_'))#.pdf">
        <cfset myArray[5]=ToBase64(readFile)>
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
		 <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif> 
         <cfabort>


</cfoutput>

