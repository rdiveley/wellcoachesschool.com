<cftry>
	<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
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

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData2">

		<cfset memberID =  theData2.Params[1][1]['Id']>

        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["Id"]=memberID>

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "_HWCTFeedbackSurveysComplete3">
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

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult3">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData">

        <cfparam name="theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']" default=" ">

        <cfset updateList = theData.Params[1][1]['_HWCTFeedbackSurveysComplete3']>

        <cfset updateList = listAppend(updateList,URL.Lesson,"^")>
        <cfset updateList = listRemoveDuplicates(updateList,'^') />

        <cfif !FindNoCase('Y',updateList)>
			<cfset newList = {} />

            <cfloop list="#updateList#" index="i" delimiters="^">
            	<cfset newList[i] = i />
            </cfloop>
<!--- CFDUMP: Debugging by rdiveley --->
<cfdump var="#updateList#" abort="true" format="html" output="" top="3">

            <cfset updateList = structKeyList(newlist) />
            <cfset updateList = replace(updateList,",","^","all") />
            <cfset updateList = 'Y' />
            <!--- <cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" /> --->
            <cfset updateField = structNew()>
            <cfset updateField['_HWCTFeedbackSurveysComplete3']=Replace(updateList.trim(),",","^","all")>

            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
            <cfset myArray[2]=key>
            <cfset myArray[3]='(int)#memberID#'>
            <cfset myArray[4]=updateField>



            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage4">

           <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
            </cfhttp>
        <cfelse>
        	<!---Y is in the list
			<cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" />--->
        </cfif>
		<cfcatch type="any">
			<cfmail to="rdiveley@wellcoaches.com" from="wellcoaches@wellcoaches.com" subject="Error in SG submissions">

            <h1>Other Error: #cfcatch.Type#</h1>
            <ul>
                <li><b>Message:</b> #cfcatch.Message#
                <li><b>Detail:</b> #cfcatch.Detail#
				<li><cfdump var="#url#"></li>
            </ul>

			</cfmail>

		</cfcatch>
</cftry>

         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


