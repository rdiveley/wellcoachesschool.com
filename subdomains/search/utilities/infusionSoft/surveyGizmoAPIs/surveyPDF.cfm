<cfparam name="form.surveyTitle" default="0" />
<cfparam name="form.id" default="0" />
<cfoutput>
<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#UrlDecode(Decrypt(url.surveyTitle,'pdf'))#/surveyresponse/#URLDecode(Decrypt(url.id,'pdf'))#">

 <cfhttp url="#sGurl#" result="myResult" method="get">
	<cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
 </cfhttp>

  <cfset jsonData = deserializeJSON(myResult.fileContent) />


   <cfsavecontent variable="PDFhtml">
  	<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">

        	<tr>
            	<td>1. What is the name you would like on your Completion Certificate: First Name? </td>
            </tr>
            <tr><td>#jsonData.data['[question(22)]']#</td></tr>
        	<tr><td>&nbsp;</td></tr>
            <tr>
            	<td>2. What is the name you would like on your Completion Certificate: Last Name?</td>
           </tr>
           <tr>
                <td>#jsonData.data['[question(23)]']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3. What email address would you like the confirmation of this survey to be sent to?</td>
            </tr>
           <tr>
                <td>#jsonData.data['[question(26)]']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>4. I am providing feedback about Lesson:</td>
            </tr>
           <tr>
                <td>#jsonData.data['[question(8)]']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>5. The Faculty Member for this Lesson was:</td>
            </tr>
           <tr>
                <td>
                	#jsonData.data['[question(12)]']#
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6. I learned new coaching skills by participating in this Lesson:</td>
            </tr>
                <td>
                	<cfif jsonData.data['[question(2)]'] EQ 1>Strongly Disagree</cfif>
                    <cfif jsonData.data['[question(2)]'] EQ 2>Disagree</cfif>
                    <cfif jsonData.data['[question(2)]'] EQ 3>Neutral</cfif>
                    <cfif jsonData.data['[question(2)]'] EQ 4>Agree</cfif>
                    <cfif jsonData.data['[question(2)]'] EQ 5>Strongly Agree</cfif>
                    <cfif jsonData.data['[question(2)]'] CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>7. The faculty member demonstrated expertise regarding the content.</td>
            </tr>
                <td>
                	<cfif jsonData.data['[question(3)]'] EQ 1>Strongly Disagree</cfif>
                    <cfif jsonData.data['[question(3)]'] EQ 2>Disagree</cfif>
                    <cfif jsonData.data['[question(3)]'] EQ 3>Neutral</cfif>
                    <cfif jsonData.data['[question(3)]'] EQ 4>Agree</cfif>
                    <cfif jsonData.data['[question(3)]'] EQ 5>Strongly Agree</cfif>
                    <cfif jsonData.data['[question(3)]'] CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr>
            <tr><td>&nbsp;</td></tr>
                <td>8. What are the most valuable skills and behaviors demonstrated by the faculty member? </td>
            </tr>
                <td>#Replace(jsonData.data['[question(5)]'],'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>9. Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr>
            <tr>
                <td>#Replace(jsonData.data['[question(6)]'],'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>10. What else would you like for us to be aware of? </td>
            </tr>
            <tr>
                <td>#Replace(jsonData.data['[question(7)]'],'#chr(10)#','<br/>','all')#</td>
            </tr>
        </table>
    </cfsavecontent>
  <cfheader name="Content-Disposition" value="inline; filename=Test.pdf">
    <cfdocument format="pdf">
     	#PDFhtml#
    </cfdocument>
</cfoutput>