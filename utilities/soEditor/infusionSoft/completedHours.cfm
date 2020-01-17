	<cfset key = "74e097c5980ebb52ebfae71b0e575154">
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
        
        <cfset updateList = listAppend(updateList,URL.Lesson,",")>
        
        <cfif !FindNoCase('Y',updateList)>
			<cfset newlist = [] />
            
            <cfloop list="#updateList#" index="i">
                <cfif NOT arrayFind(newlist,trim(i))> 
                    <cfset arrayAppend(newlist,trim(i))>
                </cfif>
            </cfloop>
            
            <cfset updateList = arraytolist(newlist) />
            
            <cfif listLen(updateList) GTE 18>
                 <cfset updateList = 'Y' />
                 <cfmodule template="applyHWCTComplete.cfm" memberID="#memberID#" /> 
            </cfif>
                
            <cfset updateField = structNew()>
            <cfset updateField['_HWCTFeedbackSurveysComplete3']=updateList.trim()>
            
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
       
        
        <p>Thank you! Please check the "Completed Survey" tab right away to verify that the survey has been saved and uploaded to your file. 
           If not, please contact your Coach Concierge for assistance. Thank you!
        </p>
      
      
     