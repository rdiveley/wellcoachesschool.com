
<cfparam name="local.dsn" default="wellcoachesschool" />
<cfif structKeyExists(url, 'email') and LEN(url.email)>

    <cfquery name="optin" datasource="#local.dsn#">
        update coach2coach
        set optin = <CFQUERYPARAM VALUE="#url.optin#" CFSQLType="CF_SQL_BIT">
        where email = <CFQUERYPARAM VALUE="#url.email#" CFSQLType="CF_SQL_VARCHAR">
        
    </cfquery>    
</cfif>
