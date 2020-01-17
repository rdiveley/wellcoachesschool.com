
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllArticleTypes">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ArticleTypes">
	<cfinvokeargument name="OrderByStatement" value=" order by Description">
</cfinvoke>

<cfparam name="ArticleID" default=0>
<cfparam name="ArticleAction" default="List">
<cfparam name="Title" default="none">
<cfparam name="ArticleContent" default="none">
<cfparam name="DateStarted" default="#now()#">
<cfparam name="Author" default="none">
<cfparam name="ArticlePageName" default="homepage">
<cfparam name="LinkType" default="3">
<cfparam name="ArticleTypeID" default="0">
<cfparam name="DateEnded" default="#now()#">
<cfparam name="Summary" default="none">
<cfparam name="Keywords" default="none">
<cfparam name="siteURL" default="none">

<cfif ArticleAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="articles">
		<cfinvokeargument name="XMLFields" value="ArticleID,DateStarted,Title,ArticleContent,Author,LinkType,DateEnded,ArticleTypeID,ArticlePageName,Summary,Keywords,siteURL">
		<cfinvokeargument name="XMLIDField" value="ArticleID">
		<cfinvokeargument name="XMLIDValue" value="#ArticleID#">
	</cfinvoke>
	<cfquery name="GetThisArticleType" dbtype="query">
		select * from AllArticleTypes where Typeid='#ArticleTypeID#'
	</cfquery>
	<cfset NewCount=#GetThisArticleType.NoOfArticleTypes# - 1>
	<cfif NewCount gte 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ArticleTypes">
			<cfinvokeargument name="XMLFields" value="Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingtype">
		<cfinvokeargument name="XMLFieldData" value="#GetThisArticleType.Description# ,#GetThisArticleType.password#,#GetThisArticleType.username#,#GetThisArticleType.TypePageName#,#NewCount#,#GetThisArticleType.Summary# ,#GetThisArticleType.filename#,#getThisArticleType.listingtype# ">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#ArticleTypeID#">
		</cfinvoke>
	</cfif>
	<cfset ArticleID=0>
	<cfset ArticleAction="List">
	<cfset ARticleTypeiD=0>
</cfif>
		
<cfif ArticleID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="articles">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="articles">
		<cfinvokeargument name="IDFieldName" value="ArticleID">
		<cfinvokeargument name="IDFieldValue" value="#ArticleID#">
	</cfinvoke>
	<cfoutput query="articles">
		<cfset Title=#replace(Title,"~",",","ALL")#>
		<cfset DateStarted=#DateStarted#>
		<cfset ArticleContent=#replace(ArticleContent,"~",",","ALL")#>
		<cfset Author=#replace(Author,"~",",","ALL")#>
		<cfset ArticlePageName=#ArticlePageName#>
		<cfset LinkType=#LinkType#>
		<cfset ArticleTypeID=#replace(ArticleTypeID,"~",",","ALL")#>
		<cfset DateEnded=#DateEnded#>
		<cfset Summary=#replace(Summary,"~",",","ALL")#>
		<cfset Keywords=#replace(Keywords,"~",",","ALL")#>
		<cfset siteURL=#replace(siteURL,"~",",","ALL")#>
	</cfoutput>
	<cfset ArticleAction="update">
</cfif>

