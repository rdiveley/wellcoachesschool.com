<cfcomponent>
	<cffunction name="ShowBanner" access="remote" output="true">
		<cfargument name="AdvertOption" type="numeric" required="true" default="2">
		<cfargument name="PageName" default="homepage" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="BannerConfig">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="BannerConfig">
		</cfinvoke>
	
		<cfset NoOfBanners=1>
		<cfset theBR="">
		<cfset Pagename=#arguments.pagename#>
		<cfset WhereStatement="Where AdvertOption='#arguments.AdvertOption#'">
		
		<cfswitch expression="#arguments.AdvertOption#">
			<cfcase value="1"> <!--- rectangle ads --->
				<cfset NoOfBanners=#BannerConfig.NoOfBanners#>
				<cfset WhereStatement="where advertOption = '1' or advertoption = '2' or advertoption='3' or advertoption='4' or advertoption='5'">
			</cfcase>
			<cfcase value="8"> <!--- Button ads --->
				<cfset NoOfBanners=#BannerConfig.NoOfBanners#>
				<cfset WhereStatement="where advertOption = '8' or advertoption = '9' or advertoption='10' or advertoption='12'">
			</cfcase>
			<cfcase value="7"> <!--- Half Banner --->
				<cfset NoOfBanners=#BannerConfig.HalfBannerNo#>
				<cfset WhereStatement="where advertOption = '7'">
			</cfcase>
			<cfcase value="14"> <!--- Skyscrapers --->
			<cfset WhereStatement="where advertOption = '13' or advertoption = '14' or advertoption='11'">
			</cfcase>
			<cfdefaultcase> <!--- regular banner --->
				<cfset NoOfBanners=1>
				<cfset WhereStatement="where advertOption = '#arguments.AdvertOption#'">
			</cfdefaultcase>
		</cfswitch>
		<cfif NoOfBanners gt 1 and #BannerConfig.ListingStyle# is "vertical"><cfset theBR="<BR"></cfif>
		<cfif #arguments.AdvertOption# is 7><cfset theBR=""></cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Banners">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
		</cfinvoke>
			
		<CFQUERY  NAME="GetMax" dbtype="query">
			SELECT Max(BanID) as MaxBan, Min(BanID) as MinBan
			FROM Banners
			#wherestatement#
		</CFQUERY>
		<cfif #GetMax.MinBan# neq ''>
	<!--- DEFINE MaxBan TO DISPLAY MAXIMUM BANNERS --->
			<CFSET BanID = RandRange(GetMax.MinBan,GetMax.MaxBan)>
			<CFSET BanID = #BanID# - 1>
	<!--- GET THE BANNER'S INFORMATION FROM THE FOLLOWING QUERY --->
		
			<cfquery name="GetBanners" dbtype="query">
				SELECT *
				FROM Banners
				WHERE BanID > #BanID#
				and AdvertOption = #arguments.AdvertOption#
				ORDER BY BanID
			</cfquery>
			<cfset BanID=#GetBanners.BanID#>
		
		
		<!--- DISPLAY THE ADS --->
		
			<CFOUTPUT QUERY="GetBanners" maxrows="#noOfBanners#" startrow="1">
			<!--- INSERT A 'PLUS ONE' INTO THE DATABASE FOR VIEWS --->
			
				<CFSET add = #incrementvalue(val(GetBanners.views))#>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
					method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="Banners">
					<cfinvokeargument name="XMLFields" 
					value="Message,Special,SpecialDate,AdvertOption,EndSpecial,clicks,Target,CompanyName,Email,HREF,ImgSrc,Views,Border">
					<cfinvokeargument name="XMLFieldData" 
					value="#GetBanners.Message#,#GetBanners.Special#,#GetBanners.SpecialDate#,#GetBanners.AdvertOption#,#GetBanners.EndSpecial#,#GetBanners.clicks#,#GetBanners.Target#,#GetBanners.CompanyName#,#GetBanners.Email#,#GetBanners.HREF#,#GetBanners.ImgSrc#,#add#,#GetBanners.Border#">
					<cfinvokeargument name="XMLIDField" value="BanID">
					<cfinvokeargument name="XMLIDValue" value="#BanID#">
				</cfinvoke>
				<CFQUERY  name="UpdateView" dbtype="query">
					UPDATE Banners Set views = #add# 
					where BanID = #BanID#
				</cfquery>
				<!--- Show each banner --->
				<cfif #ImgSrc# neq 'none'>
				<A HREF="index.cfm/scripts/redirect.cfm?BanID=#BanID#&Page=#pagename#" TARGET="#trim(TARGET)#">
					<IMG SRC="images/banners/#trim(IMGSRC)#" BORDER="#BORDER#"></A>#theBR#
				<cfelseif #message# neq "none">
				<A HREF="index.cfm/scripts/redirect.cfm?BanID=#BanID#&Page=#pagename#" TARGET="#trim(TARGET)#">
					#message#</a>#theBR#
				</cfif>
			</CFOUTPUT>
		</cfif>
	</cffunction>
	
	<cffunction name="RedirectBanner" access="remote" output="true">
		<cfargument name="BanID" default=0 required="true" type="string">
		<cfargument name="PageName" default="homepage" required="true" type="string">
		
		<cfset BanID=#arguments.BanID#>
		<CFSET ReferSite = '#cgi.HTTP_REFERER#'>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Banners">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
		</cfinvoke>
	<!--- Query Banners To Get Ban_ID to specify Redirection URL --->
		<CFQUERY NAME="GetBanners" dbtype="query">
			SELECT *
			FROM Banners
			WHERE BanID = #BanID#
			ORDER BY BanID
		</CFQUERY>
	
	<!--- Add One To Click --->	
		<CFSET add = #incrementvalue(val(GetBanners.CLICKS))#>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
			<cfinvokeargument name="XMLFields" 
			value="Message,Special,SpecialDate,AdvertOption,EndSpecial,clicks,Target,CompanyName,Email,HREF,ImgSrc,Views,Border">
			<cfinvokeargument name="XMLFieldData" 
			value="#GetBanners.Message#,#GetBanners.Special#,#GetBanners.SpecialDate#,#GetBanners.AdvertOption#,#GetBanners.EndSpecial#,#add#,#GetBanners.Target#,#GetBanners.CompanyName#,#GetBanners.Email#,#GetBanners.HREF#,#GetBanners.ImgSrc#,#GetBAnners.Views#,#GetBanners.Border#">
			<cfinvokeargument name="XMLIDField" value="BanID">
			<cfinvokeargument name="XMLIDValue" value="#BanID#">
		</cfinvoke>
	<!--- ADD "The Refering Link" TO THE STATS TABLE --->
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="BannerStats">
			<cfinvokeargument name="XMLFields" value="BanID,REFER,ThisDate,PageName">
			<cfinvokeargument name="XMLFieldData" value="#BanID#,#ReferSite#,#now()#,#arguments.pagename#">
			<cfinvokeargument name="XMLIDField" value="BanStatID">
		</cfinvoke>
	<!--- Go To URL That Banner Passed  --->
		<CFOUTPUT QUERY="GetBanners">
/			<CFLOCATION URL="#trim(HREF)#">
		</CFOUTPUT>
	</cffunction>
</cfcomponent>