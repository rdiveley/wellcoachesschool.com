<cfcomponent>
	<cffunction name="eapplication" access="public" returntype="string">
		<cfset EVentStart=dateformat(now())>
		<cfset MonthList = "January,February,March,April,May,June,July,August,September,October,November,December">
		<cfparam name="AppAction" default="SelectType">
		<cfparam name="CourseType" default="e-Class">
		<cfparam name="RecordID" default="0">
		<cfparam name="PID" default="0">
		<cfoutput><SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
		function textCounter(field, countfield, maxlimit) {
		if (field.value.length > maxlimit) // if too long...this trims it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
		else 
		countfield.value = maxlimit - field.value.length;
		}
		// End -->
		</script>
		
		<p><h1>New Class Application</h1></cfoutput>
		<cfif #AppAction# is "SelectType">
		<cfform action="Index.cfm" method="POST">
		<cfoutput>
		<input type="hidden" name="Page" value="#Page#">
		<input type="hidden" name="AppAction" value="AppPage2">
		<table border="0" width=100%>
		
		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getClassTypes" returnvariable="xEcourseTypes"></cfinvoke>
		<cfset eCourseTypesCount=#xEcourseTypes.RecordCount#>
		
		<tr><td valign=top class=left3col><p>Select Class type:</p></td>
		<td class=right3col nowrap><p class=explanation>
		<cfselect name="CourseType" size="1" required="Yes">
		<cfloop query="xEcourseTypes">
			<option value="#TypeName#">#TypeName#</option>
		</cfloop>
		</cfselect><br>
		<img src="../images/help-off.gif" onClick="gethelp('coursetype')" style="cursor: hand;"></p>
		</td></tr>
		<tr><td valign=top class=left3col><p>&nbsp;</p></td><td class=right3col><br><p><input type="Image" name="Continue" src="../images/Continue-off.gif"></p></td></tr>
		</table>
		</cfoutput>
		</cfform>
		</cfif>
		
		<cfswitch expression="#AppAction#">
		<cfcase value="AppPage2">
			<cfinvoke method="eClassApp"></cfinvoke>
		</cfcase>
		<cfcase value="AppPage3">
			<cfif isdefined('UpdateAction')>
				<cfif #UpdateAction# is "scheduleadd">
					<cfset EditAction="">
					<cfinclude template="editclasses.cfm">
					<Cfset ProductID=#Filename#>
					<cfinclude template="#homepath##Commonpath#/newparams.cfm">
				<cfelse>
					<cfset EditAction="AddClass">
					<cfinclude template="addclasses.cfm">
				</cfif>
			<cfelse>
				<cfset EditAction="AddClass">
				<cfinclude template="addclasses.cfm">
			</cfif>
			<cfif #CourseType# is "e-Class">
				<cfinclude template="application2.cfm"><!--- Lesson Summary--->
			<cfelseif #CourseType# is "LIVE TELECLASS">
				<cfinclude template="teleclassapp.cfm"><!--- Class Schedule --->
			<cfelseif #CourseType# is "Web Audio Class">
				<cfinclude template="application2.cfm"><!--- Lesson Summary--->
			</cfif>
		</cfcase>
		<cfcase value="AppPage4">
			<cfif #CourseType# is "e-Class">
				<cfinclude template="LessonHandouts.cfm"><!--- Lesson Handouts--->
			<cfelseif #ucase(CourseType)# is "LIVE TELECLASS">
				<cfset EditAction="">
				<cfinclude template="editclasses.cfm">
				<cfinclude template="application2.cfm"><!--- Lesson Summary --->
			<cfelseif #CourseType# is "Web Audio Class">
				<cfinclude template="LessonHandouts.cfm"><!--- Lesson Handouts--->
			</cfif>
		</cfcase>
		<Cfcase value="AppPage5">
			<cfinclude template="LessonHandouts.cfm"><!--- Thank you Page --->
		</cfcase>
		<cfcase value="AppPage6">
			<cfinclude template="application3.cfm"><!--- Thank you Page --->
		</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="eClassApp" access="remote" output="true">
		<cfif isdefined('lid')><cfelse><cfset lid=0></cfif>

		<cfinvoke component="#application.websitepath#.utilities.classes"
			method="getClassCategories" returnvariable="xeClassCategories"></cfinvoke>
		<cfset xeClassCategoriesCount=#xeClassCategories.recordCount#>
			<cfoutput><script>
		function GetEditor(form,tControl) {
			winStr = '#application.returnpath#/utilities/Editor.cfm?thisForm=' + form + '&amp;thisContent=' + tControl+'&page=#page#&lid=#lid#';
			win = window.open(winStr, 'editwin' , 'width=640,height=420,menubar=no,toolbar=no,status=no,scrollbars=no,resizable=yes,titlebar=no,location=no');
			win.focus();
		}</script></cfoutput>
		
		<cfform action="index.cfm" method="POST" name="classappform">
		<cfoutput>
		<input type="hidden" name="page" value="#page#">
		<input type="hidden" name="AppAction" value="AppPage3">
		<input type="hidden" name="CourseType" value="#courseType#">
		<table border="0" width=100%>
		<tr><td valign=top class=left3col><p>Select Class Category:</p></td>
		<td class=right3col><p class=explanation>
		<cfselect name="CourseCategory" size="1" required="Yes">
		<cfloop query="xeClassCategories">
		<option value="#CategoryName#">#CategoryName#
		</cfloop>
		</cfselect><br>
		<img src="../images/help-off.gif" onClick="gethelp('coursecategory')" style="cursor: hand;"></p>
		</td></tr>
		
		<tr><td valign=top class=left3col><p>Enter Class Title:</p></td><td class=right3col><p><cfinput type="Text" name="CourseTitle" required="Yes" size="25" maxlength="150"></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Enter Subtitle (optional):</p></td><td class=right3col><p class=explanation><cfinput type="Text" name="Subtitle" required="No" size="25" maxlength="150"></p></td></tr>
		
		<tr>
		<td valign=top class=left3col>
		<p>Total ## of Lessons in Your Class:</p>
		</td>
		<td class=right3col>
		<p>
		<cfselect name="NoOfLessons" size="1" required="Yes">
		<cfloop index="TT" from="1" to="60">
		<option value="#TT#">#TT#</option>
		</cfloop>
		</cfselect>
		</p>
		</td>
		</tr>
		
		<tr>
			<td valign=top class=left3col><p>Suggested Class Price:</td>
			<td class=right3col><select name="CoursePrice" size="1">
				<option value="20-39">$20-39
				<option value="40-59">$40-59
				<option value="60-79">$60-79
				<option value="80-999">$80+
				</select>
			</td>
		</tr>
		
		<tr><td valign=top class=left3col><p>Distribution Frequency:  </p></td><td class=right3col><p><cfselect name="distribution" size="1" required="Yes">
			<option value="Once">One Time Only
			<option value="daily">daily
			<option value="weekly">weekly
			<option value="semi-monthly">twice a month
			<option value="monthly">monthly</cfselect></td></tr>
		
		
		<tr><td valign=top class=left3col><p>Faculty Bio: </p></td><td class=right3col>
		<p class=explanation>
		<input readonly type=hidden name=remLen3 size=3 maxlength=3 value="500">
		<a href="javascript:GetEditor('classappform','facultybio')">Click here for the editor</a><br>
		<textarea name="facultybio" cols="25" rows="7" onKeyDown="textCounter(this.form.facultybio,this.form.remLen3,500);" onKeyUp="textCounter(this.form.facultybio,this.form.remLen3,500);"></textarea><br>
		<font size="1">75 word limit (500 characters).  This will be used by #application.WEBSITENAME# to promote the program.</font></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Faculty Qualifications:</p></td>
		<td class=right3col><cfselect name="degree"><option value="BS_BA">BS/BA<option value="MS_MA">MA/MS<option value="PHD">PhD<option value="other">Other</cfselect></td></tr>
		
		<tr><td valign=top class=left3col><p>If other, please explain</p></td><td class=right3col><cfinput type="Text" name="Degree_other" required="No" size="25" maxlength="255"></td></tr>
		
		<tr><td valign=top class=left3col><p>Indicate relevant certifications or qualifications</p></td><td class=right3col><p><cfinput type="Text" name="certifications" required="No" size="25" maxlength="255"></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Indicate years experience in the topic</p></td><td class=right3col><p><cfinput type="Text" name="experience" required="Yes" size="25" maxlength="255"></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Will you make yourself available to students by email?</p></td> <td class=right3col><p> <cfinput type="Radio" name="studentemail" value="Yes" checked="Yes">Yes, or <cfinput type="Radio" name="studentemail" value="No">no.</p></td></tr>
		
		<tr><td valign=top class=left3col><p>If yes, Email address for student email:</p></td><td class=right3col><p><cfinput type="Text" name="email" required="No" size="25" maxlength="255"></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Class Introduction: </p></td><td class=right3col><p class=explanation><a href="javascript:GetEditor('classappform','course_summary')">Click here for the editor</a><br><textarea name="course_summary" cols="25" rows="7"></textarea></p></td></tr>
		
		<tr><td valign=top class=left3col><p>Class Summary: </p></td>
		<td class=right3col><p class=explanation><a href="javascript:GetEditor('classappform','objectives')">Click here for the editor</a><br><textarea name="objectives" cols="25" rows="7"></textarea><br><font size="1">What students will be able to do upon completing your class</font></p></td></tr>
		
		
		<tr><td valign=top class=left3col><p>&nbsp;</p></td><td class=right3col><br><p><input type="Image" name="Continue" src="../images/Continue-off.gif"></p></td></tr>
		
		</table></cfoutput>
		</cfform>

	</cffunction>
</cfcomponent>