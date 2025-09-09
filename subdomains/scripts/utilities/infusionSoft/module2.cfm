	<cfparam  name="URL.Lesson" default="">
    
    
    <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">
    <cfset selectedFieldsArray[4] = "_Module2SurveysComplete">
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


        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
			<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
			<cfhttpparam type="XML" value="#myPackage.Trim()#"/>
		</cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData">

        <cfset memberID =  theData.Params[1][1]['Id']>
        
        <cfif !ArrayLen(theData.Params[1])>
            There is no user with that email address in our records. <cfabort>
        </cfif>

        <cfparam name="theData.Params[1][1]['_Module2SurveysComplete']" default=" ">
        <cfset updateList = theData.Params[1][1]['_Module2SurveysComplete']>

        <cfif updateList NEQ "Y">
			<cfset updateList = trim(listAppend(updateList,URL.Lesson,"^"))>
			<cfset updateField = structNew()>
	        <cfset updateField['_Module2SurveysComplete']=Replace(updateList.trim(),",","^","all")>
        </cfif>
        
        <cfset updateList = listRemoveDuplicates(updateList,'^') />

        <!---if the user comes after Sept 2025 look for 7 surveys not 8 --->
        <cfset local.completedSurveys = 4 />
        <cfif listFindNoCase(memberTags, 23502) AND listFindNoCase(memberTags,9833) AND listFindNoCase(memberTags, 23500)>
            <cfset local.completedSurveys = 7 />
        <cfelseif listFindNoCase(memberTags, 23502) AND listFindNoCase(memberTags, 23740)>
             <cfset local.completedSurveys = 3 />
        </cfif>

        <cfif listLen(updateList,'^') GTE local.completedSurveys OR updateList EQ 'Y'>
          	<cfset updateField = structNew()>
          	<cfset updateField['_Module2SurveysComplete']="Y">

            <cfset memberTags =  theData.Params[1][1]['Groups']>
            <!--- 16878 is mod 1 all steps completed--->
            <cfif listFindNoCase(memberTags,16878)>
                <!--- special April - August students --->
                <cfif !listFindNoCase(memberTags,22718) >
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)16696">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>

                <cfif listFindNoCase(memberTags,22722) AND listFindNoCase(memberTags,9833)>
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)22720">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>
                <!--- sept. forward --->
                <cfif listFindNoCase(memberTags,23502) AND listFindNoCase(memberTags,9833) AND listFindNoCase(memberTags, 23500)>
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)23504">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>

                <cfif !listFindNoCase(memberTags,23500)>
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)16696">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>


                <!--- 16696,9833,22718->22720 
                    If user has tag 16696 and tag 9833 and tag 22718 (which comes from a campagin)
                    give them tag 22720
                    9833: lifestyle medicine mod 4 survey training complete
                    22718: mod 2 april - august
                --->
                <cfif listFindNoCase(memberTags,9833) AND listFindNoCase(memberTags,22718)>
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)22720">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>

                <cfif listFindNoCase(memberTags,9833) AND listFindNoCase(memberTags,23500)>
                    <cfset myArray = ArrayNew(1)>
                    <cfset myArray[1]="ContactService.addToGroup">
                    <cfset myArray[2]=key>
                    <cfset myArray[3]="(int)#memberID#">
                    <cfset myArray[4]="(int)253504">

                    <cfinvoke component="utilities/XML-RPC"
                        method="CFML2XMLRPC"
                        data="#myArray#"
                        returnvariable="myPackage">

                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                    </cfhttp>
                </cfif>

                
            <cfelseif listFindNoCase(memberTags,9987)>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]=key>
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)9615"><!---9615 is mod 2 stand alone survey complete --->

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">


                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
            
            <cfelseif listFindNoCase(memberTags,23740) AND listFindNoCase(memberTags, "23502")>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]=key>
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)23734"><!--- mod 2 plus stand alone surveys complete --->

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">


                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
                
            <cfelseif listFindNoCase(memberTags,21348)>
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]=key>
                <cfset myArray[3]="(int)#memberID#">
                <cfset myArray[4]="(int)17646"><!--- dedicated Humber group --->

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
            </cfif>

	  		<!--- <cfmodule template="applyModule2Complete.cfm" memberID="#memberID#" /> --->
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


          <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result">
			<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
			<cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
		</cfhttp>

         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


