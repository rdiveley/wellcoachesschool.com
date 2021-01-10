<cfif structKeyExists(form, 'email') and LEN(form.email)>

    <cfquery name="optin" datasource="wellcoachesschool">
        update coach2coach
        set optin = <CFQUERYPARAM VALUE="0" CFSQLType="CF_SQL_VARCHAR">
        where email = <CFQUERYPARAM VALUE="#form.email#" CFSQLType="CF_SQL_VARCHAR">
    </cfquery>    

</cfif>