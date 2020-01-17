<cfcomponent>
	<cffunction access="remote" name="GetArrayRecords" output="true" returntype="array">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		
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
			<cfset RecordCount=ArrayLen(#Records#)>
		<cfelse>
			<cfset Records=ArrayNew(2)>
			<cfset RecordCount=0>
		</cfif>
		
		<cfreturn Records>
	</cffunction>
	
	<cffunction access="remote" name="DeleteArrayData" output="true" returntype="array">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="ArrayFields" type="string" required="true" default=''>
		<cfargument name="ArrayData" type="string" required="true" default=''>
		<cfargument name="RecordID" type="numeric" required="true" default=''>
		
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		<cfset RecordID=#arguments.RecordID#>
		
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
			<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<cfset RecordCount=ArrayLen(#Records#)>
		<cfelse>
			<cfset Records=ArrayNew(2)>
			<cfset RecordCount=0>
		</cfif>

		<cfloop index="JKJK" from="1" to="#RecordCount#">
			<cfif #Records[JKJK][1]# is #RecordID#>
				<cfset tRecordID=#JKJK#>
			</cfif>
		</cfloop>
		<cfset fff=ArrayDeleteAt(#Records#,#tRecordID#)>
		<cfwddx action="cfml2wddx"
			input="#Records#"
			output="newRecords">
		<cffile action="WRITE"
			file="#uploadpath#\#ThisPath#\#ThisFileName#.xml"
			output="#newRecords#"
			addnewline="No">
			
		<cfreturn Records>
		
	</cffunction>
		
		
	<cffunction access="remote" name="UpdateArrayData" output="true" returntype="array">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="ArrayData" type="string" required="true" default=''>
		<cfargument name="RecordID" type="numeric" required="true" default=''>
		
		<cfif isdefined('application.uploadpath')>
			<cfset Uploadpath=#application.uploadpath#>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset UploadPath=#physicalPath#>
		</cfif>
		<cfset ThisPath=#Arguments.ThisPath#>
		<cfset ThisFileName=#Arguments.ThisFileName#>
		<cfset RecordID=#arguments.RecordID#>
		
		<cfif FileExists("#uploadpath#\#ThisPath#\#ThisFileName#.xml")>
			<cffile action="READ" file="#uploadpath#\#ThisPath#\#ThisFileName#.xml" variable="xRecords">
			<cfwddx action="wddx2cfml"
					input="#xRecords#"
					output="Records">
			<cfset RecordCount=ArrayLen(#Records#)>
		<cfelse>
			<cfset Records=ArrayNew(2)>
			<cfset RecordCount=0>
		</cfif>
		<cfloop index="JKJK" from="1" to="#RecordCount#">
			<cfif #Records[JKJK][1]# is #RecordID#>
				<cfset tRecordID=#JKJK#>
			</cfif>
		</cfloop>
		<cfloop index="KK" from="1" to="#ListLen(ArrayData)#">
			<cfset RecordCounter = KK + 1>
			<cfset Records[#tRecordID#][RecordCounter]=#ListGetAt(ArrayData,KK)#>
		</cfloop>
		
		<cfwddx action="cfml2wddx"
			input="#Records#"
			output="NewRecords">
		<cffile action="WRITE"
		file="#uploadpath#\#ThisPath#\#ThisFileName#.xml"
		output="#NewRecords#"
		addnewline="No">
		
		<cfreturn Records>
	</cffunction>
					
	<cffunction access="remote" name="InsertArrayData" output="true" returntype="array">
		<cfargument name="ThisPath" type="string" required="true" default=''>
		<cfargument name="ThisFileName" type="string" required="true" default=''>
		<cfargument name="ArrayData" type="string" required="true" default=''>
		
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
			<cfset RecordCount=ArrayLen(#Records#)>
		<cfelse>
			<cfset Records=ArrayNew(2)>
			<cfset RecordCount=0>
		</cfif>

		<cfset fff = arraynew(1)>
		<cfif #RecordCount# is 0>
			<cfset NewID=1>
		<cfelse>
			<cf_ArraySort
				arrayname = #Records#
				sortcolumn=1
				sortorder='asc'>
			<cfset Records=ArraySorted>
			<cfset NewID=Records[#RecordCount#][1] + 1>
		</cfif>
		<cfloop index="KLK" from="1" to="#listlen(ArrayData)#">
			<cfif #KLK# is 1>
				<cfset fff[1]=#newID#>
			<cfelse>
				<cfset ThisCount=KLK - 1>
				<cfset fff[KLK]=#ListGetAt(ArrayData,ThisCount)#>
			</cfif>
		</cfloop>
		<cfset fff=arrayappend(Records,#fff#)>
		<cfset RecordCount=#RecordCount# + 1>
		<cfwddx action="cfml2wddx"
			input="#Records#"
			output="NewRecords">
		<cffile action="WRITE"
			file="#uploadpath#\#ThisPath#\#ThisFileName#.xml"
			output="#NewRecords#"
			addnewline="No">
		<cfreturn NewRecords>
		
	</cffunction>
</cfcomponent>