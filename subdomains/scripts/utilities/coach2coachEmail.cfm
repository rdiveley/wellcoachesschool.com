<cfoutput>
<!---   the coach doing the asking --->
<cfquery name="local.coach1" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email = '#form.email#'
</cfquery>
<!--- the coach chosen from coach2coach --->
<cfquery name="local.coach2" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email = '#form.coach#'
</cfquery>


<cfmail to="rdiveley@wellcoaches.com"
        subject="Coach2Coach request"
        type="html"
        from ="wellcoaches@wellcoaches.com">
<p>Hello #local.coach2.name#, </p>

<p>Coach  #local.coach1.name# would like to pair up with you.  </p>

<p>Please click <a href="http://#cgi.server_name#/utilities/coach2coachAcceptance.cfm?coach1=#form.email#&coach2=#form.coach#">here</a> to confirm your acceptance.</p>

Thank you

</cfmail>

<p>Thank you , your request has been submitted.</p>

</cfoutput>