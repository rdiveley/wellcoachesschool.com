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


        

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult1">
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


        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult3">
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


        <cfif !FindNoCase('Y',updateList)>

		  <cfset newList = {} />

            <cfloop list="#updateList#" index="i" delimiters="^">
            	<cfset newList[i] = i />
            </cfloop>

            <cfset updateList = structKeyList(newlist) />


            <cfif listLen(updateList) GTE 18>
            	<!--- <cfmail type="html" from="support@wellcoaches.com" to="mthom@wellcoaches.com" cc="rdiveley@wellcoaches.com" subject="completed surveys">
                 	<cfoutput>
                    	User: #URL.email# has just completed all of their surveys. <br />
                        We are updating their custom field to 'Y'.<br />
                        Here is the list of surveys before the update: #updateList#

               		</cfoutput>
                 </cfmail>--->
            	 <cfset updateList = 'Y' />
                 <cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" />
            </cfif>
            <cfif updateList NEQ "Y">
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']=Replace(updateList.trim(),",","^","all")>
            <cfelse>
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']="Y">

				<!-- apply tag 9557 if user has tag 9559
					 apply another tag: 9769-->
				<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
				<cfset myArray = ArrayNew(1)>
				<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
				<cfset myArray[2]=key>
				<cfset myArray[3]="(int)#memberID#">
				<cfset myArray[4]="(int)9557">

				<cfinvoke component="utilities/XML-RPC"
					method="CFML2XMLRPC"
					data="#myArray#"
					returnvariable="myPackage">
				

                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>

				<!-- check to see if user has tag 9559 -->
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

		        

                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult3">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>

		          <cfinvoke component="utilities/XML-RPC"
		            method="XMLRPC2CFML"
		            data="#myResult3.Filecontent#"
		            returnvariable="theData3">

		        <cfset memberTags =  theData3.Params[1][1]['Groups']>

		       <cfset local.foundTag = listFindNoCase(memberTags,9559)>

				<!-- user has both 9559 and 9557, so apply 9769 -->
		       <cfif local.foundTag>
			       <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
					<cfset myArray = ArrayNew(1)>
					<cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
					<cfset myArray[2]=key>
					<cfset myArray[3]="(int)#memberID#">
					<cfset myArray[4]="(int)9769">

					<cfinvoke component="utilities/XML-RPC"
						method="CFML2XMLRPC"
						data="#myArray#"
						returnvariable="myPackage">
					<cfdump var="#myPackage#">

					
                    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
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

           
            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
            </cfhttp>
        <cfelse>
        	<!---Y is in the list--->
			<cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" />
        </cfif>


         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


