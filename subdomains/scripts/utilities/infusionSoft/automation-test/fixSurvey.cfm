<cfset DSN = "wellcoachesSchool">
<cfset URL.email = 'laurie_meyer@sbcglobal.net'>

<cfquery name="insertResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
SELECT
      [Lesson]
      ,[cohort]
      ,[email]
      ,[faculty]
      ,[coachingSkills]
      ,[facultyExpertise]
      ,[valuableSkills]
      ,[lessonRelevant]
      ,[summarize]
      ,[awareOf]
      ,[attendLive]
      ,[dateSubmitted]
      ,[infusionSoftID]
  FROM [wellcoachesSchool].[dbo].[SurveyResults]
  where email like 'laurie_meyer@sbcglobal.net'
  </cfquery>


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

    <cfoutput query="insertResults">
    <cfset uniqueFileName = "#email#_#lesson#_#listFirst(dateSubmitted," ")#.pdf">
	<cfset copyFaculty = "#faculty#_#lesson#_#email#_#listFirst(dateSubmitted," ")#.pdf">

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
                <td>#lesson#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>2.  I am participating in the following class cohort:</td>
            </tr>
           <tr>
                <td>#cohort# </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3.  The Faculty Member for this Lesson was:</td>
            </tr>
           <tr>
                <td>#faculty#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>4.  I learned new coaching skills by participating in this Lesson</td>
            </tr>
           <tr>
                <td>
                	<cfif #coachingSkills# EQ 1>Strongly Disagree</cfif>
                    <cfif #coachingSkills# EQ 2>Disagree</cfif>
                    <cfif #coachingSkills# EQ 3>Neutral</cfif>
                    <cfif #coachingSkills# EQ 4>Agree</cfif>
                    <cfif #coachingSkills# EQ 5>Strongly Agree</cfif>
                    <cfif #coachingSkills# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>5.  The faculty member demonstrated expertise regarding the content</td>
            </tr>
                <td>
                	<cfif #facultyExpertise# EQ 1>Strongly Disagree</cfif>
                    <cfif #facultyExpertise# EQ 2>Disagree</cfif>
                    <cfif #facultyExpertise# EQ 3>Neutral</cfif>
                    <cfif #facultyExpertise# EQ 4>Agree</cfif>
                    <cfif #facultyExpertise# EQ 5>Strongly Agree</cfif>
                    <cfif #facultyExpertise# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
            </tr>
                <td>
                	#Replace(valuableSkills,"#chr(10)#","<br>","all")#
                </td>
            </tr>
            <tr>
            <tr><td>&nbsp;</td></tr>
                <td>7.  This Lesson was relevant to the objective of the course: To mobilize the best coaches to help people make lasting improvements to their health and well-being. </td>
            </tr>
                <td>

                    <cfif #lessonRelevant# EQ 1>Strongly Disagree</cfif>
                    <cfif #lessonRelevant# EQ 2>Disagree</cfif>
                    <cfif #lessonRelevant# EQ 3>Neutral</cfif>
                    <cfif #lessonRelevant# EQ 4>Agree</cfif>
                    <cfif #lessonRelevant# EQ 5>Strongly Agree</cfif>
                    <cfif #lessonRelevant# CONTAINS 'NA'>Not Applicable</cfif>

                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>8.  Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr>
            <tr>
                <td>#Replace(summarize,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>9.  What else would you like for us to be aware of?</td>
            </tr>
            <tr>
                <td>#Replace(awareOf,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>10.  I attended this class live</td>
            </tr>
            <tr>
                <td>#attendLive#</td>
            </tr>

        </table>
	</cfdocument>
       <cffile action="write"
            file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#uniqueFileName#"
            output="#pdfGenerate#" >

     <cffile action="write"
        file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#RereplaceNocase(copyFaculty," ","_","ALL")#"
        output="#pdfGenerate#" >


   <cfif URL.email Contains "_">
   		<cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
    	<cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
    	<cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
   </cfif>

   <cffile action="readbinary" file="#expandPath('./temp/#uniqueFileName#')#" variable="readFile">

   		
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
    </cfoutput>



