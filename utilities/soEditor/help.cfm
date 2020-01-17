
<!--- Toolbar parameters --->
<!--- Standard toolbar --->
<cfparam name="URL.New" type="boolean" default="true">
<cfparam name="URL.Save" type="boolean" default="true">
<cfparam name="URL.Cut" type="boolean" default="true">
<cfparam name="URL.Copy" type="boolean" default="true">
<cfparam name="URL.Paste" type="boolean" default="true">
<cfparam name="URL.Delete" type="boolean" default="true">
<cfparam name="URL.Find" type="boolean" default="true">
<cfparam name="URL.Undo" type="boolean" default="true">
<cfparam name="URL.Redo" type="boolean" default="true">
<cfparam name="URL.HR" type="boolean" default="true">
<cfparam name="URL.Image" type="boolean" default="true">
<cfparam name="URL.Link" type="boolean" default="true">
<cfparam name="URL.Unlink" type="boolean" default="true">
<cfparam name="URL.SpellCheck" type="boolean" default="false">
<cfparam name="URL.Help" type="boolean" default="true">
<!--- Paragraph toolbar --->
<cfparam name="URL.Align" type="boolean" default="true">
<cfparam name="URL.List" type="boolean" default="true"> 
<cfparam name="URL.Unindent" type="boolean" default="true">
<cfparam name="URL.Indent" type="boolean" default="true">
<!--- Format toolbar --->
<cfparam name="URL.FontDialog" type="boolean" default="true">
<cfparam name="URL.Format" type="boolean" default="true">
<cfparam name="URL.Font" type="boolean" default="true">
<cfparam name="URL.Size" type="boolean" default="true">
<cfparam name="URL.Bold" type="boolean" default="true">
<cfparam name="URL.Italic" type="boolean" default="true">
<cfparam name="URL.Underline" type="boolean" default="true">
<cfparam name="URL.SuperScript" type="boolean" default="true">
<cfparam name="URL.SubScript" type="boolean" default="true">
<cfparam name="URL.FgColor" type="boolean" default="true">
<cfparam name="URL.BgColor" type="boolean" default="true">
<!--- Tables toolbar --->
<cfparam name="URL.Tables" type="boolean" default="true">  
<cfparam name="URL.InsertCell" type="boolean" default="true">  
<cfparam name="URL.DeleteCell" type="boolean" default="true">  
<cfparam name="URL.InsertRow" type="boolean" default="true">  
<cfparam name="URL.DeleteRow" type="boolean" default="true">  
<cfparam name="URL.InsertColumn" type="boolean" default="true">  
<cfparam name="URL.DeleteColumn" type="boolean" default="true">  
<cfparam name="URL.SplitCell" type="boolean" default="true">
<cfparam name="URL.MergeCell" type="boolean" default="true"> 
<cfparam name="URL.CellProp" type="boolean" default="true">
<!--- View toolbar --->
<cfparam name="URL.HTMLEdit" type="boolean" default="true">  
<cfparam name="URL.Borders" type="boolean" default="true">
<cfparam name="URL.Details" type="boolean" default="true"> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Editor: Help</title>
  <style>
    table {font: 8pt Tahoma;}
    body {background: #d4d0c8; margin:0px;}
  </style>
</head>

<body>

<table width="100%" border="0" cellspacing="1" cellpadding="3">
  <tr>
    <td>
    <table border="0" cellspacing="2" cellpadding="2">
      <!--- Standard toolbar --->
      <cfif URL.New><tr valign="top"><td><IMG height=15 alt="" src="icons/newdoc.gif" width=16 border=0></td><td>Clears all of the content out of the editor.</td></tr></cfif>
      <cfif URL.Save><tr valign="top"><td><IMG height=15 alt="" src="icons/save.gif" width=16 border=0></td><td>Saves the current content in the editor</td></tr></cfif>
      <cfif URL.Cut><tr valign="top"><td><IMG height=15 alt="" src="icons/cut.gif" width=16 border=0></td><td>Removes the selected content and places it into the clipboard.</td></tr></cfif>
      <cfif URL.Copy><tr valign="top"><td><IMG height=15 alt="" src="icons/copy.gif" width=16 border=0></td><td>Copies the selected content into the clipboard.</td></tr></cfif>
      <cfif URL.Paste><tr valign="top"><td><IMG height=15 alt="" src="icons/paste.gif" width=16 border=0></td><td>Inserts content from the clipboard into the editor at the selected position.</td></tr></cfif>
      <cfif URL.Delete><tr valign="top"><td><IMG height=15 alt="" src="icons/delete.gif" width=16 border=0></td><td>Deletes the selected content from the editor.</td></tr></cfif>
      <cfif URL.Find><tr valign="top"><td><IMG height=15 alt="" src="icons/find.gif" width=16 border=0></td><td>Allows all content in the editor to be searched.</td></tr></cfif>
      <cfif URL.Undo><tr valign="top"><td><IMG height=15 alt="" src="icons/undo.gif" width=16 border=0></td><td>Undoes the last operation in the editor.</td></tr></cfif>
      <cfif URL.Redo><tr valign="top"><td><IMG height=15 alt="" src="icons/redo.gif" width=16 border=0></td><td> Redoes the last operation in the editor.</td></tr></cfif>
      <cfif URL.HR><tr valign="top"><td><IMG height=15 alt="" src="icons/hr.gif" width=16 border=0></td><td>Inserts a horizontal rule at the selected position in the editor.</td></tr></cfif>
      <cfif URL.Image><tr valign="top"><td><IMG height=15 alt="" src="icons/image.gif" width=16 border=0></td><td>Opens the image window to allow an image to be inserted into the editor at the selected position.</td></tr></cfif>
      <cfif URL.Link><tr valign="top"><td><IMG height=15 alt="" src="icons/link.gif" width=16 border=0></td><td>Opens the hyperlink window to allow a hyperlink to be created using the selected content.</td></tr></cfif>
      <cfif URL.Unlink><tr valign="top"><td><IMG height=15 alt="" src="icons/unlink.gif" width=16 border=0></td><td>Clears the hyperlink from the selected content.</td></tr></cfif>
      <cfif URL.Help><tr valign="top"><td><IMG height=16 alt="" src="icons/help.gif" width=15 border=0></td><td>Opens the help window.</td></tr></cfif>
      <!--- Paragraph toolbar --->
      <cfif URL.Align><tr valign="top"><td><IMG height=15 alt="" src="icons/left.gif" width=16 border=0></td><td>Aligns the selected content to the left.</td></tr></cfif>
      <cfif URL.Align><tr valign="top"><td><IMG height=15 alt="" src="icons/center.gif" width=16 border=0></td><td>Centers the selected content.</td></tr></cfif>
      <cfif URL.Align><tr valign="top"><td><IMG height=15 alt="" src="icons/right.gif" width=16 border=0></td><td>Aligns the selected content to the right.</td></tr></cfif>
      <cfif URL.List><tr valign="top"><td><IMG height=15 alt="" src="icons/numlist.gif" width=16 border=0></td><td>Inserts an ordered list.</td></tr></cfif>
      <cfif URL.List><tr valign="top"><td><IMG height=15 alt="" src="icons/bullist.gif" width=16 border=0></td><td>Inserts an unordered list.</td></tr></cfif>
      <cfif URL.Unindent><tr valign="top"><td><IMG height=15 alt="" src="icons/deindent.gif" width=16 border=0></td><td>Unindents the selected content.</td></tr></cfif>
      <cfif URL.Indent><tr valign="top"><td><IMG height=15 alt="" src="icons/indent.gif" width=16 border=0></td><td>Indents the selected content.</td></tr></cfif>
      <!--- Format toolbar --->
      <cfif URL.FontDialog><tr valign="top"><td><IMG height=15 alt="" src="icons/font.gif" width=16 border=0></td><td>Opens the font properties window.</td></tr></cfif>
      <cfif URL.Bold><tr valign="top"><td><IMG height=15 alt="" src="icons/bold.gif" width=16 border=0></td><td>Bolds the selected text.</td></tr></cfif>
      <cfif URL.Italic><tr valign="top"><td><IMG height=15 alt="" src="icons/italic.gif" width=16 border=0></td><td>Italicizes the selected text.</td></tr></cfif>
      <cfif URL.Underline><tr valign="top"><td><IMG height=15 alt="" src="icons/under.gif" width=16 border=0></td><td>Underlines the selected text.</td></tr></cfif>
      <cfif URL.SuperScript><tr valign="top"><td><IMG height=15 alt="" src="icons/superscript.gif" width=16 border=0></td><td>Changes the selected text to superscript.</td></tr></cfif>
      <cfif URL.SubScript><tr valign="top"><td><IMG height=15 alt="" src="icons/subscript.gif" width=16 border=0></td><td>Changes the selected text to subscript.</td></tr></cfif>
      <cfif URL.FgColor><tr valign="top"><td><IMG height=15 alt="" src="icons/fgcolor.gif" width=16 border=0></td><td>Changes the foreground color of the selected text.</td></tr></cfif>
      <cfif URL.BgColor><tr valign="top"><td><IMG height=15 alt="" src="icons/bgcolor.gif" width=16 border=0></td><td>Changes the background color of the selected text.</td></tr></cfif>
      <!--- Tables toolbar --->
      <cfif URL.Tables>
      <tr valign="top"><td><IMG height=15 alt="" src="icons/instable.gif" width=16 border=0></td><td>Inserts a table into the editor at the selected position.</td></tr>
      <cfif URL.InsertCell><tr valign="top"><td><IMG height=15 alt="" src="icons/inscell.gif" width=16 border=0></td><td>Inserts a cell into the selected row.</td></tr></cfif>
      <cfif URL.DeleteCell><tr valign="top"><td><IMG height=15 alt="" src="icons/delcell.gif" width=16 border=0></td><td>Deletes the selected cell.</td></tr></cfif>
      <cfif URL.InsertRow><tr valign="top"><td><IMG height=15 alt="" src="icons/insrow.gif" width=16 border=0></td><td>Inserts a row above the selected row.</td></tr></cfif>
      <cfif URL.DeleteRow><tr valign="top"><td><IMG height=15 alt="" src="icons/delrow.gif" width=16 border=0></td><td>Deletes the selected row.</td></tr></cfif>
      <cfif URL.InsertColumn><tr valign="top"><td><IMG height=15 alt="" src="icons/inscol.gif" width=16 border=0></td><td>Inserts a column to the left of the selected cell.</td></tr></cfif>
      <cfif URL.DeleteColumn><tr valign="top"><td><IMG height=15 alt="" src="icons/delcol.gif" width=16 border=0></td><td>Deletes the selected column.</td></tr></cfif>
      <cfif URL.SplitCell><tr valign="top"><td><IMG height=15 alt="" src="icons/splitcell.gif" width=16 border=0></td><td>Splits the selected cell into two cells.</td></tr></cfif>
      <cfif URL.MergeCell><tr valign="top"><td><IMG height=15 alt="" src="icons/mrgcell.gif" width=16 border=0></td><td>Merges the selected cells.</td></tr></cfif>
      <cfif URL.CellProp><tr valign="top"><td><IMG height=15 alt="" src="icons/tdprop.gif" width=16 border=0></td><td>Opens the table cell properties window.</td></tr></cfif>
      </cfif>
      <!--- View toolbar --->
      <cfif URL.HTMLEdit><tr valign="top"><td><IMG height=15 alt="" src="icons/viewsource.gif" width=16 border=0></td><td>Toggles the editor between source and wysiwyg modes.</td></tr></cfif>
      <cfif URL.Borders><tr valign="top"><td><IMG height=15 alt="" src="icons/borders.gif" width=15 border=0></td><td>Makes all table borders visible.</td></tr></cfif>
      <cfif URL.Details><tr valign="top"><td><IMG height=15 alt="" src="icons/details.gif" width=16 border=0></td><td>Shows all hidden tags.</td></tr></cfif>
    </table>
    </td>
  </tr>
</table>

</body>
</html>
