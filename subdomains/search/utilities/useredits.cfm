<script language="JavaScript1.1">

function AddScript(form) {
	var txt= thisform.thescript.options[thisform.thescript.selectedIndex].value;
	var AddTxt="ScriptIs="+txt; 
	soEditor.insertText("[" + AddTxt + "]","", false, true);
}
function AddForm(form) {
	var txt= thisform.theform.options[thisform.theform.selectedIndex].value;
	var AddTxt="ScriptIs="+txt; 
	soEditor.insertText("[" + AddTxt + "]","", false, true);
}
</script>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForms">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="forms">
</cfinvoke>

<table width="100%" align="CENTER" bgcolor="Silver" border=1>

	<tr>
	<td colspan=4>
	<cfmodule template="../utilities/soeditor/soeditor_lite.cfm" 		
			form="thisform"
          	field="D19"
          	scriptpath="../utilities/soeditor/"
			link="false"
			unlink="false"
			image="false">
	</td>
	</tr>
	
	</table>
</td></tr></table>