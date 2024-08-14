
<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.student_email>
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

   <cfif arrayLen(theData['params'][1]) EQ 0>
	   <cfoutput>
               We could not find student email: <mark>#url.student_email#</mark> in our system.
               <br />
               Please contact your coach concierge for further assistance.
               <cfabort>
        </cfoutput>
   </cfif>



<!---     
     
     <cfparam name="URL.retake" default="No" /> 


    <cfset memberID = theData['params'][1][1]['Id'] />
    <cfif url.retake EQ 'Yes'>
		<cfif url.score GTE 80>
    	  <cfset updateField['_PracticalSkillsAssessmentRetakeResult0']=URL.score />
		</cfif>
         <!--  <cfset updateField['_DateofPracticalSkillsAssessmentReTake'] = DateFormat(URL.exam_date,'mm-dd-yyyy') /> -->
    <cfelse>
		<cfif url.score GTE 80>
    		<cfset updateField['_PracticalSkillsAssessmentResult0']=URL.score>
		</cfif>
          <cfset updateField['_DateofPracticalSkillsAssessment'] =  DateFormat(URL.exam_date,'mm-dd-yyyy') />
    </cfif>

    <cfset updateField['_PracticalSkillsAssessmentExaminer'] = url.examiner />


	<cfset myArray = ArrayNew(1)>
     <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
     <cfset myArray[2]=key>
     <cfset myArray[3]='(int)#memberID#'>
     <cfset myArray[4]=updateField>

     <cfinvoke component="utilities/XML-RPC"
          method="CFML2XMLRPC"
          data="#myArray#"
          returnvariable="myPackage4">

     --->

<cfif URL.score GTE 80>
	

          <cfmail to="smyers@wellcoaches.com;" subject="Practical Exam Results - Pass" from="wellcoaches@wellcoaches.com" type="html">
               <p>Hi Sam,</p>
               <br />
               <p>
                    Student: #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#  <br />
                    ID: #theData.Params[1][1]['Id']#
               </p>
               <br />
               <p>Received a score of #URL.score# on their Practical Skills exam.</p>
               <br />
               <p>Here is their email address: <a href="mailto:#URL.student_email#" target="_top">#URL.student_email#</a></p>
               <br />
               To view results, click <a href="https://scripts.wellcoachesschool.com/utilities/infusionsoft/practicalResults.cfm?showPracticalResults=1&student_email=#URL.student_email#"> Results </a>
          </cfmail>
          Thank you for scoring the Practical Exam. <cfoutput> #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']# has been emailed their results!</cfoutput>

<cfelse>

	<cfmail to="smyers@wellcoaches.com" cc="#URL.examiner_email#;#URL.concierge#" subject="Practical Exam Results - No Pass" from="wellcoaches@wellcoaches.com" type="html">
     	<p>Hi Sam,</p>
          <br />
          <p>
          	Student: #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#  <br />
          	ID: #theData.Params[1][1]['Id']#
          </p>
          <br />
          <p>Received a score of #URL.score# on their Practical Skills exam.</p>
          <br />
          <p>Here is their email address: <a href="mailto:#URL.student_email#" target="_top">#URL.student_email#</a></p>
        	<br />
          To view results, click <a href="https://scripts.wellcoachesschool.com/utilities/infusionsoft/practicalResults.cfm?showPracticalResults=1&student_email=#URL.student_email#"> Results </a>
	</cfmail>
	<cfoutput>Thank you for scoring the Practical Exam.  Erika Jackson has been emailed with #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#'s score.</cfoutput>
</cfif>



