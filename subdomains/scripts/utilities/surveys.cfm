<cfparam name="SurveyID" default=0>
<cfparam name="SurveyAction" default="List">
<cfparam name="SurveyDescription" default="">
<cfparam name="SurveyName" default="">
<cfparam name="DateStarted" default="#now()#">
<cfparam name="DateEnded" default="#now()#">
<cfparam name="NoOfQsPerPage" default="10">
<cfparam name="NoOfColumns" default="1">
<cfparam name="SurveyType" default="General">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllSurveys">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Surveys">
</cfinvoke>

<cfif SurveyAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Surveys">
		<cfinvokeargument name="XMLFields" value="SurveyID,SurveyDescription,SurveyName,DateStarted,DateEnded,NoOfQsPerPage,NoOfColumns,SurveyType">
		<cfinvokeargument name="XMLIDField" value="SurveyID">
		<cfinvokeargument name="XMLIDValue" value="#SurveyID#">
	</cfinvoke>
	<cfset SurveyID=0>
	<cfset SurveyAction="List">
</cfif>
		
<cfif SurveyID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Surveys">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Surveys">
		<cfinvokeargument name="IDFieldName" value="SurveyID">
		<cfinvokeargument name="IDFieldValue" value="#SurveyID#">
	</cfinvoke>
	<cfoutput query="Surveys">
		<cfset SurveyDescription=#replace(SurveyDescription,"~",",","ALL")#>
		<cfset SurveyName=#replace(SurveyName,"~",",","ALL")#>
		<cfset DateStarted=#DateStarted#>
		<cfset DateEnded=#dateended#>
		<cfset NoOfQsPerPage=#NoOfQsPerPage#>
		<cfset NoOfColumns=#NoOfColumns#>
		<cfset SurveyType=#SurveyType#>
	</cfoutput>
	<cfset SurveyAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.SurveyDescription=replace(#form.SurveyDescription#,",","~","ALL")>
	<cfset form.SurveyName=replace(#form.SurveyName#,",","~","ALL")>
	<cfif SurveyID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Surveys">
			<cfinvokeargument name="XMLFields" 
				value="SurveyDescription,SurveyName,DateStarted,DateEnded,NoOfQsPerPage,NoOfColumns,SurveyType">
			<cfinvokeargument name="XMLFieldData" 
				value="#XMLformat(form.SurveyDescription)#,#XMLformat(form.SurveyName)#,#form.DateStarted#,#form.DateEnded#,#form.NoOfQsPerPage#,#form.NoOfColumns#,#form.SurveyType#">
			<cfinvokeargument name="XMLIDField" value="SurveyID">
			<cfinvokeargument name="XMLIDValue" value="#SurveyID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Surveys">
			<cfinvokeargument name="XMLFields" 
				value="SurveyDescription,SurveyName,DateStarted,DateEnded,NoOfQsPerPage,NoOfColumns,SurveyType">
			<cfinvokeargument name="XMLFieldData" 
				value="#XMLformat(form.SurveyDescription)#,#XMLformat(form.SurveyName)#,#form.DateStarted#,#form.DateEnded#,#form.NoOfQsPerPage#,#form.NoOfColumns#,#form.SurveyType#">
			<cfinvokeargument name="XMLIDField" value="SurveyID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=#action#">
</cfif>

<cfoutput>
<h1>Surveys</h1>

<cfif SurveyAction is "Add" or SurveyAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="SurveyID" value="#SurveyID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="SurveyAction" value="#SurveyAction#">
<TABLE>
	
	<TR>
	<TD valign="top"> Survey Type: </TD>
    <TD>
		<select name="SurveyType">
			<option value="General"<cfif #SurveyType# is "General"> selected</cfif>>General Survey</option>
			<option value="Customer"<cfif #SurveyType# is "Customer"> selected</cfif>>Customer Survey</option>
			<option value="Member"<cfif #SurveyType# is "Member"> selected</cfif>>Member Survey</option>
			<option value="Affiliate"<cfif #SurveyType# is "Affiliate"> selected</cfif>>Affiliate Survey</option>
		</select>
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Short Name: </TD>
    <TD>
		<cfinput name="SurveyName" type="text" value="#SurveyName#" size="40" maxlength="100" required="yes" message="Please enter a Category Name">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Survey Title: </TD>
    <TD>
	
		<textarea cols=40 rows=5 name="SurveyDescription">#SurveyDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>

	<tr>
		<td><font face="arial" size="2">Date this Questionaire is available:</font> </td><td><input type="text" name="DateStarted" value="#dateformat(DateStarted,"mm/dd/yyyy")#"></td>
	</tr>
	
	 <tr>
		<td><font face="arial" size="2">Date this Questionaire ends:</font> </td><td><input type="text" name="DateEnded" value="#dateformat(DateEnded,"mm/dd/yyyy")#"></td>
	</tr>
	
	 <tr>
		<td><font face="arial" size="2">Number of Questions Per Page</font> </td><td><input type="text" name="NoOfQsPerPage" value="#NoOfQsPerPage#"></td>
	</tr>
	
	 <tr>
		<td><font face="arial" size="2">Number Of Columns Per Page:</font> </td><td><input type="text" name="NoOfColumns" value="#NoOfColumns#"></td>
	</tr>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif><cfif SurveyAction is "list">
  <a href="adminheader.cfm?Action=#Action#&SurveyAction=Add">Add 
  A Survey</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="Surveys">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllSurveys">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Surveys">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="4" align="CENTER" bgcolor="Maroon"><p>Your Surveys</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Question</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllSurveys">
		<tr>
		<td><p>#int(SurveyID)#</p></td>
		<td><p>#replace(SurveyName,"~",",","ALL")#</p></td>
		<td><p>#replace(SurveyDescription,"~",",","ALL")#</p></td>
		<td><a href= "adminheader.cfm?SurveyID=#SurveyID#&SurveyAction=Edit&&action=#action#">Edit</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SurveyID=#SurveyID#&SurveyAction=Delete&action=#action#">Delete</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SurveyNameID=#SurveyID#&action=SurveyQuestions">Questions</a> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?SurveyNameID=#SurveyID#&action=SurveyResults">Results</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>