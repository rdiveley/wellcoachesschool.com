<!-- Core Coach Training - 18-week program - Lesson Feedback Survey	 -->
<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset selectedFieldsArray[4] = "_HWCTFeedbackSurveysComplete3">
    <cfset selectedFieldsArray[5] = "Groups">
    
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

		<cfset memberID =  theData.Params[1][1]['Id']>

        <cfparam name="theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']" default=" ">
        <cfparam name="URL.Lesson" default="">

        <cfset updateList = theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']>

        <cfset updateList = listAppend(updateList,URL.Lesson,"^")>

        <cfif !FindNoCase('Y',updateList)> 

		    <cfset newList = {} />

            <cfloop list="#updateList#" index="i" delimiters="^">
                <cfset i = int(i) />
            	<cfset newList[i] = int(i) />
            </cfloop>

            <cfset updateList = structKeyList(newlist) />
            <cfset updateList = listRemoveDuplicates(updateList) />
            <cfset updateList = listSort(updateList, "numeric") />
            <cfset memberTags =  theData.Params[1][1]['Groups']>


            <cfif listLen(updateList) GTE 18>
            	<cfset updateList = 'Y' />

                <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
                <cfset myArray2 = ArrayNew(1)>
                <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                <cfset myArray2[2]=key>
                <cfset myArray2[3]="(int)#memberID#">
                <cfset myArray2[4]="(int)16874">
            
                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray2#"
                    returnvariable="myPackage2">

                 <cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
                    arguments = '-X POST https://my982.infusionsoft.com/api/xmlrpc -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage2.Trim()#'
                    variable="myResult2"
                    timeout = "200">
                </cfexecute>
                

                <cfif structKeyExists(theData.Params[1][1], '_HabitsSurveysComplete') AND theData.Params[1][1]['_HabitsSurveysComplete'] EQ 'Y'>

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

                 
            </cfif>

            <cfif updateList NEQ "Y">
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']=Replace(updateList.trim(),",","^","all")>
      
            <cfelse>
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']="Y">

			   <!-- 9781 [Core 18-Week Teleclass [Jul2018 Fwd] -->
			   <cfif listFindNoCase(memberTags,9781) and listFindNoCase(memberTags,9531) AND listFindNoCase(memberTags,9553) >
					<cfset local.hasInviteToMod3 = true>
			   <cfelse>
			   		<cfset local.hasInviteToMod3 = false>
			   </cfif>

			   <!-- IF 9781 is in place [Core 18-Week Teleclass [Jul2018 Fwd] � generic statement Ray will use to make a �query� BEFORE applying any of the following program specific tags]
					THEN 9557 can be applied [Core Jul2018 Mod 1 Lesson Surveys Complete] -->
			   <cfif local.hasInviteToMod3>
			   		<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
					<cfset myArray = ArrayNew(1)>
					<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
					<cfset myArray[2]=key>
					<cfset myArray[3]="(int)#memberID#">
					<cfset myArray[4]="(int)9557">

					<cfinvoke component="utilities/XML-RPC"
						method="CFML2XMLRPC"
						data="#myArray#"
						returnvariable="myPackage">
				

					<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
						<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
					</cfhttp>
			   </cfif>


            </cfif>
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

        <!<cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#" />


        <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


