<html>
<body>
<cfoutput>

<CFX_HTTP5 REQ="DNS" ADDRESS="www.microsoft.com">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="##AA0000">#MSG#</FONT><BR>
   Error number: #ERRN#</H3>
   </center>
   <cfabort>
</CFIF>
www.microsoft.com: #HTTPIP#<p>

<CFX_HTTP5 REQ="DNS" ADDRESS="www.macromedia.com">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="##AA0000">#MSG#</FONT><BR>
   Error number: #ERRN#</H3>
   </center>
   <cfabort>
</CFIF>
www.macromedia.com: #HTTPIP#<p>

<CFX_HTTP5 REQ="DNS" ADDRESS="www.adiabata.com">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="##AA0000">#MSG#</FONT><BR>
   Error number: #ERRN#</H3>
   </center>
   <cfabort>
</CFIF>
www.adiabata.com: #HTTPIP#<p>


<CFX_HTTP5 REQ="DNS" ADDRESS="127.0.0.1">
<CFIF STATUS EQ "ER">
   <center>
   <H3>Error while processing request.  Message:<BR>
   <FONT COLOR="##AA0000">#MSG#</FONT><BR>
   Error number: #ERRN#</H3>
   </center>
   <cfabort>
</CFIF>
localhost: #HTTPIP#<p>

</cfoutput>
</body>
</html>