<cfparam name="PageID" default="0">

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
