

<cfscript>
    _payload = "{}";  
    if (structKeyExists(URL,"payload")) {  
        // Get payload from GET Request
        _payload = URL.payload;
    } else if (structKeyExists(FORM,"payload")) {
        // Get payload from POST Request
        _payload = FORM.payload;
    } else {
        // Get payload from the Body of the Request
        _payload = getHttpRequestData().content;
    }
    // now turn our payload into a structure 
    local.requestpayload = deserializeJSON(_payload);  


</cfscript>
<!---

 <cfset local.requestpayload.user.email = 'rdiveley@gmail.com' />
<cfset local.requestpayload.courseName = 'Core Coach Training: Module 2' />
<cfset local.requestpayload.percentage = '98' />
<cfset local.requestpayload.header.webhookId = '6498208' />
<cfset local.requestpayload.examName = 'a. Organize Your Mind Assessment' />
<cfset local.requestpayload.passPercentage = '80' />
<cfset local.requestpayload.courseid = '416952' />
<cfset local.requestpayload.attemptstaken = '1' />
<cfset local.requestpayload.status = 'pass' />
<cfset local.requestpayload.header.lastAttemptAt = '2019' />--->

<cfparam name="local.requestpayload.user.email" default="" />
<cfparam name="local.requestpayload.courseName" default="" />
<cfparam name="local.requestpayload.percentage" default="" />
<cfparam name="local.requestpayload.header.webhookId" default="" />
<cfparam name="local.requestpayload.examName" default="" />
<cfparam name="local.requestpayload.passPercentage" default="" />
<cfparam name="local.requestpayload.courseid" default=""/>
<cfparam name="local.requestpayload.attemptstaken" default="" />
<cfparam name="local.requestpayload.status" default="" />
<cfparam name="local.requestpayload.header.lastAttemptAt" default="" />


    <cfquery name="local.insertLU">
        insert into [wellcoachesSchool].[dbo].[learnuponwebhook]
        (   emailaddress
            ,coursename
            ,courseId
            ,exampercentage
            ,webhookid
            ,examName
            ,passPercentage
            ,attemptsTaken
            ,examstatus
            ,lastAttemptAt
        )
        values
        (
            '#local.requestpayload.user.email#'
            ,'#local.requestpayload.courseName#'
            ,'#local.requestpayload.courseId#'
            ,'#local.requestpayload.percentage#'
            ,'#local.requestpayload.header.webhookId#'
            ,'#local.requestpayload.examName#'
            ,'#local.requestpayload.passPercentage#'
            ,'#local.requestpayload.attemptsTaken#'
            ,'#local.requestpayload.status#'
            ,'#local.requestpayload.header.lastAttemptAt#'
        )

    </cfquery>

<cfquery name="local.Update_mod1kadata">

    SELECT  count(distinct examName)
    FROM learnuponwebhook
    where courseID = 416952
    AND (
            examName like '%Residential Day 1' 
            OR examName like '%Residential Day 2'
            OR examName like '%Residential Day 3'
            OR examName like '%Residential Day 4'
        )
    and emailaddress = '#local.requestpayload.user.email#'
    and exampercentage >=80 
    group by emailaddress

 </cfquery> 

 
<cfquery name="local.Update_ModTwoKAData">

    SELECT  count(distinct examName)
    FROM learnuponwebhook
    where courseID = 371386
    AND  (
            examName = 'a. Organize Your Mind Assessment' 
            OR examName = 'a. Wellness Visions Assessment'
            OR examName = 'a. Organize Your Emotions Assessment'
            OR examName = 'b. Generative Moments Assessment'
        )
    
    and emailaddress = '#local.requestpayload.user.email#'
    and exampercentage >=80 
    group by emailaddress

 </cfquery> 



<cfquery name="local.Update_lmkascore">

    SELECT count(distinct examName)
    FROM learnuponwebhook
    where courseID = 355450
        AND (
        examName like '%LIfestyle Medicine Part 1%' 
        OR examName like '%LIfestyle Medicine Part 2%'
        OR examName like '%LIfestyle Medicine Part 3%'
        OR examName like '%LIfestyle Medicine Part 4%'
        OR examName like '%LIfestyle Medicine Part 5%')
    
    and emailaddress = '#local.requestpayload.user.email#'
    and exampercentage >=80 
    group by emailaddress

 </cfquery> 

<cfquery name="local.Update_ModOneKAData">

    SELECT  count(distinct examName)
    FROM learnuponwebhook
    where (
        examName like '%1-4' 
        OR examName like '%5-7'
        OR examName like '%8-11'
        OR examName like '%12-16'
        OR examName like '%17-18'
        )
	
    and emailaddress = '#local.requestpayload.user.email#'
    and exampercentage >=80 
    group by emailaddress

 </cfquery> 


    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">

    <cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Id">
    <cfset selectedFieldsArray[2] = "FirstName">
    <cfset selectedFieldsArray[3] = "LastName">

    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='#local.requestpayload.user.email#'>
    <cfset myArray[4]=selectedFieldsArray>

    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage">

    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>

    <cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML"  data="#myResult.Filecontent#"  returnvariable="theData">

    <cfset memberID = theData['params'][1][1]['Id'] />

<!--- start updating LU --->
    <cfif local.Update_mod1kadata.recordcount GTE 4>
    
        <cfset updateField['_Mod1KAData']= 'Y' />
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#memberID#'>
        <cfset myArray[4]=updateField>

        <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

 </cfif>

 <cfif local.Update_ModTwoKAData.recordcount GTE 4>
    
    <cfset updateField['_Mod2KAData']= 'Y' />
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='(int)#memberID#'>
    <cfset myArray[4]=updateField>

    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

</cfif>

 <cfif local.Update_lmkascore.recordcount GTE 5>
    
        <cfset updateField['_LMKAScore']= 'Y' />
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#memberID#'>
        <cfset myArray[4]=updateField>

        <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

 </cfif>

 <cfif local.Update_ModOneKAData.recordcount GTE 5>
    
    <cfset updateField['_Mod1KAData']= 'Y' />
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
    <cfset myArray[2]=key>
    <cfset myArray[3]='(int)#memberID#'>
    <cfset myArray[4]=updateField>

    <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>

</cfif>