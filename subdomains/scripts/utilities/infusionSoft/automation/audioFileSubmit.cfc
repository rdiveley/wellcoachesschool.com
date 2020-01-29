<cfcomponent>
  <cffunction name="updateMemberClasses" access="remote" returnformat="json" output="false">

  		<cfargument name="element_id">
		<cfargument name="category" default="" >
        <cfargument name="cceh"  default="">
        <cfargument name="classTitle"  default="">
        <cfargument name="ce_requirements"  default="">
        <cfargument name="downloadLink"  default="">
        <cfargument name="course_description"  default="">
        <cfargument name="facilitator"  default="">
        <cfargument name="handoutLink"  default="">
        <cfargument name="classDate"  default="">
        <cfargument name="cip"  default="0">
        <cfargument name="wcm"  default="0">
		<cfargument name="nchec"  default="0">
		<cfargument name="ace"  default="0">
		<cfargument name="acsm"  default="0">
		<cfargument name="boc"  default="0">
        <cfargument name="cdr"  default="0">
        <cfargument name="ichwc"  default="0">

        <cfquery name="updateMemberClasses" datasource="wellcoachesschool" result="local.results">
        	update memberClasses
            set
            	category =  <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_varchar" />,
                cceh = <cfqueryparam value="#arguments.cceh#" cfsqltype="cf_sql_varchar" />,
                class_title = <cfqueryparam value="#arguments.classTitle#" cfsqltype="cf_sql_varchar" />,
                ce_requirements = <cfqueryparam value="#arguments.ce_requirements#" cfsqltype="cf_sql_varchar" />,
                download_link = <cfqueryparam value="#arguments.downloadLink#" cfsqltype="cf_sql_varchar" />,
                course_description = <cfqueryparam value="#arguments.course_description#" cfsqltype="cf_sql_varchar" />,
                facilitator = <cfqueryparam value="#arguments.facilitator#" cfsqltype="cf_sql_varchar" />,
                handout_link = <cfqueryparam value="#arguments.handoutLink#" cfsqltype="cf_sql_varchar" />,
                class_date = <cfqueryparam value="#arguments.classDate#" cfsqltype="cf_sql_date" />,
                cip = <cfqueryparam value="#arguments.cip#" cfsqltype="cf_sql_bit" />,
                wcm = <cfqueryparam value="#arguments.wcm#" cfsqltype="cf_sql_bit" />,
				nchec = <cfqueryparam value="#arguments.nchec#" cfsqltype="cf_sql_bit" />,
				ace = <cfqueryparam value="#arguments.ace#" cfsqltype="cf_sql_bit" />,
				acsm = <cfqueryparam value="#arguments.acsm#" cfsqltype="cf_sql_bit" />,
				boc = <cfqueryparam value="#arguments.boc#" cfsqltype="cf_sql_bit" />,
                cdr = <cfqueryparam value="#arguments.cdr#" cfsqltype="cf_sql_bit" />,
                ichwc = <cfqueryparam value="#arguments.ichwc#" cfsqltype="cf_sql_bit" />
            where id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_varchar" />
        </cfquery>

	</cffunction>
	<cffunction name="deleteMemberClasses" access="remote" returnformat="json" output="false">
    	<cfargument name="element_id" required="true">
    	<cfquery name="updateMemberClasses" datasource="wellcoachesschool" >
        	delete from  memberClasses
           where id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_varchar" />
        </cfquery>
    </cffunction>

</cfcomponent>