<html>
<head>
<title>VML editor</title>

<!--[if IE ]>

<script language="JavaScript">

// Copyright Jacco IJzerman (j.ijzerman1@chello.nl)
// Script featured on Dynamic Drive (http://www.dynamicdrive.com)

//window.moveTo(0,0);
//window.resizeTo(screen.availWidth, screen.availHeight);

function maak_code()
{
  var raam = window.open('','vmlcode','height=600,width=600');
  raam.document.open();

  with(raam.document){
  write('<html>\n');
  write('<head>\n<title>VML code</title>\n</head>\n');
  write('<body bgcolor="buttonface">\n');
  write('<center>\n<form>\n');
  write('<textarea style="width: 500px; height: 500px;">\n');

  write('<html>\n<head>\n\n');
  write('<xml:namespace ns="urn:schemas-microsoft-com:vml" prefix="v"/>\n');
  write('<style type="text/css">\nv\\:* { behavior: url(#default#VML);}\n</style>\n\n');
  write('</head>\n<body>\n\n');
  write(document.frames[0].document.body.innerHTML.replace(/<br>/gi, '\n'));
  write('\n\n</body>\n</html>\n');

  write('</textarea>\n<br>\n');
  write('<input type="button" value="Select" style="font-family: Verdana, Arial; font-size: 12px; width: 150px; margin-top: 8px;" onclick="document.forms[0].elements[0].select()">\n');
  write('</form>\n</center>\n');
  write('</body>\n');
  write('</html>');
  } 

  raam.document.close();
  raam.focus();
}

function legen()
{
  document.frames[0].document.body.innerHTML = '';
  document.frames[0].teller = 0;
}

kleurenkiezer = '';

function activeer_kiescellen()
{
  var cellen = document.getElementsByTagName('td');
  for(var i = 0; i < cellen.length; i++){
    if(cellen[i].className == 'kleur'){
    cellen[i].onclick = kies_kleur;
    }
  }
}

function voorbereiden_kleurkeuze(vul_of_rand)
{
  if(kleurenkiezer != ''){ return;}
  document.getElementById(vul_of_rand + '_cel').style.backgroundColor = '#FFFFFF';
  document.getElementById(vul_of_rand + '_cel').innerHTML = '<span style="color: #FF0033; font-size: 9px;">Choose color</span>';
  kleurenkiezer = vul_of_rand;
}

function kies_kleur()
{
  if(kleurenkiezer == ''){
  var fout = 'You have to select Fill or Stroke.\n\n';
  fout += 'You can do this by clicking on the colored square above the word "Fill" or "Stroke".\n\n';
  fout += 'After that you can select a color. ';
  fout += 'If you do not want to use a fill or stroke color, click on X.\n';
  alert(fout);
  return;
  } 

  var kleur = (this.childNodes.length > 0)? '': this.bgColor;
  var HTML = (this.childNodes.length > 0)? '<span style="color: #FF0033; font-size: 9px;">Transparent</span>': '';
  document.forms[0].elements[kleurenkiezer].value = kleur;
  document.getElementById(kleurenkiezer + '_cel').innerHTML = HTML;
  document.getElementById(kleurenkiezer + '_cel').style.backgroundColor = this.bgColor;
  kleurenkiezer = '';
}

function verwijder_vorm_uit_tekenblad()
{
  if(document.frames[0].teller > 0){
  document.frames[0].document.getElementById('nr' + document.frames[0].teller).removeNode(true);
  document.frames[0].document.getElementsByTagName('br')[(document.frames[0].teller - 1)].removeNode(true);
  document.frames[0].teller--;
  }
}

window.onerror = function(){ return true;}

window.onload = activeer_kiescellen;

document.writeln('<xml:namespace ns="urn:schemas-microsoft-com:vml" prefix="v"/>');
document.writeln('<style type="text/css">');
document.writeln('v\\:* { behavior: url(#default#VML);}');
document.writeln('</style>');

</script>

<style type="text/css">
body { 
 background-color: buttonface;
 }
select, input, td {
 font-family: Verdana, Arial;
 font-size: 10px;
 }
.kleur {
 width: 20px;
 height: 20px;
 cursor: hand; 
 }
hr {
 width: 150px;
}
</style>

<![endif]-->

</head>
<body>

<!--[if IE ]>

