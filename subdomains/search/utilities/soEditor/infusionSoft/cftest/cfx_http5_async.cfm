<HTML>
<title>CFX_HTTP5 Asynchronous Test</title>
<BODY>
<center><H2><FONT COLOR="#AA0000">CFX_HTTP Tag Test</FONT></H2></center>
<FORM METHOD=POST ACTION="cfx_http5_async_req.cfm">
<p>
<h3>Request 1:</h3>
<TABLE>
<TR><TD>URL: </TD><TD><INPUT TYPE=TEXT SIZE=65 NAME="CURL1" VALUE="http://www.microsoft.com"></TD></TR>
<TR><TD VALIGN=TOP>Body:<br>(for POST)</TD><TD><TEXTAREA ROWS=10 COLS=60 NAME="BODY1"></TEXTAREA></TD></TR>
<TR><TD VALIGN=TOP>Headers:<br>(hit "Enter"<br>after each)</TD><TD><TEXTAREA ROWS=5 COLS=60 NAME="HEADERS1"></TEXTAREA></TD></TR>
<TR><TD>SSL:</TD><TD>
Ignore invalid ceritificates: <SELECT NAME=SSLERRORS1>
<OPTION VALUE="">No
<OPTION VALUE="OK" selected>Yes
</SELECT>
</TD></TR>
<TR><TD>Account: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="USER1" VALUE=""></TD></TR>
<TR><TD>Password: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="PASS1" VALUE=""></TD></TR>
<TR><TD>Time-out: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="TIMEOUT1" VALUE="15000"></TD></TR>
<TR><TD>Method:</TD><TD>
<select name="method1">
<option value="GET">GET
<option value="POST">POST
<option value="HEAD">HEAD
</select>
</TD></TR>
</TABLE>

<hr>
<h3>Request 2:</h3>
<TABLE>
<TR><TD>URL: </TD><TD><INPUT TYPE=TEXT SIZE=65 NAME="CURL2" VALUE="http://www.yahoo.com"></TD></TR>
<TR><TD VALIGN=TOP>Body:<br>(for POST)</TD><TD><TEXTAREA ROWS=10 COLS=60 NAME="BODY2"></TEXTAREA></TD></TR>
<TR><TD VALIGN=TOP>Headers:<br>(hit "Enter"<br>after each)</TD><TD><TEXTAREA ROWS=5 COLS=60 NAME="HEADERS2"></TEXTAREA></TD></TR>
<TR><TD>SSL:</TD><TD>
Ignore invalid ceritificates: <SELECT NAME="SSLERRORS2">
<OPTION VALUE="">No
<OPTION VALUE="OK" selected>Yes
</SELECT>
</TD></TR>
<TR><TD>Account: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="USER2" VALUE=""></TD></TR>
<TR><TD>Password: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="PASS2" VALUE=""></TD></TR>
<TR><TD>Time-out: </TD><TD><INPUT TYPE=TEXT SIZE=15 NAME="TIMEOUT2" VALUE="10000"></TD></TR>
<TR><TD>Method:</TD><TD>
<select name="method2">
<option value="GET">GET
<option value="POST">POST
<option value="HEAD">HEAD
</select>
</TD></TR>
</TABLE>
<p>
<center>
Output: </TD><TD><select NAME="PARSE"><option VALUE="1" selected>TEXT<option value="0">HTML</select>&nbsp;&nbsp;&nbsp;<INPUT TYPE=SUBMIT VALUE="Execute" STYLE="WIDTH:80">
</FORM>

<hr>
<center>
<span style="font-size:10px"><font face="MS SANS SERIF">
This page and all contents are Copyright <big>&copy;</big> 2001-2003 Adiabata, Inc., Chicago, Illinois, USA
</BODY>
</HTML>
