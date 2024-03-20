	<!-- 	AFTER 1 through 8 Habits surveys are completed -->
<!-- 		a Y is added to the Habits Surveys [Jul2018 Fwd] field -->
<!-- 		AS LONG AS 9705 is in place [Res Aug2018 [Indy] Mod 1 Four-Day Surveys Complete] -->
<!-- 		THEN 9707 can be applied [Res Aug2018 [Indy] Mod 1 Habits Surveys Complete] -->
<!-- 		AS WELL AS 9771 which delivers the Certificate of Attendance [ Res Aug2018 [Indy] Mod 1 ALL Surveys Complete -->


<!-- https://www.surveygizmo.com/s3/4229417/Wellcoaches-Habits-course-Module-1?email=rdiveley@wellcoaches.com -->



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


        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult1">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

        <cfif !arrayLen(theData2.Params[1])>
            The email you entered <cfoutput><em>#URL.email#</em></cfoutput> does not exist in our records.  Please contact your concierge for further assistance.<cfabort />
        </cfif>

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "_HabitsSurveysComplete">
        <cfset selectedFieldsArray[2] = "Id">

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

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData">

        <cfparam name="theData.Params[1][1]['_HabitsSurveysComplete']" default=" ">

        <cfset updateList = theData.Params[1][1]['_HabitsSurveysComplete']>

        <cfif updateList NEQ 'Y' AND listLen(updateList) LTE 8> 

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

	        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
	              <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
	        </cfhttp>
        </cfif>
        
      
        <cfset updateList = listRemoveDuplicates(updateList,'^') />
        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "_HWCTFeedbackSurveysComplete3">
        <cfset selectedFieldsArray[2] = "_HabitsSurveysComplete">

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

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData3">

        <cfif updateList EQ 'Y' OR listLen(updateList) GTE 8>
                <cfif structKeyExists(theData3.Params[1][1],'_HWCTFeedbackSurveysComplete3') AND theData3.Params[1][1]['_HWCTFeedbackSurveysComplete3'] EQ 'Y'>

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
                    
                    
                    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult2">
                        <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
                    </cfhttp>

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

                <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
                    <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
                </cfhttp>
                <cfmodule template="applyHabitsComplete.cfm" memberID="#memberID#" />
                <cfmodule template="resTrainingFromHabits.cfm" memberID="#memberID#" email="#url.email#" />
             
         </cfif>

         <!---
            Scenario #1
            If HabitsSurveysComplete is “Y” AND tag 16874 and tag 16876 exists then add tag 16692

            Scenario #2
            If HabitsSurveysComplete is “Y” AND tag 18680 exists then add tag 16862
         --->

         <cfif structKeyExists(theData3.Params[1][1],'_HabitsSurveysComplete') AND theData3.Params[1][1]['_HabitsSurveysComplete'] EQ 'Y'> 
          
            <cfset selectedFieldStruct =structNew()>
            <cfset selectedFieldStruct["Id"]=memberID>

            <cfset selectedFieldsArray = ArrayNew(1)>
            <cfset selectedFieldsArray[1] = "Groups">
            <cfset selectedFieldsArray[2] = "Id">

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

            <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

            <cfinvoke component="utilities/XML-RPC"
                method="XMLRPC2CFML"
                data="#myResult3.Filecontent#"
                returnvariable="theData3">

            <cfset memberTags =  theData3.Params[1][1]['Groups']>
                <!--- Scenario #1
                If HabitsSurveysComplete is “Y” AND tag 16874 and tag 16876 exists then add tag 16692--->

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
                    
                    
                    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult2">
                        <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
                    </cfhttp>

                </cfif>

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
                    
                    
                    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult2">
                        <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
                    </cfhttp>
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
                    
                    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult2">
                        <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
                    </cfhttp>

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

                    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
                        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
                    </cfhttp>


                 </cfif>

        </cfif>
         

         <p>
            Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
            If not, please contact your Coach Concierge for assistance. Thank you!
        </p>

         


