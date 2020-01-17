<cfparam name="IconID" default=0>
<cfparam name="IconAction" default="List">
<cfparam name="IconFileName" default="none">
<cfparam name="IconName" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllIconNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="IconNames">
</cfinvoke>

<cfif IconAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="IconNames">
		<cfinvokeargument name="XMLFields" value="IconID,IconFileName,IconName">
		<cfinvokeargument name="XMLIDField" value="IconID">
		<cfinvokeargument name="XMLIDValue" value="#IconID#">
	</cfinvoke>
	<cfset IconID=0>
	<cfset IconAction="List">
</cfif>
		
<cfif IconID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="IconNames">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="IconNames">
		<cfinvokeargument name="IDFieldName" value="IconID">
		<cfinvokeargument name="IDFieldValue" value="#IconID#">
	</cfinvoke>
	<cfoutput query="IconNames">
		<cfset IconName=#replace(IconName,"~",",","ALL")#>
		<cfset IconFileName=#IconFileName#>
	</cfoutput>
	<cfset IconAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.IconName=replace(#form.IconName#,",","~","ALL")>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Forums\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="50"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.IconFileName="images/forums/#image#">
	</cfif>
	<cfif IconID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="IconNames">
<cfinvokeargument name="XMLFields" value="IconFileName,IconName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.IconFileName)#,#XMLformat(form.IconName)#">
			<cfinvokeargument name="XMLIDField" value="IconID">
			<cfinvokeargument name="XMLIDValue" value="#IconID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="IconNames">
			<cfinvokeargument name="XMLFields" value="IconFileName,IconName">
			<cfinvokeargument name="XMLFieldData" value="#XMLformat(form.IconFileName)#,#XMLformat(form.IconName)#">
			<cfinvokeargument name="XMLIDField" value="IconID">
		</cfinvoke>
	</cfif>
	<cfset IconAction="list">
	<cfset IconID = 0>
	<cfset IconFileName=''>
	<cfset IconName=''>
</cfif>

<cfoutput>
<h1>Discussion Forum Icons</h1>

<cfif IconAction is "Add" or IconAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="IconID" value="#IconID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="IconAction" value="#IconAction#">
<input type="hidden" name="IconFileName" value="#IconFileName#">
<TABLE>
	
	<TR>
	<TD valign="top"> Icon Name: </TD>
    <TD>
		<cfinput name="IconName" type="text" value="#IconName#" size="40" maxlength="100" required="yes" message="Please enter a Category Name">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Upload the Icon: </TD>
    <TD>
	
		<input type="file" name="image">
		<cfif #IconFileName# neq "none"><br>#replace(IconFileName,"images/forums/","")#</cfif>
	</TD>
	<!--- field validation --->
	</TR>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif IconAction is "list">

<a href="adminheader.cfm?Action=#Action#&IconAction=Add">Add A Forum Icon</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="IconNames">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllIconNames">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="IconNames">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Forum Icons</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Icon</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllIconNames">
		<tr>
		<td><p>#int(IconID)#</p></td>
		<td><p>#replace(IconName,"~",",","ALL")#</p></td>
		<td><p><img src="../#IconFileName#"></p></td>
		<td><a href= "adminheader.cfm?IconID=#IconID#&IconAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?IconID=#IconID#&IconAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
