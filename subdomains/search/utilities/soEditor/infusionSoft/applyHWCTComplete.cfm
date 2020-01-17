<cfif NOT IsDefined("thisTag.executionMode")>
	Must be called as customtag.<cfabort>
</cfif>

<cfparam name="attributes.memberID" type="numeric" default="0" />

<cfoutput>
<cfif thisTag.executionMode is "start" >

	<cfset selectedFieldsArray = ArrayNew(1)>
    <cfset selectedFieldsArray[1] = "Groups">
    
    
    <cfset myArray = ArrayNew(1)>
    <cfset myArray[1]="ContactService.load"><!---Service.method always first param--->
    <cfset myArray[2]="74e097c5980ebb52ebfae71b0e575154">
    <cfset myArray[3]='(int)#attributes.memberID#'>
    <cfset myArray[4]=selectedFieldsArray>
    
    <cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage4">  
    
    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="result">
        <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
    </cfhttp>
    
    <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#result.Filecontent#"
            returnvariable="theData">
   <cfset tagList =  theData.Params[1]['Groups'] />
      
   <cfset HWCT_Sep2013 = 0 />  
   <cfset HWCT_Sep2013_trained = 0 /> 
   
   <cfset HWCT_Sep2013 = listFind(tagList,2475)/>
   <cfset HWCT_Sep2013_trained = listFind(tagList,3082)/>
   
   <cfif HWCT_Sep2013 OR HWCT_Sep2013_trained>
		
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]="74e097c5980ebb52ebfae71b0e575154">
        <cfset myArray[3]="(int)#attributes.memberID#">
        <cfset myArray[4]="(int)2647">
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
        
        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
   
   </cfif>
   
	 
</cfif>

</cfoutput>

