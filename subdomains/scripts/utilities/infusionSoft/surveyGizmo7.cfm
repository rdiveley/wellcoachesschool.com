<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>
<cfparam name="URL.email" default="">
<cfparam name="URL.classTitle" default="">
<cfparam name="URL.lesson" default="">
<cfparam name="URL.hours" default="">
<cfparam name="URL.lessonYear" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.summarize" default="">

<cfset DSN = "wellcoachesSchool">

<cfset uniqueFileName = "#URL.email#_#URLEncodedFormat(url.classTitle)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">

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
            	<td width="500px">1. What is your email address? (You must use the email address that this survey was sent to. If you do not, this survey will not be tracked and will not add to your continuing education hours)?</td>
           </tr>
           <tr>      
                <td>#URL.email#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>  
            
            <tr>
                <td>2. What is the name of the class that was attended?</td>
            </tr> 
           <tr>     
                <td>#URL.classTitle#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>3. I attended this class in: </td>
            </tr> 
           <tr>     
                <td>#URL.lesson#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>4. How many continuing education hours was this course?</td>
            </tr> 
                <td>#URL.hours# </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>5. I attended this class in: </td>
            </tr> 
                <td>
                	#URL.lessonYear#
                </td>
            </tr>    
            <tr> 
            <tr><td>&nbsp;</td></tr>
                <td>6. I learned new coaching skills by participating in this Class:</td>
            </tr> 
                <td>
                	<cfif #URL.coachingSkills# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.coachingSkills# EQ 2>Disagree</cfif>
                    <cfif #URL.coachingSkills# EQ 3>Neutral</cfif>
                    <cfif #URL.coachingSkills# EQ 4>Agree</cfif>
                    <cfif #URL.coachingSkills# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.coachingSkills# CONTAINS 'NA'>Not Applicable</cfif>
                
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>7. Please summarize the two most valuable elements learned from this class and how you will apply them to your coaching practice or other coaching activities.</td>
            </tr>
            <tr>    
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>  
        </table>
  
  </cfdocument> 
 
  <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
 
  <cftry>
  <cfquery name="insertResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
  	INSERT INTO coachInPracticeFeedback
    (email,classTitle,lesson,hours,lessonYear,coachingSkills,summarize,dateSubmitted,infusionSoftID)
    VALUES
    (
    	 <cfqueryparam value="#URL.email#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.classTitle#" cfsqltype="cf_sql_varchar"/> 
        ,<cfqueryparam value="#URL.lesson#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.hours#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#URL.lessonYear#" cfsqltype="cf_sql_varchar"/>
    	,<cfqueryparam value="#URL.coachingSkills#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#summary#" cfsqltype="cf_sql_varchar"/>
        ,<cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp"/>
        ,<cfqueryparam value="#theData.Params[1][1]['id']#" cfsqltype="cf_sql_varchar"/>
    )
  </cfquery>
  <cfcatch type="any">
  <cfmail to="rdiveley@wellcoaches.com" subject="Survey Gizmo 7 Error" from="wellcoaches@wellcoaches.com">
  	#cfcatch.detail#<br />
    <cfdump var="#URL#">
  </cfmail>
  </cfcatch>
  </cftry>
   
        
		 <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif> 
         <cfabort>


</cfoutput>

