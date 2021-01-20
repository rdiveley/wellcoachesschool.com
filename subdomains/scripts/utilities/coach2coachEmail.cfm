<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />

<link rel="stylesheet" href="https://drvic10k.github.io/bootstrap-sortable/Contents/bootstrap-sortable.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.1/moment.js"></script>

<script src="https://drvic10k.github.io/bootstrap-sortable/Scripts/bootstrap-sortable.js"></script>

<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
<cfparam name="local.dsn" default="wellcoachesschool" />
<cfoutput>
<!---   the coach doing the asking --->
<cfquery name="local.coach" datasource="#local.dsn#">
    select * 
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#form.coach#" CFSQLType="CF_SQL_VARCHAR">
</cfquery>

<!--- the client chosen from coach2coach --->
<cfquery name="local.client" datasource="#local.dsn#">
    select * 
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#form.client#" CFSQLType="CF_SQL_VARCHAR">
</cfquery>


<!--- send an email to the potential client --->
<cfmail to="#form.client#"
        cc="#form.coach#"
        subject="Coach2Coach request"
        type="html"
        from ="wellcoaches@wellcoaches.com">

<p>Hello #local.client.name#, </p>

<p>Coach #local.coach.name# would like to pair up with you.  The following has been requested: <br />
    Coach: #local.coach.name#<br /> 
    Client: #local.client.name# </p>

<p>Please click <a href="http://#cgi.server_name#/utilities/coach2coachAcceptance.cfm?coach=#form.coach#&client=#form.client#">here</a> to confirm your acceptance.</p>

Thank you

</cfmail>

<div class="alert alert-success" role="alert">
    Thank you, your request has been submitted.
</div>



</cfoutput>