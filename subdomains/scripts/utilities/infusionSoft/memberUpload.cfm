<cfoutput>
<link rel="stylesheet" type="text/css" href="js/themes/blue/style.css">
<script type="text/javascript" src="js/jquery-latest.js"></script>
<cfparam name="URL.email" default="rdiveley@wellcoaches.com">
<cfparam name="URL.lastname" default="Diveley">
<cfparam name="concierge" default="rdiveley@wellcoaches.com">

		<cfset local.concierge = "lho@wellcoaches.com" />


<cfif structKeyExists(FORM,"fileUpload")>
	 <cfset extension = lcase(listLast(FORM.filename,"."))>
	 <cfset TempfileName = '#URL.email#_#FORM.userFiles#_#dateFormat(now(),'mm-dd-yyyy')#.#extension#'>

     <cfset acceptedMimeType="docx,xlsx,xls,doc,tif,tiff,gif,jpeg,jpg,jif,jfif,jp2,jpx,j2k,j2c,fpx,pcd,png,pdf,ppt,odt">
     <cffile
        action="upload"
        nameconflict="overwrite"
        destination="#expandPath('../../')#utilities\infusionSoft\temp\#TempfileName#"
        filefield="fileUpload">


		<cfif NOT ListFind(acceptedMimeType,lcase(listLast(CFFILE.clientFile,".")))>
            Please only upload files of type: docx, xlsx, xls, doc, pdf <br>
            <cffile
                action="DELETE"
                file="#expandPath('../../')#utilities\infusionSoft\temp\#TempfileName#"/>
            <a href="javascript:history.go(-1)"> &lt;&lt;Back</a>
            <cfabort>
        <cfelseif CFFILE.FileSize GT (5 * 1024 * 1024)>
             This type of file is too large. Please keep your file upload under 5MB<br>
            <a href="histor.go(-1)"> &lt;&lt;Back</a>
             <cffile
                action="DELETE"
                file="#expandPath('../../')#utilities\infusionSoft\temp\#TempfileName#"/>
                 <a href="javascript:history.go(-1)"> &lt;&lt;Back</a><cfabort>
                <cfabort>

        </cfif>


        <cffile action="readbinary" file="#expandPath('./temp/#TempfileName#')#" variable="readFile">
		<cfset TempfileName = listdeleteat(TempfileName,1,"_")>

	    
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="FileService.uploadFile"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#FORM.memberID#'>
        <cfset myArray[4]=TempfileName>
        <cfset myArray[5]=ToBase64(readFile)>

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">


        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


		
        <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#FORM.memberID#">
        <cfset myArray[4]="(int)2099">


        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>



    	<cfif isDefined("myResult")>
			Thank you, your prerequisite proof has been uploaded.<br />
			Please check back in two or three days to further confirm your submission.<br />
			Once your document has been reviewed and approved, a 'YES CHWC' or 'YES CPC' will be listed at the Certification Results page in your Wellcoaches Customer Hub account.

            
      		<cfmail to="#local.concierge#" from="wellcoaches@wellcoaches.com" subject="#FORM.userFiles#" type="html">
            	User: #FORM.fname#  #FORM.lname#<br /><br />
                has uploaded their prerequisite
            </cfmail>
       </cfif>
       <cfabort>
</cfif>


 <script type="text/javascript">
		function PassFileName()
		{	var errors = 0;

		  /*  if(!$('input[@id=userFiles]:checked').length){
				errors = 1;
				alert("Please select which document type you are uploading");
			}*/
			if($('##fileUpload').val()==""){
				errors = 1;
				alert("Please choose a file to upload");
			}

			if(errors){
				return false
			}else{
				document.form1.fileName.value=document.form1.fileUpload.value;
				return true;
			}

			return false;
		}
 </script>


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

<cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
</cfhttp>


<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">

   <cfset memberID =  theData.Params[1][1]['Id']>
<table class="tablesorter" >
	<tr>
    	<td>
<form name="form1" method="post" enctype="multipart/form-data" onsubmit="return PassFileName()" >
	<input type="hidden" name="fname" value="#theData.Params[1][1]['FirstName']#" />
    <input type="hidden" name="lname" value="#theData.Params[1][1]['LastName']#" />
	<input type="hidden" name="userFiles" value="PROOF_PREREQUISITE" /><!---Proof of accepted prerequisites<br />--->
	<!---<input type="radio" name="userFiles" value="PRACTICE_CLIENT_DOCUMENTATION" />Practice Client documentation (for Certification)<br />--->
	<br />

    File: <input type="file" name="fileUpload" id="fileUpload" accept="application/pdf,application/excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.ms-excel" size="20"/> <br />
    <input type="hidden" id="fileName" size="20" name="fileName" />
    <input type="hidden" name="memberID" value="#memberID#">
    <br />
    <input type="submit" name="submit" value="Upload File to your account">
</form>
		</td>
   </tr>
</table>
</cfoutput>

<cfabort>





