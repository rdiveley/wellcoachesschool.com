<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />

<link rel="stylesheet" href="https://drvic10k.github.io/bootstrap-sortable/Contents/bootstrap-sortable.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.1/moment.js"></script>

<script src="https://drvic10k.github.io/bootstrap-sortable/Scripts/bootstrap-sortable.js"></script>

<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
<cfparam name="local.dsn" default="wellcoachesschool" />
<cfoutput>

<!--- coach2 details to coach1  --->
<cfquery name="local.insertclient" datasource="#local.dsn#">
    update coach2coach
    set clientAgree = <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT">
    where email = <CFQUERYPARAM VALUE="#url.client#" CFSQLType="CF_SQL_VARCHAR">
</cfquery>

<cfquery name="local.insertcoach" datasource="#local.dsn#">
    update coach2coach
    set client = <CFQUERYPARAM VALUE="#url.client#" CFSQLType="CF_SQL_VARCHAR">
    where email = <CFQUERYPARAM VALUE="#url.coach#" CFSQLType="CF_SQL_VARCHAR">
</cfquery>


<cfquery name="local.coach" datasource="#local.dsn#">
    select *
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#url.coach#" CFSQLType="CF_SQL_VARCHAR">

    update coach2coach
    set coachAgree = <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT">
    where email= <CFQUERYPARAM VALUE="#url.coach#" CFSQLType="CF_SQL_VARCHAR">
</cfquery>

<cfquery name="local.client" datasource="#local.dsn#">
    select *
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#url.client#" CFSQLType="CF_SQL_VARCHAR">

    update coach2coach
    set clientAgree = <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT">
    where email= <CFQUERYPARAM VALUE="#url.client#" CFSQLType="CF_SQL_VARCHAR">

</cfquery>




<cfmail to="rdiveley@wellcoaches.com"
    from="wellcoaches@wellcoaches.com"
    subject="Confirmation email"
    type="html">

    <p>#local.coach.name#,</p>

    <p>#local.client.name# has confirmed the coach to coach agreement.  </p>

    <p>Coach: #local.coach.name# preferes: #local.coach.availability# #local.coach.preference# and is located in #local.coach.location#  Please be sure to complete this form if you are the coach: <a target="_blank" href="https://my982.infusionsoft.app/app/form/coach-to-coach-agreement-coach?">Coach Form</a></p>

    <p>Client: #local.client.name# preferes: #local.client.availability# #local.client.preference# and is located in #local.client.location#  Please be sure to complete this form if you are the client: <a target="_blank" href="https://my982.infusionsoft.app/app/form/coach-to-coach-agreement---client?">Client Form</a></p>

    <p>Contact information: <br />
        <br>
        Coach: #local.coach.name# at phone: #local.coach.phone# or email at: #local.coach.email#
        <br /><br />
        <p>Client: #local.client.name# at phone: #local.client.phone# or email at: #local.client.email#</p>

    </p>

    

    <p>Thank you.</p>

</cfmail>



<div class="alert alert-success" role="alert">
   You have confirmed!  <br />
   Coach: #local.coach.name#<br />
   Client/Volunteer: #local.client.name#
</div>




</cfoutput>