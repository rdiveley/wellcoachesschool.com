	<cfset showTally ="1622,1630">
    <cfset addTally = "1716,1714,1712,1710,1706,1158,1152,1136,1082,838">

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
       
       <cfoutput>
       <cfset show = 0>
       <cfset addSurveyTally = 0>
       <cfloop list="#showTally#" index="i">
       	<cfif Find(i,memberTags)>
        	<cfset show = 1>
        </cfif>    
       </cfloop>
      
       <cfloop list="#addTally#" index="x">
       	<cfif Find(x,memberTags)>
        	<cfset addSurveyTally = 1>
        </cfif>    
       </cfloop>
       
      
	   </cfoutput>
      
       
      
     