<!---<cfdump var="#URL#"><cfabort>--->
<cfoutput>

<cfparam name="FORM.fileName" default="">
<cfparam name="URL.other" default="">
<cfparam name="URL.hours" default="">
<cfparam name="URL.lesson" default="">
<cfparam name="URL.year" default="">
<cfparam name="URL.classAttended" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.businessDev" default="">
<cfparam name="URL.faculty" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">

<cfparam name="URL.usefulTele" default="">
<cfparam name="URL.changesTele" default="">

<cfset DSN = "wellcoachesSchool">

<cfset lesson = URLEncodedFormat(URL.lesson)>
<cfif len(URL.classAttended) EQ 0 OR URL.classAttended EQ 'Other'>
	<cfset classAttended = URLEncodedFormat(URL.other)>
<cfelse>
	<cfset classAttended = URLEncodedFormat(URL.classAttended)>
</cfif>

<cfset uniqueFileName = "#URL.email#_#classAttended# #URL.lesson# #year#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">



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

<!---if there's an answer in question 9 or 10 update OYM Live Survey compelete --->
<cfif len(trim(URL.changesTele)) AND len(trim(URL.usefulTele))>
	<cfset memberID =  theData.Params[1][1]['Id']>
	<cfset updateField = structNew()>
	<cfset updateField['_OYMLiveSurveyComplete']="Y">


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

 	  <cfset myArray = ArrayNew(1)>
      <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
      <cfset myArray[2]=key>
      <cfset myArray[3]='(int)#memberID#'>
      <cfset myArray[4]="(int)6228">


       <cfinvoke component="utilities/XML-RPC"
           method="CFML2XMLRPC"
           data="#myArray#"
           returnvariable="myPackage">


       <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
           <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
       </cfhttp>
</cfif>

  <cfdocument format="pdf" name="pdfGenerate">
  		<table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
        	<tr>
            	<td>Name: #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#</td>
            </tr>
             <tr><td>&nbsp;</td></tr>
        	<tr>
            	<td width="500px">1.  What was the class that you attended? </td>
           </tr>
           <tr>
                <td>#URL.classAttended#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>2. If you selected "Other", what is the name of the class that you attended? </td>
            </tr>
           <tr>
                <td>#URL.other# </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>3. I attended or listened to this class in:</td>
            </tr>
           <tr>
                <td>#URL.lesson#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>4. How many hours was this class? </td>
            </tr>
           <tr>
                <td>#val(URL.hours)#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>5. In which year did you attend, or listen to, this class?</td>
            </tr>
           <tr>
                <td>#val(URL.year)#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>6.  I learned new coaching skills by participating in this Lesson</td>
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
                <td>7. I learned new business development skills by participating in this Class: </td>
            </tr>
           <tr>
                <td>
                	<cfif #URL.businessDev# EQ 1>Strongly Disagree</cfif>
                    <cfif #URL.businessDev# EQ 2>Disagree</cfif>
                    <cfif #URL.businessDev# EQ 3>Neutral</cfif>
                    <cfif #URL.businessDev# EQ 4>Agree</cfif>
                    <cfif #URL.businessDev# EQ 5>Strongly Agree</cfif>
                    <cfif #URL.businessDev# CONTAINS 'NA'>Not Applicable</cfif>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>8.  The facilitator demonstrated expertise regarding the content</td>
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
                <td>9.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
            </tr>
                <td>
                	#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#
                </td>
            </tr>
            <tr>
                <td>10.  Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
            </tr>
            <tr>
                <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>11.  What else would you like for us to be aware of?</td>
            </tr>
            <tr>
                <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
            </tr>

        </table>

  </cfdocument>
  <cftry>


	  <cfset valuableSkills = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
      <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
      <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>

      <cfparam name="addSurveyTally" default="0">

      <cfinclude template="showHideSurveyTally.cfm">



     <cffile action="write"
  		file="#GetTempDirectory()#/#uniqueFileName#"
    	output="#pdfGenerate#" >


    <cffile action="readbinary" file="#GetTempDirectory()#/#uniqueFileName#" variable="readFile">

    <cfif URL.email Contains "_">
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

   	    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfcatch type="any">
      
  </cfcatch>
    </cftry>
		 <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif>

         <cfabort>


</cfoutput>

