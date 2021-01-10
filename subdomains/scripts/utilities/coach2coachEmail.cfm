<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />

<link rel="stylesheet" href="https://drvic10k.github.io/bootstrap-sortable/Contents/bootstrap-sortable.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.1/moment.js"></script>

<script src="https://drvic10k.github.io/bootstrap-sortable/Scripts/bootstrap-sortable.js"></script>

<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
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

<cfset local.emails = '#form.coach#,#form.client#' />

<cfif !listFindNoCase(local.emails, form.email)>
    <cflocation  url="coach2coachList.cfm?email=#form.email#&tz=#form.tz#&message=2">

</cfif>

<cfmail to="#form.client#"
        subject="Coach2Coach request"
        type="html"
        from ="wellcoaches@wellcoaches.com">

<p>Hello #local.coach2.name#, </p>

<p>Coach #local.coach1.name# would like to pair up with you.  The following has been requested: <br />
    Coach: #local.coach1.name#<br /> 
    Client: #local.coach2.name# </p>

<p>Please click <a href="http://#cgi.server_name#/utilities/coach2coachAcceptance.cfm?coach=#form.coach#&client=#form.client#">here</a> to confirm your acceptance.</p>

Thank you

</cfmail>

<div class="alert alert-success" role="alert">
    Thank you, your request has been submitted.
</div>



</cfoutput>