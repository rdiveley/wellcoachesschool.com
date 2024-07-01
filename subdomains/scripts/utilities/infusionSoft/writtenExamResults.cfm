<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />

<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">

<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.student_email>
<cfset myArray[4]=selectedFieldsArray>

<cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC" data="#myArray#" returnvariable="myPackage">

<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
     <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
     <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>

<cfinvoke component="utilities/XML-RPC" method="XMLRPC2CFML"  data="#myResult.Filecontent#"  returnvariable="theData">

   <cfif arrayLen(theData['params'][1]) EQ 0>
	   <cfoutput>
               We could not find student email: <mark>#url.student_email#</mark> in our system.
               <br />
               Please contact your coach concierge for further assistance.
               <cfabort>
        </cfoutput>
   </cfif>

    <cfparam name="URL.retake" default="No" />

    <cfset memberID = theData['params'][1][1]['Id'] />
     
    <cfparam  name="URL.score" default="0">
    <cfparam  name="URL.uniqueURL" default="0">

    <cfif url.retake EQ 'Yes'>
          
    		<cfset updateField['_WrittenExamRetakeResults']=URL.score />
		<cfset updateField['_VoucherNumber2']=URL.uniqueURL />

    <cfelse>
    		<cfset updateField['_WrittenExamResults']=URL.score>
		<cfset updateField['_VoucherNumber2']=URL.uniqueURL />
    </cfif>


	<cfset myArray = ArrayNew(1)>
     <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
     <cfset myArray[2]=key>
     <cfset myArray[3]='(int)#memberID#'>
     <cfset myArray[4]=updateField>

     <cfinvoke component="utilities/XML-RPC"  method="CFML2XMLRPC"  data="#myArray#" returnvariable="myPackage4">

     <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>


<cfoutput>
	<!--- <cflocation url="http://www.wellcoachesschool.com/utilities/infusionsoft/writtenExamThankyou.cfm"> --->
	<form action="writtenExamThankyou.cfm" method="post" name="theForm" id="theForm">
	<input type="hidden" name="email" value="<cfoutput>#URL.student_email#</cfoutput>">
	<input type="hidden" name="score" value="<cfoutput>#URL.score#</cfoutput>">
	</form>
<script>
document.theForm.submit();
</script>
</cfoutput>
