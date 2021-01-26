<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<br />
<cfparam name="local.dsn" default="wellcoachesschool" />

<cfquery name="local.getcoaches" datasource="#local.dsn#">
        select *
        from coach2coach
</cfquery>


<cfoutput>
    <p>Use this form to clear the coach, client and completed fields.</p>
<form method="post" >
   <table class="table table-bordered sortable">
        <tr>
            <td> Name </td>
            <td> Coach Email </td>
            <td> Client </td>
            <td> Coach Agree </td>
            <td> Client Agree</td>
            <td> Opt-In </td>
            <td> Clear Data</td>

        </tr>
        <cfloop query="local.getcoaches">
        <tr>
            <td>#local.getcoaches.name# </td>
            <td>#local.getcoaches.email#</td>
            <td>#local.getcoaches.client#</td>
            <td>#local.getcoaches.coachAgree#</td>
            <td>#local.getcoaches.clientAgree#</td>
            <td>#local.getcoaches.optin#</td>
            <td><input type="checkbox" name="id" value="#local.getcoaches.id#"></td>
        </tr>
        </cfloop>
        <tr>
            <td><input type="submit" value="Clear"></td>
        </tr>
        
    </table>
</form>


<cfif structKeyExists(form, 'id') and len(form.id)>
    
    <cfquery name="local.notifycoach" datasource="#local.dsn#">
        update coach2coach
        set coach = NULL
        ,client = NULL
        ,coachAgree = NULL
        ,clientAgree = NULL
        ,optIn = NULL
        where id IN (<CFQUERYPARAM VALUE="#form.id#" CFSQLType="CF_SQL_VARCHAR" list="true">)
    </cfquery>
    <div class="alert alert-success" role="alert">
       Success.
    </div> 

</cfif>
</cfoutput>