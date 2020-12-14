<cfoutput>
<!--- coach2 details to coach1  --->
<cfquery name="local.insert" datasource="wellcoachesschool">
    update coach2coach
    set coach = '#url.coach#'
    ,client = '#url.client#'
    where email = '#url.coach#'
</cfquery>

<cfquery name="local.coach" datasource="wellcoachesschool">
    select *
    from coach2coach
    where email = '#url.coach#'
</cfquery>

<cfquery name="local.client" datasource="wellcoachesschool">
    select *
    from coach2coach
    where email = '#url.client#'
</cfquery>


<cfmail to="rdiveley@wellcoaches.com"
    from="wellcoaches@wellcoaches.com"
    subject="Confirmation email"
    type="html">

    <p>#local.coach.name#,</p>

    <p>#local.client.name# has confirmed coach to coach agreement.  </p>

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

An email has been sent to confirming your pairing.



</cfoutput>