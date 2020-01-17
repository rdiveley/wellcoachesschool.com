<cfparam name="rows" default="0">
<cfparam name="ThisFormName" default="">
<cfparam name="FormInstructions" default="">
<cfparam name="SaveToDatabase" default="0">
<cfparam name="EmailResults" default="#application.Email#">
<cfparam name="tClass" default="none">
<cfparam name="SubmitButton" default="Submit">
<cfparam name="formAction" default="list">
<cfparam name="FormID" default=0>

<script
language="JavaScript" src="../files/editor.js"></script>
	<script>
function GetEditor(form,tControl) {
	winStr = 'Editor.cfm?thisForm=' + form + '&thisContent=' + tControl;
	win = window.open(winStr, 'editwin' , 'width=640,height=420,menubar=no,toolbar=no,status=no,scrollbars=no,resizable=yes,titlebar=no,location=no');
	win.focus();
}
</script>

<cfset AllForms=queryNew("empty")>
<cfinvoke component="#application.websitepath#.utilities.xmlhandler" 
	method="getXMLRecords" returnvariable="AllForms">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="forms">	
</cfinvoke>
	
<cfif #formaction# is "delete">

		<cfset XMLFields="formid,formfilename,formtitle,emailresults,savetodatabase,labels,fields,formInstructions,validations,messages,fieldvalues,fieldtypes,multiformname,positions">

	<cfinvoke component="#application.websitepath#.utilities.xmlhandler" method="deleteXMLrecords">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="forms">
		<cfinvokeargument name="XMLFields" value="#XMLFields#">
		<cfinvokeargument name="XMLIDField" value="formID">
		<cfinvokeargument name="XMLIDValue" value="#formID#">
	</cfinvoke>
	<cflocation url="adminheader.cfm?action=formcreator">
</cfif>

<h2>Form Editor:</h2>
<cfif #Rows# is 0>
	<cfquery name="getForm" dbtype="query">
		select * from AllForms where FormID='#formid#'
	</cfquery>
	<cfoutput query="getForm">
		<cfset formrows=#ListLen(fields,"~")#>
		<cfset formfilename=#formfilename#>
		<cfset FormInstructions=#formInstructions#>
		<cfset SaveToDatabase=#savetodatabase#>
		<cfset EmailResults=#emailresults#>
		<cfset tClass=#multiformname#>
		<cfset ThisFormName=#formtitle#>
		<cfset labels=#labels#>
		<cfset fields=#fields#>
		<cfset validations=#validations#>
		<cfset messages=#messages#>
		<cfset fieldvalues=#fieldvalues#>
		<cfset fieldtypes=#fieldtypes#>
		<cfparam name="formAction" default="edit">
		<cfset FormID=#FormID#>
	</cfoutput>

	<cfform name="noOfRowsForm" action="adminheader.cfm?action=formeditor" method="post">
	<cfoutput>
	<input type="hidden" name="FormID" value="#formID#">
	<input type="hidden" name="formfilename" value="#formfilename#"></cfoutput>
		<table>
		<tr>
		<td valign=top>How many items will your form have?:</td> 
		<td valign=top><cfinput name="rows" type="text" value="#formrows#" size="5" maxlength="5" required="yes" message="Please enter the number of form items" validate="integer"></td>
		</tr>
		<tr>
		<td valign=top>Title of this form:<br>(will show on the page where the user fills out the form<br>and this will also be the subject of the email sent to you.)</td> 
		<td valign=top><cfinput name="ThisFormName" type="text" value="#replace(ThisFormName,"~",",","ALL")#" size="35" maxlength="250" required="yes" message="Please enter a form name"></td>
		</tr>
		<tr>
		<td valign=top>Form Instructions:<br>(will show on the page where the user fills out the form)<br>
		<a href=javascript:GetEditor('noOfRowsForm','formInstructions')>Click here to enter the text for this section. </a>
		</td> 
		<td valign=top><textarea name="formInstructions" cols="35" rows="5"><cfoutput>#replace(FormInstructions,"~",",","ALL")#</cfoutput></textarea></td>
		</tr>
		<tr>
		<td valign="top">If this is a multipage form, select the form name that preceeds this form</td>
		<cfoutput><td valign="top"><cfselect name="tClass">
		<option value="none">None</option>
		<cfloop query="allforms">
			<option value="#formfilename#"<cfif #formfilename# eq #tClass#> selected</cfif>>#replace(formtitle,"~",",","ALL")#</option>
		</cfloop>
		</cfselect></td></cfoutput>
		</tr>
		<tr>
		<td valign="top">Please enter the email address to mail the form results to:</td>
		<td valign=top><cfinput name="EmailResults" type="text" value="#EmailResults#" required="yes" message="Please enter the email address"></td>
		</tr>
		<tr>
		<td valign=top>Do you wish to save the results of this form for later viewing?</td>
		<td valign="top"><cfif #SaveToDatabase# is 0>
		<cfinput type="radio" name="SaveToDatabase" value="1">Yes
		<cfinput type="radio" name="SaveToDatabase" value="1" checked>No
		<cfelse>
		<cfinput type="radio" name="SaveToDatabase" value="1" checked>Yes
		<cfinput type="radio" name="SaveToDatabase" value="1">No
		</cfif>
		</td>
		</tr>
		<tr><td valign=top>What do you want the submit button to say?:</td>
		<td valign=top><cfinput name="submitbutton" type="text" value="#SubmitButton#" required="yes" message="Please enter the text for the submit button"></td></tr>
		<tr><td valign=top></td><td valign=top><input type="submit" name="gocreateform" value="Go"></td></tr>
		</table>
	</cfform>

