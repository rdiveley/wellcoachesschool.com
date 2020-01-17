<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>cfx_http_upload test</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<!--- This is file we want to upload.  Define your file here --->
<cfset filePath="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\WellCoaches+Customer+Survey.pdf">

<!--- This is filed name for the file - used in CFFILE --->
<cfset fileField="primaryFile">

<!--- This is URL we want to post the file to --->
<cfset myURL="http://localhost:8500/utilities/infusionsoft/cftest/upload_cfx.cfm">

<!--- Define other fields --->
<cfset fields=ArrayNew(2)>
<cfset fields[1][1]="myVar1">
<cfset fields[1][2]="Value of myVar1">
<cfset fields[2][1]="myVar2">
<cfset fields[2][2]="Value of myVar2">

<!--- Upload --->
<cf_cfx_http5_upload url=#myURL# fields=#fields# fileField=#fileField# fileName=#filePath# fileContent="application/zip">
<cfoutput>
<cfif status EQ "ER">
   #ERRN# - #MSG#
<cfelse>
   #res#
</cfif>
</cfoutput>

</body>
</html>
