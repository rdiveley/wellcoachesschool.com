	<cfparam name="URL.email" default="">
	
	
	
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
    
 

    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
        <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
        <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
    </cfhttp>
    
    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult.Filecontent#"
        returnvariable="theData">		
		
		<cfif URL.location contains '2013'>
        	<cfset IStag = 2889 />
        <cfelseif URL.location contains '2014'>
         	<cfset IStag = 2891 /> 
        <cfelseif URL.location contains '2015'>
         	<cfset IStag = 2893 />
        <cfelseif URL.location contains '2016'>
         	<cfset IStag = 2895 />
        <cfelseif URL.location contains '2017'>
         	<cfset IStag = 2897 />
        <cfelseif URL.location contains '2018'>
         	<cfset IStag = 2899 />
        <cfelse>
        	<cfset IStag = 2889 />     
        </cfif>
        
        
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#theData.Params[1][1]['Id']#">
        <cfset myArray[4]="(int)#IStag#">


        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
        <cfif isDefined("myResult")>
         	<cflocation url="thankyou.cfm">
         </cfif> 
         <cfabort>