<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<cfparam name="local.dsn" default="wellcoachesschool" />
<cfif structKeyExists(form, 'email') and LEN(form.email)>

    <cfquery name="optin" datasource="#local.dsn#">
        update coach2coach
        set optin = <CFQUERYPARAM VALUE="0" CFSQLType="CF_SQL_BIT">
        where email = <CFQUERYPARAM VALUE="#form.email#" CFSQLType="CF_SQL_VARCHAR">
    </cfquery>    

</cfif>


<div class="alert alert-success" role="alert">
    You have successfully opted-out
</div> 