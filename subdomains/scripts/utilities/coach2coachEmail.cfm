<cfoutput>


<!---   the coach doing the asking --->
<cfquery name="local.coach1" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email = '#form.coach#'
</cfquery>

<!--- the client chosen from coach2coach --->
<cfquery name="local.coach2" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email = '#form.client#'
</cfquery>


<cfmail to="rdiveley@wellcoaches.com"
        subject="Coach2Coach request"
        type="html"
        from ="wellcoaches@wellcoaches.com">

<p>Hello #local.coach2.name#, </p>

<p>Coach #local.coach1.name# would like to pair up with you.  The following has been requested: coach: #local.coach1.name# client: #local.coach2.name# </p>

<p>Please click <a href="http://#cgi.server_name#/utilities/coach2coachAcceptance.cfm?coach=#form.coach#&client=#form.client#">here</a> to confirm your acceptance.</p>

Thank you

</cfmail>

<p>Thank you, your request has been submitted.</p>

</cfoutput>