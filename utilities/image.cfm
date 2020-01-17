
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGraphics">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>
<!--- default image parameters --->
<cfparam name="URL.ImagePath" default="../images/">
<cfparam name="URL.src" default="">      
<cfparam name="URL.style" default="">      
<cfparam name="URL.alt" default="">      
<cfparam name="URL.width" default="">      
<cfparam name="URL.height" default="">      
<cfparam name="URL.hspace" default="">      
<cfparam name="URL.vspace" default="">      
<cfparam name="URL.border" default="">      
<cfparam name="URL.align" default="">  
    
<html>
<?xml:namespace prefix="so" />
head><title>Editor: Image</title>
<link rel="stylesheet" type="text/css" href="sotoolbar.css"></link>
<style>
  body, .button, fieldset{background: #d4d0c8;font: 8pt/8pt Tahoma;margin:0px;}
  .text {font: 8pt/8pt Tahoma;padding:5px 0px 5px 0px;}
  #OuterFields {padding-left:12px}
  .inputs {padding-right:15px;font: 8pt/8pt Tahoma;}
  #ImgView {overflow:auto;width: 150px;height:125px;border-width: 1px;border-style: solid;border-color: threeddarkshadow white white threeddarkshadow;}
  #elImage {margin:15px;visibility:hidden;}
  #ImgViewBorder{width: 150px;height:125px;border: 1px inset #d4d0c8;}
  input {font: 8pt/8pt Tahoma;}
  so\:toolbar {behavior: url(sotoolbar.htc);}    
  so\:toolbar .button {behavior: url(sobutton.htc);}
  so\:toolbar .switch {behavior: url(soswitch.htc); }
</style>

<script language="JScript" for="window" event="onload">
  if (ImgSrc.value)
    elImage.src = opener.soEditor.baseURL + ImgSrc.value;
  if (ImgAlign.selected != "") {
    // select the correct alignment
    var alignOpt = ImgAlign.options;
    for (var idx=0; idx < alignOpt.length; idx++) {
      if (alignOpt[idx].value.toLowerCase() == ImgAlign.selected.toLowerCase())
        alignOpt[idx].selected = true;
    }
  }
  self.focus();
</script>

<script language="JScript" for="window" event="onunload">
  // closes file view window if it is open
  try{opener.focus();}catch(e){};  
</script>


<script language="JScript" for="OK" event="onclick"> 
  // insert the image in the editor
  if (ImgSrc.value.length > 0){
    var sImgTag = '<img src="' + ImgSrc.value + '" hspace="' + ImgHSpace.value + '" vspace="' + ImgVSpace.value + '" border="' + ImgBorder.value + '" align="' + ImgAlign.value + '" alt="' + ImgAlt.value + '" style="' + ImgStyle.value +'">';
    opener.soEditor.insertImage(sImgTag);
  }
  window.close();
</script>

<script language="JScript" for="elImage" event="onreadystatechange">
  // load image information when preview completes
  if (readyState == "complete"){
    elImage.style.visibility = "visible"; 
    if (document.readyState == "complete") {
      ImgWidth.value = elImage.width;
      ImgHieght.value = elImage.height;    
    }
  }
</script>

<script language="JScript" defer>
  function isInt() {
    return ((event.keyCode >= 48) && (event.keyCode <= 57))
  }
  function changePreview(){
     elImage.style.visibility = "hidden";
     elImage.src = ImgSrc.options[ImgSrc.selectedIndex].value;
	 elImage.style.visibility = "visible";
  } 
</script>

</head>
<body scroll="no" style="border:0px;">
<table>
<tr>
<td>
<fieldset style="padding:5px;"><legend>Image Information</legend>
<table cellspacing="0" cellpadding="0" border=0>
<tr>
  <td class="text" id="OuterFields">Source:</td>
  <td colspan="2" style="font: 8pt/8pt Tahoma;">
  <select name="ImgSrc" onchange="changePreview();">
  	<cfoutput query="AllGraphics">
		<option value="#application.returnpath#/#filename#">#trim(description)#
	</cfoutput>
  </select>
  <!--- <input name="ImgSrc" style="width:340px;" type="text" maxlength="255" value="<cfoutput>#URL.Src#</cfoutput>" onchange="changePreview();"> ---></td>
</tr>
<tr>
  <td colspan="3">
  <table cellspacing="3" cellpadding="0">
  <tr>
    <td class="text" nowrap width="50px">Alt. Text:</td>
    <td class="inputs" colspan="4"><input name="ImgAlt" style="width:100px;" type="text" maxlength="255" value="<cfoutput>#URL.Alt#</cfoutput>"></td>  
    <td rowspan="4" align="center" style="padding:10px"><span id="ImgViewBorder"><span id="ImgView"><img id="elImage" src=""></span></td>
  </tr>
  <tr>
  <td class="text">Width:</td>
  <td class="inputs"><input name="ImgWidth" type="text" style="width:50px;" maxlength="3" value="<cfoutput>#URL.Width#</cfoutput>" onchange="elImage.style.width = this.value;" onkeypress="event.returnValue=isInt();"></td>  
  <td class="text">Height:</td>
  <td class="inputs"><input name="ImgHieght" type="text" style="width:50px;" maxlength="3" value="<cfoutput>#URL.Height#</cfoutput>" onchange="elImage.style.height = this.value;" onkeypress="event.returnValue=isInt();"></td>  
  </tr>
  <tr>
  <td class="text">HSpace:</td>
  <td class="inputs"><input name="ImgHSpace" type="text" style="width:50px;" maxlength="3" value="<cfoutput>#URL.HSpace#</cfoutput>" onkeypress="event.returnValue=isInt();"></td>  
  <td class="text">VSpace:</td>
  <td class="inputs"><input name="ImgVSpace" type="text" style="width:50px;" maxlength="3" value="<cfoutput>#URL.VSpace#</cfoutput>" onkeypress="event.returnValue=isInt();"></td>  
  </tr> 
  <tr>
  <td class="text">Border:</td>
  <td class="inputs"><input name="ImgBorder" type="text" style="width:50px;" maxlength="3" value="<cfoutput>#URL.Border#</cfoutput>" onkeypress="event.returnValue=isInt();"></td>  
  <td class="text">Align:</td>
  <td class="inputs"><select name="ImgAlign" selected="<cfoutput>#URL.Align#</cfoutput>"><option></option><option value="left">left</option><option value="right">right</option><option value="top">top</option><option value="middle">middle</option><option value="bottom">bottom</option><option value="absmiddle">absmiddle</option><option value="texttop">texttop</option><option value="baseline">baseline</option></select></td>  
  </tr>   
  </table>
  </td>
</tr>
<tr>
  <td class="text" id="OuterFields">Style:</td>
  <td class="inputs" colspan="2"><input name="ImgStyle" type="text" style="width:340px;" maxlength="255" value="<cfoutput>#URL.Style#</cfoutput>"></td>  
</tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td align="right">
<table>
<tr><td><input id="OK" class="button" type="button" value="     OK     "></td>
<td><input class="button" type="button" value="  Cancel  " onclick="window.close();"></td></tr>
</table>
</td>
</tr>
</table>
</body>
</html>
