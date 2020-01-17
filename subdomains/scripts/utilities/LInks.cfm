<cfparam name="LinkID" default=0>
<cfparam name="LinkAction" default="List">
<cfparam name="LinkCategory" default="none">
<cfparam name="LinkDescription" default="none">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="DateLastViewed" default="">
<cfparam name="AddlInstructions" default="0">
<cfparam name="Banner" default="none">
<cfparam name="Hits" default="0">
<cfparam name="LinkTitle" default="">
<cfparam name="LinkURL" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AddLinks">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Links">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllLinkCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="LinkCategories">
	<cfinvokeargument name="OrderbyStatement" value=" order by catdescription">
</cfinvoke>

<cfif LinkAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Links">
		<cfinvokeargument name="XMLFields" value="LinkID,DateCreated,LinkCategory,LinkDescription,DateLastViewed,AddlInstructions,Banner,LinkTitle,LinkURL,Hits">
		<cfinvokeargument name="XMLIDField" value="LinkID">
		<cfinvokeargument name="XMLIDValue" value="#LinkID#">
	</cfinvoke>
	<cfset LinkID=0>
	<cfset LinkAction="List">
</cfif>
		
<cfif LinkID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Links">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Links">
		<cfinvokeargument name="IDFieldName" value="LinkID">
		<cfinvokeargument name="IDFieldValue" value="#LinkID#">
	</cfinvoke>
	<cfoutput query="Links">
		<cfset LinkCategory=#replace(LinkCategory,"~",",","ALL")#>
		<cfset DateCreated=#DateCreated#>
		<cfset LinkDescription=#replace(LinkDescription,"~",",","ALL")#>
		<cfset DateLastViewed=#DateLastViewed#>
		<cfset AddlInstructions=#AddlInstructions#>
		<cfset Banner=#Banner#>
		<cfset LinkTitle=replacenocase(#LinkTitle#,"~",",","ALL")>
		<cfset LinkURL=replacenocase(#LinkURL#,"~",",","ALL")>
		<cfset Hits=#Hits#>
	</cfoutput>
	<cfset LinkAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.LinkDescription=#replace(form.LinkDescription,",","~","ALL")#>
	<cfset form.LinkTitle=#replace(form.LinkTitle,",","~","ALL")#>
	<cfset form.LinkURL=#replace(form.LinkURL,",","~","ALL")#>
	<Cfif #form.LinkDescription# is ""><cfset form.LinkDescription="none"></Cfif>
	<cfset form.LinkCategory=#replace(form.LinkCategory,",","~","ALL")#>
	<Cfif #form.LinkTitle# is ""><cfset form.LinkTitle="none"></Cfif>
	<Cfif #form.LinkURL# is ""><cfset form.LinkURL="none"></Cfif>
	<cfset form.AddlInstructions=#replace(form.AddlInstructions,",","~","ALL")#>
	<Cfif #form.AddlInstructions# is ""><cfset form.AddlInstructions="none"></Cfif>
	<cfif #form.DateLastViewed# is ''><cfset form.DateLastViewed="1/1/1900"></cfif>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Links\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.Banner="images/Links/#image#">
	</cfif>
	<cfif #form.Banner# is ''><cfset form.Banner="none"></cfif>
	<cfif LinkID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Links">
			<cfinvokeargument name="XMLFields" value="DateCreated,LinkCategory,LinkDescription,DateLastViewed,AddlInstructions,Banner,LinkTitle,LinkURL,Hits">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.LinkCategory#,#form.LinkDescription#,#form.DateLastViewed#,#form.AddlInstructions#,#form.Banner#,#form.LinkTitle#,#form.LInkURL#,#form.HIts#">
			<cfinvokeargument name="XMLIDField" value="LinkID">
			<cfinvokeargument name="XMLIDValue" value="#LinkID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Links">
			<cfinvokeargument name="XMLFields" value="DateCreated,LinkCategory,LinkDescription,DateLastViewed,AddlInstructions,Banner,LinkTitle,LinkURL,Hits">
		<cfinvokeargument name="XMLFieldData" value="#form.DateCreated#,#form.LinkCategory#,#form.LinkDescription#,#form.DateLastViewed#,#form.AddlInstructions#,#form.Banner#,#form.LinkTitle#,#form.LInkURL#,#form.HIts#">
			<cfinvokeargument name="XMLIDField" value="LinkID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=#action#">
</cfif>

<cfoutput>
<h1>Links</h1>

<cfif LinkAction is "Add" or LinkAction is "Update">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="LinkID" value="#LinkID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="LinkAction" value="#LinkAction#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="DateLastViewed" value="#DateLastViewed#">
<input type="hidden" name="Banner" value="#Banner#">
<input type="hidden" name="Hits" value="#Hits#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date Created: </TD>
    <TD>
	
		#dateformat(DateCreated,'mm/dd/yyyy')#
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date Last Viewed: </TD>
    <TD>
		<cfif DateLastViewed is "none">
		<cfelse>
		#dateformat(DateLastViewed,'mm/dd/yyyy')#
		</cfif>
	</TD>
	<!--- field validation --->
	</TR>
		
	<TR>
	<TD valign="top"> ## of Hits on this Link: </TD>
    <TD>
	
		#Hits# <input type="hidden" name="hits" value="#Hits#">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Banner: </TD>
    <TD>
		<input type="file" name="image"><br>
		<cfif #Banner# neq "none">Editing: #Banner#</cfif>
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Link Title: </TD>
    <TD>
	
		<INPUT type="text" name="LinkTitle" value="#replace(LinkTitle,'~',',','ALL')#" size="50" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Link URL: </TD>
    <TD>
	
		<INPUT type="text" name="LinkURL" value="#replace(LinkURL,'~',',','ALL')#" size="50" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Link Description: </TD>
    <TD>
	
		<INPUT type="text" name="LinkDescription" value="#replace(LinkDescription,'~',',','ALL')#" size="50" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Additional Instructions for showing banner: </TD>
    <TD>
	
		<textarea cols=50 rows=5 name="addlinstructions">#replace(addlinstructions,'~',',','ALL')#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>
	
		<tr>
	<td valign=top> Category this link belongs to</td>
	<td><select name="LinkCategory" multiple size=10>
	   	<cfloop query="AllLinkCategories">
			<option value="#CategoryID#" <cfif listfind(#LinkCategory#,#CategoryID#)>selected</cfif>>#CatDescription#
		</cfloop>
		</select></td>
	</tr>

</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</fORM>
</cfif>
</CFOUTPUT>

<cfif LinkAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&LinkAction=Add">Add A New Link</a></cfoutput><br>
<cfoutput><form name="searchform" action="adminheader.cfm?action=#action#" method="post">
	<p>Search by Link Category <select name="searchcat">
		<cfloop query="allLinkCategories">
			<option value="#CategoryID#">#CatDescription#</option>
		</cfloop>
	</select> <input type="submit" name="searchsubmit" value="GO"></p>
	</form></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="Links">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AddLinks">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Links">
			<cfif isdefined('form.searchcat')>
				<cfinvokeargument name="selectstatement" value=" where LinkCategory like '%#form.searchcat#%'">
			</cfif>
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Your Links</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Title</p></td>
	<td><p>Date Created</p></td>
	<td><p>Date Last Viewed</p></td>
	<td><p>Hits</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AddLinks">
	<tr>
	<td><p>#LinkID#</p></td>
	<td><p>#replace(LinkTitle,"~",",","ALL")#</p></td>
	<td><p>#dateformat(DateCreated,'mm/dd/yyyy')#</p></td>
	<td><cfif #DateLastViewed# neq "none"><p>#dateformat(DateLastViewed,'mm/dd/yyyy')#</p><cfelse>&nbsp;</cfif></td>
	<td><p>#Hits#</p></td>
	<td><a href= "adminheader.cfm?LinkID=#LinkID#&LinkAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?LinkID=#LinkID#&LinkAction=Delete&action=#action#')">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

