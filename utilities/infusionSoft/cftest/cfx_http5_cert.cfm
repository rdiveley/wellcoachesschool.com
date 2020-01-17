<!--- This is an example of using Client Certificates and Sessions --->

<HTML><title>CFX_HTTP5 Test</title>
<BODY>
Start on: <CFOUTPUT>#Now()#</CFOUTPUT>

<cfset CURL="https://api.sandbox.paypal.com/2.0/">
<!--- Windows Login --->
<cfset fileUser="USER">
<cfset filePass="PASS">
<cfset fileDomain=".">
<cfset body="">
<cfset certStoreName="ROOT">
<cfset certSubjStr="ADIABATA, INC">
<cfset headers="">

<CFX_HTTP5 URL=#CURL# OUT="RESULT" FILEUSER=#FILEUSER# FILEPASS=#FILEPASS# FILEDOMAIN=#FILEDOMAIN#
           OUTQHEAD="QHEAD" OUTHEAD="RHEAD" METHOD="POST" BODY=#BODY#
		   HEADERS=#HEADERS# CERTSTORENAME=#CERTSTORENAME# CERTSUBJSTR=#CERTSUBJSTR# SESSION="START">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
   Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
   </center>
<CFELSE>
   <H3><FONT COLOR="#AA0000">Status:</FONT> <CFOUTPUT>#HTTPSTATUS#</CFOUTPUT></H3>
   <H3><FONT COLOR="#AA0000">Auth Scheme Used:</FONT> <CFOUTPUT>#HTTPSCHEME#</CFOUTPUT></H3>
   <H3><FONT COLOR="#AA0000">Request Headers:</FONT></H3>
   <pre><CFOUTPUT>#QHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response Headers:</FONT></H3>
   <pre><CFOUTPUT>#RHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response Body:</FONT></H3>
   <CFOUTPUT><xmp>#RESULT#</xmp></CFOUTPUT>
</CFIF>
Completed on: <CFOUTPUT>#Now()#<br>
Session: #HTTPSESSION#</CFOUTPUT>
<hr>

<CFX_HTTP5 URL=#CURL# OUT="RESULT" FILEUSER=#FILEUSER# FILEPASS=#FILEPASS# FILEDOMAIN=#FILEDOMAIN#
           OUTQHEAD="QHEAD" OUTHEAD="RHEAD" METHOD="POST" BODY=#BODY#
		   HEADERS=#HEADERS# CERTSTORENAME=#CERTSTORENAME# CERTSUBJSTR=#CERTSUBJSTR# SESSION=#HTTPSESSION# SESSIONEND="Y">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
   Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
   </center>
<CFELSE>
   <H3><FONT COLOR="#AA0000">Status:</FONT> <CFOUTPUT>#HTTPSTATUS#</CFOUTPUT></H3>
   <H3><FONT COLOR="#AA0000">Auth Scheme Used:</FONT> <CFOUTPUT>#HTTPSCHEME#</CFOUTPUT></H3>
   <H3><FONT COLOR="#AA0000">Request Headers:</FONT></H3>
   <pre><CFOUTPUT>#QHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response Headers:</FONT></H3>
   <pre><CFOUTPUT>#RHEAD#</CFOUTPUT></pre>
   <H3><FONT COLOR="#AA0000">Response Body:</FONT></H3>
   <CFOUTPUT><xmp>#RESULT#</xmp></CFOUTPUT>
</CFIF>

Completed on: <CFOUTPUT>#Now()#<br>
Session: #HTTPSESSION#</CFOUTPUT>
<p>

<hr>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2004 Adiabata, Inc., Chicago, Illinois, USA
</BODY>
</HTML>
