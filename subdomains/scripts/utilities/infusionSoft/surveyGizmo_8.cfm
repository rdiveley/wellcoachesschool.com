
<cfoutput>

<cfif isDefined('url.debug') and url.debug EQ 1>
	<cfdump var="#URL#">
</cfif>

<cfparam name="URL.lesson" default="">
<cfparam name="URL.cohort" default="">
<cfparam name="URL.faculty_member" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.faculty" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.lessonObj" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">
<cfparam name="URL.live" default="">
<cfset DSN = "wellcoachesSchool">


<cfif structKeyExists(url,'email')>
    <cfset local.email = url.email />
</cfif>

<cfif structKeyExists(url,'lesson')>
    <cfset local.lesson = url.lesson />
</cfif>

<cfif structKeyExists(url, 'emailForm')>
    <cfset local.email = url.emailForm />
</cfif>


<!---<cfset lesson = URLEncodedFormat(URL.lesson)>
<cfset uniqueFileName = "#local.email#_#URLEncodedFormat(lesson)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
<cfset copyFaculty = "#URL.faculty_member#_#URLEncodedFormat(lesson)#_#local.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">

--->

<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=local.email>
<cfset myArray[4]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">

    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
        variable="myResult"
        timeout = "200">
    </cfexecute>

<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult#"
    returnvariable="theData">


		<cfif !ArrayLen(theData.Params[1])>
          	There is no user with that email address in our records. <cfabort>
        </cfif>
<!---
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
                <td>#URL.lesson#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>2.  The Faculty Member for this Lesson was:</td>
            </tr>
           <tr>
                <td>#URL.faculty_member#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3.  I am participating in the Cohort that began:</td>
            </tr>
           <tr>
                <td>#URL.cohort#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>4  I learned new coaching skills by participating in this Lesson</td>
            </tr>
           <tr>
                <td>
                	<cfif #URL.coachingSkills# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.coachingSkills# EQ 2>Disagree</cfif>
                    <cfif #URL.coachingSkills# EQ 3>Neutral</cfif>
                    <cfif #URL.coachingSkills# EQ 4>Agree</cfif>
                    <cfif #URL.coachingSkills# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.coachingSkills# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>5.  The faculty member demonstrated expertise regarding the content</td>
            </tr>
                <td>
                	<cfif #URL.faculty# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.faculty# EQ 2>Disagree</cfif>
                    <cfif #URL.faculty# EQ 3>Neutral</cfif>
                    <cfif #URL.faculty# EQ 4>Agree</cfif>
                    <cfif #URL.faculty# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.faculty# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
            </tr>
                <td>
                	#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#
                </td>
            </tr>
            <tr>
            <tr><td>&nbsp;</td></tr>
                <td>7  This Lesson was relevant to the objective of the course: To mobilize the best coaches to help people make lasting improvements to their health and well-being. </td>
            </tr>
                <td>

                    <cfif #URL.lessonObj# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.lessonObj# EQ 2>Disagree</cfif>
                    <cfif #URL.lessonObj# EQ 3>Neutral</cfif>
                    <cfif #URL.lessonObj# EQ 4>Agree</cfif>
                    <cfif #URL.lessonObj# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.lessonObj# CONTAINS 'NA'>Not Applicable</cfif>

                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>8.  Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr>
            <tr>
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>9.  What else would you like for us to be aware of?</td>
            </tr>
            <tr>
                <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
            </tr>
        </table>

  </cfdocument>
  <cfset valuableSkills = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
  <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
  <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
--->
  <cfparam name="addSurveyTally" default="0">

  <cfinclude template="tallyTag.cfm">

<!---
  <cftry>
      <cfcatch type="any">
      <cfmail to="techsupport@wellcoaches.com" subject="Survey Gizmo 8 Error" from="#local.email#">
        #cfcatch.detail#<br />
        <cfdump var="#URL#">
      </cfmail>
      </cfcatch>
  </cftry>

  <cffile action="write"
  	file="#GetTempDirectory()#/#uniqueFileName#"
    output="#pdfGenerate#" >


   <cffile action="readbinary" file="#GetTempDirectory()#/#uniqueFileName#" variable="readFile">

    <cfif local.email Contains "_">
   		<cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
    	<cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
    	<cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
   	</cfif>


   		<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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

   		<!---<cfx_http5 url="https://my982.infusionsoft.com/api/xmlrpc" method="POST" body=#myPackage.Trim()# out="myResult"  >--->

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
    
		<cfset lessonNumber = ListFirst(URL.lesson,':')>
        <cfset lessonNumber = ListLast(lessonNumber,' ')>
        
--->

        <cflocation url="completedHours.cfm?email=#local.email#&lesson=#local.lesson#"   >

        <cfabort>


</cfoutput>

