<html>
<title>CFX_HTTP5 Test</title>
<body>
<cfflush>
<cfparam name="utf" default="">
<cfparam name="base64" default="">
<cfparam name="SCHEMES" default="">
<cfif SCHEMES NEQ "">
   <cfset A=ListToArray(SCHEMES)>
   <cfset SCHEMES=0>
   <cfloop index=I from=1 to=#ArrayLen(A)#>
      <cfset SCHEMES=SCHEMES+A[I]>
   </cfloop>
</cfif>
<hr>
<cfif FileName NEQ "">
	<cfset OUT=FileName>
	<cfset RESULT="Written to file " & FileName>
	<cfset FileName="Y">
<cfelseif PARSE NEQ 2>
	<cfset OUT="RESULT">
<cfelse>
	<cfset OUT="">
</cfif>
<cfx_http5 url=#CURL# out=#OUT# file=#FileName# fileuser=#FILEUSER# filepass=#FILEPASS# filedomain=#FILEDOMAIN#
  outqhead="QHEAD" outhead="RHEAD" method=#hMETHOD# body=#BODY# bodyfile=#BFILE# sslerrors=#SSLERRORS#
  user=#USER# pass=#PASS# schemes=#SCHEMES# timeout=#TIMEOUT# headers=#HEADERS# gzip=#GZIP# acceptType=#acceptType#
  proxyserver=#PROXYSERVER# proxyuser=#PROXYUSER# proxypass=#PROXYPASS# cookie=#COOK# redirect=#REDIR#
  certstorename=#CERTSTORENAME# certsubjstr=#CERTSUBJSTR# alive=#alive# urldecode=#URLDECODE# maxlen=#MAXLEN# maxtime=#MAXTIME#
  charsetOut=#charsetOut# charsetIn=#inCharset# base64=#base64#>
<cfif STATUS EQ "ER">
   <center>
   <h3>Error while processing request.  Message:<br>
   <font color="#AA0000"><cfoutput>#MSG#</cfoutput></font><br>
   Error number: <cfoutput>#ERRN#</cfoutput></h3>
   </center>
<cfelse>
   <h3><font color="#AA0000">Status:</font> <cfoutput>#HTTPSTATUS#</cfoutput></h3>
   <h3><font color="#AA0000">Response Length:</font> <cfoutput>#HTTPLENGTH#</cfoutput></h3>
   <h3><font color="#AA0000">Bytes Read:</font> <cfoutput>#HTTPBYTES#</cfoutput></h3>
   <h3><font color="#AA0000">Time:</font> <cfoutput>#HTTPTIME#</cfoutput> ms</h3>   
   <h3><font color="#AA0000">Auth Scheme Used:</font> <cfoutput>#HTTPSCHEME#</cfoutput></h3>
   <h3><font color="#AA0000">Request Headers:</font></h3>
   <pre><cfoutput>#QHEAD#</cfoutput></pre>
   <h3><font color="#AA0000">Response Headers:</font></h3>
   <pre><cfoutput>#RHEAD#</cfoutput></pre>
   <cfif PARSE NEQ 2>
		<h3><font color="#AA0000">Response Body:</font></h3>
   	<cfif PARSE EQ 1><xmp></cfif><cfoutput>#RESULT#</cfoutput><cfif PARSE EQ 1></xmp></cfif>
	</cfif>
</cfif>
<hr>
<p>
<a href="cfx_http5.cfm"><h2>Back</h2></a>
<hr>
<center>
<span style="font-size:10px;"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2011 Adiabata, Inc., Chicago, Illinois, USA
</font></span>
</center>
</body>
</html>
