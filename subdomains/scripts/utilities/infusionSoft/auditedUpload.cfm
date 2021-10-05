<cfoutput>
<link rel="stylesheet" type="text/css" href="js/themes/blue/style.css">
<script type="text/javascript" src="js/jquery-latest.js"></script>
<cfparam name="URL.email" default="rdiveley@wellcoaches.com">
<cfparam name="URL.lastname" default="Diveley">


<cfset julie = "a,b,c,d,e,f,g">
<cfset joanna = "h,i,j,k,l,m,n,o">
<cfset angela = "p,q,r,s,t,u,v,w,x,y,z">


<cfif listFindNoCase(julie,Left(URL.Lastname, 1))>
    <cfset concierge = "jcummings@wellcoaches.com">
<cfelseif listFindNoCase(joanna,Left(URL.Lastname, 1))>
    <cfset concierge = "jthomas@wellcoaches.com">
<cfelseif listFindNoCase(angela,Left(URL.Lastname, 1))>
    <cfset concierge = "acarterlanon@wellcoaches.com">
</cfif>

<cfif structKeyExists(FORM,"fileUpload")>
	 <cfset extension = listLast(FORM.filename,".")>
	 <cfset TempfileName = '#URL.email#_#FORM.userFiles#_#dateFormat(now(),'mm-dd-yyyy')#.#extension#'>

     <cfset acceptedMimeType="docx,xlsx,xls,doc,tif,tiff,gif,jpeg,jpg,jif,jfif,jp2,jpx,j2k,j2c,fpx,pcd,png,pdf,ppt,odt">

     <cffile
        action="upload"
        nameconflict="overwrite"
        destination="#expandPath('temp')#\#TempfileName#"
        filefield="fileUpload">

        
		<cfif NOT ListFind(acceptedMimeType,lcase(listLast(CFFILE.clientFile,".")))>
            Please only upload files of type: docx, xlsx, xls, doc, pdf <br>
            <cffile
                action="DELETE"
                file="#expandPath('temp')#\#TempfileName#"/>
            <a href="javascript:history.go(-1)"> &lt;&lt;Back</a>
            <cfabort>
        <cfelseif CFFILE.FileSize GT (5 * 1024 * 1024)>
             This type of file is too large. Please keep your file upload under 5MB<br>
            <a href="histor.go(-1)"> &lt;&lt;Back</a>
             <cffile
                action="DELETE"
                file="#expandPath('temp')#\#TempfileName#"/>
                 <a href="javascript:history.go(-1)"> &lt;&lt;Back</a><cfabort>
                <cfabort>

        </cfif>


        <cffile action="readbinary" file="#expandPath('./temp/#TempfileName#')#" variable="readFile">
		<cfset TempfileName = listdeleteat(TempfileName,1,"_")>

	    <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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


       <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

		<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#FORM.memberID#">
        <cfset myArray[4]="(int)2099">


        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">


        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>


    	<cfif isDefined("myResult")>
			Thank you, your documentation has been uploaded.  <br />

      		<cfmail to="#concierge#" from="wellcoaches@wellcoaches.com" subject="#FORM.userFiles#" type="html">
            	User: #FORM.fname#  #FORM.lname#<br /><br />
                Has uploaded documentation for recertification.
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


<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
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
	<input type="hidden" name="userFiles" value="Recertification_documentation" /><!---Proof of accepted prerequisites<br />--->
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





