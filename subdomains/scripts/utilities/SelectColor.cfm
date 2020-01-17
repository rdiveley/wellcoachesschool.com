<cfparam name="tControl" default="D19">
<cfparam name="tForm" default="thisform">
<HTML><HEAD>
	<TITLE>Pages - Edit Record</TITLE>
<SCRIPT LANGUAGE="JavaScript">
function pick(symbol) {
  if (window.opener && !window.opener.closed)
    window.opener.document.<cfoutput>#tForm#.#tControl#</cfoutput>.value = symbol;
  window.close();
}
</SCRIPT>
</HEAD>
<BODY aLink=black bgColor=white link=black text=black vLink=black>
<CENTER><FONT face=Arial size=2>
<TABLE cellPadding=0 cellSpacing=0>
  <TBODY>
  <TR>
    <TD align=middle bgColor=#a52a2a height=10><A 
      href="javascript:pick('#a52a2a')" 
      onmouseover="document.bgColor='#a52a2a'">abrown </A></TD>
    <TD align=middle bgColor=#d2691e height=10><A 
      href="javascript:pick('#d2691e')" 
      onmouseover="document.bgColor='#d2691e'">echocolate </A></TD>
    <TD align=middle bgColor=#000000 height=10><A 
      href="javascript:pick('#000000')" 
      onmouseover="document.bgColor='#000000'">black </A></TD>
    <TD align=middle bgColor=#000080 height=10><A 
      href="javascript:pick('#000080')" 
      onmouseover="document.bgColor='#000080'">NavyBlue </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#00008b height=10><A 
      href="javascript:pick('#00008b')" 
      onmouseover="document.bgColor='#00008b'">blue4 </A></TD>
    <TD align=middle bgColor=#0000cd height=10><A 
      href="javascript:pick('#0000cd')" 
      onmouseover="document.bgColor='#0000cd'">MediumBlue </A></TD>
    <TD align=middle bgColor=#0000ee height=10><A 
      href="javascript:pick('#0000ee')" 
      onmouseover="document.bgColor='#0000ee'">blue2 </A></TD>
    <TD align=middle bgColor=#0000ff height=10><A 
      href="javascript:pick('#0000ff')" 
      onmouseover="document.bgColor='#0000ff'">blue1 </A></TD>
    <TD align=middle bgColor=#006400 height=10><A 
      href="javascript:pick('#006400')" 
      onmouseover="document.bgColor='#006400'">DarkGreen </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#00688b height=10><A 
      href="javascript:pick('#00688b')" 
      onmouseover="document.bgColor='#00688b'">DeepSkyBlue4 </A></TD>
    <TD align=middle bgColor=#00868b height=10><A 
      href="javascript:pick('#00868b')" 
      onmouseover="document.bgColor='#00868b'">turquoise4 </A></TD>
    <TD align=middle bgColor=#008b00 height=10><A 
      href="javascript:pick('#008b00')" 
      onmouseover="document.bgColor='#008b00'">green4 </A></TD>
    <TD align=middle bgColor=#008b45 height=10><A 
      href="javascript:pick('#008b45')" 
      onmouseover="document.bgColor='#008b45'">SpringGreen4 </A></TD>
    <TD align=middle bgColor=#008b8b height=10><A 
      href="javascript:pick('#008b8b')" 
      onmouseover="document.bgColor='#008b8b'">cyan4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#009acd height=10><A 
      href="javascript:pick('#009acd')" 
      onmouseover="document.bgColor='#009acd'">DeepSkyBlue3 </A></TD>
    <TD align=middle bgColor=#00b2ee height=10><A 
      href="javascript:pick('#00b2ee')" 
      onmouseover="document.bgColor='#00b2ee'">DeepSkyBlue2 </A></TD>
    <TD align=middle bgColor=#00bfff height=10><A 
      href="javascript:pick('#00bfff')" 
      onmouseover="document.bgColor='#00bfff'">DeepSkyBlue1 </A></TD>
    <TD align=middle bgColor=#00c5cd height=10><A 
      href="javascript:pick('#00c5cd')" 
      onmouseover="document.bgColor='#00c5cd'">turquoise3 </A></TD>
    <TD align=middle bgColor=#00cd00 height=10><A 
      href="javascript:pick('#00cd00')" 
      onmouseover="document.bgColor='#00cd00'">green3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#00cd66 height=10><A 
      href="javascript:pick('#00cd66')" 
      onmouseover="document.bgColor='#00cd66'">SpringGreen3 </A></TD>
    <TD align=middle bgColor=#00cdcd height=10><A 
      href="javascript:pick('#00cdcd')" 
      onmouseover="document.bgColor='#00cdcd'">cyan3 </A></TD>
    <TD align=middle bgColor=#00ced1 height=10><A 
      href="javascript:pick('#00ced1')" 
      onmouseover="document.bgColor='#00ced1'">DarkTurquoise </A></TD>
    <TD align=middle bgColor=#00e5ee height=10><A 
      href="javascript:pick('#00e5ee')" 
      onmouseover="document.bgColor='#00e5ee'">turquoise2 </A></TD>
    <TD align=middle bgColor=#00ee00 height=10><A 
      href="javascript:pick('#00ee00')" 
      onmouseover="document.bgColor='#00ee00'">green2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#00ee76 height=10><A 
      href="javascript:pick('#00ee76')" 
      onmouseover="document.bgColor='#00ee76'">SpringGreen2 </A></TD>
    <TD align=middle bgColor=#00eeee height=10><A 
      href="javascript:pick('#00eeee')" 
      onmouseover="document.bgColor='#00eeee'">cyan2 </A></TD>
    <TD align=middle bgColor=#00f5ff height=10><A 
      href="javascript:pick('#00f5ff')" 
      onmouseover="document.bgColor='#00f5ff'">turquoise1 </A></TD>
    <TD align=middle bgColor=#00fa9a height=10><A 
      href="javascript:pick('#00fa9a')" 
      onmouseover="document.bgColor='#00fa9a'">MediumSpringGreen </A></TD>
    <TD align=middle bgColor=#00ff00 height=10><A 
      href="javascript:pick('#00ff00')" 
      onmouseover="document.bgColor='#00ff00'">green1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#00ff7f height=10><A 
      href="javascript:pick('#00ff7f')" 
      onmouseover="document.bgColor='#00ff7f'">SpringGreen1 </A></TD>
    <TD align=middle bgColor=#00ffff height=10><A 
      href="javascript:pick('#00ffff')" 
      onmouseover="document.bgColor='#00ffff'">cyan1 </A></TD>
    <TD align=middle bgColor=#030303 height=10><A 
      href="javascript:pick('#030303')" 
      onmouseover="document.bgColor='#030303'">gray1 </A></TD>
    <TD align=middle bgColor=#050505 height=10><A 
      href="javascript:pick('#050505')" 
      onmouseover="document.bgColor='#050505'">gray2 </A></TD>
    <TD align=middle bgColor=#080808 height=10><A 
      href="javascript:pick('#080808')" 
      onmouseover="document.bgColor='#080808'">gray3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#0a0a0a height=10><A 
      href="javascript:pick('#0a0a0a')" 
      onmouseover="document.bgColor='#0a0a0a'">gray4 </A></TD>
    <TD align=middle bgColor=#0d0d0d height=10><A 
      href="javascript:pick('#0d0d0d')" 
      onmouseover="document.bgColor='#0d0d0d'">gray5 </A></TD>
    <TD align=middle bgColor=#0f0f0f height=10><A 
      href="javascript:pick('#0f0f0f')" 
      onmouseover="document.bgColor='#0f0f0f'">gray6 </A></TD>
    <TD align=middle bgColor=#104e8b height=10><A 
      href="javascript:pick('#104e8b')" 
      onmouseover="document.bgColor='#104e8b'">DodgerBlue4 </A></TD>
    <TD align=middle bgColor=#121212 height=10><A 
      href="javascript:pick('#121212')" 
      onmouseover="document.bgColor='#121212'">gray7 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#141414 height=10><A 
      href="javascript:pick('#141414')" 
      onmouseover="document.bgColor='#141414'">gray8 </A></TD>
    <TD align=middle bgColor=#171717 height=10><A 
      href="javascript:pick('#171717')" 
      onmouseover="document.bgColor='#171717'">gray9 </A></TD>
    <TD align=middle bgColor=#1874cd height=10><A 
      href="javascript:pick('#1874cd')" 
      onmouseover="document.bgColor='#1874cd'">DodgerBlue3 </A></TD>
    <TD align=middle bgColor=#191970 height=10><A 
      href="javascript:pick('#191970')" 
      onmouseover="document.bgColor='#191970'">MidnightBlue </A></TD>
    <TD align=middle bgColor=#1a1a1a height=10><A 
      href="javascript:pick('#1a1a1a')" 
      onmouseover="document.bgColor='#1a1a1a'">gray10 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#1c1c1c height=10><A 
      href="javascript:pick('#1c1c1c')" 
      onmouseover="document.bgColor='#1c1c1c'">gray11 </A></TD>
    <TD align=middle bgColor=#1c86ee height=10><A 
      href="javascript:pick('#1c86ee')" 
      onmouseover="document.bgColor='#1c86ee'">DodgerBlue2 </A></TD>
    <TD align=middle bgColor=#1e90ff height=10><A 
      href="javascript:pick('#1e90ff')" 
      onmouseover="document.bgColor='#1e90ff'">DodgerBlue1 </A></TD>
    <TD align=middle bgColor=#1f1f1f height=10><A 
      href="javascript:pick('#1f1f1f')" 
      onmouseover="document.bgColor='#1f1f1f'">gray12 </A></TD>
    <TD align=middle bgColor=#20b2aa height=10><A 
      href="javascript:pick('#20b2aa')" 
      onmouseover="document.bgColor='#20b2aa'">LightSeaGreen </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#212121 height=10><A 
      href="javascript:pick('#212121')" 
      onmouseover="document.bgColor='#212121'">gray13 </A></TD>
    <TD align=middle bgColor=#228b22 height=10><A 
      href="javascript:pick('#228b22')" 
      onmouseover="document.bgColor='#228b22'">ForestGreen </A></TD>
    <TD align=middle bgColor=#242424 height=10><A 
      href="javascript:pick('#242424')" 
      onmouseover="document.bgColor='#242424'">gray14 </A></TD>
    <TD align=middle bgColor=#262626 height=10><A 
      href="javascript:pick('#262626')" 
      onmouseover="document.bgColor='#262626'">gray15 </A></TD>
    <TD align=middle bgColor=#27408b height=10><A 
      href="javascript:pick('#27408b')" 
      onmouseover="document.bgColor='#27408b'">RoyalBlue4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#292929 height=10><A 
      href="javascript:pick('#292929')" 
      onmouseover="document.bgColor='#292929'">gray16 </A></TD>
    <TD align=middle bgColor=#2b2b2b height=10><A 
      href="javascript:pick('#2b2b2b')" 
      onmouseover="document.bgColor='#2b2b2b'">gray17 </A></TD>
    <TD align=middle bgColor=#2e2e2e height=10><A 
      href="javascript:pick('#2e2e2e')" 
      onmouseover="document.bgColor='#2e2e2e'">gray18 </A></TD>
    <TD align=middle bgColor=#2e8b57 height=10><A 
      href="javascript:pick('#2e8b57')" 
      onmouseover="document.bgColor='#2e8b57'">SeaGreen4 </A></TD>
    <TD align=middle bgColor=#2f4f4f height=10><A 
      href="javascript:pick('#2f4f4f')" 
      onmouseover="document.bgColor='#2f4f4f'">DarkSlateGray </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#303030 height=10><A 
      href="javascript:pick('#303030')" 
      onmouseover="document.bgColor='#303030'">gray19 </A></TD>
    <TD align=middle bgColor=#32cd32 height=10><A 
      href="javascript:pick('#32cd32')" 
      onmouseover="document.bgColor='#32cd32'">LimeGreen </A></TD>
    <TD align=middle bgColor=#333333 height=10><A 
      href="javascript:pick('#333333')" 
      onmouseover="document.bgColor='#333333'">gray20 </A></TD>
    <TD align=middle bgColor=#363636 height=10><A 
      href="javascript:pick('#363636')" 
      onmouseover="document.bgColor='#363636'">gray21 </A></TD>
    <TD align=middle bgColor=#36648b height=10><A 
      href="javascript:pick('#36648b')" 
      onmouseover="document.bgColor='#36648b'">SteelBlue4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#383838 height=10><A 
      href="javascript:pick('#383838')" 
      onmouseover="document.bgColor='#383838'">gray22 </A></TD>
    <TD align=middle bgColor=#3a5fcd height=10><A 
      href="javascript:pick('#3a5fcd')" 
      onmouseover="document.bgColor='#3a5fcd'">RoyalBlue3 </A></TD>
    <TD align=middle bgColor=#3b3b3b height=10><A 
      href="javascript:pick('#3b3b3b')" 
      onmouseover="document.bgColor='#3b3b3b'">gray23 </A></TD>
    <TD align=middle bgColor=#3cb371 height=10><A 
      href="javascript:pick('#3cb371')" 
      onmouseover="document.bgColor='#3cb371'">MediumSeaGreen </A></TD>
    <TD align=middle bgColor=#3d3d3d height=10><A 
      href="javascript:pick('#3d3d3d')" 
      onmouseover="document.bgColor='#3d3d3d'">gray24 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#404040 height=10><A 
      href="javascript:pick('#404040')" 
      onmouseover="document.bgColor='#404040'">gray25 </A></TD>
    <TD align=middle bgColor=#40e0d0 height=10><A 
      href="javascript:pick('#40e0d0')" 
      onmouseover="document.bgColor='#40e0d0'">turquoise </A></TD>
    <TD align=middle bgColor=#4169e1 height=10><A 
      href="javascript:pick('#4169e1')" 
      onmouseover="document.bgColor='#4169e1'">RoyalBlue </A></TD>
    <TD align=middle bgColor=#424242 height=10><A 
      href="javascript:pick('#424242')" 
      onmouseover="document.bgColor='#424242'">gray26 </A></TD>
    <TD align=middle bgColor=#436eee height=10><A 
      href="javascript:pick('#436eee')" 
      onmouseover="document.bgColor='#436eee'">RoyalBlue2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#43cd80 height=10><A 
      href="javascript:pick('#43cd80')" 
      onmouseover="document.bgColor='#43cd80'">SeaGreen3 </A></TD>
    <TD align=middle bgColor=#454545 height=10><A 
      href="javascript:pick('#454545')" 
      onmouseover="document.bgColor='#454545'">gray27 </A></TD>
    <TD align=middle bgColor=#458b00 height=10><A 
      href="javascript:pick('#458b00')" 
      onmouseover="document.bgColor='#458b00'">chartreuse4 </A></TD>
    <TD align=middle bgColor=#458b74 height=10><A 
      href="javascript:pick('#458b74')" 
      onmouseover="document.bgColor='#458b74'">aquamarine4 </A></TD>
    <TD align=middle bgColor=#4682b4 height=10><A 
      href="javascript:pick('#4682b4')" 
      onmouseover="document.bgColor='#4682b4'">SteelBlue </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#473c8b height=10><A 
      href="javascript:pick('#473c8b')" 
      onmouseover="document.bgColor='#473c8b'">SlateBlue4 </A></TD>
    <TD align=middle bgColor=#474747 height=10><A 
      href="javascript:pick('#474747')" 
      onmouseover="document.bgColor='#474747'">gray28 </A></TD>
    <TD align=middle bgColor=#483d8b height=10><A 
      href="javascript:pick('#483d8b')" 
      onmouseover="document.bgColor='#483d8b'">DarkSlateBlue </A></TD>
    <TD align=middle bgColor=#4876ff height=10><A 
      href="javascript:pick('#4876ff')" 
      onmouseover="document.bgColor='#4876ff'">RoyalBlue1 </A></TD>
    <TD align=middle bgColor=#48d1cc height=10><A 
      href="javascript:pick('#48d1cc')" 
      onmouseover="document.bgColor='#48d1cc'">MediumTurquoise </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#4a4a4a height=10><A 
      href="javascript:pick('#4a4a4a')" 
      onmouseover="document.bgColor='#4a4a4a'">gray29 </A></TD>
    <TD align=middle bgColor=#4a708b height=10><A 
      href="javascript:pick('#4a708b')" 
      onmouseover="document.bgColor='#4a708b'">SkyBlue4 </A></TD>
    <TD align=middle bgColor=#4d4d4d height=10><A 
      href="javascript:pick('#4d4d4d')" 
      onmouseover="document.bgColor='#4d4d4d'">gray30 </A></TD>
    <TD align=middle bgColor=#4eee94 height=10><A 
      href="javascript:pick('#4eee94')" 
      onmouseover="document.bgColor='#4eee94'">SeaGreen2 </A></TD>
    <TD align=middle bgColor=#4f4f4f height=10><A 
      href="javascript:pick('#4f4f4f')" 
      onmouseover="document.bgColor='#4f4f4f'">gray31 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#4f94cd height=10><A 
      href="javascript:pick('#4f94cd')" 
      onmouseover="document.bgColor='#4f94cd'">SteelBlue3 </A></TD>
    <TD align=middle bgColor=#525252 height=10><A 
      href="javascript:pick('#525252')" 
      onmouseover="document.bgColor='#525252'">gray32 </A></TD>
    <TD align=middle bgColor=#528b8b height=10><A 
      href="javascript:pick('#528b8b')" 
      onmouseover="document.bgColor='#528b8b'">DarkSlateGray4 </A></TD>
    <TD align=middle bgColor=#53868b height=10><A 
      href="javascript:pick('#53868b')" 
      onmouseover="document.bgColor='#53868b'">CadetBlue4 </A></TD>
    <TD align=middle bgColor=#545454 height=10><A 
      href="javascript:pick('#545454')" 
      onmouseover="document.bgColor='#545454'">gray33 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#548b54 height=10><A 
      href="javascript:pick('#548b54')" 
      onmouseover="document.bgColor='#548b54'">PaleGreen4 </A></TD>
    <TD align=middle bgColor=#54ff9f height=10><A 
      href="javascript:pick('#54ff9f')" 
      onmouseover="document.bgColor='#54ff9f'">SeaGreen1 </A></TD>
    <TD align=middle bgColor=#551a8b height=10><A 
      href="javascript:pick('#551a8b')" 
      onmouseover="document.bgColor='#551a8b'">purple4 </A></TD>
    <TD align=middle bgColor=#556b2f height=10><A 
      href="javascript:pick('#556b2f')" 
      onmouseover="document.bgColor='#556b2f'">DarkOliveGreen </A></TD>
    <TD align=middle bgColor=#575757 height=10><A 
      href="javascript:pick('#575757')" 
      onmouseover="document.bgColor='#575757'">gray34 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#595959 height=10><A 
      href="javascript:pick('#595959')" 
      onmouseover="document.bgColor='#595959'">gray35 </A></TD>
    <TD align=middle bgColor=#5c5c5c height=10><A 
      href="javascript:pick('#5c5c5c')" 
      onmouseover="document.bgColor='#5c5c5c'">gray36 </A></TD>
    <TD align=middle bgColor=#5cacee height=10><A 
      href="javascript:pick('#5cacee')" 
      onmouseover="document.bgColor='#5cacee'">SteelBlue2 </A></TD>
    <TD align=middle bgColor=#5d478b height=10><A 
      href="javascript:pick('#5d478b')" 
      onmouseover="document.bgColor='#5d478b'">MediumPurple4 </A></TD>
    <TD align=middle bgColor=#5e5e5e height=10><A 
      href="javascript:pick('#5e5e5e')" 
      onmouseover="document.bgColor='#5e5e5e'">gray37 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#5f9ea0 height=10><A 
      href="javascript:pick('#5f9ea0')" 
      onmouseover="document.bgColor='#5f9ea0'">CadetBlue </A></TD>
    <TD align=middle bgColor=#607b8b height=10><A 
      href="javascript:pick('#607b8b')" 
      onmouseover="document.bgColor='#607b8b'">LightSkyBlue4 </A></TD>
    <TD align=middle bgColor=#616161 height=10><A 
      href="javascript:pick('#616161')" 
      onmouseover="document.bgColor='#616161'">gray38 </A></TD>
    <TD align=middle bgColor=#636363 height=10><A 
      href="javascript:pick('#636363')" 
      onmouseover="document.bgColor='#636363'">gray39 </A></TD>
    <TD align=middle bgColor=#63b8ff height=10><A 
      href="javascript:pick('#63b8ff')" 
      onmouseover="document.bgColor='#63b8ff'">SteelBlue1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#6495ed height=10><A 
      href="javascript:pick('#6495ed')" 
      onmouseover="document.bgColor='#6495ed'">CornflowerBlue </A></TD>
    <TD align=middle bgColor=#666666 height=10><A 
      href="javascript:pick('#666666')" 
      onmouseover="document.bgColor='#666666'">gray40 </A></TD>
    <TD align=middle bgColor=#668b8b height=10><A 
      href="javascript:pick('#668b8b')" 
      onmouseover="document.bgColor='#668b8b'">PaleTurquoise4 </A></TD>
    <TD align=middle bgColor=#66cd00 height=10><A 
      href="javascript:pick('#66cd00')" 
      onmouseover="document.bgColor='#66cd00'">chartreuse3 </A></TD>
    <TD align=middle bgColor=#66cdaa height=10><A 
      href="javascript:pick('#66cdaa')" 
      onmouseover="document.bgColor='#66cdaa'">medium </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#66cdaa height=10><A 
      href="javascript:pick('#66cdaa')" 
      onmouseover="document.bgColor='#66cdaa'">MediumAquamarine </A></TD>
    <TD align=middle bgColor=#68228b height=10><A 
      href="javascript:pick('#68228b')" 
      onmouseover="document.bgColor='#68228b'">DarkOrchid4 </A></TD>
    <TD align=middle bgColor=#68838b height=10><A 
      href="javascript:pick('#68838b')" 
      onmouseover="document.bgColor='#68838b'">LightBlue4 </A></TD>
    <TD align=middle bgColor=#6959cd height=10><A 
      href="javascript:pick('#6959cd')" 
      onmouseover="document.bgColor='#6959cd'">SlateBlue3 </A></TD>
    <TD align=middle bgColor=#696969 height=10><A 
      href="javascript:pick('#696969')" 
      onmouseover="document.bgColor='#696969'">DimGray </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#696969 height=10><A 
      href="javascript:pick('#696969')" 
      onmouseover="document.bgColor='#696969'">gray41 </A></TD>
    <TD align=middle bgColor=#698b22 height=10><A 
      href="javascript:pick('#698b22')" 
      onmouseover="document.bgColor='#698b22'">OliveDrab4 </A></TD>
    <TD align=middle bgColor=#698b69 height=10><A 
      href="javascript:pick('#698b69')" 
      onmouseover="document.bgColor='#698b69'">DarkSeaGreen4 </A></TD>
    <TD align=middle bgColor=#6a5acd height=10><A 
      href="javascript:pick('#6a5acd')" 
      onmouseover="document.bgColor='#6a5acd'">SlateBlue </A></TD>
    <TD align=middle bgColor=#6b6b6b height=10><A 
      href="javascript:pick('#6b6b6b')" 
      onmouseover="document.bgColor='#6b6b6b'">gray42 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#6b8e23 height=10><A 
      href="javascript:pick('#6b8e23')" 
      onmouseover="document.bgColor='#6b8e23'">OliveDrab </A></TD>
    <TD align=middle bgColor=#6c7b8b height=10><A 
      href="javascript:pick('#6c7b8b')" 
      onmouseover="document.bgColor='#6c7b8b'">SlateGray4 </A></TD>
    <TD align=middle bgColor=#6ca6cd height=10><A 
      href="javascript:pick('#6ca6cd')" 
      onmouseover="document.bgColor='#6ca6cd'">SkyBlue3 </A></TD>
    <TD align=middle bgColor=#6e6e6e height=10><A 
      href="javascript:pick('#6e6e6e')" 
      onmouseover="document.bgColor='#6e6e6e'">gray43 </A></TD>
    <TD align=middle bgColor=#6e7b8b height=10><A 
      href="javascript:pick('#6e7b8b')" 
      onmouseover="document.bgColor='#6e7b8b'">LightSteelBlue4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#6e8b3d height=10><A 
      href="javascript:pick('#6e8b3d')" 
      onmouseover="document.bgColor='#6e8b3d'">DarkOliveGreen4 </A></TD>
    <TD align=middle bgColor=#707070 height=10><A 
      href="javascript:pick('#707070')" 
      onmouseover="document.bgColor='#707070'">gray44 </A></TD>
    <TD align=middle bgColor=#708090 height=10><A 
      href="javascript:pick('#708090')" 
      onmouseover="document.bgColor='#708090'">SlateGray </A></TD>
    <TD align=middle bgColor=#737373 height=10><A 
      href="javascript:pick('#737373')" 
      onmouseover="document.bgColor='#737373'">gray45 </A></TD>
    <TD align=middle bgColor=#757575 height=10><A 
      href="javascript:pick('#757575')" 
      onmouseover="document.bgColor='#757575'">gray46 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#76ee00 height=10><A 
      href="javascript:pick('#76ee00')" 
      onmouseover="document.bgColor='#76ee00'">chartreuse2 </A></TD>
    <TD align=middle bgColor=#76eec6 height=10><A 
      href="javascript:pick('#76eec6')" 
      onmouseover="document.bgColor='#76eec6'">aquamarine2 </A></TD>
    <TD align=middle bgColor=#778899 height=10><A 
      href="javascript:pick('#778899')" 
      onmouseover="document.bgColor='#778899'">LightSlateGray </A></TD>
    <TD align=middle bgColor=#787878 height=10><A 
      href="javascript:pick('#787878')" 
      onmouseover="document.bgColor='#787878'">gray47 </A></TD>
    <TD align=middle bgColor=#79cdcd height=10><A 
      href="javascript:pick('#79cdcd')" 
      onmouseover="document.bgColor='#79cdcd'">DarkSlateGray3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#7a378b height=10><A 
      href="javascript:pick('#7a378b')" 
      onmouseover="document.bgColor='#7a378b'">MediumOrchid4 </A></TD>
    <TD align=middle bgColor=#7a67ee height=10><A 
      href="javascript:pick('#7a67ee')" 
      onmouseover="document.bgColor='#7a67ee'">SlateBlue2 </A></TD>
    <TD align=middle bgColor=#7a7a7a height=10><A 
      href="javascript:pick('#7a7a7a')" 
      onmouseover="document.bgColor='#7a7a7a'">gray48 </A></TD>
    <TD align=middle bgColor=#7a8b8b height=10><A 
      href="javascript:pick('#7a8b8b')" 
      onmouseover="document.bgColor='#7a8b8b'">LightCyan4 </A></TD>
    <TD align=middle bgColor=#7ac5cd height=10><A 
      href="javascript:pick('#7ac5cd')" 
      onmouseover="document.bgColor='#7ac5cd'">CadetBlue3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#7b68ee height=10><A 
      href="javascript:pick('#7b68ee')" 
      onmouseover="document.bgColor='#7b68ee'">MediumSlateBlue </A></TD>
    <TD align=middle bgColor=#7ccd7c height=10><A 
      href="javascript:pick('#7ccd7c')" 
      onmouseover="document.bgColor='#7ccd7c'">PaleGreen3 </A></TD>
    <TD align=middle bgColor=#7cfc00 height=10><A 
      href="javascript:pick('#7cfc00')" 
      onmouseover="document.bgColor='#7cfc00'">LawnGreen </A></TD>
    <TD align=middle bgColor=#7d26cd height=10><A 
      href="javascript:pick('#7d26cd')" 
      onmouseover="document.bgColor='#7d26cd'">purple3 </A></TD>
    <TD align=middle bgColor=#7d7d7d height=10><A 
      href="javascript:pick('#7d7d7d')" 
      onmouseover="document.bgColor='#7d7d7d'">gray49 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#7ec0ee height=10><A 
      href="javascript:pick('#7ec0ee')" 
      onmouseover="document.bgColor='#7ec0ee'">SkyBlue2 </A></TD>
    <TD align=middle bgColor=#7f7f7f height=10><A 
      href="javascript:pick('#7f7f7f')" 
      onmouseover="document.bgColor='#7f7f7f'">gray50 </A></TD>
    <TD align=middle bgColor=#7fff00 height=10><A 
      href="javascript:pick('#7fff00')" 
      onmouseover="document.bgColor='#7fff00'">chartreuse1 </A></TD>
    <TD align=middle bgColor=#7fffd4 height=10><A 
      href="javascript:pick('#7fffd4')" 
      onmouseover="document.bgColor='#7fffd4'">aquamarine1 </A></TD>
    <TD align=middle bgColor=#828282 height=10><A 
      href="javascript:pick('#828282')" 
      onmouseover="document.bgColor='#828282'">gray51 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#836fff height=10><A 
      href="javascript:pick('#836fff')" 
      onmouseover="document.bgColor='#836fff'">SlateBlue1 </A></TD>
    <TD align=middle bgColor=#838b83 height=10><A 
      href="javascript:pick('#838b83')" 
      onmouseover="document.bgColor='#838b83'">honeydew4 </A></TD>
    <TD align=middle bgColor=#838b8b height=10><A 
      href="javascript:pick('#838b8b')" 
      onmouseover="document.bgColor='#838b8b'">azure4 </A></TD>
    <TD align=middle bgColor=#8470ff height=10><A 
      href="javascript:pick('#8470ff')" 
      onmouseover="document.bgColor='#8470ff'">LightSlateBlue </A></TD>
    <TD align=middle bgColor=#858585 height=10><A 
      href="javascript:pick('#858585')" 
      onmouseover="document.bgColor='#858585'">gray52 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#878787 height=10><A 
      href="javascript:pick('#878787')" 
      onmouseover="document.bgColor='#878787'">gray53 </A></TD>
    <TD align=middle bgColor=#87ceeb height=10><A 
      href="javascript:pick('#87ceeb')" 
      onmouseover="document.bgColor='#87ceeb'">SkyBlue </A></TD>
    <TD align=middle bgColor=#87cefa height=10><A 
      href="javascript:pick('#87cefa')" 
      onmouseover="document.bgColor='#87cefa'">LightSkyBlue </A></TD>
    <TD align=middle bgColor=#87ceff height=10><A 
      href="javascript:pick('#87ceff')" 
      onmouseover="document.bgColor='#87ceff'">SkyBlue1 </A></TD>
    <TD align=middle bgColor=#8968cd height=10><A 
      href="javascript:pick('#8968cd')" 
      onmouseover="document.bgColor='#8968cd'">MediumPurple3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8a2be2 height=10><A 
      href="javascript:pick('#8a2be2')" 
      onmouseover="document.bgColor='#8a2be2'">BlueViolet </A></TD>
    <TD align=middle bgColor=#8a8a8a height=10><A 
      href="javascript:pick('#8a8a8a')" 
      onmouseover="document.bgColor='#8a8a8a'">gray54 </A></TD>
    <TD align=middle bgColor=#8b0000 height=10><A 
      href="javascript:pick('#8b0000')" 
      onmouseover="document.bgColor='#8b0000'">red4 </A></TD>
    <TD align=middle bgColor=#8b008b height=10><A 
      href="javascript:pick('#8b008b')" 
      onmouseover="document.bgColor='#8b008b'">magenta4 </A></TD>
    <TD align=middle bgColor=#8b0a50 height=10><A 
      href="javascript:pick('#8b0a50')" 
      onmouseover="document.bgColor='#8b0a50'">DeepPink4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b1a1a height=10><A 
      href="javascript:pick('#8b1a1a')" 
      onmouseover="document.bgColor='#8b1a1a'">firebrick4 </A></TD>
    <TD align=middle bgColor=#8b1c62 height=10><A 
      href="javascript:pick('#8b1c62')" 
      onmouseover="document.bgColor='#8b1c62'">maroon4 </A></TD>
    <TD align=middle bgColor=#8b2252 height=10><A 
      href="javascript:pick('#8b2252')" 
      onmouseover="document.bgColor='#8b2252'">VioletRed4 </A></TD>
    <TD align=middle bgColor=#8b2323 height=10><A 
      href="javascript:pick('#8b2323')" 
      onmouseover="document.bgColor='#8b2323'">brown4 </A></TD>
    <TD align=middle bgColor=#8b2500 height=10><A 
      href="javascript:pick('#8b2500')" 
      onmouseover="document.bgColor='#8b2500'">OrangeRed4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b3626 height=10><A 
      href="javascript:pick('#8b3626')" 
      onmouseover="document.bgColor='#8b3626'">tomato4 </A></TD>
    <TD align=middle bgColor=#8b3a3a height=10><A 
      href="javascript:pick('#8b3a3a')" 
      onmouseover="document.bgColor='#8b3a3a'">IndianRed4 </A></TD>
    <TD align=middle bgColor=#8b3a62 height=10><A 
      href="javascript:pick('#8b3a62')" 
      onmouseover="document.bgColor='#8b3a62'">HotPink4 </A></TD>
    <TD align=middle bgColor=#8b3e2f height=10><A 
      href="javascript:pick('#8b3e2f')" 
      onmouseover="document.bgColor='#8b3e2f'">coral4 </A></TD>
    <TD align=middle bgColor=#8b4500 height=10><A 
      href="javascript:pick('#8b4500')" 
      onmouseover="document.bgColor='#8b4500'">DarkOrange4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b4513 height=10><A 
      href="javascript:pick('#8b4513')" 
      onmouseover="document.bgColor='#8b4513'">SaddleBrown </A></TD>
    <TD align=middle bgColor=#8b4726 height=10><A 
      href="javascript:pick('#8b4726')" 
      onmouseover="document.bgColor='#8b4726'">sienna4 </A></TD>
    <TD align=middle bgColor=#8b475d height=10><A 
      href="javascript:pick('#8b475d')" 
      onmouseover="document.bgColor='#8b475d'">PaleVioletRed4 </A></TD>
    <TD align=middle bgColor=#8b4789 height=10><A 
      href="javascript:pick('#8b4789')" 
      onmouseover="document.bgColor='#8b4789'">orchid4 </A></TD>
    <TD align=middle bgColor=#8b4c39 height=10><A 
      href="javascript:pick('#8b4c39')" 
      onmouseover="document.bgColor='#8b4c39'">salmon4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b5742 height=10><A 
      href="javascript:pick('#8b5742')" 
      onmouseover="document.bgColor='#8b5742'">LightSalmon4 </A></TD>
    <TD align=middle bgColor=#8b5a00 height=10><A 
      href="javascript:pick('#8b5a00')" 
      onmouseover="document.bgColor='#8b5a00'">orange4 </A></TD>
    <TD align=middle bgColor=#8b5a2b height=10><A 
      href="javascript:pick('#8b5a2b')" 
      onmouseover="document.bgColor='#8b5a2b'">tan4 </A></TD>
    <TD align=middle bgColor=#8b5f65 height=10><A 
      href="javascript:pick('#8b5f65')" 
      onmouseover="document.bgColor='#8b5f65'">LightPink4 </A></TD>
    <TD align=middle bgColor=#8b636c height=10><A 
      href="javascript:pick('#8b636c')" 
      onmouseover="document.bgColor='#8b636c'">pink4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b6508 height=10><A 
      href="javascript:pick('#8b6508')" 
      onmouseover="document.bgColor='#8b6508'">DarkGoldenrod4 </A></TD>
    <TD align=middle bgColor=#8b668b height=10><A 
      href="javascript:pick('#8b668b')" 
      onmouseover="document.bgColor='#8b668b'">plum4 </A></TD>
    <TD align=middle bgColor=#8b6914 height=10><A 
      href="javascript:pick('#8b6914')" 
      onmouseover="document.bgColor='#8b6914'">goldenrod4 </A></TD>
    <TD align=middle bgColor=#8b6969 height=10><A 
      href="javascript:pick('#8b6969')" 
      onmouseover="document.bgColor='#8b6969'">RosyBrown4 </A></TD>
    <TD align=middle bgColor=#8b7355 height=10><A 
      href="javascript:pick('#8b7355')" 
      onmouseover="document.bgColor='#8b7355'">burlywood4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b7500 height=10><A 
      href="javascript:pick('#8b7500')" 
      onmouseover="document.bgColor='#8b7500'">gold4 </A></TD>
    <TD align=middle bgColor=#8b7765 height=10><A 
      href="javascript:pick('#8b7765')" 
      onmouseover="document.bgColor='#8b7765'">PeachPuff4 </A></TD>
    <TD align=middle bgColor=#8b795e height=10><A 
      href="javascript:pick('#8b795e')" 
      onmouseover="document.bgColor='#8b795e'">NavajoWhite4 </A></TD>
    <TD align=middle bgColor=#8b7b8b height=10><A 
      href="javascript:pick('#8b7b8b')" 
      onmouseover="document.bgColor='#8b7b8b'">thistle4 </A></TD>
    <TD align=middle bgColor=#8b7d6b height=10><A 
      href="javascript:pick('#8b7d6b')" 
      onmouseover="document.bgColor='#8b7d6b'">bisque4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b7d7b height=10><A 
      href="javascript:pick('#8b7d7b')" 
      onmouseover="document.bgColor='#8b7d7b'">MistyRose4 </A></TD>
    <TD align=middle bgColor=#8b7e66 height=10><A 
      href="javascript:pick('#8b7e66')" 
      onmouseover="document.bgColor='#8b7e66'">wheat4 </A></TD>
    <TD align=middle bgColor=#8b814c height=10><A 
      href="javascript:pick('#8b814c')" 
      onmouseover="document.bgColor='#8b814c'">LightGoldenrod4 </A></TD>
    <TD align=middle bgColor=#8b8378 height=10><A 
      href="javascript:pick('#8b8378')" 
      onmouseover="document.bgColor='#8b8378'">AntiqueWhite4 </A></TD>
    <TD align=middle bgColor=#8b8386 height=10><A 
      href="javascript:pick('#8b8386')" 
      onmouseover="document.bgColor='#8b8386'">LavenderBlush4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b864e height=10><A 
      href="javascript:pick('#8b864e')" 
      onmouseover="document.bgColor='#8b864e'">khaki4 </A></TD>
    <TD align=middle bgColor=#8b8682 height=10><A 
      href="javascript:pick('#8b8682')" 
      onmouseover="document.bgColor='#8b8682'">seashell4 </A></TD>
    <TD align=middle bgColor=#8b8878 height=10><A 
      href="javascript:pick('#8b8878')" 
      onmouseover="document.bgColor='#8b8878'">cornsilk4 </A></TD>
    <TD align=middle bgColor=#8b8970 height=10><A 
      href="javascript:pick('#8b8970')" 
      onmouseover="document.bgColor='#8b8970'">LemonChiffon4 </A></TD>
    <TD align=middle bgColor=#8b8989 height=10><A 
      href="javascript:pick('#8b8989')" 
      onmouseover="document.bgColor='#8b8989'">snow4 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8b8b00 height=10><A 
      href="javascript:pick('#8b8b00')" 
      onmouseover="document.bgColor='#8b8b00'">yellow4 </A></TD>
    <TD align=middle bgColor=#8b8b7a height=10><A 
      href="javascript:pick('#8b8b7a')" 
      onmouseover="document.bgColor='#8b8b7a'">LightYellow4 </A></TD>
    <TD align=middle bgColor=#8b8b83 height=10><A 
      href="javascript:pick('#8b8b83')" 
      onmouseover="document.bgColor='#8b8b83'">ivory4 </A></TD>
    <TD align=middle bgColor=#8c8c8c height=10><A 
      href="javascript:pick('#8c8c8c')" 
      onmouseover="document.bgColor='#8c8c8c'">gray55 </A></TD>
    <TD align=middle bgColor=#8db6cd height=10><A 
      href="javascript:pick('#8db6cd')" 
      onmouseover="document.bgColor='#8db6cd'">LightSkyBlue3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#8deeee height=10><A 
      href="javascript:pick('#8deeee')" 
      onmouseover="document.bgColor='#8deeee'">DarkSlateGray2 </A></TD>
    <TD align=middle bgColor=#8ee5ee height=10><A 
      href="javascript:pick('#8ee5ee')" 
      onmouseover="document.bgColor='#8ee5ee'">CadetBlue2 </A></TD>
    <TD align=middle bgColor=#8f8f8f height=10><A 
      href="javascript:pick('#8f8f8f')" 
      onmouseover="document.bgColor='#8f8f8f'">gray56 </A></TD>
    <TD align=middle bgColor=#8fbc8f height=10><A 
      href="javascript:pick('#8fbc8f')" 
      onmouseover="document.bgColor='#8fbc8f'">DarkSeaGreen </A></TD>
    <TD align=middle bgColor=#90ee90 height=10><A 
      href="javascript:pick('#90ee90')" 
      onmouseover="document.bgColor='#90ee90'">PaleGreen2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#912cee height=10><A 
      href="javascript:pick('#912cee')" 
      onmouseover="document.bgColor='#912cee'">purple2 </A></TD>
    <TD align=middle bgColor=#919191 height=10><A 
      href="javascript:pick('#919191')" 
      onmouseover="document.bgColor='#919191'">gray57 </A></TD>
    <TD align=middle bgColor=#9370db height=10><A 
      href="javascript:pick('#9370db')" 
      onmouseover="document.bgColor='#9370db'">MediumPurple </A></TD>
    <TD align=middle bgColor=#9400d3 height=10><A 
      href="javascript:pick('#9400d3')" 
      onmouseover="document.bgColor='#9400d3'">DarkViolet </A></TD>
    <TD align=middle bgColor=#949494 height=10><A 
      href="javascript:pick('#949494')" 
      onmouseover="document.bgColor='#949494'">gray58 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#969696 height=10><A 
      href="javascript:pick('#969696')" 
      onmouseover="document.bgColor='#969696'">gray59 </A></TD>
    <TD align=middle bgColor=#96cdcd height=10><A 
      href="javascript:pick('#96cdcd')" 
      onmouseover="document.bgColor='#96cdcd'">PaleTurquoise3 </A></TD>
    <TD align=middle bgColor=#97ffff height=10><A 
      href="javascript:pick('#97ffff')" 
      onmouseover="document.bgColor='#97ffff'">DarkSlateGray1 </A></TD>
    <TD align=middle bgColor=#98f5ff height=10><A 
      href="javascript:pick('#98f5ff')" 
      onmouseover="document.bgColor='#98f5ff'">CadetBlue1 </A></TD>
    <TD align=middle bgColor=#98fb98 height=10><A 
      href="javascript:pick('#98fb98')" 
      onmouseover="document.bgColor='#98fb98'">PaleGreen </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#9932cc height=10><A 
      href="javascript:pick('#9932cc')" 
      onmouseover="document.bgColor='#9932cc'">DarkOrchid </A></TD>
    <TD align=middle bgColor=#999999 height=10><A 
      href="javascript:pick('#999999')" 
      onmouseover="document.bgColor='#999999'">gray60 </A></TD>
    <TD align=middle bgColor=#9a32cd height=10><A 
      href="javascript:pick('#9a32cd')" 
      onmouseover="document.bgColor='#9a32cd'">DarkOrchid3 </A></TD>
    <TD align=middle bgColor=#9ac0cd height=10><A 
      href="javascript:pick('#9ac0cd')" 
      onmouseover="document.bgColor='#9ac0cd'">LightBlue3 </A></TD>
    <TD align=middle bgColor=#9acd32 height=10><A 
      href="javascript:pick('#9acd32')" 
      onmouseover="document.bgColor='#9acd32'">YellowGreen </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#9aff9a height=10><A 
      href="javascript:pick('#9aff9a')" 
      onmouseover="document.bgColor='#9aff9a'">PaleGreen1 </A></TD>
    <TD align=middle bgColor=#9b30ff height=10><A 
      href="javascript:pick('#9b30ff')" 
      onmouseover="document.bgColor='#9b30ff'">purple1 </A></TD>
    <TD align=middle bgColor=#9bcd9b height=10><A 
      href="javascript:pick('#9bcd9b')" 
      onmouseover="document.bgColor='#9bcd9b'">DarkSeaGreen3 </A></TD>
    <TD align=middle bgColor=#9c9c9c height=10><A 
      href="javascript:pick('#9c9c9c')" 
      onmouseover="document.bgColor='#9c9c9c'">gray61 </A></TD>
    <TD align=middle bgColor=#9e9e9e height=10><A 
      href="javascript:pick('#9e9e9e')" 
      onmouseover="document.bgColor='#9e9e9e'">gray62 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#9f79ee height=10><A 
      href="javascript:pick('#9f79ee')" 
      onmouseover="document.bgColor='#9f79ee'">MediumPurple2 </A></TD>
    <TD align=middle bgColor=#9fb6cd height=10><A 
      href="javascript:pick('#9fb6cd')" 
      onmouseover="document.bgColor='#9fb6cd'">SlateGray3 </A></TD>
    <TD align=middle bgColor=#a020f0 height=10><A 
      href="javascript:pick('#a020f0')" 
      onmouseover="document.bgColor='#a020f0'">purple </A></TD>
    <TD align=middle bgColor=#a0522d height=10><A 
      href="javascript:pick('#a0522d')" 
      onmouseover="document.bgColor='#a0522d'">sienna </A></TD>
    <TD align=middle bgColor=#a1a1a1 height=10><A 
      href="javascript:pick('#a1a1a1')" 
      onmouseover="document.bgColor='#a1a1a1'">gray63 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#a2b5cd height=10><A 
      href="javascript:pick('#a2b5cd')" 
      onmouseover="document.bgColor='#a2b5cd'">LightSteelBlue3 </A></TD>
    <TD align=middle bgColor=#a2cd5a height=10><A 
      href="javascript:pick('#a2cd5a')" 
      onmouseover="document.bgColor='#a2cd5a'">DarkOliveGreen3 </A></TD>
    <TD align=middle bgColor=#a3a3a3 height=10><A 
      href="javascript:pick('#a3a3a3')" 
      onmouseover="document.bgColor='#a3a3a3'">gray64 </A></TD>
    <TD align=middle bgColor=#a4d3ee height=10><A 
      href="javascript:pick('#a4d3ee')" 
      onmouseover="document.bgColor='#a4d3ee'">LightSkyBlue2 </A></TD>
    <TD align=middle bgColor=#a6a6a6 height=10><A 
      href="javascript:pick('#a6a6a6')" 
      onmouseover="document.bgColor='#a6a6a6'">gray65 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#a8a8a8 height=10><A 
      href="javascript:pick('#a8a8a8')" 
      onmouseover="document.bgColor='#a8a8a8'">gray66 </A></TD>
    <TD align=middle bgColor=#ab82ff height=10><A 
      href="javascript:pick('#ab82ff')" 
      onmouseover="document.bgColor='#ab82ff'">MediumPurple1 </A></TD>
    <TD align=middle bgColor=#ababab height=10><A 
      href="javascript:pick('#ababab')" 
      onmouseover="document.bgColor='#ababab'">gray67 </A></TD>
    <TD align=middle bgColor=#adadad height=10><A 
      href="javascript:pick('#adadad')" 
      onmouseover="document.bgColor='#adadad'">gray68 </A></TD>
    <TD align=middle bgColor=#add8e6 height=10><A 
      href="javascript:pick('#add8e6')" 
      onmouseover="document.bgColor='#add8e6'">LightBlue </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#adff2f height=10><A 
      href="javascript:pick('#adff2f')" 
      onmouseover="document.bgColor='#adff2f'">GreenYellow </A></TD>
    <TD align=middle bgColor=#aeeeee height=10><A 
      href="javascript:pick('#aeeeee')" 
      onmouseover="document.bgColor='#aeeeee'">PaleTurquoise2 </A></TD>
    <TD align=middle bgColor=#afeeee height=10><A 
      href="javascript:pick('#afeeee')" 
      onmouseover="document.bgColor='#afeeee'">PaleTurquoise </A></TD>
    <TD align=middle bgColor=#b03060 height=10><A 
      href="javascript:pick('#b03060')" 
      onmouseover="document.bgColor='#b03060'">maroon </A></TD>
    <TD align=middle bgColor=#b0b0b0 height=10><A 
      href="javascript:pick('#b0b0b0')" 
      onmouseover="document.bgColor='#b0b0b0'">gray69 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#b0c4de height=10><A 
      href="javascript:pick('#b0c4de')" 
      onmouseover="document.bgColor='#b0c4de'">LightSteelBlue </A></TD>
    <TD align=middle bgColor=#b0e0e6 height=10><A 
      href="javascript:pick('#b0e0e6')" 
      onmouseover="document.bgColor='#b0e0e6'">PowderBlue </A></TD>
    <TD align=middle bgColor=#b0e2ff height=10><A 
      href="javascript:pick('#b0e2ff')" 
      onmouseover="document.bgColor='#b0e2ff'">LightSkyBlue1 </A></TD>
    <TD align=middle bgColor=#b22222 height=10><A 
      href="javascript:pick('#b22222')" 
      onmouseover="document.bgColor='#b22222'">firebrick </A></TD>
    <TD align=middle bgColor=#b23aee height=10><A 
      href="javascript:pick('#b23aee')" 
      onmouseover="document.bgColor='#b23aee'">DarkOrchid2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#b2dfee height=10><A 
      href="javascript:pick('#b2dfee')" 
      onmouseover="document.bgColor='#b2dfee'">LightBlue2 </A></TD>
    <TD align=middle bgColor=#b3b3b3 height=10><A 
      href="javascript:pick('#b3b3b3')" 
      onmouseover="document.bgColor='#b3b3b3'">gray70 </A></TD>
    <TD align=middle bgColor=#b3ee3a height=10><A 
      href="javascript:pick('#b3ee3a')" 
      onmouseover="document.bgColor='#b3ee3a'">OliveDrab2 </A></TD>
    <TD align=middle bgColor=#b452cd height=10><A 
      href="javascript:pick('#b452cd')" 
      onmouseover="document.bgColor='#b452cd'">MediumOrchid3 </A></TD>
    <TD align=middle bgColor=#b4cdcd height=10><A 
      href="javascript:pick('#b4cdcd')" 
      onmouseover="document.bgColor='#b4cdcd'">LightCyan3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#b4eeb4 height=10><A 
      href="javascript:pick('#b4eeb4')" 
      onmouseover="document.bgColor='#b4eeb4'">DarkSeaGreen2 </A></TD>
    <TD align=middle bgColor=#b5b5b5 height=10><A 
      href="javascript:pick('#b5b5b5')" 
      onmouseover="document.bgColor='#b5b5b5'">gray71 </A></TD>
    <TD align=middle bgColor=#b8860b height=10><A 
      href="javascript:pick('#b8860b')" 
      onmouseover="document.bgColor='#b8860b'">DarkGoldenrod </A></TD>
    <TD align=middle bgColor=#b8b8b8 height=10><A 
      href="javascript:pick('#b8b8b8')" 
      onmouseover="document.bgColor='#b8b8b8'">gray72 </A></TD>
    <TD align=middle bgColor=#b9d3ee height=10><A 
      href="javascript:pick('#b9d3ee')" 
      onmouseover="document.bgColor='#b9d3ee'">SlateGray2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ba55d3 height=10><A 
      href="javascript:pick('#ba55d3')" 
      onmouseover="document.bgColor='#ba55d3'">MediumOrchid </A></TD>
    <TD align=middle bgColor=#bababa height=10><A 
      href="javascript:pick('#bababa')" 
      onmouseover="document.bgColor='#bababa'">gray73 </A></TD>
    <TD align=middle bgColor=#bbffff height=10><A 
      href="javascript:pick('#bbffff')" 
      onmouseover="document.bgColor='#bbffff'">PaleTurquoise1 </A></TD>
    <TD align=middle bgColor=#bc8f8f height=10><A 
      href="javascript:pick('#bc8f8f')" 
      onmouseover="document.bgColor='#bc8f8f'">RosyBrown </A></TD>
    <TD align=middle bgColor=#bcd2ee height=10><A 
      href="javascript:pick('#bcd2ee')" 
      onmouseover="document.bgColor='#bcd2ee'">LightSteelBlue2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#bcee68 height=10><A 
      href="javascript:pick('#bcee68')" 
      onmouseover="document.bgColor='#bcee68'">DarkOliveGreen2 </A></TD>
    <TD align=middle bgColor=#bdb76b height=10><A 
      href="javascript:pick('#bdb76b')" 
      onmouseover="document.bgColor='#bdb76b'">DarkKhaki </A></TD>
    <TD align=middle bgColor=#bdbdbd height=10><A 
      href="javascript:pick('#bdbdbd')" 
      onmouseover="document.bgColor='#bdbdbd'">gray74 </A></TD>
    <TD align=middle bgColor=#bebebe height=10><A 
      href="javascript:pick('#bebebe')" 
      onmouseover="document.bgColor='#bebebe'">gray </A></TD>
    <TD align=middle bgColor=#bf3eff height=10><A 
      href="javascript:pick('#bf3eff')" 
      onmouseover="document.bgColor='#bf3eff'">DarkOrchid1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#bfbfbf height=10><A 
      href="javascript:pick('#bfbfbf')" 
      onmouseover="document.bgColor='#bfbfbf'">gray75 </A></TD>
    <TD align=middle bgColor=#bfefff height=10><A 
      href="javascript:pick('#bfefff')" 
      onmouseover="document.bgColor='#bfefff'">LightBlue1 </A></TD>
    <TD align=middle bgColor=#c0ff3e height=10><A 
      href="javascript:pick('#c0ff3e')" 
      onmouseover="document.bgColor='#c0ff3e'">OliveDrab1 </A></TD>
    <TD align=middle bgColor=#c1cdc1 height=10><A 
      href="javascript:pick('#c1cdc1')" 
      onmouseover="document.bgColor='#c1cdc1'">honeydew3 </A></TD>
    <TD align=middle bgColor=#c1cdcd height=10><A 
      href="javascript:pick('#c1cdcd')" 
      onmouseover="document.bgColor='#c1cdcd'">azure3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#c1ffc1 height=10><A 
      href="javascript:pick('#c1ffc1')" 
      onmouseover="document.bgColor='#c1ffc1'">DarkSeaGreen1 </A></TD>
    <TD align=middle bgColor=#c2c2c2 height=10><A 
      href="javascript:pick('#c2c2c2')" 
      onmouseover="document.bgColor='#c2c2c2'">gray76 </A></TD>
    <TD align=middle bgColor=#c4c4c4 height=10><A 
      href="javascript:pick('#c4c4c4')" 
      onmouseover="document.bgColor='#c4c4c4'">gray77 </A></TD>
    <TD align=middle bgColor=#c6e2ff height=10><A 
      href="javascript:pick('#c6e2ff')" 
      onmouseover="document.bgColor='#c6e2ff'">SlateGray1 </A></TD>
    <TD align=middle bgColor=#c71585 height=10><A 
      href="javascript:pick('#c71585')" 
      onmouseover="document.bgColor='#c71585'">MediumVioletRed </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#c7c7c7 height=10><A 
      href="javascript:pick('#c7c7c7')" 
      onmouseover="document.bgColor='#c7c7c7'">gray78 </A></TD>
    <TD align=middle bgColor=#c9c9c9 height=10><A 
      href="javascript:pick('#c9c9c9')" 
      onmouseover="document.bgColor='#c9c9c9'">gray79 </A></TD>
    <TD align=middle bgColor=#cae1ff height=10><A 
      href="javascript:pick('#cae1ff')" 
      onmouseover="document.bgColor='#cae1ff'">LightSteelBlue1 </A></TD>
    <TD align=middle bgColor=#caff70 height=10><A 
      href="javascript:pick('#caff70')" 
      onmouseover="document.bgColor='#caff70'">DarkOliveGreen1 </A></TD>
    <TD align=middle bgColor=#cccccc height=10><A 
      href="javascript:pick('#cccccc')" 
      onmouseover="document.bgColor='#cccccc'">gray80 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd0000 height=10><A 
      href="javascript:pick('#cd0000')" 
      onmouseover="document.bgColor='#cd0000'">red3 </A></TD>
    <TD align=middle bgColor=#cd00cd height=10><A 
      href="javascript:pick('#cd00cd')" 
      onmouseover="document.bgColor='#cd00cd'">magenta3 </A></TD>
    <TD align=middle bgColor=#cd1076 height=10><A 
      href="javascript:pick('#cd1076')" 
      onmouseover="document.bgColor='#cd1076'">DeepPink3 </A></TD>
    <TD align=middle bgColor=#cd2626 height=10><A 
      href="javascript:pick('#cd2626')" 
      onmouseover="document.bgColor='#cd2626'">firebrick3 </A></TD>
    <TD align=middle bgColor=#cd2990 height=10><A 
      href="javascript:pick('#cd2990')" 
      onmouseover="document.bgColor='#cd2990'">maroon3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd3278 height=10><A 
      href="javascript:pick('#cd3278')" 
      onmouseover="document.bgColor='#cd3278'">VioletRed3 </A></TD>
    <TD align=middle bgColor=#cd3333 height=10><A 
      href="javascript:pick('#cd3333')" 
      onmouseover="document.bgColor='#cd3333'">brown3 </A></TD>
    <TD align=middle bgColor=#cd3700 height=10><A 
      href="javascript:pick('#cd3700')" 
      onmouseover="document.bgColor='#cd3700'">OrangeRed3 </A></TD>
    <TD align=middle bgColor=#cd4f39 height=10><A 
      href="javascript:pick('#cd4f39')" 
      onmouseover="document.bgColor='#cd4f39'">tomato3 </A></TD>
    <TD align=middle bgColor=#cd5555 height=10><A 
      href="javascript:pick('#cd5555')" 
      onmouseover="document.bgColor='#cd5555'">IndianRed3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd5b45 height=10><A 
      href="javascript:pick('#cd5b45')" 
      onmouseover="document.bgColor='#cd5b45'">coral3 </A></TD>
    <TD align=middle bgColor=#cd5c5c height=10><A 
      href="javascript:pick('#cd5c5c')" 
      onmouseover="document.bgColor='#cd5c5c'">IndianRed </A></TD>
    <TD align=middle bgColor=#cd6090 height=10><A 
      href="javascript:pick('#cd6090')" 
      onmouseover="document.bgColor='#cd6090'">HotPink3 </A></TD>
    <TD align=middle bgColor=#cd6600 height=10><A 
      href="javascript:pick('#cd6600')" 
      onmouseover="document.bgColor='#cd6600'">DarkOrange3 </A></TD>
    <TD align=middle bgColor=#cd661d height=10><A 
      href="javascript:pick('#cd661d')" 
      onmouseover="document.bgColor='#cd661d'">chocolate3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd6839 height=10><A 
      href="javascript:pick('#cd6839')" 
      onmouseover="document.bgColor='#cd6839'">sienna3 </A></TD>
    <TD align=middle bgColor=#cd6889 height=10><A 
      href="javascript:pick('#cd6889')" 
      onmouseover="document.bgColor='#cd6889'">PaleVioletRed3 </A></TD>
    <TD align=middle bgColor=#cd69c9 height=10><A 
      href="javascript:pick('#cd69c9')" 
      onmouseover="document.bgColor='#cd69c9'">orchid3 </A></TD>
    <TD align=middle bgColor=#cd7054 height=10><A 
      href="javascript:pick('#cd7054')" 
      onmouseover="document.bgColor='#cd7054'">salmon3 </A></TD>
    <TD align=middle bgColor=#cd8162 height=10><A 
      href="javascript:pick('#cd8162')" 
      onmouseover="document.bgColor='#cd8162'">LightSalmon3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd8500 height=10><A 
      href="javascript:pick('#cd8500')" 
      onmouseover="document.bgColor='#cd8500'">orange3 </A></TD>
    <TD align=middle bgColor=#cd853f height=10><A 
      href="javascript:pick('#cd853f')" 
      onmouseover="document.bgColor='#cd853f'">tan3 </A></TD>
    <TD align=middle bgColor=#cd8c95 height=10><A 
      href="javascript:pick('#cd8c95')" 
      onmouseover="document.bgColor='#cd8c95'">LightPink3 </A></TD>
    <TD align=middle bgColor=#cd919e height=10><A 
      href="javascript:pick('#cd919e')" 
      onmouseover="document.bgColor='#cd919e'">pink3 </A></TD>
    <TD align=middle bgColor=#cd950c height=10><A 
      href="javascript:pick('#cd950c')" 
      onmouseover="document.bgColor='#cd950c'">DarkGoldenrod3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cd96cd height=10><A 
      href="javascript:pick('#cd96cd')" 
      onmouseover="document.bgColor='#cd96cd'">plum3 </A></TD>
    <TD align=middle bgColor=#cd9b1d height=10><A 
      href="javascript:pick('#cd9b1d')" 
      onmouseover="document.bgColor='#cd9b1d'">goldenrod3 </A></TD>
    <TD align=middle bgColor=#cd9b9b height=10><A 
      href="javascript:pick('#cd9b9b')" 
      onmouseover="document.bgColor='#cd9b9b'">RosyBrown3 </A></TD>
    <TD align=middle bgColor=#cdaa7d height=10><A 
      href="javascript:pick('#cdaa7d')" 
      onmouseover="document.bgColor='#cdaa7d'">burlywood3 </A></TD>
    <TD align=middle bgColor=#cdad00 height=10><A 
      href="javascript:pick('#cdad00')" 
      onmouseover="document.bgColor='#cdad00'">gold3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cdaf95 height=10><A 
      href="javascript:pick('#cdaf95')" 
      onmouseover="document.bgColor='#cdaf95'">PeachPuff3 </A></TD>
    <TD align=middle bgColor=#cdb38b height=10><A 
      href="javascript:pick('#cdb38b')" 
      onmouseover="document.bgColor='#cdb38b'">NavajoWhite3 </A></TD>
    <TD align=middle bgColor=#cdb5cd height=10><A 
      href="javascript:pick('#cdb5cd')" 
      onmouseover="document.bgColor='#cdb5cd'">thistle3 </A></TD>
    <TD align=middle bgColor=#cdb79e height=10><A 
      href="javascript:pick('#cdb79e')" 
      onmouseover="document.bgColor='#cdb79e'">bisque3 </A></TD>
    <TD align=middle bgColor=#cdb7b5 height=10><A 
      href="javascript:pick('#cdb7b5')" 
      onmouseover="document.bgColor='#cdb7b5'">MistyRose3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cdba96 height=10><A 
      href="javascript:pick('#cdba96')" 
      onmouseover="document.bgColor='#cdba96'">wheat3 </A></TD>
    <TD align=middle bgColor=#cdbe70 height=10><A 
      href="javascript:pick('#cdbe70')" 
      onmouseover="document.bgColor='#cdbe70'">LightGoldenrod3 </A></TD>
    <TD align=middle bgColor=#cdc0b0 height=10><A 
      href="javascript:pick('#cdc0b0')" 
      onmouseover="document.bgColor='#cdc0b0'">AntiqueWhite3 </A></TD>
    <TD align=middle bgColor=#cdc1c5 height=10><A 
      href="javascript:pick('#cdc1c5')" 
      onmouseover="document.bgColor='#cdc1c5'">LavenderBlush3 </A></TD>
    <TD align=middle bgColor=#cdc5bf height=10><A 
      href="javascript:pick('#cdc5bf')" 
      onmouseover="document.bgColor='#cdc5bf'">seashell3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cdc673 height=10><A 
      href="javascript:pick('#cdc673')" 
      onmouseover="document.bgColor='#cdc673'">khaki3 </A></TD>
    <TD align=middle bgColor=#cdc8b1 height=10><A 
      href="javascript:pick('#cdc8b1')" 
      onmouseover="document.bgColor='#cdc8b1'">cornsilk3 </A></TD>
    <TD align=middle bgColor=#cdc9a5 height=10><A 
      href="javascript:pick('#cdc9a5')" 
      onmouseover="document.bgColor='#cdc9a5'">LemonChiffon3 </A></TD>
    <TD align=middle bgColor=#cdc9c9 height=10><A 
      href="javascript:pick('#cdc9c9')" 
      onmouseover="document.bgColor='#cdc9c9'">snow3 </A></TD>
    <TD align=middle bgColor=#cdcd00 height=10><A 
      href="javascript:pick('#cdcd00')" 
      onmouseover="document.bgColor='#cdcd00'">yellow3 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#cdcdb4 height=10><A 
      href="javascript:pick('#cdcdb4')" 
      onmouseover="document.bgColor='#cdcdb4'">LightYellow3 </A></TD>
    <TD align=middle bgColor=#cdcdc1 height=10><A 
      href="javascript:pick('#cdcdc1')" 
      onmouseover="document.bgColor='#cdcdc1'">ivory3 </A></TD>
    <TD align=middle bgColor=#cfcfcf height=10><A 
      href="javascript:pick('#cfcfcf')" 
      onmouseover="document.bgColor='#cfcfcf'">gray81 </A></TD>
    <TD align=middle bgColor=#d02090 height=10><A 
      href="javascript:pick('#d02090')" 
      onmouseover="document.bgColor='#d02090'">VioletRed </A></TD>
    <TD align=middle bgColor=#d15fee height=10><A 
      href="javascript:pick('#d15fee')" 
      onmouseover="document.bgColor='#d15fee'">MediumOrchid2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#d1d1d1 height=10><A 
      href="javascript:pick('#d1d1d1')" 
      onmouseover="document.bgColor='#d1d1d1'">gray82 </A></TD>
    <TD align=middle bgColor=#d1eeee height=10><A 
      href="javascript:pick('#d1eeee')" 
      onmouseover="document.bgColor='#d1eeee'">LightCyan2 </A></TD>
    <TD align=middle bgColor=#d2b48c height=10><A 
      href="javascript:pick('#d2b48c')" 
      onmouseover="document.bgColor='#d2b48c'">tan </A></TD>
    <TD align=middle bgColor=#d3d3d3 height=10><A 
      href="javascript:pick('#d3d3d3')" 
      onmouseover="document.bgColor='#d3d3d3'">LightGray </A></TD>
    <TD align=middle bgColor=#d4d4d4 height=10><A 
      href="javascript:pick('#d4d4d4')" 
      onmouseover="document.bgColor='#d4d4d4'">gray83 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#d6d6d6 height=10><A 
      href="javascript:pick('#d6d6d6')" 
      onmouseover="document.bgColor='#d6d6d6'">gray84 </A></TD>
    <TD align=middle bgColor=#d8bfd8 height=10><A 
      href="javascript:pick('#d8bfd8')" 
      onmouseover="document.bgColor='#d8bfd8'">thistle </A></TD>
    <TD align=middle bgColor=#d9d9d9 height=10><A 
      href="javascript:pick('#d9d9d9')" 
      onmouseover="document.bgColor='#d9d9d9'">gray85 </A></TD>
    <TD align=middle bgColor=#da70d6 height=10><A 
      href="javascript:pick('#da70d6')" 
      onmouseover="document.bgColor='#da70d6'">orchid </A></TD>
    <TD align=middle bgColor=#daa520 height=10><A 
      href="javascript:pick('#daa520')" 
      onmouseover="document.bgColor='#daa520'">goldenrod </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#db7093 height=10><A 
      href="javascript:pick('#db7093')" 
      onmouseover="document.bgColor='#db7093'">pale </A></TD>
    <TD align=middle bgColor=#db7093 height=10><A 
      href="javascript:pick('#db7093')" 
      onmouseover="document.bgColor='#db7093'">PaleVioletRed </A></TD>
    <TD align=middle bgColor=#dbdbdb height=10><A 
      href="javascript:pick('#dbdbdb')" 
      onmouseover="document.bgColor='#dbdbdb'">gray86 </A></TD>
    <TD align=middle bgColor=#dcdcdc height=10><A 
      href="javascript:pick('#dcdcdc')" 
      onmouseover="document.bgColor='#dcdcdc'">gainsboro </A></TD>
    <TD align=middle bgColor=#dda0dd height=10><A 
      href="javascript:pick('#dda0dd')" 
      onmouseover="document.bgColor='#dda0dd'">plum </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#deb887 height=10><A 
      href="javascript:pick('#deb887')" 
      onmouseover="document.bgColor='#deb887'">burlywood </A></TD>
    <TD align=middle bgColor=#dedede height=10><A 
      href="javascript:pick('#dedede')" 
      onmouseover="document.bgColor='#dedede'">gray87 </A></TD>
    <TD align=middle bgColor=#e066ff height=10><A 
      href="javascript:pick('#e066ff')" 
      onmouseover="document.bgColor='#e066ff'">MediumOrchid1 </A></TD>
    <TD align=middle bgColor=#e0e0e0 height=10><A 
      href="javascript:pick('#e0e0e0')" 
      onmouseover="document.bgColor='#e0e0e0'">gray88 </A></TD>
    <TD align=middle bgColor=#e0eee0 height=10><A 
      href="javascript:pick('#e0eee0')" 
      onmouseover="document.bgColor='#e0eee0'">honeydew2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#e0eeee height=10><A 
      href="javascript:pick('#e0eeee')" 
      onmouseover="document.bgColor='#e0eeee'">azure2 </A></TD>
    <TD align=middle bgColor=#e0ffff height=10><A 
      href="javascript:pick('#e0ffff')" 
      onmouseover="document.bgColor='#e0ffff'">LightCyan1 </A></TD>
    <TD align=middle bgColor=#e3e3e3 height=10><A 
      href="javascript:pick('#e3e3e3')" 
      onmouseover="document.bgColor='#e3e3e3'">gray89 </A></TD>
    <TD align=middle bgColor=#e5e5e5 height=10><A 
      href="javascript:pick('#e5e5e5')" 
      onmouseover="document.bgColor='#e5e5e5'">gray90 </A></TD>
    <TD align=middle bgColor=#e6e6fa height=10><A 
      href="javascript:pick('#e6e6fa')" 
      onmouseover="document.bgColor='#e6e6fa'">lavender </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#e8e8e8 height=10><A 
      href="javascript:pick('#e8e8e8')" 
      onmouseover="document.bgColor='#e8e8e8'">gray91 </A></TD>
    <TD align=middle bgColor=#e9967a height=10><A 
      href="javascript:pick('#e9967a')" 
      onmouseover="document.bgColor='#e9967a'">DarkSalmon </A></TD>
    <TD align=middle bgColor=#ebebeb height=10><A 
      href="javascript:pick('#ebebeb')" 
      onmouseover="document.bgColor='#ebebeb'">gray92 </A></TD>
    <TD align=middle bgColor=#ededed height=10><A 
      href="javascript:pick('#ededed')" 
      onmouseover="document.bgColor='#ededed'">gray93 </A></TD>
    <TD align=middle bgColor=#ee0000 height=10><A 
      href="javascript:pick('#ee0000')" 
      onmouseover="document.bgColor='#ee0000'">red2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ee00ee height=10><A 
      href="javascript:pick('#ee00ee')" 
      onmouseover="document.bgColor='#ee00ee'">magenta2 </A></TD>
    <TD align=middle bgColor=#ee1289 height=10><A 
      href="javascript:pick('#ee1289')" 
      onmouseover="document.bgColor='#ee1289'">DeepPink2 </A></TD>
    <TD align=middle bgColor=#ee2c2c height=10><A 
      href="javascript:pick('#ee2c2c')" 
      onmouseover="document.bgColor='#ee2c2c'">firebrick2 </A></TD>
    <TD align=middle bgColor=#ee30a7 height=10><A 
      href="javascript:pick('#ee30a7')" 
      onmouseover="document.bgColor='#ee30a7'">maroon2 </A></TD>
    <TD align=middle bgColor=#ee3a8c height=10><A 
      href="javascript:pick('#ee3a8c')" 
      onmouseover="document.bgColor='#ee3a8c'">VioletRed2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ee3b3b height=10><A 
      href="javascript:pick('#ee3b3b')" 
      onmouseover="document.bgColor='#ee3b3b'">brown2 </A></TD>
    <TD align=middle bgColor=#ee4000 height=10><A 
      href="javascript:pick('#ee4000')" 
      onmouseover="document.bgColor='#ee4000'">OrangeRed2 </A></TD>
    <TD align=middle bgColor=#ee5c42 height=10><A 
      href="javascript:pick('#ee5c42')" 
      onmouseover="document.bgColor='#ee5c42'">tomato2 </A></TD>
    <TD align=middle bgColor=#ee6363 height=10><A 
      href="javascript:pick('#ee6363')" 
      onmouseover="document.bgColor='#ee6363'">IndianRed2 </A></TD>
    <TD align=middle bgColor=#ee6a50 height=10><A 
      href="javascript:pick('#ee6a50')" 
      onmouseover="document.bgColor='#ee6a50'">coral2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ee6aa7 height=10><A 
      href="javascript:pick('#ee6aa7')" 
      onmouseover="document.bgColor='#ee6aa7'">HotPink2 </A></TD>
    <TD align=middle bgColor=#ee7600 height=10><A 
      href="javascript:pick('#ee7600')" 
      onmouseover="document.bgColor='#ee7600'">DarkOrange2 </A></TD>
    <TD align=middle bgColor=#ee7621 height=10><A 
      href="javascript:pick('#ee7621')" 
      onmouseover="document.bgColor='#ee7621'">chocolate2 </A></TD>
    <TD align=middle bgColor=#ee7942 height=10><A 
      href="javascript:pick('#ee7942')" 
      onmouseover="document.bgColor='#ee7942'">sienna2 </A></TD>
    <TD align=middle bgColor=#ee799f height=10><A 
      href="javascript:pick('#ee799f')" 
      onmouseover="document.bgColor='#ee799f'">PaleVioletRed2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ee7ae9 height=10><A 
      href="javascript:pick('#ee7ae9')" 
      onmouseover="document.bgColor='#ee7ae9'">orchid2 </A></TD>
    <TD align=middle bgColor=#ee8262 height=10><A 
      href="javascript:pick('#ee8262')" 
      onmouseover="document.bgColor='#ee8262'">salmon2 </A></TD>
    <TD align=middle bgColor=#ee82ee height=10><A 
      href="javascript:pick('#ee82ee')" 
      onmouseover="document.bgColor='#ee82ee'">violet </A></TD>
    <TD align=middle bgColor=#ee9572 height=10><A 
      href="javascript:pick('#ee9572')" 
      onmouseover="document.bgColor='#ee9572'">LightSalmon2 </A></TD>
    <TD align=middle bgColor=#ee9a00 height=10><A 
      href="javascript:pick('#ee9a00')" 
      onmouseover="document.bgColor='#ee9a00'">orange2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ee9a49 height=10><A 
      href="javascript:pick('#ee9a49')" 
      onmouseover="document.bgColor='#ee9a49'">tan2 </A></TD>
    <TD align=middle bgColor=#eea2ad height=10><A 
      href="javascript:pick('#eea2ad')" 
      onmouseover="document.bgColor='#eea2ad'">LightPink2 </A></TD>
    <TD align=middle bgColor=#eea9b8 height=10><A 
      href="javascript:pick('#eea9b8')" 
      onmouseover="document.bgColor='#eea9b8'">pink2 </A></TD>
    <TD align=middle bgColor=#eead0e height=10><A 
      href="javascript:pick('#eead0e')" 
      onmouseover="document.bgColor='#eead0e'">DarkGoldenrod2 </A></TD>
    <TD align=middle bgColor=#eeaeee height=10><A 
      href="javascript:pick('#eeaeee')" 
      onmouseover="document.bgColor='#eeaeee'">plum2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#eeb422 height=10><A 
      href="javascript:pick('#eeb422')" 
      onmouseover="document.bgColor='#eeb422'">goldenrod2 </A></TD>
    <TD align=middle bgColor=#eeb4b4 height=10><A 
      href="javascript:pick('#eeb4b4')" 
      onmouseover="document.bgColor='#eeb4b4'">RosyBrown2 </A></TD>
    <TD align=middle bgColor=#eec591 height=10><A 
      href="javascript:pick('#eec591')" 
      onmouseover="document.bgColor='#eec591'">burlywood2 </A></TD>
    <TD align=middle bgColor=#eec900 height=10><A 
      href="javascript:pick('#eec900')" 
      onmouseover="document.bgColor='#eec900'">gold2 </A></TD>
    <TD align=middle bgColor=#eecbad height=10><A 
      href="javascript:pick('#eecbad')" 
      onmouseover="document.bgColor='#eecbad'">PeachPuff2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#eecfa1 height=10><A 
      href="javascript:pick('#eecfa1')" 
      onmouseover="document.bgColor='#eecfa1'">NavajoWhite2 </A></TD>
    <TD align=middle bgColor=#eed2ee height=10><A 
      href="javascript:pick('#eed2ee')" 
      onmouseover="document.bgColor='#eed2ee'">thistle2 </A></TD>
    <TD align=middle bgColor=#eed5b7 height=10><A 
      href="javascript:pick('#eed5b7')" 
      onmouseover="document.bgColor='#eed5b7'">bisque2 </A></TD>
    <TD align=middle bgColor=#eed5d2 height=10><A 
      href="javascript:pick('#eed5d2')" 
      onmouseover="document.bgColor='#eed5d2'">MistyRose2 </A></TD>
    <TD align=middle bgColor=#eed8ae height=10><A 
      href="javascript:pick('#eed8ae')" 
      onmouseover="document.bgColor='#eed8ae'">wheat2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#eedc82 height=10><A 
      href="javascript:pick('#eedc82')" 
      onmouseover="document.bgColor='#eedc82'">LightGoldenrod2 </A></TD>
    <TD align=middle bgColor=#eedd82 height=10><A 
      href="javascript:pick('#eedd82')" 
      onmouseover="document.bgColor='#eedd82'">light </A></TD>
    <TD align=middle bgColor=#eedfcc height=10><A 
      href="javascript:pick('#eedfcc')" 
      onmouseover="document.bgColor='#eedfcc'">AntiqueWhite2 </A></TD>
    <TD align=middle bgColor=#eee0e5 height=10><A 
      href="javascript:pick('#eee0e5')" 
      onmouseover="document.bgColor='#eee0e5'">LavenderBlush2 </A></TD>
    <TD align=middle bgColor=#eee5de height=10><A 
      href="javascript:pick('#eee5de')" 
      onmouseover="document.bgColor='#eee5de'">seashell2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#eee685 height=10><A 
      href="javascript:pick('#eee685')" 
      onmouseover="document.bgColor='#eee685'">khaki2 </A></TD>
    <TD align=middle bgColor=#eee8aa height=10><A 
      href="javascript:pick('#eee8aa')" 
      onmouseover="document.bgColor='#eee8aa'">PaleGoldenrod </A></TD>
    <TD align=middle bgColor=#eee8cd height=10><A 
      href="javascript:pick('#eee8cd')" 
      onmouseover="document.bgColor='#eee8cd'">cornsilk2 </A></TD>
    <TD align=middle bgColor=#eee9bf height=10><A 
      href="javascript:pick('#eee9bf')" 
      onmouseover="document.bgColor='#eee9bf'">LemonChiffon2 </A></TD>
    <TD align=middle bgColor=#eee9e9 height=10><A 
      href="javascript:pick('#eee9e9')" 
      onmouseover="document.bgColor='#eee9e9'">snow2 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#eeee00 height=10><A 
      href="javascript:pick('#eeee00')" 
      onmouseover="document.bgColor='#eeee00'">yellow2 </A></TD>
    <TD align=middle bgColor=#eeeed1 height=10><A 
      href="javascript:pick('#eeeed1')" 
      onmouseover="document.bgColor='#eeeed1'">LightYellow2 </A></TD>
    <TD align=middle bgColor=#eeeee0 height=10><A 
      href="javascript:pick('#eeeee0')" 
      onmouseover="document.bgColor='#eeeee0'">ivory2 </A></TD>
    <TD align=middle bgColor=#f08080 height=10><A 
      href="javascript:pick('#f08080')" 
      onmouseover="document.bgColor='#f08080'">LightCoral </A></TD>
    <TD align=middle bgColor=#f0e68c height=10><A 
      href="javascript:pick('#f0e68c')" 
      onmouseover="document.bgColor='#f0e68c'">khaki </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#f0f0f0 height=10><A 
      href="javascript:pick('#f0f0f0')" 
      onmouseover="document.bgColor='#f0f0f0'">gray94 </A></TD>
    <TD align=middle bgColor=#f0f8ff height=10><A 
      href="javascript:pick('#f0f8ff')" 
      onmouseover="document.bgColor='#f0f8ff'">AliceBlue </A></TD>
    <TD align=middle bgColor=#f0fff0 height=10><A 
      href="javascript:pick('#f0fff0')" 
      onmouseover="document.bgColor='#f0fff0'">honeydew1 </A></TD>
    <TD align=middle bgColor=#f0ffff height=10><A 
      href="javascript:pick('#f0ffff')" 
      onmouseover="document.bgColor='#f0ffff'">azure1 </A></TD>
    <TD align=middle bgColor=#f2f2f2 height=10><A 
      href="javascript:pick('#f2f2f2')" 
      onmouseover="document.bgColor='#f2f2f2'">gray95 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#f4a460 height=10><A 
      href="javascript:pick('#f4a460')" 
      onmouseover="document.bgColor='#f4a460'">SandyBrown </A></TD>
    <TD align=middle bgColor=#f5deb3 height=10><A 
      href="javascript:pick('#f5deb3')" 
      onmouseover="document.bgColor='#f5deb3'">wheat </A></TD>
    <TD align=middle bgColor=#f5f5dc height=10><A 
      href="javascript:pick('#f5f5dc')" 
      onmouseover="document.bgColor='#f5f5dc'">beige </A></TD>
    <TD align=middle bgColor=#f5f5f5 height=10><A 
      href="javascript:pick('#f5f5f5')" 
      onmouseover="document.bgColor='#f5f5f5'">WhiteSmoke </A></TD>
    <TD align=middle bgColor=#f5fffa height=10><A 
      href="javascript:pick('#f5fffa')" 
      onmouseover="document.bgColor='#f5fffa'">MintCream </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#f7f7f7 height=10><A 
      href="javascript:pick('#f7f7f7')" 
      onmouseover="document.bgColor='#f7f7f7'">gray97 </A></TD>
    <TD align=middle bgColor=#f8f8ff height=10><A 
      href="javascript:pick('#f8f8ff')" 
      onmouseover="document.bgColor='#f8f8ff'">GhostWhite </A></TD>
    <TD align=middle bgColor=#fa8072 height=10><A 
      href="javascript:pick('#fa8072')" 
      onmouseover="document.bgColor='#fa8072'">salmon </A></TD>
    <TD align=middle bgColor=#faebd7 height=10><A 
      href="javascript:pick('#faebd7')" 
      onmouseover="document.bgColor='#faebd7'">AntiqueWhite </A></TD>
    <TD align=middle bgColor=#faf0e6 height=10><A 
      href="javascript:pick('#faf0e6')" 
      onmouseover="document.bgColor='#faf0e6'">linen </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#fafad2 height=10><A 
      href="javascript:pick('#fafad2')" 
      onmouseover="document.bgColor='#fafad2'">LightGoldenrodYellow </A></TD>
    <TD align=middle bgColor=#fafafa height=10><A 
      href="javascript:pick('#fafafa')" 
      onmouseover="document.bgColor='#fafafa'">gray98 </A></TD>
    <TD align=middle bgColor=#fcfcfc height=10><A 
      href="javascript:pick('#fcfcfc')" 
      onmouseover="document.bgColor='#fcfcfc'">gray99 </A></TD>
    <TD align=middle bgColor=#fdf5e6 height=10><A 
      href="javascript:pick('#fdf5e6')" 
      onmouseover="document.bgColor='#fdf5e6'">OldLace </A></TD>
    <TD align=middle bgColor=#ff0000 height=10><A 
      href="javascript:pick('#ff0000')" 
      onmouseover="document.bgColor='#ff0000'">red1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ff00ff height=10><A 
      href="javascript:pick('#ff00ff')" 
      onmouseover="document.bgColor='#ff00ff'">magenta </A></TD>
    <TD align=middle bgColor=#ff1493 height=10><A 
      href="javascript:pick('#ff1493')" 
      onmouseover="document.bgColor='#ff1493'">DeepPink1 </A></TD>
    <TD align=middle bgColor=#ff3030 height=10><A 
      href="javascript:pick('#ff3030')" 
      onmouseover="document.bgColor='#ff3030'">firebrick1 </A></TD>
    <TD align=middle bgColor=#ff34b3 height=10><A 
      href="javascript:pick('#ff34b3')" 
      onmouseover="document.bgColor='#ff34b3'">maroon1 </A></TD>
    <TD align=middle bgColor=#ff3e96 height=10><A 
      href="javascript:pick('#ff3e96')" 
      onmouseover="document.bgColor='#ff3e96'">VioletRed1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ff4040 height=10><A 
      href="javascript:pick('#ff4040')" 
      onmouseover="document.bgColor='#ff4040'">brown1 </A></TD>
    <TD align=middle bgColor=#ff4500 height=10><A 
      href="javascript:pick('#ff4500')" 
      onmouseover="document.bgColor='#ff4500'">OrangeRed1 </A></TD>
    <TD align=middle bgColor=#ff6347 height=10><A 
      href="javascript:pick('#ff6347')" 
      onmouseover="document.bgColor='#ff6347'">tomato1 </A></TD>
    <TD align=middle bgColor=#ff69b4 height=10><A 
      href="javascript:pick('#ff69b4')" 
      onmouseover="document.bgColor='#ff69b4'">HotPink </A></TD>
    <TD align=middle bgColor=#ff6a6a height=10><A 
      href="javascript:pick('#ff6a6a')" 
      onmouseover="document.bgColor='#ff6a6a'">IndianRed1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ff6eb4 height=10><A 
      href="javascript:pick('#ff6eb4')" 
      onmouseover="document.bgColor='#ff6eb4'">HotPink1 </A></TD>
    <TD align=middle bgColor=#ff7256 height=10><A 
      href="javascript:pick('#ff7256')" 
      onmouseover="document.bgColor='#ff7256'">coral1 </A></TD>
    <TD align=middle bgColor=#ff7f00 height=10><A 
      href="javascript:pick('#ff7f00')" 
      onmouseover="document.bgColor='#ff7f00'">DarkOrange1 </A></TD>
    <TD align=middle bgColor=#ff7f24 height=10><A 
      href="javascript:pick('#ff7f24')" 
      onmouseover="document.bgColor='#ff7f24'">chocolate1 </A></TD>
    <TD align=middle bgColor=#ff7f50 height=10><A 
      href="javascript:pick('#ff7f50')" 
      onmouseover="document.bgColor='#ff7f50'">coral </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ff8247 height=10><A 
      href="javascript:pick('#ff8247')" 
      onmouseover="document.bgColor='#ff8247'">sienna1 </A></TD>
    <TD align=middle bgColor=#ff82ab height=10><A 
      href="javascript:pick('#ff82ab')" 
      onmouseover="document.bgColor='#ff82ab'">PaleVioletRed1 </A></TD>
    <TD align=middle bgColor=#ff83fa height=10><A 
      href="javascript:pick('#ff83fa')" 
      onmouseover="document.bgColor='#ff83fa'">orchid1 </A></TD>
    <TD align=middle bgColor=#ff8c00 height=10><A 
      href="javascript:pick('#ff8c00')" 
      onmouseover="document.bgColor='#ff8c00'">DarkOrange </A></TD>
    <TD align=middle bgColor=#ff8c69 height=10><A 
      href="javascript:pick('#ff8c69')" 
      onmouseover="document.bgColor='#ff8c69'">salmon1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ffa07a height=10><A 
      href="javascript:pick('#ffa07a')" 
      onmouseover="document.bgColor='#ffa07a'">LightSalmon1 </A></TD>
    <TD align=middle bgColor=#ffa500 height=10><A 
      href="javascript:pick('#ffa500')" 
      onmouseover="document.bgColor='#ffa500'">orange1 </A></TD>
    <TD align=middle bgColor=#ffa54f height=10><A 
      href="javascript:pick('#ffa54f')" 
      onmouseover="document.bgColor='#ffa54f'">tan1 </A></TD>
    <TD align=middle bgColor=#ffaeb9 height=10><A 
      href="javascript:pick('#ffaeb9')" 
      onmouseover="document.bgColor='#ffaeb9'">LightPink1 </A></TD>
    <TD align=middle bgColor=#ffb5c5 height=10><A 
      href="javascript:pick('#ffb5c5')" 
      onmouseover="document.bgColor='#ffb5c5'">pink1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ffb6c1 height=10><A 
      href="javascript:pick('#ffb6c1')" 
      onmouseover="document.bgColor='#ffb6c1'">LightPink </A></TD>
    <TD align=middle bgColor=#ffb90f height=10><A 
      href="javascript:pick('#ffb90f')" 
      onmouseover="document.bgColor='#ffb90f'">DarkGoldenrod1 </A></TD>
    <TD align=middle bgColor=#ffbbff height=10><A 
      href="javascript:pick('#ffbbff')" 
      onmouseover="document.bgColor='#ffbbff'">plum1 </A></TD>
    <TD align=middle bgColor=#ffc0cb height=10><A 
      href="javascript:pick('#ffc0cb')" 
      onmouseover="document.bgColor='#ffc0cb'">pink </A></TD>
    <TD align=middle bgColor=#ffc125 height=10><A 
      href="javascript:pick('#ffc125')" 
      onmouseover="document.bgColor='#ffc125'">goldenrod1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ffc1c1 height=10><A 
      href="javascript:pick('#ffc1c1')" 
      onmouseover="document.bgColor='#ffc1c1'">RosyBrown1 </A></TD>
    <TD align=middle bgColor=#ffd39b height=10><A 
      href="javascript:pick('#ffd39b')" 
      onmouseover="document.bgColor='#ffd39b'">burlywood1 </A></TD>
    <TD align=middle bgColor=#ffd700 height=10><A 
      href="javascript:pick('#ffd700')" 
      onmouseover="document.bgColor='#ffd700'">gold1 </A></TD>
    <TD align=middle bgColor=#ffdab9 height=10><A 
      href="javascript:pick('#ffdab9')" 
      onmouseover="document.bgColor='#ffdab9'">PeachPuff1 </A></TD>
    <TD align=middle bgColor=#ffdead height=10><A 
      href="javascript:pick('#ffdead')" 
      onmouseover="document.bgColor='#ffdead'">NavajoWhite1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ffe1ff height=10><A 
      href="javascript:pick('#ffe1ff')" 
      onmouseover="document.bgColor='#ffe1ff'">thistle1 </A></TD>
    <TD align=middle bgColor=#ffe4b5 height=10><A 
      href="javascript:pick('#ffe4b5')" 
      onmouseover="document.bgColor='#ffe4b5'">moccasin </A></TD>
    <TD align=middle bgColor=#ffe4c4 height=10><A 
      href="javascript:pick('#ffe4c4')" 
      onmouseover="document.bgColor='#ffe4c4'">bisque1 </A></TD>
    <TD align=middle bgColor=#ffe4e1 height=10><A 
      href="javascript:pick('#ffe4e1')" 
      onmouseover="document.bgColor='#ffe4e1'">MistyRose1 </A></TD>
    <TD align=middle bgColor=#ffe7ba height=10><A 
      href="javascript:pick('#ffe7ba')" 
      onmouseover="document.bgColor='#ffe7ba'">wheat1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#ffebcd height=10><A 
      href="javascript:pick('#ffebcd')" 
      onmouseover="document.bgColor='#ffebcd'">BlanchedAlmond </A></TD>
    <TD align=middle bgColor=#ffec8b height=10><A 
      href="javascript:pick('#ffec8b')" 
      onmouseover="document.bgColor='#ffec8b'">LightGoldenrod1 </A></TD>
    <TD align=middle bgColor=#ffefd5 height=10><A 
      href="javascript:pick('#ffefd5')" 
      onmouseover="document.bgColor='#ffefd5'">PapayaWhip </A></TD>
    <TD align=middle bgColor=#ffefdb height=10><A 
      href="javascript:pick('#ffefdb')" 
      onmouseover="document.bgColor='#ffefdb'">AntiqueWhite1 </A></TD>
    <TD align=middle bgColor=#fff0f5 height=10><A 
      href="javascript:pick('#fff0f5')" 
      onmouseover="document.bgColor='#fff0f5'">LavenderBlush1 </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#fff5ee height=10><A 
      href="javascript:pick('#fff5ee')" 
      onmouseover="document.bgColor='#fff5ee'">seashell1 </A></TD>
    <TD align=middle bgColor=#fff68f height=10><A 
      href="javascript:pick('#fff68f')" 
      onmouseover="document.bgColor='#fff68f'">khaki1 </A></TD>
    <TD align=middle bgColor=#fff8dc height=10><A 
      href="javascript:pick('#fff8dc')" 
      onmouseover="document.bgColor='#fff8dc'">cornsilk1 </A></TD>
    <TD align=middle bgColor=#fffacd height=10><A 
      href="javascript:pick('#fffacd')" 
      onmouseover="document.bgColor='#fffacd'">LemonChiffon1 </A></TD>
    <TD align=middle bgColor=#fffaf0 height=10><A 
      href="javascript:pick('#fffaf0')" 
      onmouseover="document.bgColor='#fffaf0'">FloralWhite </A></TD></TR>
  <TR>
    <TD align=middle bgColor=#fffafa height=10><A 
      href="javascript:pick('#fffafa')" 
      onmouseover="document.bgColor='#fffafa'">snow1 </A></TD>
    <TD align=middle bgColor=#ffff00 height=10><A 
      href="javascript:pick('#ffff00')" 
      onmouseover="document.bgColor='#ffff00'">yellow1 </A></TD>
    <TD align=middle bgColor=#ffffe0 height=10><A 
      href="javascript:pick('#ffffe0')" 
      onmouseover="document.bgColor='#ffffe0'">LightYellow1 </A></TD>
    <TD align=middle bgColor=#fffff0 height=10><A 
      href="javascript:pick('#fffff0')" 
      onmouseover="document.bgColor='#fffff0'">ivory1 </A></TD>
    <TD align=middle bgColor=#ffffff height=10><A 
      href="javascript:pick('#ffffff')" 
      onmouseover="document.bgColor='#ffffff'">white </A></TD></TR></TBODY></TABLE></CENTER>
</BODY></HTML>
