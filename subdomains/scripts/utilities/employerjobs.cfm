<cfparam name="memberaction" default="">
<cfparam name="ThisJobID" default=0>
<cfparam name="PageAction" default="list">
<cfparam name="employerid" default="0">
<script>
function confirmDelete(delUrl) {
  if (confirm("Are you sure you want to delete")) {
    document.location = delUrl;
  }
}
</script>

<cfif #PageAction# is "changeEmployer">
<cfif isdefined('form.changeemployer')>
	<cfloop index="thisJobID" list="#form.changeEmployer#">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ThisJob">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="jobs">
			<cfinvokeargument name="selectstatement" value=" where jobid='#trim(thisJobID)#'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
			method="UpdateXMLRecord" returnvariable="newJobID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="XMLFields" value="JobDescription,JobTitle,DateCreated,JobType,JobImage,StateID,ContactState,LocationCity,ContactName,ContactAddress,Jobcategoryid,ContactCity,InvoiceInstructions,ContactInstructions,JobStarts,JobEnds,HotJob,ContactZip,ContactPhone,ContactFax,ContactEmail,JobPay,PayByInvoice,Status,employerID,JobDetails,JobPayPer">
			<cfinvokeargument name="XMLFieldData" value="#ThisJob.JobDescription#,#ThisJob.JobTitle#,#ThisJob.DateCreated#,#ThisJob.JobType#,#ThisJob.JobImage#,#ThisJob.StateID#,#ThisJob.contactState# ,#ThisJob.LocationCity# ,#ThisJob.ContactName# ,#ThisJob.ContactAddress# ,#ThisJob.Jobcategoryid#,#ThisJob.ContactCity# ,#ThisJob.InvoiceInstructions# ,#ThisJob.ContactInstructions# ,#ThisJob.JobStarts#,#ThisJob.JobEnds#,#ThisJob.HotJob#,#ThisJob.ContactZip# ,#ThisJob.ContactPhone# ,#ThisJob.ContactFax# ,#ThisJob.ContactEmail# ,#ThisJob.JobPay#,#ThisJob.PayByInvoice#,#ThisJob.status#,#trim(form.newemployerid)#,#ThisJob.JobDetails# ,#ThisJob.JobPayPer#">
			<cfinvokeargument name="XMLIDField" value="JobID">
			<cfinvokeargument name="XMLIDValue" value="#trim(thisJobID)#">
		</cfinvoke>
	
	</cfloop>
	<cfelse>
	<cfoutput><p><font color="##CC0000"><strong>You must check at least one job to transfer to a new employer</strong></font></p></cfoutput>
	</cfif>
	<cfset PageAction="list">
</cfif>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="states">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllEmployers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="employers">
	<cfinvokeargument name="orderbystatement" value=" order by companyname">
</cfinvoke>
<cfparam name="ID" default="0">
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="TheJob">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="jobs">
	<cfinvokeargument name="selectstatement" value=" where employerID='#employerid#'">
	<cfinvokeargument name="orderbystatement" value=" order by datecreated desc">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="jobBoardConfig">
	<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
	<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
	<cfinvokeargument name="IDFieldName" value="configID">
	<cfinvokeargument name="IDFieldValue" value="0000000001">
</cfinvoke>

<Cfif #pageaction# is "list">
	<cfif #TheJob.recordcount# is 0><cfoutput>You have no jobs listed.</cfoutput>
	<cfelse>
	<cfoutput>
	<cfquery name="thisemployer" dbtype="query">
		select companyname from allemployers where employerid='#trim(employerid)#'
	</cfquery>
	<p><strong>Jobs for #thisemployer.companyname#</strong></p>
	<p>&nbsp;</p>
	<cfset tEmployerID=#EmployerID#>
	<form action="adminheader.cfm?action=#action#&pageaction=changeEmployer&employerid=#employerid#" method="post">
	<p>select employer to move the selected jobs to<select name="newEmployerID">
				<option value="0">None</option>
				<cfloop query="AllEmployers">
					<option value="#AllEmployers.EmployerID#" <cfif #tEmployerID# is #AllEmployers.EmployerID#>selected</cfif>>#companyname#</option>
				</cfloop>
			</select><input type="submit" name="changeEmpGo" value="Change"></p>
	<table width=100% cellpadding="0" cellspacing="0" border="0">
		<TR BGCOLOR=##99cc99>
		  <TD HEIGHT="20" CLASS="heading" WIDTH="70">Posted</TD>
		  <TD WIDTH="150" CLASS="heading">Location</TD>
		  <TD WIDTH="220" CLASS="heading">Job Title</TD>
		  <TD WIDTH="220" CLASS="heading">Actions</TD>
		</TR>
		<cfloop query="theJob">
			<cfquery name="getState" dbtype="query">
				select * from allstates where stateid='#trim(stateid)#'
			</cfquery>
		<TR style="border-bottom:1px black solid">
			<TD nowrap class=body valign=top style="border-bottom:1px ##cccccc dashed">#dateformat(datecreated,"mm/dd/yyyy")#&nbsp;</TD>
			<TD class=body valign=top style="border-bottom:1px ##cccccc dashed">#LocationCity#<BR>#getstate.statename#</TD>
			<TD class=body valign=top style="border-bottom:1px ##cccccc dashed">#jobTitle#</TD>
			<TD class=body valign=top style="border-bottom:1px ##cccccc dashed" nowrap>
			<input type="checkbox" name="changeEmployer" value="#jobid#"></TD>
		</TR>
		</cfloop>
	</table>
	</form>
	</cfoutput>	
	</cfif>
</cfif>