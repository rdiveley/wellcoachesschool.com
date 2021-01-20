<cfif structKeyExists(url, 'email') and LEN(url.email)>

    <cfparam name="local.dsn" default="wellcoachesschool" />    
    <cfquery name="local.notifycoach" datasource="#local.dsn#">
        select *
        from coach2coach
        where optin = <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT">
    </cfquery>


    <cfif local.notifycoach.recordcount>
        <cfmail to="#local.notifycoach.email#" 
            from="wellcoaches@wellcoaches.com"
            subject="New coach register"
            type="html">

            <p>This email is to inform you that a new client/volunteer has registered.</p>
            <p>Please login to CustomerHub to view the list of new volunteers/clients.</p>
            
            <p>If you wish to no longer receive this notification click <a href="http://#cgi.server_name#/utilities/coach2coachOptOut.cfm?coach=#local.notifycoach.email#">here</a></p>

            <p>Thank you.</p>

        </cfmail>
    </cfif>

    </cfif>