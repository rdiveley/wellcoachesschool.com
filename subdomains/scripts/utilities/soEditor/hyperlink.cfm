<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="Pages">
	<cfinvokeargument name="ThisFileName" value="Pages">
</cfinvoke>
<html>
<head><title>Editor: Hyperlink</title>
<link rel="stylesheet" type="text/css" href="sotoolbar.css"></link>
<style>
  body, .button{background: #d4d0c8;font: 8pt/8pt Tahoma;margin:0px;}
  body {padding:5px;}
  .text {font: 8pt/8pt Tahoma;padding:5px 0px 5px 0px;}
  .inputs {padding-right:15px;padding-top:5px;}
  .controls {width:100%;text-align:right;margin-top:5px;margin-right:3px}
  input {font: 8pt/8pt Tahoma;}
  fieldset {padding:15px;}
</style>
<script language="JScript" for="window" event="onload">
  for ( elem in window.dialogArguments )
  {
    switch( elem ) {
    case "url":    
      tbURL.value = window.dialogArguments["url"];
      break;    
    case "target":    
      tbTarget.value = window.dialogArguments["target"];
      break;
    case "style":    
      tbStyle.value = window.dialogArguments["style"];
      break;      
    }
  }
</script>
<script language="JScript" for="OK" event="onclick">
  var arr = new Array();
  arr["url"] = tbURL.value;
  arr["target"] = tbTarget.value;    
  arr["style"] = tbStyle.value;
  window.returnValue = arr;
  window.close();
  
</script>
<script>
	function ChangeType() {
  	tbURL.value=tbType.value;
  }
</script>
</head>
<body scroll="no">
<fieldset title="Hyperlink Properties"><legend>Hyperlink Properties</legend>
<table cellspacing="3" style="margin:10px;">
<tr>
  <td class="text">Type:</td>
  <td class="inputs" colspan="3"><select name="tbType" onChange="ChangeType()"><option value="http://">Web Link<option value="mailto:">Email</select></td>  
</tr>
<tr>
  <td class="text">URL:</td>
  <td class="inputs" colspan="3">
  	<cf_combobox name="tbURL" value="http://">
		<cfoutput query="allpages">
			<option value="index.cfm?Page=#pagename#">#pagename#
		</cfoutput>
	</cf_combobox>
  </td>  
</tr>
<tr>
  <td class="text">Target:</td>
  <td class="inputs"><input name="tbTarget" type="text" maxlength="100" style="width:50px"></td>  
</tr>
<tr>
  <td class="text">Style:</td>
  <td class="inputs" colspan="3"><input name="tbStyle" type="text" maxlength="100" style="width:200px"></td>  
</tr>

</table>
</fieldset>
<div class="controls"><input id="OK" class="button" type="button" value="     OK     "> <input class="button" type="button" value="  Cancel  " onclick="window.close();"></div>

</body>
</html>
