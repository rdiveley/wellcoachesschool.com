<cfset MailTo = "support@hostek.com">
<html>
<head>
  <title>Sending a simple e-mail</title>
</head>

<body>
<h1>Sample e-mail</h1>
<cfmail
  from="wellcoaches@wellcoaches.com"
  to="#MailTo#"
  subject="Sample CF e-mail from #CGI.SERVER_NAME#"
>
This is the body of a test email. Please notify Mason when this arrives.
<cfoutput>
Server:  #CGI.SERVER_NAME#
Script:  #CGI.SCRIPT_NAME#
Path: #CGI.PATH_TRANSLATED#
</cfoutput>

</cfmail>

The e-mail was sent to <cfoutput>#MailTo#</cfoutput>.

</body>
</html>