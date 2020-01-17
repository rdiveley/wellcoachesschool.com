<cfparam name="ElementID" default=0>
<cfparam name="font_size" default=0>
<cfparam name="StyleAction" default="List">
<cfparam name="font_weight" default="">
<cfparam name="color" default="black">
<cfparam name="datecreated" default="#dateformat(now())#">
<cfparam name="ssElement" default="0">
<cfparam name="font_family" default="">
<cfparam name="font_style" default="">
<cfparam name="text_align" default="">
<cfparam name="text_decoration" default="">
<cfparam name="text_decoration2" default="">
<cfparam name="StyleSheetName" default="">
<cfparam name="SheetID" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="allstylesheets">
	<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
	<cfinvokeargument name="ThisFileName" value="stylesheets">
</cfinvoke>
	
<cfif StyleAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="#StylesheetName#">
		<cfinvokeargument name="XMLFields" value="ElementID,font_weight,ssElement,datecreated,font_size,color,font_family,text_align,text_decoration,font_style">
		<cfinvokeargument name="XMLIDField" value="ElementID">
		<cfinvokeargument name="XMLIDValue" value="#ElementID#">
	</cfinvoke>
	<cfset ElementID=0>
	<cfset StyleAction="List">
</cfif>
		
<cfif ElementID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="StyleElements">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="#StylesheetName#">
		<cfinvokeargument name="IDFieldName" value="ElementID">
		<cfinvokeargument name="IDFieldValue" value="#ElementID#">
	</cfinvoke>
	<cfoutput query="StyleElements">
		<cfset font_weight=#font_weight#>
		<cfset datecreated=#datecreated#>
		<cfset color=#color#>
		<cfset font_size=#font_size#>
		<cfset ssElement=#ssElement#>
		<cfset font_family=#font_family#>
		<cfset text_align=#text_align#>
		<cfset text_decoration=#text_decoration#>
		<cfset font_style=#font_style#>
	</cfoutput>
	<cfset StyleAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset TheFields="font_weight,ssElement,datecreated,font_size,color,font_family,text_align,text_decoration,font_style">
	<cfif not isdefined('form.datecreted')><cfset Form.DateCreated=dateformat(now())></cfif>
	<cfif form.color is ''><cfset form.color="black"></cfif>
	<cfset TheFieldData="#form.font_weight#,#Form.ssElement#,#dateformat(form.datecreated)#,#form.font_size#,#form.color#,#form.font_family#,#Form.text_align#,#Form.text_decoration#,#Form.font_style#">
	<cfif ElementID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="#StylesheetName#">
			<cfinvokeargument name="XMLFields" value="#TheFields#">
			<cfinvokeargument name="XMLFieldData" value="#TheFieldData#">
			<cfinvokeargument name="XMLIDField" value="ElementID">
			<cfinvokeargument name="XMLIDValue" value="#ElementID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
			method="InsertXMLRecord" returnvariable="NewElementID">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="#StylesheetName#">
			<cfinvokeargument name="XMLFields" value="#TheFields#">
			<cfinvokeargument name="XMLFieldData" value="#TheFieldData#">
			<cfinvokeargument name="XMLIDField" value="ElementID">
		</cfinvoke>
	</cfif>
	
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="TheElements">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="#StyleSheetName#">
	</cfinvoke>
	<cfset csstext=''>
	<cfoutput query="TheElements">
		<cfset csstext="#csstext##sselement# {font-family: #font_family#; font-size: #font_size#;">
		<cfset csstext="#csstext# font-weight: #font_weight#; color: #color#;">
		<cfset csstext="#csstext# text-decoration: #text_decoration#; font-style: #font_style#;">
		<cfset csstext="#csstext# text-lign: #text_align#;}">
	</cfoutput>
	<cffile action="write" 
		file="#application.uploadpath#\files\#sheetID#.css" 
		output="#csstext#">

	<cfquery name="Stylesheets" dbtype="query">
		select * from allstylesheets where filename='#sheetid#'
	</cfquery>
	<cfif #stylesheets.recordcount# gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfinvokeargument name="XMLFields" value="Filename,Content">
			<cfinvokeargument name="XMLFieldData" value="#form.SheetID#,#csstext#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
			<cfinvokeargument name="XMLIDValue" value="#stylesheets.styleID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="stylesheets">
			<cfinvokeargument name="XMLFields" value="Filename,Content">
			<cfinvokeargument name="XMLFieldData" value="#form.SheetID#,#csstext#">
			<cfinvokeargument name="XMLIDField" value="StyleID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=#action#&StyleSheetName=#StyleSheetName#&SheetID=#SheetID#">
</cfif>

<cfoutput><h2>Style Sheet Elements for #sheetid#:</h2></cfoutput>

