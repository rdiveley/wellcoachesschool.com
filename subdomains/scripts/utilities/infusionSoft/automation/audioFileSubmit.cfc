<cfcomponent>

    <!--- Update Member Classes Method --->
    <cffunction name="updateMemberClasses" access="remote" returntype="any" returnformat="json">
        <cfargument name="element_id" type="numeric" required="true">
        <cfargument name="category" type="string" required="false" default="">
        <cfargument name="classTitle" type="string" required="false" default="">
        <cfargument name="facilitator" type="string" required="false" default="">
        <cfargument name="ce_requirements" type="string" required="false" default="">
        <cfargument name="downloadLink" type="string" required="false" default="">
        <cfargument name="course_description" type="string" required="false" default="">
        <cfargument name="handoutLink" type="string" required="false" default="">
        <cfargument name="classDate" type="string" required="false" default="">
        <cfargument name="nbhwc_expiration" type="string" required="false" default="">
        <cfargument name="cip" type="numeric" required="false" default="0">
        <cfargument name="wcm" type="numeric" required="false" default="0">
        <cfargument name="nchec" type="numeric" required="false" default="0">
        <cfargument name="ace" type="numeric" required="false" default="0">
        <cfargument name="acsm" type="numeric" required="false" default="0">
        <cfargument name="boc" type="numeric" required="false" default="0">
        <cfargument name="cdr" type="numeric" required="false" default="0">
        <cfargument name="ichwc" type="numeric" required="false" default="0">
        <cfargument name="archive" type="numeric" required="false" default="0">
        
        <cftry>
            <cfquery name="updateRecord" datasource="wellcoachesschool">
                UPDATE memberClasses 
                SET 
                    category = <cfqueryparam value="#arguments.category#" cfsqltype="cf_sql_varchar">,
                    class_title = <cfqueryparam value="#arguments.classTitle#" cfsqltype="cf_sql_varchar">,
                    facilitator = <cfqueryparam value="#arguments.facilitator#" cfsqltype="cf_sql_varchar">,
                    ce_requirements = <cfqueryparam value="#arguments.ce_requirements#" cfsqltype="cf_sql_varchar">,
                    download_link = <cfqueryparam value="#arguments.downloadLink#" cfsqltype="cf_sql_varchar">,
                    course_description = <cfqueryparam value="#arguments.course_description#" cfsqltype="cf_sql_varchar">,
                    handout_link = <cfqueryparam value="#arguments.handoutLink#" cfsqltype="cf_sql_varchar">,
                    <cfif len(trim(arguments.classDate))>
                        class_date = <cfqueryparam value="#arguments.classDate#" cfsqltype="cf_sql_date">,
                    </cfif>
                    <cfif len(trim(arguments.nbhwc_expiration))>
                        nbhwc_expiration = <cfqueryparam value="#arguments.nbhwc_expiration#" cfsqltype="cf_sql_date">,
                    </cfif>
                    cip = <cfqueryparam value="#arguments.cip#" cfsqltype="cf_sql_integer">,
                    wcm = <cfqueryparam value="#arguments.wcm#" cfsqltype="cf_sql_integer">,
                    nchec = <cfqueryparam value="#arguments.nchec#" cfsqltype="cf_sql_integer">,
                    ace = <cfqueryparam value="#arguments.ace#" cfsqltype="cf_sql_integer">,
                    acsm = <cfqueryparam value="#arguments.acsm#" cfsqltype="cf_sql_integer">,
                    boc = <cfqueryparam value="#arguments.boc#" cfsqltype="cf_sql_integer">,
                    cdr = <cfqueryparam value="#arguments.cdr#" cfsqltype="cf_sql_integer">,
                    ichwc = <cfqueryparam value="#arguments.ichwc#" cfsqltype="cf_sql_integer">,
                    archive = <cfqueryparam value="#arguments.archive#" cfsqltype="cf_sql_integer">
                WHERE id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <cfreturn {
                "success": true,
                "message": "Record updated successfully",
                "element_id": arguments.element_id
            }>
            
        <cfcatch>
            <cflog file="wellcoaches_errors" text="Update error for ID #arguments.element_id#: #cfcatch.message# - #cfcatch.detail#">
            
            <cfreturn {
                "success": false,
                "message": "Update failed: #cfcatch.message#",
                "error": cfcatch.detail
            }>
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- Delete Member Classes Method --->
    <cffunction name="deleteMemberClasses" access="remote" returntype="any" returnformat="json">
        <cfargument name="element_id" type="numeric" required="true">
        
        <cftry>
            <cfquery name="deleteRecord" datasource="wellcoachesschool">
                DELETE FROM memberClasses 
                WHERE id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <cfreturn {
                "success": true,
                "message": "Record deleted successfully",
                "element_id": arguments.element_id
            }>
            
        <cfcatch>
            <cflog file="wellcoaches_errors" text="Delete error for ID #arguments.element_id#: #cfcatch.message# - #cfcatch.detail#">
            
            <cfreturn {
                "success": false,
                "message": "Delete failed: #cfcatch.message#",
                "error": cfcatch.detail
            }>
        </cfcatch>
        </cftry>
    </cffunction>

    <!--- Update Archive Status Method --->
    <cffunction name="updateArchive" access="remote" returntype="any" returnformat="json">
        <cfargument name="element_id" type="numeric" required="true">
        <cfargument name="archive" type="numeric" required="true">
        
        <cftry>
            <cfquery name="updateArchiveStatus" datasource="wellcoachesschool">
                UPDATE memberClasses 
                SET archive = <cfqueryparam value="#arguments.archive#" cfsqltype="cf_sql_integer">
                WHERE id = <cfqueryparam value="#arguments.element_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <cfreturn {
                "success": true,
                "message": "Archive status updated successfully",
                "element_id": arguments.element_id,
                "archive": arguments.archive
            }>
            
        <cfcatch>
            <cflog file="wellcoaches_errors" text="Archive update error for ID #arguments.element_id#: #cfcatch.message# - #cfcatch.detail#">
            
            <cfreturn {
                "success": false,
                "message": "Archive update failed: #cfcatch.message#",
                "error": cfcatch.detail
            }>
        </cfcatch>
        </cftry>
    </cffunction>

</cfcomponent>