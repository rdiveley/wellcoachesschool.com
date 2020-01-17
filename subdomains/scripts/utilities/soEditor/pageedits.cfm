<script language="JavaScript1.1">

function AddScript(form) {
	var txt= thisform.thescript.options[thisform.thescript.selectedIndex].value;
	var AddTxt="ScriptIs="+txt; 
	alert(AddTxt);
	soEditor.insertText("<" + AddTxt + ">","", false, true);
    //soEditor.FormCreator(AddTxt);
}
</script>

<table width="100%" align="CENTER" bgcolor="Silver" border=1>
<!--- <tr>
<td>
	<table width="100%" align="CENTER" bgcolor="Silver">
	<tr>
	<td><font face="Arial" size="2" color="Black"><b>Headers</b></font></td>
	<td><font face="Arial" size="2" color="Black"><b>Font Face</b></font></td>
	<td><font face="Arial" size="2" color="Black"><b>Font Size</b></font></td>
	<td valign=bottom>
	
	<a href="javascript:BR(this.form);"><img src="../Images/br.jpg" width=16 height=16 alt="" border="0"></A>
	<a href="javascript:HR(this.form);"><img src="../Images/HR.jpg" width=16 height=16 alt="" border="0"></A>
	<a href="javascript:B(this.form);"><img src="../Images/bld.jpg" width=16 height=16 alt="Bold" border="0"></a>
	<a href="javascript:I(this.form);"><img src="../Images/Itl.jpg" width=16 height=16 alt="Italic" border="0"></a>
	<a href="javascript:U(this.form);"><img src="../Images/UNDRLN.jpg" width=16 height=16 alt="Underline" border="0"></a>
	<a href="javascript:P(this.form);"><img src="../Images/paragraph.gif" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:LEFT(this.form);"><img src="../Images/Lft.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:CENTER(this.form);"><img src="../Images/cnt.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:JUSTIFIED(this.form);"><img src="../Images/JST.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:RIGHT(this.form);"><img src="../Images/Rt.jpg" width=16 height=16 alt="" border="0"></a>
	</td>
	</tr>
	<tr>
	<td><select name="Headers" onchange="Header(this.form)">
		 <option value="0" selected>None</option>
		 <option value="1">Header 1</option>
		 <option value="2">Header 2</option>
		 <option value="3">Header 3</option>
		 <option value="4">Header 4</option>
		 <option value="5">Header 5</option>
		 <option value="6">Header 5</option>
		 <option value="7">End Header 1</option>
		 <option value="8">End Header 2</option>
		 <option value="9">End Header 3</option>
		 <option value="10">End Header 4</option>
		 <option value="11">End Header 5</option>
		 <option value="12">End Header 5</option>
		 </select>
	</td>
	<td><select name="fontface" onchange="getfont(this.form)">
		 <option value="0" selected>None</option>
		 <option value="1">Serif</option>
		 <option value="2">Arial</option>
		 <option value="3">Courier New</option>
		 <option value="4">Comic Sans</option>
		 <option value="5">Times New Roman</option>
		 <option value="6">Verdana</option>
		 <option value="7">End Font</option>
		 </select>
	</td>
	<td>
	<select name="Body_font_size" onchange="getfontsize(this.form)">
		<option value="None" selected>None</option>
	    <option value="1">1</option>
	    <option value="2">2</option>
	    <option value="3">3</option>
	  <p></p>  <option value="4">4</option>
	    <option value="5">5</option>
	    <option value="6">6</option>
	    <option value="7">7</option>
	    </select>
	</td>
	
	<td valign=bottom NOWRAP>
	<a href="javascript:AddText('thisform','D19',9,<cfoutput>'#t#','#LID#');"><img src="../Images/anchor.jpg" width=16 height=16 alt="" border="0" onclick=></a>
	<a href="javascript:AddText('#ThisForm#','D19',1,'#t#','#LID#'</cfoutput>);"><img src="../Images/email.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:AddText('thisform','D19',11,<cfoutput>'#t#','#LID#'</cfoutput>);"><img src="../Images/Bullets.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:AddText('thisform','D19',13,<cfoutput>'#t#','#LID#'</cfoutput>);"><img src="../Images/numbered.jpg" width=16 height=16 alt="" border="0"></a>
	<a href="javascript:AddText('thisform','D19',14,<cfoutput>'#t#','#LID#'</cfoutput>);"><img src="../Images/icons.gif" width=16 height=16 alt="" border="0"></a>
	<input type="Image" name="" src="../Images/save.jpg" border="0" width="16" height="16" alt="">
	<img src="../Images/HELP.jpg" width=16 height=16 alt="" border="0">
	</td>
	</tr> --->
	
	<tr>
	<td colspan=4>
	<cfmodule template="../common/soeditor/soeditor_lite.cfm" 		
			form="thisform"
          	field="D19"
          	scriptpath="../common/soeditor/">
	</td>
	</tr>
	
	
	<tr>
	<td colspan="4" bgcolor="#d4d0c8">
	<cfoutput>
	<a href="javascript:AddForm('thisform','D19',1,1,'#t#','#LID#');"><img src="../Images/forms.jpg" width=40 height=16 alt="" border="0"></a>
	&nbsp;&nbsp;
	<img src="../images/SCRIPTS.jpg" width=70 height=16 alt="" border="0">
	<select name="thescript" size="1" onChange="AddScript('thisform')" class="inputs">
		<option value="001">News Feed from MoreOver.com</option>
		<option value="002">News Feed from Headliner</option>
		<option value="003">Weather Feed from the WeatherGuys</option>
		<option value="004">Weather Feed from Weather.com</option>
		<option value="005">Email Page to Friend</option>
		<option value="006">Search the Internet with Google</option>
		<option value="007">Yahoo Webrings</option>
		<option value="008">Request for Information</option>
		<option value="009">Request for Information Thank You</option>
		<option value="010">Guest Book</option>
		<option value="011">Guest Book Thank You</option>
		<option value="012">Site Map</option>
		<option value="149">Hit Counter</option>
		<option value=091>Newsletter Sign Up Script</option>
		<option value=013>Product Search</option>
		<option value=014>Product Search Results</option>
		<option value=103>Product Categories Listing Page</option>
		<option value=104>Product Items Listing Page</option>
		<option value=105>Product Notify Page</option>
		<option value=015>Product Check Out</option>
		<option value=017>Product View Cart, Check Out Buttons</option>
	</select>
	</cfoutput>
	</td>
	</tr>
	</table>
</td></tr></table>