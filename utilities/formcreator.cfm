
<cfparam name="rows" default="0">
<cfparam name="ThisFormName" default="">
<cfparam name="FormInstructions" default="">
<cfparam name="SaveToDatabase" default="0">
<cfparam name="EmailResults" default="#Application.email#">
<cfparam name="tClass" default="none">
<cfparam name="SubmitButton" default="Submit">
<cfparam name="formAction" default="list">
<cfparam name="FormID" default=0>

<cfif #formaction# is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Forms">
		<cfinvokeargument name="XMLFields" value="formID,formfilename,formtitle,emailresults,savetodatabase,labels,fields,formInstructions">
		<cfinvokeargument name="XMLIDField" value="formID">
		<cfinvokeargument name="XMLIDValue" value="#formID#">
	</cfinvoke>
	<cfset formID=0>
	<cfset formAction="List">
</cfif>

<h2>Form Creator:</h2>
<cfif #Rows# is 0>
	<cfform name="noOfRowsForm" action="adminheader.cfm?action=formcreator" method="post">
		<table>
		<tr>
		<td valign=top>How many items will your form have?:</td> 
		<td valign=top><cfinput name="rows" type="text" value="#rows#" size="5" maxlength="5" required="yes" message="Please enter the number of form items" validate="integer"></td>
		</tr>
		<tr>
		<td valign=top>Title of this form:<br>(will show on the page where the user fills out the form<br>and this will also be the subject of the email sent to you.)</td> 
		<td valign=top><cfinput name="ThisFormName" type="text" value="#ThisFormName#" size="35" maxlength="250" required="yes" message="Please enter a form name"></td>
		</tr>
		<tr>
		<td valign=top>Form Instructions:<br>(will show on the page where the user fills out the form)</td> 
		<td valign=top><textarea name="formInstructions" cols="35" rows="5"><cfoutput>#FormInstructions#</cfoutput></textarea></td>
		</tr>
		<tr>
		<td valign="top">Do you want this form to display per a specific style in your style sheet?</td>
		<td valign="top">style name: <cfinput type="text" name="tClass" value="#tClass#"></td>
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
	
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllForms">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="forms">
	</cfinvoke>
	<cfif #Allforms.recordcount# gt 0>
		<table class=toptable>
	<th colspan="6" align="CENTER" bgcolor="#800040">Your Custom Forms</th>
	<tr>
	<th>ID</th>
	<th>Name</th>
	<th>Description</th>
	<th>Actions</th>
	</tr>
	
	<cfoutput query="AllForms">
		<tr>
		<td><p>#int(formid)#</p></td>
		<td><p>#formfilename#</p></td>
		<td><p>#formtitle#</p></td>
		
		<td>

		<a href="javascript:confirmDelete('adminheader.cfm?FormID=#FormID#&formAction=Delete&Action=formcreator')">Delete this form</a>
		<br>
		<a href="../utilities/ViewForm.cfm?formname=#formfilename#&Action=ViewForm" target="MSM">View Completed Form</a>
		<cfif #savetodatabase# is 1>
		<br>
		<a href="adminheader.cfm?formID=#formid#&listname=#formfilename#&Action=viewFormReplies">View Replies to this form</a></cfif>
		</td>
		</tr>
	</cfoutput>
	
	</table>
	</cfif>
<cfelseif isdefined('form.submit')>
	<cfinclude template="createform.cfm">
<cfelse>

<CF_agr_password mode="alpha" case="mixed" length="20" var="filename">
<script language="JavaScript" src="../scripts/formvalidation.js"></script>
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
</script>	

<p>

<Table bgcolor="#F5F5DC">
<cfform action="adminheader.cfm?action=formcreator" method="post">
<cfoutput>
<input type="hidden" name="rows" value="#rows#">
<input type="hidden" name="ThisFormName" value="#ThisFormName#">
<input type="hidden" name="formInstructions" value="#formInstructions#">
<input type="hidden" name="SaveToDatabase" value="#SaveToDatabase#">
<input type="hidden" name="EmailResults" value="#EmailResults#">
<input type="hidden" name="tClass" value="#tClass#">
<input type="hidden" name="enctype" value="multipart/form-data">
<input type="hidden" name="SubmitButton" value="#SubmitButton#">
<input type="hidden" name="filename" value="#filename#">
</cfoutput>
<tr><td colspan=6><font color="#FFFF99">Field names must be only one word</font></td></tr>
<tr><td valign=top></td><th>Field Label</th><th>Field Name</th><th>Type</th><th>Default Value<br>or values for dropdown selections, checkboxes and radio buttons. Separate values with commas.</th><th>Input required?<a href="javascript:msg()">?</a></th><th>Error Message<a href="javascript:msg1()">?</a></th></tr>
<cfloop index="rowx" from="1" to="#rows#">
<cfoutput>
<tr>
	<td valign=top>#Rowx#</td>
	<td valign=top><cfinput name="label_#rowx#" type="text" size="15" maxlength="50" required="yes" message="Please enter field label #Rowx#"></td>
	<td valign=top><cfinput name="name_#rowx#" type="text" size="15" maxlength="50" required="yes" message="Please enter field name #Rowx#"></td>
	<td valign=top><select name="type_#rowx#">
			<option value="">Select</option>	
			<option value="dropdown">Dropdown Selection</option>
			<option value="checkbox">Checkbox</option>
			<option value="file">File</option>
			<option value="hidden">Hidden</option>
			<option value="password">Password</option>
			<option value="radio">Radio</option>
			<option value="text">Text</option>
			<option value="textarea">Scrolling text area</option>
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
<tr></tr>
<tr><td colspan="8" align="center"><input type="submit" value="Create Form" NAME="submit"></td></tr>

</cfform>
</table>


</cfif>
