function SelectColor(PageName,PageControl) {
	winStr = PageName + "?PageControl=" + PageControl;
	win = window.open(winStr, 'subwin' , 'width=500,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}

function TableWzd(TemplateID,PositionID,ID) {
	winStr = '../jscripts/index.htm?TypeID=' + ID + '&ThisForm=' + TemplateID + '&ThisContent=' + PositionID;
	win = window.open(winStr, 'subwin' , 'width=500,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}

function AddForm(TemplateID,PositionID,ID) {
	winStr = '../common/formcreator/index.cfm?TypeID=' + ID + '&ThisForm=' + TemplateID + '&ThisContent=' + PositionID;
	win = window.open(winStr, 'subwin' , 'width=610,height=350,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}

function AddText(TemplateID,PositionID,ID,WebSiteID,SID) {
	winStr = 'addtext.cfm?TypeID=' + ID + '&ThisForm=' + TemplateID + '&ThisContent=' + PositionID + '&t=' + WebSiteID+'&lid='+SID;
	win = window.open(winStr, 'subwin' , 'width=500,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}
function AddScript(TemplateID,PositionID,ID,ScriptType,WebSiteID,SID) {
	winStr = 'addscript.cfm?TypeID=' + ID + '&ThisForm=' + TemplateID + '&ThisContent=' + PositionID+'&ScriptType='+ScriptType + '&t=' + WebSiteID+'&lid='+SID;
	win = window.open(winStr, 'subwin' , 'width=500,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}

function MakeFont() {
	winStr = 'makefont.cfm';
	win = window.open(winStr, 'subwin' , 'width=500,height=300,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}

function PREVIEW(Add)
{
var txt=thisform.D19.value;

preview=open("blank.htm","DisplayWindow","toolbar=no,directories=no,menubar=no,location=no,directories=no");
preview.document.write(txt);
preview.document.write("<p><center>");
preview.document.write("<a href=javascript:window.close();>Close This Window</a></center>");
}


function UNFONT()
{
var newtext=checkforbracket("</font>");
document.thisform.D19.value = newtext;
}

function NOTEXT()
{
document.thisform.D19.value += ("");
}

function P(form)
{
var newtext=checkforbracket("<P>\n");
document.thisform.D19.value= newtext;
}
function CENTER(form)
{
var newtext=checkforbracket("<P ALIGN=CENTER>\n");
document.thisform.D19.value= newtext;
}

function RIGHT(form)
{
var newtext=checkforbracket("<P ALIGN=RIGHT>\n");
document.thisform.D19.value= newtext;
}
function LEFT(form)
{
var newtext=checkforbracket("<P ALIGN=LEFT>\n");
document.thisform.D19.value= newtext;
}
function JUSTIFIED(form)
{
var newtext=checkforbracket("<P ALIGN=JUSTIFIED>\n");
document.thisform.D19.value= newtext;
}
function BR(form)
{
var newtext=checkforbracket("<BR>\n");
document.thisform.D19.value = newtext;
}

function HR(form)
{
var newtext=checkforbracket("<HR>\n");
document.thisform.D19.value = newtext;
}

function B(form)
{
var newtext=checkforbracket("<B>");
document.thisform.D19.value = newtext;
}

function UNBOLD(form)
{
var newtext=checkforbracket("</B>\n");
document.thisform.D19.value = newtext;
}

function I(form)
{
var newtext=checkforbracket("<I>");
document.thisform.D19.value = newtext;
}

function UNITALIC(form)
{
var newtext=checkforbracket("</i>\n");
document.thisform.D19.value = newtext;
}

function U(form)
{
var newtext=checkforbracket("<U>");
document.thisform.D19.value = newtext;
}

function UNUNDERLINE(form)
{
var newtext=checkforbracket("</U>\n");
document.thisform.D19.value = newtext;
}

function BLOCKQUOTE(form)
{
var newtext=checkforbracket("<BLOCKQUOTE>");
document.thisform.D19.value = newtext;
}

function UNBLOCKQUOTE(form)
{
var newtext=checkforbracket("</BLOCKQUOTE>\n");
document.thisform.D19.value = newtext;
}

function NONBREAKINGSPACE(form) {
var newtext=checkforbracket('&nbsp;');
document.thisform.D19.value = newtext;
}

function Header(form)
{

if (form.Headers.options[form.Headers.selectedIndex].value==1) 
	H1(form)
if (form.Headers.options[form.Headers.selectedIndex].value==2) 
	H2(form)
if (form.Headers.options[form.Headers.selectedIndex].value==3) 
	H3(form)
if (form.Headers.options[form.Headers.selectedIndex].value==4) 
	H4(form)
if (form.Headers.options[form.Headers.selectedIndex].value==5) 
	H5(form)
if (form.Headers.options[form.Headers.selectedIndex].value==6) 
	H6(form)
	
if (form.Headers.options[form.Headers.selectedIndex].value==7) 
	UNH1(form)
if (form.Headers.options[form.Headers.selectedIndex].value==8) 
	UNH2(form)
if (form.Headers.options[form.Headers.selectedIndex].value==9) 
	UNH3(form)
if (form.Headers.options[form.Headers.selectedIndex].value==10) 
	UNH4(form)
if (form.Headers.options[form.Headers.selectedIndex].value==11) 
	UNH5(form)
if (form.Headers.options[form.Headers.selectedIndex].value==12) 
	UNH6(form)
}
function H1(form)
{
var newtext=checkforbracket("<H1>");
document.thisform.D19.value = newtext;
}

function H2(form)
{
var newtext=checkforbracket("<H2>");
document.thisform.D19.value = newtext;
}

function H3(form)
{
var newtext=checkforbracket("<H3>");
document.thisform.D19.value = newtext;
}

function H4(form)
{
var newtext=checkforbracket("<H4>");
document.thisform.D19.value = newtext;
}

function H5(form)
{
var newtext=checkforbracket("<H5>");
document.thisform.D19.value = newtext;
}

function H6(form)
{
var newtext=checkforbracket("<H6>");
document.thisform.D19.value = newtext;
}

function UNH1(form)
{
var newtext=checkforbracket("</H1>\n");
document.thisform.D19.value = newtext;
}

function UNH2(form)
{
var newtext=checkforbracket("</H2>\n");
document.thisform.D19.value = newtext;
}

function UNH3(form)
{
var newtext=checkforbracket("</H3>\n");
document.thisform.D19.value = newtext;
}

function UNH4(form)
{
var newtext=checkforbracket("</H4>\n");
document.thisform.D19.value = newtext;
}

function UNH5(form)
{
var newtext=checkforbracket("</H5>\n");
document.thisform.D19.value = newtext;
}

function UNH6(form)
{
var newtext=checkforbracket("</H6>\n");
document.thisform.D19.value = newtext;
}

function UNP(form)
{
var newtext=checkforbracket("</p>\n");
document.thisform.D19.value = newtext;
}

function checkforbracket(text) {
	page=document.thisform.D19.value;
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