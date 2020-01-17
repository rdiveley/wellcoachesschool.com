<!---
DESCRIPTION:
Cold Fusion custom tag to automatically E-Mail the contents of
any form to a specified E-Mail address.

ATTRIBUTES:
FROM    - (required) Sender's E-Mail address.
SUBJECT - (optional) Message subject, defaults to "Form submission"
          if not specified.
TO      - (required) Recipient's E-Mail address.

NOTES:
Tag processes the comma delimited list of field names available
as FORM.fieldnames. Each field is checked to see that it has not
already been processed (if there were multiple fields with the
same name then they'd appear multiple times in the FORM.fieldnames
list). The finished list of fields are then sent via E-Mail to
the specified recipient. The message is formatted with each field
on it's own line, in "FIELD: value" format. The message is also
automatically date and time stamped.

USAGE:
To use, just enter <CF_MailForm> on any form action page, making
sure you specify TO and FROM addresses. An optional SUBJECT may be
specified too if desired.

EXAMPLES:
 Send form results to a fixed address:
  <CF_MailForm TO="webmaster@stoneage.com" FROM="#FORM.email#">

 Specifying the message subject:
  <CF_MailForm TO="webmaster@stoneage.com" FROM="#FORM.email#" SUBJECT="#FORM.subject#">

AUTHOR:
Ben Forta (ben@stoneage.com) 9/25/97
--->

<!--- Initialize variables --->
<CFSET proceed = "Yes">
<CFSET error_message = "">
<CFSET CRLF = Chr(13) & Chr(10)>

<!--- Check that fieldnames exists --->
<CFIF IsDefined("FORM.fieldnames") IS "No">>
 <CFSET proceed = "No">
 <CFSET error_message = "No form fields present!">
</CFIF>

<!--- Check that TO and FROM were specified --->
<CFIF proceed>
 <CFIF (IsDefined("ATTRIBUTES.to") IS "No") OR (IsDefined("ATTRIBUTES.from") IS "No")>
  <CFSET proceed = "No">
  <CFSET error_message = "TO and FROM attributes are required!">
 </CFIF>
</CFIF>

<!--- Check that TO and FROM are not empty --->
<CFIF proceed>
 <CFIF (Trim(ATTRIBUTES.to) IS "") OR (Trim(ATTRIBUTES.from) IS "")>
  <CFSET proceed = "No">
  <CFSET error_message = "TO and FROM may not be left blank!">
 </CFIF>
</CFIF>

<!--- If okay to go, process it --->
<CFIF proceed>

 <!--- Create variable for message body --->
 <CFSET message_body = "">

 <!--- Create empty list of processed variables --->
 <CFSET fieldnames_processed = "">
 
 <!--- Loop through fieldnames --->
 <CFLOOP INDEX="form_element" LIST="#FORM.fieldnames#">
 
  <!--- Try to find current element in list --->
  <CFIF ListFind(fieldnames_processed, form_element) IS 0>
  
   <!--- Make fully qualified copy of it (to prevent acessing the wrong field type) --->
   <CFSET form_element_qualified = "FORM." & form_element>
   
   <!--- Append it to message body --->
   <CFSET message_body = message_body & form_element & ": " & Evaluate(form_element_qualified) & CRLF>

   <!--- And add it to the processed list --->
   <CFSET fieldnames_processed = ListAppend(fieldnames_processed, form_element)>
   
  </CFIF>
  
 </CFLOOP> <!--- End of loop through fields --->
 
 <!--- Build subject --->
 <CFIF IsDefined("ATTRIBUTES.subject")>
  <CFSET subject = ATTRIBUTES.subject>
 <CFELSE>
  <CFSET subject = "Form submission">
 </CFIF>

 <!--- Send mail message --->
<CFMAIL FROM="#ATTRIBUTES.from#" TO="#ATTRIBUTES.to#" SUBJECT="#subject#"
		server="#application.MailServer#">
The following is the contents of a form submitted on #DateFormat(Now())# at #TimeFormat(Now())#:

#message_body#
</CFMAIL>

<CFELSE>

 <!--- Error occurred --->
 <CFOUTPUT><H1>#error_message#</H1></CFOUTPUT>
 <CFABORT>
 
</CFIF>