<cfif StyleAction is "Add" or StyleAction is "Update">
<cfoutput>
<p>Following is a list of common page elements that you can control via a style sheet.  Please select the element you wish to set parameters for.<br>
<form name="stylesheetform" action="adminheader.cfm?action=#action#" method="post">
<input type="hidden" name="StyleAction" value=="#styleAction#">
<input type="hidden" name="action" value="#action#">
<input type="hidden" name="StyleSheetName" value="#StyleSheetName#">
<input type="hidden" name="SheetID" value="#SheetID#">
<input type="hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="ElementID" value="#ElementID#">
	<table><tr><td>Select the page element:</td><td><select name="ssElement">
		<option value="p"<cfif #ssElement# is "p"> selected</cfif>>Paragraph</option>
		<option value="td"<cfif #ssElement# is "td"> selected</cfif>>Text inside any table</option>
		<option value="h1"<cfif #ssElement# is "h1"> selected</cfif>>Header Size 1</option>
		<option value="h2"<cfif #ssElement# is "h2"> selected</cfif>>Header Size 2</option>
		<option value="h3"<cfif #ssElement# is "h3"> selected</cfif>>Header Size 3</option>
		<option value="h4"<cfif #ssElement# is "h4"> selected</cfif>>Header Size 4</option>
		<option value="h5"<cfif #ssElement# is "h5"> selected</cfif>>Header Size 5</option>
		<option value="h6"<cfif #ssElement# is "h6"> selected</cfif>>Header Size 6</option>
		<option value="li"<cfif #ssElement# is "li"> selected</cfif>>Bulleted List</option>
		<option value="a"<cfif #ssElement# is "a"> selected</cfif>>Any text link</option>
		<option value="a:active"<cfif #ssElement# is "a:active"> selected</cfif>>Any active text link</option>
		<option value="a:hover"<cfif #ssElement# is "a:hover"> selected</cfif>>Hover over any text link</option>
		<option value="a:visited"<cfif #ssElement# is "visited"> selected</cfif>>Already visited text link</option>
	</select></td></tr>
	<tr><td>Select the font:</td><td>
	<select name="font_family">
		<option value="serif"<cfif #font_family# is "serif"> selected</cfif>>Serif</option>
		<option value="sans-serif"<cfif #font_family# is "sans-serif"> selected</cfif>>Sans Serif</option>
		<option value="cursive"<cfif #font_family# is "cursive"> selected</cfif>>Cursive</option>
		<option value="fantasy"<cfif #font_family# is "fantasy"> selected</cfif>>Fantasy</option>
		<option value="monospace"<cfif #font_family# is "monospace"> selected</cfif>>Monospace</option>
		<option value="arial"<cfif #font_family# is "arial"> selected</cfif>>Arial</option>
		<option value="verdana"<cfif #font_family# is "verdana"> selected</cfif>>Verdana</option>
		<option value="Times New Roman"<cfif #font_family# is "Times New Roman"> selected</cfif>>Times New Roman</option>
		<option value="Courier New"<cfif #font_family# is "Courier New"> selected</cfif>>Courier New</option>
	</select></td></tr>
	<tr><td>Select the font size:</td><td>
	<select name="font_size">
		<option value="10 pt">10 Most easily read
		</option><option value="1 pt">1 Very Fine Print</option>
		<option value="2 pt"<cfif #font_size# is "2 pt"> selected</cfif>>2</option>
		<option value="3 pt"<cfif #font_size# is "3 pt"> selected</cfif>>3</option>
		<option value="4 pt"<cfif #font_size# is "4 pt"> selected</cfif>>4</option>
		<option value="5 pt"<cfif #font_size# is "5 pt"> selected</cfif>>5</option>
		<option value="6 pt"<cfif #font_size# is "6 pt"> selected</cfif>>6</option>
		<option value="7 pt"<cfif #font_size# is "7 pt"> selected</cfif>>7</option>
		<option value="8 pt"<cfif #font_size# is "8 pt"> selected</cfif>>8</option>
		<option value="9 pt"<cfif #font_size# is "9 pt"> selected</cfif>>9</option>
		<option value="11 pt"<cfif #font_size# is "11 pt"> selected</cfif>>11</option>
		<option value="12 pt"<cfif #font_size# is "12 pt"> selected</cfif>>12</option>
		<option value="13 pt"<cfif #font_size# is "13 pt"> selected</cfif>>13</option>
		<option value="14 pt"<cfif #font_size# is "14 pt"> selected</cfif>>14</option>
		<option value="15 pt"<cfif #font_size# is "15 pt"> selected</cfif>>15</option>
		<option value="16 pt"<cfif #font_size# is "16 pt"> selected</cfif>>16</option>
		<option value="17 pt"<cfif #font_size# is "17 pt"> selected</cfif>>17</option>
		<option value="18 pt"<cfif #font_size# is "18 pt"> selected</cfif>>18 Very Large</option>
	</select></td></tr>
	<tr><td>Select the font color:</td><td><input name="color" maxlength="10" size="10" value="#color#"> 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('stylesheetform','color')"></td></tr>
	<tr><td>Select the font weight: </td><td>
	<select name="font_weight">
		<option value="normal"<cfif #font_weight# is "normal"> selected</cfif>>Normal</option>
		<option value="bold"<cfif #font_weight# is "bold"> selected</cfif>>Bold</option>
		<option value="bolder"<cfif #font_weight# is "bolder"> selected</cfif>>Bolder</option>
		<option value="lighter"<cfif #font_weight# is "lighter"> selected</cfif>>Lighter</option>
	</select></td></tr>
	<tr><td>Select the font style: </td><td>
	<select name="font_style">
		<option value="normal"<cfif #font_style# is "normal"> selected</cfif>>normal</option>
		<option value="italic"<cfif #font_style# is "italic"> selected</cfif>>italic</option>
		<option value="oblique"<cfif #font_style# is "oblique"> selected</cfif>>oblique</option>
	</select></td></tr>
	<tr><td>Select the text alignment: </td><td>
	<select name="text_align">
		<option value="left"<cfif #text_align# is "left"> selected</cfif>>left</option>
		<option value="right"<cfif #text_align# is "right"> selected</cfif>>right</option>
		<option value="center"<cfif #text_align# is "center"> selected</cfif>>center</option>
		<option value="justify"<cfif #text_align# is "justify"> selected</cfif>>justified</option>
	</select></td></tr>
	<tr><td>Select the text decoration: </td><td>
	<select name="text_decoration">
		<option value="none"<cfif #text_decoration# is "none"> selected</cfif>>none</option>
		<option value="underline"<cfif #text_decoration# is "underline"> selected</cfif>>underline</option>
		<option value="overline"<cfif #text_decoration# is "overline"> selected</cfif>>overline</option>
		<option value="line-through"<cfif #text_decoration# is "line-through"> selected</cfif>>line through</option>
	</select></td></tr>
	<tr><td></td><td><input type="submit" name="submit" value="Save this setting"></td></tr>
	</table>
