<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

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

		<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

		<cfif !ArrayLen(theData2.Params[1])>
          	There is no user with that email address in our records. <cfabort>
          </cfif>

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
       	<!--- Core Training Survey Complete --->
        <cfset selectedFieldsArray[1] = "_HWCTFeedbackSurveysComplete3">
          <!--- OYM Live Survey Complete --->
		<cfset selectedFieldsArray[2] = "_OYMLiveSurveyComplete">
         <!--- written exam results --->
		<cfset selectedFieldsArray[3] = "_WrittenExamResults">
         <!--- written exam retake results --->
		<cfset selectedFieldsArray[4] = "_WrittenExamRetakeResults">
		<!--- written exam successfully completed --->
        <cfset selectedFieldsArray[5] = "_WrittenExamsuccessfullycompleted">
		 <!---  practice client result --->
		<cfset selectedFieldsArray[6] = "_PracticeClientResult0">
         <!--- practice client retake result --->
		<cfset selectedFieldsArray[7] = "_PracticeClientRetakeResult0">
        <!--- date of practical skills assessment --->
		<cfset selectedFieldsArray[8] = "_DateofPracticalSkillsAssessment">
		 <!--- practical skills assessment results--->
		<cfset selectedFieldsArray[9] = "_PracticalSkillsAssessmentResult0">
         <!---practical skills assessment examiner--->
        <cfset selectedFieldsArray[10] = "_PracticalSkillsAssessmentExaminer">
		<!--- PS Assessment re-take date --->
        <!---practical skills assessment retake results--->
        <cfset selectedFieldsArray[11] = "_PracticalSkillsAssessmentRetakeResult0">
		<!---practical skills assessment retake examiner--->
        <!---personal wellness vision submitted--->
        <cfset selectedFieldsArray[12] = "_PersonalWellnessVisionSubmitted">


        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='Contact'>
        <cfset myArray[4]='(int)10'>
        <cfset myArray[5]='(int)0'>
        <cfset myArray[6]=selectedFieldStruct>
        <cfset myArray[7]=selectedFieldsArray>

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

		<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult3">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData">


       <cfif !structKeyExists(theData.Params[1][1], '_HWCTFeedbackSurveysComplete3')>
       	<cfset surveyComplete = '' />
       <cfelse>
	  	<cfset surveyComplete  =  theData.Params[1][1]['_HWCTFeedbackSurveysComplete3'] />
       </cfif>

 	  <cfif !structKeyExists(theData.Params[1][1], '_OYMLiveSurveyComplete')>
       	<cfset oymSurvey = '' />
       <cfelse>
	 	<cfset oymSurvey  = theData.Params[1][1]['_OYMLiveSurveyComplete'] />
	   </cfif>

	   <cfif !structKeyExists(theData.Params[1][1], '_WrittenExamResults')>
       	<cfset writtenExam = '' />
       <cfelse>
	 	<cfset writtenExam  = theData.Params[1][1]['_WrittenExamResults'] />
	   </cfif>

        <cfif !structKeyExists(theData.Params[1][1], '_WrittenExamRetakeResults')>
       	<cfset writtenExamRetake = '' />
       <cfelse>
	 	<cfset writtenExamRetake  = theData.Params[1][1]['_WrittenExamRetakeResults'] />
	   </cfif>

	   <cfif !structKeyExists(theData.Params[1][1], '_WrittenExamsuccessfullycompleted')>
       	<cfset writtenExamDate = '' />
       <cfelse>
	 	<cfset writtenExamDate  = DateFormat(theData.Params[1][1]['_WrittenExamsuccessfullycompleted'],'mm/dd/yyyy') />
	   </cfif>


	   <cfif !structKeyExists(theData.Params[1][1], '_PracticeClientResult0')>
       	<cfset practiceClient = '' />
       <cfelse>
	 	<cfset practiceClient  = theData.Params[1][1]['_PracticeClientResult0'] />
	   </cfif>

	   <cfif !structKeyExists(theData.Params[1][1], '_PracticeClientRetakeResult0')>
       	<cfset practiceClientRetake = '' />
       <cfelse>
	 	<cfset practiceClientRetake  = theData.Params[1][1]['_PracticeClientRetakeResult0'] />
	   </cfif>

       <cfif !structKeyExists(theData.Params[1][1], '_DateofPracticalSkillsAssessment')>
       	<cfset PSAssessmentDate = ''/>
       <cfelse>
	 	<cfset PSAssessmentDate = DateFormat(theData.Params[1][1]['_DateofPracticalSkillsAssessment'],'mm/dd/yyyy') />
	   </cfif>

	  <cfif !structKeyExists(theData.Params[1][1], '_PracticalSkillsAssessmentResult0')>
       	<cfset PSAssessment = '' />
       <cfelse>
	 	<cfset PSAssessment  = theData.Params[1][1]['_PracticalSkillsAssessmentResult0'] />
	   </cfif>

 	  <cfif !structKeyExists(theData.Params[1][1], '_PracticalSkillsAssessmentExaminer')>
       	<cfset PSExaminer= '' />
       <cfelse>
	 	<cfset PSExaminer  = theData.Params[1][1]['_PracticalSkillsAssessmentExaminer'] />
	   </cfif>

	  <cfif !structKeyExists(theData.Params[1][1], '_PracticalSkillsAssessmentRetakeResult0')>
       	<cfset PSRetakeResults = '' />
       <cfelse>
	 	<cfset PSRetakeResults  = theData.Params[1][1]['_PracticalSkillsAssessmentRetakeResult0'] />
	   </cfif>

	   <cfif !structKeyExists(theData.Params[1][1], '_PersonalWellnessVisionSubmitted')>
       	<cfset personalWVSubmitted = '' />
       <cfelse>
	 	<cfset personalWVSubmitted  = theData.Params[1][1]['_PersonalWellnessVisionSubmitted'] />
	   </cfif>


