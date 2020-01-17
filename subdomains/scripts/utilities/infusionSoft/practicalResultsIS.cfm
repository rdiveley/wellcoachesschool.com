<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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


<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
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

     <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
          <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
     </cfhttp>

<cfif URL.score GTE 80>
	<!---  4226 pass
	4228 did not pass--->
   	<cfset contactList = ArrayNew(1)>
     <cfset contactList[1] = "(int)#theData.Params[1][1]['Id']#">

     <cfset contactArray = ArrayNew(1)>

     <cfset contactArray[1]="APIEmailService.sendEmail"><!---Service.method always first param--->
     <cfset contactArray[2]='fb7d1fc8a4aab143f6246c090a135a41'>
     <cfset contactArray[3]='#contactList#'>
     <cfset contactArray[4]='(int)4226'>

     <cfinvoke component="utilities/XML-RPC"
         method="CFML2XMLRPC"
         data="#contactArray#"
         returnvariable="getEmailTemplate">

         <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
               <cfhttpparam type="XML" value="#getEmailTemplate.Trim()#"/>
         </cfhttp>

          <cfmail to="#URL.examiner_email#;lho@wellcoaches.com;" subject="Practical Exam Results - Pass" from="wellcoaches@wellcoaches.com" type="html">
               <p>Hi #URL.concierge#,</p>
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
          Thank you for scoring the Practical Exam.  #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']# has been emailed their results!
<cfelse>

	<cfmail to="erika@wellcoaches.com" cc="#URL.examiner_email#;#URL.concierge#" subject="Practical Exam Results - No Pass" from="wellcoaches@wellcoaches.com" type="html">
     	<p>Hi Erika,</p>
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



