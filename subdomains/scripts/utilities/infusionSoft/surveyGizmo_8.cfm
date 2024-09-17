
<cfoutput>

<cfif isDefined('url.debug') and url.debug EQ 1>
	<cfdump var="#URL#">
</cfif>

<cfparam name="URL.lesson" default="">
<cfparam name="URL.cohort" default="">
<cfparam name="URL.faculty_member" default="">
<cfparam name="URL.coachingSkills" default="">
<cfparam name="URL.faculty" default="">
<cfparam name="URL.VALUABLE" default="">
<cfparam name="URL.lessonObj" default="">
<cfparam name="URL.summarize" default="">
<cfparam name="URL.aware" default="">
<cfparam name="URL.live" default="">
<cfset DSN = "wellcoachesSchool">


<cfif structKeyExists(url,'email')>
    <cfset local.email = url.email />
</cfif>

<cfif structKeyExists(url,'lesson')>
    <cfset local.lesson = url.lesson />
</cfif>

<cfif structKeyExists(url, 'emailForm')>
    <cfset local.email = url.emailForm />
</cfif>


<!---<cfset lesson = URLEncodedFormat(URL.lesson)>
<cfset uniqueFileName = "#local.email#_#URLEncodedFormat(lesson)#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">
<cfset copyFaculty = "#URL.faculty_member#_#URLEncodedFormat(lesson)#_#local.email#_#dateFormat(now(),'mm-dd-yyyy')#.pdf">

--->


<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
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

  <cfparam name="addSurveyTally" default="0">

  <cfinclude template="tallyTag.cfm">



        <cflocation url="completedHours.cfm?email=#local.email#&lesson=#local.lesson#"   >

        <cfabort>


</cfoutput>

