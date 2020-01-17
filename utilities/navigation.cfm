<cfparam name="NavID" default=0>
<cfparam name="PositionID" default="0000000001">
<cfparam name="NavTypeID" default=3>
<cfparam name="Filename" default='none'>
<cfparam name="AltText" default="none">
<cfparam name="Anchor" default="none">
<cfparam name="LinkText" default="none">
<cfparam name="NavAction" default="List">
<cfparam name="xLevel" default="Folder">
<cfparam name="tLevelUnder" default="0">
<cfparam name="PageLink" default="0">


<cfif NavAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="navigation">
		<cfinvokeargument name="XMLFields" value="NavID,FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,xLevel,LevelUnder,PageLink">
		<cfinvokeargument name="XMLIDField" value="NavID">
		<cfinvokeargument name="XMLIDValue" value="#NavID#">
	</cfinvoke>
	<cfset NavAction="list">
	<cfset NavID=0>
</cfif>
<cfif NavID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Graphics">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="navigation">
		<cfinvokeargument name="IDFieldName" value="NavID">
		<cfinvokeargument name="IDFieldValue" value="#NavID#">
	</cfinvoke>
	<cfoutput query="Graphics">
		<cfset FileName=#FileName#>
		<cfset NavTypeID=#NavTypeID#>
		<cfset AltText="#AltText#">
		<cfset LinkText="#LInkText#">
		<cfset PositionID=#PositionID#>
		<cfset Anchor=#Anchor#>
		<cfset xLevel=#xLevel#>
		<cfset tLevelUnder=#LevelUnder#>
        <cfset PageLink=#PageLink#>
	</cfoutput>
	<cfset NavAction="update">
</cfif>
		
<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.Filename="images/#image#">
	</cfif>
	<cfif NavID gt 0>
		<cfif NavAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="XMLFields" value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,xLevel,LevelUnder,PageLink">
				<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#form.NavTypeID#,#form.AltText#,#form.LinkText#,#form.Anchor#,#form.PositionID#,#form.xLevel#,#form.levelUnder#,#form.PageLink#">
				<cfinvokeargument name="XMLIDField" value="NavID">
				<cfinvokeargument name="XMLIDValue" value="#NavID#">
			</cfinvoke>
		<cfelseif NavAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="utilities">
				<cfinvokeargument name="ThisFileName" value="navigation">
				<cfinvokeargument name="XMLFields" value="NavID,FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,xLevel,LevelUnder,PageLink">
				<cfinvokeargument name="XMLIDField" value="NavID">
				<cfinvokeargument name="XMLIDValue" value="#NavID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="navigation">
			<cfinvokeargument name="XMLFields" value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,xLevel,LevelUnder">
				<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#form.NavTypeID#,#form.AltText#,#form.LinkText#,#form.Anchor#,#form.PositionID#,#form.xLevel#,#form.levelUnder#,#form.PageLink#">
			<cfinvokeargument name="XMLIDField" value="NavID">
		</cfinvoke>
	</cfif>
	<cfset NavAction="list">
	<cfset FileName="none">
	<cfset NavTypeID = 0>
	<cfset NavID = 0>
	<cfset AltText='none'>
	<cfset LinkText="none">
	<cfset PositionID="0000000001">
	<cfset Anchor="none">
	<cfset xLevel="Folder">
	<cfset LevelUnder="0">
    <cfset PageLink = "0">
</cfif>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Nav">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="navigation">
	<cfinvokeargument name="orderbyStatement" value=" order by xLevel">
</cfinvoke>
<cfoutput><h1>Web Site Navigation</h1>
<FORM action="adminheader.cfm?uploadfile=true" method="post" enctype="multipart/form-data" name="thisform">
<input type="hidden" name="action" value="#action#">
<input type="hidden" name="NavID" value="#NavID#">
<input type="hidden" name="filename" value="#filename#">
<input type="hidden" name="NavAction" value="#NavAction#">
<TABLE>

	<tr>
	<td valign="top"> <b>Link Type</b> </td>
	<td>
		Graphic: <input type="Radio" name="NavTypeID" value="1" <cfif #NavTypeID# is 1>checked</cfif>><br>
		Flash File:<input type="Radio" name="NavTypeID" value="2"<cfif #NavTypeID# is 2>checked</cfif>><br>
		Text: <input type="Radio" name="NavTypeID" value="3"<cfif #NavTypeID# is 3>checked</cfif>>
	</td>
	</tr>
	<tr>
	<td valign="top"> <b>Link Level</b> </td>
	<td>
		Top Level: <input type="Radio" name="xLevel" value="0"<cfif #xLevel# is "0"> checked</cfif>><br>
		2nd Level: <input type="Radio" name="xLevel" value="1"<cfif #xLevel# is "1"> checked</cfif>><br>
		3nd Level: <input type="Radio" name="xLevel" value="2"<cfif #xLevel# is "2"> checked</cfif>>
	</td>
	</tr>
	
	<tr>
	<td valign="top"> <b>Under</b> </td>
	<td>
		<select name="LevelUnder">
			<option value="0">None</option>
			<cfloop query="nav">
				<option value="#nav.NavID#"<cfif #tlevelUnder# is #nav.NavID#> selected</cfif>>#nav.linkText#</option>
			</cfloop>
		</select>
	</td>
	</tr>
	
	<TR>
	<TD valign="top"> <b>Navigation Position:</b>
