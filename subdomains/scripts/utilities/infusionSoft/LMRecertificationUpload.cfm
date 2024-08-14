<cfoutput>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

<cfparam name="URL.email" default="rdiveley@wellcoaches.com">
<cfparam name="URL.lastname" default="Diveley">
<cfparam name="concierge" default="rdiveley@wellcoaches.com">

<cfset julie = "a,b,c,d,e,f,g">
<cfset angela = "h,i,j,k,l,m,n,o">
<cfset nathan = "p,q,r,s,t,u,v,w,x,y,z">


<cfif listFindNoCase(julie,Left(URL.Lastname, 1))>
    <cfset concierge = "jcummings@wellcoaches.com">
<cfelseif listFindNoCase(angela,Left(URL.Lastname, 1))>
    <cfset concierge = "amillerbarton@wellcoaches.com">
<cfelseif listFindNoCase(nathan,Left(URL.Lastname, 1))>
    <cfset concierge = "nmikeska@wellcoaches.com">
</cfif>


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

        <cfset memberID = FORM.memberid>

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

        

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult3">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

          <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData3">



       <cfset memberTags =  theData3.Params[1][1]['Groups']>


        <cfif listFindNoCase(memberTags, 1828 )>

            <!-- ID 9837: NBC-HWC Certified and eligible for LM Mod 4 Course Certificate -->
            <cfset local.tagToApply="9837">

            
            <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
            <cfset myArray[2]=key>
            <cfset myArray[3]="(int)#FORM.memberID#">
            <cfset myArray[4]="(int)#local.tagToApply#"> <!-- NBC-HWC Documentation Submitted -->


            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">


            

            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>

            <!--- update fields --->
            <cfset updateField = structNew()>
            <cfset updateField['_SupportingNBCdocumentationreceived']='YES'>

            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
            <cfset myArray[2]=key>
            <cfset myArray[3]='(int)#memberID#'>
            <cfset myArray[4]=updateField>


            <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage4">

            

                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="result">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
                </cfhttp>

            <cfif isDefined("myResult")>
                Thank you, your NBC-HWC Certification document has been uploaded. <br />
                Please allow two business days for a 'YES' to appear beside the statement: Supporting NBC documentation received (located at the National Board Certification sub-page under Certification at your Wellcoaches Customer Hub Account).

                <cfmail to="#concierge#;mthom@wellcoaches.com" from="wellcoaches@wellcoaches.com" subject="#FORM.userFiles#" type="html">
                    User: #FORM.fname#  #FORM.lname#<br /><br />
                    has uploaded their NBC-HWC Documentation
                </cfmail>
        </cfif>
    <cfelse>
            You must be certified before you can recertify.
            Please contact your concierge for further assistance: <a href="mailto:#concierge#">#concierge#</a>
    </cfif>    
       <cfabort>
</cfif>


 <script type="text/javascript">
		function PassFileName()
		{
			var errors = 0;

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
<!--- find user by email --->

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

<cfif !ArrayLen(theData.Params[1])>
	<cfmail to="rdiveley@wellcoches.com" from="rdivwellcoacheseley@wellcoaches.com" subject="#FORM.userFiles#" type="html">
            	User: #FORM.fname#  #FORM.lname#<br /><br />
                error trying to upload on recertificationUpload.cfm <br />

				<cfdump var="#theData#"><br />

				<cfdump var="#form#">
            </cfmail>
     There is no user with that email address in our records. Please contact your concierge #concierge#<cfabort>
</cfif>

<cfset memberID =  theData.Params[1][1]['Id']>
<table class="tablesorter" >
	<tr>
    	<td>
			<form name="form1" method="post" enctype="multipart/form-data" onsubmit="return PassFileName()" >
				<input type="hidden" name="fname" value="#theData.Params[1][1]['FirstName']#" />
			    <input type="hidden" name="lname" value="#theData.Params[1][1]['LastName']#" />
				<input type="hidden" name="userFiles" value="NBC-HWC-DOCUMENTATION" />

			    File: <input type="file" name="fileUpload" id="fileUpload" accept="application/pdf" size="20"/> <br />
			    <input type="hidden" id="fileName" size="20" name="fileName" />
			    <input type="hidden" name="memberID" value="#memberID#">
			    <br />
			    <input type="submit" name="submit" value="Submit NBC Documentation">
			</form>
		</td>
   </tr>
</table>
</cfoutput>

<cfabort>





