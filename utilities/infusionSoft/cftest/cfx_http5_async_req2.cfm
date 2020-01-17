<HTML>
<title>CFX_HTTP5 Asynchronous Test</title>
<BODY>
Start on: <CFOUTPUT>#Now()#</CFOUTPUT>
<hr>
<cfset HTTPREQLIST="">
<cfflush>
<cfif CURL1 NEQ "">
	<CFX_HTTP5 URL=#CURL1# OUT="RESULT" OUTHEAD="OUTHEAD" METHOD=#METHOD1# BODY=#BODY1# SSLERRORS=#SSLERRORS1# USER=#USER1# PASS=#PASS1# TIMEOUT=#TIMEOUT1# HEADERS=#HEADERS1# ASYNC="Y" gzip=2>
	<CFIF STATUS NEQ "OK">
		<center>
		<H3>Error while processing request.  Message:<BR>
		<FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
		Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
		</center>
	<CFELSE>
		<cfset HTTPREQLIST=ListAppend(HTTPREQLIST, HTTPREQID)>
		Request <cfoutput>#HTTPREQID#</cfoutput> was subimtted.<br>
	</CFIF>
</CFIF>

<cfif CURL2 NEQ "">
	<CFX_HTTP5 URL=#CURL2# OUT="RESULT" OUTHEAD="OUTHEAD" METHOD=#METHOD2# BODY=#BODY2# SSLERRORS=#SSLERRORS2# USER=#USER2# PASS=#PASS2# TIMEOUT=#TIMEOUT2# HEADERS=#HEADERS2# ASYNC="Y" gzip=2>
	<CFIF STATUS NEQ "OK">
		<center>
		<H3>Error while processing request.  Message:<BR>
		<FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
		Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
		</center>
		<CFX_HTTP5 REQ="CANCEL" REQID=#HTTPREQLIST#>
	<CFELSE>
		<cfset HTTPREQLIST=ListAppend(HTTPREQLIST, HTTPREQID)>
		Request <cfoutput>#HTTPREQID#</cfoutput> was subimtted.<br>
	</CFIF>
</CFIF>
<hr>
<cfflush>
<CFLOOP CONDITION="Len(HTTPREQLIST) GT 0">
	<cfoutput>#HTTPREQLIST#</cfoutput><br>
	<cfflush>
	<CFX_HTTP5 REQ="WGET" REQID=#HTTPREQLIST#>
	<cfoutput>#HTTPREQLIST#</cfoutput><br>
	<CFIF STATUS EQ "ER">
		<center>
		<H3>Error while processing GET request.  Message:<BR>
		<FONT COLOR="#AA0000"><CFOUTPUT>#MSG#</CFOUTPUT></FONT><BR>
		Error number: <CFOUTPUT>#ERRN#</CFOUTPUT></H3>
		</center>
		<cfabort>
	<CFELSE>
		Request <cfoutput>#HTTPREQID#</cfoutput> complete.
		<H3><FONT COLOR="#AA0000">Status:</FONT> <CFOUTPUT>#HTTPSTATUS#</CFOUTPUT></H3>
		<H3><FONT COLOR="#AA0000">Headers:</FONT></H3>
		<pre><CFOUTPUT>#OUTHEAD#</CFOUTPUT></pre>
		<H3><FONT COLOR="#AA0000">Body:</FONT></H3>
		<CFIF PARSE><xmp></CFIF><CFOUTPUT>#RESULT#</CFOUTPUT><CFIF PARSE></xmp></CFIF>
		<cfflush>
	</CFIF>
	<hr>
</CFLOOP>
<p>
Completed on: <CFOUTPUT>#Now()#</CFOUTPUT>
<p>
<a href="cfx_http5_async2.cfm"><h2>Back</h2></a>
<hr>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2003 Adiabata, Inc., Chicago, Illinois, USA
</BODY>
</HTML>
