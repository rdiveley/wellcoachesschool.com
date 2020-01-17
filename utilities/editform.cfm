
<cfset formlen = #rows#>
<cfset Positions=''>
<cfset Positions=#Form.positions#>

<cfloop index="fieldx" from="1" to="#formlen#">

		<Cfif ListFind(#positions#,#fieldx#)>
		<cfelse>
			<cfoutput><p><font color="black">You do not have a position <strong>#fieldx#</strong> Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p></cfoutput>
			<cfabort>
		</Cfif> 
		<cfif Evaluate("form."&"label_#fieldx#") neq "" AND Evaluate("form."&"name_#fieldx#") eq "">
			<cfoutput><p><font color="black">You have not entered a fieldname for the field <strong>#Evaluate("form."&"label_#fieldx#")#</strong> Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p></cfoutput>
			<cfabort>
		</cfif>
		
		<cfif Evaluate("form."&"name_#fieldx#") neq "" AND Evaluate("form."&"type_#fieldx#") eq "">
			<cfoutput><p><font color="black">You have not selected a field type for the field <strong>#Evaluate("form."&"name_#fieldx#")#</strong>. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p></cfoutput>
			<cfabort>
		</cfif>

		<cfif Evaluate("form."&"validation_#fieldx#") neq "No" AND Evaluate("form."&"message_#fieldx#") eq "">
			<cfoutput><p><font color="black">You have selected <strong>#Evaluate("form."&"label_#fieldx#")#</strong> as a required field but have not indicated an error message for that field. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify.</font></p></cfoutput>
			<cfabort>
		</cfif>

</cfloop>

<cffile action="delete" file="#application.uploadpath#\scripts\#form.filename#.cfm">

<!--- form tag --->
	<cfset thistag="<cfoutput><cfif isdefined('url.message')><strong>">
	<cfset thistag="#ThisTag#Your email has been sent.  We will answer you shortly.</strong><br><br></cfif>">
	<cfset thistag="#ThisTag#<cfform action='../scripts/saveit.cfm' method='post' enctype='multipart/form-data' scriptSrc='../CFIDE/scripts/cfform.js'>">
	<cfset thistag="#ThisTag#<table cellpadding=0 cellspacing=0 border=1 width=100%>">
	
	<cffile action="append" file="#application.uploadpath#\scripts\#form.filename#.cfm"
	 output="#thisTag#"
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
<cfset fieldTypes=''>
<cfset validations=''>
<cfset messages=''>
<cfset fieldvalues=''>

<cfloop index="fieldx" from="1" to="#formlen#">
	<cfset fieldZ=ListFind(#Positions#,#FieldX#)>
	<cfif Evaluate("form."&"name_#fieldZ#") neq "">
		<cfset flabel = Evaluate("form."&"label_#fieldZ#")>
		<cfset flabel=replace(flabel,",","|","ALL")>
		<cfif #trim(flabel)# is ''><cfset flabel="none"></cfif>
		<cfset labels=listappend(#labels#,#flabel#)>
		
		<cfset fname = Evaluate("form."&"name_#fieldZ#")>
		<cfset fname=replace(fname,",","","ALL")>
		<cfset fields=listappend(#fields#,#fname#)>
		
		<cfset ftype = Evaluate("form."&"type_#fieldZ#")>
		<cfset fieldtypes=listappend(#fieldtypes#,#ftype#)>
		
		<cfif Evaluate("form."&"value_#fieldZ#") neq "">	
			<cfset fvalue = Evaluate("form."&"value_#fieldZ#")>
		<cfelse>	
			<cfset fvalue = " ">
		</cfif>
		<cfset xfvalue=replace(#fvalue#,",","^","ALL")>
		<cfif xfvalue is ""><cfset xfvalue="none"></cfif>
		<cfset fieldvalues=ListAppend(#fieldvalues#,#xfvalue#)>
		
		<cfset fvalidation = Evaluate("form."&"validation_#fieldZ#")>
		<cfset validations=ListAppend(#validations#,#fvalidation#)>
		
		<cfset fmessage = Evaluate("form."&"message_#fieldZ#")>
		<cfset xfmessage=replace(#fmessage#,",","^","ALL")>
		<cfif xfmessage is ""><cfset xfmessage="none"></cfif>
		<cfset messages=ListAppend(#messages#,#xfmessage#)>
		
		<cfswitch expression="#Ftype#">
		<cfcase value="dropdown">
			<cfif #listlen(fvalue)# lt 2>
				Error in dropdown - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas and that you have not used a comma within a value.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td><strong>#replace(fLabel,'|',',','All')#:</strong></td><td><cfselect name=""#fname#"">">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<option value=""#trim(ThisValue)#"">#trim(ThisValue)#</option>">
				</cfloop>
				<cfset AppendValue="#AppendValue#</cfselect></td></tr>">
			</cfif>
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="checkbox">
			<cfif #listlen(fvalue)# lt 2>
				Error in checkbox <cfoutput>#replace(fLabel,'|',',','All')#</cfoutput> - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas and that you have not used a comma within a value.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td><strong>#replace(fLabel,'|',',','All')#:</strong></td><td>">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<cfinput type=checkbox name=""#Fname#"" value=""#trim(ThisValue)#"" required=""#fvalidation#"" message=""#Fmessage#""> #trim(ThisValue)#<br>">
				</cfloop>
			</cfif>
			<cfset AppendValue="#AppendValue#</td></tr>">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="radio">
			<cfif #listlen(fvalue)# lt 2>
				Error in radio button field - not enough values - must have at least 2. Please go <a href="javascript:window.history.go(-1)">back</a> and rectify and make sure the values you entered are separated by commas and that you have not used a comma within a value.<p>
				<cfabort>
			<cfelse>
				<cfset AppendValue="<tr><td><strong>#replace(fLabel,'|',',','All')#:</strong></td><td>">
				<cfloop list="#fvalue#" index="ThisValue">
					<cfset AppendValue="#AppendValue#<cfinput type=radio name=""#Fname#"" value=""#trim(ThisValue)#"" required=""#fvalidation#"" message=""#Fmessage#""> #trim(ThisValue)#<br>">
				</cfloop>
			</cfif>
			<cfset AppendValue="#AppendValue#</td></tr>">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#AppendValue#"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="textarea">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<tr><td><strong>#replace(fLabel,'|',',','All')#</strong></td><td><textarea name=""#fname#"" rows=""5"" cols=""20"">#fvalue#</textarea></td></tr>"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="hidden">
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<input type=""#Ftype#"" name=""#fname#"" value=""#fvalue#"">"
			addnewline="Yes">
		</cfcase>
		
		<cfcase value="Grid">
			<cfset gridVAlues="<tr><td colspan=2><strong>#replace(fLabel,'|',',','All')#:</strong></td></tr><tr><td colspan=2>">
			<cfset fieldtype=ListGetAt(#fvalue#,1,"`")>
			<cfset columns=ListGetAt(#fvalue#,2,"`")>
			<cfset rows=ListGetAt(#fvalue#,3,"`")>
			<cfset ColumnCount=ListLen(#columns#,"{")>
			<cfset rowCount=ListLen(#rows#,"{")>
				
			<cfset gridValues="#gridValues#<table border=0><tr><td></td>">
			<cfset tColumns=#ColumnCount# + 1>
			
			<cfloop index="columnlabels" list="#columns#" delimiters="{">
				<cfset gridValues="#gridValues#<Td>#columnLabels#</td>">
			</cfloop>
			<cfset gridValues="#gridValues#</tr>">
			
			<cfset xRowCount=0>
			<cfloop index="rowlabels" list="#Rows#" delimiters="{">
				<cfset xRowCount=#xRowCount# + 1>
				<cfset gridValues="#gridValues#<tr><td>#rowlabels#</td>">
				<cfloop index="NoOfColumns" from="1" to="#ColumnCount#">
					<cfset gridValues="#gridValues#<td>">
					<cfif #fieldtype# is "checkbox">
						<cfset gridValues="#gridValues#<input type='checkbox' name='#Fname#_#NoOfColumns#_#xRowCount#'>">
					<cfelseif #fieldtype# is "radio">
						<cfset gridValues="#gridValues#<input type='radio' name='#Fname#_#NoOfColumns#_#xRowCount#'>">
					<cfelseif #fieldtype# is "text">
						<cfset gridValues="#gridValues#<input type='text' name='#Fname#_#NoOfColumns#_#xRowCount#' size=20>">
					<cfelseif #fieldtype# is "textarea">
						<cfset gridValues="#gridValues#<textarea name='#Fname#_#NoOfColumns#_#xRowCount#' cols=20 rows=5></textarea>">
					</cfif>
					<cfset gridValues="#gridValues#</td>">
				</cfloop>
				<cfset gridValues="#gridValues#</tr>">
			</cfloop>
		<cfset gridValues="#gridValues#</table></td></tr>">
		<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="#gridValues#"
			addnewline="Yes">
		
		</cfcase>
		
		<cfdefaultcase>
			<cffile action="APPEND" file="#application.uploadpath#\scripts\#form.filename#.cfm" 
			output="<tr><td><strong>#replace(fLabel,'|',',','All')#</strong></td><td><cfinput type=""#Ftype#"" name=""#fname#"" size=""25"" maxlength=""250"" value=""#fvalue#"" required=""#fvalidation#"" message=""#Fmessage#""></td></tr>"
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
<cfset validations=replace(#validations#,",","~","ALL")>
<cfset messages=replace(#messages#,",","~","ALL")>
<cfset fieldvalues=replace(#fieldvalues#,",","~","ALL")>
<cfset fieldtypes=replace(#fieldtypes#,",","~","ALL")>
<cfset form.formInstructions=replace(#form.formInstructions#,",","~","ALL")>
<cfif #form.formInstructions# is ''><cfset form.formInstructions="none"></cfif>
<cfif #form.emailresults# is ''><cfset form.emailresults="none"></cfif>

<cfset XMLFields="formfilename,formtitle,emailresults,savetodatabase,labels,fields,formInstructions,validations,messages,fieldvalues,fieldtypes,multiformname,positions">

<cfset form.Positions=#ListSort(positions,"numeric")#>

<cfinvoke component="#application.websitepath#.utilities.xmlhandler" 
	method="UpdateXMLRecord" returnvariable="FormID">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFilename" value="forms">
	<cfinvokeargument name="XMLFields" value="#XMLFields#">
	<cfinvokeargument name="XMLFieldData" value="#form.Filename#,#Form.ThisFormName#,#form.emailresults#,#form.savetodatabase#,#labels#,#fields#,#form.formInstructions#,#validations#,#messages#,#fieldvalues#,#fieldtypes#,#form.tclass#,#replace(form.positions,',','~','ALL')#">
	<cfinvokeargument name="XMLIDField" value="formID">
	<cfinvokeargument name="XMLIDVAlue" value="#form.formID#">
</cfinvoke>

<div align="center"><h2>Form Creator - Success</h2>
<p><strong>Your form has been created. <a href="adminheader.cfm?action=formcreator">Click here</a> to return to the Form Creator</strong></p></div>

<cfset formname=#form.filename#>
<cfinclude template="../scripts/viewform.cfm">

