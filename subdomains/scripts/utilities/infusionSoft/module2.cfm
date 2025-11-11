<cfparam  name="URL.Lesson" default="">
<cfparam  name="URL.email" default="">

<cftry>
    <!--- Validate required parameters --->
    <cfif !len(trim(URL.email))>
        <cfthrow type="ValidationError" message="Email parameter is required">
    </cfif>

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

    <!--- Make initial contact lookup with retry logic --->
    <cfset maxRetries = 3>
    <cfset retryDelay = 2000>
    <cfset success = false>
    <cfset attempt = 0>

    <cfloop condition="attempt LT maxRetries AND !success">
        <cfset attempt = attempt + 1>
        <cftry>
            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1" timeout="30">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

            <cfif structKeyExists(myResult1, "statusCode") AND left(myResult1.statusCode, 1) EQ "2">
                <cfset success = true>
            <cfelse>
                <cfif attempt LT maxRetries>
                    <cfset sleep(retryDelay)>
                </cfif>
            </cfif>

            <cfcatch type="any">
                <cfif attempt LT maxRetries>
                    <cfset sleep(retryDelay)>
                </cfif>
            </cfcatch>
        </cftry>
    </cfloop>

    <!--- Check if initial lookup succeeded --->
    <cfif !success OR !structKeyExists(myResult1, "statusCode") OR left(myResult1.statusCode, 1) NEQ "2">
        <cfthrow type="APIError" message="Initial contact lookup failed after #maxRetries# retries" detail="Email: #URL.email#">
    </cfif>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData">

        <cfset memberID =  theData.Params[1][1]['Id']>
        <cfset memberTags =  theData.Params[1][1]['Groups']>

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

                    <!--- Retry logic for this API call --->
                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 16696" detail="After #maxRetries# retries">
                    </cfif>
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

                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 22720" detail="After #maxRetries# retries">
                    </cfif>
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

                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 23504" detail="After #maxRetries# retries">
                    </cfif>
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

                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 16696 (second)" detail="After #maxRetries# retries">
                    </cfif>
                </cfif>


                <!--- 16696,9833,22718->22720 --->
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

                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 22720 (alt)" detail="After #maxRetries# retries">
                    </cfif>
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

                    <cfset success = false>
                    <cfset attempt = 0>
                    <cfloop condition="attempt LT maxRetries AND !success">
                        <cfset attempt = attempt + 1>
                        <cftry>
                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>
                            <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                                <cfset success = true>
                            <cfelse>
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfif>
                            <cfcatch type="any">
                                <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                            </cfcatch>
                        </cftry>
                    </cfloop>
                    <cfif !success>
                        <cfthrow type="APIError" message="Failed to add to group 253504" detail="After #maxRetries# retries">
                    </cfif>
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

                <cfset success = false>
                <cfset attempt = 0>
                <cfloop condition="attempt LT maxRetries AND !success">
                    <cfset attempt = attempt + 1>
                    <cftry>
                        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                        </cfhttp>
                        <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                            <cfset success = true>
                        <cfelse>
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfif>
                        <cfcatch type="any">
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfcatch>
                    </cftry>
                </cfloop>
                <cfif !success>
                    <cfthrow type="APIError" message="Failed to add to group 9615" detail="After #maxRetries# retries">
                </cfif>

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

                <cfset success = false>
                <cfset attempt = 0>
                <cfloop condition="attempt LT maxRetries AND !success">
                    <cfset attempt = attempt + 1>
                    <cftry>
                        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                        </cfhttp>
                        <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                            <cfset success = true>
                        <cfelse>
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfif>
                        <cfcatch type="any">
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfcatch>
                    </cftry>
                </cfloop>
                <cfif !success>
                    <cfthrow type="APIError" message="Failed to add to group 23734" detail="After #maxRetries# retries">
                </cfif>

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

                <cfset success = false>
                <cfset attempt = 0>
                <cfloop condition="attempt LT maxRetries AND !success">
                    <cfset attempt = attempt + 1>
                    <cftry>
                        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult" timeout="30">
                            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                        </cfhttp>
                        <cfif structKeyExists(myResult, "statusCode") AND left(myResult.statusCode, 1) EQ "2">
                            <cfset success = true>
                        <cfelse>
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfif>
                        <cfcatch type="any">
                            <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                        </cfcatch>
                    </cftry>
                </cfloop>
                <cfif !success>
                    <cfthrow type="APIError" message="Failed to add to group 17646" detail="After #maxRetries# retries">
                </cfif>
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

         <!--- Final update with retry logic --->
         <cfset success = false>
         <cfset attempt = 0>
         <cfloop condition="attempt LT maxRetries AND !success">
             <cfset attempt = attempt + 1>
             <cftry>
                 <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result" timeout="30">
                     <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                     <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
                 </cfhttp>
                 <cfif structKeyExists(result, "statusCode") AND left(result.statusCode, 1) EQ "2">
                     <cfset success = true>
                 <cfelse>
                     <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                 </cfif>
                 <cfcatch type="any">
                     <cfif attempt LT maxRetries><cfset sleep(retryDelay)></cfif>
                 </cfcatch>
             </cftry>
         </cfloop>

         <cfif !success>
             <cfthrow type="APIError" message="Failed to update contact" detail="After #maxRetries# retries">
         </cfif>

         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>

<cfcatch type="any">
    <!--- Log error details --->
    <cfset errorDetails = structNew()>
    <cfset errorDetails.type = cfcatch.type>
    <cfset errorDetails.message = cfcatch.message>
    <cfset errorDetails.detail = cfcatch.detail>
    <cfset errorDetails.email = URL.email>
    <cfset errorDetails.lesson = URL.Lesson>
    <cfset errorDetails.timestamp = now()>
    <cfif isDefined("memberID")>
        <cfset errorDetails.memberID = memberID>
    </cfif>

    <!--- Send error notification email --->
    <cfmail to="rdiveley@wellcoaches.com"
            from="noreply@wellcoaches.com"
            subject="Module 2 Survey Processing Error"
            type="html">
        <h2>Error in Module 2 Survey Processing</h2>
        <p><strong>Time:</strong> #dateFormat(errorDetails.timestamp, "mm/dd/yyyy")# #timeFormat(errorDetails.timestamp, "hh:mm:ss tt")#</p>
        <p><strong>Error Type:</strong> #errorDetails.type#</p>
        <p><strong>Error Message:</strong> #errorDetails.message#</p>
        <p><strong>Error Detail:</strong> #errorDetails.detail#</p>
        <hr>
        <h3>Request Details:</h3>
        <p><strong>Email:</strong> #errorDetails.email#</p>
        <p><strong>Lesson:</strong> #errorDetails.lesson#</p>
        <cfif isDefined("errorDetails.memberID")>
            <p><strong>Member ID:</strong> #errorDetails.memberID#</p>
        </cfif>
        <hr>
        <h3>Stack Trace:</h3>
        <pre>#cfcatch.stackTrace#</pre>
    </cfmail>

    <!--- Display user-friendly error message --->
    <cfoutput>
        <h3>We're sorry, but there was an error processing your survey.</h3>
        <p>Our team has been notified and will investigate this issue. Please contact your Coach Concierge at rdiveley@wellcoaches.com for assistance.</p>
        <p>Error Reference: #dateFormat(now(), "mm/dd/yyyy")# #timeFormat(now(), "hh:mm:ss tt")#</p>
    </cfoutput>
</cfcatch>
</cftry>
