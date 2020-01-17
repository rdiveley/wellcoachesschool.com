<cfcomponent>
	<cffunction access="remote" name="setNavigation" output="true" returntype="string">
		<cfargument name="XMLString" type="string" required="true">
		<cfinclude template="../website.ini">
		<cfset XMLString2=replace(#arguments.XMLString#,"&","&amp;","ALL")>
		<cffile action="WRITE" 
			file="#physicalpath#\utilities\NavigationXML.xml" 
			output="#XMLString2#" addnewline="No">
		

		<cffile action="READ" 
			file="#Application.UploadPath#\utilities\NavigationXML.xml" 
			variable="navXML">

		<cfset MyNav=XMLParse(#navXML#)>
		
		<cfloop index="i" from="1" to="#ArrayLen(MyNav.Folder.Folder)#">
			<cfset NavID=#MyNav.Folder.Folder[i].XMLAttributes.NavID#>
			<cfset ParentID=#MyNav.Folder.Folder[i].XMLAttributes.NavID#><br>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="ThisNav">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="IDFieldName" value="NavID">
				<cfinvokeargument name="IDFieldValue" value="#NavID#">
			</cfinvoke>
			<cfoutput query="ThisNav">
				<cfset FileName=#FileName#>
				<cfset NavTypeID=#NavTypeID#>
				<cfset AltText="#AltText#">
				<cfset LinkText="#LInkText#">
				<cfset PositionID=#PositionID#>
				<cfset Anchor=#Anchor#>
				<cfset Level=#Level#>
			</cfoutput>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="XMLFields" 
				value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level">
				<cfinvokeargument name="XMLFieldData" 
				value="#Filename#,#NavTypeID#,#AltText#,#LinkText#,#Anchor#,#i#,Folder">
				<cfinvokeargument name="XMLIDField" value="NavID">
				<cfinvokeargument name="XMLIDValue" value="#NavID#">
			</cfinvoke>
			
			<cfif #arraylen(MyNav.Folder.Folder[i].xmlChildren)#>
		
				<cfloop index="k" from="1" to="#arraylen(MyNav.Folder.Folder[i].xmlChildren)#">
					<cfoutput>
					<cfset ChildNavID=#MyNav.Folder.Folder[i].xmlChildren[k].xmlAttributes.navid#>
					<cfset SubParentID=#MyNav.Folder.Folder[i].xmlChildren[k].xmlAttributes.navid#>
					</cfoutput>
					<cfif #arraylen(MyNav.Folder.Folder[i].xmlChildren[k].xmlChildren)#>
						<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
							method="GetXMLRecords" returnvariable="ThisNav">
							<cfinvokeargument name="ThisPath" value="utilities">
							<cfinvokeargument name="ThisFileName" value="navigation">
							<cfinvokeargument name="IDFieldName" value="NavID">
							<cfinvokeargument name="IDFieldValue" value="#ChildNavID#">
						</cfinvoke>
						<cfoutput query="ThisNav">
							<cfset FileName=#FileName#>
							<cfset NavTypeID=#NavTypeID#>
							<cfset AltText="#AltText#">
							<cfset LinkText="#LInkText#">
							<cfset PositionID=#PositionID#>
							<cfset Anchor=#Anchor#>
							<cfset Level=#Level#>
						</cfoutput>
						<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
							method="UpdateXMLRecord">
							<cfinvokeargument name="ThisPath" value="utilities">
							<cfinvokeargument name="ThisFileName" value="navigation">
							<cfinvokeargument name="XMLFields" 
							value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level">
							<cfinvokeargument name="XMLFieldData" 
							value="#Filename#,#NavTypeID#,#AltText#,#LinkText#,#Anchor#,#i#/#k#,Folder">
							<cfinvokeargument name="XMLIDField" value="NavID">
							<cfinvokeargument name="XMLIDValue" value="#ChildNavID#">
						</cfinvoke>
						<cfloop index="l" from="1" to="#arraylen(MyNav.Folder.Folder[i].xmlChildren[k].xmlChildren)#">
							<cfoutput>
							<cfset DeepChildNavID=#MyNav.Folder.Folder[i].xmlChildren[k].xmlChildren[l].xmlAttributes.navid#><br>
							</cfoutput>
							<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
								method="GetXMLRecords" returnvariable="ThisNav">
								<cfinvokeargument name="ThisPath" value="utilities">
								<cfinvokeargument name="ThisFileName" value="navigation">
								<cfinvokeargument name="IDFieldName" value="NavID">
								<cfinvokeargument name="IDFieldValue" value="#DeepChildNavID#">
							</cfinvoke>
							<cfoutput query="ThisNav">
								<cfset FileName=#FileName#>
								<cfset NavTypeID=#NavTypeID#>
								<cfset AltText="#AltText#">
								<cfset LinkText="#LInkText#">
								<cfset PositionID=#PositionID#>
								<cfset Anchor=#Anchor#>
								<cfset Level=#Level#>
							</cfoutput>
							<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
								<cfinvokeargument name="ThisPath" value="utilities">
								<cfinvokeargument name="ThisFileName" value="navigation">
								<cfinvokeargument name="XMLFields" 
								value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level">
								<cfinvokeargument name="XMLFieldData" 
								value="#Filename#,#NavTypeID#,#AltText#,#LinkText#,#Anchor#,#i#/#k#/#l#,Leaf">
								<cfinvokeargument name="XMLIDField" value="NavID">
								<cfinvokeargument name="XMLIDValue" value="#DeepChildNavID#">
							</cfinvoke>
						</cfloop>
						
					<cfelse>
					
					<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
						method="GetXMLRecords" returnvariable="ThisNav">
						<cfinvokeargument name="ThisPath" value="utilities">
						<cfinvokeargument name="ThisFileName" value="navigation">
						<cfinvokeargument name="IDFieldName" value="NavID">
						<cfinvokeargument name="IDFieldValue" value="#ChildNavID#">
					</cfinvoke>
					<cfoutput query="ThisNav">
						<cfset FileName=#FileName#>
						<cfset NavTypeID=#NavTypeID#>
						<cfset AltText="#AltText#">
						<cfset LinkText="#LInkText#">
						<cfset PositionID=#PositionID#>
						<cfset Anchor=#Anchor#>
						<cfset Level=#Level#>
					</cfoutput>
					<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
						<cfinvokeargument name="ThisPath" value="utilities">
						<cfinvokeargument name="ThisFileName" value="navigation">
						<cfinvokeargument name="XMLFields" 
						value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level">
						<cfinvokeargument name="XMLFieldData" 
						value="#Filename#,#NavTypeID#,#AltText#,#LinkText#,#Anchor#,#i#/#k#,Leaf">
						<cfinvokeargument name="XMLIDField" value="NavID">
						<cfinvokeargument name="XMLIDValue" value="#ChildNavID#">
					</cfinvoke>
					
					</cfif>
				</cfloop>
			</cfif>
			
		</cfloop>
		<cfreturn "done">
	</cffunction>
	
	<cffunction access="remote" name="getNavigation" output="true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Navigation">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="Thisfilename" value="navigation">
			<cfinvokeargument name="OrderbySTatement" value=" order by PositionID">
		</cfinvoke>
		<cfset NavigationXML='<Folder label="Navigation" data="Navigation">'>
		<cfset ThisLevel=#Navigation.Level#>
		<cfset tCount=1>
		<cfoutput query="navigation">
			<cfset filename=#filename#>
			<cfset NavTypeID=#NavTypeID#>
			<cfset AltText="#AltText#">
			<cfset LinkText="#LinkText#">
			<cfset PositionID=#PositionID#>
			<cfset Anchor=#Anchor#>
			<cfset Level=#level#>
				
			<cfif #ThisLevel# neq #level#>
				<cfif #level# is "Folder">
					<cfset NavigationXML=#NavigationXML# & "</Folder>">
				</cfif>
				<cfset #thisLevel# = #level#>
			<cfelseif #ThisLevel# is "Folder" and #level# is "Folder" and #tCount# neq 1>
				<cfset NavigationXML=#NavigationXML# & "</Folder>">
			</cfif>
			<cfset NavigationXML=#NavigationXML# & "<#Level# label=""#XMLFormat(LinkText)#"" data=""#XMLFormat(AltText)#"" NavID=""#NavID#""">
			<cfif #level# is "Leaf"><cfset NavigationXML=#NavigationXML# & " />">
			<cfelse><cfset NavigationXML=#NavigationXML# & ">"></cfif>
			<cfset tCount=2>
		</cfoutput>
		<cfset NavigationXML=#NavigationXML# & "</Folder></Folder>">

		<cffile action="WRITE" file="#Application.UploadPath#\utilities\NavigationXML.xml" output="#NavigationXML#" addnewline="No">
	</cffunction>
	
	<cffunction access="remote" name="runNavigation" output="true">
		<cfargument name="Content" type="string" default="" required="true">
		
		<!--- <cfinvoke method="parseNavigation"></cfinvoke> --->
		<cffile action="READ" 
			file="#Application.UploadPath#\utilities\NavigationXML.xml" 
			variable="navXML">
			
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Allnavigation">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="navigation">
		</cfinvoke>
		
		<cfset SubMenuCounter = 0>
		<cfset SubMenu=''>
		<cfset PositionCounter=0>
		<cfloop query="AllNavigation">
			<cfif ListLen(#Position#,"/") gt 1>
				<cfif #ListGetAt(PositionID,1,"/")# neq #PositionCounter#>
					<cfset SubMenu=#SubMenu# & "submenu[#SubMenuCounter#]='<br><a href=""index.cfm?page=#Anchor#"" ><img src=""#filename#"" border=0>">
				<cfelse>
					<cfset SubMenu=#SubMenu# & "<br><a href=""index.cfm?page=#Anchor#"" ><img src=""#filename#"" border=0>">
				</cfif>
			<cfelse>
				<cfset SubMenu=#SubMenu# & "submenu[#SubMenuCounter#]=''">
				<cfset SubMenuCounter = #SubMenuCounter# + 1>
			</cfif>
			<cfset PositionCounter=#ListGetAt(PositionID,1,"/")#>
		</cfloop>
		
		<cfset tcontent=replacenocase(#arguments.content#,"~",",","ALL")>

		<cfif isnumeric(left(#tcontent#,1))>
			<cfset MenuCounter=0>
			<cfoutput>
			<cfloop query="allnavigation">
				<cfif listFind(#tContent#,#NavID#)>
					<cfif ListLen(#PositionID#,"/") is 1>
						<cfif findnocase("_off",#filename#)>
							<cfset tImage=replacenocase(#filename#,"_off","_on")>
							<a href="index.cfm?page=#Anchor#" class="nav" onmouseout="changeImages('#Anchor#', '#filename#'); return true;" onmouseover="changeImages('#Anchor#', '#tImage#'); showit(#MenuCounter#); return true;"><img src="#filename#" border=0 name="#Anchor#"></a>
						<cfelse>
							<a href="index.cfm?page=#Anchor#" class=nav onmouseover="showit(#MenuCounter#); return true;"><img src="#filename#" border=0></a>
						</cfif>
						<cfset MenuCounter=#MenuCounter# + 1>
					</cfif>
				</cfif>
			</cfloop>
			</cfoutput>
		</cfif>
		
		<cfif #SubMenu# neq ''>
			<cfoutput>
			<script>
			#SubMenu#
			//Set delay before submenu disappears after mouse moves out of it (in milliseconds)
			var delay_hide=500
			
			/////No need to edit beyond here
			
			var menuobj=document.all.describe;
			//var menuobj=document.getElementById? document.getElementById("describe") : document.all? document.all.describe : document.layers? document.dep1.document.dep2 : ""
			
			function showit(which){
			clear_delayhide()
			thecontent=(which==-1)? "" : submenu[which]
			if (document.getElementById||document.all)
			menuobj.innerHTML=thecontent
			else if (document.layers){
			menuobj.document.write(thecontent)
			menuobj.document.close()
			}
			}
			
			function resetit(e){
			if (document.all&&!menuobj.contains(e.toElement))
			delayhide=setTimeout("showit(-1)",delay_hide)
			else if (document.getElementById&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
			delayhide=setTimeout("showit(-1)",delay_hide)
			}
			
			function clear_delayhide(){
			if (window.delayhide)
			clearTimeout(delayhide)
			}
			
			function contains_ns6(a, b) {
			while (b.parentNode)
			if ((b = b.parentNode) == a)
			return true;
			return false;
			}

			</script>
			</cfoutput>
		</cfif>
	</cffunction>
</cfcomponent>