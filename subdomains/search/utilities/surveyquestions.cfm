<cfparam name="QuestionID" default=0>
<cfparam name="QuestionAction" default="List">
<cfparam name="SurveyNameID" default="">
<cfparam name="Question" default="">
<cfparam name="PositionID" default="0">
<cfparam name="DisplayTypeID" default=0>
<cfparam name="UseInSearch" default=0>
<cfparam name="isrequired" default=0>
<cfparam name="answers" default='none'>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllSurveyQuestions">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
	<cfinvokeargument name="IDFieldName" value="SurveyNameID">
    <cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllSurveys">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Surveys">
	<cfinvokeargument name="IDFieldName" value="SurveyID">
    <cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
</cfinvoke>

<cfif QuestionAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
		<cfinvokeargument name="XMLFields" value="QuestionID,SurveyNameID,Question,PositionID,DisplayTypeID,UseInSearch,isrequired,answers">
		<cfinvokeargument name="XMLIDField" value="QuestionID">
		<cfinvokeargument name="XMLIDValue" value="#QuestionID#">
	</cfinvoke>
	<cfset QuestionID=0>
	<cfset QuestionAction="List">
</cfif>
		
<cfif QuestionID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="SurveyQuestions">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
		<cfinvokeargument name="IDFieldName" value="QuestionID">
		<cfinvokeargument name="IDFieldValue" value="#QuestionID#">
	</cfinvoke>
	<cfoutput query="SurveyQuestions">
		<cfset Question=#replace(Question,"~",",","ALL")#>
		<cfset Question=replace(#Question#,"`","'","ALL")>
		<cfset SurveyNameID=#SurveyNameID#>
		<cfset PositionID=#PositionID#>
		<cfset DisplayTypeID=#DisplayTypeID#>
		<cfset UseInSearch=#UseInSearch#>
		<cfset isrequired=#isrequired#>
		<cfset answers=#replace(answers,"~",",","ALL")#>
	</cfoutput>
	<cfset QuestionAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.Question=replace(#form.Question#,",","~","ALL")>
	<cfset form.Question=replace(#form.Question#,"'","`","ALL")>
	<cfset form.answers=#replace(form.answers,",","~","ALL")#>
	<cfif QuestionID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
			<cfinvokeargument name="XMLFields" value="SurveyNameID,Question,PositionID,DisplayTypeID,UseInSearch,isrequired,answers">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.SurveyNameID#,#XMLformat(form.Question)#,#form.PositionID#,#form.DisplayTypeID#,#form.UseInSearch#,#form.isrequired#,#form.answers#">
			<cfinvokeargument name="XMLIDField" value="QuestionID">
			<cfinvokeargument name="XMLIDValue" value="#QuestionID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
			<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
			<cfinvokeargument name="XMLFields" value="SurveyNameID,Question,PositionID,DisplayTypeID,UseInSearch,isrequired,answers">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.SurveyNameID#,#XMLformat(form.Question)#,#form.PositionID#,#form.DisplayTypeID#,#form.UseInSearch#,#form.isrequired#,#form.answers#">
			<cfinvokeargument name="XMLIDField" value="QuestionID">
		</cfinvoke>
	</cfif>
	<cfset QuestionAction="list">
	<cfset QuestionID = 0>
	<cfset SurveyNameID=#SurveyNameID#>
	<cfset Question=''>
	<cfset PositionID=0>
	<cfset DisplayTypeID=0>
	<cfset UseInSearch=0>
	<cfset isrequired=0>
	<cfset answers='none'>
</cfif>

<cfoutput>
<h1>Survey Questions for "#AllSurveys.SurveyName#"</h1>

<cfif QuestionAction is "Add" or QuestionAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="QuestionID" value="#QuestionID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="QuestionAction" value="#QuestionAction#">
<input type="hidden" name="SurveyNameID" value="#SurveyNameID#">
<TABLE>
	
	<TR>
	<TD valign="top"> Question: </TD>
    <TD>
		<cfinput name="Question" type="text" value="#Question#" size="40" maxlength="100" required="yes" message="Please enter an Question">
	</TD>
	<!--- field validation --->
	</TR>

	 <tr>
		<td><font face="arial" size="2">Display as:</font> </td><td>
			<select name="DisplayTypeID">
			<option value="1" <cfif #DisplayTypeID# is 1>selected</cfif>>Single Selection Drop Down                        
			<option value="2" <cfif #DisplayTypeID# is 2>selected</cfif>>Multi Selection Drop Down                         
			<option value="3" <cfif #DisplayTypeID# is 3>selected</cfif>>Radio Button                                      
			<option value="4" <cfif #DisplayTypeID# is 4>selected</cfif>>Text Box                                          
			<option value="5" <cfif #DisplayTypeID# is 5>selected</cfif>>Paragraph Box                                     
			<option value="6" <cfif #DisplayTypeID# is 6>selected</cfif>>Essay Box                                         
			<option value="7" <cfif #DisplayTypeID# is 7>selected</cfif>>Check Box  
			<!--- <option value="8" <cfif #DisplayTypeID# is 8>selected</cfif>>Grid    --->
			</select>
		</td>
	</tr>
	<tr>
		<td><font face="arial" size="2">PositionID in the Question list</font></td>
		<td><select name="PositionID">
			<cfloop index="tt" from="1" to="50">
				<cfset NewID=#tt#>
				<cfset tLen=Len(NewID)>
				<cfloop index="XX" from="#tLen#" to="9">
					<cfset NewID="0#NewID#">
				</cfloop>
				<option value="#NewID#" <cfif #PositionID# is #NewID#>selected</cfif>>#TT#
			</cfloop>
		</select></td>
	</tr>
	<tr>
		<td><font face="arial" size="2">Use in Search Criteria?</font> </td><td>
			Yes: <input type="Radio" name="UseInSearch" value="1" <cfif #UseInSearch# is 1>checked</cfif>><br>
			No: <input type="Radio" name="UseInSearch" value="0" <cfif #UseInSearch# is 0>checked</cfif>>
		</td>
	</tr>
	<tr>
		<td><font face="arial" size="2">Is this question required?</font> </td><td>
			<cfif #isrequired# is 1>
				Yes: <input type="Radio" name="isrequired" value="1" checked><br>
				No: <input type="Radio" name="isrequired" value="0"></cfif>
			<cfif #isrequired# is 0>
				Yes: <input type="Radio" name="isrequired" value="1"><br>
				No: <input type="Radio" name="isrequired" value="0" checked></cfif>
			<cfif #isrequired# is ''>
				Yes: <input type="Radio" name="isrequired" value="1"><br>
				No: <input type="Radio" name="isrequired" value="0" checked></cfif>
	
	</td>
	</tr>
	<tr>
		<td>Answers for this question (if applicable - this usually applies to drop downs, radio buttons, checkboxes and grids)
		</td>
		<td><textarea cols=40 rows=5 name="answers">#answers#</textarea><br>
		<font color="##CC0000"><strong>Separate by commas and DO NOT USE COMMAs in the answers themselves</strong></font></td>
	</tr>
</TABLE>
	
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</cffORM>
</cfif>


<cfif QuestionAction is "list">

<a href="adminheader.cfm?Action=#Action#&QuestionAction=Add&SurveyNameID=#SurveyNameID#">Add A Question for "#AllSurveys.SurveyName#"</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="SurveyQuestions">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllSurveyQuestions">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="SurveyQuestions">
			<cfinvokeargument name="IDFieldName" value="SurveyNameID">
		    <cfinvokeargument name="IDFieldValue" value="#SurveyNameID#">
			<cfinvokeargument name="OrderByStatement" value=" order by records.PositionID">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Questions for "#AllSurveys.SurveyName#"</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Question</p></td>
		<td><p>PositionID</p></td>
		<td><p>Display Type</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllSurveyQuestions">
		<tr>
		<td><p>#int(QuestionID)#</p></td>
		<td><p>#replace(Question,"~",",","ALL")#</p></td>
		<td><p>#int(PositionID)#</p></td>
		<td><p><cfif #DisplayTypeID# is 1>Single Selection Drop Down </cfif>                       
			<cfif #DisplayTypeID# is 2>Multi Selection Drop Down </cfif>                     
			<cfif #DisplayTypeID# is 3>Radio Button   </cfif>                                      
			<cfif #DisplayTypeID# is 4>Text Box    </cfif>                                      
			<cfif #DisplayTypeID# is 5>Paragraph Box </cfif>                              
			<cfif #DisplayTypeID# is 6>Essay Box </cfif>                                        
			<cfif #DisplayTypeID# is 7>Check Box  </cfif>
			<cfif #DisplayTypeID# is 8>Grid </cfif>  </p></td>
		<td><a href= "adminheader.cfm?QuestionID=#QuestionID#&QuestionAction=Edit&&action=#action#&SurveyNameID=#SurveyNameID#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?QuestionID=#QuestionID#&QuestionAction=Delete&action=#action#&SurveyNameID=#SurveyNameID#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
<a href="adminheader.cfm?Action=Surveys">Return to Surveys</a><br>
</cfoutput>