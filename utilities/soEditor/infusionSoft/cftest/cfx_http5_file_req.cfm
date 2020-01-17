<HTML>
<title>CFX_HTTP5 File Send Test</title>
<BODY>
<br>
<cfset crlf="#Chr(13)##Chr(10)#">
<cfset curl=GetDirectoryFromPath(CGI.PATH_INFO)>
<cfset curl="http://" & CGI.SERVER_NAME & Left(curl, Len(curl)-1) & "cfx_http5_upload.cfm">
<cfset fileName=GetFileFromPath(filePath)>
<cfset headers="Content-Type: multipart/form-data, boundary=AaB03x#crlf#">
<cfset body='#crlf#--AaB03x#crlf#Content-Disposition: form-data; name="fileName"#crlf##crlf##fileName#'>
<cfset body='#body##crlf#--AaB03x#crlf#Content-Disposition: form-data; name="uploadFile"; filename="#fileName#"#crlf#Content-Type: text/plain#crlf##crlf#'>
<cfset bodyEnd="#crlf#--AaB03x--">

<CFX_HTTP5 URL=#curl# OUT="RESULT" OUTQHEAD="QHEAD" OUTHEAD="RHEAD" METHOD="POST" BODY=#body# BODYFILE=#filePath# BODYEND=#bodyEnd# HEADERS=#headers#>
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
   Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
   </center>
<CFELSE>
   <H3><FONT COLOR="#AA0000">Status:</FONT> <CFOUTPUT>#HTTPSTATUS#</CFOUTPUT></H3>
   <H3><FONT COLOR="#AA0000">Request Headers:</FONT></H3>
   <pre><CFOUTPUT>#QHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response Headers:</FONT></H3>
   <pre><CFOUTPUT>#RHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response from uploading program:</FONT></H3>
   <table border=1><tr><td><CFOUTPUT>#RESULT#</CFOUTPUT></td></tr></table>
</CFIF>

<p>
<a href="cfx_http5_file.cfm"><h2>Back</h2></a>
<hr>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2004 Adiabata, Inc., Chicago, Illinois, USA
</BODY>
</HTML>
