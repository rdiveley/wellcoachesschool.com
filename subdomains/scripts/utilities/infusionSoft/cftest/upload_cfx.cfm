<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<cfset destination=GetDirectoryFromPath(GetCurrentTemplatePath())>

<cffile destination=#destination# action="upload" nameconflict="overwrite" filefield="primaryFile">

<cfoutput>
Uploaded file: #cffile.serverDirectory#\#cffile.serverFile#<br>
Value of MyVar1 is "#MyVar1#"<br>
Value of MyVar2 is "#MyVar2#"<br>
</cfoutput>

</body>
</html>
