<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<br />
<cfparam name="local.dsn" default="wellcoachesschool" />
<cfoutput>
    <p>Use this form to clear the coach, client and completed fields.</p>
<form method="post" >
    <table>
        <tr>
            <td>Coach Email </td>
            <td><input type="text" name='email'></td>
            <td><button type="submit" class="btn btn-primary">Clear</button>   </td>
        </tr>
        
    </table>
</form>


<cfif structKeyExists(form, 'email') and len(form.email)>
    <cfquery name="local.notifycoach" datasource="#local.dsn#">
        update coach2coach
        ,coach = NULL
        ,client = NULL
        where email = <CFQUERYPARAM VALUE="#form.email#" CFSQLType="CF_SQL_VARCHAR">
    </cfquery>
    <div class="alert alert-success" role="alert">
        Coach #form.email# has been cleared!
    </div> 

</cfif>
</cfoutput>