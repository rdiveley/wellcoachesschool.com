 <cfoutput>
     <cfif isDefined('url.debug') and url.debug EQ 1>
          <cfdump var="#URL#">
          <cfabort>
     </cfif>
     <cfparam name="URL.aware" default="">
     <cfparam name="URL.businessDev" default="">
     <cfparam name="URL.coachingskills" default="">
     <cfparam name="URL.email" default="">
     <cfparam name="URL.faculty" default="">
     <cfparam name="URL.fname" default="">
     <cfparam name="URL.hours" default="">
     <cfparam name="URL.lesson" default="">
     <cfparam name="URL.lname" default="">
     <cfparam name="URL.recommend" default="">
     <cfparam name="URL.summarize" default="">
     <cfparam name="URL.VALUABLE" default="">
     <cfparam name="URL.year" default="">
     <cfset DSN = "wellcoachesSchool">
     
     <!---<cfset lesson = URLEncodedFormat(URL.lesson)>--->
     <cfset uniqueFileName = "#URL.email#_#URLEncodedFormat(lesson)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
     <cfset copyFaculty = "#URL.faculty#_#URLEncodedFormat(lesson)#_#URL.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
     
     <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
     <cfset selectedFieldsArray = ArrayNew(1)>
     <cfset selectedFieldsArray[1] = "Id">
     <cfset selectedFieldsArray[2] = "FirstName">
     <cfset selectedFieldsArray[3] = "LastName">
     <cfset myArray = ArrayNew(1)>
     <cfset myArray[1]="ContactService.findByEmail">
     <!---Service.method always first param--->
     <cfset myArray[2]=key>
     <cfset myArray[3]=URL.email>
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
     <cfdocument format="pdf" name="pdfGenerate">
     <table width="800"  style="font-family:Arial, Helvetica, sans-serif;size:auto">
          <tr>
               <td>Name: #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td width="500px">1.  Name for Certificate - Your First Name</td>
          </tr>
          <tr>
               <td>#URL.fname#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>2.  Name for Certificate - Your Last Name</td>
          </tr>
          <tr>
               <td>#URL.lname#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>3. What was the class that you attended? </td>
          </tr>
          <tr>
               <td>#URL.lesson#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>4. How many hours was this class? </td>
          </tr>
          <tr>
               <td>#URL.hours#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>5. In which year did you attend, or listen to, this class? </td>
          </tr>
          <tr>
               <td>#URL.year#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>6.  I learned new coaching skills by participating in this Lesson</td>
          </tr>
          <tr>
               <td><cfif #URL.coachingSkills# EQ 1>
                         Strongly Disagree
                    </cfif>
                    <cfif #URL.coachingSkills# EQ 2>
                         Disagree
                    </cfif>
                    <cfif #URL.coachingSkills# EQ 3>
                         Neutral
                    </cfif>
                    <cfif #URL.coachingSkills# EQ 4>
                         Agree
                    </cfif>
                    <cfif #URL.coachingSkills# EQ 5>
                         Strongly Agree
                    </cfif>
                    <cfif #URL.coachingSkills# CONTAINS 'NA'>
                         Not Applicable
                    </cfif>
               </td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>5.  The faculty member demonstrated expertise regarding the content</td>
          </tr>
          <tr>
               <td><cfif #URL.faculty# EQ 1>
                         Strongly Disagree
                    </cfif>
                    <cfif #URL.faculty# EQ 2>
                         Disagree
                    </cfif>
                    <cfif #URL.faculty# EQ 3>
                         Neutral
                    </cfif>
                    <cfif #URL.faculty# EQ 4>
                         Agree
                    </cfif>
                    <cfif #URL.faculty# EQ 5>
                         Strongly Agree
                    </cfif>
                    <cfif #URL.faculty# CONTAINS 'NA'>
                         Not Applicable
                    </cfif>
                   </td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>6.  What are the most valuable skills and behaviors demonstrated by the faculty member?</td>
          </tr>
          <tr>
               <td>#Replace(URL.VALUABLE,"#chr(10)#","<br>","all")#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>7. learned new business development skills by participating in this Class: </td>
          </tr>
          <tr>
               <td><cfif #URL.businessdev# EQ 1>
                         Strongly Disagree
                    </cfif>
                    <cfif #URL.businessdev# EQ 2>
                         Disagree
                    </cfif>
                    <cfif #URL.businessdev# EQ 3>
                         Neutral
                    </cfif>
                    <cfif #URL.businessdev# EQ 4>
                         Agree
                    </cfif>
                    <cfif #URL.businessdev# EQ 5>
                         Strongly Agree
                    </cfif>
                    <cfif #URL.businessdev# CONTAINS 'NA'>
                         Not Applicable
                    </cfif></td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>8.  The facilitator demonstrated expertise regarding the content.</td>
          </tr>
          <tr>
               <td><cfif #URL.faculty# EQ 1>
                         Strongly Disagree
                    </cfif>
                    <cfif #URL.faculty# EQ 2>
                         Disagree
                    </cfif>
                    <cfif #URL.faculty# EQ 3>
                         Neutral
                    </cfif>
                    <cfif #URL.faculty# EQ 4>
                         Agree
                    </cfif>
                    <cfif #URL.faculty# EQ 5>
                         Strongly Agree
                    </cfif>
                    <cfif #URL.faculty# CONTAINS 'NA'>
                         Not Applicable
                    </cfif></td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
           <tr>
               <td>9.  What are the most valuable skills and behaviors demonstrated by the facilitator?</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>#Replace(URL.valuable,"#chr(10)#","<br>","all")#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>10.  Please summarize the two most valuable elements learned from this class and how you will apply them to your coaching practice or other coaching activities. </td>
          </tr>
          <tr>
               <td>#Replace(URL.summarize,"#chr(10)#","<br>","all")#</td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>11. What else would you like for us to be aware of?  </td>
          </tr>
          <tr>
               <td>&nbsp;</td>
          </tr>
          <tr>
               <td>#Replace(URL.aware,"#chr(10)#","<br>","all")#</td>
          </tr>
     </table>
     </cfdocument>
    
     <cfset valuableSkills = Replace(URL.VALUABLE,"#chr(10)#","<br>","all")>
     <cfset awareOF = Replace(URL.aware,"#chr(10)#","<br>","all")>
     <cfset summary = Replace(URL.summarize,"#chr(10)#","<br>","all")>
     
     <cftry>
          <cfcatch type="any">
               <cfmail to="techsupport@wellcoaches.com" subject="Survey Gizmo 8 Error" from="#URL.email#">
                    #cfcatch.detail#<br />
                    <cfdump var="#URL#">
               </cfmail>
          </cfcatch>
     </cftry>
     <cffile action="write"
  		file="#GetTempDirectory()#/#uniqueFileName#"
    		output="#pdfGenerate#" >
     
     <cffile action="readbinary" file="#GetTempDirectory()#/#uniqueFileName#" variable="readFile">
     
	<cfif URL.email Contains "_">
          <cfset oldEmail = listGetAt(uniqueFileName,1,'@')>
          <cfset newEmail = REReplaceNoCase(oldEmail,"_","^","all")>
          <cfset uniqueFileName = ReplaceNoCase(uniqueFileName,oldEmail,newEmail,"all")>
     </cfif>
     
     <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e">
     <cfset myArray = ArrayNew(1)>
     <cfset myArray[1]="FileService.uploadFile">
     <!---Service.method always first param--->
     <cfset myArray[2]=key>
     <cfset myArray[3]="(int)#theData.Params[1][1]['id']#">
     <cfset myArray[4]="#URLDecode(ListGetAt(uniqueFileName,'2','_'))#.pdf">
     <cfset myArray[5]=ToBase64(readFile)>
     <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage"> 

     <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
          <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
          <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
     </cfhttp>
     
     <cfif Find('Motivational',url.lesson)>
     	<cfset applyTag = "(int)4451">
     <cfelseif Find('Overcoming', url.lesson)>
     	<cfset applyTag = "(int)4449">
     <cfelse>
     	<cfset applyTag = "(int)4453">
     </cfif>     
     
     <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e">
	<cfset myArray2 = ArrayNew(1)>
     <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
     <cfset myArray2[2]=key>
     <cfset myArray2[3]="(int)#theData.Params[1][1]['Id']#">
     <cfset myArray2[4]=applyTag>
     
     
     <cfinvoke component="utilities/XML-RPC"
          method="CFML2XMLRPC"
          data="#myArray2#"
          returnvariable="myPackage2">
    
     
     

     <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult2">
          <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
          <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
     </cfhttp>
     
     
     <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file. 
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>

</cfoutput> 