<HTML>
<title>CFX_HTTP5 Asynchronous Test</title>
<BODY>
<CFOUTPUT>
Start on: #Now()#
<p>
<cfset HTTPREQLIST="">
<cfif CURL1 NEQ "">
	<CFX_HTTP5 URL=#CURL1# OUT="RESULT" OUTHEAD="OUTHEAD" OUTQHEAD="OUTQHEAD" METHOD=#METHOD1# BODY=#BODY1# SSLERRORS=#SSLERRORS1# USER=#USER1# PASS=#PASS1# TIMEOUT=#TIMEOUT1# HEADERS=#HEADERS1# ASYNC="Y" CONTEXT=1>
	<CFIF STATUS NEQ "OK">
		<center>
		<H3>Error while processing request.  Message:<BR>
		<FONT COLOR="##AA0000">#MSG#</FONT><BR>
		Error number: #ERRN#</H3>
		</center>
	<CFELSE>
		<cfset HTTPREQLIST=ListAppend(HTTPREQLIST, HTTPREQID)>
		Request #HTTPREQID# was subimtted.<br>
	</CFIF>
</CFIF>

<cfif CURL2 NEQ "">
	<CFX_HTTP5 URL=#CURL2# OUT="RESULT" OUTHEAD="OUTHEAD" OUTQHEAD="OUTQHEAD" METHOD=#METHOD2# BODY=#BODY2# SSLERRORS=#SSLERRORS2# USER=#USER2# PASS=#PASS2# TIMEOUT=#TIMEOUT2# HEADERS=#HEADERS2# ASYNC="Y" CONTEXT=2>
	<CFIF STATUS NEQ "OK">
		<center>
		<H3>Error while processing request.  Message:<BR>
		<FONT COLOR="##AA0000">#MSG#</FONT><BR>
		Error number: #ERRN#</H3>
		</center>
		<CFX_HTTP5 REQ="CANCEL" REQID=#HTTPREQLIST#>
                <cfset HTTPREQLIST="">
	<CFELSE>
		<cfset HTTPREQLIST=ListAppend(HTTPREQLIST, HTTPREQID)>
		Request #HTTPREQID# was subimtted.<br>
	</CFIF>
</CFIF>

<p>

<CFLOOP CONDITION="Len(HTTPREQLIST) GT 0">
	<CFX_HTTP5 FNC="WAIT" REQID=#HTTPREQLIST# TIMEOUT=0 INFO="INFO">
	<CFIF STATUS EQ "ER">
          #ERRN# - #MSG#
	  <cfabort>
	</cfif>
	<!-- #INFO#<hr> -->
	<cfloop list="#HTTPREQREADY#" index="req">
	   <cfx_http5 fnc="get" reqid=#req#>
	   <b>Results for request #req#</b><br>
	   <CFIF STATUS EQ "ER">
		<H3>Error while processing WGET request.  Message:<BR>
		<FONT COLOR="##AA0000">#MSG#</FONT><BR>
		Error number: #ERRN#</H3>
	   <CFELSE>
		<b><FONT COLOR="##AA0000">Status:</FONT> #HTTPSTATUS#</b><br>
		<b><FONT COLOR="##AA0000">Request Headers:</FONT></b><br>
		<pre>#OUTQHEAD#</pre>
		<b><FONT COLOR="##AA0000">Response Headers:</FONT></b><br>
		<pre>#OUTHEAD#</pre>
		<!---<b><FONT COLOR="##AA0000">Body:</FONT></b><br>
		<CFIF PARSE><xmp></CFIF>#RESULT#<CFIF PARSE></xmp></CFIF>--->
	   </CFIF>
	</cfloop>
</CFLOOP>
<p>
Completed on: #Now()#
<p>
<a href="cfx_http5_async.cfm"><h2>Back</h2></a>
<hr>
</CFOUTPUT>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2004 Adiabata, Inc., Chicago, Illinois, USA
</BODY>
</HTML>
