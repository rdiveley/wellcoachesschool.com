<cfparam name="PageID" default=0>
<cfparam name="EditAction" default="list">
<cfset Details="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="IDFieldName" value="pageid">
	<cfinvokeargument name="IDFieldValue" value="#pageid#">
</cfinvoke>
<cfset PageName=#AllPages.PageName#>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Alltemplates">
	<cfinvokeargument name="ThisPath" value="Templates">
	<cfinvokeargument name="ThisFileName" value="templates">
	<cfinvokeargument name="IDFieldName" value="TemplateID">
	<cfinvokeargument name="IDFieldValue" value="#AllPages.TemplateID#">
</cfinvoke>
<cfset TemplateName=#AllTemplates.filename#>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllDetails">
	<cfinvokeargument name="ThisPath" value="Templates">
	<cfinvokeargument name="ThisFileName" value="#templateName#">
	<cfinvokeargument name="orderbystatement" value=" order by positionid">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="ThePageExists">
	<cfinvokeargument name="FileName" value="#Pagename#">
	<cfinvokeargument name="ThisPath" value="pages">
</cfinvoke>	

<cfif #ThePageExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Thispage">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="#Pagename#">
	</cfinvoke>
<cfelse>
	<cfset newRecords=QueryNew("DetailID,PositionID,Content,DisplayTypeID")>
	<cfoutput query="AllDetails">
		<cfif #int(DisplayTypeID)# neq 1 and #int(DisplayTypeID)# neq 15 and #int(DisplayTypeID)# neq 11>
			<CFSET newRow  = QueryAddRow(newRecords, 1)>
			<CFSET temp = QuerySetCell(newrecords, "DetailID","#newRow#", #newRow#)>
			<CFSET temp = QuerySetCell(newrecords, "PositionID","#PositionID#", #newRow#)>
			<CFSET temp = QuerySetCell(newrecords, "Content","#Content#", #newRow#)>
			<CFSET temp = QuerySetCell(newrecords, "DisplayTypeID","#int(DisplayTypeID)#", #newRow#)>
		</cfif>
	</cfoutput>
	<cfwddx action="cfml2wddx"
		input="#newrecords#"
		output="xRecords">
	<cffile action="WRITE" file="#application.uploadpath#\Pages\#PageName#.xml" output="#xRecords#" addnewline="No">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Thispage">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="#Pagename#">
	</cfinvoke>
</cfif>

<cfif #AllPages.StyleSheetID# gt 0>
	<cfset StyleSheetID=#int(AllPages.StyleSheetID)#>
	<cfset tLen=Len(StyleSheetID)>
	<cfloop index="XX" from="#tLen#" to="9">
		<cfset StyleSheetID="0#StyleSheetID#">
	</cfloop>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="stylesheets">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="stylesheets">
		<cfinvokeargument name="IDFieldName" value="StyleID">
		<cfinvokeargument name="IDFieldValue" value="#StyleSheetID#">
	</cfinvoke>
	<cfset details="#Details#<link rel=""stylesheet"" href=""../files/#stylesheets.filename#.css"">">
</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGraphics">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Allnavigation">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="navigation">
</cfinvoke>

<cfoutput query="AllDetails">
	
<!--- Table Structure --->
<cfif #int(DisplayTypeID)# is 1>
	<cfset Content2=replacenocase(#content#,"images/","../","ALL")>
	<cfset Details=#Details# & #replace(Content2,"~",",","ALL")#>
</cfif>

<!--- Table Background Color  --->
<cfif #int(DisplayTypeID)# is 2>
<!--- 	<cfset BGColor=#Content#>
  	<cfinclude template="GetBGColor.cfm"> --->
	<cfset Details=#Details# & "Select Table Background color:<br><input type='text' name='D#PositionID#'"> 
	<cfif #Action# is "Edit">
		<cfset Details=#Details# & "value='" & #Content# & "'">
	</cfif>
		<cfset Details=#Details# & "><input type=button name=bgcolorbutt value='...' onclick=selectcolor('thisform','D#PositionID#')><br>">

</cfif>

<!--- Table Background Image  --->
<cfif #int(DisplayTypeID)# is 3>
	<cfset Details = #Details# & "Select Table Background Graphic:<br> <select name='D#PositionID#'>">
	<cfif #Action# is "Edit">
		<cfset MatchID = #Content#>
	</cfif>
	<cfinclude template="GetGraphic.cfm">
	<cfset Details = #Details# & "</select><br>">
	
</cfif>

<!--- Table Cell Background Color  --->
<cfif #int(DisplayTypeID)# is 4>
	<cfset Details=#Details# & "Select Cell Background color:<br><input type='text' name='D#PositionID#'"> 
	<cfif #Action# is "Edit">
		<cfset Details=#Details# & "value='" & #Content# & "'">
	</cfif>
		<cfset Details=#Details# & "><input type=button name=bgcolorbutt value='...' onclick=selectcolor('thisform','D#PositionID#')><br>">

</cfif>

<!--- Table Cell Background Image  --->
<cfif #int(DisplayTypeID)# is 5>
	<cfset Details = #Details# & "Select cell Background Graphic:<br> <select name='D#PositionID#'><option value='0'>None</option>">
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#trim(PositionID)#'
	</cfquery>
	<cfset MatchID = #trim(GetThisGraphic.Content)#>
	<cfinclude template="GetGraphic.cfm">
	<cfset Details = #Details# & "</select><br>">

</cfif>

<!--- Image --->
<cfif #int(DisplayTypeID)# is 6>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
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
	<cfset ThisContent = "<img src=../#getGraphic.Filename#><br><a href=""javascript:changeGraphic('D#PositionID#')"" class=box>Click Here to change this Graphic</a>">
	<cfset Details=#Details# & #ThisContent#>
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#getGraphic.GraphicsID#"" onChange=""this.form.submit();"">">
</cfif>

<!--- Logo Image --->
<cfif #int(DisplayTypeID)# is 13>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
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
	<cfset Details = #Details# & "<img src=../#getGraphic.Filename#><br><a href=""javascript:changeLogo('D#PositionID#')"" class=box>Click Here to change the logo</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#getGraphic.GraphicsID#"">">
</cfif>

<!--- Banner Image --->
<cfif #int(DisplayTypeID)# is 14>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset tContent=#Content#>
	<cfif #GetThisGraphic.RecordCount# gt 0>
		<cfset tContent=#GetThisGraphic.content#>
	</cfif>
	
	<cfquery name="GetGraphic" dbtype="query">
		select GraphicsID,filename from AllGraphics 
		<cfif isnumeric(#tContent#)>
		Where GraphicsID='#tcontent#'
		<cfelse>
		where GraphicsTypeID='10' or GraphicsTypeID='11' or GraphicsTypeID='12'
		</cfif>
	</cfquery>
	<cfset Details = #Details# & "<img src=../#getGraphic.Filename#><br><a href=""javascript:changeGraphic('D#PositionID#')"" class=box>Click Here to change this Graphic</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#getGraphic.GraphicsID#"">">
</cfif>

<!--- Product Listing Script --->
<cfif #int(DisplayTypeID)# is 15>
	<cfset Details = #Details# & "Product Listing goes here.">
</cfif>

<!--- Text --->
<cfif #int(DisplayTypeID)# is 7>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset tContent7="The content of the Web Site goes here.">
	<cfif #GetThisGraphic.RecordCount# gt 0>
		<cfset tContent7=#GetThisGraphic.content#>
	</cfif>
	<cfset tContent7=replacenocase(#tContent7#,"~",",","ALL")>
	<!--- <cfset tPos=findnocase("ScriptIs",#tContent7#)>
	<cfif tPos gt 0>
		<cfset tLen = len(trim(#tContent7#))>
		<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
		<cfif #tpos# is 2>
			<cfset FirstHalf=''>
			<cfset FirstScript=left(#tContent7#,#lPos#)>
			<cfif lpos neq tlen>
				<cfset LastHalf=mid(#tContent7#,#lPos#,#tLen#)>
			<cfelse>
				<cfset LastHalf=''>
			</cfif>
		<cfelse>
			<cfset scriptLen=lPos - tPos + 2>
			<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
			<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
			<cfset LastHalf=mid(#tContent7#,#lPos#,#tLen#)>
		</cfif>
	</cfif> --->


	<cfset Details = #Details# & "#tContent7#<br><a href=""javascript:GetEditor('thisform','D#PositionID#')"" class=box>Click here to change the text</a>">
	<cfset tContent7=htmleditformat(#TContent7#)>
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent7#"">">
</cfif>

<!--- One Navigation Link --->
<cfif #int(DisplayTypeID)# is 8>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset content=replacenocase(#content#,"~",",","ALL")>
	<cfset tContent=#trim(content)#>
	<cfif #GetThisGraphic.RecordCount# gt 0>
		<cfif isnumeric(left(#GetThisGraphic.content#,1))>
			<cfset tContent=#GetThisGraphic.content#>
			<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
			<cfset tContent=#trim(tcontent)#>
		</cfif>
	</cfif>
	<cfif isnumeric(left(#tcontent#,1))>
		<cfloop query="allnavigation">
			<cfif listFind(#tContent#,#NavID#)>
				<cfif NavTypeID is 1>
					<cfset Details=#Details# & "<img src=""../#filename#"">">
				<cfelse>
					<cfset Details=#Details# & "#LinkText# | ">
				</cfif>
			</cfif>
		</cfloop>
	<cfelse>
		<cfset tContent=''>
		<cfset tCounter=1>
		<cfloop query="AllNavigation" startrow="1" endrow="1">
			<cfif tCounter is 1><cfset tContent="#trim(NavID)#"><cfset tCounter=2>
			<cfelse><cfset tContent="#trim(tContent)#,#trim(NavID)#"></cfif>
			<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#"">">
			<cfelse>
				<cfset Details=#Details# & "#LinkText# | ">
			</cfif>
		</cfloop>
	</cfif>
	<cfset Details=#Details# & "<br><a href=""javascript:changeNav('D#PositionID#','#tContent#')"" class=box>Click here to change navigation</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
</cfif>

<!--- Navigation Drop Down List --->
<cfif #int(DisplayTypeID)# is 17>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset content=replacenocase(#content#,"~",",","ALL")>
	<cfset tContent=#trim(content)#>
	<cfif #GetThisGraphic.RecordCount# gt 0>
		<cfif isnumeric(left(#GetThisGraphic.content#,1))>
			<cfset tContent=#GetThisGraphic.content#>
			<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
		</cfif>
	</cfif>
	<cfif isnumeric(left(#tcontent#,1))>
		<cfloop query="allnavigation">
			<cfif listFind(#tContent#,#NavID#)>
				<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#""><br>">
				<cfelse>
				<cfset Details=#Details# & "#LinkText#<br>">
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
			<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#""><br>">
			<cfelse>
				<cfset Details=#Details# & "#LinkText#<br>">
			</cfif>
		</cfloop>
	</cfif>
	<cfset Details=#Details# & "<br><a href=""javascript:changeNav('D#PositionID#','#tContent#')"" class=box>Click here to change navigation</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
</cfif>

<!--- Navigation Link List--->
<cfif #int(DisplayTypeID)# is 9>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset content=replacenocase(#content#,"~",",","ALL")>
	<cfset tContent=#trim(content)#>
	<cfif #GetThisGraphic.RecordCount# gt 0>
		<cfif isnumeric(left(#GetThisGraphic.content#,1))>
			<cfset tContent=#trim(GetThisGraphic.content)#>
			<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
		</cfif>
	</cfif>
	<cfif isnumeric(left(#tcontent#,1))>
		<cfloop query="allnavigation">
			<cfif listFind(#tContent#,#NavID#)>
				<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#""><br>">
				<cfelse>
				<cfset Details=#Details# & "#LinkText#<br>">
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
			<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#""><br>">
			<cfelse>
				<cfset Details=#Details# & "#LinkText#<br>">
			</cfif>
		</cfloop>
	</cfif>
	<cfset Details=#Details# & "<br><a href=""javascript:changeNav('D#PositionID#','#tContent#')"" class=box>Click here to change navigation</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
</cfif>

<!--- Sideways Navigation Link List--->
<cfif #int(DisplayTypeID)# is 10>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
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
				<cfif NavTypeID is 1>
					<cfset Details=#Details# & "<img src=""../#filename#"">">
				<cfelse>
					<cfset Details=#Details# & "#LinkText# | ">
				</cfif>
			</cfif>
		</cfloop>
	<cfelse>
		<cfset tContent=''>
		<cfset tCounter=1>
		<cfloop query="AllNavigation">
			<cfif tCounter is 1><cfset tContent="#NavID#"><cfset tCounter=2>
			<cfelse><cfset tContent="#tContent#,#NavID#"></cfif>
			<cfif NavTypeID is 1>
				<cfset Details=#Details# & "<img src=""../#filename#"">">
			<cfelse>
				<cfset Details=#Details# & "#LinkText# | ">
			</cfif>
		</cfloop>
	</cfif>
	<cfset Details=#Details# & "<br><a href=""javascript:changeNav('D#PositionID#','#tContent#')"" class=box>Click here to change navigation</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
</cfif>

<!--- Javascript --->
<cfif #int(DisplayTypeID)# is 11>
	<cfset Details=#Details# & "<script language='JavaScript1.1'>" & #Content# & "</script>">
</cfif>

<!--- Flash--->
<cfif #int(DisplayTypeID)# is 18>
	<cfquery name="GetThisGraphic" dbtype="query">
		select * from ThisPage where PositionID='#PositionID#'
	</cfquery>
	<cfset content=replacenocase(#content#,"~",",","ALL")>
	<cfset tContent=#trim(content)#>
	<cfset displayContent=#allDetails.content#>
	<cfif lcase(displayContent) is "header" or lcase(displayContent) is "sidemenu">
		<cfif #GetThisGraphic.RecordCount# gt 0>
			<cfif isnumeric(left(#GetThisGraphic.content#,1))>
				<cfset tContent=#trim(GetThisGraphic.content)#>
				<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
			</cfif>
		</cfif>
		<cfif isnumeric(left(#tcontent#,1))>
			<cfloop query="allnavigation">
				<cfif listFind(#tContent#,#NavID#)>
					<cfif NavTypeID is 1>
					<cfset Details=#Details# & "<img src=""../#filename#""><br>">
					<cfelse>
					<cfset Details=#Details# & "#LinkText#<br>">
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
				<cfif NavTypeID is 1>
					<cfset Details=#Details# & "<img src=""../#filename#""><br>">
				<cfelse>
					<cfset Details=#Details# & "#LinkText#<br>">
				</cfif>
			</cfloop>
		</cfif>
		<cfset Details=#Details# & "<br><a href=""javascript:changeNav('D#PositionID#','#tContent#')"" class=box>Click here to change navigation</a>">
		<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
	</cfif>
	<cfif lcase(displayContent) is "pagetype">
		<cfset tContent=#trim(GetThisGraphic.content)#>
		<cfset tContent=replacenocase(#tContent#,"~",",","ALL")>
		<cfset Details=#Details# & "<br><strong>PageType=#tContent#</strong><br><a href=""javascript:changePageType('D#PositionID#','#tContent#')"" class=box>Click here to change the page type</a>">
	<cfset Details=#Details# & "<input type=""hidden"" name=""D#PositionID#"" value=""#tcontent#"">">
	</cfif>
	
</cfif>

</cfoutput>

<script language="JavaScript" src="../files/editor.js"></script>
<cfoutput>
<script>
function formsubmit(formname) {
	formname.submit();
}
</script>
<h2 style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; color: yellow;font-size: 16px; background-color : ##0000a0;">Edit page: #PageName#</h2>
<form method="post" action="savepage.cfm" name="thisform">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="PageID" value="#PageID#">
<p class=legal>The sizes and proportions of the sections for this page are not what the final page will look like.  <a href="adminheader.cfm?TemplateID=#AllPages.TemplateID#&Action=viewtemplate&TemplateName=#TemplateName#" target="MMM" class=nav>Click here</a> to view the original template.<br><a href="../index.cfm?page=#pagename#" target="MSM">Click here</a> to view this page live.</p>

<table bgcolor="##FFFFFF" width=100% cellpadding=0 cellspacing=0><tr><Td>
#Details#</Td></tr></table>
</cfoutput>

</form>
