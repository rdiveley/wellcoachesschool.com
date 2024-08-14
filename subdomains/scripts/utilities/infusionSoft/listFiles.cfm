<cfparam name="URL.email" default="rdiveley@wellcoaches.com">


<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Id">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.email>
<cfset myArray[4]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">


<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>

<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">


    <cfset memberID =  theData.Params[1][1]['Id']>


<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "OwnerID">


<cfset selectedFieldStruct =structNew()>
<cfset selectedFieldStruct["Id"]='(int)50132'>

<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="DataService.query"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]='User'>
<cfset myArray[4]='(int)100'>
<cfset myArray[5]='(int)0'>
<cfset myArray[6]=selectedFieldStruct>
<cfset myArray[7]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
    method="CFML2XMLRPC"
    data="#myArray#"
    returnvariable="myPackage">



<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>


<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">
  <cfdump var="#theData#"><cfabort>
    <cfloop from="1" to="#arrayLen(theData.Params[1])#" index="key">
    	<cfoutput>
       	<a href="https://my982.infusionsoft.com/Download?Id=#theData.Params[1][key]['Id']#&returnTo=http://my982.infusionsoft.com/Contact/manageContact.jsp?view=edit&lists_sel=files">#theData.Params[1][key]['FileName']#</a><br>
   		</cfoutput>
    </cfloop>