<table width="100%" height="100%">
  <tr>
  <td width="165" valign="top">

  <form>

  <input type="hidden" name="vulkleur" value="">
  <input type="hidden" name="randkleur" value="#000000">
  
  <b>Tool:</b>
  <select name="gereedschap" style="width: 150px;">
  <!-- <option value="vrijevorm">Free shape</option>
  <option value="ovaal">Oval</option> -->
  <option value="rechthoek">Rect</option>
  <!-- <option value="rondhoek">Roundrect</option> -->
  </select>

  <hr align="left">

  <b>Size:</b>
  <select name="lijndikte" style="width: 150px;">
  <option value="1px">1px</option>
  <option value="2px">2px</option>
  <option value="3px">3px</option>
  <option value="4px">4px</option>
  <option value="5px">5px</option>
  <option value="6px">6px</option>
  <option value="7px">7px</option>
  <option value="8px">8px</option>
  <option value="9px">9px</option>
  <option value="10px">10px</option>
  <option value="11px">11px</option>
  <option value="12px">12px</option>
  </select>

  <hr align="left">

  <table>

    <tr>
    <td class="kleur" bgcolor="#000000"></td>
    <td class="kleur" bgcolor="#583200"></td>
    <td class="kleur" bgcolor="#4E5800"></td>
    <td class="kleur" bgcolor="#007C42"></td>
    <td class="kleur" bgcolor="#0060A0"></td>
    <td class="kleur" bgcolor="#051DFF"></td>
    </tr><tr>
    <td class="kleur" bgcolor="#A800CC"></td>
    <td class="kleur" bgcolor="#D00095"></td>
    <td class="kleur" bgcolor="#C40053"></td>
    <td class="kleur" bgcolor="#FF0033"></td>
    <td class="kleur" bgcolor="#FC6500"></td>
    <td class="kleur" bgcolor="#FFEF21"></td>
    </tr><tr>
    <td class="kleur" bgcolor="#8CFF21"></td>
    <td class="kleur" bgcolor="#39FF71"></td>
    <td class="kleur" bgcolor="#65FFD9"></td>
    <td class="kleur" bgcolor="#79D0FF"></td>
    <td class="kleur" bgcolor="#8D8DFF"></td>
    <td class="kleur" bgcolor="#FFC9FC"></td>
    </tr><tr>
    <td class="kleur" bgcolor="#FFF7E9"></td>
    <td class="kleur" bgcolor="#E5FFE5"></td>
    <td class="kleur" bgcolor="#FFF2B9"></td>
    <td class="kleur" bgcolor="#DDFFA5"></td>
    <td class="kleur" bgcolor="#FFEAA1"></td>
    <td class="kleur" bgcolor="#FFFFFF" align="center"><span style="color: #FF0033; font-size: 10px; font-weight: bold;">X</span></td>
    </tr>

    <tr>
    <td cospan="6" style="height: 10px;"></td>
    </tr>

    <tr>
    <td id="vulkleur_cel" align="center" colspan="3" style="cursor: hand; height: 50px; background-color: #FFFFFF;" onselectstart="return false"  onclick="voorbereiden_kleurkeuze('vulkleur')" >
    <span style="color: #FF0033; font-size: 9px;">Transparent</span>
    </td>
    <td id="randkleur_cel" align="center" colspan="3" style="cursor: hand; height: 50px; background-color: #000000;" onselectstart="return false"  onclick="voorbereiden_kleurkeuze('randkleur')" >
    </td>
    </tr>

    <tr>
    <td colspan="3" style="font-size: 9px;">Fill</td>
    <td colspan="3" style="font-size: 9px;">Stroke</td>
    </tr>

  </table>

  <hr align="left">

  <input type="checkbox" name="anti_alias">&nbsp;&nbsp;<b>Antialias</b>

  <hr align="left">

  <input type="button" value="Undo" style="width: 150px;" onclick="verwijder_vorm_uit_tekenblad()" onfocus="this.blur()">
  <input type="button" value="Empty" style="width: 150px; margin-top: 8px;" onclick="legen()" onfocus="this.blur()" >

  <hr align="left">
  
  <input type="button" name="submitknop" value="Get code" style="width: 150px;" onclick="maak_code()" onfocus="this.blur()"> 

  </form>

  <span id="geen_script" style="color: #FF0033; font-weight: bold;">This application uses JavaScript. Enable JavaScript if you want to use this application.</span>

  </td><td valign="top">

  <iframe width="100%" height="100%" src="../utilities/blad.htm"></iframe>

  </td>
  </tr>
</table>

<script language="JavaScript">

document.getElementById('geen_script').innerText = '';
document.forms[0].reset();
document.writeln('<v:oval style="position: absolute; left: 0px; top: 0px; width: 1px; height: 1px; display: none;" />');

</script>

<![endif]-->

<![if !IE ]>
<h4><font face="Arial, Helvetica">This page can only be viewed in Internet Explorer 5+ (Windows).</font></h4>
<![endif]>

</body>
</html>
