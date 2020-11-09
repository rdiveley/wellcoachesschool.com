<cfoutput>
<!--- coach2 details to coach1  --->
<cfquery name="local.insert" datasource="wellcoachesschool">
    update coach2coach
    set coach = '#url.coach2#'
    where email = '#url.coach1#'
</cfquery>

<cfquery name="local.coach1" datasource="wellcoachesschool">
    select *
    from coach2coach
    where email = '#url.coach1#'
</cfquery>

<cfquery name="local.coach2" datasource="wellcoachesschool">
    select *
    from coach2coach
    where email = '#url.coach2#'
</cfquery>

#local.coach1.email#
<cfmail to="rdiveley@wellcoaches.com"
    from="wellcoaches@wellcoaches.com"
    subject="Confirmation email"
    type="html">

    <p>#local.coach1.name#,</p>

    <p>#local.coach2.name# has confirmed their interest.</p>

    <p>#local.coach2.name# preferes: #local.coach2.availability# #local.coach2.preference# and is located in #local.coach2.location#</p>

    <p>You may contact #local.coach2.name# at: #local.coach2.phone#</p>

    <p>Thank you.</p>

</cfmail>

An email has been sent to #url.coach1# confirming your pairing.



</cfoutput>