<cfparam name="form.surveyTitle" default="0" />
<cfparam name="form.id" default="0" />
<cfoutput>

<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#url.surveyTitle#/surveyresponse/#url.id#">

<cfhttp url="#sGurl#" result="myResult" method="get">
	<cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
 </cfhttp>
      
  <cfset jsonData = deserializeJSON(myResult.fileContent) />
 
  	<cfset q1 = jsonData.data['[question(22)]'] />
    <cfset q2 = jsonData.data['[question(25)]'] />
    <cfset q3 = jsonData.data['[question(8)]'] />
    <cfset q4 = jsonData.data['[question(12)]'] />
    <cfset q5 = jsonData.data['[question(25)]'] />
    <cfset q6 = jsonData.data['[question(2)]'] />
    <cfset q7 = jsonData.data['[question(3)]'] />
    <cfset q8 = jsonData.data['[question(5)]'] />
    <cfset q9 = jsonData.data['[question(4)]'] />
	<cfset url.email = jsonData.data['[question(9), option(0)]']/>    

    <cfset q10 = jsonData.data['[question(6)]'] />
    <cfset q11= jsonData.data['[question(7)]'] />
   
 <cfdocument format="pdf" name="pdfGenerate">
  	<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
        	
        	<tr>
            	<td>1. What is your First Name? </td>
            </tr>
            <tr><td>#q1#</td></tr> 
        	<tr><td>&nbsp;</td></tr>
            <tr>
            	<td>2. What is your Last Name?</td>
           </tr>
           <tr>      
                <td>#q2#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3. I am providing feedback about Lesson: </td>
            </tr> 
           <tr>     
                <td>#q3#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
            <tr>
                <td>4. The Faculty Member for this Lesson was: </td>
            </tr> 
           <tr>     
                <td>#q4#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr>
             <tr>
                <td>5. I am participating in the Cohort that began:</td>
            </tr> 
           <tr>     
                <td>#q5#</td>
            </tr>  
         
            <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>6. I learned new coaching skills by participating in this Lesson:</td>
            </tr> 
            <tr>
                <td>
                	<cfif q6 EQ 1>Strongly Disagree</cfif>
                    <cfif q6 EQ 2>Disagree</cfif>
                    <cfif q6 EQ 3>Neutral</cfif>
                    <cfif q6 EQ 4>Agree</cfif>
                    <cfif q6 EQ 5>Strongly Agree</cfif>
                    <cfif q6 CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
             <tr><td>&nbsp;</td></tr>
            <tr>   
                <td>7. The faculty member demonstrated expertise regarding the content.</td>
            </tr> 
            <tr>
                <td>
                	<cfif q7 EQ 1>Strongly Disagree</cfif>
                    <cfif q7 EQ 2>Disagree</cfif>
                    <cfif q7 EQ 3>Neutral</cfif>
                    <cfif q7 EQ 4>Agree</cfif>
                    <cfif q7 EQ 5>Strongly Agree</cfif>
                    <cfif q7 CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>  
           
            <tr><td>&nbsp;</td></tr>
                <td>8. What are the most valuable skills and behaviors demonstrated by the faculty member? </td>
            </tr> 
                <td>#Replace(q8,'#chr(10)#','<br/>','all')#</td>
            </tr>  
            <tr><td>&nbsp;</td></tr> 
             <tr>   
                <td>9. This Lesson was relevant to the objective of the course: To mobilize the best coaches to help people make lasting improvements to their health and well-being.</td>
            </tr> 
            <tr>
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
                <td>10. Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr> 
            <tr> 
                <td>#Replace(q10,'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr> 
            <tr>    
                <td>11. What else would you like for us to be aware of? </td>
            </tr>
            <tr>    
                <td>#Replace(q11,'#chr(10)#','<br/>','all')#</td>
            </tr>   
        </table>
     </cfdocument> 
    
    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
    
	<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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
 	