<cfif isDefined('form.submit')>
		<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Articles\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="2000"
			nameofimages="image"
			nameConflict="overwrite"
			accept="application/*,audio/mp3"
			default="na">
		<cfset Form.siteURL="images/ARticles/#image#">
	</cfif>
	<cfset form.ArticleContent=#replace(form.ArticleContent,",","~","ALL")#>
	<cfset form.ArticleTypeID=#replace(form.ArticleTypeID,",","~","ALL")#>
	<cfset form.Author=#replace(form.Author,",","~","ALL")#>
	<cfset form.Summary=#replace(form.Summary,",","~","ALL")#>
	<cfset form.Keywords=#replace(form.Keywords,",","~","ALL")#>
	<cfset form.siteURL=#replace(form.siteURL,",","~","ALL")#>
	<cfset form.Title=#replace(form.Title,",","~","ALL")#>
	<cfif ArticleID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="XMLFields" value="DateStarted,Title,ArticleContent,Author,LinkType,DateEnded,ArticleTypeID,ArticlePageName,Summary,Keywords,siteURL">
		<cfinvokeargument name="XMLFieldData" value="#dateformat(form.DateStarted,'yyyy/mm/dd')#,#form.Title#,#form.ArticleContent# ,#form.Author# ,#form.LinkType#,#dateformat(form.DateEnded,'yyyy/mm/dd')#,#form.ArticleTypeID#,#form.ArticlePageName#,#form.Summary# ,#form.Keywords# ,#form.siteURL# ">
			<cfinvokeargument name="XMLIDField" value="ArticleID">
			<cfinvokeargument name="XMLIDValue" value="#ArticleID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="XMLFields" value="DateStarted,Title,ArticleContent,Author,LinkType,DateEnded,ArticleTypeID,ArticlePageName,Summary,Keywords,siteURL">
		<cfinvokeargument name="XMLFieldData" value="#form.DateStarted#,#form.Title#,#form.ArticleContent# ,#form.Author# ,#form.LinkType#,#form.DateEnded#,#form.ArticleTypeID#,#form.ArticlePageName# ,#form.Summary# ,#form.Keywords# ,#form.siteURL# ">
			<cfinvokeargument name="XMLIDField" value="ArticleID">
		</cfinvoke>
		
		<cfquery name="GetThisArticleType" dbtype="query">
			select * from AllArticleTypes where Typeid='#form.ArticleTypeID#'
		</cfquery>
		<cfif not isnumeric(#GetThisArticleType.NoOfArticleTypes#)>
			<cfset NoOfArticleTypes=0>
		<cfelse>
			<cfset NoOfArticleTypes=#GetThisArticleType.NoOfArticleTypes#>
		</cfif>
		<cfset NewCount=#NoOfArticleTypes# + 1>
		<cfif not isnumeric(NewCount)><cfset NewCount=0></cfif>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ArticleTypes">
			<cfinvokeargument name="XMLFields" value="Description,password,username,TypePageName,NoOfArticleTypes,Summary,filename,listingType">
		<cfinvokeargument name="XMLFieldData" value="#GetThisArticleType.Description#,#GetThisArticleType.password#,#GetThisArticleType.username#,#GetThisArticleType.TypePageName#,#NewCount#,#GetThisArticleType.Summary#,#GetThisArticleType.filename#,1">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#form.ArticleTypeID#">
		</cfinvoke>
	</cfif>
	<cfset ArticleAction="list">
	<cfset Title="none">
	<cfset DateStarted = #now()#>
	<cfset ArticleID = 0>
	<cfset ArticleContent='none'>
	<cfset Title='none'>
	<cfset Author='none'>
	<cfset ArticlePageName='homepage'>
	<cfset LinkType=3>
	<cfset ArticleTypeID = 0>
	<cfset DateEnded = #now()#>
	<cfset Summary='none'>
	<cfset Keywords='none'>
	<cfset siteURL='none'>
</cfif>

<cfoutput>
<h1>articles</h1>

<cfif ArticleAction is "Add" or ArticleAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="ArticleID" value="#ArticleID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ArticleAction" value="#ArticleAction#">
<input type="Hidden" name="DateStarted" value="#DateStarted#">
<input type="hidden" name="ArticlePageName" value="#ArticlePageName#">
<TABLE>
		
		
	<TR>
	<TD valign="top"> Date To Archive: </TD>
    <TD>
	
		<INPUT type="text" name="DateEnded" value="#dateformat(DateEnded,'mm/dd/yyyy')#" maxLength="16">
		(i.e. 12/31/1997)
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="DateEnded_date">
	</TR>
	
	<TR>
	<TD valign="top"> Title: </TD>
    <TD>
	
		<cfINPUT name="Title" type="text" value="#Title#" maxLength="255" required="yes" message="Please enter a Title">
		
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Author: </TD>
    <TD>
	
		<INPUT type="text" name="Author" value="#Author#" maxLength="255">
		
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> No. of Views: </TD>
    <TD>
	#ArticlePageName#
		
	</TD>
	</TR>

	<TR>
	<TD valign="top"> Article Category: </TD>
    <TD>
		<select name="ArticleTypeID" size="20" multiple>
			<cfloop query="AllArticleTypes">
				<option value="#TypeID#" <cfif #listfind(articleTypeID,TypeID)#>selected</cfif>>#Description#</option>
			</cfloop>
		</select>
		
	</TD>
	</TR>
	<TR>
	<TD valign="top">Type of document added: </TD>
    <TD>
	<Cfif #LinkType# is 1>
	<input type="radio" name="LinkType" value="1" checked>Uploaded Document <br>
	<cfelse>
	<input type="radio" name="LinkType" value="1">Uploaded Document <br>
	</cfif>
	<Cfif #LinkType# is 2>
	<input type="radio" name="LinkType" value="2" checked>Web Site Link <br>
	<cfelse>
	<input type="radio" name="LinkType" value="2" checked>Web Site Link <br>
	</cfif>
	<Cfif #LinkType# is 3>
	<input type="radio" name="LinkType" value="3" checked>Manually Entered 
	<cfelse>
	<input type="radio" name="LinkType" value="3" checked>Manually Entered 
	</cfif>
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<td colspan="2" valign="TOP"> Keywords to use in searching:<br>Please separate keywords with comma's and type nothing else but alpha-numeric characters </TD>
	</TD>
	<tr>
    <TD colspan="2">
		<TEXTAREA name="Keywords" cols=45 rows=5>#Keywords#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<td colspan="2" valign="TOP"> Summary of this article</TD>
	</TD>
	<tr>
    <TD colspan="2">
		<a href="javascript:GetEditor('thisform','Summary')" class=box>Click here to open the editor</a><br>
		<TEXTAREA name="Summary" cols=45 rows=5>#Summary#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<td colspan="2" valign="TOP"> If content is a PDF, DOC, XLS, etc:, Upload the file<br></TD>
	</TD>
	<tr>
    <TD colspan="2">
		<input type="file" name="image">
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top" colspan=2> <b>OR</b> If this article is a link to another web site, type the URL here: <br>	
		<input type="text" name="siteURL" value="#siteURL#" maxlength="255" size="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<td colspan="2" valign="TOP"><b>OR</b> type in Article Content:</TD>
	</TD>
	<tr>
    <TD colspan="2">
		<a href="javascript:GetEditor('thisform','ArticleContent')" class=box>Click here to open the editor</a><br>
		<textarea cols=50 rows=10 name="ArticleContent">#ArticleContent#</textarea>

	
	</TD>
	<!--- field validation --->
	</TR>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cfFORM>
</cfif>
</CFOUTPUT>

<cfif ArticleAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&ArticleAction=Add">Add A New Article</a></cfoutput>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="articles">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Allarticles">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="orderbystatement" value="order by articleID desc">
			<cfif isdefined('form.searchcat')>
				<cfinvokeargument name="selectstatement" value=" where ArticleTypeID like '%#form.searchcat#%'">
			</cfif>
		</cfinvoke>
	<form><textarea cols=150 rows=5>This is where you enter articles to be displayed in your interactive ad. Before anyone can see the articles that you'd like them to read in your web site, they must first be loaded in here. 

Below is a list of articles already added by you. You can change the information on file about an article by clicking the "Edit" link to the far right of the article. 

If you no longer want a particular article on your web site, click the "Delete" link to the right of the article and it is removed immediately. Be careful! If you delete an article accidentally, the only way to get it back is to add it again.

Be sure to give your article a title. The Article Summary is a short synopsis of the article that describes the full article.

TIP: You may copy and paste an article in the box, but products like Microsoft Word also embed lots of formatting and display features that might make your article look funny. We suggest that you do the following if you intend to copy an article written with a product like Microsoft Word: 

Highlight and copy the article text 
Click the Start button and click Run 
Type Notepad in the box and click OK 
When Notepad comes up, click Edit and then click Paste 
Your article now displays in Notepad. Click Edit and then click Select All. The article highlights. 
Click Edit and then click Copy 
Close Notepad now. It's no longer needed. 
Now click inside the Article Content box and click Edit and then click Paste. The article should now be there. Add paragraph spacing by clicking where you'd like a new line to begin and press Enter. 

Selecting the Editor link over the Article Content box will allow you to format your article with bold, italics, underlining, headings, etc.</textarea></form>
<cfoutput><form name="searchform" action="adminheader.cfm?action=#action#" method="post">
	<p>Search by Article Category <select name="searchcat">
		<cfloop query="allArticleTypes">
			<option value="#TypeID#">#Description#</option>
		</cfloop>
	</select> <input type="submit" name="searchsubmit" value="GO"></p>
	</form></cfoutput><br>
	<table border="1" align="CENTER">
	<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your articles</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>Category</p></td>
	<td><p>Views</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="Allarticles">
	<tr>
	<td><p>#ArticleID#</p></td>
	<td><p>#Title#</p></td>
	<td><p>#replace(articleTypeID,"~",",","ALL")#</p></td>
	<td><p><cfif isnumeric(#articlepagename#)>#ArticlePageName#<cfelse>0</cfif></p></td>
	
	<td><a href= "adminheader.cfm?ArticleID=#ArticleID#&ArticleAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?ArticleID=#ArticleID#&ArticleAction=Delete&action=#action#&ArticleTypeID=#ArticleTypeID#')">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

