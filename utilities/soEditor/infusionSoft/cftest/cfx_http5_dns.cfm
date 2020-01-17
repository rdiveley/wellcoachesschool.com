<html>
<title>Adiabata, Inc. - CFX_HTTP5 Test</title>
<body topmargin=3 bottommargin=5>
<center>
<cfoutput>
<font color="##aa0000"><h2>CFX_HTTP5 Test - Name and IP Resolution</h2></font>
<cfx_http5 REQ="DNS" ADDRESS=#addr#>
<cfif STATUS NEQ "OK">
   <h3>Error while processing request.  Message:<br>
   <font COLOR="##AA0000">#MSG#</font><br>
   Error number: #ERRN#</h3>
<cfelse>
   IP: #IP_ADDR#
   <br>
   DNS: #DNS_ADDR#
</cfif>
<p>
</cfoutput>
<a HREF="cfx_http5.cfm">Home</a>
<p>
<hr>

<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2011 Adiabata, Inc., Chicago, Illinois, USA
</font></span>
</center>
</body>
</html>
