
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGalleries">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="photoCategories">
</cfinvoke>
	
<cfparam name="PhotoID" default=0>
<cfparam name="PhotoAction" default="List">
<cfparam name="PhotoTitle" default="">
<cfparam name="PhotoDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PhotoPageName" default="homepage">
<cfparam name="ThePhoto" default="">

<cfif PhotoAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Photos">
		<cfinvokeargument name="XMLFields" value="PhotoID,PhotoDescription,PhotoTitle,DateCreated,PhotoPageName,ThePhoto">
		<cfinvokeargument name="XMLIDField" value="PhotoID">
		<cfinvokeargument name="XMLIDValue" value="#PhotoID#">
	</cfinvoke>
	<cfset PhotoID=0>
	<cfset PhotoAction="List">
</cfif>
		
<cfif PhotoID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Photos">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Photos">
		<cfinvokeargument name="IDFieldName" value="PhotoID">
		<cfinvokeargument name="IDFieldValue" value="#PhotoID#">
	</cfinvoke>
	<cfoutput query="Photos">
		<cfset PhotoTitle=#PhotoTitle#>
		<cfset DateCreated=#DateCreated#>
		<cfset PhotoDescription=#PhotoDescription#>
		<cfset PhotoPageName=#PhotoPageName#>
		<cfset ThePhoto=#ThePhoto#>
	</cfoutput>
	<cfset PhotoAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Gallery\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.ThePhoto="images/Gallery/#image#">
	</cfif>
	<cfif #form.ThePhoto# is ''><cfset form.ThePhoto="none"></cfif>
	<cfif #form.PhotoDescription# is ''><cfset form.PhotoDescription="none"></cfif>
	<cfif PhotoID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Photos">
			<cfinvokeargument name="XMLFields" value="PhotoDescription,PhotoTitle,DateCreated,PhotoPageName,ThePhoto">
		<cfinvokeargument name="XMLFieldData" value="#form.PhotoDescription#,#form.PhotoTitle#,#form.DateCreated#,#form.PhotoPageName#,#form.ThePhoto#">
			<cfinvokeargument name="XMLIDField" value="PhotoID">
			<cfinvokeargument name="XMLIDValue" value="#PhotoID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Photos">
			<cfinvokeargument name="XMLFields" value="PhotoDescription,PhotoTitle,DateCreated,PhotoPageName,ThePhoto">
			<cfinvokeargument name="XMLFieldData" value="#form.PhotoDescription#,#form.PhotoTitle#,#form.DateCreated#,#form.PhotoPageName#,#form.ThePhoto#">
			<cfinvokeargument name="XMLIDField" value="PhotoID">
		</cfinvoke>
	</cfif>
	<cfset PhotoAction="list">
	<cfset PhotoTitle="">
	<cfset DateCreated = #now()#>
	<cfset PhotoID = 0>
	<cfset PhotoDescription=''>
	<cfset PhotoTitle=#PhotoTitle#>
	<cfset PhotoPageName='homepage'>
	<cfset ThePhoto=''>
</cfif>

<cfoutput>
<h1>Photos</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="PhotoID" value="#PhotoID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="PhotoAction" value="#PhotoAction#">
<input type="hidden" name="ThePhoto" value="#ThePhoto#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Title: </TD>
    <TD>
	
		<INPUT type="text" name="PhotoTitle" value="#PhotoTitle#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<TEXTAREA name="PhotoDescription" cols=50 rows=5>#PhotoDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Photo: </TD>
    <TD>
		<input type="file" name="image"><br>#ThePhoto#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Gallery</td>
	<td><select name="PhotoPageName">
	   	<cfloop query="AllGalleries">
			<option value="#categoryid#" <cfif #PhotoPageName# is #categoryid#>selected</cfif>>#catdescription#
		</cfloop>
		</select></td>
	</tr>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="Photos">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllPhotos">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Photos">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Photos</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Thumbnail</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllPhotos">
<tr>
<td><p>#int(PhotoID)#</p></td>
<td><p>#PhotoTitle#</p></td>
<td><p><img src="../#ThePhoto#" height=50 width=50></p></td>

<td><a href= "adminheader.cfm?PhotoID=#PhotoID#&PhotoAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?PhotoID=#PhotoID#&PhotoAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

