<html>
<title>CFX_HTTP5 Test</title>
<body>
<center>
<h2><font color="#AA0000">CFX_HTTP5 Tag Test</font></h2>
<form method=POST action="cfx_http5_req.cfm">
<p>
<table style="font-family:Arial, Helvetica, sans-serif;font-size:12px;" cellspacing="2">
<tr>
	<td align="right"><strong>URL:</strong>&nbsp;&nbsp;</td>
	<td><input type="text" size="80" name="CURL" value="http://www.microsoft.com"></td>
</tr>
<tr>
	<td valign="top" align="right"><strong>Body:</strong>&nbsp;&nbsp;<br>(for POST)&nbsp;&nbsp;</td>
	<td><textarea rows="3" cols="62" name="BODY"></textarea></td>
</tr>
<tr>
	<td valign="top" align="right" nowrap><strong>Headers:</strong>&nbsp;&nbsp;<br>(hit "Enter" after each)&nbsp;&nbsp;</td>
	<td><textarea rows="5" cols="62" name="HEADERS"></textarea></td>
</tr>
<tr>
	<td align="right"><strong>Body File:</strong>&nbsp;&nbsp;</td>
	<td><input type="text" size="80" name="BFILE" value=""></td>
</tr>
<tr>
	<td align="right"><strong>Convert body to charset:</strong>&nbsp;&nbsp;</td>
	<td><input type="text" size="12" name="charsetOut" value=""></td>
</tr>
<tr>
	<td align="right"><strong>Charset of result:</strong>&nbsp;&nbsp;</td>
	<td><input type="text" name="inCharset" value="" size="12"> (leave blank for auto)</td>
</tr>
<tr>
	<td align="right"><strong>Accepted types:</strong></td>
	<td><input type="text" name="acceptType" value="" size="50"></td>
</tr>
<tr> 
	<td align="right" nowrap style="padding-top:5px;"><strong>Allow redirect:</strong>&nbsp;&nbsp;</td>
	<td>
		<select name="REDIR"><option value="N">No</option><option value="Y" selected>Yes</option></select>
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Allow cookie:</strong>&nbsp;&nbsp;
		<select name="COOK"><option value="" selected>Default</option><option value="N">No</option><option value="Y">Yes</option></select>
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Allow Keep-Alive:</strong>&nbsp;&nbsp;
		<select name="alive"><option value="" selected>Default</option><option value="N">No</option><option value="Y">Yes</option></select>
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>URL Decode:</strong>&nbsp;&nbsp;
		<select name="URLDECODE"><option value="Y">Decode</option><option value="E">Escape</option><option value="N">No</option></select>
	</td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Ungzip content:</strong>&nbsp;&nbsp;</td>
	<td>
		<select name="GZIP"><option value="">Default</option><option value="0">No</option><option value="1">Yes</option><option value="2">If gzip'ed</option></select>
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Encode result into Base64:</strong>&nbsp;&nbsp;
		<input type="checkbox" name="base64" value="Y">
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Ignore invalid SSL ceritificates:</strong>&nbsp;&nbsp;
		<select name="SSLERRORS"><option value="">No</option><option value="OK" selected>Yes</option></select>
	</td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Client cerificate:</strong>&nbsp;&nbsp;</td>
	<td nowrap>System store name: <input type="text" size="20" name="CERTSTORENAME" value="">&nbsp;&nbsp;Cerificate subject line: <input type="text" size="22" name="CERTSUBJSTR" value=""></td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Web-site login:</strong>&nbsp;&nbsp;</td>
	<td nowrap>Account: <input type="text" size="15" name="USER" value="">&nbsp;&nbsp;&nbsp;Password: <input type="text" size="15" name="PASS" value=""></td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Auth Schemes:</strong>&nbsp;&nbsp;</td>
	<td nowrap><input type="checkbox" name="SCHEMES" value="0" checked>Auto&nbsp;&nbsp;&nbsp;<input type="checkbox" name="SCHEMES" value="1">Basic&nbsp;&nbsp;&nbsp;<input type="checkbox" name="SCHEMES" value="2">NTLM&nbsp;&nbsp;&nbsp;<input type="checkbox" name="SCHEMES" value="4">Passport&nbsp;&nbsp;&nbsp;<input type="checkbox" name="SCHEMES" value="8">Digest&nbsp;&nbsp;&nbsp;<input type="checkbox" name="SCHEMES" value="16">NTLM or Kerberos</td>
</tr>
<tr>
   <td align="right" nowrap style="padding-top:5px;"><strong>Time-out:</strong>&nbsp;&nbsp;</td>
	<td nowrap>
		<input type="text" size="4" name="TIMEOUT" value="45000"> ms
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Max response size:</strong>&nbsp;&nbsp;
		<input type="text" name="MAXLEN" value="" size="5"> bytes
		&nbsp;&nbsp;&nbsp;&nbsp;<strong>Max response time:</strong>&nbsp;&nbsp;
		<input type="text" name="MAXTIME" value="" size="4"> ms
	</td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Proxy server:</strong>&nbsp;&nbsp;</td>
	<td nowrap>
		<input type="text" size="24" name="PROXYSERVER" value="">
		&nbsp;&nbsp;&nbsp;&nbsp;User:&nbsp;&nbsp;
		<input type="text" size="16" name="PROXYUSER" value="">
		&nbsp;&nbsp;&nbsp;&nbsp;Password:&nbsp;&nbsp;
		<input type="text" size="16" name="PROXYPASS" value="">
	</td>
</tr>
<tr>
	<td align="right" nowrap style="padding-top:5px;"><strong>Windows login:</strong>&nbsp;&nbsp;</td>
	<td>
		User: <input type=text name="FileUser" value="" size="10">&nbsp;&nbsp;&nbsp;
		Pass: <input type=text name="FilePass" value="" size="10">&nbsp;&nbsp;&nbsp;
		Domain: <input type=text name="FileDomain" value="" size="10">
	</td>
</tr>
<tr><td align="right" nowrap><strong>Output to file:</strong>&nbsp;&nbsp;</td><td><input type=text name="FileName" value="" size="50"></td></tr>
<tr><td align="right" nowrap><strong>Display:</strong>&nbsp;&nbsp;</td><td><select name="PARSE"><option value="1" selected>TEXT</option><option value="0">HTML</option><option value="2">No Output</option></select></td></tr>
</table>
<p>

<input type="submit" name="hmethod" value="GET" style="width:80px;">
<input type="submit" name="hmethod" value="POST" style="width:80px;">
<input type="submit" name="hmethod" value="HEAD" style="width:80px;">
<input type="submit" name="hmethod" value="PUT" style="width:80px;">
<input type="submit" name="hmethod" value="DELETE" style="width:80px;">
</form>

<hr>
<center><h2><font color="#AA0000">CFX_HTTP5 Host Name Resolution</font></h2></center>
<form method=post action="cfx_http5_dns.cfm">
Name or IP address: <input type="text" name="addr" value="www.macromedia.com" size="30">
<input type=submit value="Resolve">
</form>

<hr>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2011 Adiabata, Inc., Chicago, Illinois, USA
</font></span>
</center>
</body>
</html>
