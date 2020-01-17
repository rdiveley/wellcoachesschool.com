<cfcomponent>
  <cffunction name="updateMemberClasses" access="remote" returnformat="json" output="false">
  		<cfargument name="element_id" required="true">
		<cfargument name="category" required="true">
        <cfargument name="cceh" required="true">
        <cfargument name="classTitle" required="true">
        <cfargument name="downloadLink" required="true">
        <cfargument name="facilitator" required="true">
        <cfargument name="handoutLink" required="true">
        <cfargument name="listenLink" required="true">
        <cfargument name="classDate" required="true">
        <cfargument name="cip" required="true">
        <cfargument name="wcm" required="true">
        
        <cfquery name="updateMemberClasses" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
        	update memberClasses
            set  
            	category =  <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_varchar" />,
                cceh = <cfqueryparam value="#arguments.cceh#" cfsqltype="cf_sql_varchar" />,
                class_title = <cfqueryparam value="#arguments.classTitle#" cfsqltype="cf_sql_varchar" />,
                download_link = <cfqueryparam value="#arguments.downloadLink#" cfsqltype="cf_sql_varchar" />,
                facilitator = <cfqueryparam value="#arguments.facilitator#" cfsqltype="cf_sql_varchar" />,
                handout_link = <cfqueryparam value="#arguments.handoutLink#" cfsqltype="cf_sql_varchar" />,
                listen_link = <cfqueryparam value="#arguments.listenLink#" cfsqltype="cf_sql_varchar" />,
                class_date = <cfqueryparam value="#arguments.classDate#" cfsqltype="cf_sql_date" />,
                cip = <cfqueryparam value="#arguments.cip#" cfsqltype="cf_sql_bit" />,
                wcm = <cfqueryparam value="#arguments.wcm#" cfsqltype="cf_sql_bit" />
            where id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_varchar" />
        </cfquery>
	</cffunction>
	<cffunction name="deleteMemberClasses" access="remote" returnformat="json" output="false">
    	<cfargument name="element_id" required="true">
    	<cfquery name="updateMemberClasses" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
        	delete from  memberClasses
           where id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_varchar" />
        </cfquery>
    </cffunction>

</cfcomponent>