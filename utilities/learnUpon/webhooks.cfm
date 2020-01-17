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

<!--- <cfset local.requestpayload.user.email = 'rdiveley@gmail.com' />
<cfset local.requestpayload.courseName = 'Core Coach Training: Module 2' />
<cfset local.requestpayload.percentage = '98' />
<cfset local.requestpayload.header.webhookId = '6498208' />
<cfset local.requestpayload.examName = 'a. Organize Your Mind Assessment' />
<cfset local.requestpayload.passPercentage = '80' /> --->


    <cfquery name="local.insertLU">
        insert into [wellcoachesSchool].[dbo].[learnuponwebhook]
        (   emailaddress
            ,coursename
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
            ,'#local.requestpayload.percentage#'
            ,'#local.requestpayload.header.webhookId#'
            ,'#local.requestpayload.examName#'
            ,'#local.requestpayload.passPercentage#'
            ,'#local.requestpayload.attemptsTaken#'
            ,'#local.requestpayload.status#'
            ,'#local.requestpayload.header.lastAttemptAt#'
        )

    </cfquery>



