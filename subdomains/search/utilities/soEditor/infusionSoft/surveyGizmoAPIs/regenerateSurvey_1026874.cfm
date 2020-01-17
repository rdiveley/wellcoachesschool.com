<cfparam name="form.surveyTitle" default="0" />
<cfparam name="form.id" default="0" />
<cfoutput>

<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#url.surveyTitle#/surveyresponse/#url.id#">

<cfhttp url="#sGurl#" result="myResult" method="get">
	<cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
 </cfhttp>
      
  <cfset jsonData = deserializeJSON(myResult.fileContent) />
 
	<cfset q1 = jsonData.data['[question(33)]'] />
    <cfset q2 = jsonData.data['[question(34)]'] />
    <cfset q3 = jsonData.data['[question(35)]'] />
    <cfset q4 = jsonData.data['[question(29)]'] />
    <cfset q5 = jsonData.data['[question(30)]'] />
    <cfset q6 = jsonData.data['[question(8)]'] />
    <cfset q7 = jsonData.data['[question(31)]'] />
    <cfset q8 = jsonData.data['[question(28)]'] />
    <cfset q9 = jsonData.data['[question(2)]'] />
	<cfset url.email = jsonData.data['[question(9), option(0)]']/>    

    <cfset q10 = jsonData.data['[question(25)]'] />
    <cfset q11= jsonData.data['[question(3)]'] />
    <cfset q12= jsonData.data['[question(5)]'] />
    <cfset q13= jsonData.data['[question(6)]'] />
    <cfset q14= jsonData.data['[question(7)]'] />

  
  
    <cfdocument format="pdf" name="pdfGenerate">
  	<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
        	
        	<tr>
            	<td>1. What is the name you would like on your Completion Certificate: First Name? </td>
            </tr>
            <tr><td>#q1#</td></tr> 
        	<tr><td>&nbsp;</td></tr>
            <tr>
            	<td>2. What is the name you would like on your Completion Certificate: Last Name?</td>
           </tr>
           <tr>      
                <td>#q2#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3. What email address would you like the confirmation of this survey to be sent to?</td>
            </tr> 
           <tr>     
                <td>#q3#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>4. I am providing feedback about Lesson:</td>
            </tr> 
           <tr>     
                <td>#q4#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
             <tr>
                <td>5. If you selected "Other", what is the name of the class that you attended? :</td>
            </tr> 
           <tr>     
                <td>#q5#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6. I attended or listened to this class in:</td>
            </tr> 
           <tr>     
                <td>
                	#q6#
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>7. How many hours was this class?</td>
            </tr> 
           <tr>     
                <td>
                	#q7#
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>8.In which year did you attend, or listen to, this class? </td>
            </tr> 
           <tr>     
                <td>
                	#q8#
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>9. I learned new coaching skills by participating in this Lesson:</td>
            </tr> 
                <td>
                	<cfif q9 EQ 1>Strongly Disagree</cfif>
                    <cfif q9 EQ 2>Disagree</cfif>
                    <cfif q9 EQ 3>Neutral</cfif>
                    <cfif q9 EQ 4>Agree</cfif>
                    <cfif q9 EQ 5>Strongly Agree</cfif>
                    <cfif q9 CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>10. I learned new business development skills by participating in this Class:</td>
            </tr> 
                <td>
                	<cfif q10 EQ 1>Strongly Disagree</cfif>
                    <cfif q10 EQ 2>Disagree</cfif>
                    <cfif q10 EQ 3>Neutral</cfif>
                    <cfif q10 EQ 4>Agree</cfif>
                    <cfif q10 EQ 5>Strongly Agree</cfif>
                    <cfif q10 CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>11. The faculty member demonstrated expertise regarding the content.</td>
            </tr> 
                <td>
                	<cfif q11 EQ 1>Strongly Disagree</cfif>
                    <cfif q11 EQ 2>Disagree</cfif>
                    <cfif q11 EQ 3>Neutral</cfif>
                    <cfif q11 EQ 4>Agree</cfif>
                    <cfif q11 EQ 5>Strongly Agree</cfif>
                    <cfif q11 CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>    
            <tr> 
            <tr><td>&nbsp;</td></tr>
                <td>12. What are the most valuable skills and behaviors demonstrated by the faculty member? </td>
            </tr> 
                <td>#Replace(q12,'#chr(10)#','<br/>','all')#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>  
                <td>13. Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr> 
            <tr> 
                <td>#Replace(q13,'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>14. What else would you like for us to be aware of? </td>
            </tr>
            <tr>    
                <td>#Replace(q14,'#chr(10)#','<br/>','all')#</td>
            </tr>  
        </table>
     </cfdocument> 
    
     
     
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
    </cfoutput>
    
	<cfset key = "74e097c5980ebb52ebfae71b0e575154">
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="FileService.uploadFile"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#theData.Params[1][1]['id']#">
        <cfset myArray[4]="#URLDecode(url.lesson)#.pdf">
        <cfset myArray[5]=ToBase64(pdfGenerate)>
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
   
   	    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>