<br>
Whether your navigation links go across the page, or top to bottom down the side, you must define the order that the Navigation links will appear on the page when you're selecting navigation for a horizontal or vertial navigation list. The number 1 position will appear first/top and the number 2 position will appear second/next, and so on. All Navigation links <b>MUST</b> have a unique Navigation Position.
 </TD>
    <TD>
		<select name="PositionID">
			<option value="0">None</option>
			<cfloop index="I" from="1" to="300">
				<cfset tLen=Len(I)>
				<cfset NewID=I>
				<cfloop index="XX" from="#tLen#" to="9">
					<cfset NewID="0#NewID#">
				</cfloop>
				<option value="#NewID#" <cfif #PositionID# is #NewID#>selected</cfif>>#I#</option>
			</cfloop>
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> <b>Upload graphic:</b> <br><B>If you selected "Graphic" or "Flash File" above</b>, Click the browse button and upload the graphic or Flash File</TD>
    <TD>
		<INPUT type="file" name="image" value="#trim(FileName)#" maxLength="50">
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> <b>Text of the link:</b> <br><B>If you selected Navigation Text above</b>, enter what you would like the Navigation Text to say here. Make it short and meaningful.</LI><li>If you have uploaded your own navigation buttons, enter nothing here</TD>
    <TD>
		<INPUT type="text" name="LinkText" value="#trim(LinkText)#" maxLength="50">
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> <b>Description (alt text) of Graphic or Link:</b> <OL><LI><b>The contents of this field will display if someone holds their mouse over your text link. You can use it to add further explanation about your link, if desired. This is an optional field.</LI></OL></td>
    <TD>
	
		<INPUT type="text" name="AltText" value="#AltText#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	

	<TR>
	<TD valign="top"> <b>URL</b> (If you are linking to a page on <b>YOUR</b>Website that was created by you,just type the <b>single word</b> page name in as you did when you created the page. If it is a link to a different Website then type in the full URL i.e. http://www.website.com): </TD>
    <TD>
		<INPUT type="text" name="Anchor" value="#Anchor#" size="50" maxLength="250">
		
	</TD>

	</TR>
    <TR>
	<TD valign="top">Main anchor link</td>
    <TD>
	
		<INPUT type="text" name="PageLink" value="#PageLink#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="Save Changes">


</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="navigation">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Allnavigation">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="navigation">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Nav">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="navigation">
		<cfinvokeargument name="orderbyStatement" value=" order by xLevel">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="7" align="CENTER" bgcolor="Maroon"><p><font color="#FFFFFF">Your Web Site Navigation</font></p></th>
<tr>
<td><p>ID</p></td>
<td><p>Description</p></td>
<td><p>Navigation Type</p></td>
<td><p>Link</p></td>
<td><p>Under</p></td>
<td><p>Position</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="Allnavigation">
<tr>
<td><p>#int(NavID)#</p></td>
<td><p><cfif #Filename# neq 'none'><a href="#application.returnpath#/#Filename#" target="MSM">#AltText#</a><cfelse>#LinkText# - #AltText#</cfif></p></td>
<td>
	<p><cfif #NavTypeID# is 1>Graphic</cfif>
	<cfif #NavTypeID# is 2>Flash File</cfif>
	<cfif #NavTypeID# is 3>Text</cfif></p>
</td>
<td><p>#Anchor#</p></td>
<cfquery name="under" dbtype="query">
	select linktext from Nav where navid='#levelunder#'
</cfquery>
<cfif under.recordcount gt 0>
	<cfset tUnder=#under.linktext#>
<cfelse>
	<cfset tUnder=#LevelUnder#>
</cfif>
<td><p>#tUnder#</p></td>
<td><p>#int(PositionID)#</p></td>
<td><a href= "adminheader.cfm?NavID=#NavID#&NavAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?NavID=#NavID#&NavAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

