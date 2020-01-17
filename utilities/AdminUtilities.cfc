<cfcomponent>
  <cffunction access="remote" name="InitWebSite" output="true" returntype="query">
    <cffile action="read" file="#application.uploadpath#\#application.utilitiespath#\websiteinfo.xml" variable="WebSiteVars">
	<cfwddx action="wddx2cfml"
		input="#WebSiteVars#"
		output="Records">
    <cfquery dbtype="query" name="xWebSiteInfo">
		select * from Records
	</cfquery>
    <cfreturn xWebSiteInfo>
  </cffunction>
  
  <cffunction access="remote" name="GetMailServer" output="true" returntype="string">
    <cfinclude template="website.ini">
    <cfreturn MailServer>
  </cffunction>
  
  <cffunction access="remote" name="getPages" output="true" returntype="query">
    <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllPages">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="pages">
		<cfinvokeargument name="orderByStatement" value=" order by pagename">
	</cfinvoke>
    <cfreturn AllPages>
  </cffunction>
  
</cfcomponent>