<cfoutput>
<table  style="font-size: 16px; font-family:verdana,Arial,Helvetica,sans-serif; border:none; width:600px;color: ##555" >
	<!---<cfif len(surveyComplete)>
		<tr>
			<td>
	               <strong>Core Training Surveys Complete</strong>
	               <br />
	               #surveyComplete#
	          </td>
		</tr>
	</cfif>
	<cfif len(oymSurvey)>
		<tr>
			<td>
	          	<strong>OYM Live Survey Complete</strong>
	               <br />
	          	#oymSurvey#
	          </td>
		</tr>
	</cfif> --->
	<cfif len(writtenExam)>
		<tr>
			<td>
	               <strong>Written Exam Results</strong>
	               <br />
	               #writtenExam#
	          </td>
		</tr>
	</cfif>
	<cfif len(writtenExamRetake)>
	<tr>
		<td>
               <strong>Written Exam Retake Results</strong>
               <br />
               #writtenExamRetake#
          </td>
	</tr>
	</cfif>
	<!---
	<cfif len(writtenExamDate)>
		<tr>
			<td>
	               <strong>Written Exam successfully completed</strong>
	               <br />
	               #writtenExamDate#
	          </td>
		</tr>
	</cfif> --->
	<cfif len(practiceClient)>
		<tr>
			<td>
	               <strong>Practice Client Result</strong>
	               <br />
	               #practiceClient#
	          </td>
		</tr>
	</cfif>
	<cfif len(practiceClientRetake)>
		<tr>
			<td>
	               <strong>Practice Client Retake Result</strong>
	               <br />
	               #practiceClientRetake#
	          </td>
		</tr>
	</cfif>
	<!---
	<cfif len(PSAssessmentDate)>
		<tr>
			<td>
	               <strong>Date of Practical Skills Assessment</strong>
	               <br />
	               #PSAssessmentDate#
	          </td>
		</tr>
	</cfif> --->
	<cfif len(PSAssessment)>
		<tr>
			<td>
	               <strong>Practical Skills Assessment Result</strong>
	               <br />
	               #PSAssessment#
	          </td>
		</tr>
	</cfif>
	<!---
	<cfif len(PSExaminer)>
		<tr>
			<td>
	               <strong>Practical Skills Assessment Examiner</strong>
	               <br />
	               #PSExaminer#
	          </td>
		</tr>
	</cfif>
	<cfif len(PSRetakeDate)>
		<tr>
			<td>
	               <strong>Date of Practical Skills Assessment Re-Take</strong>
	               <br />
	               #PSRetakeDate#
	          </td>
		</tr>
	</cfif>--->
	<cfif len(PSRetakeResults)>
		<tr>
			<td>
	               <strong>Practical Skills Assessment Retake Result</strong>
	               <br />
	               #PSRetakeResults#
	          </td>
		</tr>
	</cfif>
	<!---
	<cfif len(PSRetakeExaminer)>
		<tr>
			<td>
	               <strong>Practical Skills Assessment Retake Examiner</strong>
	               <br />
	               #PSRetakeExaminer#
	          </td>
		</tr>
	</cfif> --->
	<cfif len(personalWVSubmitted)>
		<tr>
			<td>
	               <strong>Personal Wellness Vision Submitted</strong>
	               <br />
	               #personalWVSubmitted#
	          </td>
		</tr>
	</cfif>

</table>
</cfoutput>