</form></p>
</cfoutput>
</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="#StyleSheetName#">
		<cfinvokeargument name="ThisPath" value="pages">
</cfinvoke>

<cfif StyleAction is "list">

	<cfoutput><a href="adminheader.cfm?Action=#Action#&StyleAction=Add&StyleSheetName=#StyleSheetName#&SheetID=#SheetID#">Add A Style Element</a></cfoutput><br>
	<cfif #TheFileExists#>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllElements">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="#StyleSheetName#">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="10" align="CENTER" bgcolor="Maroon"><p>Style Elements for <cfoutput>#SheetID#</cfoutput></p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Element</p></td>
		<td><p>Font Family</p></td>
		<td><p>Size</p></td>
		<td><p>Color</p></td>
		<td><p>Weight</p></td>
		<td><p>Style</p></td>
		<td><p>Alignment</p></td>
		<td><p>Decoration</p></td>
		<td><p>Actions</p></td>
		</tr>
		<cfoutput query="AllElements">
		<tr>
		<td><p>#int(ElementID)#</p></td>
		<td><p>
		<cfswitch expression="#ssElement#">
		<cfcase value="p">Paragraph</cfcase>
		<cfcase value="td">Text inside any table</cfcase>
		<cfcase value="h1">Header Size 1</cfcase>
		<cfcase value="h2">Header Size 2</cfcase>
		<cfcase value="h3">Header Size 3</cfcase>
		<cfcase value="h4">Header Size 4</cfcase>
		<cfcase value="h5">Header Size 5</cfcase>
		<cfcase value="h6">Header Size 6</cfcase>
		<cfcase value="li">Bulleted List</cfcase>
		<cfcase value="a">Any text link</cfcase>
		<cfcase value="a:active">Any active text link</cfcase>
		<cfcase value="a:hover">Hover over any text link</cfcase>
		<cfcase value="a:visited">Already visited text link</cfcase>
		</cfswitch></p></td>
		<td><p>#font_family#</p></td>
		<td><p>#font_size#</p></td>
		<td><p>#color#</p></td>
		<td><p>#font_weight#</p></td>
		<td><p>#font_style#</p></td>
		<td><p>#text_align#</p></td>
		<td><p>#text_decoration#</p></td>
		<td><a href= "adminheader.cfm?ElementID=#ElementID#&StyleAction=Edit&action=#action#&StyleSheetName=#StyleSheetName#&SheetID=#SheetID#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?ElementID=#ElementID#&StyleAction=Delete&action=#action#&StyleSheetName=#StyleSheetName#&SheetID=#SheetID#')">Delete</a>
		</tr>
		</cfoutput>
		</table>
	</cfif>
</cfif>