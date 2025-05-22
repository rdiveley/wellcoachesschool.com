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
    
    
           
            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>
    
    
           
    
            
            <cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
            <cfset myArray = ArrayNew(1)>
            <cfset myArray[1]="ContactService.addToGroup"><!---Service.method always first param--->
            <cfset myArray[2]=key>
            <cfset myArray[3]="(int)#FORM.memberID#">
            <cfset myArray[4]="(int)9837"> <!-- NBC-HWC Documentation Submitted -->
    
    
            <cfinvoke component="utilities/XML-RPC"
                method="CFML2XMLRPC"
                data="#myArray#"
                returnvariable="myPackage">
    
    
            

            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
            </cfhttp>
    
            <!--- update fields --->
            <cfset updateField = structNew()>
            <cfset updateField['_SupportingNBCdocumentationreceived']='YES'>
            <!---  <cfset updateField['s']=form.score> --->
            <cfset updateField['_PleaseselecttheNBCexamperiodyouparticipatedin0']=" #DateFormat(form.examDate,'mm-dd-yyyy')# ">
    
    
            <cfset myArray = ArrayNew(1)>
             <cfset myArray[1]="ContactService.update"><!---Service.method always first param--->
             <cfset myArray[2]=key>
             <cfset myArray[3]='(int)#FORM.memberID#'>
             <cfset myArray[4]=updateField>
    
    
             <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage4">
    
               

                <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="result">
                    <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                    <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
                </cfhttp>
    
            <cfif isDefined("myResult")>
                Thank you, your NBC-HWC Certification exam results have been uploaded.<br />
                Please allow two - three business days for delivery of your Lifestyle Medicine Coach Certificate.
    
                  <cfmail to="#concierge#;mthom@wellcoaches.com" from="wellcoaches@wellcoaches.com" subject="#FORM.userFiles#" type="html">
                    User: #FORM.fname#  #FORM.lname#<br /><br />
                    has uploaded their NBC-HWC Documentation
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
                }else if(!$.trim($('##score').val())) {
                    //errors = 1;
                    //alert("Please provide your score");
                    //$('##score').focus();
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
    
    
    

    <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
            </cfhttp>
    
    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult.Filecontent#"
        returnvariable="theData">
    
    <cfif !ArrayLen(theData.Params[1])>
        <cfmail to="rdiveley@wellcoches.com" from="wellcoaches@wellcoaches.com" subject="#FORM.userFiles#" type="html">
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
    
                   <!--- <p>
                      NBC-HWC total test percentage: <input id="score" type="text" name="score" ><br /> 
                        Please select the NBC exam period you participated in: <!-- <input  readonly="readonly" placeholder="mm/dd/yyyy" id="examDate" type="date" name="examDate" > -->
    
                         <select name="examDate" id="examDate">
                            <!---<option value="09-30-2017">September 2017</option>
                            <option value="06-30-2018">June 2018</option>
                            <option value="11-30-2018">November 2018</option>
                            <option value="06-30-2019">June 2019</option>
                            <option value="02-29-2020">February 2020</option>
                            <option value="10-31-2020">October 2020</option>
                            <option value="02-28-2021">February 2021</option>--->
                            <option value="04-30-2022">Spring 2022</option>
                            <option value="07-31-2022">Summer 2022</option>
                            <option value="11-30-2022">Fall 2022</option>
                            <option value="04-30-2023">Spring 2023</option>
                            <option value="07-31-2023">Summer 2023</option>
                            <option value="11-30-2023">Fall 2023</option>
                            <option value="04-30-2024">Spring 2024</option>
                            <option value="07-31-2024">Summer 2024</option>
                            <option value="11-30-2024">Fall 2024</option>


                            
                            
                        </select>
                    </p>--->
    
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
    
    
    
    
    
    