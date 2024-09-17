<cfoutput>

<cfparam name="FORM.fileName" default="">
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




<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
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
            	<td width="500px">1.  I am providing feedback about Lesson</td>
           </tr>
           <tr>      
                <td>#URL.lesson#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>  
            <tr>
                <td>2.  I am participating in the following class cohort:</td>
            </tr> 
           <tr>     
                <td>#URL.cohort# </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3.  The Faculty Member for this Lesson was:</td>
            </tr> 
           <tr>     
                <td>#URL.faculty_member#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>4.  I learned new coaching skills by participating in this Lesson</td>
            </tr> 
           <tr>     
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
                <td>5.  The faculty member demonstrated expertise regarding the content</td>
            </tr> 
                <td>
                	<cfif #URL.faculty# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.faculty# EQ 2>Disagree</cfif>
                    <cfif #URL.faculty# EQ 3>Neutral</cfif>
                    <cfif #URL.faculty# EQ 4>Agree</cfif>
                    <cfif #URL.faculty# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.faculty# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>6.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
            </tr> 
                <td>
                	#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#
                </td>
            </tr>    
            <tr> 
            <tr><td>&nbsp;</td></tr>
                <td>7.  This Lesson was relevant to the objective of the course: To mobilize the best coaches to help people make lasting improvements to their health and well-being. </td>
            </tr> 
                <td>
                	
                    <cfif #URL.lessonObj# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.lessonObj# EQ 2>Disagree</cfif>
                    <cfif #URL.lessonObj# EQ 3>Neutral</cfif>
                    <cfif #URL.lessonObj# EQ 4>Agree</cfif>
                    <cfif #URL.lessonObj# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.lessonObj# CONTAINS 'NA'>Not Applicable</cfif>
                    
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>  
                <td>8.  Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr> 
            <tr> 
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>9.  What else would you like for us to be aware of?</td>
            </tr>
            <tr>    
                <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>10.  I attended this class live</td>
            </tr>
            <tr>    
                <td>#URL.live#</td>
            </tr>    
            
        </table>
  
  </cfdocument> 
  <cfset valuableLesson = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
  <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
  <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
<!---
<cfmail 
    from = "survey_gizmo@wellcoaches.net" 
    to = "v.kukarin@websitemovers.com"
    subject = "survey_gizmo">
#URL.lesson#  #awareOF# Referer: #cgi.http_rerferrer#
</cfmail>
--->     
 
  <cffile action="write"
  		file="#GetTempDirectory()#/#uniqueFileName#"
    	output="#pdfGenerate#" >
    
     
   <cffile action="readbinary" file="#GetTempDirectory()#/#uniqueFileName#" variable="readFile">
   
   
   
   
   <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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
   

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
		<cfset lessonNumber = ListFirst(URL.lesson,':')>
        <cfset lessonNumber = ListLast(lessonNumber,' ')>
        <cflocation url="completedHours.cfm?email=#URL.email#&lesson=#lessonNumber#"   >     
         
        <cfabort>


</cfoutput>

