	<!-- 	AFTER 1 through 8 Habits surveys are completed -->
<!-- 		a Y is added to the Habits Surveys [Jul2018 Fwd] field -->
<!-- 		AS LONG AS 9705 is in place [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete] -->
<!-- 		THEN 9707 can be applied [Res Aug2018 [Indy] Mod 1 Habits Surveys Complete] -->
<!-- 		AS WELL AS 9771 which delivers the Certificate of Attendance [ Res Aug2018 [Indy] Mod 1 ALL Surveys Complete -->


<!-- https://www.surveygizmo.com/s3/4229417/Wellcoaches-Habits-course-Module-1?email=rdiveley@wellcoaches.com -->

  <!--- CFDUMP: Debugging by rdiveley --->


<cfparam  name="URL.lesson" default="">

	<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset selectedFieldsArray[4] = "_HabitsSurveysComplete">
    <cfset selectedFieldsArray[5] = "_HWCTFeedbackSurveysComplete3">
    <cfset selectedFieldsArray[6] = "Groups">
    
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]=URL.email>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

        <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
            arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
            variable="myResult1"
            timeout = "200">
        </cfexecute>


    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1#"
        returnvariable="theData">

        <cfset memberID = theData.Params[1][1]['Id'] />
        <cfset memberTags =  theData.Params[1][1]['Groups']>

        <cfif !arrayLen(theData.Params[1])>
            The email you entered <cfoutput><em>#URL.email#</em></cfoutput> does not exist in our records.  Please contact your concierge for further assistance.<cfabort />
        </cfif>

        <cfif listFindNoCase(memberTags, 16874) AND listFindNoCase(memberTags, 16876)>

            <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
            <cfset myArray2 = ArrayNew(1)>
            <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
            <cfset myArray2[2]=key>
            <cfset myArray2[3]="(int)#memberID#">
            <cfset myArray2[4]="(int)16692">
        
            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray2#"
                returnvariable="myPackage2">
            
            <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                variable="myResult2"
                timeout = "200">
            </cfexecute>

        </cfif>

        <cfparam name="theData.Params[1][1]['_HabitsSurveysComplete']" default=" ">

        <cfset updateList = theData.Params[1][1]['_HabitsSurveysComplete']>

        <cfif updateList NEQ 'Y' AND listLen(updateList) LTE 8 AND updateList NEQ 'STANDALONE'> 

            <cfset updateList = listAppend(updateList,URL.Lesson,"^")>
            <cfset newList = {} />
            <cfloop list="#updateList#" index="i" delimiters="^">
                <cfset newList[i] = i />
            </cfloop>
            <cfset updateList = structKeyList(newlist) />

			<cfset updateField = structNew()>
	        <cfset updateField['_HabitsSurveysComplete']=Replace(updateList.trim(),",","^","all")>
	        <cfset myArray = ArrayNew(1)>
	        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
	        <cfset myArray[2]=key>
	        <cfset myArray[3]='(int)#memberID#'>
	        <cfset myArray[4]=updateField>
	        <cfinvoke component="utilities/XML-RPC"
	              method="CFML2XMLRPC"
	              data="#myArray#"
	              returnvariable="myPackage4">

            <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
                variable="result"
                timeout = "200">
            </cfexecute>

        </cfif>

        <cfset updateList = listRemoveDuplicates(updateList,'^') />
        
        <cfif updateList EQ 'Y' OR listLen(updateList) GTE 8>
                <cfif structKeyExists(theData.Params[1][1],'_HWCTFeedbackSurveysComplete3') AND theData.Params[1][1]['_HWCTFeedbackSurveysComplete3'] EQ 'Y'>

                    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
                    <cfset myArray2 = ArrayNew(1)>
                    <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                    <cfset myArray2[2]=key>
                    <cfset myArray2[3]="(int)#memberID#">
                    <cfset myArray2[4]="(int)16692">
                
                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray2#"
                        returnvariable="myPackage2">
                    
                    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                        variable="myResult2"
                        timeout = "200">
                    </cfexecute>

                </cfif>
    
                <cfset updateField = structNew()>
                <cfset updateField['_HabitsSurveysComplete']="Y">
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
                <cfset myArray[2]=key>
                <cfset myArray[3]='(int)#memberID#'>
                <cfset myArray[4]=updateField>
                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage4">

                <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                    arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
                    variable="result"
                    timeout = "200">
                </cfexecute>
               <!--- No Longer using this code.
                
                <cfmodule template="applyHabitsComplete.cfm" memberID="#memberID#" />
                <cfmodule template="resTrainingFromHabits.cfm" memberID="#memberID#" email="#url.email#" /> --->
             
         </cfif>

         <!---
            Scenario #1
            If HabitsSurveysComplete is “Y” AND tag 16874 and tag 16876 exists then add tag 16692

            Scenario #2
            If HabitsSurveysComplete is “Y” AND tag 18680 exists then add tag 16862
         ---> 

         <cfif structKeyExists(theData.Params[1][1],'_HabitsSurveysComplete') 
                AND (theData.Params[1][1]['_HabitsSurveysComplete'] EQ 'Y' 
                     OR ListLen(theData.Params[1][1]['_HabitsSurveysComplete']) GTE 8)> 
                <!---Scenario #2
                    If HabitsSurveysComplete is “Y” AND tag 18680 exists then add tag 16862
                --->

                <cfif listFindNoCase(memberTags, 18680) >

                    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
                    <cfset myArray2 = ArrayNew(1)>
                    <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                    <cfset myArray2[2]=key>
                    <cfset myArray2[3]="(int)#memberID#">
                    <cfset myArray2[4]="(int)18682">
                
                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray2#"
                        returnvariable="myPackage2">

                    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                        variable="myResult2"
                        timeout = "200">
                    </cfexecute>
                </cfif>

                <!--- Scenario #3
                    If _HabitsSurveysComplete has 8 surveys or "Y”, AND the record has tag 18680 OR tag 18684, 
                    then add tag 18682 AND enter “STANDALONE” to _HabitsSurveysComplete --->

                 <cfif listFindNoCase(memberTags,18680) OR listFindNoCase(memberTags,18684)>

                    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
                    <cfset myArray2 = ArrayNew(1)>
                    <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                    <cfset myArray2[2]=key>
                    <cfset myArray2[3]="(int)#memberID#">
                    <cfset myArray2[4]="(int)18682">
                
                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray2#"
                        returnvariable="myPackage2">
                    
                    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                        variable="myResult2"
                        timeout = "200">
                    </cfexecute>

                    <cfset updateField = structNew()>
                    <cfset updateField['_HabitsSurveysComplete']="STANDALONE">
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
                    <cfset myArray[2]=key>
                    <cfset myArray[3]='(int)#memberID#'>
                    <cfset myArray[4]=updateField>
                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage4">

                    <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                        arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage4.Trim()#'
                        variable="result"
                        timeout = "200">
                    </cfexecute>

                 </cfif>

        </cfif>
         

         <p>
            Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
            If not, please contact your Coach Concierge for assistance. Thank you!
        </p>

         


