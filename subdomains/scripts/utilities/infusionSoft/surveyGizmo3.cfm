<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>

<cfparam name="FORM.fileName" default="">
<cfparam name="URL.lesson" default="">
<cfparam name="URL.email" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.facultyExpertise" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">
<cfparam name="URL.faculty" default="">
<cfset DSN = "wellcoachesSchool">

<!---<cfset lesson = URLEncodedFormat(URL.lesson)>--->
<cfset uniqueFileName = "#URL.email#_#URLEncodedFormat(URL.lesson)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
<cfset copyFaculty = "#URL.faculty#_#URLEncodedFormat(URL.lesson)#_#URL.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf"> 
 
   

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
  
  <cfif arrayisEmpty(theData.Params)>
  	Your email address was not found in our system.  Please contact your concierge to ensure we have the correct
    email address in our records.
   	<br /><br/>
    Thank you,<br/>
    Wellcoaches
  	<cfabort>
  </cfif>
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
                <td>2.  The Faculty Member for this Lesson was:</td>
            </tr> 
           <tr>     
                <td>#URL.faculty#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>3.  I learned new coaching skills by participating in this Lesson</td>
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
                <td>4.  The faculty member demonstrated expertise regarding the content</td>
            </tr> 
                <td>
                	<cfif #URL.facultyExpertise# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.facultyExpertise# EQ 2>Disagree</cfif>
                    <cfif #URL.facultyExpertise# EQ 3>Neutral</cfif>
                    <cfif #URL.facultyExpertise# EQ 4>Agree</cfif>
                    <cfif #URL.facultyExpertise# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.facultyExpertise# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>5.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
            </tr> 
                <td>
                	#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#
                </td>
            </tr>    
            <tr> 
           
            <tr><td>&nbsp;</td></tr> 
            <tr>  
                <td>6.  Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr> 
            <tr> 
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>7.  What else would you like for us to be aware of?</td>
            </tr>
            <tr>    
                <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
        </table>
  
  </cfdocument> 
  
  <cfset valuableSkills = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
  <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
  <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
 
  <cffile action="write"
  	file="#GetTempDirectory()#/#uniqueFileName#"
    output="#pdfGenerate#" >
    
   <cffile action="readbinary" file="#GetTempDirectory()#/#uniqueFileName#" variable="readFile">
   
   <cfif URL.email Contains "_">
   		<cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
    	<cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
    	<cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
   </cfif>    
   
  
   
   
   		<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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
        
		 <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif> 
         <cfabort>


</cfoutput>

