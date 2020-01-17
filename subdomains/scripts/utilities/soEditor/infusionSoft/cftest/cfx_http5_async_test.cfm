<html>
<title>CFX_HTTP5 Asynchronous Test</title>
<body>
<h3>
To run this test correctly, the number of CFX_HTTP5 threads should be at least the same, as number of starting URLs.
<br>
If number of threads is lower, some requests will be waiting in the queue before they are executed.
</h3>
<cfsetting enablecfoutputonly="yes">
<!--- Our URLs --->
<cfset urls=ArrayNew(1)>
<cfset urls[1]="http://www.gazeta.ru">
<cfset urls[2]="http://www.cnn.com">
<cfset urls[3]="http://www.microsoft.com">
<cfset urls[4]="http://www.yahoo.com">
<cfset urls[5]="http://www.excite.com">
<cfset urls[6]="http://www.adobe.com">
<cfset urls[7]="http://www.simplyhired.com">
<cfset urls[8]="http://www.google.com">
<cfset urls[9]="http://www.craigslist.org">


<cfset startTime=GetTickCount()>
<cfset totHttpTime=0>
<cfset HTTPREQLIST="">

<!--- Launch them --->
<cfloop index="i" from="1" to="#ArrayLen(urls)#">
	<cfx_http5 URL=#urls[i]# OUT="RESULT" OUTHEAD="OUTHEAD" ASYNC="Y" CONTEXT=#i# gzip=2>
	<cfif STATUS NEQ "OK">
	   <!--- Should never happen, but just to be safe --->
		<cfoutput>Request #i#: #ERRN# - #MSG#<br></cfoutput>
	<cfelse>
		<cfset HTTPREQLIST=ListAppend(HTTPREQLIST, HTTPREQID)>
		<cfoutput>Request #i# was subimtted. URL: #urls[i]#<br></cfoutput>
	</cfif>
</cfloop>

<cfoutput><br><br></cfoutput>

<!--- Read them --->
<cfloop condition="Len(HTTPREQLIST) GT 0">
	<cfx_http5 FNC="WGET" REQID=#HTTPREQLIST#>
	<cfoutput>
	<b>Results for request #HTTPCONTEXT#:</b><br>
	Request time: #HTTPTIME# ms<br>
	<cfif STATUS EQ "ER">
		Error #ERRN# - #MSG#<br>
	<cfelse>
	   URL: #urls[HTTPCONTEXT]#<br>
		Status: #HTTPSTATUS#<br>	
		Reported length: #HTTPLENGTH#<br>
		Bytes read: #HTTPBYTES#<br>
		<pre>#OUTHEAD#</pre>
	</cfif>
	</cfoutput>
	<cfset totHttpTime=totHttpTime+HTTPTIME>
</cfloop>

<!--- Our execution time --->
<cfset runTime=GetTickCount()-startTime>
<cfset saveTime=totHttpTime-runTime>

<cfoutput>
<p>
Total execution time: #runTime# ms<br>
Sum of requests execution times: #totHttpTime# ms<br>
Savings: #saveTime# ms
<br>
<br>
<a href="#cgi.SCRIPT_NAME#?#GetTickCount()#"><strong>Run again</strong></a>
</cfoutput>

<cfsetting enablecfoutputonly="no">
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2000-2011 Adiabata, Inc., Chicago, Illinois, USA
</font></span>
</center>
</body>
</html>
