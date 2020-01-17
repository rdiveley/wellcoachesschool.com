<cfcomponent>
	<cffunction name="getBasicConfig" access="public" returntype="string">
		<cfinclude template="vars.cfm">
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Utilities">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="utilitiesconfig">
			<cfinvokeargument name="IDFieldName" value="utilityID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfreturn Utilities>
	</cffunction>
	
	<cffunction name="saveBasicConfig" access="public" returntype="string">
		<cfargument name="MoreOverSearchParams" default="0" type="string" required="no">
		<cfargument name="STockData" default="0" type="string" required="no">
		<cfargument name="webringID" default="0" type="string" required="no">
		<cfargument name="RingSurfID" default="0" type="string" required="no">
		<cfargument name="WeatherFeedZip" default="0" type="string" required="no">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="utilitiesconfig">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>

		<cfif #TheFileExists# is "true">
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="UtilitiesConfig">
				<cfinvokeargument name="XMLFields" value="StockData,WebRingID,MoreOverSearchParams,WeatherFeedZip,RingSurfID">
				<cfinvokeargument name="XMLFieldData" value="#arguments.StockData#,#arguments.webRingID#,#arguments.MoreOverSearchParams#,#arguments.WeatherFeedZip#,#arguments.RingSurfID#">
				<cfinvokeargument name="XMLIDField" value="UtilityID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="UtilitiesConfig">
				<cfinvokeargument name="XMLFields" value="StockData,WebRingID,MoreOverSearchParams,WeatherFeedZip,RingSurfID">
				<cfinvokeargument name="XMLFieldData" value="#arguments.StockData#,#arguments.webRingID#,#arguments.MoreOverSearchParams#,#arguments.WeatherFeedZip#,#arguments.RingSurfID#">
				<cfinvokeargument name="XMLIDField" value="UtilityID">
			</cfinvoke>
		</cfif>
	</cffunction>
	
	<cffunction name="getPages" access="remote" output="true" returntype="query">
		<cfargument name="PageID" type="string" required="no" default="0">

		<cfinvoke component="#application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfif #arguments.PageID# gt 0>
				<cfinvokeargument name="IDFieldName" value="pageid">
				<cfinvokeargument name="IDFieldValue" value="#pageid#">
			</cfif>
		</cfinvoke>
		<cfreturn AllPages>
	</cffunction>
	
	<cffunction name="getAllPages" access="remote" output="true" returntype="query">
		<cfinvoke component="#application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		<cfreturn AllPages>
	</cffunction>
	
	<cffunction name="savePage" access="remote" output="true" returntype="string">
		<cfargument name="PageID" type="string" required="no" default="0">
		<cfargument name="Navigation" type="string" required="no" default="none">
		<cfargument name="PageTitle" type="string" required="yes">
		<cfargument name="PageName" type="string" required="yes">
		<cfargument name="StyleSheet" type="string" required="no" default="0">
		<cfargument name="Background" type="string" required="no" default="none">
		<cfargument name="Logo" type="string" required="no" default="none">
		<cfargument name="ScriptName" type="string" required="no" default="none">
		<cfargument name="AvailableTo" type="string" required="no" default="all">
		<cfargument name="Content" type="string" required="no" default="none">
		<cfinclude template="vars.cfm">
		
		<cfset PageTitle=replace(#arguments.PageTitle#,",","~","ALL")>
		<cfset ScriptName=#arguments.ScriptName#>
		<cfif ScriptName is "none"><cfset ScriptName="0"></cfif>
		<cfif #arguments.PageID# gt 0>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Pages">
				<cfinvokeargument name="XMLFields" value="Background,PageTitle,PageName,Navigation,StyleSheet,ScriptName,AvailableTo,Logo">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Background#,#PageTitle#,#arguments.PageName#,#arguments.Navigation#,#arguments.StyleSheet#,#ScriptName#,#arguments.AvailableTo#,#arguments.Logo#">
				<cfinvokeargument name="XMLIDField" value="PageID">
				<cfinvokeargument name="XMLIDValue" value="#PageID#">
			</cfinvoke>
			<cfif #ScriptName# is "0">
				<cffile action="WRITE" file="#uploadpath#\Pages\#arguments.PageName#.xml" output="#arguments.content#" addnewline="No">
			</cfif>
		<cfelse>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Pages">
				<cfinvokeargument name="XMLFields" value="Background,PageTitle,PageName,Navigation,StyleSheet,ScriptName,AvailableTo,Logo">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Background#,#PageTitle#,#arguments.PageName#,#arguments.Navigation#,#arguments.StyleSheet#,#ScriptName#,#arguments.AvailableTo#,#arguments.Logo#">
				<cfinvokeargument name="XMLIDField" value="PageID">
			</cfinvoke>
			<cfif #ScriptName# is "0">
				<cffile action="WRITE" file="#uploadpath#\Pages\#arguments.PageName#.xml" output="#arguments.content#" addnewline="No">
			</cfif>
		</cfif>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="getScriptList" access="remote" returntype="query" output="true">
		<cfinclude template="vars.cfm">
		<cfquery name="xscripts" datasource="#DSN#" password="#DSNpword#" username="#DSNuname#">
			select * from scripts
		</cfquery>
		<cfset scripts=QueryNew("scriptName,scriptDescript")>
		<cfset section="">
		<cfset newRow=QueryAddRow(scripts,1)>
		<CFSET temp = QuerySetCell(scripts, "scriptName","0", #newRow#)>
		<CFSET temp = QuerySetCell(scripts, "scriptDescript","----- Select Script -----", #newRow#)>
		<cfoutput query="xScripts">
			<cfif section neq #scriptSection#>
				<CFSET newRow  = QueryAddRow(scripts, 1)>
				<CFSET temp = QuerySetCell(scripts, "scriptName","0", #newRow#)>
				<CFSET temp = QuerySetCell(scripts, "scriptDescript","#scriptSection#", #newRow#)>
				<cfset section=#scriptSection#>
			<cfelse>
				<CFSET newRow  = QueryAddRow(scripts, 1)>
				<CFSET temp = QuerySetCell(scripts, "scriptName","#scriptName#", #newRow#)>
				<CFSET temp = QuerySetCell(scripts, "scriptDescript","#scriptDescript#", #newRow#)>
			</cfif>
		</cfoutput>
		<cfreturn scripts>
	</cffunction>
	
	<cffunction name="getGraphicsTypes" access="remote" returntype="query" output="true">
		<cfinclude template="vars.cfm">
		<cfinvoke method="GetArrayRecords" returnvariable="XgraphicTypes"
			component="#WebSitePath#.utilities.arrayhandler">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="graphictypes">
		</cfinvoke>
		<cfset graphicTypes=QueryNew("ID,typeName")>
		<cfset TypeCount=ArrayLen(#XgraphicTypes#)>
		<cfloop index="TT" from="1" to="#TypeCount#">
			<CFSET newRow  = QueryAddRow(graphicTypes, 1)>
			<CFSET temp = QuerySetCell(graphicTypes, "ID","#XgraphicTypes[TT][1]#", #newRow#)>
			<CFSET temp = QuerySetCell(graphicTypes, "typeName","#XgraphicTypes[TT][2]#", #newRow#)>
		</cfloop>
		<cfreturn graphicTypes>
	</cffunction>
	
	<cffunction name="getGraphics" access="remote" returntype="query" output="true">
		<cfargument name="GraphicsID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Graphics">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="graphics">
			<cfif #arguments.GraphicsID# gt 0>
				<cfinvokeargument name="IDFieldName" value="GraphicsID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.GraphicsID#">
			</cfif>
		</cfinvoke>
		<cfreturn graphics>
	</cffunction>
	
	<cffunction name="getFileNames" access="remote" returntype="query" output="true">
		<cfinclude template="vars.cfm">
		<cfparam name="thisDirectory" default="#uploadpath#\images\">
		<cfdirectory action = "list" directory =#thisDirectory# name="foo">
		<cfset fileNames=QueryNew("theFileName")>
		<cfoutput query="foo"> 
			<cfif NOT foo.name is "." AND NOT foo.name is ".."> 
				<cfif #type# neq "Dir">
					<CFSET newRow  = QueryAddRow(fileNames, 1)>
					<CFSET temp = QuerySetCell(fileNames, "theFileName","#name#", #newRow#)>
	
				</cfif>
		   	</cfif>
		</cfoutput>
		<cfreturn fileNames>
	</cffunction>
	
	<cffunction name="saveGraphic" access="remote" returntype="string" output="true">
		<cfargument name="GraphicID" required="yes" type="string">
		<cfargument name="GraphicsTypeID" required="yes" type="string">
		<cfargument name="description" required="yes" type="string">
		<cfargument name="FileName" required="yes" type="string">
		<cfinclude template="vars.cfm">

		<cfset GraphicsID=#arguments.GraphicID#>
		<cfif GraphicsID gt 0>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.GraphicsTypeID#,#arguments.description#">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
				<cfinvokeargument name="XMLIDValue" value="#GraphicsID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="GraphicsID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="graphics">
				<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.GraphicsTypeID#,#arguments.description#">
				<cfinvokeargument name="XMLIDField" value="GraphicsID">
			</cfinvoke>
		</cfif>
		<cfreturn GraphicsID>
	</cffunction>
	
	<cffunction name="saveNavigation" access="remote" output="true" returntype="string">
		<cfargument name="NavigationID" required="yes" type="string">
		<cfargument name="NavTypeID" required="yes" type="string">
		<cfargument name="LinkText" required="yes" type="string">
		<cfargument name="AltText" required="yes" type="string">
		<cfargument name="fileName" required="yes" type="string">
		<cfargument name="positionID" required="yes" type="string">
		<cfargument name="level" required="yes" type="string">
		<cfargument name="anchor" required="yes" type="string">
		<cfargument name="levelUnder" required="yes" type="string">
		<cfinclude template="vars.cfm">
		
		<cfset NavigationID=#arguments.NavigationID#>
		<cfif NavigationID gt 0>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="XMLFields" value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level,LevelUnder">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.NavTypeID#,#arguments.AltText#,#arguments.LinkText#,#arguments.Anchor#,#arguments.PositionID#,#arguments.Level#,#arguments.levelUnder#">
				<cfinvokeargument name="XMLIDField" value="NavID">
				<cfinvokeargument name="XMLIDValue" value="#NavigationID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="NavigationID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="XMLFields" value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level,LevelUnder">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.NavTypeID#,#arguments.AltText#,#arguments.LinkText#,#arguments.Anchor#,#arguments.PositionID#,#arguments.Level#,#arguments.levelUnder#">
				<cfinvokeargument name="XMLIDField" value="NavID">
			</cfinvoke>
		</cfif>
		<cfreturn NavigationID>
	</cffunction>
	
	<cffunction name="getNavigation" access="remote" returntype="query" output="true">
		<cfargument name="NavigationID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Navigation">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Navigation">
			<cfif #arguments.NavigationID# gt 0>
				<cfinvokeargument name="IDFieldName" value="NavID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.NavigationID#">
			</cfif>
		</cfinvoke>
		<cfreturn Navigation>
	</cffunction>
	
	<cffunction name="getNavigationUnders" access="remote" returntype="query" output="true">
		<cfargument name="NavigationID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Navigation">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Navigation">
			<cfif #arguments.NavigationID# gt 0>
				<cfinvokeargument name="IDFieldName" value="NavID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.NavigationID#">
			</cfif>
		</cfinvoke>
		<cfreturn Navigation>
	</cffunction>
	
	<cffunction name="deleteNavigation" access="remote" returntype="string" output="true">
		<cfargument name="NavigationID" type="string" default="yes">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="navigation">
			<cfinvokeargument name="XMLFields" value="NavID,FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level,LevelUnder">
			<cfinvokeargument name="XMLIDField" value="NavID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.NavigationID#">
		</cfinvoke>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="deleteGraphic" access="remote" returntype="string" output="true">
		<cfargument name="GraphicsID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="graphics">
			<cfinvokeargument name="XMLFields" value="GraphicsID,FileName,GraphicsTypeID,description">
			<cfinvokeargument name="XMLIDField" value="GraphicsID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.GraphicsID#">
		</cfinvoke>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="deletePage" access="remote" returntype="string" output="true">
		<cfargument name="PageID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="Pages">
			<cfinvokeargument name="XMLFields" value="PageID,Background,PageTitle,PageName,Navigation,StyleSheet,ScriptName,AvailableTo">
			<cfinvokeargument name="XMLIDField" value="PageID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.PageID#">
		</cfinvoke>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="deleteStyle" returntype="string" output="true" access="remote">
		<cfargument name="StyleID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="#TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfinvokeargument name="XMLFields" value="StyleID,Filename,Content">
			<cfinvokeargument name="XMLIDField" value="StyleID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.StyleID#">
		</cfinvoke>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="saveStyleSheet" access="remote" output="true" returntype="string">
		<cfargument name="StyleID" required="yes" type="string">
		<cfargument name="FileName" required="yes" type="string">
		<cfargument name="Content" required="yes" type="string">
		<cfinclude template="vars.cfm">

		<cfset arguments.Content=replace(arguments.content,",","~","ALL")>
		<cfset StyleID=#arguments.StyleID#>
		<cfif StyleID gt 0>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="stylesheets">
				<cfinvokeargument name="XMLFields" value="Filename,Content">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.Content#">
				<cfinvokeargument name="XMLIDField" value="StyleID">
				<cfinvokeargument name="XMLIDValue" value="#StyleID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="StyleID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="stylesheets">
				<cfinvokeargument name="XMLFields" value="Filename,Content">
				<cfinvokeargument name="XMLFieldData" value="#arguments.Filename#,#arguments.Content#">
				<cfinvokeargument name="XMLIDField" value="StyleID">
			</cfinvoke>
		</cfif>
		<cfreturn StyleID>
	</cffunction>
	
	<cffunction name="getStyleSheets" access="remote" returntype="query" output="true">
		<cfargument name="STyleID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="XstyleSheets">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfif #arguments.STyleID# gt 0>
				<cfinvokeargument name="IDFieldName" value="STyleID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.STyleID#">
			</cfif>
		</cfinvoke>
		<cfset styleSheets=QueryNew("StyleID,Filename,content")>
		<cfoutput query="XstyleSheets">
			<CFSET newRow  = QueryAddRow(styleSheets, 1)>
			<CFSET temp = QuerySetCell(styleSheets, "StyleID","#XstyleSheets.styleID#", #newRow#)>
			<CFSET temp = QuerySetCell(styleSheets, "Filename","#Filename#", #newRow#)>
			<CFSET temp = QuerySetCell(styleSheets, "content","#replace(content,'~',',','ALL')#", #newRow#)>
		</cfoutput>
		<cfreturn styleSheets>
	</cffunction>
	
	<cffunction name="getLogos" access="remote" returntype="query" output="true">
		<cfargument name="GraphicsID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Graphics">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="graphics">
			<cfif #arguments.GraphicsID# gt 0>
				<cfinvokeargument name="IDFieldName" value="GraphicsID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.GraphicsID#">
			<cfelse>
				<cfinvokeargument name="selectstatement" value=" where GraphicsTypeID='7' or GraphicsTypeID='6' or GraphicsTypeID='5'">
			</cfif>
		</cfinvoke>
		<cfreturn graphics>
	</cffunction>
	
	<cffunction name="getBackgrounds" access="remote" returntype="query" output="true">
		<cfargument name="GraphicsID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Graphics">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="graphics">
			<cfif #arguments.GraphicsID# gt 0>
				<cfinvokeargument name="IDFieldName" value="GraphicsID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.GraphicsID#">
			<cfelse>
				<cfinvokeargument name="selectstatement" value=" where GraphicsTypeID='4'">
			</cfif>
		</cfinvoke>
		<cfreturn graphics>
	</cffunction>
	
	<cffunction name="getPageNavigation" access="remote" returntype="query" output="true">
		<cfargument name="NavigationID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Navigation">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Navigation">
			<cfif #arguments.NavigationID# gt 0>
				<cfinvokeargument name="IDFieldName" value="NavID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.NavigationID#">
			</cfif>
		</cfinvoke>
		<cfreturn Navigation>
	</cffunction>
	
	<cffunction name="getArticlePages" access="remote" returntype="query" output="true">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Pages">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Pages">
			<cfinvokeargument name="OrderByStatement" value=" order by pagename">
		</cfinvoke>
		<cfreturn Pages>
	</cffunction>
	
	<cffunction name="getPageStyles" access="remote" returntype="query" output="true">
		<cfargument name="STyleID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="styleSheets">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfif #arguments.STyleID# gt 0>
				<cfinvokeargument name="IDFieldName" value="STyleID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.STyleID#">
			</cfif>
		</cfinvoke>
		<cfreturn styleSheets>
	</cffunction>
	
	<cffunction name="getHomePage" access="remote" output="true" returntype="query">
		<cfargument name="pageName" type="string" required="no" default="homepage">
		<cfargument name="Field1" type="string" required="no" default="0">
		<cfargument name="Field2" type="string" required="no" default="0">
		
		<cfinvoke component="#application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfinvokeargument name="selectstatement" value=" where pagename='#arguments.pageName#'">
		</cfinvoke>

		<cfif #AllPages.RecordCount# gt 0>
			<cfif FileExists("#application.uploadpath#\Pages\#allPages.PageName#.xml")>
				<cffile action="read" file="#application.uploadpath#\Pages\#allPages.PageName#.xml" variable="content">
				<cfwddx action="wddx2cfml"
					input="#content#"
					output="xcontent">
				<cfquery name="getNav" dbtype="query">
					select content from xcontent 
					<cfif #allpages.templateID# is "0000000004">
						where positionID='0000000005'
					<cfelse>
						where positionID='0000000022'
					</cfif>
				</cfquery>
				<cfset navigation=getNav.content>
				<cfquery name="getNav" dbtype="query">
					select content from xcontent 
					where positionID='0000000003'
				</cfquery>
				<cfset frameStop=trim(#getNav.content#)>
			<cfelse>
				<cfset content="no content">
				<cfset frameStop="home">
			</cfif>
			<cfset Pages=QueryNew("PageID,Background,PageTitle,PageName,Navigation,StyleSheet,ScriptName,AvailableTo,Logo,content,frameStop")>
			<cfoutput query="allPages">

				<cfset Background=#BackGrColorID#>
				<cfset stylesheet=#stylesheetID#>
				<cfset scriptname="none">
				<cfset availableTo=#PageTypeID#>
				<cfset Logo=#BackGrImageID#>
				<cfset newRow=QueryAddRow(Pages,1)>
				<CFSET temp = QuerySetCell(Pages, "PageID","#allPages.PageID#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "Background","#Background#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "PageTitle","#PageTitle#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "PageName","#PageName#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "Navigation","#Navigation#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "StyleSheet","#StyleSheet#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "ScriptName","#ScriptName#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "AvailableTo","#AvailableTo#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "Logo","#Logo#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "content","#xcontent#", #newRow#)>
				<CFSET temp = QuerySetCell(Pages, "frameStop","#frameStop#", #newRow#)>
			</cfoutput>
		<cfelse>
			<cfset Pages=AllPages>
		</cfif>
		<cfreturn Pages>
	</cffunction>
	
	<cffunction name="getHomePageNav" access="remote" output="true" returntype="query">
		<cfargument name="Navigation" type="string" required="yes">
		
		<cfset Navigation=replace(#arguments.Navigation#,"~",",","ALL")>
		<cfoutput>#Navigation#<br></cfoutput>
		<cfinvoke component="#application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="xnav">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="navigation">
			<cfinvokeargument name="orderbystatement" value=" order by positionID">
		</cfinvoke>
		
		<cfset nav=QueryNew("NavID,FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level")>
		<cfloop index="navElement" list="#navigation#">
			<cfquery name="getnav" dbtype="query">
				select * from xnav
				where NavID = '#trim(navElement)#'
			</cfquery>
			<CFSET newRow  = QueryAddRow(nav, 1)>
			<CFSET temp = QuerySetCell(nav, "NavID","#getnav.NavID#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "FileName","#getnav.FileName#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "NavTypeID","#getnav.NavTypeID#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "AltText","#getnav.AltText#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "LinkText","#trim(getnav.LinkText)#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "Anchor","#trim(getnav.Anchor)#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "PositionID","#getnav.PositionID#", #newRow#)>
			<CFSET temp = QuerySetCell(nav, "Level","#getnav.Level#", #newRow#)>
		</cfloop>
		
		<cfreturn nav>
	</cffunction>
	
	<cffunction name="selectArticleTypes" access="remote" output="true" returntype="query">
		<cfinclude template="vars.cfm">
		<CFQUERY name="MainTypes" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#" >
			SELECT *
			FROM ArticleTypes
			where eacChoice=1 and subCatID=0
		</CFQUERY>
		<cfreturn MainTypes>
	</cffunction>
	
	<cffunction name="getArticleTypes" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		<CFQUERY name="MainTypes" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#" >
			SELECT *
			FROM ArticleTypes
			where eacChoice=1 and subCatID=0
			<cfif #arguments.TypeID# gt 0>
				and TypeID=#arguments.TypeID#
			</cfif>
		</CFQUERY>
		<CFQUERY name="subTypes" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#" >
			SELECT *
			FROM ArticleTypes
			where eacChoice=1 and subCatID > 0
			<cfif #arguments.TypeID# gt 0>
				and TypeID=#arguments.TypeID#
			</cfif>
		</CFQUERY>
		<cfset getRecords=QueryNew("TypeID,ShowOnPage,TypeName,description,NoOfArticles,TypeImage,ListingType,SubCatID")>
		<cfoutput query="MainTypes">
			<cfset newRow=QueryAddRow(getRecords,1)>
			<CFSET temp = QuerySetCell(getRecords, "TypeID","#MainTypes.TypeID#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "ShowOnPage","#ShowOnPage#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "TypeName","#TypeName#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "description","#description#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "NoOfArticles","#NoOfArticles#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "TypeImage","#TypeImage#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "ListingType","#ListingType#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecords, "SubCatID","#TypeImage#", #newRow#)>
			<cfquery name="getSubTypes" dbtype="query">
				select * from subTypes where subCatID=#typeID#
			</cfquery>
			<cfloop query="getSubTypes">
				<cfset newRow=QueryAddRow(getRecords,1)>
				<CFSET temp = QuerySetCell(getRecords, "TypeID","#getSubTypes.TypeID#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "ShowOnPage","#ShowOnPage#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "TypeName","#TypeName#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "description","#description#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "NoOfArticles","#NoOfArticles#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "TypeImage","#TypeImage#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "ListingType","#ListingType#", #newRow#)>
				<CFSET temp = QuerySetCell(getRecords, "SubCatID","#TypeImage#", #newRow#)>
			</cfloop>
		</cfoutput>
		<cfreturn GetRecords>
	</cffunction>
	
	<cffunction name="saveArticleType" access="remote" output="true" returntype="string">
		<cfargument name="ArticleTypeID" required="yes" type="string">
		<cfargument name="ShowOnPage" required="yes" type="string">
		<cfargument name="ArticleTypeName" required="yes" type="string">
		<cfargument name="ArticleTypeDescript" required="yes" type="string">
		<cfargument name="NoOfArticles" required="yes" type="string">
		<cfargument name="TypeImage" required="yes" type="string">
		<cfargument name="ListingType" required="yes" type="string">
		<cfargument name="SubCatID" required="yes" type="string">
		
		<cfinclude template="vars.cfm">
		<cfset fields="ShowOnPage,TypeName,description,NoOfArticles,TypeImage,ListingType,SubCatID,eacChoice">
		
		<cfset typeid=#arguments.ArticleTypeID#>
		<cfif typeid gt 0>
			<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				update articletypes set
				description='#arguments.ArticleTypeDescript#',
				NoOfArticles=#arguments.NoOfArticles#,
				ShowOnPage='#arguments.ShowOnPage#',
				TypeName='#arguments.ArticleTypeName#',
				TypeImage='#arguments.TypeImage#',
				ListingType='#arguments.ListingType#',
				SubCatID=#arguments.SubCatID#
				where typeid = #typeid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				insert into articletypes (#fields#) values (
				'#arguments.ShowOnPage#',
				'#arguments.ArticleTypeName#',
				'#arguments.ArticleTypeDescript#',
				#arguments.NoOfArticles#,
				'#arguments.TypeImage#',
				'#arguments.ListingType#',
				#arguments.SubCatID#,
				1
			</cfquery>	
			<cfquery name="getMax" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				select max(typeid) as NewID from articletypes
			</cfquery>
			<cfset typeid=#getMax.NewID#>
		</cfif>
		<cfreturn typeid>
	</cffunction>
	
	<cffunction name="deleteArticleTypes" returntype="string" output="true" access="remote">
		<cfargument name="TypeID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfquery name="delete" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
			update articletypes set eacPage=0 where typeid=#arguments.typeid#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="getArticles" access="remote" output="true" returntype="query">
		<cfargument name="TypeID" required="no" type="string" default="0">
		<cfargument name="ArticleID" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecords" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#" >
			SELECT *
			FROM Articles
			<cfif #arguments.TypeID# gt 0>
				where ArticleTypeID=#arguments.TypeID#
				<cfif #arguments.ArticleID# gt 0>
					and ArticleID=#arguments.ArticleID#
				</cfif>
			<cfelse>
				<cfif #arguments.ArticleID# gt 0>
					Where ArticleID=#arguments.ArticleID#
				</cfif>
			</cfif>
		</CFQUERY>

		<cfset articles=QueryNew("ARTICLEID,ARTICLETYPEID,AUTHOR,CONTENT,DATEENDED,DATESTARTED,IMAGEID,LINKTYPE,PAGEID,SUMMARY,TITLE,USERID")>
		
		<cfoutput query="GetRecords">
			<cfset newRow=QueryAddRow(articles,1)>
			<CFSET temp = QuerySetCell(articles, "ArticleID","#GetRecords.ArticleID#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "ARTICLETYPEID","#ARTICLETYPEID#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "AUTHOR","#AUTHOR#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "CONTENT","#content#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "DATEENDED","#DATEENDED#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "DATESTARTED","#DATESTARTED#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "IMAGEID","#IMAGEID#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "LinkType","#LinkType#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "Summary","#Summary#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "Title","#Title#", #newRow#)>
			<CFSET temp = QuerySetCell(articles, "USERID","#USERID#", #newRow#)>
		</cfoutput>
			
		<cfreturn articles>
	</cffunction>
	
	<cffunction name="updateArticleHits" access="remote" output="true" returntype="string">
		<cfargument name="ArticleID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
			update Articles set
			hits=hits + 1
			where ArticleID = #arguments.ArticleID#
		</cfquery>
	</cffunction>
	
	<cffunction name="saveArticle" access="remote" output="true" returntype="string">
		<cfargument name="ArticleID" required="no" type="string" default="0">
		<cfargument name="ArticleTypeID" required="yes" type="string">
		<cfargument name="AUTHOR" required="yes" type="string">
		<cfargument name="CONTENT" required="yes" type="string">
		<cfargument name="DATEENDED" required="yes" type="string">
		<cfargument name="IMAGEID" required="yes" type="string">
		<cfargument name="LINKTYPE" required="yes" type="string">
		<cfargument name="SUMMARY" required="yes" type="string">
		<cfargument name="TITLE" required="yes" type="string">
		<cfargument name="USERID" required="yes" type="string">
		<cfargument name="hits" required="yes" type="string">
		<cfargument name="linkURL" required="yes" type="string">
		<cfargument name="keywords" required="yes" type="string">
		<cfargument name="eacPage" required="yes" type="string">
		<cfinclude template="vars.cfm">
		
		<cfset dateStarted=now()>
		<cfset fields="ARTICLETYPEID, AUTHOR, CONTENT, DATEENDED, DATESTARTED, IMAGEID, LINKTYPE,  SUMMARY, TITLE, USERID, dateCreated, hits, linkURL, keywords, eacPage ">
		<cfset dateCreated=now()>
		
		<cfset ArticleID=#arguments.ArticleID#>
		<cfif ArticleID gt 0>
			<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				update Articles set
				CONTENT='#arguments.CONTENT#',
				hits=#arguments.hits#,
				eacPage='#arguments.eacPage#',
				AUTHOR='#arguments.AUTHOR#',
				IMAGEID='#arguments.IMAGEID#',
				ARTICLETYPEID=#arguments.ARTICLETYPEID#,
				DATEENDED='#dateformat(arguments.DATEENDED)#',
				LINKTYPE=#arguments.LINKTYPE#,
				SUMMARY='#arguments.SUMMARY#',
				USERID=#arguments.USERID#,
				TITLE='#arguments.TITLE#',
				linkURL='#arguments.linkURL#',
				keywords='#arguments.keywords#'
				where ArticleID = #arguments.ArticleID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				insert into Articles (#fields#) values (
				#arguments.ARTICLETYPEID#, 
				'#arguments.AUTHOR#', 
				'#arguments.CONTENT#', 
				'#arguments.DATEENDED#', 
				'#DATESTARTED#', 
				'#arguments.IMAGEID#', 
				#arguments.LINKTYPE#, 
				'#arguments.SUMMARY#', 
				'#arguments.TITLE#', 
				'#arguments.USERID#', 
				'#arguments.dateCreated#', 
				#arguments.hits#, 
				'#arguments.linkURL#', 
				'#arguments.keywords#', 
				'#arguments.eacPage#'
			</cfquery>	
			<cfquery name="getMax" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				select max(articleID) as NewID from Articles
			</cfquery>
			<cfset ArticleID=#getMax.NewID#>
		</cfif>
		<cfreturn ArticleID>
	</cffunction>
	
	<cffunction name="deleteArticles" returntype="string" output="true" access="remote">
		<cfargument name="articleID" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<cfquery name="delete" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
			delete from articles where articleID=#arguments.articleID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="getReports" access="remote" returntype="query" output="true">
		<cfargument name="ReportID" type='string' required="no" default="0">
		<cfargument name="sortBy" type="string" required="no" default="0">
		<cfinclude template="vars.cfm">
		
		<cfquery name="getReport" datasource="#DSN#" 
			username="#DSNUname#" password="#DSNPword#" >
			select * from jobReports
			<cfif #arguments.ReportID# neq 0 and #arguments.sortBy# neq 0>
			where ReportID=#arguments.ReportID#
			order by #arguments.SortBy#
			</cfif>
			<cfif #arguments.ReportID# neq 0 and #arguments.sortby# is 0>
				where ReportID=#arguments.reportid#
			</cfif>
			<cfif #arguments.ReportID# is 0 and #arguments.sortBy# neq 0>
			order by #arguments.sortBy#
			</cfif>
		</cfquery>
		<cfreturn getReport>
	</cffunction>
	
	<cffunction name="saveReport" access="remote" returntype="string" output="true">
		<cfargument name="ReportID" type="string" required="yes">
		<cfargument name="ReportName" type="string" required="yes">
		<cfargument name="ReportDescript" type="string" required="yes">
		<cfargument name="SelectJob" type="string" required="yes">
		<cfargument name="selectItem" type="string" required="yes">
		<cfargument name="selectUsage" type="string" required="yes">
		<cfargument name="selectDateRange" type="string" required="yes">
		<cfargument name="SubTotalOnItem" type="string" required="yes">
		<cfargument name="FieldsToUse" type="string" required="yes">
		<cfargument name="TablesToUse" type="string" required="yes">
		<cfargument name="SortBy" type="string" required="yes">
		<cfargument name="IncludeItemCount" type="string" required="yes">
		<cfargument name="SubTotalOnDate" type="string" required="no" default="0">
		<cfinclude template="vars.cfm">
		<cfset ReportFields="ReportName,ReportDescript,SelectJob,selectItem,selectUsage,selectDateRange,SubTotalOnItem,FieldsToUse,TablesToUse,SortBy,IncludeItemCount,SubTotalOnDate">
		<cfset InsertData="'#arguments.ReportName#','#arguments.ReportDescript#',#arguments.SelectJob#,#arguments.selectItem#,#arguments.selectUsage#,#arguments.selectDateRange#,#arguments.SubtotalOnItem#,'#arguments.FieldsToUse#','#arguments.TablesToUse#','#arguments.SortBy#',#arguments.IncludeItemCount#,#arguments.SubTotalOnDate#">
		<cfset UpdateData="ReportName='#arguments.ReportName#',ReportDescript='#arguments.ReportDescript#',SelectJob=#arguments.SelectJob#,SelectItem=#arguments.selectItem#,SelectUsage=#arguments.selectUsage#,selectDateRange=#arguments.selectDateRange#,SubTotalOnItem=#arguments.SubtotalOnItem#,FieldsToUse='#arguments.FieldsToUse#',TablesToUse='#arguments.TablesToUse#',SortBy='#arguments.SortBy#',IncludeItemCount=#arguments.IncludeItemCount#,SubTotalOnDate=#arguments.SubTotalOnDate#">
		<cfset ID="ReportID">
		<cfif #arguments.ReportID# gt 0>
			<cfquery name="update" datasource="#DSN#" 
			username="#DSNUname#" password="#DSNPword#" >
				update jobReports set #preserveSingleQuotes(UpdateData)# where ReportID=#arguments.ReportID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#DSN#" 
			username="#DSNUname#" password="#DSNPword#" >
				insert into jobReports (#ReportFields#) values(#preserveSingleQuotes(InsertData)#)
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="runReport" access="remote" returntype="query" output="true">
		<cfargument name="ReportID" required="yes" type="string">
		<cfargument name="JobID" required="no" type="string" default="0">
		<cfargument name="ItemID" required="no" type="string" default="0">
		<cfargument name="UsageID" required="no" type="string" default="0">
		<cfargument name="startDate" required="no" type="string" default="0">
		<cfargument name="endDate" required="no" type="string" default="0">
		<cfinclude template="vars.cfm">
		
		<cfinvoke method="getReports" returnvariable="theReport">
			<cfinvokeargument name="ReportID" value="#arguments.ReportID#">
		</cfinvoke>
		
		<cfoutput>
		<style>
		H1 {font-family: Arial; color: maroon; font-size: 14pt}
		td {
			border-bottom: dotted 1px ##000000; 
			border-right: dotted 1px ##000000;
			font-family: Arial;
			color: ##0000A0;
			padding-right: 5px;
			font-size: 10pt;
			font-weight: normal;
		}
		th {
			border-bottom: dotted 1px ##000000; 
			border-right: dotted 1px ##000000;
			font-family: Arial;
			color: maroon;
			padding-right: 5px;
			font-size: 10pt;
			font-weight: bold;
		}
		</style>

		<h1>#theReport.reportname#</h1>
		<p>#paragraphFormat(theReport.reportDescript)#</p><p>&nbsp;</p></cfoutput>
		<cfset WhereStatement="">
		<cfset ReportName=#theReport.FieldsToUse#>
		<cfset ReportDescript=#theReport.FieldsToUse#>
		<cfset SelectJob=#theReport.SelectJob#>
		<cfset selectItem=#theReport.selectItem#>
		<cfset selectUsage=#theReport.selectUsage#>
		<cfset selectDateRange=#theReport.selectDateRange#>
		<cfset SubTotalOnItem=#theReport.SubTotalOnItem#>
		<cfset FieldsToUse=#theReport.FieldsToUse#>
		<cfset TablesToUse=#theReport.TablesToUse#>
		<cfset SortBy=#theReport.SortBy#>
		<cfset IncludeItemCount=#theReport.IncludeItemCount#>
		<cfset SubTotalOnDate=#theReport.SubTotalOnDate#>
		<cfset andorwhere="where">
		<cfset TotalBy="none">
		
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"Item Usage: ","","ALL")>
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"Job: ","","ALL")>
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"Customer: ","","ALL")>
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"User: ","","ALL")>
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"Job Item: ","","ALL")>
		<cfset FieldsToUse=replacenocase(#fieldsToUse#,"Master Item: ","","ALL")>
		
		<cfset TablesToUse=replacenocase(#TablesToUse#,"usageitems","ItemUsage","ALL")>
		<cfset records=QueryNew(#FieldsToUse#)>
		
		<cfif #selectJob# is 1>
			<cfset WhereStatement="#WhereSTatement# #andorwhere# Jobs.Jobid=#arguments.JobID#">
			<cfset andorwhere="and">
			<cfif listfindnocase(#TAblesToUse#,"Jobs")>
			<cfelse>
				<cfset TablesToUse=ListAppend(#tablesToUse#,"Jobs")>
			</cfif>
		</cfif>
		
		<cfif listfindnocase(#tablestoUse#,"Jobs")>
			<cfif listfindnocase(#tablesToUse#,"jobitems")>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# JobItems.ItemJobID=Jobs.JobID">
				<cfset andorwhere="and">
			</cfif>
			<cfif listfindnocase(#tablesToUse#,"ItemUsage")>
				<cfif listfindnocase(#tablestoUse#,"jobitems")>
					<cfset WhereStatement=" #WhereStatement# #andOrWhere# ItemUsage.UsageItemID=JobItems.ItemID">
					<cfset andorwhere="and">
				<cfelse>
					<cfset WhereStatement="#WhereSTatement# #andorwhere# ItemUsage.ItemJobID=Jobs.JobID">
					<cfset andorwhere="and">
				</cfif>
			</cfif>
			<cfif listfindnocase(#tablesToUse#,"Customers")>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# Customers.CustomerID=Jobs.CustomerID">
				<cfset andorwhere="and">
			</cfif>
			<cfif listfindnocase(#tablesToUse#,"Users")>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# Users.userID=Jobs.PM">
				<cfset andorwhere="and">
			</cfif>
		</cfif>
		<cfif #selectItem# is 1>
			<cfif listfindnocase(#tablesToUse#,"JobItems")>
				<cfif listfindnocase(#fieldsToUse#,"ItemID")>
				<cfelse>
					<cfset FieldsToUse=ListAppend(#FieldsToUse#,"ItemID")>
				</cfif>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# JobItems.ItemID=#arguments.ItemID#">
				<cfset andorwhere="and">
			</cfif>
		</cfif>
		<cfif #selectUsage# is 1>
			<cfif listfindnocase(#tablesToUse#,"ItemUsage")>
				<cfif listfindnocase(#fieldsToUse#,"UsageID")>
				<cfelse>
					<cfset FieldsToUse=ListAppend(#FieldsToUse#,"UsageID")>
				</cfif>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# ItemUsage.UsageID=#arguments.UsageID#">
				<cfset andorwhere="and">
			</cfif>
		</cfif>
		<cfif #selectDateRange# is 1>
			<cfif listfindnocase(#tablesToUse#,"ItemUsage")>
				<cfif listfindnocase(#fieldsToUse#,"DateUsed")>
				<cfelse>
					<cfset FieldsToUse=ListAppend(#FieldsToUse#,"DateUsed")>
				</cfif>
				<cfset startDate=dateformat(dateAdd("d",-1,#arguments.startDate#),"mm/dd/yyyy")>
				<cfset endDate=dateformat(dateAdd("d",1,#arguments.endDate#),"mm/dd/yyyy")>
				<cfset WhereStatement="#WhereSTatement# #andorwhere# (ItemUsage.DateUsed >  '#startDate#' and ItemUsage.DateUsed < '#endDate#')">
				<cfset andorwhere="and">
			</cfif>
		</cfif>
		<cfif #SubTotalOnItem# is 1>
			<cfif listfindnocase(#tablesToUse#,"JobItems")>
				<cfif listfindnocase(#tablesToUse#,"ItemUsage")>
					<cfset TotalBy="UsageItemID">
					<cfif listfindnocase(#fieldsToUse#,"usageItemID")>
					<cfelse>
						<cfset FieldsToUse=ListAppend(#fieldsToUse#,"UsageItemID")>
					</cfif>
				<cfelse>
					<cfset TotalBy="ItemID">
				</cfif>
			<cfelseif listfindnocase(#tablesToUse#,"ItemUsage")>
				<cfset TotalBy="UsageItemID">
				<cfif ListFindNoCase(#fieldsToUse#,"UsageItemID")>
					<cfset FieldsToUse=ListAppend(#fieldsToUse#,"UsageItemID")>
				</cfif>
			<cfelse>
				<cfset TotalBy="ItemID">
				<cfset TablesToUse=ListAppend(#TablesToUse#,"Items")>
				<cfset FieldsToUse=ListAppend(#FieldsToUse#,"ItemID")>
				<cfset WhereStatement="#wherestatement# #andorwhere# Items.ItemJobID=Jobs.JobID">
			</cfif>
		</cfif>
		<cfif #SubTotalOnDate# is 1>
			<cfset TotalBy="DateUsed">
			<cfif listfindnocase(#fieldsToUse#,"DateUsed")>
			<cfelse>
				<cfset FieldsToUse=ListAppend(#fieldsToUse#,"DateUsed")>
			</cfif>
		</cfif>
		
		<cfif #SortBy# neq ""><cfset WhereStatement="#WhereSTatement# order by #Sortby#"></cfif>

		<!--- <cfoutput>select #FieldsToUse# from #tablesToUse# #WhereStatement#<br></cfoutput> --->

		<cfset records=QueryNew("FieldsToUse,TablesToUse,WhereStatement,SubTotalOnItem,SubTotalOnDate,IncludeItemCount,TotalBy")>
		<CFSET newRow  = QueryAddRow(records, 1)>
		<CFSET temp = QuerySetCell(records, "FieldsToUse","#FieldsToUse#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "TablesToUse","#TablesToUse#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "WhereStatement","#WhereStatement#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "SubTotalOnItem","#SubTotalOnItem#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "SubTotalOnDate","#SubTotalOnDate#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "IncludeItemCount","#IncludeItemCount#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "TotalBy","#TotalBy#", #newRow#)>
		
		<cfreturn records>
	</cffunction>
	
	<cffunction name="runReportItems" access="remote" returntype="query" output="true">
		<cfargument name="FieldsToUse" type="string" required="yes">
		<cfargument name="TablesToUse" type="string" required="yes">
		<cfargument name="WhereStatement" type="string" required="yes">
		<cfargument name="SubTotalOnItem" type="string" required="yes">
		<cfargument name="SubTotalOnDate" type="string" required="yes">
		<cfargument name="IncludeItemCount" type="string" required="yes">
		<cfargument name="TotalBy" type="string" required="yes">
		<cfinclude template="vars.cfm">
		
		<cfset FieldsToUse=#arguments.FieldsToUse#>
		<cfset TablesToUse=#arguments.TablesToUse#>
		<cfset WhereStatement=#arguments.WhereStatement#>
		<cfset SubTotalOnItem=#arguments.SubTotalOnItem#>
		<cfset SubTotalOnDate=#arguments.SubTotalOnDate#>
		<cfset IncludeItemCount=#arguments.IncludeItemCount#>
		<cfset TotalBy=#arguments.TotalBy#>
		
		<cfquery name="theItems"  datasource="#DSN#" 
			username="#DSNUname#" password="#DSNPword#" >
				select #FieldsToUse# from #tablesToUse#
				#preservesinglequotes(whereStatement)#
		</cfquery>
		
		<cfset getItems=QueryNew("#FieldsToUse#")>
		<cfset tLen=ListLen(#FieldsToUse#)>
		
		<cfset ItemCount=0>
		<cfset TotalItemCount=0>
		<cfset quantityCount=0>
		<cfset subTotalLine="">
		<cfset subTotalField=#TotalBy#>
		
		<cfoutput query="theItems">
			
			<cfif subTotalField neq "none">
				<cfif subTotalLine is "">
					<cfset subTotalLine=evaluate(#subTotalField#)>
				</cfif>
				<cfset subTotalData=evaluate(#subTotalField#)>
				<cfif #subTotalLine# neq #subTotalData#>
					<cfset doTotalLIne=1>
					<cfset 	#subTotalLine# = #subTotalData#	>		

				<cfelse>
					<cfset doTotalLine=0>
				</cfif>
			</cfif>
			
			<cfif subTotalField neq "none">
				<cfif doTotalLine is 1>
					<CFSET newRow  = QueryAddRow(getItems, 1)>
					<cfset FieldCount=1>
					<cfloop list="#FieldsToUse#" index="theField">
						<cfif FieldCount is 3>
							<CFSET temp = QuerySetCell(getItems,#theField#,#quantityCount#,#newRow#)>
							<cfset quantityCount=0>
						<cfelseif FieldCount is 4>
							<CFSET temp = QuerySetCell(getItems,#theField#,"Line Items",#newRow#)>
						<cfelseif FieldCount is 5>
							<CFSET temp = QuerySetCell(getItems,#theField#,#ItemCount#,#newRow#)>
							<cfset ItemCount=0>
						<cfelseif FieldCount is 2>
							<CFSET temp = QuerySetCell(getItems,#theField#,"for #subTotalField#",#newRow#)>
						<cfelseif FieldCount is 1>
							<CFSET temp = QuerySetCell(getItems, #theField#,"Total #theField#", #newRow#)>
						<cfelse>
							<CFSET temp = QuerySetCell(getItems, #theField#," ", #newRow#)>
						</cfif>
						<cfset FieldCount=FieldCount + 1>
					</cfloop>
				</cfif>
			</cfif>
			
			<cfif isdefined('theItems.quantity')>
				<cfset quantityCount=quantityCount + #quantity#>
			</cfif>
			
			<CFSET newRow  = QueryAddRow(getItems, 1)>
			<cfloop list="#FieldsToUse#" index="theField">
				<cfset theData=evaluate(#theField#)>
				<cfif isDate(theData)><cfset thisData=dateformat(theData,"mm/dd/yyyy")>
				<cfelse><cfset thisData=theData></cfif>
				<CFSET temp = QuerySetCell(getItems, #theField#,#thisData#, #newRow#)>
			</cfloop>
			
			<cfset TotalItemCount=TotalItemCount + 1>
			<cfset ItemCount=ItemCount + 1>

		</cfoutput>
		
		<cfif subTotalField neq "none">
			<CFSET newRow  = QueryAddRow(getItems, 1)>
			<cfset FieldCount=1>
			<cfloop list="#FieldsToUse#" index="theField">
				<cfif FieldCount is 3>
					<CFSET temp = QuerySetCell(getItems,#theField#,#quantityCount#,#newRow#)>
					<cfset quantityCount=0>
				<cfelseif FieldCount is 4>
					<CFSET temp = QuerySetCell(getItems,#theField#,"Line Items",#newRow#)>
				<cfelseif FieldCount is 5>
					<CFSET temp = QuerySetCell(getItems,#theField#,#ItemCount#,#newRow#)>
					<cfset ItemCount=0>
				<cfelseif FieldCount is 2>
					<CFSET temp = QuerySetCell(getItems,#theField#,"for #subTotalField#",#newRow#)>
				<cfelseif FieldCount is 1>
					<CFSET temp = QuerySetCell(getItems, #theField#,"Total #theField#", #newRow#)>
				<cfelse>
					<CFSET temp = QuerySetCell(getItems, #theField#," ", #newRow#)>
				</cfif>
				<cfset FieldCount=FieldCount + 1>
			</cfloop>
		</cfif>
			
		<cfreturn getItems>
		
	</cffunction>
	
	<cffunction name="saveNewsletter" access="remote" returntype="string" output="true">
		<cfargument name="NewsletterID" type="string" required="yes">
		<cfargument name="TheHeader" type="string" required="yes">
		<cfargument name="TheFooter" type="string" required="yes">
		<cfargument name="TheBody" type="string" required="yes">
		<cfargument name="dateCreated" type="string" required="yes">
		<cfargument name="dateLastSent" type="string" required="yes">
		<cfargument name="returnEmail" type="string" required="yes">
		<cfargument name="sentTo" type="string" required="yes">
		<cfargument name="Title" type="string" required="yes">
		<cfargument name="ReturnURL" type="string" required="yes">
		<cfargument name="ShowOnPage" type="string" required="yes">
		
		<cfset NewsletterID=#arguments.NewsletterID#>
		<cfif #NewsletterID# gt 0>
			<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				update newsletters set
				DateCreated='#arguments.DateCreated#',
				Name='#arguments.Title#',
				TheHeader='#arguments.TheHeader#',
				DateLastSent='#arguments.DateLastSent#',
				TheLetter='#arguments.TheBody#',
				SEntTo=#arguments.SEntTo#,
				TheFooter='#arguments.TheFooter#',
				ReturnEmail='#arguments.ReturnEmail#',
				ReturnURL='#arguments.ReturnURL#',
				eacPage='#arguments.ShowOnPage#'
				where ID=#NewsletterID#
			</cfquery>
		<cfelse>
			<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				insert into newsletters (DateCreated,Name,TheHeader,DateLastSent,TheLetter,SEntTo,TheFooter,ReturnEmail,ReturnURL,eacPage)
				values (
				'#arguments.DateCreated#','#arguments.Title#','#arguments.TheHeader#','#arguments.DateLastSent#','#arguments.TheBody#',#arguments.SEntTo#,'#arguments.TheFooter#','#arguments.ReturnEmail#','#arguments.ReturnURL#','#arguments.ShowOnPage#' )
			</cfquery>
			<cfquery name="getMax" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				select max(ID) as NewID from Newsletters
			</cfquery>
			<cfset NewsletterID=#getMax.NewID#>
		</cfif>
	</cffunction>
	
	<cffunction name="getNewsletters" access="remote" output="true" returntype="query">
		<cfargument name="NewsletterID" required="no" type="string" default="0">

		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecords" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#" >
			SELECT *
			FROM Newsletters
			<cfif #arguments.NewsletterID# gt 0>
				where ID=#arguments.NewsletterID#
			</cfif>
		</CFQUERY>
		<cfreturn GetRecords>
	</cffunction>
	
	<cffunction name="getAssessmentClients" access="remote" output="true" returntype="query">
		<cfargument name="alphabet" type="string" required="no" default="A">
		<cfargument name="searchParam" type="string" default="none" required="no">
		<cfargument name="searchValue" type="string" default="none" required="no">
		
		<cfinclude template="vars.cfm">
		
		<cfset searchParam=#arguments.searchParam#>
		<cfset searchValue=#arguments.searchValue#>
		<cfset searchID=0>
		<cfset searchlastname=0>
		<cfset searchemail=0>
		<cfif searchParam is "lastname">
			<cfset searchlastname=#searchValue#>
		</cfif>
		<cfif searchParam is "email">
			<cfset searchemail=#searchValue#>
		</cfif>
		<cfif searchParam is "memberID">
			<cfset searchID=#searchValue#>
		</cfif>
		
		<cfquery name="getNames" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select firstname,lastname,assessmentid,coachfirstname,coachlastname,email,phone,employer,CONVERT(CHAR(10),datecreated,110) as created,username from assessment
			<cfif #arguments.alphabet# neq "ALL">
				where ucase(lastname) like '#arguments.alphabet#%' 
				or lcase(lastname) like '#arguments.alphabet#%'
			</cfif>
			<cfif #searchID# neq 0>
			and assessmentID=#searchID#
			</cfif>
			<cfif #searchlastname# neq "0">
			and lastname like '#searchlastname#%'
			</cfif>
			<cfif #searchemail# neq "0">
			and email like '%#searchemail#%'
			</cfif>
			order by lastname
		</cfquery>
		<cfreturn getNames>
	</cffunction>
	
	<cffunction name="getAssessment" access="remote" output="true" returntype="query">
		<cfargument name="assessID" type="string" required="yes">
		
		<cfquery name="getNames" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select firstname,lastname,assessmentid from assessment
			order by lastname
		</cfquery>
		<cfreturn getNames>
	</cffunction>
	
	<cffunction name="getAdminAssessment" access="remote" output="true" returntype="query">
		<cfargument name="AssessmentID" type="string" required="yes">
		<cfargument name="Fields" type="string" required="yes">
		<cfinclude template="vars.cfm">
		
		<cfset Fields=replacenocase(#arguments.Fields#,"datecreated","CONVERT(CHAR(10),datecreated,110) as created")>BirthDate
		<cfset Fields=replacenocase(#arguments.Fields#,"BirthDate","CONVERT(CHAR(10),BirthDate,110) as BirthDate")>
		<cfquery name="Assessment" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select #arguments.fields# from assessment
			<cfif #arguments.AssessmentID# neq 0>
				where AssessmentID=#arguments.AssessmentID#
			</cfif>
			order by lastname
		</cfquery>
		<cfreturn Assessment>
	</cffunction>
	
	<cffunction name="saveAssessment" access="remote" output="true" returntype="string">
		<cfargument name="assessmentID" required="yes" type="string">
		<cfargument name="UserID" required="yes" type="string">
		<cfargument name="Fields" required="yes" type="string">
		<cfargument name="Content" required="yes" type="string">
		
		<cfinclude template="vars.cfm">
		<cfset ContentList=#arguments.Content#>
		<cfset Fields=#arguments.Fields#>
		<cfset lastCount=ListLen(#fields#)>
		<cfset UserID=#arguments.UserID#>
		<cfset assessmentID=#arguments.assessmentID#>
		<cfset tCount=1>
		<cfset StartDate=DateFormat(now())>
		<cfset EndDate=DateFormat(DateAdd("d",365,#startDate#))>
		
		<cfif assessmentID gt 0>	
			<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				update assessment set
				<cfloop index="theField" list="#Fields#">
					<cfif tCount is #LastCount#>
						#theField#='#ListGetAt(ContentList,LastCount,"~")#'
					<cfelse>
						#theField#='#ListGetAt(ContentList,tCount,"~")#',
						<cfset tCount=#tCount# + 1>
					</cfif>
				</cfloop>
				where AssessmentID = #AssessmentID#
			</cfquery>
		<cfelse>

			<cfset FirstName=ListGetAt(ContentList,1,"~")>
			<cfset LastName=ListGetAt(ContentList,2,"~")>
			<cfset Employer=ListGetAt(ContentList,3,"~")>
			<cfset BirthDate=ListGetAt(ContentList,4,"~")>
			<cfset Relationship=ListGetAt(ContentList,5,"~")>
			<cfset Children=ListGetAt(ContentList,6,"~")>
			<cfset PlanningSession=ListGetAt(ContentList,7,"~")>
			<cfset EACbenefit=ListGetAt(ContentList,8,"~")>
			<cfset Eligibility=ListGetAt(ContentList,9,"~")>
			<cfset UserName=ListGetAt(ContentList,10,"~")>
			<cfset xPassWord=ListGetAt(ContentList,11,"~")>
			<cfset CoachFirstName=ListGetAt(ContentList,12,"~")>
			<cfset CoachLastName=ListGetAt(ContentList,13,"~")>
			<cfset Address=ListGetAt(ContentList,14,"~")>
			<cfset City=ListGetAt(ContentList,15,"~")>
			<cfset State=ListGetAt(ContentList,16,"~")>
			<cfset Email=ListGetAt(ContentList,17,"~")>
			<cfset Phone=ListGetAt(ContentList,18,"~")>
			<cfset Occupation=ListGetAt(ContentList,19,"~")>
			<cfset sex=ListGetAt(ContentList,20,"~")>
			<cfset coachID=ListGetAt(ContentList,21,"~")>
			
			<cfif UserID is 0>
				<cfquery name="Insert" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					INSERT INTO Clients
					 ( FirstName,LastName, StartDate,EndDate,Logon,Password,Children,
					 Active,BirthDate,RelationshipStatus,Employer,
					 LastModified,Banned,PlanningSession,EACBenefit,Eligibility,
					 CoachID,CoachFirstName,CoachLastName) 
				 
					VALUES 
					( '#FirstName#',
					 '#LastName#',
					 '#dateformat(StartDate)#',
					 '#dateformat(EndDate)#',
					 '#UserName#',
					 '#xPassWord#',
					 '#children#',
					 1,
					 '#dateformat(BirthDate)#',
					 #Relationship#,
					 '#Employer#',
					 '#dateformat(now())#',
					 0,
					 '#PlanningSession#',
					 '#EACBenefit#',
					 '#Eligibility#',
					 '#coachID#',
					 '#coachFirstName#',
					 '#coachLastName#')
				</cfquery>
				<cfquery name="GetMaxID" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					select max(ClientID) as NewID from Clients
				</cfquery>
				<cfset tUserID=#GetMaxID.NewID#>
				
				<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
					insert into clientaddresses (connectID,address1,city,state,addresstypeid)
					values(#tUserID#,'#address#','#city#','#state#',1)
				</cfquery>
				<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
					insert into clientemail (connectid,emailaddress,emailtypeid)
					values (#tUserID#,'#email#',1)
				</cfquery>
				<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">	
					insert into clientphonenumbers (connectid,phonenumber,phonetypeid)
					values (#tUserID#,'#phone#',1)
				</cfquery>
			<cfelse>
				<cfquery name="update" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					update clients set 
					 FirstName='#FirstName#',
					 LastName='#LastName#', 
					 StartDate='#dateformat(StartDate)#',
					 EndDate='#dateformat(EndDate)#',
					 Logon='#UserName#',
					 Password='#xPassWord#',
					 Children='#children#',
					 Active=1,
					 BirthDate='#dateformat(BirthDate)#',
					 RelationshipStatus=#Relationship#,
					 Employer='#Employer#',
					 LastModified='#dateformat(now())#',
					 Banned=0,
					 PlanningSession='#PlanningSession#',
					 EACBenefit='#EACBenefit#',
					 Eligibility='#Eligibility#',
					 CoachID='#coachID#',
					 CoachFirstName=#coachFirstName#',
					 CoachLastName'#coachLastName#' 
					 where userid=#userID#
				</cfquery>
				<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
					update clientaddresses set 
					address1='#address#',
					city='#city#',
					state='#state#',
					addresstypeid=1
					where connectID=#userID#
				</cfquery>
				<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
					update clientemail set 
					emailaddress='#email#',emailtypeid=1
					where connectid=#UserID#
				</cfquery>
				<cfquery name="update" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">	
					update clientphonenumbers set phonenumber='#phone#',phonetypeid=1)
					where connectid=#UserID#
				</cfquery>
				<cfset age=datediff("yyyy",#birthdate#,now())>
				<cfquery name="Update" datasource="#application.DSN#"  
					username="#application.DSNuName#" password="#application.DSNpWord#">
					Update Members Set
					 FirstName='#FirstName#',
					 LastName='#LastName#',
					 AGe=#AGe#,
					 BirthDate='#dateformat(BirthDate)#',
					 Occupation='#Occupation#',
					 RelationshipStatus=#Relationship#,
					 sex=#sex#,
					 LastModified='#dateformat(now())#',
					 WebSiteURL='#PlanningSession#,#EACbenefit#,#Eligibility#',
					 Children='#children#'
					 where MemberID = #UserID#
				</cfquery>
				<cfquery name="Updateemail" datasource="#application.DSN#"  
					username="#application.DSNuName#" password="#application.DSNpWord#"> 
					update Email set
					 EMailAddress='#email#'
					 where ConnectID=#UserID#
				</cfquery>
				<cfquery name="UpdateNotifyMe" datasource="#application.DSN#"  
					username="#application.DSNuName#" password="#application.DSNpWord#"> 
					update NotifyMe set
					 EMAIL='#email#'
					 where Memberid=#UserID#
				</cfquery>
				<cfquery name="Updateaddress" datasource="#application.DSN#"  
					username="#application.DSNuName#" password="#application.DSNpWord#">
					update Addresses set
					 AddressTypeID=1,
					 Address1='#Address#',
					 City='#city#',
					 State='#State#''
					 where ConnectID=#UserID#
				</cfquery>
				<cfquery name="Updatephone" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					Update PhoneNumbers  set
					 PhoneNumber='#trim(phone)#'
					 Where ConnectID=#UserID#
					 and phonetypeid=1
				</cfquery>
			</cfif>
			<cfif #UserID# is 0>
				<cfset UserID=#tUserID#>
			</cfif>
			<cfquery name="insert" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">	
				insert into assessment (UserID,DateCreated,#fields#) values (#UserID#,'#dateformat(now())#','#FirstName#','#LastName#','#Employer#','#dateformat(BirthDate)#',				'#Relationship#','#Children#','#PlanningSession#','#EACbenefit#','#Eligibility#','#UserName#','#xPassWord#','#CoachFirstName#','#CoachLastName#','#address#','#city#','#state#','#email#','#phone#', '#Occupation#','#Sex#','#coachID#'
				)
			</cfquery>	
			
			<cfquery name="GetNextID" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				select max(AssessmentID) as NewID from Assessment
			</cfquery>
			<cfset AssessmentID=#getNextID.NewID#>
		</cfif>
		
		<cfif Fields eq "DepressionEvaluation">
			<cfset goAhead=0>
			<cfif ListFind(#content#,"3")>
				<cfset goAhead=1>
			</cfif>
			<cfif ListFind(#content#,"4")>
				<cfset goAhead=1>
			</cfif>
			<cfif goAhead eq 1>
				<cfquery name="getName" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					select * from assessment where assessmentID=#assessmentID#
				</cfquery>
				<cfmail to="urgent@eac-wellcoaches.com" replyto="urgent@eac-wellcoaches.com" from="urgent@eac-wellcoaches.com" subject="Urgent Depression Evaluation" bcc="jrobinson@wellcoaches.com" type="html" server="#MailServer#">
					#getName.firstname# #getName.lastname# <br>
					#getName.address#<br>
					#getName.City# #getName.state#<br>
					#getName.email#<br>
					#getName.phone#<br>
					has answered C (3) or D (4) to the depression evaluation<br><BR>
					below are the answers to each question<br><BR>
					Low In Energy=#ListGetAt(getName.DEPRESSIONEVALUATION,1)#<br>
					Blame Self=#ListGetAt(getName.DEPRESSIONEVALUATION,2)#<br>
					Poor Appetite=#ListGetAt(getName.DEPRESSIONEVALUATION,3)#<br>
					Sleep Difficulty=#ListGetAt(getName.DEPRESSIONEVALUATION,4)#<br>
					Feeling Hopeless=#ListGetAt(getName.DEPRESSIONEVALUATION,5)#<br>
					Feeling Blue=#ListGetAt(getName.DEPRESSIONEVALUATION,6)#<br>
					No Interest=#ListGetAt(getName.DEPRESSIONEVALUATION,7)#<br>
					worthlessness=#ListGetAt(getName.DEPRESSIONEVALUATION,8)#<br>
					Commit Suicide=#ListGetAt(getName.DEPRESSIONEVALUATION,9)#<br>
					Difficulty Concentrating=#ListGetAt(getName.DEPRESSIONEVALUATION,10)#<br>

				</cfmail>
			</cfif>
		</cfif>
		
		<cfif Fields eq "CurrentSymptoms">
			<cfset goAhead=0>
			<cfif ListFind(#content#,"1")>
				<cfset goAhead=1>
			</cfif>
			<cfif goAhead eq 1>
				<cfquery name="getName" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					select * from assessment where assessmentID=#assessmentID#
				</cfquery>
				<cfmail to="urgent@eac-wellcoaches.com" replyto="urgent@eac-wellcoaches.com" from="urgent@eac-wellcoaches.com" subject="Urgent Current Symptoms Evaluation" bcc="jrobinson@wellcoaches.com" type="html" server="#MailServer#">
					#getName.first# #getName.last# <br>
					#getName.address#<br>
					#getName.City# #getName.state#<br>
					#getName.email#<br>
					#getName.phone#<br>
					has answered yes (1) to any of the question for current symtoms<br><BR>
					below are the answers to each question<br><BR>
					a. Chest pain or discomfort, frequent palpitations or fluttering in the heart = #ListGetAt(contentList,1,"~")#<br>
					b. Unusual shortness of breath = #ListGetAt(contentList,2,"~")#<br>
					c. Unexplained dizziness or fainting = #ListGetAt(contentList,3,"~")#<br>
					d. Temporary sensation of numbness or tingling, paralysis, vision problem, or lightheadedness = #ListGetAt(contentList,4,"~")#<br>
					e. Frequent urination and unusual thirst = #ListGetAt(contentList,5,"~")#<br>
					f. Frequent back pain = #ListGetAt(contentList,6,"~")#<br>
					g. Have trouble sleeping lately = #ListGetAt(contentList,7,"~")#<br>

				</cfmail>
			</cfif>
		</cfif>
		
		<cfreturn AssessmentID>
	</cffunction>
	
	<cffunction name="getCoaches" access="remote" returntype="query" output="true">
		<cfargument name="alphabet" type="string" default="a" required="no">
		<cfargument name="searchParam" type="string" default="none" required="no">
		<cfargument name="searchValue" type="string" default="none" required="no">
		<cfinclude template="vars.cfm">
		<cfset alphabet=#arguments.alphabet#>
		<cfset searchParam=#arguments.searchParam#>
		<cfset searchValue=#arguments.searchValue#>
		<cfset searchID=0>
		<cfset searchlastname=0>
		<cfset searchemail=0>
		<cfif searchParam is "lastname">
			<cfset searchlastname=#searchValue#>
		</cfif>
		<cfif searchParam is "email">
			<cfset searchemail=#searchValue#>
		</cfif>
		<cfif searchParam is "memberID">
			<cfset searchID=#searchValue#>
		</cfif>
		
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT LTRIM(RTRIM(Members.FirstName)) as FirstName, Members.LastName, Email.EMailAddress, Members.StartDate, 	
			Members.EndDate, Members.Logon, Members.SubTypeID, Members.AccessLevel, Members.Active, 
			Members.WebSiteID, Members.MemberID , members.password, members.height,
			SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and members.subtypeid=2
			<cfif #alphabet# neq "all">
			and (members.lastname like '#lcase(alphabet)#%' or members.lastname like '#ucase(alphabet)#%')
			</cfif>
			<cfif #searchID# neq 0>
			and members.memberid=#searchID#
			</cfif>
			<cfif #searchlastname# neq "0">
			and members.lastname like '#searchlastname#%'
			</cfif>
			<cfif #searchemail# neq "0">
			and email.emailaddress like '%#searchemail#%'
			</cfif>
			Order by Members.LastName
		</CFQUERY>
		<cfoutput>SELECT Members.FirstName, Members.LastName, Email.EMailAddress, Members.StartDate, 	
			Members.EndDate, Members.Logon, Members.SubTypeID, Members.AccessLevel, Members.Active, 
			Members.WebSiteID, Members.MemberID , members.password, members.height,
			SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and members.subtypeid=2
			<cfif #alphabet# neq "all">
			and (members.lastname like '#lcase(alphabet)#%' or members.lastname like '#ucase(alphabet)#%')
			</cfif>
			<cfif #searchID# neq 0>
			and members.memberid=#searchID#
			</cfif>
			<cfif #searchlastname# neq "0">
			and members.lastname like '#searchlastname#%'
			</cfif>
			<cfif #searchemail# neq "0">
			and email.emailaddress like '%#searchemail#%'
			</cfif>
			Order by Members.LastName</cfoutput>
		<cfreturn getRecord>
	</cffunction>
	
	<cffunction name="getCoachLoginInfo" access="remote" returntype="string" output="true">
		<cfargument name="CoachID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			select logon,password from members where memberid=#arguments.CoachID#
		</CFQUERY>
		<cfset newurl="http://www.wellcoaches.com/scripts/coaching/loginlogic.cfm?pword=#getRecord.password#&uname=#getRecord.logon#">
		<cfreturn newurl>
	</cffunction>
	
	<cffunction name="getCoachLogin" access="remote" returntype="query" output="true">
		<cfargument name="uName" type="string" required="yes">
		<cfargument name="pssWord" type="string" required="yes">
		<cfinclude template="vars.cfm">

		<CFQUERY name="getCoach" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			select FirstName,LastName,MemberID from members where logon='#trim(arguments.uName)#' and password='#trim(arguments.pssWord)#'
		</CFQUERY>
		<cfif getCoach.recordcount gt 0>
			<cfset getRecord=QueryNew("FirstName,LastName,MemberID,FullName")>
			<cfset fullname="#trim(getCoach.firstname)# #trim(getCoach.Lastname)#">
			<CFSET newRow  = QueryAddRow(getRecord, 1)>
			<CFSET temp = QuerySetCell(getRecord, "FirstName","#getCoach.firstname#", #newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "LastName","#getCoach.lastname#",#newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "MemberID","#getCoach.memberid#",#newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "FullName","#fullname#",#newRow#)>
			<cfreturn GetRecord>
		<cfelse>
			<cfset getRecord=QueryNew("FirstName,LastName,MemberID,FullName")>
			<CFSET newRow  = QueryAddRow(getRecord, 1)>
			<CFSET temp = QuerySetCell(getRecord, "FirstName","none", #newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "LastName","none",#newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "MemberID","0",#newRow#)>
			<CFSET temp = QuerySetCell(getRecord, "FullName","0",#newRow#)>
			<cfreturn GetRecord>
		</cfif>
	</cffunction>
	
	<cffunction name="getCoach" access="remote" returntype="query" output="true">
		<cfargument name="CoachID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT Members.*,
			Addresses.Address1, 
			Addresses.Address2, 
			Addresses.City, 
			Addresses.State, 
			Addresses.PostalCode, 
			Email.EMailAddress, 
			PhoneNumbers.PhoneNumber,
			Addresses.Country, 
			Members.MemberID AS ID_Field,
			SubscriptionType.SubDescription AS SubType
			FROM Members,SubscriptionType, Email, Addresses, PhoneNumbers
			WHERE Members.SubTypeID = SubscriptionType.SubTypeID
			and Members.MemberID = #arguments.CoachID#
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and PhoneNumbers.TableID=15
			and PhoneNumbers.ConnectID = Members.MemberID
			and phonenumbers.phonetypeid=1
			and Addresses.tableid=15
			and Addresses.connectid = members.memberid
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>	
	
	<cffunction name="getClients" access="remote" returntype="query" output="true">
		<cfargument name="alphabet" type="string" default="a" required="no">
		<cfargument name="searchParam" type="string" default="none" required="no">
		<cfargument name="searchValue" type="string" default="none" required="no">
		<cfinclude template="vars.cfm">
		<cfset alphabet=#arguments.alphabet#>
		<cfset searchParam=#arguments.searchParam#>
		<cfset searchValue=#arguments.searchValue#>
		<cfset searchID=0>
		<cfset searchlastname=0>
		<cfset searchemail=0>
		<cfif searchParam is "lastname">
			<cfset searchlastname=#searchValue#>
		</cfif>
		<cfif searchParam is "email">
			<cfset searchemail=#searchValue#>
		</cfif>
		<cfif searchParam is "memberID">
			<cfset searchID=#searchValue#>
		</cfif>
		
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT LTRIM(RTRIM(Members.FirstName)) as FirstName, Members.LastName, Email.EMailAddress, Members.StartDate, 	
			Members.EndDate, Members.Logon, Members.SubTypeID, Members.AccessLevel, Members.Active, 
			Members.WebSiteID, Members.MemberID , members.password, members.height,
			SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and members.subtypeid=1
			<cfif #alphabet# neq "all">
			and (members.lastname like '#lcase(alphabet)#%' or members.lastname like '#ucase(alphabet)#%')
			</cfif>
			<cfif #searchID# neq 0>
			and members.memberid=#searchID#
			</cfif>
			<cfif #searchlastname# neq "0">
			and members.lastname like '#searchlastname#%'
			</cfif>
			<cfif #searchemail# neq "0">
			and email.emailaddress like '%#searchemail#%'
			</cfif>
			Order by Members.LastName
		</CFQUERY>

		<cfreturn getRecord>
	</cffunction>
	
	<cffunction name="getClientLoginInfo" access="remote" returntype="string" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			select logon,password,DATECREATED, assessementid from members where memberid=#arguments.ClientID#
		</CFQUERY>
		<cfset newurl="http://www.wellcoaches.com/scripts/clients/loginlogic.cfm?pword=#getRecord.password#&uname=#getRecord.logon#">
		<cfreturn newurl>
	</cffunction>
	
	<cffunction name="getClient" access="remote" returntype="query" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT Members.*,
			Addresses.Address1, 
			Addresses.Address2, 
			Addresses.City, 
			Addresses.State, 
			Addresses.PostalCode, 
			Email.EMailAddress, 
			PhoneNumbers.PhoneNumber,
			Addresses.Country, 
			Members.MemberID AS ID_Field,
			SubscriptionType.SubDescription AS SubType
			FROM Members,SubscriptionType, Email, Addresses, PhoneNumbers
			WHERE Members.SubTypeID = SubscriptionType.SubTypeID
			and Members.MemberID = #arguments.ClientID#
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and PhoneNumbers.TableID=15
			and PhoneNumbers.ConnectID = Members.MemberID
			and phonenumbers.phonetypeid=1
			and Addresses.tableid=15
			and Addresses.connectid = members.memberid
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>	
	
	<cffunction name="GetCoachTypes" access="remote" returntype="query" output="true">
		
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecords" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT subscriptiontype.SubTypeID, SubscriptionType.SubDescription, SubscriptionType.WebSiteID, SubscriptionType.DateStarted, SubscriptionType.DateEnded, SubscriptionType.SubTypeID AS ID_Field
				FROM SubscriptionType
		</CFQUERY>
		<cfreturn getRecords>
	</cffunction>
	
	<cffunction name="GetCoachType" access="remote" returntype="query" output="true">
		<cfargument name="SubTypeID" type="string" required="no">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecords" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT *
			FROM SubscriptionType
			where SubTypeID=#arguments.SubTypeID#
		</CFQUERY>
		<cfreturn getRecords>
	</cffunction>
	
	<cffunction name="saveCoachType" access="remote" returntype="string" output="true">
		<cfargument name="subTypeID" required="yes" type="string">
		<cfargument name="description" required="yes" type="string">
		<cfinclude template="vars.cfm">
		<CFIF #arguments.subTypeID# gt 0>
			<CFQUERY name="update" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
				update subscriptionType
				set SubDescription='#arguments.description#'
				where subtypeid=#arguments.subtypeid#
			</CFQUERY>
		<CFELSE>
			<CFQUERY name="update" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
				insert into subscriptionType
				(subDescription,WebSiteID,DateStarted,DateEnded)
				values ('#arguments.description#',1,'#now()#','#dateadd("d",365,now())#')
			</CFQUERY>
		
		</CFIF>
		<cfreturn subTypeID>
	</cffunction>
	
	<cffunction name="getEmployers" access="remote" returntype="query" output="true">
		<cfargument name="alphabet" type="string" default="a" required="no">
		<cfargument name="searchParam" type="string" default="none" required="no">
		<cfargument name="searchValue" type="string" default="none" required="no">
		<cfinclude template="vars.cfm">
		<cfset alphabet=#arguments.alphabet#>
		<cfset searchParam=#arguments.searchParam#>
		<cfset searchValue=#arguments.searchValue#>
		<cfset searchID=0>
		<cfset searchlastname=0>
		<cfset searchemail=0>
		<cfif searchParam is "lastname">
			<cfset searchlastname=#searchValue#>
		</cfif>
		<cfif searchParam is "email">
			<cfset searchemail=#searchValue#>
		</cfif>
		<cfif searchParam is "memberID">
			<cfset searchID=#searchValue#>
		</cfif>
		
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT LTRIM(RTRIM(Members.FirstName)) as FirstName, Members.LastName, Email.EMailAddress, Members.StartDate, 	
			Members.EndDate, Members.Logon, Members.SubTypeID, Members.AccessLevel, Members.Active, 
			Members.WebSiteID, Members.MemberID , members.password, members.height,
			SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and members.subtypeid=5
			<cfif #alphabet# neq "all">
			and (members.lastname like '#lcase(alphabet)#%' or members.lastname like '#ucase(alphabet)#%')
			</cfif>
			<cfif #searchID# neq 0>
			and members.memberid=#searchID#
			</cfif>
			<cfif #searchlastname# neq "0">
			and members.lastname like '#searchlastname#%'
			</cfif>
			<cfif #searchemail# neq "0">
			and email.emailaddress like '%#searchemail#%'
			</cfif>
			Order by Members.LastName
		</CFQUERY>

		<cfreturn getRecord>
	</cffunction>
	
	<cffunction name="getEmployerLoginInfo" access="remote" returntype="string" output="true">
		<cfargument name="EmployerID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			select logon,password from members where memberid=#arguments.EmployerID#
		</CFQUERY>
		<cfset newurl="http://www.wellcoaches.com/scripts/clients/loginlogic.cfm?pword=#getRecord.password#&uname=#getRecord.logon#">
		<cfreturn newurl>
	</cffunction>
	
	<cffunction name="getEmployer" access="remote" returntype="query" output="true">
		<cfargument name="EmployerID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="GetRecord" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
			SELECT Members.*,
			Addresses.Address1, 
			Addresses.Address2, 
			Addresses.City, 
			Addresses.State, 
			Addresses.PostalCode, 
			Email.EMailAddress, 
			PhoneNumbers.PhoneNumber,
			Addresses.Country, 
			Members.MemberID AS ID_Field,
			SubscriptionType.SubDescription AS SubType
			FROM Members,SubscriptionType, Email, Addresses, PhoneNumbers
			WHERE Members.SubTypeID = SubscriptionType.SubTypeID
			and Members.MemberID = #arguments.EmployerID#
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and PhoneNumbers.TableID=15
			and PhoneNumbers.ConnectID = Members.MemberID
			and phonenumbers.phonetypeid=1
			and Addresses.tableid=15
			and Addresses.connectid = members.memberid
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>	
	
	<cffunction name="saveMember" returntype="string" output="true" access="remote">
		<cfargument name="memberID" type="string" required="yes">
		<cfargument name="FirstName" type="string" required="yes">
		<cfargument name="LastName" type="string" required="yes">
		<cfargument name="StartDate" type="string" required="yes">
		<cfargument name="EndDate" type="string" required="yes">
		<cfargument name="Logon" type="string" required="yes">
		<cfargument name="Password" type="string" required="yes">
		<cfargument name="SubTypeID" type="string" required="yes">
		<cfargument name="WebSiteID" type="string" required="yes">
		<cfargument name="AccessLevel" type="string" required="yes">
		<cfargument name="Active" type="string" required="yes">
		<cfargument name="WebsiteURL" type="string" required="yes">
		<cfargument name="AGe" type="string" required="yes">
		<cfargument name="BirthDate" type="string" required="yes">
		<cfargument name="Occupation" type="string" required="yes">
		<cfargument name="RelationshipStatus" type="string" required="yes">
		<cfargument name="FeePaid" type="string" required="yes">
		<cfargument name="sex" type="string" required="yes">
		<cfargument name="Height" type="string" required="yes">
		<cfargument name="CompanyID" type="string" required="yes">
		<cfargument name="EMailAddress" type="string" required="yes">
		<cfargument name="PhoneNumber" type="string" required="yes">
		<cfargument name="Address1" type="string" required="yes">
		<cfargument name="Address2" type="string" required="yes">
		<cfargument name="City" type="string" required="yes">
		<cfargument name="STate" type="string" required="yes">
		<cfargument name="Zip" type="string" required="yes">
		<cfargument name="Country" type="string" required="yes">
		<cfargument name="AltEMailAddress" type="string" required="yes">
		<cfargument name="WorkPhoneNumber" type="string" required="yes">
		
		<cfset memberID=#arguments.memberid#>
		<cfset FirstName=#arguments.FirstName#>
		<cfset LastName=#arguments.LastName#>
		<cfset StartDate=#arguments.StartDate#>
		<cfset EndDate=#arguments.EndDate#>
		<cfset Logon=#arguments.Logon#>
		<cfset Password=#arguments.Password#>
		<cfset SubTypeID=#arguments.SubTypeID#>
		<cfset WebSiteID=#arguments.WebSiteID#>
		<cfset AccessLevel=#arguments.AccessLevel#>
		<cfset Active=#arguments.Active#>
		<cfset WebsiteURL=#arguments.WebsiteURL#>
		<cfset AGe=#arguments.AGe#>
		<cfset BirthDate=#arguments.BirthDate#>
		<cfset Occupation=#arguments.Occupation#>
		<cfset RelationshipStatus=#arguments.RelationshipStatus#>
		<cfset FeePaid=#arguments.FeePaid#>
		<cfset sex=#arguments.sex#>
		<cfset Height=#arguments.Height#>
		<cfset CompanyID=#arguments.CompanyID#>
		<cfset EMailAddress=#arguments.EMailAddress#>
		<cfset PhoneNumber=#arguments.PhoneNumber#>
		<cfset Address1=#arguments.Address1#>
		<cfset Address2=#arguments.Address2#>
		<cfset City=#arguments.City#>
		<cfset STate=#arguments.STate#>
		<cfset PostalCode=#arguments.Zip#>
		<cfset Country=#arguments.Country#>
		<cfset AltEMailAddress=#arguments.AltEMailAddress#>
		<cfset WorkPhoneNumber=#arguments.WorkPhoneNumber#>
		
		<cfinclude template="vars.cfm">
		
		<CFIF MemberID gt 0>

			<cfquery name="Update" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				Update Members Set
				 FirstName='#trim(FirstName)#',
				 LastName='#LastName#',
				 StartDate='#dateformat(StartDate)#',
				 EndDate='#dateformat(EndDate)#',
				 Logon='#logon#',
				 Password='#password#',
				 SubTypeID=#SubTypeID#,
				 CompanyID=<cfif isnumeric(#CompanyID#)>#CompanyID#<cfelse>0</cfif>,
				 AccessLevel=<cfif #accesslevel# is ''>0<cfelse>#AccessLevel#</cfif>,
				 Active=#Active#,
				 WebsiteURL='#WebsiteURL#',
				 <cfif #Age# is ''><cfelse>AGe=#AGe#,</cfif>
				 BirthDate='#dateformat(BirthDate)#',
				 Occupation='#Occupation#',
				 RelationshipStatus=#RelationshipStatus#,
				 <cfif #FeePaid# is ''>FeePaid=0<cfelse>FeePaid=#FeePaid#</cfif>,
				 sex=#sex#,
				 Height='#Height#',
				 <cfif isdefined('banned')>banned=#banned#,</cfif>
				 LastModified='#dateformat(now())#'
				 where MemberID = #MemberID#
			</cfquery>
			<cfquery name="Updateemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#"> 
			update Email set
				 EMailAddress='#EMailAddress#'
				 where TableID=15
				 and ConnectID=#MemberID#
				 and WebSiteID= 1
			</cfquery>
			<cfquery name="GetAltEmail" datasource="#DSN#" username="#DSNuName#" password="#DSNpWord#">
				select emailaddress,Emailid
				from email 
				where connectid=#MemberID# 
				and email.tableid=15 and email.websiteid=2
			</cfquery>
			<cfif #GetAltEmail.RecordCount# gt 0>
				<cfquery name="Updateemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#"> 
					update Email set
					 EMailAddress='#AltEMailAddress#'
					 where EmailID=#GetAltEmail.EmailID#
				</cfquery>
			<cfelse>
				<cfquery name="Insertemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#"> 
					Insert into Email (
					emailaddress,tableid,websiteid,connectid)
					values(
					'#AltEMailAddress#',15,2,#MemberID#)
				</cfquery>
			</cfif>
			<cfquery name="Updateaddress" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			update Addresses set
				 AddressTypeID=1,
				 Address1='#Address1#',
				 Address2='#Address2#',
				 City='#City#',
				 State='#State#',
				 PostalCode='#PostalCode#',
				 Country='#Country#'
				 where TableID=15
				 and ConnectID=#MemberID#
			</cfquery>
			<cfquery name="Updatephone" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				Update PhoneNumbers  set
				 PhoneNumber='#PhoneNumber#'
				 Where TableID=15
				 and ConnectID=#MemberID#
				 and PhoneTypeID=1
				 
				 Update PhoneNumbers  set
				 PhoneNumber='#WorkPhoneNumber#'
				 Where TableID=15
				 and ConnectID=#MemberID#
				 and PhoneTypeID=2
			</cfquery>
	
		<CFELSE>
			
			<!--- the height field is the company code if it's a company --->
			<cfif #subtypeID# is 5>
				<cfif #trim(height)# is "">
					<CF_aGr_password mode="alpha" case="upper" lenght="5,15" var="height">
				<cfelse>
					<cfset height=#height#>
				</cfif>
			<cfelse>
				<cfset height=#height#>
			</cfif>
	
			<cfquery name="Insert" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				INSERT INTO Members
				 ( FirstName,
				 LastName,
				 StartDate,
				 EndDate,
				 Logon,
				 Password,
				 SubTypeID,
				 WebSiteID,
				 AccessLevel,
				 Active,
				 WebsiteURL,
				 AGe,
				 BirthDate,
				 Occupation,
				 RelationshipStatus,
				 FeePaid,
				 sex,
				 Height,
				 CompanyID,
				 LastModified) 
			 
				VALUES 
				( '#FirstName#',
				 '#LastName#',
				 '#dateformat(StartDate)#',
				 '#dateformat(EndDate)#',
				 '#uName#',
				 '#pWord#',
				 #SubTypeID#,
				 #WebSiteID#,
				 #AccessLevel#,
				 #Active#,
				 '#WebsiteURL#',
				 #AGe#,
				 '#dateformat(BirthDate)#',
				 '#Occupation#',
				 #RelationshipStatus#,
				 #FeePaid#,
				 #sex#,
				 '#Height#',
				 #companyid#,
				 '#dateformat(now())#')
			</cfquery>
			<cfquery name="GetNextID" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				select max(MemberID) as NewID from Members
			</cfquery>
			<cfset MemberID = #GetNextID.NewID#>
			
			<cfif #SubTypeID# is 1>
				<cfquery name="AddClientGoal" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					insert into client (
					Client_name, MemberID )
					values (
					'#trim(Firstname)# #trim(lastname)#',
					#MemberID# )
				</cfquery>
			<cfelseif #SubTypeID# neq 5>
				<cfquery name="AddClientGoal" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
					insert into analyst (
					analyst_firstname,
					analyst_lastname, 
					MemberID,
					analyst_email )
					values (
					'#trim(Firstname)#', 
					'#trim(lastname)#',
					#MemberID# ,
					'#EMailAddress#')
				</cfquery>
			</cfif>
			<cfquery name="Insert" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
				 
			INSERT INTO Email 
				 ( EMailAddress,
				 TableID,
				 ConnectID,
				 WebSiteID) 
			 
			VALUES 
				( '#EMailAddress#',
				 15,
				 #MemberID#,
				 1)
				
			INSERT INTO Addresses
				 ( AddressTypeID,
				 Address1,
				 Address2,
				 City,
				 State,
				 PostalCode,
				 Country,
				 TableID,
				 ConnectID) 
			 
			VALUES 
				( 1,
				 '#Address1#',
				 '#Address2#',
				 '#City#',
				 '#State#',
				 '#PostalCode#',
				 '#Country#',
				 15,
				 #MemberID#)
				
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 phonetypeid) 
			 
			VALUES 
				( '#PhoneNumber#',
				 15,
				 #MemberID#,
				 1)
			</cfquery>
	
		</CFIF>
		<cfreturn MemberID>
	</cffunction>
	
	<cffunction name="getCoachOfficePhone" access="remote" returntype="string" output="true">
		<cfargument name="CoachID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getPhone" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select PhoneNumber from PhoneNumbers where connectid=#arguments.CoachID#
			and phonetypeid=2
		</cfquery>
		<cfset phone=#getPhone.phonenumber#>
		<cfreturn phone>
	</cffunction>
	<cffunction name="getCoachAltEmail" access="remote" returntype="string" output="true">
		<cfargument name="CoachID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select emailaddress 
			from email 
			where connectid=#arguments.CoachID# 
			email.websiteid=2
		</cfquery>
		<cfset email=#getemail.emailaddress#>
		<cfreturn email>
	</cffunction>
	
	<cffunction name="getEmployerOfficePhone" access="remote" returntype="string" output="true">
		<cfargument name="EmployerID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getPhone" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select PhoneNumber from PhoneNumbers where connectid=#arguments.EmployerID#
			and phonetypeid=2
		</cfquery>
		<cfset phone=#getPhone.phonenumber#>
		<cfreturn phone>
	</cffunction>
	<cffunction name="getEmployerAltEmail" access="remote" returntype="string" output="true">
		<cfargument name="EmployerID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select emailaddress 
			from email 
			where connectid=#arguments.EmployerID# 
			email.websiteid=2
		</cfquery>
		<cfset email=#getemail.emailaddress#>
		<cfreturn email>
	</cffunction>
	
	<cffunction name="getClientOfficePhone" access="remote" returntype="string" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getPhone" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select PhoneNumber from PhoneNumbers where connectid=#arguments.ClientID#
			and phonetypeid=2
		</cfquery>
		<cfset phone=#getPhone.phonenumber#>
		<cfreturn phone>
	</cffunction>
	
	<cffunction name="getClientAltEmail" access="remote" returntype="string" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="getemail" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select emailaddress 
			from email 
			where connectid=#arguments.ClientID# 
			email.websiteid=2
		</cfquery>
		<cfset email=#getemail.emailaddress#>
		<cfreturn email>
	</cffunction>
	
	<cffunction name="getLogCats" access="remote" returntype="query" output="true">
		<cfargument name="categoryID" type="string" required="no" default="0">
		<cfinclude template="vars.cfm">
		<cfquery name="logTypes" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			Select * from notecategories
			<cfif #arguments.categoryID# neq 0>
				where categoryID=#arguments.categoryID#
			</cfif>
		</cfquery>

		<cfreturn logTypes>
	</cffunction>
	
	<cffunction name="deleteLogCats" access="remote" returntype="string" output="true">
		<cfargument name="CategoryID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="Delete" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			delete from notecategories
			where categoryID = #arguments.categoryID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="saveLogCats" access="remote" output="true" returntype="string">
		<cfargument name="CategoryID" type="string" required="yes">
		<cfargument name="description" type="string" required="yes">
		<cfargument name="idrangeend" type="string" required="yes">
		<cfargument name="idrangestart" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfif #arguments.CategoryID# neq 0>
			<cfquery name="Update" datasource="#DSN#"  
				username="#DSNuName#" password="#DSNpWord#">
				update notecategories set
				description='#arguments.description#',
				idrangeend=#arguments.idrangeend#,
				idrangestart=#arguments.idrangestart#
				where categoryID=#arguments.CategoryID#
			</cfquery>
		<cfelse>
			<cfquery name="Insert" datasource="#DSN#"  
				username="#DSNuName#" password="#DSNpWord#">
				insert into notecategories ( description,idrangeend,idrangestart)
		values('#arguments.description#',#arguments.idrangeend#,#arguments.idrangestart#)
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="getLogTypes" access="remote" returntype="query" output="true">
		<cfargument name="CategoryID" type="string" required="no" default="0">
		<cfargument name="TypeID" type="string" required="no" default="0">
		<cfinclude template="vars.cfm">

		<cfquery name="logTypes" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			Select notetypes.*, notecategories.description , 
			notecategories.idrangestart, notecategories.idrangeend
			from notetypes,notecategories 
			where notecategories.categoryid=notetypes.notecategoryid
			<cfif #arguments.CategoryID# neq 0>
				and notecategories.categoryID=#arguments.CategoryID#
			</cfif>
			<cfif #arguments.TypeID# neq 0>
				and notetypes.ID=#arguments.TypeID#
			</cfif>
		</cfquery>

		<cfreturn logTypes>
	</cffunction>
	
	<cffunction name="deleteLogTypes" access="remote" returntype="string" output="true">
		<cfargument name="TypeID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="Delete" datasource="#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			delete from notetypes
			where ID = #arguments.TypeID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="saveLogTypes" access="remote" output="true" returntype="string">
		<cfargument name="CategoryID" type="string" required="yes">
		<cfargument name="TYPEDESCRIPTION" type="string" required="yes">
		<cfargument name="TYPECOMMENTS" type="string" required="yes">
		<cfargument name="EXPLANATION" type="string" required="yes">
		<cfargument name="NOTECATEGORYID" type="string" required="yes">
		<cfargument name="TYPEID" type="string" required="yes">
		
		<cfinclude template="vars.cfm">
		<cfif #arguments.CategoryID# neq 0>
			<cfquery name="Update" datasource="#DSN#"  
				username="#DSNuName#" password="#DSNpWord#">
				update notetypes set
				TYPEDESCRIPTION='#arguments.TYPEDESCRIPTION#',
				TYPECOMMENTS='#arguments.TYPECOMMENTS#',
				EXPLANATION='#arguments.EXPLANATION#',
				NOTECATEGORYID=#arguments.NOTECATEGORYID#,
				TYPEID=#arguments.TypeID#
				where ID=#arguments.CategoryID#
				</cfquery>
		<cfelse>
			<cfquery name="Insert" datasource="#DSN#"  
				username="#DSNuName#" password="#DSNpWord#">
				insert into notetypes ( TYPEDESCRIPTION,NOTECATEGORYID,TYPEID,
				EXPLANATION,TYPECOMMENTS)
				values('#arguments.TYPEDESCRIPTION#',#arguments.NOTECATEGORYID#,
				#arguments.TYPEID#,'#arguments.explanation#','#arguments.typecomments#')
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="BMI" access="remote" output="true" returntype="string">
		<cfargument name="height" type="string" required="yes">
		<cfargument name="weight" type="string" required="yes">

			<cfset w = #arguments.weight#>
			<cfset HeightFeet = #arguments.height#>
			<cfset h = HeightFeet>
			<cftry>
				<cfset displaybmi = round((w * 703) / (h * h))>
				<cfif w lte 35 or w gte 500  or h lte 48 or h gte 120>
					<cfset bmi_txt = "Invalid data.  Please check and re-enter!">
				<cfelse>
					<cfset bmi_txt = displaybmi>
				</cfif>
				<cfcatch>
					<cfset bmi_txt=0>
				</cfcatch>
			</cftry>

		<cfreturn bmi_txt>
	</cffunction>
	
	<cffunction name="CalculateOneAssessment" access="remote" output="true" returntype="query">
		<cfargument name="assessmentID" type="string" required="yes">
		<cfinclude template="../utilities/vars.cfm">
		<cfquery name="theAssessment" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select * from assessment
			where assessmentID=#arguments.assessmentID#
		</cfquery>

		<cfset confidenceTotal=0>
		<cfset confidenceCount=0>
		<cfloop index="element" list="#theAssessment.confidence#">
			<cfif #element# is 1><cfset confidenceTotal=#confidenceTotal# + 20><cfset confidenceCount=confidenceCount + 1></cfif>
			<cfif #element# is 2><cfset confidenceTotal=#confidenceTotal# + 40><cfset confidenceCount=confidenceCount + 1></cfif>
			<cfif #element# is 3><cfset confidenceTotal=#confidenceTotal# + 60><cfset confidenceCount=confidenceCount + 1></cfif>
			<cfif #element# is 4><cfset confidenceTotal=#confidenceTotal# + 80><cfset confidenceCount=confidenceCount + 1></cfif>
			<cfif #element# gte 5><cfset confidenceTotal=#confidenceTotal# + 100><cfset confidenceCount=confidenceCount + 1></cfif>
		</cfloop>
		<cfif confidenceCount gt 0>
			<cfset confidencePercent=round(#confidenceTotal# / confidenceCount)>
		<cfelse>
			<cfset confidencePercent=0>
		</cfif>
		
		<cfset weightPercent=0>
		<cfinvoke method="BMI" returnvariable="thisBMI">
			<cfinvokeargument name="height" value="#theassessment.height#">
			<cfinvokeargument name="weight" value="#theassessment.CurrentWeight#">
		</cfinvoke>
		<cfif thisBMI gte 35><cfset weightPercent=20></cfif>
		<cfif thisBMI gte 30.0 and thisBMI lte 34.9><cfset weightPercent=40></cfif>
		<cfif thisBMI gte 27.5 and thisBMI lte 29.9><cfset weightPercent=60></cfif>
		<cfif thisBMI gte 25 and thisBMI lte 27.4><cfset weightPercent=80></cfif>
		<cfif thisBMI gt 0 and thisBMI lte 24.9><cfset weightPercent=100></cfif>

		<cfset exercisePercent=0>
		<cfset ActivityPercent=0>
		<cfif #theAssessment.RegularActivity# gt 0><cfset ActivityPercent=100></cfif>
		<cfif #theAssessment.RegularActivity# is ""><cfset ActivityPercent=0></cfif>
		<cfset MinutesPercent=0>
		<cfif ActivityPercent is 0>
			<cfif #isNumeric(theAssessment.ActivityMinutes)#>
				<cfset xMinutes=#theAssessment.ActivityMinutes#>
				<cfif #xMinutes# gte 30><cfset MinutesPercent=100></cfif>
				<cfif #xMinutes# gte 20 and #xMinutes# lte 29><cfset MinutesPercent=80></cfif> 
				<cfif #xMinutes# gte 15 and #xMinutes# lte 19><cfset MinutesPercent=60></cfif> 
				<cfif #xMinutes# gte 10 and #xMinutes# lte 14><cfset MinutesPercent=40></cfif> 
				<cfif #xMinutes# gt 0 and #xMinutes# lte 9><cfset MinutesPercent=20></cfif>
			</cfif>
			
		</cfif>
		<cfset aerobicPercent=0>
		<cfif #theAssessment.AerobicExercise# is 0><cfset aerobicPercent=20></cfif>
		<cfif #theAssessment.AerobicExercise# is 1><cfset aerobicPercent=40></cfif>
		<cfif #theAssessment.AerobicExercise# is 2><cfset aerobicPercent=60></cfif>
		<cfif #theAssessment.AerobicExercise# gte 3><cfset aerobicPercent=20></cfif>
		<cfset strengthPercent=0>
		<cfif #theAssessment.StrengthExercises# is 1><cfset strengthPercent=80></cfif>
		<cfif #theAssessment.StrengthExercises# is 2><cfset strengthPercent=100></cfif>
		<cfif #theAssessment.StrengthExercises# is 3><cfset strengthPercent=100></cfif>
		<cfif #theAssessment.StrengthExercises# is 0><cfset strengthPercent=20></cfif>
		<cfset stretchPercent=0>
		<cfif #theAssessment.StretchingExercises# is 0><cfset stretchPercent=20></cfif>
		<cfif #theAssessment.StretchingExercises# is 1><cfset stretchPercent=60></cfif>
		<cfif #theAssessment.StretchingExercises# is 2><cfset stretchPercent=80></cfif>
		<cfif #theAssessment.StretchingExercises# is 3><cfset stretchPercent=100></cfif>
		<cfset exerciseCount=5>
		<cfif #ActivityPercent# is 0><cfset exerciseCount=exerciseCount - 1></cfif>
		<cfif #MinutesPercent# is 0><cfset exerciseCount=exerciseCount - 1></cfif>
		<cfif #strengthPercent# is 0><cfset exerciseCount=exerciseCount - 1></cfif>
		<cfif #stretchPercent# is 0><cfset exerciseCount=exerciseCount - 1></cfif>
		<cfif #aerobicPercent# is 0><cfset exerciseCount=exerciseCount - 1></cfif>
		<cfif #exerciseCount# gt 0>
			<cfset exercisePercent=round((ActivityPercent + MinutesPercent + strengthPercent + stretchPercent + aerobicPercent) / exerciseCount)>
		<cfelse>
			<cfset exercisePercent=0>
		</cfif>

		
		<cfset breakfastPercent=0>
		<cfif #theAssessment.Breakfast# is 1><cfset breakfastPercent=20></cfif>
		<cfif #theAssessment.Breakfast# is 2><cfset breakfastPercent=40></cfif>
		<cfif #theAssessment.Breakfast# is 3><cfset breakfastPercent=80></cfif>
		<cfif #theAssessment.Breakfast# is 4><cfset breakfastPercent=100></cfif>
		<cfset SnacksPercent=0>
		<cfif #theAssessment.Snacks# is 1><cfset SnacksPercent=20></cfif>
		<cfif #theAssessment.Snacks# is 2><cfset SnacksPercent=40></cfif>
		<cfif #theAssessment.Snacks# is 3><cfset SnacksPercent=80></cfif>
		<cfif #theAssessment.Snacks# is 4><cfset SnacksPercent=100></cfif>
		<cfset fatsPercent=0>
		<cfif #theAssessment.FatIntake# is 1><cfset fatsPercent=20></cfif>
		<cfif #theAssessment.FatIntake# is 2><cfset fatsPercent=40></cfif>
		<cfif #theAssessment.FatIntake# is 3><cfset fatsPercent=60></cfif>
		<cfif #theAssessment.FatIntake# is 4><cfset fatsPercent=80></cfif>
		<cfif #theAssessment.FatIntake# is 5><cfset fatsPercent=100></cfif>
		<cfset transPercent=0>
		<cfif #theAssessment.TransFats# is 1><cfset transPercent=20></cfif>
		<cfif #theAssessment.TransFats# is 2><cfset transPercent=40></cfif>
		<cfif #theAssessment.TransFats# is 3><cfset transPercent=60></cfif>
		<cfif #theAssessment.TransFats# is 4><cfset transPercent=80></cfif>
		<cfif #theAssessment.TransFats# is 5><cfset transPercent=100></cfif>
		<cfset breadPercent=0>
		<cfif #theAssessment.BreadsGrains# is 1><cfset breadPercent=20></cfif>
		<cfif #theAssessment.BreadsGrains# is 2><cfset breadPercent=40></cfif>
		<cfif #theAssessment.BreadsGrains# is 3><cfset breadPercent=60></cfif>
		<cfif #theAssessment.BreadsGrains# is 4><cfset breadPercent=80></cfif>
		<cfif #theAssessment.BreadsGrains# is 5><cfset breadPercent=100></cfif>
		<cfset fruitPercent=0>
		<cfif #theAssessment.FruitsAndVeggies# is 1><cfset fruitPercent=20></cfif>
		<cfif #theAssessment.FruitsAndVeggies# is 2><cfset fruitPercent=40></cfif>
		<cfif #theAssessment.FruitsAndVeggies# is 3><cfset fruitPercent=60></cfif>
		<cfif #theAssessment.FruitsAndVeggies# is 4><cfset fruitPercent=80></cfif>
		<cfif #theAssessment.FruitsAndVeggies# is 5><cfset fruitPercent=100></cfif>
		<cfset WaterPercent=0>
		<cfif #theAssessment.Water# is 1><cfset WaterPercent=20></cfif>
		<cfif #theAssessment.Water# is 2><cfset WaterPercent=40></cfif>
		<cfif #theAssessment.Water# is 3><cfset WaterPercent=60></cfif>
		<cfif #theAssessment.Water# is 4><cfset WaterPercent=80></cfif>
		<cfif #theAssessment.Water# is 5><cfset WaterPercent=100></cfif>
		<cfset softPercent=0>
		<cfif #theAssessment.SoftDrinks# is 1><cfset softPercent=20></cfif>
		<cfif #theAssessment.SoftDrinks# is 2><cfset softPercent=40></cfif>
		<cfif #theAssessment.SoftDrinks# is 3><cfset softPercent=60></cfif>
		<cfif #theAssessment.SoftDrinks# is 4><cfset softPercent=80></cfif>
		<cfif #theAssessment.SoftDrinks# is 5><cfset softPercent=100></cfif>
		<cfset weekDayPercent=0>
		<cfif #theAssessment.WeekDayAlcohol# is 1><cfset weekDayPercent=20></cfif>
		<cfif #theAssessment.WeekDayAlcohol# is 2><cfset weekDayPercent=40></cfif>
		<cfif #theAssessment.WeekDayAlcohol# is 3><cfset weekDayPercent=80></cfif>
		<cfif #theAssessment.WeekDayAlcohol# is 4><cfset weekDayPercent=100></cfif>
		<cfset WeekEndPercent=0>
		<cfif #theAssessment.WeekEndAlcohol# is 1><cfset weekEndPercent=20></cfif>
		<cfif #theAssessment.WeekEndAlcohol# is 2><cfset weekEndPercent=40></cfif>
		<cfif #theAssessment.WeekEndAlcohol# is 3><cfset weekEndPercent=80></cfif>
		<cfif #theAssessment.WeekEndAlcohol# is 4><cfset weekEndPercent=100></cfif>
		<cfset NutritionPercent=0>
		<cfset nutritionCount=10>
		<cfif #weekEndPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #weekDayPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #softPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #WaterPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #fruitPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #breadPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #transPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #fatsPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #SnacksPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif #breakfastPercent# is 0><cfset nutritionCount=nutritionCount - 1></cfif>
		<cfif nutritionCount gt 0>
		<cfset NutritionPercent=round((weekEndPercent + weekDayPercent + softPercent + WaterPercent + fruitPercent + breadPercent + transPercent + fatsPercent + SnacksPercent + breakfastPercent )/ nutritionCount)>
		<cfelse>
			<cfset NutritionPercent=0>
		</cfif>
		
		<cfset overallPercent=0>
		<cfif #theAssessment.OverallHealth# is 1><cfset overallPercent=20></cfif>
		<cfif #theAssessment.OverallHealth# is 2><cfset overallPercent=40></cfif>
		<cfif #theAssessment.OverallHealth# is 3><cfset overallPercent=60></cfif>
		<cfif #theAssessment.OverallHealth# is 4><cfset overallPercent=80></cfif>
		<cfif #theAssessment.OverallHealth# is 5><cfset overallPercent=100></cfif>
		<cfset PhysicianPercent=0>
		<cfif #theAssessment.PhysicianRelationship# is 1><cfset PhysicianPercent=20></cfif>
		<cfif #theAssessment.PhysicianRelationship# is 2><cfset PhysicianPercent=60></cfif>
		<cfif #theAssessment.PhysicianRelationship# is 3><cfset PhysicianPercent=100></cfif>
		<cfset examPercent=0>
		<cfif #theAssessment.PhysicalExam# is 1><cfset examPercent=20></cfif>
		<cfif #theAssessment.PhysicalExam# is 2><cfset examPercent=60></cfif>
		<cfif #theAssessment.PhysicalExam# is 3><cfset examPercent=80></cfif>
		<cfif #theAssessment.PhysicalExam# is 4><cfset examPercent=100></cfif>
		<cfset SystolicPercent=0>
		<cfif #theAssessment.Systolic# gt 0 and #theAssessment.Systolic# lte 120><cfset SystolicPercent=100></cfif>
		<cfif #theAssessment.Systolic# gte 121 and #theAssessment.Systolic# lte 139>
			<cfset SystolicPercent=60></cfif>
		<cfif #theAssessment.Systolic# gte 140><cfset SystolicPercent=40></cfif>
		<cfset DiastolicPercent=0>
		<cfif #theAssessment.Diastolic# gt 0 and #theAssessment.Diastolic# lte 80><cfset DiastolicPercent=100></cfif>
		<cfif #theAssessment.Diastolic# gte 81 and #theAssessment.Diastolic# lte 89><cfset DiastolicPercent=60></cfif>
		<cfif #theAssessment.Diastolic# gte 90><cfset DiastolicPercent=40></cfif>
		<cfset CholesterolPercent=0>
		<cfif #theAssessment.TotalCholesterol# gt 0 and #theAssessment.TotalCholesterol# lte 199><cfset CholesterolPercent=100></cfif>
		<cfif #theAssessment.TotalCholesterol# gte 200 and #theAssessment.TotalCholesterol# lte 239>
			<cfset CholesterolPercent=60></cfif>
		<cfif #theAssessment.TotalCholesterol# gte 240><cfset CholesterolPercent=40></cfif>
		
		<cfset HDLPercent=0>
			<cfif #theAssessment.sex# is 1>
				<cfif #theAssessment.HDL# gte 50 ><cfset HDLPercent=100></cfif>
				<cfif #theAssessment.HDL# gt 0 and #theASsessment.HDL# lte 49><cfset HDLPercent=40></cfif>
			<cfelse>
				<cfif #theAssessment.HDL# gte 40 ><cfset HDLPercent=100></cfif>
				<cfif #theAssessment.HDL# gt 0 and #theASsessment.HDL# lte 39><cfset HDLPercent=40></cfif>
			</cfif>

		<cfset LDLPercent=0>
			<cfif #theAssessment.sex# is 1>
				<cfif #theAssessment.LDL# gte 50 ><cfset LDLPercent=100></cfif>
				<cfif #theAssessment.LDL# gt 0 and #theAssessment.LDL# lte 49><cfset LDLPercent=40></cfif>
			<cfelse>
				<cfif #theAssessment.LDL# gte 40 ><cfset LDLPercent=100></cfif>
				<cfif #theAssessment.LDL# gt 0 and #theAssessment.LDL# lte 39><cfset LDLPercent=40></cfif>
			</cfif>
		<cfset triglyceridePercent=0>
		<cfif #theAssessment.triglyceride# gte 151 ><cfset triglyceridePercent=60></cfif>
		<cfif #theAssessment.triglyceride# gt 0 and #theAssessment.triglyceride# lte 150><cfset triglyceridePercent=100></cfif>
		<cfset glucosePercent=0>	
		<cfif #theAssessment.glucose# gte 101 ><cfset glucosePercent=60></cfif>
		<cfif #theAssessment.glucose# gt 0 and #theAssessment.glucose# lte 100><cfset glucosePercent=100></cfif>
		<cfset sickPercent=0>	
		<cfif #theAssessment.SickDays# is 0 or #theAssessment.SickDays# is 1>
			<cfset sickPercent=100></cfif>
		<cfif #theAssessment.SickDays# is 2 or #theAssessment.SickDays# is 3>
			<cfset sickPercent=80></cfif>
		<cfif #theAssessment.SickDays# is 4 or #theAssessment.SickDays# is 5>
			<cfset sickPercent=60></cfif>
		<cfif #theAssessment.SickDays# is 6 or #theAssessment.SickDays# is 7>
			<cfset sickPercent=40></cfif>
		<cfif #theAssessment.SickDays# gte 8><cfset sickPercent=20></cfif>
		<cfset tobaccoPercent=0>	
		<cfif #theAssessment.TobaccoStatus# is 1 or #theAssessment.TobaccoStatus# is 2 or #theAssessment.TobaccoStatus# is 4 or #theAssessment.TobaccoStatus# is 3>
			<cfset tobaccoPercent=20></cfif>
		<cfif #theAssessment.TobaccoStatus# is 5><cfset tobaccoPercent=60></cfif>
		<cfif #theAssessment.TobaccoStatus# is 6><cfset tobaccoPercent=80></cfif>
		<cfif #theAssessment.TobaccoStatus# gte 7><cfset tobaccoPercent=100></cfif>
		
		<cfset PersonalPercent=100>
		<cfloop index="element" list="#theAssessment.PersonalHealthHistory#">
			<cfif #element# is 1><cfset PersonalPercent=  PersonalPercent - 20></cfif>
		</cfloop>
		<cfif #theassessment.PersonalHealthHistory# is ""><cfset PersonalPercent=0></cfif>

		<cfset painPercent=0>
		<cfif #theAssessment.BodilyPain# is 2 or #theAssessment.BodilyPain# is 1>
			<cfset painPercent=20></cfif>
		<cfif #theAssessment.BodilyPain# is 3><cfset painPercent=40></cfif>
		<cfif #theAssessment.BodilyPain# is 4><cfset painPercent=60></cfif>
		<cfif #theAssessment.BodilyPain# is 5><cfset painPercent=80></cfif>
		<cfif #theAssessment.BodilyPain# gte 6><cfset painPercent=100></cfif>
		<cfset limitationsPercent=0>
		<cfif #theAssessment.HealthLimitations# is 1><cfset limitationsPercent=20></cfif>
		<cfif #theAssessment.HealthLimitations# is 2><cfset limitationsPercent=40></cfif>
		<cfif #theAssessment.HealthLimitations# is 3><cfset limitationsPercent=60></cfif>
		<cfif #theAssessment.HealthLimitations# is 4><cfset limitationsPercent=80></cfif>
		<cfif #theAssessment.HealthLimitations# gte 5><cfset limitationsPercent=100></cfif>
		
		<cfset tempHealth=overallPercent + PhysicianPercent + examPercent + SystolicPercent + DiastolicPercent + CholesterolPercent + HDLPercent + LDLPercent + triglyceridePercent + glucosePercent + sickPercent + tobaccoPercent + PersonalPercent + painPercent + limitationsPercent>

		<cfset healthCount=15>
		<cfif #overallPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #PhysicianPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #examPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #SystolicPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #DiastolicPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #CholesterolPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #HDLPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #LDLPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #triglyceridePercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #glucosePercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #sickPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #tobaccoPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #PersonalPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #painPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif #limitationsPercent# is 0><cfset healthCount=healthCount - 1></cfif>
		<cfif HealthCount gt 0>
			<cfset healthPercent=round(tempHealth / healthCount)>
		<cfelse>
			<cfset healthPercent=0>
		</cfif>
		
		<cfset CopingPercent=0>
		<cfif #theAssessment.Coping# is 1><cfset CopingPercent=20></cfif>
		<cfif #theAssessment.Coping# is 2><cfset CopingPercent=40></cfif>
		<cfif #theAssessment.Coping# is 3><cfset CopingPercent=60></cfif>
		<cfif #theAssessment.Coping# is 4><cfset CopingPercent=80></cfif>
		<cfif #theAssessment.Coping# gte 5><cfset CopingPercent=100></cfif>
		
		<cfset xStressPercent=0>
		<cfloop index="element" list="#theAssessment.stress#">
			<cfif #element# is 1><cfset xStressPercent=  xStressPercent + 20></cfif>
		</cfloop>
		
		<cfset sleepPercent=0>
		<cfif #theAssessment.HoursOfSleep# is 1><cfset sleepPercent=40></cfif>
		<cfif #theAssessment.HoursOfSleep# is 2><cfset sleepPercent=80></cfif>
		<cfif #theAssessment.HoursOfSleep# is 3><cfset sleepPercent=100></cfif>
		<cfif #theAssessment.HoursOfSleep# is 4><cfset sleepPercent=100></cfif>
		<cfset EmotionalPercent=0>
		<cfif #theAssessment.EmotionalIssues# is 1><cfset EmotionalPercent=20></cfif>
		<cfif #theAssessment.EmotionalIssues# is 2><cfset EmotionalPercent=40></cfif>
		<cfif #theAssessment.EmotionalIssues# is 3><cfset EmotionalPercent=60></cfif>
		<cfif #theAssessment.EmotionalIssues# is 4><cfset EmotionalPercent=80></cfif>
		<cfif #theAssessment.EmotionalIssues# gte 5><cfset EmotionalPercent=100></cfif>
		<cfset socialPercent=0>
		<cfif #theAssessment.SocialActivity# is 1><cfset socialPercent=20></cfif>
		<cfif #theAssessment.SocialActivity# is 2><cfset socialPercent=40></cfif>
		<cfif #theAssessment.SocialActivity# is 3><cfset socialPercent=60></cfif>
		<cfif #theAssessment.SocialActivity# is 4><cfset socialPercent=80></cfif>
		<cfif #theAssessment.SocialActivity# gte 5><cfset socialPercent=100></cfif>
		<cfset supportPercent=0>
		<cfif #theAssessment.SocialSupport# is 1><cfset supportPercent=20></cfif>
		<cfif #theAssessment.SocialSupport# is 2><cfset supportPercent=100></cfif>
		
		<cfset FeelingsPercent=0>
		<cfset FeelingsCount=0>
		<cfloop index="element" list="#theAssessment.Feelings#">
			<cfset FeelingsCount=#FeelingsCount# + 1>
			<cfif #element# is 1><cfset FeelingsPercent=20></cfif>
			<cfif #element# is 2><cfset FeelingsPercent=40></cfif>
			<cfif #element# is 3><cfset FeelingsPercent=60></cfif>
			<cfif #element# is 4><cfset FeelingsPercent=80></cfif>
			<cfif #element# is 5><cfset FeelingsPercent=100></cfif>
			<cfif FeelingsCount gte 5>
				<cfif #element# is 1 or #element# is 2 or #element# is 3>
					<cfset FeelingsPercent=20>
				</cfif>
			</cfif>
		</cfloop>
		<cfset stressCount=7>
		<cfif #CopingPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #xStressPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #sleepPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #EmotionalPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #socialPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #supportPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif #FeelingsPercent# is 0><cfset stressCount=stressCount - 1></cfif>
		<cfif stressCount neq 0>
		<cfset StressPercent=round((CopingPercent + xStressPercent + sleepPercent + EmotionalPercent + socialPercent + supportPercent + FeelingsPercent) / stressCount)>
		<cfelse>
			<cfset StressPercent=0>
		</cfif>
		
		<cfset purposePercent=0>
		<cfif #theAssessment.SenseOfPurpose# is 1><cfset purposePercent=20></cfif>
		<cfif #theAssessment.SenseOfPurpose# is 2><cfset purposePercent=40></cfif>
		<cfif #theAssessment.SenseOfPurpose# is 3><cfset purposePercent=60></cfif>
		<cfif #theAssessment.SenseOfPurpose# is 4><cfset purposePercent=80></cfif>
		<cfif #theAssessment.SenseOfPurpose# gte 5><cfset purposePercent=100></cfif>
		<cfset JoyPercent=0>
		<cfif #theAssessment.Joy# is 1><cfset JoyPercent=20></cfif>
		<cfif #theAssessment.Joy# is 2><cfset JoyPercent=40></cfif>
		<cfif #theAssessment.Joy# is 3><cfset JoyPercent=60></cfif>
		<cfif #theAssessment.Joy# is 4><cfset JoyPercent=80></cfif>
		<cfif #theAssessment.Joy# gte 5><cfset JoyPercent=100></cfif>
		<cfset jobPercent=0>
		<cfif #theAssessment.JobSatisfaction# is 1><cfset jobPercent=20></cfif>
		<cfif #theAssessment.JobSatisfaction# is 2><cfset jobPercent=40></cfif>
		<cfif #theAssessment.JobSatisfaction# is 3><cfset jobPercent=60></cfif>
		<cfif #theAssessment.JobSatisfaction# is 4><cfset jobPercent=80></cfif>
		<cfset GratitudePercent=0>
		<cfif #theAssessment.Gratitude# is 1><cfset GratitudePercent=20></cfif>
		<cfif #theAssessment.Gratitude# is 2><cfset GratitudePercent=40></cfif>
		<cfif #theAssessment.Gratitude# is 3><cfset GratitudePercent=60></cfif>
		<cfif #theAssessment.Gratitude# is 4><cfset GratitudePercent=80></cfif>
		<cfif #theAssessment.Gratitude# gte 5><cfset GratitudePercent=100></cfif>
		<cfset lifeCount=4>
		<cfif #purposePercent# is 0><cfset lifeCount=lifeCount - 1></cfif>
		<cfif #JoyPercent# is 0><cfset lifeCount=lifeCount - 1></cfif>
		<cfif #GratitudePercent# is 0><cfset lifeCount=lifeCount - 1></cfif>
		<cfif #jobPercent# is 0><cfset lifeCount=lifeCount - 1></cfif>
		<cfif lifeCount gt 0>
		<cfset LifePercent=round((purposePercent + JoyPercent + jobPercent + GratitudePercent) / lifeCount)>
		<cfelse>
			<cfset LifePercent=0>
		</cfif>
		
		<cfset energyPercent=0>
		<cfif listlen(#theAssessment.energy#) gt 0>
			<cfset Best=#listgetat(theAssessment.energy,1)#>
			<cfif not isnumeric(Best)><cfset Best=1></cfif>
			<cfset Best=replace(Best,"%","","ALL")>
			<cfset Medium=#listgetat(theAssessment.energy,2)#>
			<cfif not isnumeric(Medium)><cfset Medium=1></cfif>
			<cfset Medium=replace(Medium,"%","","ALL")>
			<cfset Low=#listgetat(theAssessment.energy,3)#>
			<cfif not isnumeric(Low)><cfset Low=1></cfif>
			<cfset Low=replace(Low,"%","","ALL")>
			<cfset energy1=Best + (Medium / 2) + (Low / 4)>
			<cfif listlen(#theAssessment.energy#) gte 4>
				<cfset Best2=#listgetat(theAssessment.energy,4)#>
			<cfif not isnumeric(Best2)><cfset Best2=1></cfif>
			<cfset Best2=replace(Best2,"%","","ALL")>
				<cfset Medium2=#listgetat(theAssessment.energy,5)#>
			<cfif not isnumeric(Medium2)><cfset Medium2=1></cfif>
			<cfset Medium2=replace(Medium2,"%","","ALL")>
				<cfset Low2=#listgetat(theAssessment.energy,6)#>
			<cfif not isnumeric(Low2)><cfset Low2=1></cfif>
			<cfset Low2=replace(Low2,"%","","ALL")>
				<cfset energy2=Best2 + (Medium2 / 2) + (Low2 / 4)>
				<cfset energyPercent=(#energy1# + #energy2#) / 2>
			<cfelse>
				<cfset energyPercent=#listgetat(theAssessment.energy,1)#>
			</cfif>
		</cfif>
		
		<cfset report=QueryNew("ItemName,Value")>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Confidence", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#ConfidencePercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Life", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#LifePercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Energy", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#energyPercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Exercise", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#exercisePercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Nutrition", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#NutritionPercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Weight", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#weightPercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Stress", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#StressPercent#",#newRow#)>
		<CFSET newRow  = QueryAddRow(report, 1)>
		<CFSET temp = QuerySetCell(report, "ItemName","Health", #newRow#)>
		<CFSET temp = QuerySetCell(report, "Value","#healthPercent#",#newRow#)>
		<cfreturn report>
	</cffunction>
	
	<cffunction name="CoachAssessmentClients" access="remote" output="true" returntype="query">
		<cfargument name="CoachID" type="string" required="no" default="0">
		<cfargument name="CoachFirst" type="string" required="no" default="0">
		<cfargument name="CoachLast" type="string" required="no" default="0">
		<cfinclude template="vars.cfm">
		
		<cfset CoachID=#arguments.CoachID#>
		<cfset CoachFirst=#trim(arguments.CoachFirst)#>
		<cfset CoachLast=#trim(arguments.CoachLast)#>
		
		<cfquery name="getNames" datasource = "#DSN#"  username="#DSNuName#" password="#DSNpWord#">
			select assessmentid as ID,FirstName,LastName,Email,Phone,Employer,CONVERT(CHAR(10),datecreated,110) as Created,UserName, City, State from assessment
			<cfif #CoachID# neq "0">
			where CoachID = #CoachID#
			or (coachfirstname like '%#CoachFirst#%' and coachlastname like '%#CoachLast#%')
			<cfelse>
				where (coachfirstname like '%#CoachFirst#%' and coachlastname like '%#CoachLast#%')
			</cfif>
			order by lastname
		</cfquery>

		<cfreturn getNames>
	</cffunction>
	
	<cffunction name="getClientLogin" access="remote" returntype="query" output="true">
		<cfargument name="uName" type="string" required="yes">
		<cfargument name="pssWord" type="string" required="yes">
		<cfinclude template="vars.cfm">

		<CFQUERY name="getClient" dataSource="#DSN#" password="#DSNpWord#" username="#dsnuname#">
			select datecreated,assessmentID from assessment where username='#trim(arguments.uName)#' and xpassword='#trim(arguments.pssWord)#'
		</CFQUERY>
		<cfreturn getClient>
	</cffunction>
	
	<cffunction name="getassessclient" access="remote" returntype="query" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<CFQUERY name="wClient" dataSource="#DSN#" password="#DSNpWord#" username="#dsnuname#">
			select FirstName,LastName,Employer,CONVERT(CHAR(10),BirthDate,101) as BirthDate,Relationship,Children,PlanningSession,EACbenefit,Eligibility,UserName,xPassWord,CoachFirstName,CoachLastName,Address,City,State,Email,Phone,Occupation,Sex,CoachID,datecreated as startdate from assessment where userid=#arguments.clientID#
		</CFQUERY>
		<cfif #wClient.recordcount# is 0>
			<CFQUERY name="wClient" dataSource="#DSN#" password="#DSNpWord#" username="#DSNuname#">
				SELECT Members.FirstName,
				members.LastName,
				CONVERT(CHAR(10),BirthDate,101) as BirthDate,
				members.relationshipstatus as Relationship,
				members.Children,
				members.logon as UserName,
				members.password as xPassWord,
				members.Sex,
				members.accesslevel as CoachID,
				Addresses.Address1 as Address,
				Addresses.City, 
				Addresses.State,
				Email.EMailAddress as Email, 
				PhoneNumbers.PhoneNumber as Phone
				FROM Members, Email, Addresses, PhoneNumbers
				WHERE email.tableid=15
				and email.connectid = members.memberid
				and email.websiteid=1
				and PhoneNumbers.TableID=15
				and PhoneNumbers.ConnectID = Members.MemberID
				and phonenumbers.phonetypeid=1
				and Addresses.tableid=15
				and Addresses.connectid = members.memberid
				and Members.memberid=#arguments.ClientID#
			</CFQUERY>
		</cfif>
		<cfreturn wClient>
		
	</cffunction>
	
	<cffunction name="getAccount" access="remote" output="true" returntype="query">
		<cfinclude template="application.cfm">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="websiteinfo">
				<cfinvokeargument name="ThisPath" value="utilities">
		</cfinvoke>

		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="WebSiteInfo">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="websiteinfo">
				<cfinvokeargument name="IDFieldName" value="websiteid">
				<cfinvokeargument name="IDFieldValue" value="0000000001">
			</cfinvoke>
		<cfelse>
			<cfinclude template="../website.ini">
			<cfset dateStarted=dateformat(now(),"mm/dd/yyyy")>
			<cfset Active=1>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="websiteinfo">
				<cfinvokeargument name="XMLFields" value="DSN,DSNuName,DSNpWord,IPAddress,ACTIVE,ADDRESS1,ADDRESS2,CELLNUMBER,CITY,COUNTRY,DateStarted,EMAIL,OWNERNAME,MailServer,PHONENUMBER,PWORD,STATE,USERNAME,WEBSITENAME,ZIP,MetaKeywords,MetaTitle,MetaDescription,CompanyName,Description,ReturnPath">
				<cfinvokeargument name="XMLFieldData" value="#DSN#,#DSNuName#,#DSNpWord#,#IPAddress#,#ACTIVE#,#ADDRESS1#,#ADDRESS2#,#CELLNUMBER#,#CITY#,#COUNTRY#,#DateStarted#,#EMAIL#,#OWNERNAME#,#MailServer#,#PHONENUMBER#,#PWORD#,#STATE#,#USERNAME#,#WEBSITENAME#,#ZIP#,#MetaKeywords#,#MetaTitle#,#MetaDescription#,#CompanyName#,#MetaDescription#,#ReturnPath#">
				<cfinvokeargument name="XMLIDField" value="WebSiteID">
			</cfinvoke>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="WebSiteInfo">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="websiteinfo">
				<cfinvokeargument name="IDFieldName" value="websiteid">
				<cfinvokeargument name="IDFieldValue" value="0000000001">
			</cfinvoke>
		</cfif>
		<cfreturn webSiteInfo>
	</cffunction>
	
	<cffunction name="saveAccount" access="remote" output="true" returntype="string">
		<cfargument name="DSN" type="string" required="yes">
		<cfargument name="DSNuName" type="string" required="yes">
		<cfargument name="DSNpWord" type="string" required="yes">
		<cfargument name="IPAddress" type="string" required="yes">
		<cfargument name="ADDRESS1" type="string" required="yes">
		<cfargument name="ADDRESS2" type="string" required="yes">
		<cfargument name="CELLNUMBER" type="string" required="yes">
		<cfargument name="CITY" type="string" required="yes">
		<cfargument name="COUNTRY" type="string" required="yes">
		<cfargument name="EMAIL" type="string" required="yes">
		<cfargument name="OWNERNAME" type="string" required="yes">
		<cfargument name="MailServer" type="string" required="yes">
		<cfargument name="PHONENUMBER" type="string" required="yes">
		<cfargument name="PWORD" type="string" required="yes">
		<cfargument name="STATE" type="string" required="yes">
		<cfargument name="USERNAME" type="string" required="yes">
		<cfargument name="WEBSITENAME" type="string" required="yes">
		<cfargument name="ZIP" type="string" required="yes">
		<cfargument name="MetaKeywords" type="string" required="yes">
		<cfargument name="MetaTitle" type="string" required="yes">
		<cfargument name="MetaDescription" type="string" required="yes">
		<cfargument name="CompanyName" type="string" required="yes">
		<cfargument name="ReturnPath" type="string" required="yes">

		<cfset DSN=#arguments.DSN#>
		<cfset DSNuName=#arguments.DSNuName#>
		<cfset DSNpWord=#arguments.DSNpWord#>
		<cfset ReturnPath=#arguments.returnpath#>
		<cfset IPAddress=#arguments.IPAddress#>
		<cfset ACTIVE=1>
		<cfset ADDRESS1=#arguments.ADDRESS1#>
		<cfset Address1=replace(#address1#,",","~","ALL")>
		<cfset ADDRESS2=#arguments.ADDRESS2#>
		<cfset ADDRESS2=replace(#ADDRESS2#,",","~","ALL")>
		<cfset CELLNUMBER=#arguments.CELLNUMBER#>
		<cfset CITY=#arguments.CITY#>
		<cfset COUNTRY=#arguments.COUNTRY#>
		<cfset DateStarted=#dateformat(now())#>
		<cfset EMAIL=#arguments.EMAIL#>
		<cfset OWNERNAME=#arguments.OWNERNAME#>>
		<cfset MailServer=#arguments.MailServer#>
		<cfset PHONENUMBER=#arguments.PHONENUMBER#>
		<cfset PWORD=#arguments.PWORD#>
		<cfset STATE=#arguments.STATE#>
		<cfset USERNAME=#arguments.USERNAME#>
		<cfset WEBSITENAME=#arguments.WEBSITENAME#>
		<cfset WEBSITENAME=replace(#WEBSITENAME#,",","~","ALL")>
		<cfset ZIP=#arguments.ZIP#>
		<cfset MetaKeywords=#arguments.MetaKeywords#>
		<cfset MetaKeywords=replace(#MetaKeywords#,",","~","ALL")>
		<cfset MetaTitle=#arguments.MetaTitle#>
		<cfset MetaTitle=replace(#MetaTitle#,",","~","ALL")>
		<cfset MetaDescription=#arguments.MetaDescription#>
		<cfset MetaDescription=replace(#MetaDescription#,",","~","ALL")>
		<cfset CompanyName=#arguments.CompanyName#>
		<cfset CompanyName=replace(#CompanyName#,",","~","ALL")>
		<cfset Description=#arguments.MetaDescription#>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="websiteinfo">
				<cfinvokeargument name="ThisPath" value="utilities">
		</cfinvoke>
	
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="WebSiteInfo">
				<cfinvokeargument name="XMLFields" value="DSN,DSNuName,DSNpWord,IPAddress,ACTIVE,ADDRESS1,ADDRESS2,CELLNUMBER,CITY,COUNTRY,DateStarted,EMAIL,OWNERNAME,MailServer,PHONENUMBER,PWORD,STATE,USERNAME,WEBSITENAME,ZIP,MetaKeywords,MetaTitle,MetaDescription,CompanyName,Description,ReturnPath">
				<cfinvokeargument name="XMLFieldData" value="#DSN#,#DSNuName#,#DSNpWord#,#IPAddress#,#ACTIVE#,#ADDRESS1#,#ADDRESS2#,#CELLNUMBER#,#CITY#,#COUNTRY#,#DateStarted#,#EMAIL#,#OWNERNAME#,#MailServer#,#PHONENUMBER#,#PWORD#,#STATE#,#USERNAME#,#WEBSITENAME#,#ZIP#,#MetaKeywords#,#MetaTitle#,#MetaDescription#,#CompanyName#,#Description#,#ReturnPath#">
				<cfinvokeargument name="XMLIDField" value="WebSiteID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="websiteinfo">
				<cfinvokeargument name="XMLFields" value="DSN,DSNuName,DSNpWord,IPAddress,ACTIVE,ADDRESS1,ADDRESS2,CELLNUMBER,CITY,COUNTRY,DateStarted,EMAIL,OWNERNAME,MailServer,PHONENUMBER,PWORD,STATE,USERNAME,WEBSITENAME,ZIP,MetaKeywords,MetaTitle,MetaDescription,CompanyName,Description,ReturnPath">
				<cfinvokeargument name="XMLFieldData" value="#DSN#,#DSNuName#,#DSNpWord#,#IPAddress#,#ACTIVE#,#ADDRESS1#,#ADDRESS2#,#CELLNUMBER#,#CITY#,#COUNTRY#,#DateStarted#,#EMAIL#,#OWNERNAME#,#MailServer#,#PHONENUMBER#,#PWORD#,#STATE#,#USERNAME#,#WEBSITENAME#,#ZIP#,#MetaKeywords#,#MetaTitle#,#MetaDescription#,#CompanyName#,#Description#,#ReturnPath#">
				<cfinvokeargument name="XMLIDField" value="WebSiteID">
			</cfinvoke>
		</cfif>

		<cfreturn "0000000001">
	</cffunction>
	
	<cffunction name="getLinks" output="true" access="remote" returntype="query">
		<cfinclude template="application.cfm">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllLinkCategories">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="LinkCategories">
		</cfinvoke>
		<cfreturn AllLinkCategories>
	</cffunction>
	
	<cffunction name="saveLinkCats" output="true" access="remote" returntype="string">
		<cfargument name="LinkCatID" type="string" required="yes">
		<cfargument name="DateCreated" type="string" required="yes">
		<cfargument name="DateLastViewed" type="string" required="yes">
		<cfargument name="CatImage" type="string" required="yes">
		<cfargument name="CatDescript" type="string" required="yes">
		<cfargument name="CatPage" type="array" required="yes">
		<cfargument name="NoOfLinks" type="string" required="yes">
		
		<cfset NewID=#LinkCatID#>
		<cfset CatPage = ArrayToList(#arguments.CatPage#)>
		<cfif arguments.LinkCatID gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="LinkCategories">
				<cfinvokeargument name="XMLFields" value="DateCreated,ShowOnPage,CatDescription,DateLastViewed,NoOfLinks,Banner">
			<cfinvokeargument name="XMLFieldData" value="#arguments.DateCreated#,#CatPage#,#arguments.CatDescript#,#arguments.DateLastViewed#,#arguments.NoOfLinks#,#arguments.CatImage#">
				<cfinvokeargument name="XMLIDField" value="CategoryID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.LinkCatID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="LinkCategories">
				<cfinvokeargument name="XMLFields" value="DateCreated,ShowOnPage,CatDescription,DateLastViewed,NoOfLinks,Banner">
			<cfinvokeargument name="XMLFieldData" value="#arguments.DateCreated#,#CatPage#,#arguments.CatDescript#,#arguments.DateLastViewed#,#arguments.NoOfLinks#,#arguments.CatImage#">
				<cfinvokeargument name="XMLIDField" value="CategoryID">
			</cfinvoke>
		</cfif>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="getName" access="remote" output="true" returntype="string">
		<cfargument name="MemberID" type="string" required="yes">
		
		<cfif #arguments.MemberID# gt 0>
			<cfquery name="checkuser" datasource="#application.DSN#" 
				password="#application.DSNpWord#" username="#application.DSNuName#">
				select logon, password, memberID, firstname, lastname, subtypeid, banned, active,
				occupation
				from members
				where MemberID=#arguments.MemberID#
			</cfquery>
			<cfset MemberName2="#trim(CheckUser.Firstname)# #trim(CheckUser.LastName)#">
		</cfif>
		<cfreturn MemberName2>
	</cffunction>
	
	<cffunction name="getMemberButtons" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" type="string" required="yes">
		<cfquery name="checkuser" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#">
			select subtypeid, occupation, lastvisit
			from members
			where MemberID=#arguments.MemberID#
		</cfquery>
		<Cfif #checkuser.LastVisit# neq #dateformat(now())#>
			<cfquery name="update" datasource="#application.DSN#" 
				password="#application.DSNpWord#" username="#application.DSNuName#">
				update members set lastvisit=#createODBCdatetime(now())# 
				where memberid=#arguments.MemberID#
			</cfquery>
		</Cfif>
		
		<cfset GoFaculty=0>
		<cfset GoMember=0>
		<cfset GoStudent=0>
		<cfset GoTrainee=0>
		<cfset GoLicensee=0>
		<cfset FacultyHomePage="Homepage">
		<cfset MemberHomePage="homepage">
		<cfset TraineeHOmepage="homepage">
		<cfset STudentHomePage="homepage">
		<cfset LicenseHomePage="homepage">
		<cfset memberButtonList=QueryNew("goType,TypeHomePage,MenuGo")>
		
		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getGeneralConfig" returnvariable="generalConfig"></cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getTraineeConfig" returnvariable="traineeConfig"></cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getLicenseeConfig" returnvariable="licenseConfig"></cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getStudentConfig" returnvariable="studentConfig"></cfinvoke>
		<cfinvoke method="getAllPages" returnvariable="pages"></cfinvoke>
				
		<cfif #checkuser.occupation# neq ''>	
			<cfset OldSubType=#checkuser.SubTypeID#>
			<cfset MenuCount=0>
			<cfset TypeList=#CheckUser.Occupation#>
			<cfset TypeList=ListAppend(#TypeList#,#OldSubType#)>
			<cfif listfind(#TypeList#,#generalConfig.facultyType#)>
				<cfset GoFaculty = 0>
				<cfif OldSubType eq #generalConfig.FacultyType#>
					<cfset GoFaculty=1>
				</cfif></cfif>
				<cfset FacultyHomePage="faculty">
				<cfset newRow=QueryAddRow(memberButtonList,1)>
				<CFSET temp = QuerySetCell(memberButtonList, "goType","1", #newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"TypeHomePage","#FacultyHomePage#",#newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"MenuGo","#GoFaculty#",#newRow#)>
			
			<cfif listfind(#TypeList#,#studentConfig.studentType#)>
				<cfset GoStudent = 0>
				<cfif OldSubType eq #studentConfig.studentType#>
					<cfset GoStudent=1>
				</cfif></cfif>
				<cfquery name="student" dbtype="query">
					select pagename from pages where pageid='#studentConfig.StudentHome#'
				</cfquery>
				<cfset STudentHomePage=#student.pagename#>
				<cfset newRow=QueryAddRow(memberButtonList,1)>
				<CFSET temp = QuerySetCell(memberButtonList, "goType","1", #newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"TypeHomePage","#STudentHomePage#",#newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"MenuGo","#GoStudent#",#newRow#)>
			
			<cfif listfind(#TypeList#,#traineeConfig.traineeType#)>
				<cfset GoTrainee = 0>
				<cfif OldSubType eq #traineeConfig.traineeType#>
					<cfset GoTrainee=1>
				</cfif></cfif>
				<cfquery name="trainee" dbtype="query">
					select pagename from pages where pageid='#traineeConfig.TraineeHome#'
				</cfquery>
				<cfset TraineeHOmepage=#trainee.pagename#>
				<cfset newRow=QueryAddRow(memberButtonList,1)>
				<CFSET temp=QuerySetCell(memberButtonList, "goType","1", #newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"TypeHomePage","#TraineeHOmepage#",#newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"MenuGo","#GoTrainee#",#newRow#)>
			
			<cfif listfind(#TypeList#,#licenseConfig.licenseeType#)>
				<cfset GoLicensee = 0>
				<cfif OldSubType eq #licenseConfig.licenseeType#>
					<cfset GoLicensee=1>
				</cfif></cfif>	
				<cfquery name="licensee" dbtype="query">
					select pagename from pages where pageid='#licenseConfig.licenseehome#'
				</cfquery>
				<cfset LicenseHomepage=#licensee.pagename#>
				<cfset newRow=QueryAddRow(memberButtonList,1)>
				<CFSET temp = QuerySetCell(memberButtonList, "goType","#GoLicensee#", #newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"TypeHomePage","#LicenseHomepage#",#newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"MenuGo","#GoLicensee#",#newRow#)>
			
			<cfif ListFind(TypeList,3) or ListFind(TypeList,8) or ListFind(TypeList,9)>
				<cfset GoMember = 0>
				<cfif OldSubType eq 3 or OldSubType eq 8 or OldSubType eq 9>
					<cfset GoMember=1>
				</cfif></cfif>
				<cfquery name="member" dbtype="query">
					select pagename from pages where pageid='#studentConfig.StudentHome#'
				</cfquery>
				<cfset MemberHomePage=#member.pagename#>
				<cfset newRow=QueryAddRow(memberButtonList,1)>
				<CFSET temp = QuerySetCell(memberButtonList, "goType","1", #newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"TypeHomePage","#MemberHomePage#",#newRow#)>
				<CFSET temp=QuerySetCell(memberButtonList,"MenuGo","#GoMember#",#newRow#)>
			
			
		</cfif>

		<cfreturn memberButtonList>
	</cffunction>
	
	<cffunction name="getMainPages" returntype="query" access="remote" output="true">
		<cfargument name="thisPage" type="string" required="yes">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="pages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfinvokeargument name="selectstatement" value=" where pagename='#thisPage#'">
		</cfinvoke>
		<cfinvoke component="#application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="thePage">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="#trim(arguments.thisPage)#">
			<cfinvokeargument name="selectstatement" value=" where positionID='0000000003'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Utilities">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="classpageconfig">
			<cfinvokeargument name="IDFieldName" value="utilityID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfset mainLinks=QueryNew("classesPage,membersPage,facultyPage,licencePage,webcoachPage,loginPage,joinPage,backImage,frameStop")>
		<cfif #pages.recordcount# gt 0>
			
			<cfset newRow=QueryAddRow(mainLinks,1)>

			<CFSET temp=QuerySetCell(mainLinks,"classesPage","#Utilities.classesPage#",#newRow#)>
			<CFSET temp=QuerySetCell(mainLinks,"membersPage","#Utilities.membersPage#",#newRow#)>
			<CFSET temp=QuerySetCell(mainLinks,"facultyPage","#Utilities.facultyPage#",#newRow#)>
			<CFSET temp=QuerySetCell(mainLinks,"licencePage","#Utilities.licencePage#",#newRow#)>
			<CFSET temp=QuerySetCell(mainLinks,"webcoachPage","#Utilities.webcoachPage#",#newRow#)>
			<CFSET temp=QuerySetCell(mainLinks,"loginPage","#Utilities.loginPage#",#newRow#)>
			<CFSET temp = QuerySetCell(mainLinks, "joinPage","#Utilities.joinPage#", #newRow#)>
			<cfquery name="getPosition" dbtype="query">
				select BackGrImageID from pages
			</cfquery>
			<cfif #getPosition.BackGrImageID# is "0000000003">
				<cfset filename="image1">
			<cfelse>
				<cfset filename="image2">
			</cfif>
			<CFSET temp = QuerySetCell(mainLinks, "backImage","#replace(Filename,'.gif','','ALL')#", #newRow#)>
			<CFSET temp = QuerySetCell(mainLinks, "frameStop","#trim(thePage.content)#", #newRow#)>
		</cfif>
		<cfreturn mainLinks>
	</cffunction>
</cfcomponent>