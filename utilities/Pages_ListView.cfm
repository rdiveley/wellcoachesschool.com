<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="pages">
	<cfinvokeargument name="ThisPath" value="pages">
</cfinvoke>	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="alltemplates">
	<cfinvokeargument name="ThisPath" value="Templates">
	<cfinvokeargument name="ThisFileName" value="templates">
</cfinvoke>
<h1>Pages</h1>

<form action="adminheader.cfm" method="post" name="addnew">
<input type="hidden" name="action" value="pages_recordedit">
<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Add a New Page using template:</font> <select name="templateID">
	<cfoutput query="alltemplates">
		<option value="#TemplateID#">#filename#</option>
	</cfoutput>
</select><input type="submit" name="selectemplate" value="Go">
</form>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllPages">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="pages">
		<cfinvokeargument name="orderByStatement" value=" order by pagename">
	</cfinvoke>
	<table class=toptable>
	<th colspan="6" align="CENTER" bgcolor="#800040">Your Pages</th>
	<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Title</th>
	<th>Actions</th>
	</tr>
	
	<cfoutput query="AllPages">
		<tr>
		<td><p>#int(PageID)#</p></td>
		<td><p>#PageName#</p></td>
		<td><p>#PageTitle#</p></td>
		
		<td>
		<a href= "adminheader.cfm?PageID=#PageID#&Action=pages_recordedit">Edit Page Specifications</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif #Pagename# neq "homepage">
		
		<a href="javascript:confirmDelete('adminheader.cfm?PageID=#PageID#&PageAction=Delete&Action=pages_recordedit')">Delete this page</a></cfif>
		<br>
		<a href="adminheader.cfm?PageID=#PageID#&Action=homepage">Edit the page</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#application.returnpath#/index.cfm?page=#pagename#" target="MSM">View Completed Page</a></td>
		</tr>
	</cfoutput>
	
	</table>
</cfif>