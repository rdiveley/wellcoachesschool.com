<cfparam name="form.surveyTitle" default="0" />
<cfparam name="form.id" default="0" />
<cfoutput>


<cfset SGurl = "https://api.alchemer.com/v5/survey/#url.surveyTitle#/surveyresponse/#url.id#?">

 <cfhttp url="#sGurl#" result="myResult" method="get">
	<cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
 </cfhttp>

<cfset jsonData = deserializeJSON(myResult.fileContent) />

<cfset SGurl="text" />
   <cfsavecontent variable="PDFhtml">
  	<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">

        	<tr>
            	<td>1. What is the name you would like on your Completion Certificate: First Name? </td>
            </tr>

            <tr><td>#jsonData.data.survey_data['22']['answer']#</td></tr>
        	<tr><td>&nbsp;</td></tr>
            <tr>
            	<td>2. What is the name you would like on your Completion Certificate: Last Name?</td>
           </tr>
           <tr>
                <td>#jsonData.data.survey_data[23]['answer']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3. What email address would you like the confirmation of this survey to be sent to?</td>
            </tr>
           <tr>
                <td>#jsonData.data.survey_data[26]['answer']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>4. I am providing feedback about Lesson:</td>
            </tr>
           <tr>
                <td>#jsonData.data.survey_data[8]['answer']#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>5. The Faculty Member for this Lesson was:</td>
            </tr>
           <tr>
                <td>
                	#jsonData.data.survey_data[12]['answer']#
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6. I learned new coaching skills by participating in this Lesson:</td>
            </tr>
                <td>
                	<cfif jsonData.data.survey_data[2]['answer'] EQ 1>Strongly Disagree</cfif>
                    <cfif jsonData.data.survey_data[2]['answer'] EQ 2>Disagree</cfif>
                    <cfif jsonData.data.survey_data[2]['answer'] EQ 3>Neutral</cfif>
                    <cfif jsonData.data.survey_data[2]['answer'] EQ 4>Agree</cfif>
                    <cfif jsonData.data.survey_data[2]['answer'] EQ 5>Strongly Agree</cfif>
                    <cfif jsonData.data.survey_data[2]['answer'] CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>7. The faculty member demonstrated expertise regarding the content.</td>
            </tr>
                <td>
                	<cfif jsonData.data.survey_data[3]['answer'] EQ 1>Strongly Disagree</cfif>
                    <cfif jsonData.data.survey_data[3]['answer'] EQ 2>Disagree</cfif>
                    <cfif jsonData.data.survey_data[3]['answer'] EQ 3>Neutral</cfif>
                    <cfif jsonData.data.survey_data[3]['answer'] EQ 4>Agree</cfif>
                    <cfif jsonData.data.survey_data[3]['answer'] EQ 5>Strongly Agree</cfif>
                    <cfif jsonData.data.survey_data[3]['answer'] CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr>
            <tr><td>&nbsp;</td></tr>
                <td>8. What are the most valuable skills and behaviors demonstrated by the faculty member? </td>
            </tr>
                <td>#Replace(jsonData.data.survey_data[5]['answer'],'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>9. Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr>
            <tr>
                <td>#Replace(jsonData.data.survey_data[6]['answer'],'#chr(10)#','<br/>','all')#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>10. What else would you like for us to be aware of? </td>
            </tr>
            <tr>
                <td>#Replace(jsonData.data.survey_data[7]['answer'],'#chr(10)#','<br/>','all')#</td>
            </tr>
        </table>
    </cfsavecontent>
  <cfheader name="Content-Disposition" value="inline; filename=Test.pdf">
    <cfdocument format="pdf">
     	#PDFhtml#
    </cfdocument>
</cfoutput>