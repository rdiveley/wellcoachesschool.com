<HTML>
<TITLE>Adiabata, Inc. - CFX_HTTP5 Test</TITLE>
<BODY topmargin=3 bottommargin=5>
<center>
<cfoutput>

<cfset header="HTTP_AUTH_LOGIN: admin#Chr(13)##Chr(10)#">
<cfset header="#header#HTTP_AUTH_PASSWD: setup#Chr(13)##Chr(10)#">
<cfset header="#header#HTTP_PRETTY_PRINT: TRUE#Chr(13)##Chr(10)#">

<cf_sendXML url="https://pl1.demo.sw-soft.com:8443/enterprise/control/agent.php" headers=#header#>
<packet version="1.3.1.0">
   <server>
      <get>
         <gen_info/>
      </get>
   </server>
</packet>
</cf_sendXML>

<cfif status EQ "ER">
   <h3>Error: #errn#<br>Message: #msg#</h3>
<cfelse>
   <xmp>#out#</xmp>
</cfif>
</cfoutput>

<p>
<hr>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2004 <a href="http://adiabata.com">Adiabata, Inc.</a>, Chicago, Illinois, USA
</BODY>
</HTML>
