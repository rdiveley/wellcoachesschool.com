<cfcomponent>
	<cffunction name="savePageDetail" access="remote" output="true" returntype="string">
		<cfargument name="PageID" type="string" required="true">

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfinvokeargument name="IDFieldName" value="pageid">
			<cfinvokeargument name="IDFieldValue" value="#pageid#">
		</cfinvoke>
		<cfset PageName=#AllPages.PageName#>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Alltemplates">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="templates">
			<cfinvokeargument name="IDFieldName" value="TemplateID">
			<cfinvokeargument name="IDFieldValue" value="#AllPages.TemplateID#">
		</cfinvoke>
		<cfset TemplateName=#AllTemplates.filename#>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllDetails">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="#templateName#">
		</cfinvoke>
		
		<cfset newRecords=QueryNew("DetailID,PositionID,Content,DisplayTypeID")>
		<cfoutput query="AllDetails">
			<cfif #DisplayTypeID# neq 1 and #DisplayTypeID# neq 15 and #DisplayTypeID# neq 11>
				<cfset NewPosition=#PositionID#>
				<cfset #cPos# = "form.D#NewPosition#">
				<cfset thiscontent = evaluate(#cPos#)>
				<cfset thiscontent=replacenocase(#thiscontent#,",","~","ALL")>
				<cfset thiscontent=replacenocase(#thiscontent#,"'","`","ALL")>
				<CFSET newRow  = QueryAddRow(newRecords, 1)>
				<CFSET temp = QuerySetCell(newrecords, "DetailID","#newRow#", #newRow#)>
				<CFSET temp = QuerySetCell(newrecords, "PositionID","#int(NewPosition)#", #newRow#)>
				<CFSET temp = QuerySetCell(newrecords, "Content","#thiscontent#", #newRow#)>
				<CFSET temp = QuerySetCell(newrecords, "DisplayTypeID","#DisplayTypeID#", #newRow#)>
			</cfif>
		</cfoutput>
		
		<cfwddx action="cfml2wddx"
			input="#newrecords#"
			output="xRecords">
		<cffile action="WRITE" file="#application.uploadpath#\Pages\#PageName#.xml" output="#xRecords#" addnewline="No">
		<cflocation url="../files/adminheader.cfm?Action=homepage&PageID=#PageID#">
	</cffunction>
	
	<cffunction name="saveTemplateDetail" access="remote" output="true" returntype="string">
		<cfargument name="DetailID" type="string" required="true">
		<cfargument name="TemplateName" type="string" required="true">
		<cfargument name="Content" type="string" required="true">
		<cfargument name="PositionID" type="string" required="true">
		<cfargument name="DisplayTypeID" type="string" required="true">
		
		<cfset Content=#arguments.Content#>
		<cfset Content=replace(#content#,"~",",","ALL")>
		<cfset PositionID=#arguments.PositionID#>
		<cfset DisplayTypeID=#arguments.DisplayTypeID#>
		<cfset DetailID=#arguments.DetailID#>
		<cfset TemplateName=#arguments.TemplateName#>
		
		<cfif int(#DetailID#) gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#">
				<cfinvokeargument name="XMLFields" value="Content,PositionID,DisplayTypeID">
			<cfinvokeargument name="XMLFieldData" value="#Content#,#PositionID#,#DisplayTypeID#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
				<cfinvokeargument name="XMLIDValue" value="#DetailID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="#templateName#">
				<cfinvokeargument name="XMLFields" value="Content,PositionID,DisplayTypeID">
				<cfinvokeargument name="XMLFieldData" value="#Content#,#PositionID#,#DisplayTypeID#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
			</cfinvoke>
			<cfset DetailID=NewID>
		</cfif>
		<cfreturn DetailID>
	</cffunction>
	
	<cffunction name="saveTemplate" access="remote" output="true" returntype="string">
		<cfargument name="TemplateID" type="string" required="true">
		<cfargument name="TemplateName" type="string" required="true">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="PageTypeID" type="string" required="true">
		
		<cfset description=replace(#arguments.description#,",","~","ALL")>
		<cfset TemplateName=replace(#arguments.TemplateName#," ","","ALL")>
		<cfset PageTypeID=#arguments.PageTypeID#>
		<cfset TemplateID=#arguments.TemplateID#>
		
		<cfif TemplateID gt 0>	
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="templates">
				<cfinvokeargument name="XMLFields" value="Filename,Description,PageTypeid">
				<cfinvokeargument name="XMLFieldData" value="#FileName#,#Description#,#PageTypeID#">
				<cfinvokeargument name="XMLIDField" value="TemplateID">
				<cfinvokeargument name="XMLIDValue" value="#TemplateID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="Templates">
				<cfinvokeargument name="ThisFileName" value="templates">
				<cfinvokeargument name="XMLFields" value="Filename,Description,PageTypeid">
				<cfinvokeargument name="XMLFieldData" value="#FileName#,#Description#,#PageTypeID#">
				<cfinvokeargument name="XMLIDField" value="TemplateID">
			</cfinvoke>
			<cfset TemplateID=NewID>
		</cfif>
		<cfreturn TemplateID>
	</cffunction>
</cfcomponent>