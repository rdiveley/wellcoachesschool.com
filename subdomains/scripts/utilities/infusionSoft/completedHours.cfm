<!-- Core Coach Training - 18-week program - Lesson Feedback Survey	 -->
<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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


        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult1">
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

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
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
            	 <cfset updateList = 'Y' />
                 <cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" />
            </cfif>

            <cfif updateList NEQ "Y">
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']=Replace(updateList.trim(),",","^","all")>
            <cfelse>
            	<cfset updateField = structNew()>
            	<cfset updateField['_HWCTFeedbackSurveysComplete3']="Y">

				<!-- check to see if user has tag 9781 -->
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

		        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
		            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
		        </cfhttp>

		          <cfinvoke component="utilities/XML-RPC"
		            method="XMLRPC2CFML"
		            data="#myResult3.Filecontent#"
		            returnvariable="theData3">

		        <cfset memberTags =  theData3.Params[1][1]['Groups']>

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

           <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
                <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
            </cfhttp>
        <cfelse>
        	<!---Y is in the list--->
			<cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" />
        </cfif>

        <cfmodule template="allSurveysCompleted.cfm" memberID="#memberID#" />


         <p>Thank you! Please check the "Completed Survey" tab within 10-15 minutes to verify that the survey has been saved and uploaded to your file.
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>


