<cfcomponent>
	<cffunction access="remote" name="GetXMLRecords" output="true" returntype="query">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="IDFieldName" type="string" required="false" default=''>
		<cfargument name="IDFieldValue" type="string" required="false" default="0">
		<cfargument name="OrderbyStatement" type="string" required="false" default="">
		<cfargument name="SelectStatement" type="string" required="false" default="">
		
		<cfset goAhead=0>
		<cfif #Arguments.IDFieldName# neq '' and #Arguments.IDFieldValue# neq 0>
			<cfset IDFieldName=#Arguments.IDFieldName#>
			<cfset tempFieldValue=#arguments.IDFieldValue#>
			<cfloop index="TT" from="#len(tempFieldValue)#" to="9">
				<cfset tempFieldValue="0#tempFieldValue#">
			</cfloop>
			<cfset IDFieldValue=#tempFieldValue#>
			<cfset goAhead=1>
		</cfif>
	
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>

		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetAllRecords" dbtype="query">
				SELECT *
				FROM Records
				<cfif #goAhead#>
				where #IDFieldName# = '#IDFieldVAlue#'
				</cfif>
				<cfif #SelectStatement# neq ''>
					#preservesinglequotes(SelectStatement)#
				</cfif>
				<cfif #Arguments.OrderbyStatement# neq ''>
					 #preservesinglequotes(Arguments.OrderbyStatement)#
				</cfif>
			</CFQUERY>
		</cfif>
		<cfif isdefined('GetAllRecords')>
			<cfreturn GetAllRecords>
		<cfelse>
			<cfset GetAllRecords=QueryNew("empty")>
			<cfreturn GetAllRecords>
		</cfif>
	</cffunction>
	
	<cffunction access="remote" name="InsertXMLRecord" output="true" returntype="string">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="XMLFields" type="string" required="true" default=''>
		<cfargument name="XMLFieldData" type="string" required="true" default=''>
		<cfargument name="XMLIDField" type="string" required="true" default=''>
		
		<cfinclude template="../website.ini">
		<cfset UploadPath=#physicalPath#>
	
		<cfset XMLFields="#arguments.XMLIDField#,#arguments.XMLFields#">
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetAllRecords" dbtype="query">
				SELECT *
				FROM Records
			</CFQUERY>
			<cfset RecordCount=#GetAllRecords.RecordCount#>
		<cfelse>
			<cfset RecordCount=0>
			<cfset Records=QueryNew("#XMLFields#")>
		</cfif>
		
		<cfif #Records.RecordCount# is 0><cfset Records=QueryNew("#XMLFields#")></cfif>
		<cfset NewID="0000000001">

		<cfif RecordCount gt 0>
			<CFQUERY name="GetNewID" dbtype="query">
				select Max(#arguments.XMLIDField#) as NewID from records
			</cfquery>
			<cfset NewID=#GetNewID.NewID# + 1>
			<cfset tLen=Len(NewID)>
			<cfloop index="XX" from="#tLen#" to="9">
				<cfset NewID="0#NewID#">
			</cfloop>
		</cfif>
		
		<CFSET newRow  = QueryAddRow(records, 1)>
		<cfset XMLFieldData="#NewID#,#arguments.XMLFieldData#">

		<cfloop index="KK" from="1" to="#listlen(XMLFields)#">

			<CFSET temp = QuerySetCell(records, "#ListGetAt(XMLFields,KK)#","#ListGetAt(XMLFieldData,KK)#", #newRow#)>
		</cfloop>
		
		<cfwddx action="cfml2wddx"
			input="#Records#"
			output="NewRecords">
		
		<cffile action="WRITE" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" output="#NewRecords#" addnewline="No">
		
		<cfreturn NewID>
	</cffunction>
	
	<cffunction access="remote" name="DeleteXMLRecord" output="false">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="XMLFields" type="string" required="true" default=''>
		<cfargument name="XMLIDField" type="string" required="true" default=''>
		<cfargument name="XMLIDValue" type="string" required="true" default=''>
		<cfset ThisPath="#application.uploadpath#\#Arguments.ThisPath#">
		<cfset ThisFileName=#Arguments.ThisFileName#>
		<cfset RecordID=#Arguments.XMLIDValue#>
		<cfif FileExists("#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetRecords" dbtype="query">
				SELECT #arguments.XMLFields#, #Arguments.XMLIdField# as ThisRecordID
				FROM Records
			</CFQUERY>
			<cfset RecordCount=#GetRecords.RecordCount#>
		<cfelse>
			<cfset RecordCount=0>
			<cfset Records=QueryNew("#Arguments.XMLFields#")>
		</cfif>
		<cfset NewRecords=QueryNew("#Arguments.XMLFields#")>
		<cfoutput query="GetRecords">
			<cfif #ThisRecordID# neq #RecordID#>
			<CFSET newRow  = QueryAddRow(newRecords, 1)>
				<cfloop index="KK" from="1" to="#listlen(arguments.XMLFields)#">
					<cfset ThisFieldName=#ListGetAt(XMLFields,KK)#>
					<cfset ThisFieldData=evaluate(#ThisFieldName#)>
					<CFSET temp = QuerySetCell(newrecords, "#ListGetAt(arguments.XMLFields,KK)#","#ThisFieldData#", #newRow#)>
				</cfloop>
			</cfif>
		</cfoutput>
		<cfwddx action="cfml2wddx"
				input="#newrecords#"
				output="xRecords">
		<cffile action="WRITE" file="#ThisPath#\#ThisFileName#.xml" output="#xRecords#" addnewline="No">

	</cffunction>
	
	<cffunction access="remote" name="UpdateXMLRecord" output="true">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="XMLFields" type="string" required="true" default=''>
		<cfargument name="XMLFieldData" type="string" required="true" default=''>
		<cfargument name="XMLIDField" type="string" required="true" default=''>
		<cfargument name="XMLIDValue" type="string" required="true" default=''>
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		<cfset RecordID=#arguments.XMLIDValue#>
		
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetAllRecords" dbtype="query">
				SELECT *, #arguments.XMLIdField# as IDField
				FROM Records
			</CFQUERY>
			<cfset RecordCount=#GetAllRecords.RecordCount#>
		<cfelse>
			<cfset RecordCount=0>
			<cfset Records=QueryNew("#Arguments.XMLFields#")>
		</cfif>
	
		<CFIF #RecordID# gt 0>
			<cfset GG=0>
			<cfloop query="GetAllRecords">
				<cfset GG=GG + 1>
				<cfif #GetAllRecords.IDField# is #recordid#>
					<cfset QueryColumn=#GG#>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfif #GG# gt 0>
		<cfloop index="KK" from="1" to="#listlen(arguments.XMLFields)#">
			<CFSET temp = QuerySetCell(records, "#ListGetAt(arguments.XMLFields,KK)#","#ListGetAt(arguments.XMLFieldData,KK)#", #QueryColumn#)>
		</cfloop>
		
		<cfwddx action="cfml2wddx"
			input="#records#"
			output="Newrecords">
		
		<cffile action="WRITE" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" output="#Newrecords#" addnewline="No">
		</cfif>
	</cffunction>
	
	<cffunction access="remote" name="GetRecordCount" output="true" returntype="numeric">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="WhereStatement" type="string" required="false" default=''>
		
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetAllRecords" dbtype="query">
				SELECT count(*) as RcdCnt
				FROM Records
				<cfif #Arguments.WhereStatement# neq ''>
				#Arguments.WhereStatement#
				</cfif>
			</CFQUERY>
			<cfset RecordCount=#GetAllRecords.RcdCnt#>
		<cfelse>
			<cfset RecordCount=0>
		</cfif>
		<cfset RcdCnt=#RecordCount#>
		<cfreturn RcdCnt>
	</cffunction>
	
	<cffunction access="remote" name="GetFieldValue" output="true" returntype="string">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="FieldName" type="string" required="true" default="">
		<cfargument name="IDFieldName" type="string" required="true" default="">
		<cfargument name="IDFieldValue" type="string" required="true" default="">
		
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		
		<cfset NewID=#arguments.IDFieldValue#>
		<cfset tLen=Len(arguments.IDFieldValue)>
		<cfloop index="XX" from="#tLen#" to="9">
			<cfset NewID="0#NewID#">
		</cfloop>
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetName" dbtype="query">
				SELECT #Arguments.FieldName# as FieldValue
				FROM Records
				Where #arguments.IDFieldName# = '#NewID#'
			</CFQUERY>
			<cfset FieldVAlue=#GetName.FieldVAlue#>
		<cfelse>
			<cfset FieldVAlue=''>
		</cfif>

		<cfreturn FieldVAlue>
	</cffunction>
	
	<cffunction access="remote" name="GetMaxID" output="true" returntype="numeric">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="FieldName" type="string" required="true" default="">
		
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
				<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<CFQUERY name="GetName" dbtype="query">
				SELECT max(#Arguments.FieldName#) as FieldValue
				FROM Records
			</CFQUERY>
			<cfset FieldVAlue=#GetName.FieldVAlue#>
		<cfelse>
			<cfset FieldVAlue='0000000001'>
		</cfif>
		
		<cfreturn FieldVAlue>
	</cffunction>
	
	<cffunction name="CheckFileExists" access="remote" output="true" returntype="boolean">
		<cfargument name="FileName" default='' required="true" type="string">
		<cfargument name="ThisPath" default='' required="true" type="string">
		
		<!--- <cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse> --->
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		<!--- </cfif> --->
		<cfif FileExists("#uploadpath#\#ThisPath#\#FileName#.xml")>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
</cfcomponent>