<cfelseif isdefined('form.submit')>
	<cfinclude template="editform.cfm">
<cfelse>

<cfquery name="getForm" dbtype="query">
	select * from AllForms where FormID='#formid#'
</cfquery>
<cfoutput query="getForm">
	<cfset Positions=#replace(positions,'~',',','ALL')#>
	<cfset formrows=#ListLen(fields,"~")#>
	<cfset formfilename=#formfilename#>
	<cfset FormInstructions=#formInstructions#>
	<cfset SaveToDatabase=#savetodatabase#>
	<cfset EmailResults=#emailresults#>
	<cfset tClass=#multiformname#>
	<cfset ThisFormName=#formtitle#>
	<cfset labels=#labels#>
	<cfset fields=#fields#>
	<cfset validations=#validations#>
	<cfset messages=#messages#>
	<cfset fieldvalues=#fieldvalues#>
	<cfset fieldtypes=#fieldtypes#>
	<cfparam name="formAction" default="edit">
	<cfset FormID=#FormID#>
</cfoutput>
	
<script language="JavaScript">

function msg() {
	alert("If you want to validate for email, you should enter the field name as 'emailname'.\n\nOnly one field can be validated for email at a time.")
}

function msg1() {
	alert("This is the message that is displayed in an alert box if there's an error in the form field.")
}

function msg2() {
	alert("If you need more than 5 fields, enter the number that you want and hit 'Get'.")
}
function checktype(tfield,fName,currentValue) {
	if (tfield.value=="Grid") {
		window.open("buildgrid.cfm?field="+fName+"&currentValue="+currentValue,"buildgrid","width=640,height=420,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no");
	}
}
</script>	

<p>

