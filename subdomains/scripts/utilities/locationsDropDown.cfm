<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="locations">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Alllocations">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="locations">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="resvConfig">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="resvConfig">
		<cfinvokeargument name="IDFieldName" value="configID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput><form name="thisform" action="index.cfm?Page=#resvConfig.searchresultsPage#" method="post">
	<select name="Locations">
		<cfloop query="AllLocations"><option value="#LocationTypeID#">#city#, #state#</option></cfloop>
	</select><input type="submit" name="submit" value="GO">
	</form></cfoutput>
</cfif>