
<!--- This template handles 
	Lists (Bulleted and Numbered
	Paragraph start with alignment
	Graphics with alignment
	Links
	Email Links
	--->

<cfinclude template="GetPath.cfm">
<cfinclude template="#HomePath#GetDSN.cfm">
<cfinclude template="#homepath##CommonPath#/breakvars.cfm">
<cfparam name="TypeID" default=0>
<cfparam name="TemplateID" default=0>
<cfparam name="PositionID" default=0>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Add Text</title>
<script language="JavaScript">
var listcount = 0;
var AddTxt='';

function checkforbracket(text) {
	page=window.opener.document.thisform.D19.value;
	var x=0; 
	var y=0; 
	x = page.indexOf("["); 
	y = page.indexOf("]"); 
	// Surround
	if (x != -1 && y!= -1 && x > y) {
		split1 = page.substring(0,y);
		split3 = page.substring(y+1,x);
		split5 = page.substring(x+1,page.length); 
		tReturn = split1+split3+split5;
			return tReturn
			// document[formName][fieldName].value=split1+split2+split3+split4+split5;
			text="";
			// window.opener.document.core.id.value="";
	}
	else {
		// Disallow cerebral 404; ] cursor
		if (x== -1 && y!= -1) {
			alert("I'm afraid I can't do that!");
			split1 = page.substring(0,y);
			split2 = page.substring(y+1,page.length); 
			tReturn = split1 + split2;
			return tReturn
			// document[formName][fieldName].value=split1 + split2;
			text="";
			// window.opener.document.core.id.value="";
		}
		else {
			// Insert
			if (x != -1 && y== -1) {
				split1 = page.substring(0,x);
				split2 = page.substring(x+1,page.length); 
			}
			// Replace
			if (x != -1 && y!= -1 && x < y) {
				split1 = page.substring(0,x);
				split2 = page.substring(y+1,page.length); 
			}
			// No cursor?  Paste before </BODY>
			if (x== -1 && y== -1) {
				split1 = page.substring(0,page.length);
				split2 = ''; 
			}
			tReturn = split1+text+split2;
			return tReturn
			text="";
			// window.opener.document.core.id.value="";
		}
	}

}

function NOTEXT()
{
document.Add.write.value += ("")
}

function AddToList(form,id) {
	if (id==1) {
		if (listcount==0) {
		form.choice2.value='<ul><li>' + form.choice.value + '</li>';
		listcount+=1
		}else{
		form.choice2.value+='<li>' + form.choice.value + '</li>';
		}
	}else{
		if (listcount==0) {
		form.choice2.value='<ol type=1><li>' + form.choice.value + '</li>';
		listcount+=1
		}else{
		form.choice2.value+='<li>' + form.choice.value + '</li>';
		}
	}
}

function SendThis(form) {
	var txt=form.choice.value;

<cfif #TypeID# is 1>
  var txt2 = form.txt2.value;
    if(txt =='')	{
		NOTEXT();
	}
    if(txt2 =='')	{
		NOTEXT();
	}else{
		AddTxt = ("<A HREF=MAILTO:" + txt + ">" + txt2 + "</A>\n");
	}
</cfif>

<cfif #TypeID# is 6>
	txt=document.forms[0].choice.options[document.forms[0].choice.selectedIndex].value ;
	if(txt!='normal') {
		AddTxt="<p align="+txt+">";        
	}else{
		AddTxt="<p>";
	}
</cfif>

<cfif #TypeID# is 9>
	var txt2=form.choice2.value;
	var txt3 =  document.forms[0].choice3.options[document.forms[0].choice3.selectedIndex].value ;
	var txt4 =   document.forms[0].choice4.options[document.forms[0].choice4.selectedIndex].value ;
 	if(txt!=''&&txt4=="NONE") {
		AddTxt="<a href=index.cfm?<cfoutput>#t#</cfoutput>&OutLink="+txt+">";
	}else{
		AddTxt="<a href=index.cfm?t="+txt4+">";
	}                       
 	if(txt2!='') {
		AddTxt+=txt2+"</a>"; 
	}else if(txt3!='NONE'){ 
		AddTxt+="<img src=../images/"+txt3+" border=0>"+"</a>"; 
	}

</cfif> 

<cfif #TypeID# is 11>
 	var txt2=form.choice2.value;
 	if(txt2!='') AddTxt=txt2+'</ul>';                          
</cfif> 

<cfif #TypeID# is 13>
	var txt2=form.choice2.value;
 	if(txt2!='') AddTxt=txt2+'</ol>';  
</cfif>

<cfif #TypeID# is 14>
	txt =  document.forms[0].choice.options[document.forms[0].choice.selectedIndex].value ;
	txt1 =  document.forms[0].choice1.options[document.forms[0].choice1.selectedIndex].value ;
	if(txt!='') AddTxt="<img src=<cfoutput>#ReturnPath#</cfoutput>/images/"+txt+" align=" + txt1 + ">"; 
</cfif>

<cfif #TypeID# is 16>
	var txt2=form.choice.value;
 	if(txt2!='') AddTxt=txt2;  
</cfif>

  if (window.opener && !window.opener.closed)
    window.opener.document.thisform.D19.value = window.opener.document.thisform.D19.value + AddTxt + '';
  window.close();
}
</script>
</head>

<body>
<cfif #TypeID# gt 0>

<form>
<input type="hidden" name="t" value="<cfoutput>#t#</cfoutput>">
<cfif #TypeID# is 16>
Enter the text:<br>
<textarea name=choice cols=30 rows=5></textarea><br>

</cfif>
<cfif #TypeID# is 1>
Enter the email address:<br>
<input type=text name=choice><br>
Enter the text for this email address:<br>
<input type=text name=txt2><br>

</cfif>
<cfif #TypeID# is 6>
Select positioning for this paragraph:<br>
<select name="choice">
	<option value="normal">Normal</option>
	<option value="left">Left</option>
	<option value="right">Right</option>
	<option value="center">Center</option>
	<option value="justify">Justified (IE Only)</option>
</select>
<!--- Paragraph --->
</cfif>

<cfif #TypeID# is 9>
If you are linking to a page inside your site<br>
select the page name you wish to link to<br>
<cfquery name="pages" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
	select pagename from pages
	where websiteid=#webSiteid#
	order by pagename
</cfquery>
<select name="choice4">
	<option value="NONE">None</option>
	<cfoutput query="Pages">
		<cfset PageID=#trim(Pagename)#>
		<cfinclude template="#homepath##commonpath#/newparams.cfm">
		<option value="#trim(t)#">#trim(Pagename)#</option>
	</cfoutput>
</select>
<br><br>
OR If you are linking to a page on another website<br>
type in the full URL (http://www.theothersite.com)<br>
URL: <input type=text name=choice>
<br>Type in the text for this link or select a graphic<br>
Text: <input type=text name=choice2>
<cfquery name="Graphics" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
	select * from webgraphics
	where websiteid = #websiteiD#
</cfquery>
or Grahpic: <select name="choice3">
		<option value="NONE">None</option>
	<cfoutput query="Graphics">
		<option value="#trim(filename)#">#trim(Description)#</option>
	</cfoutput>
</select>
<!--- Link --->
</cfif>

<cfif #TypeID# is 11>
Bulleted List: <input type=text name=choice>
<input type=button name=go value='Add To List' onClick=AddToList(this.form,1)>
<br>
<textarea name=choice2 rows=15></textarea>
<!--- Bulleted List --->
</cfif>

<cfif #TypeID# is 13>
Numbered List: <input type=text name=choice>
<input type=button name=go value='Add To List' onClick=AddToList(this.form,2)>
<br>
<textarea name=choice2 rows=15></textarea>
<!--- Numbered List --->
</cfif>

<cfif #TypeID# is 14>
<cfquery name="Graphics" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
	select * from webgraphics
	where websiteid = #websiteiD#
</cfquery>
Picture: <select name="choice">
	<cfoutput query="Graphics">
		<option value="#trim(filename)#">#trim(Description)#</option>
	</cfoutput>
</select>
Select the alignment of the picture:<br>
<select name="choice1">
	<option value="normal">Normal</option>
	<option value="left">Left</option>
	<option value="right">Right</option>
	<option value="center">Center</option>
</select>
<!--- Add an images --->
</cfif>

<input type="Button" name="SendIt" value="Save this text"  onClick="SendThis(this.form)">
</form>
<cfelse>

</cfif>
</body>
</html>
