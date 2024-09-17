<cfoutput>

<cfif structKeyExists(url,'email')>
    <cfset local.email = url.email />
</cfif>

<cfif structKeyExists(url,'lesson')>
    <cfset local.lesson = url.lesson />
</cfif>

<cfif structKeyExists(url, 'emailForm')>
    <cfset local.email = url.emailForm />
</cfif>


<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset selectedFieldsArray[4] = "_HWCTFeedbackSurveysComplete3">
<cfset selectedFieldsArray[5] = "_HabitsSurveysComplete">
<cfset selectedFieldsArray[6] = "Groups">
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
        arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/v1/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
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

		<cfset memberID =  theData.Params[1][1]['Id']>
        <cfset memberTags =  theData.Params[1][1]['Groups']>


<cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/4051290/surveyresponse">

<cfset emailParam = "[question(93)]" />	
<cfset local.params = "filter[field][0]=#urlEncodedFormat(emailParam)#&filter[operator][0]=in&filter[value][0]=#trim(urlEncodedFormat(url.email))#&filter[field][1]=status&filter[operator][1]==&filter[value][1]=complete&resultsperpage=500" />

<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
        arguments = '-G -k #SGurl#?api_token=b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca -d #local.params#'
        variable="local.myResult"
        timeout = "200">
</cfexecute>

<cfset jsonData = deserializeJSON(local.myResult) />

<cfset local.updateList = "" />
<cfset local.newList = "" />

<cfloop array="#jsonData.data#" index="local.field">
    <cfset local.updateList = arrayToList(rematch("[\d]+",local.field['[question(89)]']))>
    <cfset local.newList = listAppend(local.newList,local.updateList) />
</cfloop>

<cfset local.newList = listChangeDelims(listRemoveDuplicates(local.newList),"^") />
<cfset local.updateList = "" />

<cfif local.newList NEQ 'Y' AND listLen(local.newList, "^") LT 8 AND local.newList NEQ 'STANDALONE'> 

    <cfset updateField = structNew()>
    <cfset updateField['_HabitsSurveysComplete']=local.newList>
    
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='(int)#memberID#'>
    <cfset myArray[4]=updateField>
    
    <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage4">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

</cfif>
<cfif structKeyExists(theData.Params[1][1],'_HWCTFeedbackSurveysComplete3') AND theData.Params[1][1]['_HWCTFeedbackSurveysComplete3'] EQ 'Y'>

    
    <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
    <cfset myArray2 = ArrayNew(1)>
    <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
    <cfset myArray2[2]=key>
    <cfset myArray2[3]="(int)#memberID#">
    <cfset myArray2[4]="(int)16874">

    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray2#"
        returnvariable="myPackage2">


    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
		<cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
    </cfhttp>

</cfif>

<cfif listLen(local.newList,"^") GTE 8>
    <!---Scenario #2
        If HabitsSurveysComplete is "Y" AND tag 18680 exists then add tag 16862
    --->
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

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

        
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
        <cfset myArray2 = ArrayNew(1)>
        <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray2[2]=key>
        <cfset myArray2[3]="(int)#memberID#">
        <cfset myArray2[4]="(int)16876">
    
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray2#"
            returnvariable="myPackage2">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
        </cfhttp>

    <cfif listFindNoCase(memberTags, 18680) >

        
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
        <cfset myArray2 = ArrayNew(1)>
        <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray2[2]=key>
        <cfset myArray2[3]="(int)#memberID#">
        <cfset myArray2[4]="(int)18682">
    
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray2#"
            returnvariable="myPackage2">
        
        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
        </cfhttp>

    </cfif>

    <!--- Scenario #3
        If _HabitsSurveysComplete has 8 surveys or "Y”, AND the record has tag 18680 OR tag 18684, 
        then add tag 18682 AND enter “STANDALONE” to _HabitsSurveysComplete --->

    <cfif listFindNoCase(memberTags,18680) OR listFindNoCase(memberTags,18684)>

        
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
        <cfset myArray2 = ArrayNew(1)>
        <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray2[2]=key>
        <cfset myArray2[3]="(int)#memberID#">
        <cfset myArray2[4]="(int)18682">
    
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray2#"
            returnvariable="myPackage2">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
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

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

        </cfif>

</cfif>



<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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

            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>


        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult1.Filecontent#"
            returnvariable="theData">

        <cfset memberTags =  theData.Params[1][1]['Groups']>

        <cfif listFindNoCase(memberTags, 16874) AND listFindNoCase(memberTags, 16876)>

                
                <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
                <cfset myArray2 = ArrayNew(1)>
                <cfset myArray2[1]="ContactService.addToGroup"><!---Service.method always first param--->
                <cfset myArray2[2]=key>
                <cfset myArray2[3]="(int)#memberID#">
                <cfset myArray2[4]="(int)16692">
            
                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray2#"
                    returnvariable="myPackage2">
                
                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult2">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage2.Trim()#"/>
                </cfhttp>

            </cfif>

         <p>
            Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
            If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


</cfoutput>