<Table bgcolor="#F5F5DC">
<cfform action="adminheader.cfm?action=formeditor" method="post" name=createform>
<cfoutput>
<input type="hidden" name="rows" value="#rows#">
<input type="hidden" name="ThisFormName" value="#form.ThisFormName#">
<input type="hidden" name="formInstructions" value="#form.formInstructions#">
<input type="hidden" name="SaveToDatabase" value="#form.SaveToDatabase#">
<input type="hidden" name="EmailResults" value="#form.EmailResults#">
<input type="hidden" name="tClass" value="#form.tClass#">
<input type="hidden" name="enctype" value="multipart/form-data">
<input type="hidden" name="SubmitButton" value="#form.SubmitButton#">
<input type="hidden" name="filename" value="#formfilename#">
<input type="hidden" name="FormID" value="#FormID#">
<tr><td colspan=6><font color="##000000">Field names must be only one word<br> do not use a ## sign in a field name unless you double it ####.  Do not use a ## sign in any other area.</font></td></tr>
<tr><td colspan=6><font color="##000000">Positions must not be duplicated and must contain all the numbers between 1 and #rows#.</font></td></tr>
<tr><td valign=top></td><th>Position</th><th>Field Label</th><th>Field Name</th><th>Type</th><th>Default Value<br>or values for dropdown selections, checkboxes and radio buttons. Separate values with commas.  Use no punctuation of any sort in this area for checkbox or radio buttons value lists.</th><th>Input required?<a href="javascript:msg()">?</a></th><th>Error Message<a href="javascript:msg1()">?</a></th></tr>
<cfloop index="rowx" from="1" to="#formrows#">
	<cfset PositionID=ListGetAt(#positions#,#rowx#)>
<tr>
	<td valign=top>#Rowx#</td>
	<td valign=top>
	<Cfif not isdefined('PositionID')><cfset PositionID=1></Cfif>
	<select name="positions">
		<cfloop index="XX" from="1" to="#rows#">
			<option value="#XX#"<cfif #PositionID# is #XX#> selected</cfif>>#XX#</option>
		</cfloop>
	</select></td>
	<td valign=top><cfinput name="label_#rowx#" type="text" size="15"  required="yes" message="Please enter field label #Rowx#" value="#replace(ListGetAt(labels,rowx,'~'),'|',',','ALL')#"></td>
	<td valign=top><cfinput name="name_#rowx#" type="text" size="15" maxlength="50" required="yes" message="Please enter field name #Rowx#" value="#ListGetAt(fields,rowx,'~')#"></td>
	<td valign=top>
		<cfset xType=#ListGetAt(FieldTypes,rowx,"~")#>
		<select name="type_#rowx#" onChange="checktype(type_#rowx#,'type_#rowx#','#replace(ListGetAt(fieldvalues,rowx,'~'),"^",",","ALL")#')">
			<option value="">Select</option>	
			<option value="dropdown"<cfif #xType# is "dropdown"> selected</cfif>>Dropdown Selection</option>
			<option value="checkbox"<cfif #xType# is "checkbox"> selected</cfif>>Checkbox</option>
			<option value="file"<cfif #xType# is "file"> selected</cfif>>File</option>
			<option value="hidden"<cfif #xType# is "hidden"> selected</cfif>>Hidden</option>
			<option value="password"<cfif #xType# is "password"> selected</cfif>>Password</option>
			<option value="radio"<cfif #xType# is "radio"> selected</cfif>>Radio</option>
			<option value="text"<cfif #xType# is "text"> selected</cfif>>Text</option>
			<option value="textarea"<cfif #xType# is "textarea"> selected</cfif>>Scrolling text area</option>
			<option value="Grid"<cfif #xType# is "Grid"> selected</cfif>>Grid</option>
		</select>
	</td>
	<td valign=top><textarea cols=25 rows=5 name="value_#rowx#">#replace(ListGetAt(fieldvalues,rowx,'~'),"^",",","ALL")#</textarea></td>
	<td valign=top><select name="validation_#rowx#">
		<cfif #ListGetAt(validations,rowx,"~")# is "Yes">
			<option value="Yes" selected>Yes</option>
			<option value="No">No</option>
		<cfelse>
			<option value="Yes">Yes</option>
			<option value="No" selected>No</option>
		</cfif>
		</select>
	</td>
	<td valign=top><input type="text" name="message_#rowx#" maxlength=250 value="#ListGetAt(messages,rowx,'~')#"></td>
	</tr>
</cfloop>	
</cfoutput>

<cfif #Rows# gt #FormRows#>
	<cfset FormRows=#FormRows# + 1>
	<cfloop index="rowx" from="#formRows#" to="#rows#">
	<cfoutput>
	<tr>
		<td valign=top>#Rowx#</td>
		<td valign=top>
			<select name="positions">
				<cfloop index="XX" from="1" to="#rows#">
					<option value="#XX#">#XX#</option>
				</cfloop>
			</select>
		</td>
		<td valign=top><cfinput name="label_#rowx#" type="text" size="15" maxlength="50" required="yes" message="Please enter field label #Rowx#"></td>
		<td valign=top><cfinput name="name_#rowx#" type="text" size="15" maxlength="50" required="yes" message="Please enter field name #Rowx#"></td>
		<td valign=top><select name="type_#rowx#" onChange="checktype(type_#rowx#,'type_#rowx#')">
				<option value="">Select</option>	
				<option value="dropdown">Dropdown Selection</option>
				<option value="checkbox">Checkbox</option>
				<option value="file">File</option>
				<option value="hidden">Hidden</option>
				<option value="password">Password</option>
				<option value="radio">Radio</option>
				<option value="text">Text</option>
				<option value="textarea">Scrolling text area</option>
				<option value="Grid">Grid</option>
			</select>
		</td>
		<td valign=top><textarea cols=25 rows=5 name="value_#rowx#"></textarea></td>
		<td valign=top><select name="validation_#rowx#">
				<option value="Yes">Yes</option>
				<option value="No">No</option>
			</select>
		</td>
		<td valign=top><input type="text" name="message_#rowx#" maxlength=250></td>
		</tr>
		
	</cfoutput>
	</cfloop>
</cfif>
<tr></tr>
<tr><td colspan="8" align="center"><input type="submit" value="Create Form" NAME="submit"></td></tr>

</cfform>
</table>


</cfif>
