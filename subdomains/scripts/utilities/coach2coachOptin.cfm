<cfif structKeyExists(form, 'email') and LEN(form.email)>

    <cfquery name="optin" datasource="wellcoachesschool">
        update coach2coach
        set optin = <CFQUERYPARAM VALUE="#form.optin#" CFSQLType="CF_SQL_VARCHAR">
        where email = <CFQUERYPARAM VALUE="#form.email#" CFSQLType="CF_SQL_VARCHAR">
        
    </cfquery>    

    <cflocation url="http://#cgi.server_name#/utilities/coach2coachList.cfm?email=#form.email#&tz=#form.tz#&message=1" />
</cfif>
