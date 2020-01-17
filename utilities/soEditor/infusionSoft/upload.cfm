<cfoutput>
<cfif isDefined("fileUpload")>
	<cfparam name="FORM.fileName" default="">
   
   <!--- <cfset TempfileName = ListGetat(FORM.fileName,3,"\")>--->
	  
      	<cfset TempfileName = "#listlast(FORM.fileName, '\')#">		
   
	  <cffile action="upload"
		 nameconflict="overwrite"
		 fileField="fileUpload"
		 destination="#expandPath('./temp')#">
		
        <cffile action="readbinary" file="#expandPath('./temp/#TempFileName#')#" variable="readFile">
    
	    <cfset key = "74e097c5980ebb52ebfae71b0e575154">
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="FileService.uploadFile"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)50136'>
        <cfset myArray[4]=TempfileName>
        <cfset myArray[5]=ToBase64(readFile)>
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
           
      
        <!--- <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="xml" value="#myPackage.Trim()#">
        </cfhttp> --->
         
         <cfx_http5 url="https://my982.infusionsoft.com/api/xmlrpc" method="POST" body=#myPackage.Trim()# out="myResult"  >
    
    <cfif isDefined("myResult")>
      
        <p>Thankyou, your file #TempfileName# has been uploaded.</p>
       </cfif> 
       <cfabort>
</cfif>

 <script type="text/javascript"> 
		function PassFileName() 
		{ 
			document.form1.fileName.value=document.form1.fileUpload.value; 
		} 
 </script> 
<form name="form1" method="post" enctype="multipart/form-data" onsubmit="PassFileName()" > 
    File: <input type="file" name="fileUpload" id="fileUpload" size="20"/> <br /> 
    <input type="hidden" id="fileName" size="20" name="fileName" /> 
    <input type="submit" name="submit" value="Upload File to your account"> 
</form> 

</cfoutput>

<cfabort>


<cfif FORM.datafile is not "">

<cfset key = "74e097c5980ebb52ebfae71b0e575154">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="FileService.uploadFile"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]='(int)50136'>
<cfset myArray[4]='(string)test.html'>
<cfset myArray[5]='(string)#ToBase64(FORM.datafile)#'>



<cfinvoke component="utilities/XML-RPC"
	method="CFML2XMLRPC"
	data="#myArray#"
    returnvariable="myPackage">
    
    <cfdump var="#myPackage#">
    
    <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
		<cfhttpparam type="xml" value="#myPackage.Trim()#">
	</cfhttp>
    
    <cfdump var="#myResult#">
    
</cfif>    
    
<!---<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
	<cfhttpparam type="xml" value="#myPackage.Trim()#">
</cfhttp>--->


     
 