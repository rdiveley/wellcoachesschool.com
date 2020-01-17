<cfinclude template="GetPath.cfm">
<cfinclude template="#HomePath#GetDSN.cfm">
<cfinclude template="#homepath##CommonPath#/breakvars.cfm">
<cfinclude template="#homepath##CommonPath#/GetWeb.Cfm">
<cfParam name="ThisForm" default="thisform">
<cfparam name="ThisContent" default="thiscontent">
<cfparam name="BodyVars" default="">
<html>

<head>
<title>Editor</title>
<cfoutput><script language="JavaScript" src="#homepath##ScriptPath#/browsercheck.js"></script>
<script
language="JavaScript" src="#homepath##ScriptPath#/editor.js"></script>
<script></cfoutput>
function SendIt(form) {
	var AddTxt=document.thisform.D19.value;
	if (window.opener && !window.opener.closed)
    window.opener.document.<cfoutput>#thisform#.#thiscontent#</cfoutput>.value = AddTxt + '';
  window.close();
}

</script>

</head>

<body link="#E7D8E4" vlink="#D2FBFB" alink="#FFE8FF" leftmargin=0 topmargin=0>
<form name="thisform" onSubmit="SendIt(this.form)">
<cfoutput>
<input type="hidden" name="t" value="#t#">
<input type="hidden" name="BodyVars" value="#BodyVars#">
<input type="hidden" name="direction" value="forward">
</cfoutput>
<div align="center"><div align="center"><center>

<table border="1" cellpadding="0" cellspacing="0" width="100%" height="100">
 <tr>    
        <td width=50%><cfinclude template="pageedits.cfm"> </td></tr>
		
		<!---<tr><td width=50% align="CENTER" valign="TOP"><textarea name="D19" cols="60" rows="20"></textarea><br><font face="Arial" size="2" color="Maroon"><b>If you wish to insert any text into already existing text, move your mouse to where you wish the insert to happen and either type in the text or place a bracket [ there and click on the function you want to insert.  Remember to put the "END" functions in the appropriate places also</b></font></td></tr> --->
        <script>
		document.thisform.D19.value=	window.opener.document.<cfoutput>#thisform#.#thiscontent#</cfoutput>.value
		</script>

</table>
</center></div></div>
</form>
</body>
</html>
