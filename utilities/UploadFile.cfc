<cfcomponent>
	<cffunction access="remote" name="UploadFile" output="true" returntype="string">
		<cfargument name="TheFileName" type="string" required="true">
		<cfargument name="curPath" type="string" required="true">
		<cfargument name="curDirectory" type="string" required="true">
		<cfargument name="weight" type="numeric" required="true" default="">
		<cfargument name="nameConflictParam" type="string" required="true">
		<cfargument name="acceptParams" type="string" required="true">
		<cfset ThisFileName=#trim(arguments.TheFileName)#>
		<cfif #ThisFileName# neq ''>
			<cf_FileUpload
			directory="#arguments.curDirectory#"
			weight="#arguments.Weight#"
			nameofimages="ThisFileName"
			nameConflict="#arguments.nameConflictParam#"
			accept="#arguments.acceptParams#"
			default="na">
		</cfif>
		<cfreturn ThisFileName>
	</cffunction>
</cfcomponent>