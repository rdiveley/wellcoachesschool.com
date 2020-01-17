<cfcomponent>
	<cffunction name="getHomePage" access="remote" output="true">
		<cfargument name="pageName" type="string" required="no" default="homepage">
		<cfset Page=#arguments.PageName#>
		<CFSETTING ENABLECFOUTPUTONLY="Yes">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		<cfif not isdefined('session.memberid')>
			<cfset session.memberid=0>
		</cfif>
		<Cfif #left(Page,4)# is "http"><cflocation url="#pageName#"></Cfif>
		<cfquery name="GetPage" dbtype="query">
			select * from AllPages
			where pagename='#pageName#'
		</cfquery>
		<cfset PageName=#pageName#>
		<cfset PageTitle=#GetPage.PageTitle#>
		<cfset BackgroundColor=#GetPage.BackGrColorID#>
		<cfset PageNo=#GetPage.PageID#>
		<cfset PageType=#GetPage.PageTypeID#>
		<cfparam name="frameStop" default="home">
		<cfif PageType is 1>
			<cfif not isdefined('session.memberid')>
				<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
					method="GetXMLRecords" returnvariable="MemberConfig">
					<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
					<cfinvokeargument name="ThisFileName" value="MemberConfig">
					<cfinvokeargument name="IDFieldName" value="MemberConfigID">
					<cfinvokeargument name="IDFieldValue" value="0000000001">
				</cfinvoke>
					<cfoutput query="MemberConfig">
					<cfset LoginPage=#LoginPage#>
					<cflocation URL="../index.cfm?page=#LoginPage#">
				</cfoutput>
			</cfif>
		</cfif>
		<cfif isdefined('url.aid')>
			<cfset NewID=#url.aid#>
			<cfset tLen=Len(NewID)>
			<cfloop index="XX" from="#tLen#" to="9">
				<cfset NewID="0#NewID#">
			</cfloop>
			<cfset session.affiliateID=#NewID#>
		</cfif>
		<!--- <cfset StructDelete(Session, "cartid")>
		<cfset StructDelete(Session, "customerid")> --->
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Alltemplates">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="templates">
			<cfinvokeargument name="IDFieldName" value="TemplateID">
			<cfinvokeargument name="IDFieldValue" value="#GetPage.TemplateID#">
		</cfinvoke>
		<cfset TemplateName=#AllTemplates.filename#>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="thedetails">
			<cfinvokeargument name="ThisPath" value="Templates">
			<cfinvokeargument name="ThisFileName" value="#templateName#">
		</cfinvoke>
		<cfquery name="AllDetails" dbtype="query">
			select * from thedetails order by positionid
		</cfquery>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Thispage">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="#Pagename#">
		</cfinvoke>
		
		<cfset StyleSheetDetails=''>
		<cfif #GetPage.StyleSheetID# gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="stylesheets">
				<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
				<cfinvokeargument name="ThisFileName" value="stylesheets">
				<cfinvokeargument name="IDFieldName" value="StyleID">
				<cfinvokeargument name="IDFieldValue" value="#int(GetPage.StyleSheetID)#">
			</cfinvoke>
			<cfset StyleSheetDetails="<link rel=""stylesheet"" href=""files/#replace(stylesheets.filename,'~',',','ALL')#.css"" type=""text/css"">">
			<cfset sContent=replace(#stylesheets.content#,"~",",","ALL")>
			<!--- <cfset STyleSheetDetails="<style>#sContent#</style>"> --->
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllGraphics">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="graphics">
		</cfinvoke>
			
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theNavigation">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="navigation">
		</cfinvoke>
		<cfquery name="Allnavigation" dbtype="query">
			select * from theNavigation order by positionid
		</cfquery>
		<cfset Details=''>
		<cfset JavascriptDetails=''>
		
		<cfoutput query="AllDetails">
		<!--- Javascript --->
		<cfif #DisplayTypeID# is 11>
			<cfset JavascriptDetails=#JavascriptDetails# & "<script language='JavaScript1.1'>" & #Content# & "</script>">
		</cfif>
		</cfoutput>
		
		<html>
		<cfoutput><head>
		<title>#PageTitle#</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<META Name="Keywords" Content="#replace(application.MetaKeywords,'~',',','ALL')#" />
		<META name="Copyright" content="Copyright #year(now())# #application.websitename#">
		<META name="Publisher" content="#application.websitename#">
		<META name="Author" content="#application.ownername#">
		<META name="description" content="#application.MetaDescription#">
		<META NAME="date" CONTENT="#dateformat(now(),'yyyymmdd')#">
		<META NAME="channel" CONTENT="internet technology">
		<META http-equiv="Content-Language" content="en">
		<META name="revisit-after" content="15 days">
		<META name="robots" content="index, follow">
		<META name="Rating" content="General">
		<META name="Robots" content="All">
		
		#StyleSheetDetails#
		#JavascriptDetails#
		<SCRIPT TYPE="text/javascript" LANGUAGE="Javascript" SRC="scripts/cookies.js"></SCRIPT>
		<SCRIPT TYPE="text/javascript" LANGUAGE="Javascript" SRC="scripts/pop_win.js"></SCRIPT>
		<script>function newImage(arg) {
			if (document.images) {
				rslt = new Image();
				rslt.src = arg;
				return rslt;
			}
		}
		function changeImages(imagetitle,imagename) {
		
			if (document.images) {
				document.images[ imagetitle ].src
				= imagename;
			
			}
		
		}</script>
		
		</head>
		
		<body <cfif #BackgroundColor# neq 0>bgcolor="#trim(BackgroundColor)#"</cfif> leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
		
		<!--- <table bgcolor="##FFFFFF" width=100% cellpadding=0 cellspacing=0 <cfif #BackgroundColor# neq 0>bgcolor="#BackgroundColor#"</cfif>><tr><Td> ---></cfoutput>
		
		<cfset TheDetails=''>
		<cfloop query="AllDetails">
		
		<!--- Table Structure --->
		<cfif #DisplayTypeID# is 1>
			<cfset Details=#trim(replace(Content,"~",",","ALL"))#>
			<cfset TheDetails=#trim(TheDetails)# & #trim(Details)#>
		</cfif>
		
		<!--- Table Background Color  --->
		<cfif #DisplayTypeID# is 2>
		<!--- 	<cfset BGColor=#Content#>
			<cfinclude template="GetBGColor.cfm"> --->
			<cfset TheDetails=#trim(TheDetails)# & "Select Table Background color:<br><input type='text' name='D#PositionID#'"> 
			<cfif #Action# is "Edit">
				<cfset TheDetails=#trim(TheDetails)# & "value='" & #Content# & "'">
			</cfif>
		</cfif>
		
		<!--- Table Background Image  --->
		<cfif #DisplayTypeID# is 3>
			<cfset Details = #Details# & "Select Table Background Graphic:<br> <select name='D#PositionID#'>">
			<cfif #Action# is "Edit">
				<cfset MatchID = #Content#>
			</cfif>
			<cfinclude template="GetGraphic.cfm">
			<cfset TheDetails=#trim(TheDetails)# & "</select><br>">
		</cfif>
		
		<!--- Table Cell Background Color  --->
		<cfif #DisplayTypeID# is 4>
			<cfset Details=#Details# & "Select Cell Background color:<br><input type='text' name='D#PositionID#'"> 
			<cfif #Action# is "Edit">
				<cfset TheDetails=#trim(TheDetails)# & "value='" & #Content# & "'">
			</cfif>
		</cfif>
		
		<!--- Table Cell Background Image  --->
		<cfif #DisplayTypeID# is 5>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#trim(Content)#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfset tContent=#trim(GetThisGraphic.content)#>
			</cfif>
			<cfquery name="GetGraphic" dbtype="query">
				select GraphicsID,filename from AllGraphics 
				<cfif isnumeric(#tContent#)>
				Where GraphicsID='#tcontent#'
				<cfelse>
				where GraphicsTypeID='10' or GraphicsTypeID='11' or GraphicsTypeID='12'
				</cfif>
			</cfquery>
			<cfif #getGraphic.Recordcount# gt 0>
				<cfset ThisContent = " background='#getGraphic.Filename#' ">
				<cfset TheDetails="#trim(TheDetails)##trim(ThisContent)#">
			</cfif>
		
		</cfif>
		
		<!--- Image --->
		<cfif #DisplayTypeID# is 6>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#trim(Content)#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfset tContent=#trim(GetThisGraphic.content)#>
			</cfif>
			
			<cfquery name="GetGraphic" dbtype="query">
				select GraphicsID,filename from AllGraphics 
				<cfif isnumeric(#tContent#)>
				Where GraphicsID='#tcontent#'
				<cfelse>
				where GraphicsTypeID='10' or GraphicsTypeID='11' or GraphicsTypeID='12'
				</cfif>
			</cfquery>
			<cfset ThisContent = "<img src=#getGraphic.Filename#>">
			<cfset TheDetails="#trim(TheDetails)##trim(ThisContent)#">
		</cfif>
		
		<!--- Logo Image --->
		<cfif #DisplayTypeID# is 13>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#trim(Content)#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfset tContent=#trim(GetThisGraphic.content)#>
			</cfif>
			<cfquery name="GetGraphic" dbtype="query">
				select GraphicsID,filename from AllGraphics 
				<cfif isnumeric(#tContent#)>
				Where GraphicsID='#tcontent#'
				<cfelse>
				where GraphicsTypeID='5' or GraphicsTypeID='6' or GraphicsTypeID='7'
				</cfif>
			</cfquery>
			<cfset TheDetails="#trim(TheDetails)#<img src=#getGraphic.Filename#>">
		</cfif>
		
		<!--- Banner Image --->
		<cfif #DisplayTypeID# is 14>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#trim(Content)#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfset tContent=#trim(GetThisGraphic.content)#>
			</cfif>
			
			<cfquery name="GetGraphic" dbtype="query">
				select GraphicsID,filename from AllGraphics 
				<cfif isnumeric(#tContent#)>
				Where GraphicsID='#tcontent#'
				<cfelse>
				where GraphicsTypeID='10' or GraphicsTypeID='11' or GraphicsTypeID='12'
				</cfif>
			</cfquery>
			<cfset TheDetails="#trim(TheDetails)#<img src=#getGraphic.Filename#>">
		</cfif>
		
		<!--- Product Listing Script --->
		<cfif #DisplayTypeID# is 15>
			<cfset TheDetails = #trim(TheDetails)# & #content#>
		</cfif>
		
		<cfoutput>#trim(TheDetails)#</cfoutput>
		<cfset TheDetails=''>
		
		<!--- Text --->
		<cfif #DisplayTypeID# is 7>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent7="The content of the Web Site goes here.">
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfset tContent7=#trim(GetThisGraphic.content)#>
			</cfif>
			<cfset tContent7=replacenocase(#tContent7#,"`","'","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"~",",","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;s","'s","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;t","'t","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;r","'r","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;l","'l","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;v","'v","ALL")>
			<cfset tContent7=replacenocase(#tContent7#,"&amp;d","'d","ALL")>
			<Cfset tContent7=replacenocase(#tContent7#,"^","&","ALL")>
			<cfif isdefined("session.affiliateid")>
				<cfset tContent7=replacenocase(#tContent7#,"%aid%","#session.affiliateid#","ALL")>
			</cfif>
			<cfset FirstHalf=''>
			<cfset SecondHalf=''>
			<cfset LastHalf=''>
			<cfset FirstScript=''>
			<cfset SecondScript=''>
			<cfset DoIt=0>
			<cfset tPos=findnocase("ScriptIs",#tContent7#)>
			<cfif tPos gt 0>
				<cfset tLen = len(trim(#tContent7#))>
				<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
				<cfif #tpos# is 2>
					<cfset FirstHalf=''>
					<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
					<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
					<!--- <cfinclude template="../scripts/#FirstScript#.cfm"> --->
					<cfinvoke method="#firstScript#"></cfinvoke>
					<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
					<cfif lpos neq tlen>
						<cfset SecondHalf=#tContent7#>
					<cfelse>
						<cfset SecondHalf=''>
					</cfif>
				<cfelse>
					<cfset scriptLen=lPos - tPos >
					<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
					<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
					<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
					<cfoutput>#FirstHalf#</cfoutput>
					<!--- <cfinclude template="../scripts/#FirstScript#.cfm"> --->
					<cfinvoke method="#firstScript#"></cfinvoke>
					<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
				</cfif>
				<cfif #SecondHalf# neq ''>
					<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
					<cfif tPos gt 0>
						<cfset tLen = len(trim(#SecondHalf#))>
						<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
						<cfif #tpos# is 2>
							<cfset FirstHalf=''>
							<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
							<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
							<!--- <cfinclude template="../scripts/#FirstScript#.cfm"> --->
							<cfinvoke method="#firstScript#"></cfinvoke>
							<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
							<cfif lpos neq tlen>
								<cfset ThirdHalf=#SecondHalf#>
							<cfelse>
								<cfset ThirdHalf=''>
							</cfif>
							<cfoutput>#ThirdHalf#</cfoutput>
						<cfelse>
							<cfset scriptLen=lPos - tPos >
							<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
							<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
							<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
							<cfoutput>#FirstHalf#</cfoutput>
							<!--- <cfinclude template="../scripts/#FirstScript#.cfm"> --->
							<cfinvoke method="#firstScript#"></cfinvoke>
							<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
							<cfoutput>#ThirdHalf#</cfoutput>
						</cfif>
					<cfelse>
						<cfoutput>#SecondHalf#</cfoutput>
					</cfif>
				</cfif>
			<cfelse>
				<cfoutput>#tContent7#</cfoutput>
			</cfif>
			
		</cfif>
		
		<!--- One Navigation Link --->
		<cfif #DisplayTypeID# is 8>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset content=replacenocase(#content#,"~",",","ALL")>
			<cfset tContent=#content#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfif isnumeric(left(#GetThisGraphic.content#,1))>
					<cfset tContent=#GetThisGraphic.content#>
					<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
				</cfif>
			</cfif>
			<cfif isnumeric(left(#tcontent#,1))>
				<cfset Details=''>
				<cfloop query="allnavigation">
					<cfif listFind(#tContent#,#NavID#)>
						<cfset Details='#Details#<a href="index.cfm?page=#Anchor#" class=nav>'>
						<cfif NavTypeID is 3><cfset Details='#Details# #LinkText# |'> 
						<cfelseif NavTypeID is 1><cfset Details='#Details#<img src="#filename#" border=0>'>
						<cfelse><cfset Details='#Details#<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
		 WIDTH="336" HEIGHT="280" id="#LinkText#" ALIGN=""><PARAM NAME=movie VALUE="images/#filename#"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src="mainbeyoga.swf" quality=high bgcolor=##FFFFFF  WIDTH="336" HEIGHT="280" NAME="mainbeyoga" ALIGN=""
		 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
		</OBJECT>'>
						</cfif><cfset Details='#Details#</a>'>
					</cfif>
				</cfloop>
				<cfoutput>#Details#</cfoutput>
			<cfelse>
				<cfset tContent=''>
				<cfset tCounter=1>
				<cfset Details=''>
				<cfloop query="AllNavigation">
					<cfif tCounter is 1>
						<cfset tContent="#NavID#">
						<cfset tCounter=2>
					<cfelse>
						<cfset tContent="#tContent#,#NavID#">
					</cfif>
					<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav>">
					<cfif NavTypeID is 3>
					<cfset Details="#Details##LinkText# | ">
					<cfelseif NavTypeID is 1>
					<cfset Details="#Details#<img src=""#filename#"" border=0>">
					<cfelse>
					<cfset Details="<OBJECT classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000""
		 codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0""
		 WIDTH=""336"" HEIGHT=""280"" id=""#LinkText#""><PARAM NAME=movie VALUE=""images/#filename#""> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src=""mainbeyoga.swf"" quality=high bgcolor=##FFFFFF  WIDTH=""336"" HEIGHT=""280"" NAME=""mainbeyoga"" 
		 TYPE=""application/x-shockwave-flash"" PLUGINSPAGE=""http://www.macromedia.com/go/getflashplayer""></EMBED></OBJECT>">
					</cfif>
					<cfset Details="#Details#</a>">
				</cfloop>
				<cfoutput>#Details#</cfoutput>
			</cfif>
		</cfif>
		
		<cfoutput>#trim(TheDetails)#</cfoutput>
		<cfset TheDetails=''>
		
		<!--- Navigation Drop Down List --->
		<cfif #DisplayTypeID# is 17>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#content#>
			<cfinvoke component="#Application.WebSitePath#.utilities.Navigation" method="RunNavigation">
				<cfinvokeargument name="Content" value="#TContent#">
			</cfinvoke>
		</cfif>
		
		<!--- Navigation Link List--->
		<cfif #DisplayTypeID# is 9>
			<cfset Details=''>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset content=replacenocase(#content#,"~",",","ALL")>
			<cfset tContent=#content#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfif isnumeric(left(#GetThisGraphic.content#,1))>
					<cfset tContent=#GetThisGraphic.content#>
					<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
				</cfif>
			</cfif>
			<cfif isnumeric(left(#tcontent#,1))>
				<cfloop query="allnavigation">
					<cfif listFind(#tContent#,#NavID#)>
						<cfif NavTypeID is 3>
						<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav>#LinkText#</a><br>">
						<cfelseif NavTypeID is 1>
							<cfif findnocase("_off",#filename#)>
								<cfset tImage=replacenocase(#filename#,"_off","_on")>
								<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=""nav"" onmouseout=""changeImages('#Anchor#', '#filename#'); return true;"" onmouseover=""changeImages('#Anchor#', '#tImage#'); return true;""><img src=""#filename#"" border=0 name=""#Anchor#""></a><br><br>">
							<cfelse>
								<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav><img src=""#filename#"" border=0></a><br>">
							</cfif>
						<br>
						<cfelse>
						<cfset Details="#Details#<OBJECT classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000""
		 codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0""
		 WIDTH=""336"" HEIGHT=""280"" id=""#LinkText#""><PARAM NAME=movie VALUE=""images/#filename#""> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src=""images/#filename#"" quality=high bgcolor=##FFFFFF  WIDTH=""336"" HEIGHT=""280"" NAME=""#linkText#"" 
		 TYPE=""application/x-shockwave-flash"" PLUGINSPAGE=""http://www.macromedia.com/go/getflashplayer""></EMBED></OBJECT><br>">
						</cfif>
					</cfif>
				</cfloop>
			<cfelse>
				<cfset tContent=''>
				<cfset tCounter=1>
				<cfloop query="AllNavigation">
					<cfif tCounter is 1>
						<cfset tContent="#NavID#">
						<cfset tCounter=2>
					<cfelse>
						<cfset tContent="#tContent#,#NavID#">
					</cfif>
					<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"">">
					<cfif NavTypeID is 3>
					<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav>">
					<cfset Details="#LinkText#<br>">
					<cfelseif NavTypeID is 1>
					<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"">">
					<cfset Details="#Details#<img src=""#filename#"" border=0>">
					<cfelse>
					<cfset Details="#Details#<OBJECT classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000""
		 codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0""
		 WIDTH=""336"" HEIGHT=""280"" id=""#LinkText#""><PARAM NAME=movie VALUE=""images/#filename#""> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src=""images/#filename#"" quality=high bgcolor=##FFFFFF  WIDTH=""336"" HEIGHT=""280"" NAME=""#linkText#""
		 TYPE=""application/x-shockwave-flash"" PLUGINSPAGE=""http://www.macromedia.com/go/getflashplayer""></EMBED></OBJECT>">
					</cfif>
					<cfset Details="#Details#</a><br>">
				</cfloop>
			</cfif>
			<cfoutput>#Details#</cfoutput>
		</cfif>
		
		<!--- Sideways Navigation Link List--->
		<cfif #DisplayTypeID# is 10>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset content=replacenocase(#content#,"~",",","ALL")>
			<cfset tContent=#content#>
			<cfif #GetThisGraphic.RecordCount# gt 0>
				<cfif isnumeric(left(#GetThisGraphic.content#,1))>
					<cfset tContent=#GetThisGraphic.content#>
					<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
				</cfif>
			</cfif>
			<cfif isnumeric(left(#tcontent#,1))>
				<cfset Details=''>
				<cfloop query="allnavigation">
					<cfif listFind(#tContent#,#NavID#)>
						<!--- <cfset Details='#Details#<a href="index.cfm?page=#Anchor#" class=nav>'> --->
						<cfif NavTypeID is 3><cfset Details='#Details#<a href="index.cfm?page=#Anchor#" class=nav>#LinkText#</a> ::'> 
						<cfelseif NavTypeID is 1>
							<cfif findnocase("_off",#filename#)>
								<cfset tImage=replacenocase(#filename#,"_off","_on")>
								<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=""white"" onmouseout=""changeImages('#Anchor#', '#filename#'); return true;"" onmouseover=""changeImages('#Anchor#', '#tImage#'); return true;""><img src=""#filename#"" border=0 name=""#Anchor#""></a>">
							<cfelse>
								<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav><img src=""#filename#"" border=0></a>">
							</cfif>
						<!--- <cfset Details='#Details#<img src="#filename#" border=0>'> --->
						<cfelse><cfset Details='#Details#<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
		 WIDTH="336" HEIGHT="280" id="#LinkText#" ALIGN=""><PARAM NAME=movie VALUE="images/#filename#"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src="mainbeyoga.swf" quality=high bgcolor=##FFFFFF  WIDTH="336" HEIGHT="280" NAME="mainbeyoga" ALIGN=""
		 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
		</OBJECT>'>
						</cfif><!--- <cfset Details='#Details#</a>'> --->
					</cfif>
				</cfloop>
				<cfoutput>#Details#</cfoutput>
			<cfelse>
				<cfset tContent=''>
				<cfset tCounter=1>
				<cfset Details=''>
				<cfloop query="AllNavigation">
					<cfif tCounter is 1>
						<cfset tContent="#NavID#">
						<cfset tCounter=2>
					<cfelse>
						<cfset tContent="#tContent#,#NavID#">
					</cfif>
					<cfset Details="#Details#<a href=""index.cfm?page=#Anchor#"" class=nav>">
					<cfif NavTypeID is 3>
					<cfset Details="#Details##LinkText# | ">
					<cfelseif NavTypeID is 1>
					<cfset Details="#Details#<img src=""#filename#"" border=0>">
					<cfelse>
					<cfset Details="<OBJECT classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000""
		 codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0""
		 WIDTH=""336"" HEIGHT=""280"" id=""#LinkText#""><PARAM NAME=movie VALUE=""images/#filename#""> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##FFFFFF> <EMBED src=""mainbeyoga.swf"" quality=high bgcolor=##FFFFFF  WIDTH=""336"" HEIGHT=""280"" NAME=""mainbeyoga"" 
		 TYPE=""application/x-shockwave-flash"" PLUGINSPAGE=""http://www.macromedia.com/go/getflashplayer""></EMBED></OBJECT>">
					</cfif>
					<cfset Details="#Details#</a>">
				</cfloop>
				<cfoutput>#Details#</cfoutput>
			</cfif>
		</cfif>
		
		<!--- Flash --->
		<cfif #DisplayTypeID# is 18>
			<cfquery name="GetThisGraphic" dbtype="query">
				select * from ThisPage where PositionID='#POsitionID#'
			</cfquery>
			<cfset tContent=#content#>
			<cfset displayContent=#allDetails.content#>displaycontent=#displayContent#
			<cfset Details=''>
			<cfif lcase(displayContent) is "sidemenu">
				<cfoutput><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0" width="135" height="500" id="sidemenu" align="middle"><param name="allowScriptAccess" value="sameDomain" /><param name="movie" value="images/flash/sidemenu.swf?page=#pagename#" /><param name="quality" value="high" /><param name="bgcolor" value="##ffffff" /><embed src="images/flash/sidemenu.swf?page=#pagename#" quality="high" bgcolor="##ffffff" width="135" height="500" name="sidemenu" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object></cfoutput>
			</cfif>
			<cfif lcase(displayContent) is "pagetype">
				<cfset framestop=#trim(getThisGraphic.content)#>
				<cfoutput><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0" width="782" height="160" id="sidemenu" align="middle"><param name="allowScriptAccess" value="sameDomain" /><param name="movie" value="images/flash/header.swf?ThisPage=#pagename#&FrameStop=#framestop#&memberID=#session.memberid#" /><param name="quality" value="high" /><param name="bgcolor" value="##ffffff" /><embed src="images/flash/header.swf?ThisPage=#pagename#&FrameStop=#framestop#&memberID=#session.memberid#" quality="high" bgcolor="##ffffff" width="782" height="160" name="sidemenu" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object></cfoutput>
			</cfif>
		</cfif>
		</cfloop>
		
		<!--- </Td></tr></table> --->
		
		</body>
		</html>
		</cfsetting>
		<!--- </cfprocessingdirective> --->

	</cffunction>
	
	<cffunction name="myProfile" output="true" access="remote">
		<cfparam name="frameStop" default="home">
		<cfif #frameStop# is "student">
			<cfset getMethod="getStudentConfig">
		<cfelseif #frameStop# is "trainee">
			<cfset getMethod="getTraineeConfig">
		<cfelseif #frameStop# is "licencee">
			<cfset getMethod="getLicenseeConfig">
		<cfelseif #frameStop# is "memberships">
			<cfset getMethod="getStudentConfig">
		</cfif>
		<cfinvoke component="#application.websitepath#.utilities.classes" returnvariable="textConfig" method="#getMethod#"></cfinvoke>
		<cfquery name="getMemberInfo" datasource="#application.DSN#" 
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname, lastname, memberid, accesslevel from members
			where memberid=#session.memberid#
		</cfquery>
		<cfif #getMemberInfo.AccessLevel# neq 1>
			<script>
			function goprofile() {	window.location.href="index.cfm?page=<cfoutput>#page#</cfoutput>&PageID=memberprofile&TemplateAction=editprofile";
			}
			</script>
			
			<cfoutput>
			<cfset AltStartPageText=replace(#AltStartPageText#,"#Chr(10)#","<p>","ALL")>
			<cfset AltStartPageText=replace(#AltStartPageText#,"'","`","ALL")>
			<cfset AltStartPageText=replace(#AltStartPageText#,"%T%",#T#,"ALL")>
			<script>
				win = window.open("", 'editwin' , 'width=300,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
				win.document.write('#PreserveSingleQuotes(AltStartPageTExt)#<p><a href=javascript:window.close()>Close This Window</a>')
				win.document.bgColor="lightblue"
				win.focus();
			</script>
			</cfoutput>
			<!--- <cfinclude template="../scripts/editprofile.cfm"> --->
		<cfelse>
			<cfoutput query="GetMemberInfo" maxrows=1>
			<cfset startPage=textConfig.startPage>
			<cfset startPage=replacenocase(startpage,"[Firstname]","#getMemberInfo.firstname#","ALL")>
			<cfset startPage=replacenocase(startpage,"~",",","ALL")>
			<p>#ParagraphFormat(startPage)#</p>
			</cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="listArticles" access="remote" output="true">
		<cfparam name="ArticleTypeID" default=0>
		<cfparam name="message" default=''>
		<cfif #Page# is "licenseCoachManual">
			<cfset ThisPageNo=83>
		<cfelse>
			<cfset ThisPageNo=#PageNo#>
		</cfif>
		<cfset OldPageID=Page>
		<cfquery name="GetArticles" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			SELECT Articles.*, ArticleTypes.*
			FROM Articles, ArticleTypes
			Where Articles.ArticleTypeID = ArticleTypes.TypeID
			and Articles.PageID=#ThisPageNo#
			<cfif #ArticleTypeID# neq 0>
				and Articles.ArticleTypeID=#ArticleTypeID#
			</cfif>
			order by ArticleTypeID,ArticleID
		</cfquery>
		
		<cfoutput><script>
		function openarticle(articleid) {
		
		winStr = 'scripts/viewAnArticle.cfm?page=#page#&ArticleID='+articleid;
			win = window.open(winStr, 'articles' , 'width=600,height=430,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		</script></cfoutput>
		
		<cfif #ArticleTypeID# gt 0 or findnocase("coachmanual",#Page#)>
		<cfoutput><table width="100%" border="0">
		<tr><td><h1><cfif findnocase("coachmanual",#Page#)>Coach Training Manual<cfelse>#trim(GetArticles.description)# Library</cfif></h1></td></tr></cfoutput>
		<cfoutput query="GetArticles">
		<tr>
		<td>
		<cfif #Author# neq ''>
		<cfset extension=ucase(right(#Trim(author)#,3))>
		<cfswitch expression="#Extension#">
			<cfcase value="DOC">
				<cfset Image="<img src='../Images/icoWord.gif' width='19' height='14' alt='' border='0'>">
			</cfcase>
			<cfcase value="PDF">
				<cfset Image="<img src='../Images/icoAcrobat.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="XLS">
				<cfset Image="<img src='../Images/icoXLS.gif' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="PPT">
				<cfset Image="<img src='../Images/icoPwerPoint.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="ZIP">
				<cfset Image="<img src='../Images/icoZIP.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="MDB">
				<cfset Image="<img src='../Images/icoAccess.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="TXT">
				<cfset Image="<img src='../Images/icoText.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfcase value="HTM,TML,CFM,ASP,PHP,JSP,HMS">
				<cfset Image="<img src='../Images/icoHTML.jpg' width='16' height='18' alt='' border='0'>">
			</cfcase>
			<cfdefaultcase>
				<cfset Image="<img src='../Images/icoUnknown.jpg' width='15' height='18' alt='' border='0'>">
			</cfdefaultcase>
		</cfswitch>
		<p>#image#<a href="#Trim(Author)#" target="MMM"><cfif #OldPageID# neq "coachmanual" or #OldPageID# neq "licenseCoachManual">#Dateformat(DateSTarted,"mm/dd/yyyy")# </cfif>#Title#</a><br>
		<cfelse>
		<p><img src="../Images/icoHTML.jpg" width="16" height="18" alt="" border="0"><a href="javascript:openarticle(#ArticleID#)"><cfif #OldPageID# neq "coachmanual"  or #OldPageID# neq "licenseCoachManual">#Dateformat(DateSTarted,"mm/dd/yyyy")# </cfif>#Title#</a> <br>
		</cfif>
		</td>
		</tr>
		</cfoutput>
		<Cfif findnocase("coachmanual",#Page#)>
		<cfelse><tr><td><p>&nbsp;</p><p><a href="javascript:history.go(-1)"><img src="images/frmBackToLibrary.gif"></a></p></td></tr></cfif>
		</table>
		<cfelse>
		<cfoutput><Table border="0">
			<tr><td><h5>Library Categories</h5></td></tr></cfoutput>
			<cfset ThisType=0>
			<cfoutput query="GetArticles">
				<cfif #ThisType# neq #ArticleTypeID#>
					<cfset ThisType=#ArticleTypeID#>
					<tr>
					<td><a href= "index.cfm?ArticleTypeID=#ArticleTypeID#&page=#Page#" class=articles>#Description#</a> (#NoOfArticles#)</td>
					</tr>
				</cfif>
			</cfoutput>
		<cfoutput></table></cfoutput>
		
		</cfif>
		
		<Cfif findnocase("coachmanual",#Page#)>
		<cfelse>
		<cfoutput><cfform action="../scripts/emailform.cfm?page=#Page#" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="subject" value="Library Article Request">
		<table><tr><td colspan=2><h3>Request New Library Articles</h3></td></tr>
		<cfif #message# neq ''><tr><td class=helloline>#Message#</td></tr></cfif>
		<tr><td>I would like #trim(application.websitename)# to provide a library article on the topic of:<br><input type="Text" name="Topic" size="25" maxlength="50"></td></tr>
		<tr><td>My email address is:<br><cfinput type="Text" name="email" message="Please enter your email address" required="Yes" size="25" maxlength="250"></td></tr>
		<tr><td>Other Comments:<br><textarea name="comments" cols="25" rows="3"></textarea></td></tr>
		<tr><td><br><input type="Image" name="submit" src="images/submit-off.gif"></td></tr>
		</table>
			
		</cfform></cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="infoRequest2" output="true" access="remote">
		<cfparam name="message" default=''>
		<cfparam name="pageName" default="contactus">
		<cfset Fullname=''>
		<cfset ThisAddress1=''>
		<cfset Thisaddress2=''>
		<cfset Thiscity=''>
		<cfset Thisstate=''>
		<cfset Thispostalcode=''>
		<cfset Thisemailaddress=''>
		<cfset ThisPhoneNumber=''>
		<cfset ThisCountry=''>
		<cfif isdefined('form.webEmail')>
			<CF_MailForm
			To="#trim(form.WebEmail)#"
			From="info@Wellcoaches.com"
			Subject="#Form.Subject#">
		<cfoutput>	<p><b>Thank you for contacting us.
		We will return your email as soon as possible.
		Wellcoaches® staff</b></p></cfoutput>
		<cfelse>
		
		<cfif #session.memberid# gt 0>
			<cfquery name="GetMemberInfo" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
				SELECT 
				Members.FirstName, 
				Members.LastName,
				Addresses.Address1, 
				Addresses.Address2, 
				Addresses.City, 
				Addresses.State, 
				Addresses.PostalCode, 
				Email.EMailAddress, 
				PhoneNumbers.PhoneNumber,
				Addresses.Country
				FROM Members, Email, Addresses, PhoneNumbers
				WHERE email.tableid=15
				and email.connectid = members.memberid and email.websiteid=1
				and PhoneNumbers.TableID=15
				and PhoneNumbers.ConnectID = Members.MemberID
				and Phonenumbers.phonetypeid=1
				and Addresses.tableid=15
				and Addresses.connectid = members.memberid
				and addresses.addresstypeid=1
				and Members.memberid=#sid#
			</cfquery>
			<cfoutput query="GetMemberInfo">
				<cfset FullName="#trim(Firstname)# #trim(lastname)#">
				<cfset ThisAddress1=#trim(address1)#>
				<cfset Thisaddress2=#trim(address2)#>
				<cfset Thiscity=#trim(city)#>
				<cfset Thisstate=#trim(state)#>
				<cfset Thispostalcode=#trim(postalcode)#>
				<cfset Thisemailaddress=#trim(emailaddress)#>
				<cfset ThisPhoneNumber=#trim(PhoneNumber)#>
				<cfset ThisCountry=#trim(Country)#>
			</cfoutput>
		<cfelse>
			<cfset FullName=''>
			<cfset ThisAddress1=''>
			<cfset Thisaddress2=''>
			<cfset Thiscity=''>
			<cfset ThisState=''>
			<cfset Thispostalcode=''>
			<cfset Thisemailaddress=''>
			<cfset ThisPhoneNumber=''>
			<cfset ThisCountry=''>
		</cfif>
				<cfform method="POST" action="index.cfm?page=#Page#">
				<cfoutput>
				<input type="hidden" name="subject" value="#PageName#">
				<input type="hidden" name="webEmail" value="#trim(application.email)#">
				
				 <div align="center"><center>
				 <table border="0" cellpadding="0" cellspacing="0" width="75%" height="296">
					<tr>
					  <td width="32%" height="25"><p>Your Name</p></td>
					  <td width="68%" height="25"><cfinput type="Text" name="ContactName" required="Yes" size="25" maxlength="50" value="#Fullname#"></td>
					</tr>
					<tr>
					  <td width="32%" height="25"><p>Address</p></td>
					  <td width="68%" height="25"><input type="text" name="Address" size="25" maxlength="50" value="#Thisaddress1#"></td>
					</tr>
					<tr>
					  <td width="32%" height="25"><p>City</p></td>
					  <td width="68%" height="25"><input type="text" name="City" size="25" maxlength="50" value="#Thiscity#"></td>
					</tr>
					<tr>
					  <td width="32%" height="25"><p>State</p></td>
					  <td width="68%" height="25"><input type="text" name="State" size="25" maxlength="50" value="#Thisstate#"></td>
					</tr>
					<tr>
					  <td width="32%" height="25"><p>Zip</p></td>
					  <td width="68%" height="25"><input type="text" name="Zip" size="25" maxlength="50" value="#ThisPostalCode#"></td>
					</tr>
					<tr>
					  <td width="32%" height="25"><p>Telephone</p></td>
					  <td width="68%" height="25"><cfinput type="Text" name="Telephone" required="No" size="25" maxlength="50" value="#Thisphonenumber#"></td>
					</tr>
		<!---             <tr>
					  <td width="32%" height="25"><p>Fax</p></td>
					  <td width="68%" height="25"><input type="text" name="Fax" size="25" maxlength="50"></td>
					</tr> --->
					<tr>
					  <td width="32%" height="25"><p>Email</p></td>
					  <td width="68%" height="25"><cfinput type="Text" name="Email" required="Yes" size="25" maxlength="50" value="#ThisEmailAddress#"></td>
					</tr></cfoutput>
					<tr>
					  <td width="32%" height="21"><p>Comments</p></td>
					  <td width="68%" height="21"><textarea rows="5" name="Comments" cols="20"></textarea></td>
					</tr>
					<tr><td></td><td><input type="Image" name="infosubmit" src="images/submit-off.gif"></td></tr>
				  </table>
				  </center></div>
				</cfform>
		</cfif>
	</cffunction>
	
	<cffunction name="membersignup" access="remote" output="true">
		<cfinclude template="../scripts/membersignup.cfm">
	</cffunction>
	
	<cffunction name="ecourselisting" access="remote" output="true">
		<cfinclude template="../scripts/ecourselisting.cfm">
	</cffunction>
	
	<cffunction name="memberlogin" access="remote" output="true">
		<cfinclude template="../scripts/memberlogin.cfm">
	</cffunction>
	 
	<cffunction name="currentpoll" access="remote" output="true">
		<cfinclude template="../scripts/currentpoll.cfm">
	</cffunction>
	
	<cffunction name="facultylist" access="remote" output="true">
				<cfoutput><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0" width="400" height="400" id="MemberDirectory" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="http://www.wellcoach.com/images/flash/MemberDirectory.swf?dirType=2&dirTitle=Faculty" /><param name="quality" value="high" /><param name="bgcolor" value="##f7f7f7" /><embed src="http://www.wellcoach.com/images/flash/MemberDirectory.swf?dirType=2&dirTitle=Faculty" quality="high" bgcolor="##f7f7f7" width="400" height="400" name="MemberDirectory" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object></cfoutput>
		
	</cffunction>
	
	<cffunction name="edittraineeprofile" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getTraineeConfig" returnvariable="traineeConfig"></cfinvoke>
		<cfif isdefined('form.nextURL')>
			<cfinclude template="../scripts/updatetraineeprofile.cfm">
			<cfinvoke component="#application.websitepath#.utilities.membersSQL" 
				method="getFullMember" returnvariable="getMemberInfo">
				<cfinvokeargument name="memberid" value="#session.memberid#">
			</cfinvoke>
			<cfset StudentAFterEditAProfile=#traineeConfig.profileEdit#>
		
			<cfif StudentAFterEditAProfile neq ''>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[firstname]",#trim(GetMemberInfo.firstname)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[username]",#trim(GetMemberInfo.logon)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[password]",#trim(GetMemberInfo.passWord)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"~",",","ALL")>
			</cfif>
			
			<p><cfoutput>#ParagraphFormat(StudentAFterEditAProfile)#</cfoutput></p>
		<cfelse>
			<cfinclude template="../scripts/edittraineeprofile.cfm">
		</cfif>
	</cffunction>
	<cffunction name="edittraineeaccount" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getTraineeConfig" returnvariable="traineeConfig"></cfinvoke>
		<cfinclude template="../scripts/edittraineeaccount.cfm">
	</cffunction>
	
	<cffunction name="traineeclasslist" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getTraineeConfig" returnvariable="traineeConfig"></cfinvoke>
		<cfinclude template="../scripts/traineeclasslist.cfm">
	</cffunction>
	
	<cffunction name="facultyreg" access="remote" output="true">
		<cfif isdefined('form.nextURL')>
			<cfinclude template="../scripts/facultysignuplogic2.cfm">
		<cfelse>
			<cfinclude template="../scripts/facultyreg.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="traineeCurrentCourse" access="remote" output="true">
		<cfinclude template="../scripts/mycurrentcourse.cfm">
	</cffunction>
	
	<cffunction name="viewlesson" access="remote" output="true">
		<cfinclude template="../scripts/ecourseshow.cfm">
	</cffunction>
	
	<cffunction name="editmemberaccount" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getStudentConfig" returnvariable="studentConfig"></cfinvoke>
		<cfinclude template="../scripts/editmemberaccount.cfm">
	</cffunction>
	
	<cffunction name="editmemberprofile" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getStudentConfig" returnvariable="studentConfig"></cfinvoke>
		<cfif isdefined('form.nextURL')>
			<cfinclude template="../scripts/updatememberprofile.cfm">
			<cfinvoke component="#application.websitepath#.utilities.membersSQL" 
				method="getFullMember" returnvariable="getMemberInfo">
				<cfinvokeargument name="memberid" value="#session.memberid#">
			</cfinvoke>
			<cfset StudentAFterEditAProfile=#studentConfig.profileEdit#>
		
			<cfif StudentAFterEditAProfile neq ''>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[firstname]",#trim(GetMemberInfo.firstname)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[username]",#trim(GetMemberInfo.logon)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"[password]",#trim(GetMemberInfo.passWord)#,"ALL")>
				<cfset StudentAFterEditAProfile=replacenocase(#StudentAFterEditAProfile#,"~",",","ALL")>
			</cfif>
			
			<p><cfoutput>#ParagraphFormat(StudentAFterEditAProfile)#</cfoutput></p>
		<cfelse>
			<cfinclude template="../scripts/editmemberprofile.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="memberpassword" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.classes" method="getTraineeConfig" returnvariable="traineeConfig"></cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.membersSQL" 
				method="getFullMember" returnvariable="getMemberInfo">
				<cfinvokeargument name="memberid" value="#session.memberid#">
			</cfinvoke>
		<cfinclude template="../scripts/memberpassword.cfm">
	</cffunction>
	
	<cffunction name="freeclasses" access="remote" output="true">
		<cfinclude template="../scripts/freeclasses.cfm">
	</cffunction>
	
	<cffunction name="requesttopic" access="remote" output="true">
		<cfinclude template="../scripts/requesttopic.cfm">
	</cffunction>
	
	<cffunction name="discussions" access="remote" output="true">
		<cfinvoke component="#application.websitepath#.utilities.membersSQL" method="getMember" returnvariable="getmemberinfo">
			<cfinvokeargument name="memberid" value="#session.memberid#">
		</cfinvoke>
		<cflocation url="myforum/index.cfm?returnPage=#page#&OldMemberID=#session.memberid#&subTypeID=#getmemberinfo.subtypeid#&othertypeid=#getmemberinfo.occupation#">
	</cffunction>
	
	<cffunction name="newsletter" access="remote" output="true">
		<cfinclude template="../scripts/newsletter.cfm">
	</cffunction>
	
	<cffunction name="traineeregistration" access="remote" output="true">
		<cfinclude template="../scripts/traineeregistration.cfm">
	</cffunction>
	
	<cffunction name="getname" access="remote" output="true">
		<cfinclude template="../scripts/getname.cfm">
	</cffunction>
</cfcomponent>