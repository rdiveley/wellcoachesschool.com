<cfsilent>
<!--- This implements file uploading using cfx_http5 --->
<!--- Syntax:   cf_cfx_http5_upload fields fileField fileName fileContent URL
      Where:
      fields - 2-dimensional array.
               fields[][1] - field name;
               fields[][2] - filed value;
               This parameter can be omitted, if no form fields to be posted.
   fileField - name of the field that holds file to upload.
    fileName - fully qualified absolute file name to upload
 fileContent - Content-Type header for the file.  If missing, a default header
               will be provided.
         url - server URL

               Make your own changes, if needed.

   On exit, there will be STATUS variable defined.
   If it is "ER", ERRN and MSG contain error number and message.
   If it is "OK", RES variable contains server response.
--->
<!--- Parameters check --->
<cfparam name="attributes.fileContent" default="">
<cfparam name="attributes.fields" default="">
<cfparam name="attributes.fileField" default="">
<cfparam name="attributes.fileName" default="">
<cfparam name="attributes.url" default="">
<cfif Len(attributes.fileField) EQ 0>
   <cfset caller.status="ER">
   <cfset caller.errn=1>
   <cfset caller.msg="fileField is not defined">
   <cfexit>
</cfif>
<cfif Len(attributes.fileName) EQ 0>
   <cfset caller.status="ER">
   <cfset caller.errn=2>
   <cfset caller.msg="fileName is not defined">
   <cfexit>
</cfif>
<cfif Len(attributes.url) EQ 0>
   <cfset caller.status="ER">
   <cfset caller.errn=3>
   <cfset caller.msg="URL is not defined">
   <cfexit>
</cfif>

<cfset crlf="#Chr(13)##Chr(10)#">
<cfset boundary="AaB03xdFrtwzZsx">
<cfset headers="Content-Type: multipart/form-data, boundary=#boundary#">
<cfset part="#crlf#--#boundary##crlf#Content-Disposition: form-data; ">
<cfset body="">
<cfif IsArray(attributes.fields)>
   <cfloop index="i" from="1" to="#ArrayLen(attributes.fields)#">
      <cfset body='#body##part#name="#attributes.fields[i][1]#"#crlf##crlf##attributes.fields[i][2]#'>
   </cfloop>
</cfif>
<cfset body='#body##part#name="#attributes.fileField#"; filename="#GetFileFromPath(attributes.fileName)#"#crlf#'>
<cfif Len(attributes.fileContent) EQ 0>
   <cfset attributes.fileContent="application/octet-stream">
</cfif>
<cfset body='#body#Content-Type: #attributes.fileContent##crlf##crlf#'>
<cfset bodyend="#crlf#--#boundary#--">

<CFX_HTTP5 URL=#attributes.url# OUT="caller.res" METHOD="POST" BODY=#body# BODYFILE=#attributes.fileName# BODYEND=#bodyEnd# HEADERS=#headers#>
<cfset caller.status=status>
<cfif status EQ "ER">
   <cfset caller.errn=ERRN>
   <cfset caller.msg=MSG>
</cfif>
</cfsilent>