<cfoutput>
<cfif structkeyExists(form,'to')>
<cfmail to="#FORM.to#" from="wellcoaches@wellcoaches.com" subject="testing email from wellcoaches">
	This is a test email from Wellcoaches.
</cfmail>
<br />
Email Sent to #FORM.to#!<br>
<a href="javascript:history.go(-1)"> Try again </a>
<cfelse>
<form method="post">
	Send email to: <input type="text" name="to" size="50" />
    <br />
    <input type="submit" value="Send Email" />
</form>
</cfif>


</cfoutput>
