<cfif thisTag.executionMode IS "end"><cfparam name="request.cfdev_combobox" default="0"><cfset request.cfdev_combobox=request.cfdev_combobox+1><cfset instance=request.cfdev_combobox><cfparam name="attributes.name" default=""><cfparam name="attributes.size" default=""><cfparam name="attributes.width" default=""><cfparam name="attributes.value" default=""><cfif cgi.user_agent does not contain "MSIE" and cgi.user_agent does not contain "Win"><input type=text size="<cfoutput>#attributes.size#</cfoutput>"><cfexit></cfif><cfif NOT Len(attributes.name)>
	<script language="javascript">
		alert("cf_combobox requires a name attribute.");
	</script>
	<cfset thisTag.generatedContent = "">
	<cfexit>
</cfif><cfif instance eq "1"><script language="javascript">
	var cfdev_combocount=0;
	var cfdev_fInitCombo=true;
	
	<cfif NOT IsDefined("attributes.manualresize")>window.onresize=cfdev_resizecombos;</cfif>
	
	function cfdev_resizecombos() {
		
		var oText;
		var oSelect;
		
		var obj;
		var x;
		var y;

		cfdev_fInitCombo=false;
		
		for(var i=1;i<=cfdev_combocount;i++) {	
			x=0;
			y=0;
			oText=eval("document.all.oCFDEVComboText"+i);
			oSelect=eval("document.all.oCFDEVComboSelect"+i);
			obj=oText;

			while(obj.tagName!="BODY") {
				x+=obj.offsetLeft;
				y+=obj.offsetTop;
				obj=obj.offsetParent;
			}	
	
			if(cfdev_fInitCombo) {
				oText.style.width=oText.offsetWidth-16;
				oText.style.marginRight=16;
			}
					
			oSelect.style.left=x;
			oSelect.style.top=y;
			oSelect.style.width=oText.offsetWidth+16;
	
			oSelect.style.clip="rect(0,"+(oText.offsetWidth+18)+","+(oText.offsetHeight)+","+(oText.offsetWidth-2)+")";
			oSelect.style.display="block";
			
			oSelect.selectedIndex=-1;
		}
	}
	function cfdev_updatecombo(instance) {
		var oText=eval("document.all.oCFDEVComboText"+instance);
		var oSelect=eval("document.all.oCFDEVComboSelect"+instance);
		var tr=oText.createTextRange();
		tr.text=oSelect.options[oSelect.selectedIndex].value;
		tr.expand("textedit");
		tr.select();
		oSelect.selectedIndex=-1;		
	}
	function cfdev_combocheckloaded(interactive) {
		if(document.readyState=="complete") {
			cfdev_resizecombos();
		}
		else if(document.readyState=="interactive") {
			if(!interactive) cfdev_resizecombos();
			setTimeout("cfdev_combocheckloaded(true)",100);
		}
		else {
			setTimeout("cfdev_combocheckloaded(false)",100);
		}
	}
	
	cfdev_combocheckloaded(false);
</script></cfif><cfoutput><input type=text <cfif Len(attributes.width)>style="width:#attributes.width#;" </cfif><cfif Len(attributes.size)>size="#attributes.size#" </cfif>name="#attributes.name#" id="oCFDEVComboText#instance#" value="#attributes.value#"><select onchange="cfdev_updatecombo(#instance#);" id="oCFDEVComboSelect#instance#" size="1" style="position:absolute;display:none;"></cfoutput>
<cfoutput>#thisTag.generatedContent#</cfoutput>
</select><script language="javascript">
	cfdev_combocount=<cfoutput>#instance#</cfoutput>;
</script><cfset thisTag.generatedContent = ""></cfif>