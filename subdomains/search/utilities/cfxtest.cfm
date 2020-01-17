<BODY BGCOLOR="white" TEXT="black">
<cfinclude template="../website.ini">
<cfset UploadPath=#PhysicalPath#>
<cfset UtilitiesPath="Utilities">
<cfset TheFilesPath="Files">
<cfset ImagesPath="images">
<cfset TemplatePath="Templates">
<cfset ScriptsPath="scripts">
<cfset PAGESPATH="Pages">
<cfset WebSitePath=#WebSitePath#>

<cfif FileExists("#uploadpath#\#utilitiespath#\websiteinfo.xml")>
	<cfinvoke 
		 component="#WebSitePath#.Utilities.AdminUtilities"
		 method="InitWebSite"
		 returnvariable="InitWebSiteRet">
	</cfinvoke>
	<cfoutput query="InitWebSiteRet">
		<cfset DSN=#DSN#>
		<cfset DSNuName=#DSNuName#>
		<cfset DSNpWord=#DSNpWord#>
	</cfoutput>
</cfif>
<CFSET #dataSource# = "">
<CFSET #queryText# = "">

<CFIF #ParameterExists(FORM.queryText)# EQ "yes">

	<cfquery name="results" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">#PreserveSingleQuotes(FORM.queryText)#</cfquery>

	Results of your query (No. of Records=<cfoutput>#results.recordcount#</cfoutput>):<BR>
	<cf_dumpquery
		query="results"
		border=1>

	<CFSET #dataSource# = #DSN# >
	<CFSET #queryText# = #FORM.queryText# >

</CFIF>

<CFOUTPUT>
<FORM METHOD="POST" ACTION="#CGI.SCRIPT_NAME#">

DataSource:<BR><INPUT TYPE="TEXT" NAME="dataSource" VALUE="#dataSource#" SIZE=20><BR>

Type in a SQL query:<BR>
<TEXTAREA NAME="queryText" ROWS=10 COLS=50>#queryText#</TEXTAREA>
<p>
<INPUT TYPE="submit" VALUE="Query">
<INPUT TYPE="reset" VALUE="Revert">

</FORM>
</CFOUTPUT>
