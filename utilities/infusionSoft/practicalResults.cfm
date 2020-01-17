<cfif structKeyExists(url,'showPracticalResults') >
	<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/1382009/surveyresponse">

     <cfhttp url="#SGurl#" result="myResult" method="get">
        <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
        <cfhttpparam type="url"  value="[question(21)]" name="filter[field][0]"/>
        <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
        <cfhttpparam type="url"  value="#URL.student_email#" name="filter[value][0]"/>
        <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
        <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
        <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
        <cfhttpparam type="url"  value="300" name="resultsperpage"/>
     </cfhttp>

     <cfset jsonData = deserializeJSON(myResult.fileContent) />
     <cfparam name="id" default="" />
     <cfloop array="#jsonData['data']#" index="struct">
          <cfset id = struct['id']>
     </cfloop>
     <cfset URL.surveyTitle = 1382009 />
     <cfset URL.id = id />
</cfif>


<cfhttp url="https://restapi.surveygizmo.com/v4/survey/#URL.surveyTitle#/surveyresponse/#URL.id#" result="myResult2" method="get">
        <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
</cfhttp>

<cfset jsonData = deserializeJSON(myResult2.fileContent).data />


<cfoutput>

     <cfdocument format="pdf" name="pdfGenerate">
     <table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
     	<tr>
          	<td><h1>Practical Skills Assessment: #jsonData['[question(4)]']#</h1></td>
          </tr>
          <tr>
               <td>Score: </td>
          </tr>
          <tr>
               <td>#jsonData['[question(16), option(0)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>

          <tr>
               <td>Student Name: </td>
          </tr>
          <tr>
               <td>#jsonData['[question(2)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td width="500px">Student Last Name:</td>
          </tr>
          <tr>
               <td>#jsonData['[question(22)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Student Email: </td>
          </tr>
          <tr>
               <td>#jsonData['[question(21)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Practical Examiner Email </td>
          </tr>
          <tr>
               <td>#jsonData['[question(24)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Practical Examiner</td>
          </tr>
          <tr>
               <td>#jsonData['[question(3)]']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
          	<td><h2>The following skills were fully demonstrated:</h2></td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Session Opening</td>
          </tr>

          <cfloop from="10001" to="10010" index="i">
			<cfif structKeyExists(jsonData,'[question(8), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(8), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Weekly Goal Review: Goal 1</td>
          </tr>
          <cfloop from="10006" to="10012" index="i">
          	<cfif structKeyExists(jsonData,'[question(9), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(9), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Weekly Goal Review: Goal 2</td>
          </tr>
         <cfloop from="10048" to="10054" index="i">
          	<cfif structKeyExists(jsonData,'[question(18), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(18), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
           <tr>
               <td>Three Month Goal Review</td>
          </tr>
          <cfloop from="10013" to="10016" index="i">
          	<cfif structKeyExists(jsonData,'[question(10), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(10), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
           <tr>
               <td>Generative Moment</td>
          </tr>
          <cfloop from="10017" to="10024" index="i">
          	<cfif structKeyExists(jsonData,'[question(11), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(11), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
           <tr>
               <td>Weekly Goal Setting: Goal 1</td>
          </tr>
          <cfloop from="10025" to="10030" index="i">
          	<cfif structKeyExists(jsonData,'[question(12), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(12), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>

           <tr>
               <td>Weekly Goal Setting: Goal 2</td>
          </tr>
          <cfloop from="10042" to="10047" index="i">
          	<cfif structKeyExists(jsonData,'[question(17), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(17), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>

           <tr>
               <td>Session Close</td>
          </tr>
         <cfloop from="10031" to="10034" index="i">
          	<cfif structKeyExists(jsonData,'[question(13), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(13), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
           <tr>
               <td>Coaching Presence</td>
          </tr>
         <cfloop from="10035" to="10041" index="i">
          	<cfif structKeyExists(jsonData,'[question(14), option(#i#)]')>
                    <tr>
                         <td>#jsonData['[question(14), option(#i#)]']#</td>
                    </tr>
               </cfif>
          </cfloop>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>Comments & Recommendations:</td>
          </tr>
          <cfscript>
			str = jsonData['[question(15)]'];
			//first make Windows style into Unix style
			str = replace(str,chr(13)&chr(10),chr(10),"ALL");
			//now make Macintosh style into Unix style
			str = replace(str,chr(13),chr(10),"ALL");
			//now fix tabs
			str = replace(str,chr(9),"&nbsp;&nbsp;&nbsp;","ALL");
			//now return the text formatted in HTML
		</cfscript>

          <tr>
               <td>#replace(str,chr(10),"<br />","ALL")#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
     </table>
    </cfdocument>


<cfheader name="Content-Disposition" value="attachment; filename=PracticalAssessment.pdf" />
<cfcontent type="application/pdf" variable="#toBinary(pdfGenerate)#" />


     <cfabort>
</cfoutput>