<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>

<cfparam name="URL.location" default="">
<cfparam name="URL.faculty_member" default="">
<cfparam name="URL.reason" default="">
<cfparam name="URL.valuableSkills" default="">
<cfparam name="URL.expectations" default="">
<cfparam name="URL.whatways" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.quality" default="">
<cfparam name="URL.aware" default="">
<cfparam name="URL.email" default="">

<cfset DSN = "wellcoachesSchool">

<!---<cfset lesson = URLEncodedFormat(URL.lesson)>--->
<cfset uniqueFileName = "#URL.email#_#URLEncodedFormat(URL.location)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
<cfset copyFaculty = "#URL.faculty_member#_#URLEncodedFormat(URL.location)#_#URL.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf"> 
 
   
<cfset key = "74e097c5980ebb52ebfae71b0e575154">
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


<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
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
            	<td width="500px">1. What is the location of the workshop you attended?</td>
           </tr>
           <tr>      
                <td>#URL.location#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>2. Who was the facilitator?</td>
            </tr> 
           <tr>     
                <td>#URL.faculty_member#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>3. What is the reason you chose to attend this workshop? </td>
            </tr> 
           <tr>     
                <td>#Replace(URL.reason,"#chr(10)#","<br>","all")#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>4. What did you learn or find most helpful? </td>
            </tr> 
                <td>#Replace(URL.valuableSkills,"#chr(10)#","<br>","all")#
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>5. Did the workshop content meet your expectations? </td>
            </tr> 
                <td>#URL.expectations#</td>
            </tr>    
            <tr> 
           
            <tr><td>&nbsp;</td></tr> 
            <tr>  
                <td>6. In what ways did the content meet, or not meet, your expectations? </td>
            </tr> 
            <tr> 
                <td>#Replace(URL.whatways,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>7. How would you rate the skills of the facilitator? </td>
            </tr>
            <tr>    
                <td> #URL.coachingSkills# </td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>8. How would you rate the quality of the workshop facility?</td>
            </tr>
            <tr>    
                <td>#URL.quality# </td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td> 9. What additional comments do you have regarding the workshop that would be helpful to Wellcoaches in its effort to improve quality?</td>
            </tr>
            <tr>    
                <td>#URL.aware# </td>
            </tr>  
            
        </table>
  
  </cfdocument> 
  
  <cfset valuableSkills = Replace(URL.valuableSkills,"#chr(10)#","<br>","all")>
  <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
  
 
  <cftry>
  <cfquery name="insertResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
  	INSERT INTO coachInPracticeFeedback
    (hours,location,faculty,email,reason,valuableSkills,expectations,whatways,coachingSkills,quality,awareOf,dateSubmitted,infusionSoftID)
    VALUES
    (
         <cfqueryparam value="7.5" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.location#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.faculty_member#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.email#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.reason#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.valuableSkills#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.expectations#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.whatways#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.coachingSkills#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.quality#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#awareOF#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp"/>
        ,<cfqueryparam value="#theData.Params[1][1]['id']#" cfsqltype="cf_sql_varchar"/>
    )
  </cfquery>
  <cfcatch type="any">
  <cfmail to="techsupport@wellcoaches.com" subject="Survey Gizmo 5 Error" from="#URL.email#">
  	#cfcatch.detail#<br />
    <cfdump var="#URL#">
  </cfmail>
  </cfcatch>
  </cftry>
  <cfset folderName = left(uniqueFileName,1) />
  <cfset newfolder = 'C:/websites/wellcoachesschool/utilities/infusionsoft/temp/#folderName#' />
  <cfif not directoryExists(newfolder)>
    	<cfdirectory action="create" directory="#newfolder#">
  </cfif>
  <cffile action="write"
  	file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#folderName#\#uniqueFileName#"
    output="#pdfGenerate#" >
    
     <cffile action="write"
        file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#folderName#\#RereplaceNocase(copyFaculty," ","_","ALL")#"
        output="#pdfGenerate#" >
        
    
   <cffile action="readbinary" file="#expandPath('./temp/#folderName#/#uniqueFileName#')#" variable="readFile">
   
    <cfif URL.email Contains "_">
   		<cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
    	<cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
    	<cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
   </cfif>    
   
  
   
   
   		<cfset key = "74e097c5980ebb52ebfae71b0e575154">
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
   
   		<!---<cfx_http5 url="https://my982.infusionsoft.com/api/xmlrpc" method="POST" body=#myPackage.Trim()# out="myResult"  >--->
        
        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
        <cfif URL.location contains '2013'>
        	<cfset IStag = 2889 />
        <cfelseif URL.location contains '2014'>
         	<cfset IStag = 2891 /> 
        <cfelseif URL.location contains '2015'>
         	<cfset IStag = 2893 />
        <cfelseif URL.location contains '2016'>
         	<cfset IStag = 2895 />
        <cfelseif URL.location contains '2017'>
         	<cfset IStag = 2897 />
        <cfelseif URL.location contains '2018'>
         	<cfset IStag = 2899 />
        <cfelse>
        	<cfset IStag = 2889 />     
        </cfif>
        
        
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#theData.Params[1][1]['Id']#">
        <cfset myArray[4]="(int)#IStag#">


<cfinvoke component="utilities/XML-RPC"
	method="CFML2XMLRPC"
	data="#myArray#"
	returnvariable="myPackage">
<cfdump var="#myPackage#">



<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>
        
        
		 <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif> 
         <cfabort>


</cfoutput>

