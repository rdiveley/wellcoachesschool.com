<cfParam name="ThisForm" default="thisform">
<cfparam name="ThisContent" default="thiscontent">
<cfparam name="BodyVars" default="">
<cfparam name="ThisControl" default="">


<html>

<head>
<title>Editor</title>
<script>
function SendIt(form) {
	var AddTxt=document.thisform.D19.value;
	if (window.opener && !window.opener.closed)
    window.opener.document.<cfoutput>#thisform#.#thiscontent#.value = AddTxt</cfoutput> + '';
	window.opener.document.thisform.submit();
  	window.close();
}

</script>

</head>

<body link="#E7D8E4" vlink="#D2FBFB" alink="#FFE8FF" leftmargin=0 topmargin=0>
<form name="thisform" method="post" onSubmit="SendIt(this.form)">
<cfoutput><input type="hidden" name="thisform" value="#thisform#">
<input type="hidden" name="thisContent" value="#thisContent#"></cfoutput>
<div align="center"><div align="center"><center>

<table border="1" cellpadding="0" cellspacing="0" width="100%" height="150">
 <tr>    
        <td width=50%><cfmodule 
						template="fckeditor/fckeditor.cfm"
						toolbarSet="Jamie"
						basePath="fckeditor/"
						instanceName="D19"
						value='#thisContent#'
						width="100%"
						height="500">
					</td></tr>
        <script>
		document.thisform.D19.value=window.opener.document.<cfoutput>#thisform#.#thiscontent#</cfoutput>.value
		</script>

</table>
</center></div></div>
</form>
</body>
</html>

