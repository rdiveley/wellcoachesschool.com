
<cfset formlen = #rows#>

<cfloop index="fieldx" from="1" to="#formlen#">

		<cfif Evaluate("form."&"label_#fieldx#") neq "" AND Evaluate("form."&"name_#fieldx#") eq "">
			<p><font color="yellow">Error in form label/ name. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p>
			<cfabort>
		</cfif>
		
		<cfif Evaluate("form."&"name_#fieldx#") neq "" AND Evaluate("form."&"type_#fieldx#") eq "">
			<p><font color="yellow">Error in form name/ type. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p>
			<cfabort>
		</cfif>

		<cfif Evaluate("form."&"validation_#fieldx#") neq "" AND Evaluate("form."&"message_#fieldx#") eq "">
			<p><font color="yellow">If you have selected that fields are required, there must be an error message for that field. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p>
			<cfabort>
		</cfif>

</cfloop>

<!--- form tag --->
	<cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="<cfoutput><<cfif isdefined('url.message')><<<strong>Your email has been sent.  We will answer you shortly.</strong><br><br></cfif> <cfform action=scripts/saveit.cfm method=post enctype=multipart/form-data scriptSrc=../CFIDE/scripts/cfform.js> <<table cellpadding=0 cellspacing=0 border=0 width=100%>"
	 addnewline="Yes">
<!--- required hidden fields ---> 
	 <cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="<input type=""hidden"" name=""SaveToDatabase"" value=""#form.SaveToDatabase#""><input type=""hidden"" name=""thisfilename"" value=""#form.filename#"">"
	 addnewline="Yes"> 
	 <cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="<input type=""hidden"" name=""EmailResults"" value=""#form.EmailResults#"">"
	 addnewline="Yes"> 
<!--- Form title and instructions --->
	<cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="<tr><td colspan=2><h2>#Form.ThisFormName#</h2></td></tr>"
	 addnewline="Yes">
	 <cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="<tr><td colspan=2>#Form.formInstructions#</td></tr>"
	 addnewline="Yes">
<!--- create the input tags --->
<cfset Labels=''>
<cfset Fields=''>

<cfloop index="fieldx" from="1" to="#formlen#">

	<cfif Evaluate("form."&"name_#fieldx#") neq "">
		<cfset flabel = Evaluate("form."&"label_#fieldx#")>
		<cfset labels=listappend(#labels#,#flabel#)>
		
		<cfset fname = Evaluate("form."&"name_#fieldx#")>
		<cfset fields=listappend(#fields#,#fname#)>
		
		<cfset ftype = Evaluate("form."&"type_#fieldx#")>

		<cfif Evaluate("form."&"value_#fieldx#") neq "">	
			<cfset fvalue = Evaluate("form."&"value_#fieldx#")>
		<cfelse>	
			<cfset fvalue = "">
		</cfif>
		<cfset fvalidation = Evaluate("form."&"validation_#fieldx#")>
		<cfset fmessage = Evaluate("form."&"message_#fieldx#")>

		<cfswitch expression="#Ftype#">
		<cfcase value="dropdown">
			<cfif #listlen(fvalue)# lt 2>
				Error in dropdown - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td>#fLabel#:</td><td><cfselect name=""#fname#"">">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<option value=""#ThisValue#"">#ThisValue#</option>">
				</cfloop>
				<cfset AppendValue="#AppendValue#</cfselect></td></tr>">
			</cfif>
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="checkbox">
			<cfif #listlen(fvalue)# lt 2>
				Error in checkbox field - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td>#fLabel#:</td><td>">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<cfinput type=checkbox name=""#Fname#"" value=""#ThisValue#"" required=""#fvalidation#"" message=""#Fmessage#""> #ThisValue#<br>">
				</cfloop>
			</cfif>
			<cfset AppendValue="#AppendValue#</td></tr>">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="radio">
			<cfif #listlen(fvalue)# lt 2>
				Error in radio button field - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td>#fLabel#:</td><td>">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<cfinput type=radio name=""#Fname#"" value=""#ThisValue#"" required=""#fvalidation#"" message=""#Fmessage#""> #ThisValue#<br>">
				</cfloop>
			</cfif>
			<cfset AppendValue="#AppendValue#</td></tr>">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="textarea">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<tr><td>#flabel#</td><td><textarea name=""#fname#"" rows=""5"" cols=""20"">#fvalue#</textarea></td></tr>"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="hidden">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<input type=""#Ftype#"" name=""#fname#"" value=""#fvalue#"">"
			addnewline="Yes">
		</cfcase>
		
		<cfdefaultcase>
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<tr><td>#flabel#</td><td><cfinput type=""#Ftype#"" name=""#fname#"" size=""25"" maxlength=""250"" value=""#fvalue#"" required=""#fvalidation#"" message=""#Fmessage#""></td></tr>"
			addnewline="Yes">
		</cfdefaultcase>
		
		</cfswitch>
		
	</cfif>
</cfloop>

<!--- form submit button tag --->
<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm"
 output="<tr><td></td><td><br><input type=""submit"" NAME=submit VALUE=""#form.SubmitButton#""></td></tr>" 
 addnewline="Yes">

 <!--- form end tag --->
<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" output="</table></cfform></cfoutput>" addnewline="Yes">

<cffile action="read" file="#application.uploadpath#\scripts\#form.filename#.cfm" variable="theForm">
<cfset newForm=replace(#theForm#,"<<<","<","ALL")>
<cfset newForm=replace(#newForm#,"<<","<","ALL")>
<cffile action="write" file="#application.uploadpath#\scripts\#form.filename#.cfm" output="#newForm#">

<cfset Labels=replace(#labels#,",","~","ALL")>
<cfset fields=replace(#fields#,",","~","ALL")>
<cfset form.formInstructions=replace(#form.formInstructions#,",","~","ALL")>
<cfif #form.formInstructions# is ''><cfset form.formInstructions="none"></cfif>
<cfif #form.emailresults# is ''><cfset form.emailresults="none"></cfif>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="insertXMLrecord" returnvariabl="NewFormID">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="forms">
	<cfinvokeargument name="XMLFields" value="formfilename,formtitle,emailresults,savetodatabase,labels,fields,formInstructions">
	<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#Form.ThisFormName#,#form.emailresults#,#form.savetodatabase#,#labels#,#fields#,#form.formInstructions#">
	<cfinvokeargument name="XMLIDField" value="formID">
</cfinvoke>

<div align="center"><h2>Form Creator - Success</h2>
<p><strong>Your form has been created and added to the drop down on the editor.</strong></p></div>

