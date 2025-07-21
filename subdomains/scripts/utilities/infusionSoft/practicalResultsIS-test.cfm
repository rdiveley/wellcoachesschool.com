
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

<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
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

<cfhttp url="https://scripts.wellcoachesschool.com/utilities/infusionSoft/sendmail.php" method="post">
    <cfhttpparam type="formField" name="firstName" value="#theData.Params[1][1]['FirstName']#">
    <cfhttpparam type="formField" name="lastName" value="#theData.Params[1][1]['LastName']#">
    <cfhttpparam type="formField" name="studentId" value="#theData.Params[1][1]['Id']#">
    <cfhttpparam type="formField" name="score" value="#URL.score#">
    <cfhttpparam type="formField" name="studentEmail" value="#URL.student_email#">
    <cfhttpparam type="formField" name="examinerEmail" value="#URL.examiner_email#">
    <cfhttpparam type="formField" name="conciergeEmail" value="#URL.concierge#">
</cfhttp>

<cfoutput>
    Thank you for scoring the Practical Exam. #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']# has been emailed their results!
</cfoutput>




