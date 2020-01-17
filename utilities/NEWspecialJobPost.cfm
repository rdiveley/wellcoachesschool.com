<cfparam name="jobaction" default="add">
<cfparam name="employerid" default="0">
<cfparam name="action" default="">
<cfparam name="startadd" default="0">
<cfset page="postajob">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="states">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="JobCategories">
</cfinvoke>

<cfif isDefined('form.submit')>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="eCommerce">
		<cfinvokeargument name="IDFieldName" value="GatewayID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset PaymentGateway=#PaymentGateway#>
		<cfset GatewayUsername=#GatewayUsername#>
		<cfset GatewayPassword=#GatewayPassword#>
		<cfset GatewayURL=#GatewayURL#>
		<cfset AllowVISA=#AllowVISA#>
		<cfset AllowMC=#AllowMC#>
		<cfset AllowDiscover=#AllowDiscover#>
		<cfset AllowCarteBlanch=#AllowCarteBlanch#>
		<cfset AllowAMEX=#AllowAMEX#>
		<cfset AllowChecks=#AllowChecks#>
		<cfset AllowDinersClub=#AllowDinersClub#>
	</cfoutput>
	<Cfset ccexpires="#trim(form.expmonth)##right(form.expyear,2)#">
	<cfset form.contactname="#trim(form.contact_first)# #trim(form.contact_last)#">
	<cfset processtotal=evaluate("form.hotjobprice#form.hotjob#")>
	<cfset processtotal=dollarformat(processtotal)>
	<cfset processtotal=replace(processtotal,"$","")>
	<cfset processtotal=replace(processtotal,",","","ALL")>
	<cfset form.ccno=replace(form.ccno,"-","","ALL")>
	<cfset newInvoiceNo=1>
	<cfset form.billinvoice=1>
	
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Jobs\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.JobImage="images/Jobs/#image#">
	<Cfelse>
		<cfset form.JobImage="">
	</cfif>
	<cfif #form.JobImage# is ''><cfset form.JobImage="none"></cfif>
	
	<cfif not isdefined('form.LocationCity')><cfset form.LocationCity="0"></cfif>
	<cfif not isdefined('form.ContactName')><cfset form.ContactName="0"></cfif>
	<cfif not isdefined('form.ContactAddress')><cfset form.ContactAddress="0"></cfif>
	<cfif not isdefined('form.StateID')><cfset form.StateID="0"></cfif>
	<cfif not isdefined('form.ContactState')><cfset form.ContactState="0"></cfif>
	<cfif not isdefined('form.PayByInvoice')><cfset form.PayByInvoice="0"></cfif>
	<cfif #form.jobpay# eq ""><cfset form.jobpay=0></cfif>
	<cfquery name="getCompanySTate" dbtype="query">
		select stateid from allstates where statename='#form.state#' or stateabbrev='#form.state#'
	</cfquery>
	<cfif #GetCompanyState.recordcount# gt 0>
		<cfset companyStateID=#getCompanyState.stateid#>
	<cfelse>
		<cfset companyStateid=#form.state#>
	</cfif>
	<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,ContactName,StartDate,username,password,StateID,LocationCity,CompanyName,websiteURL,typeID">
	<CFSET FieldValues = "'#form.ContactName#' ,1,'#ccexpires#' ,'#form.ccno#' ,'#form.ccv#' ,'#form.ContactName#' ,'#dateformat(now(),'yyyy/mm/dd')#' ,'#form.username#' ,'#form.password#' ,'#companyStateid#' ,'#form.CITY#' ,'#form.CompanyName#' ,'#form.websiteURL#' ,#form.hotjob#">
	
	<cfif #employerid# eq "0">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employers (#fieldList#)
			values ('#form.ContactName#' ,1,'#ccexpires#' ,'#form.ccno#' ,'#form.ccv#' ,'#form.ContactName#' ,'#dateformat(now(),'yyyy/mm/dd')#' ,'#form.username#' ,'#form.password#' ,'#companyStateid#' ,'#form.CITY#' ,'#preservesinglequotes(form.CompanyName)#' ,'#form.websiteURL#' ,#form.hotjob#)
		</cfquery>
		<cfquery name="getMax" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select max(employerID) as NewID from employers
		</cfquery>
		<cfset NewEmployerID=#getMax.NewID#>
		<Cfset session.employerid=#newEmployerID#>
	
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "1,#newEmployerID#,'#form.Email#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeremail (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "2,#newEmployerID#,'#form.altemail#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeremail (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "1,#newEmployerID#,'#form.phone#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employerphone (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "3,#newEmployerID#,'#form.faxphone#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employerphone (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "2,#newEmployerID#,'#form.officephone#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employerphone (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>

		<cfquery name="getState" dbtype="query">
			select stateAbbrev from allstates
			where statename like '#form.state#' or stateabbrev ='#form.state#'
		</cfquery>
		<cfif getSTate.recordcount gt 0>
			<cfset companystate=getstate.stateabbrev>
		<cfelse>
			<cfset companystate=#form.state#>
		</cfif>
		<CFSET FieldList = "Address1,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#form.address#',1 ,'#form.City#' ,#newEmployerID#,'#form.zip# ','#companystate#' ,'#form.country#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeraddress (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
	<cfelse>
		<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			update employers set 
			CardName='#form.contactname#' ,
			Active=1,
			CCExpire='#ccexpires#' ,
			CCNo='#form.CCNo#' ,
			CCType='#form.CCV#' ,
			ContactName='#form.ContactName#' ,
			StartDate='#dateformat(form.startdate,'yyyy/mm/dd')#',
			username='#form.username#',
			password='#form.password#',
			StateID='#companyStateid#',
			LocationCity='#form.CITY#',
			CompanyName='#form.CompanyName#' ,
			websiteURL='#form.websiteURL#' ,
			typeid=#form.hotjob#
			where employerID=#employerID#
		</cfquery>
		<Cfset sessions.employerid=#EmployerID#>
		<cfset NewEmployerid=#employerID#>
	</cfif>

	<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		insert into jobs (JobDescription,JobTitle,DateCreated,JobType,JobImage,StateID,ContactState,LocationCity,ContactName,ContactAddress,Jobcategoryid,ContactCity,InvoiceInstructions,ContactInstructions,JobStarts,JobEnds,HotJob,ContactZip,ContactPhone,ContactFax,ContactEmail,JobPay,PayByInvoice,Status,employerID,JobDetails,JobPayPer)
		values (
		'#form.JobDescription#','#form.JobTitle#','#form.DateCreated#',#form.JobType#,'#form.JobImage#','#form.StateID#','#form.ContactState#','#form.LocationCity#','#form.ContactName#','#form.ContactAddress#','#form.Jobcategoryid#','#form.ContactCity#','#form.InvoiceInstructions#','#form.ContactInstructions#','#form.JobStarts#','#form.JobEnds#','#form.HotJob#','#form.ContactZip#','#form.ContactPhone#','#form.ContactFax#','#form.ContactEmail#',#form.JobPay#,#form.PayByInvoice#,1,#newEmployerID#,'#form.JobDetails#','#form.JobPayPer#')
	</cfquery>
	<cfquery name="getMax" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select max(jobID) as NewID from jobs
	</cfquery>
	<cfset NewJobID=#getMax.NewID#>
	
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="jobBoardConfig">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
		<cfinvokeargument name="IDFieldName" value="configID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfset txtSubject = "<A HREF=""#application.returnpath#/files/adminheader.cfm?JobID=#newJobID#&JobAction=Edit&action=jobsAdmin&alphabet=a"">View New Job Details</A>">
	
	<cfset txtSubject = "#txtSubject#<br><BR><A HREF=""#application.returnpath#/files/adminheader.cfm?employerid=#newEmployerID#&employerAction=Edit&action=newjobEmployers"">View New Employer Details</A>">
	
	<cfif #form.ccno# neq "" and isdefined('form.billinvoice')>
		<cfset txtSubject="#txtsubject#<br><br>This customer tried to process by credit card and it was either declined or the process failed">
	</cfif>
	
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="jobBoardConfig">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="jobBoardConfig">
		<cfinvokeargument name="IDFieldName" value="configID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="jobBoardConfig">
		<cfset EmployerEmailText='#replace(EmployerEmailText,"~",",","ALL")#'>			
	</cfoutput>
	
	<<cfif #form.mailinglistchoice# is 2>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=84168
		>
	</cfif>
	<cfif #form.mailinglistchoice# is 1>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=111604
		>
	</cfif>
	<cfif #form.mailinglistchoice# is 3>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=85033
		>
	</cfif>
	<cfif #form.mailinglistchoice# is 4>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=88473
		>
	</cfif>
	<cfif #form.mailinglistchoice# is 5>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=117958
		>
	</cfif>
	<cfif #form.mailinglistchoice# is 6>
	<cf_ecMListExternal
		email=#form.email#
		name=#form.contactname#
		AR=117551
		>
	</cfif>
	<cflocation url="adminheader.cfm?action=newspecialjobpost&employerID=0">
</cfif>

<cfoutput>

<cfif #int(startadd)# neq 0>

<cfif JobAction is "Update" or #JobAction# is "Add">
	<cfif #employerid# neq "0">
		<cfinclude template="../scripts/NEWgetemployerinfo.cfm">
	<cfelse>
		<cfinclude template="../scripts/getemployerempty.cfm">
	</cfif>
<script>
function getInfo() {
	document.thisform.Address.value=document.thisform.ContactAddress.value;
	document.thisform.City.value=document.thisform.ContactCity.value;
	//document.thisform.State.value=document.thisform.contactstate.value;
	document.thisform.zip.value=document.thisform.ContactZip.value;
	document.thisform.email.value=document.thisform.ContactEmail.value;
	document.thisform.phone.value=document.thisform.ContactPhone.value;
	document.thisform.faxphone.value=document.thisform.ContactFax.value;
}
</script>
<style>.bottomline td {border-bottom: dotted 1px ##cccccc;}</style>
<cfform action="adminheader.cfm?action=#action#" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="JobID" value="0000000000">
<input type="hidden" name="JobAction" value="#JobAction#">
<input type="Hidden" name="DateCreated" value="#dateformat(now(),'yyyy/mm/dd')#">
<input type="hidden" name="employerid" value="#employerid#">
<TABLE class=bottomline>
	<TR>
	  <TD ALIGN=middle colspan=3 BGCOLOR="##99CC99" HEIGHT="20">

<SPAN CLASS="heading"><A NAME="jobposting"></A>
		&nbsp;Step 1: Public Job Posting Information</SPAN>
	  </TD>
	</TR>
	<TR>
	<TD valign="top"> <strong>Job Title:</strong> </TD>
	<TD colspan=2>
	
		<INPUT type="text" name="JobTitle"  size=50 >
		
	</TD>
	</tr>
	<tr>
	<td valign=top> <strong>Job Category</strong> </td>
	<td colspan=2><cfselect name="Jobcategoryid" message="Please select at least one category" multiple="yes">
		<cfloop query="AllCAtegories">
			<option value="#AllCAtegories.categoryid#">#CategoryName#</option>
		</cfloop>
	</cfselect>
	<br>To select more then one category, hold the CTRL key down while clicking categories with your mouse.
	</td>
	</tr>
	<tr>
	<TD valign="top"> <strong>Upload Job Listing Image (optional):</strong></TD>
	<TD colspan=2>
		<input type="file" name="image">

		
	</TD>
	<!--- field validation --->
	</TR>	
	<tr>
	
	<td valign=top> <strong>Salary Information (optional)</strong> </td>
	<td colspan=2><input type="text" name="JobPay"> per <select name="JobPayPer">
	<option value="day">Day</option>
	<option value="week">Week</option>
	<option value="semimonth">Semi-Monthly</option>
	<option value="twoweeks">Two Weeks</option>
	<option value="month">Monthly</option>
	</select>
	</td>
	</tr>

	<input type="hidden" value="0" name="JobType">
	<input type="hidden" name="JobStarts" value="#dateformat(now(),'yyyy/mm/dd')#">
	<cfset tomorrow=#dateformat(dateadd("yyyy",1,now()),"yyyy/mm/dd")#>
	<input type="hidden" name="JobEnds" value="#tomorrow#">


	
	
	<input type="hidden" name="status" value="0">

	<tr>
	<td valign=top> <strong>Job Location City</strong> </td>
	<td colspan=2><input type="text" name="LocationCity" size=50 ></td>
	</tr>
	
	<tr>
	<td valign=top> <strong>Job Location State</strong> </td>
	<td colspan=2><cfselect name="StateID" message="Please select at least one state" size="5" required="yes" multiple="yes">
		<cfloop query="AllStates">
			<option value="#AllStates.StateID#">#stateName#</option>
		</cfloop>
		<OPTION value="999">Nationwide</OPTION> 
		<OPTION value="Australia">Australia</OPTION>
		<OPTION value="Canada">Canada</OPTION> 
		<OPTION value="United Kingdom">United Kingdom</OPTION>
		<OPTION value="Other Countries">Other Countries</OPTION>
	</cfselect><br>To select more then one state, hold the CTRL key down while clicking states with your mouse.
	</td>
	</tr>
	
	<tr>
		<td colspan=2><strong>Company Website</strong> <br><input type="text" name="websiteURL"  size=55 maxlength=255 value="#websiteurl#">
		</td>
	</tr>
		<TR>
	<TD valign="top" colspan=3> <strong>Full Job Description:</strong> Requirements, Qualifications, or any other information pertinent to job: <br>(plain text only - do not cut and paste from MS Word or Word Perfect unless it was saved as RTF format)<br><a href="javascript:GetEditor('thisform','JobDetails')">Click here for the editor</a><br>
		
		<TEXTAREA name="JobDetails" cols=155 rows=15></TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top" colspan=3> <strong>Company Description (optional)</strong><br>
	<a href="javascript:GetEditor('thisform','JobDescription')">Click here for the editor</a><br>
		<TEXTAREA name="JobDescription" cols=55 rows=5></TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR BGCOLOR="##99CC99">
          			  <TD ALIGN=middle colspan=3 HEIGHT="20"><SPAN CLASS="heading">&nbsp;Step 2. Public Contact Information for Applicants</SPAN> <SPAN CLASS="body">(How candidates should contact you)
</SPAN>					  </TD>
					</TR>
	<tr>
	<td valign=top> <strong>Contact Name</strong> </td>
	<td valign=top colspan=2> First: <cfinput name="Contact_first" type="text" size=50 required="yes" message="Please enter the contact first name"><br>
	Last: <cfinput type="text" name="Contact_last" size=50 required="yes" message="Please enter the contact last name"></td>
	</tr>
	<tr>
	<td valign=top> <strong>Address</strong> </td>
	<td colspan=2><input type="text" name="ContactAddress"  size=50></td>
	</tr>
	<tr>
	<td valign=top> <strong>City</strong> </td>
	<td colspan=2><input type="text" name="ContactCity" size=50></td>
	</tr>
	<tr>
	<td valign=top> <strong>State</strong> </td>
	<td valign=top colspan=2>
	<select name="contactstate">
		<cfloop query="AllStates">
			<option value="#AllStates.StateID#">#stateName#</option>
		</cfloop>
	</select>
	</td>
	</tr>
	<tr>
	<td valign=top> <strong>Postal Code</strong> </td>
	<td colspan=2><input type="text" name="ContactZip"></td>
	</tr>
	<tr>
	<td valign=top> <strong>Email</strong> </td>
	<td colspan=2><cfinput type="text" name="ContactEmail" size=50 required="yes" message="Please enter the contact email address"></td>
	</tr>
	<tr>
	<td valign=top> <strong>Phone</strong> </td>
	<td colspan=2><cfinput type="text" name="ContactPhone" required="yes" message="Please enter the contact phone number"></td>
	</tr>
	<tr>
	<td valign=top> <strong>Fax Number</strong> </td>
	<td colspan=2><input type="text" name="ContactFax"></td>
	</tr>
	<TR>
	<TD valign="top" colspan=3> <strong>Contact Instructions:</strong> <br>Specific Contact Instructions you might have go here (optional).<bR>
	
		<textarea name="ContactInstructions" cols=55 rows="5"></textarea>
		
	</TD>
	</tr>
	
	<TR>
	  <TD ALIGN=middle colspan=3 BGCOLOR="##99CC99" HEIGHT="20" CLASS="heading">
		Step 3. Private Billing and User Information (this info will not be displayed online)
	  </TD>
	</TR>
	<tr><td colspan=3><input type="checkbox" name="getinfo" onClick="getInfo()"> Check this box if the company address, email and phone information is the same as the contact information.</td></tr>
	<tr>
			<td><strong>Company Name</strong> </td>
			 <td colspan=2><cfinput type="text" name="companyname" value="#companyname#" size=50 required="yes" message="Please enter the contact company name"></td>
	</tr>
	<tr>
			<td valign=top><strong>Address</strong> </td>
			 <td colspan=2><input type="text" name="Address" value="#address#"  size=50><br><input type="text" name="Address2" size=50 value="#address2#"></td>
	</tr>
	<tr>
			<td><strong>City</strong> </td>
			 <td colspan=2><input type="text" name="City" value="#city#" size=50></td>
	</tr>
	<tr>
			<td><strong>State</strong> </td>
			 <td colspan=2><input type="text" name="State" value="#state#" size=50></td>
	</tr>
	<tr>
			<td><strong>Postal Code</strong> </td>
			 <td colspan=2><input type="text" name="zip" value="#zip#" size=15></td>

	</tr>
	<tr>
			<td><strong>Country</strong> </td>
			 <td colspan=2><select name="Country">
			 	<cfif #country# neq ""><option value="#country#">#country#</option></cfif>
				<cfinclude template="../files/countries.htm">
			 </select></td>
	</tr>
	<tr>
			<td><strong>Office Phone</strong> </td>
			 <td colspan=2><cfinput type="text" name="phone" value="#phone#" size=25 required="yes" message="Please enter the company phonenumber"></td>
	</tr><tr>
			<td><strong>Other Phone</strong> </td>
			 <td colspan=2><input type="text" name="officephone" value="#officephone#" size=25></td>
	</tr>
	<tr>
			<td><strong>Fax Phone</strong> </td>
			 <td colspan=2><input type="text" name="faxphone" value="#faxphone#" size=25></td>
	</tr>
	<tr>
			<td><strong>Email Address</strong> </td>
			 <td colspan=2><cfinput type="text" name="email" value="#email#" size=50 required="yes" message="Please enter the company email address"></td>
	</tr>
	
		<tr>
			<td><strong>Alternate Email Address (optional)</strong></td>
			<td colspan=2><input type="text" name="altemail" value="#altemail#" size=50></td>
		</tr>
		<input type="hidden" name="active" value="#active#">
		<input type="Hidden" name="startdate" value="#startdate#">
	
		<tr>
	<td valign=top colspan=3> <strong>Employers</strong> (please check one)  <br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employerTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employerTypes">
		<cfinvokeargument name="orderbystatement" value=" order by typeprice">
	</cfinvoke>
	<cfif #employerTypes.recordcount# gt 1>
	<p><strong>Please select the type of access you would like to your personal resume page.</strong></p>
	<cfset hCount=0>
	<cfloop query="employerTypes">
		<cfif #showonpage# is #Page#>
			<cfif hCount is 0>
			<Cfset hCount=1>
			<input type="radio" name="HotJob" value="#employerTypeID#" checked> <strong>#TypeName#</strong> #replace(TypeDescription,"~",",","ALL")# #dollarformat(typePRice)#<br>
		<input type="hidden" name="HotJobPrice#employerTypeID#" value="#typePRice#">
			<cfelse>
		<input type="radio" name="HotJob" value="#employerTypeID#"> <strong>#TypeName#</strong> #replace(TypeDescription,"~",",","ALL")# #dollarformat(typePRice)#<br>
		<input type="hidden" name="HotJobPrice#employerTypeID#" value="#typePRice#">
			</cfif>
		</cfif>
	</cfloop>
	<cfelseif #employeeTypes.recordcount# is 1>
		<input type="hidden" name="HotJob" value="#employerTypes.employerTypeID#">
		<input type="hidden" name="HotJobPrice#employerTypeID#" value="#typePRice#">
	<cfelse>
		<input type="hidden" name="HotJob" value="0">
		<input type="hidden" name="HotJobPrice0" value="0">
	</cfif><br>

		</td>
	</tr>
	<TR>
	  <TD ALIGN=middle COLSPAN=3 HEIGHT="20" CLASS="heading" BGCOLOR="##99CC99">
		  Step 4: Personal Profile Access
	  </TD>
	</TR>
	<tr><td colspan=3><p>-Make sure to create a Username and Password to store billing and contact information to streamline future postings. <br> 
-This will also allow you access to the Resume Database for 30 days.<br> 
-We NEVER share any of this information with anyone!!  <br> 
-Send me an email if you have any questions or require assistance.  Thank you for your business: <a href="mailto:#application.email#">#application.email#</a></p></td></tr>	<tr>
			<td><strong>User Name</strong> </td>
			 <td colspan=2><cfinput type="text" name="username" value="#username#" size=45 required="yes" message="Please enter a username"></td>
	</tr>
	<tr>
			<td><strong>Password</strong> </td>
			 <td colspan=2><cfinput type="Password" name="Password" value="#password#" size=45 required="yes" message="Please enter a password"></td>
	</tr>
	
	<TR>
	  <TD ALIGN=middle COLSPAN=3 HEIGHT="20" CLASS="heading" BGCOLOR="##99CC99">
		  Step 5: Payment Information
	  </TD>
	</TR>
	
	<tr>
	<td valign=top colspan=3>Use this form to supply your credit card information or the address to which you would like your invoice sent. If paying with Credit card, please make sure that the information you submit matches the billing address and phone number on file with your credit card company. If you need assistance, you may call 608.338.5052 or send email to <a href="mailto:jobposts@exercisecareers.com">jobposts@exercisecareers.com</a><br><br>

Please provide a valid credit card number and expiration date. Credit card numbers may include dashes<br><BR> Visa, MasterCard, and American Express cards accepted.
	</TD>
	</TR>
	<tr>
		<td>Credit Card Number<br><input type="text" name="ccno" size=30></td>
		<td align=center>Expiration<br><select name="ExpMonth" size="1"><option value="01">January<option value="02">February<option value="03">March<option value="04">April<option value="05">May<option value="06">June<option value="07">July<option value="08">August<option value="09">September<option value="10">October<option value="11">November<option value="12">December</select>&nbsp;&nbsp;&nbsp;&nbsp;<select name="ExpYear" size="1"><option value="2004">2004<option value="2005">2005<option value="2006">2006<option value="2007">2007<option value="2008">2008<option value="2009">2009<option value="2010">2010<option value="2011">2011<option value="2012">2012<option value="2013">2013<option value="2014">2014<option value="2015">2015<option value="2016">2016<option value="2017">2017<option value="2018">2018</select></td>
		<td>CCV<br><input type="text" size=5 name="CCV"></td>
	</tr>
	<tr><td colspan=3><input name="billInvoice" type="checkbox" value="Yes" checked> OR Check here if you wish to be billed via invoice.<br><BR>
	<strong>Invoicing Instructions:</strong><br>
	
		<textarea name="InvoiceInstructions" cols=55 rows="5"></textarea>
</td></tr>
	<tr><td colspan=3>Mailing list choice: <select name="mailinglistchoice">
				<option value=1>Contract Client</option>
				<option value=2>EC Customer NEW</option>
				<option value=3>EC Potential Customer</option>
				<option value=4>EC Customer</option>
				<option value=5>EC Customer - Internship</option>
				<option value=6>EC Potential Customer - Internship</option>
			</select>

		</td>
	</tr>
	<TR>
	  <TD ALIGN=middle COLSPAN=3 HEIGHT="20" CLASS="heading" BGCOLOR="##99CC99">
		  Step 6: Submit Job Posting
	  </TD>
	</TR>
	<tr><td colspan=3>Please review your information carefully. Once you click "Submit", the listing will be reviewed by EC staff and then approved for listing within the searchable database. Job listings will automatically expire within 30 days unless advised otherwise. <br><BR>

Thank you<br><BR>

If you need assistance, <a href="mailto:#application.email#">contact us</a> <br><br>
<!--- form buttons --->
<INPUT type="submit" name="submit" value="Submit Job Posting"> <input type="reset">
</td></tr>
</TABLE>
	


</cfFORM><div id="tipDiv" style="position:absolute; visibility:hidden; z-index:100"></div>

</cfif>

	


<cfelse>
	<cfquery name="allEmployers" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select employerid,companyname from employers order by companyname
	</cfquery>
	<form action="adminheader.cfm?action=#action#" method=post>
	<input type="hidden" name="startAdd" value="1" />
	Select an employer: <select name="employerid">
		<option value="0">New Employer</option>
		<cfloop query="allemployers">
		<option value="#employerid#">#companyname#</option>
		</cfloop>
	</select>
	<br>
	<input type="submit" name="selectemployersubmit" value="Select Employer">
	</form>
</cfif>
</CFOUTPUT>