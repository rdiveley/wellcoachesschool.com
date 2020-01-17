<cfparam name="alphabet" default="a">
<cfparam name="EmployeeID" default=0>
<cfparam name="EmployeeAction" default="List">
<cfparam name="CardName" default="none">
<cfparam name="CCExpire" default="none">
<cfparam name="date_posted" default="#now()#">
<cfparam name="LINK" default="">
<cfparam name="firstname" default="none">
<cfparam name="lastname" default="none">
<cfparam name="Active" default="1">
<cfparam name="username" default="">
<cfparam name="CCNo" default="">
<cfparam name="CCType" default="">
<cfparam name="JobCategoryID" default="">
<cfparam name="password" default="">
<cfparam name="StateID" default="">
<cfparam name="tStateID" default="">
<cfparam name="LocationCity" default="">
<cfparam name="MilesFromHome" default="0">
<cfparam name="websiteURL" default="">
<cfparam name="title" default="">
<cfparam name="address" default="">
<cfparam name="address2" default="">
<cfparam name="city" default="">
<cfparam name="state" default="">
<cfparam name="zip" default="">
<cfparam name="country" default="">
<cfparam name="phone" default="">
<cfparam name="officephone" default="">
<cfparam name="faxphone" default="">
<cfparam name="email" default="">
<cfparam name="username" default="">
<cfparam name="password" default="">
<cfparam name="EmailID" default="0">
<cfparam name="addressid" default="0">
<cfparam name="phoneID" default="0">
<cfparam name="faxID" default="0">
<cfparam name="resume" default=" ">
<cfparam name="resumeID" default="0">
<cfparam name="typeid" default="1">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllEmployees">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Employees">
</cfinvoke>

<cfif EmployeeAction is "delete">
	<cfquery name="getold" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select OldEmployeeID from employees where employeeid=#employeeid#
	</cfquery>
	<cfset OldEmployeeID=#getOld.OldEmployeeID#>
	<cfquery name="delete" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		delete from employees where employeeID=#employeeID#
		delete from employeephone where connectid=#employeeid#
		delete from employeeemail where connectid=#employeeid#
		delete from employeeaddress where connectid=#employeeid#
	</cfquery>
	
	<cfif FileExists("#application.uploadpath#\files\resumes\r#trim(employeeID)#")>
		<cffile action="delete" file="#application.uploadpath#\files\resumes\r#trim(employeeID)#">
	<cfelseif FileExists("#application.uploadpath#\files\resumes\r#trim(oldemployeeID)#")>
		<cffile action="delete" file="#application.uploadpath#\files\resumes\r#trim(oldemployeeID)#">
	</cfif>
	<cfset EmployeeID=0>
	<cfset EmployeeAction="List">
</cfif>
		
<cfif EmployeeID gt 0>

	<cfquery name="employees" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select employees.* , employeephone.phoneID, employeephone.phonenumber,
		employeeemail.emailid, employeeemail.emailaddress,
		employeeaddress.addressid, employeeaddress.address1, employeeaddress.address2,
		employeeaddress.city, employeeaddress.state, employeeaddress.country, 
		employeeaddress.PostalCode
		from employees, employeephone, employeeemail, employeeaddress 
		where employeeid=#employeeID#
		and employeephone.connectid=employees.employeeid
		and employeephone.PhoneTypeID=1
		and employeeemail.connectid=employees.employeeid
		and employeeemail.emailTypeID=1
		and employeeaddress.connectid=employees.employeeid
		and employeeaddress.AddressTypeID=1
	</cfquery>

	<cfquery name="employeefaxphone" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employeephone where phonetypeID=3 and connectID=#employeeid#
	</cfquery>

	<cfif employees.recordcount is 0>
		<cfquery name="employees" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employees.*
			from employees
			where employeeid=#employeeID#
		</cfquery>
		<cfquery name="Ephone" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employeephone.*
			from employeephone
			where connectID=#employeeID#
		</cfquery>
		<cfquery name="Eemail" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employeeemail.*
			from employeeemail
			where connectID=#employeeID#
		</cfquery>
		<cfquery name="Eaddress" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employeeaddress.*
			from employeeaddress
			where connectID=#employeeID#
		</cfquery>
		<cfoutput query="employees">
			<cfset Active=#Active#>
			<cfset StartDate=#StartDate#>
			<cfset CCExpire=#CCExpire#>
			<cfset CCNo=#CCNo#>
			<cfset CCType=#CCType#>
			<cfset firstname=#replace(firstname,"~",",","ALL")#>
			<cfset StateID=#StateID#>
			<cfset MilesFromHome=#MilesFromHome#>
			<cfset jobcategoryID=#replace(jobcategoryid,"~",",","ALL")#>
			<cfset tStateID=#trim(stateid)#>
			<cfset LocationCity=#LocationCity#>
			<cfset lastname=#replace(lastname,"~",",","ALL")#>
			<cfset title=#replace(title,"~",",","ALL")#>
			<cfset websiteURL=#websiteURL#>
			<cfset username=#username#>
			<cfset password=#password#>
			<Cfset typeid=#trim(typeid)#>
			<cfset OLDEMPLOYEEID =#employeeid#>
		</cfoutput>
		<cfoutput query="Eaddress">
			<cfset AddressID=#addressID#>
			<cfset address=#address1#>
			<cfset address2=#address2#>
			<cfset address2=#address2#>
			<cfset city=#city#>
			<cfset state=#state#>
			<cfset zip=#postalcode#>
			<cfset country=#country#>
		</cfoutput>
		<cfoutput query="Ephone">
			<Cfset phoneID=#phoneID#>
			<cfset phone=#phonenumber#>
		</cfoutput>
		<cfoutput query="eEmail">
			<cfset emailID=#emailID#>
			<cfset email=#emailaddress#>
		</cfoutput>
	<cfelse>
		<cfoutput query="employees">
			<cfset Active=#Active#>
			<cfset StartDate=#StartDate#>
			<cfset CCExpire=#CCExpire#>
			<cfset CCNo=#CCNo#>
			<cfset CCType=#CCType#>
			<cfset firstname=#replace(firstname,"~",",","ALL")#>
			<cfset StateID=#StateID#>
			<cfset MilesFromHome=#MilesFromHome#>
			<cfset jobcategoryID=#replace(jobcategoryid,"~",",","ALL")#>
			<cfset tStateID=#trim(stateid)#>
			<cfset LocationCity=#LocationCity#>
			<cfset lastname=#replace(lastname,"~",",","ALL")#>
			<cfset title=#replace(title,"~",",","ALL")#>
			<cfset websiteURL=#websiteURL#>
			<cfset username=#username#>
			<cfset password=#password#>
			<Cfset typeid=#trim(typeid)#>
			<cfset AddressID=#addressID#>
			<cfset address=#address1#>
			<cfset address2=#address2#>
			<cfset username=#username#>
			<cfset password=#password#>
			<cfset address2=#address2#>
			<cfset city=#city#>
			<cfset state=#state#>
			<cfset zip=#postalcode#>
			<cfset country=#country#>
			<Cfset phoneID=#phoneID#>
			<cfset phone=#phonenumber#>
			<cfset emailID=#emailID#>
			<cfset email=#emailaddress#>
			<cfset OldEmployeeID=#OldEmployeeID#>
		</cfoutput>
	</cfif>
	<cfoutput query="employeefaxphone">
		<cfset faxPhoneID=#phoneID#>
		<cfset faxphone=#phonenumber#>
	</cfoutput>
	
	<cfif FileExists("#application.uploadpath#\files\resumes\r#trim(employeeID)#.xml")>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="thisresume">
			<cfinvokeargument name="ThisPath" value="files/resumes">
			<cfinvokeargument name="ThisFileName" value="r#trim(employeeID)#">
		</cfinvoke>
	<cfelse>here
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="thisresume">
			<cfinvokeargument name="ThisPath" value="files/resumes">
			<cfinvokeargument name="ThisFileName" value="r#trim(OldEmployeeid)#">
		</cfinvoke>
	</cfif>
	<cfif #thisresume.recordcount# gt 0>
		<cfset resume=replace(#thisresume.resume#,"~",",","ALL")>
		<cfset resumeID=#thisresume.resumeid#>
	<cfelse>
		<cfset resume="">
		<cfset resumeID=0>
	</cfif>
	<cfset employeeAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.firstname# is ''><cfset form.firstname="none"></cfif>
	<cfif #form.lastname# is ''><cfset form.lastname="none"></cfif>
	<cfif not isdefined('form.LocationCity')><cfset form.LocationCity="0"></cfif>
	<cfif not isdefined('form.StateID')><cfset form.StateID="0"></cfif>
	<cfif isdefined('form.nationwide')><cfset stateid=999></cfif>
	
	<cfif EmployeeID gt 0>
		<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			update employees set 
			CardName='#Trim(form.firstname)# #trim(form.lastname)#' ,
			Active=#form.active#,
			firstname='#form.firstname#' ,
			lastname='#form.lastname#' ,
			username='#form.username#',
			password='#form.password#',
			StateID='#form.StateID#',
			LocationCity='#form.LocationCity#',
			MilesFromHome='#form.MilesFromHome#' ,
			websiteURL='#form.websiteURL#' ,
			typeid=#form.typeid#,
			Title='#form.Title#',
			JobCategoryID='#form.Jobcategoryid#'
			where EmployeeID=#EmployeeID#
		</cfquery>
		<cfset NewEmployeeID=#EmployeeID#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#form.address1#' ,'#form.address2#' ,1,'#form.city#' ,#newEmployeeID#, '#form.zip#','#form.state#' ,'#form.country#' ">
		<cfif #addressid# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeEaddress
					set address1='#form.address1#',
					address2='#form.address2#',
					city='#form.city#',
					postalcode='#form.zip#',
					state='#form.state#',
					country='#form.country#'
				where addressID=#addressid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeEaddress (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "1,#newEmployeeID#,'#form.email#' ">
		<cfif #EmailID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeeemail
					set emailaddress='#form.email#'
				where emailID=#emailid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeeemail (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>

		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "1,#newEmployeeID#,'#form.telephone#' ">
		<cfif #PHoneID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeephone
					set phonenumber='#form.telephone#'
				where phoneID=#PHoneID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeephone (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "3,#newEmployeeID#,'#form.fax#' ">
		<cfif #faxPHoneID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeephone
					set phonenumber='#form.fax#'
				where phoneID=#faxPHoneID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeephone (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<cfquery name="getold" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select OldEmployeeID from employees where employeeid=#employeeid#
		</cfquery>
		<cfset OldEmployeeID=#getOld.OldEmployeeID#>
	
		<cfif FileExists("#application.uploadpath#\files\resumes\r#trim(oldemployeeID)#")>
			<cfinvoke method="SaveResume" 
				component="#application.websitepath#.utilities.jobboard" returnvariable="resumeID">
				<cfinvokeargument name="ResumeID" value="#resumeID#">
				<cfinvokeargument name="EmployeeID" value="#EmployeeID#">
				<cfinvokeargument name="Resume" value="#form.resume#">
				<cfinvokeargument name="Title" value="#form.Title#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="SaveResume" 
				component="#application.websitepath#.utilities.jobboard" returnvariable="resumeID">
				<cfinvokeargument name="ResumeID" value="#resumeID#">
				<cfinvokeargument name="EmployeeID" value="#employeeid#">
				<cfinvokeargument name="Resume" value="#form.resume#">
				<cfinvokeargument name="Title" value="#form.Title#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfset FieldList="active,cardname,ccexpire,ccno,cctype,jobcategoryid,startdate,firstname,lastname,username,password,stateid,locationcity,milesfromhome,websiteurl,title,typeid">
		<cfset fieldData="0,'#form.firstname# #form.lastname#','','','','#form.jobcategoryid#','#dateformat(now())#','#form.firstname#','#form.lastname#','#form.username#','#form.password#','#form.stateid#','#form.locationcity#',#form.milesfromhome#,'#form.websiteurl#','#form.title#',#form.typeid#">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employees (#fieldlist#) values(
			#preserveSingleQuotes(fielddata)#)
		</cfquery>
		<cfquery name="getMaxID" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select max(employeeid) as newid from employees
		</cfquery>
		<cfset newEmployeeid=#getMaxID.newid#>
		
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#form.address1#' ,'#form.address2#' ,1,'#form.city#' ,#newEmployeeID#, '#form.zip#','#form.state#' ,'#form.country#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeEaddress (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "1,#newEmployeeID#,'#form.email#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeeemail (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "1,#newEmployeeID#,'#form.telephone#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeephone (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>

		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "3,#newEmployeeID#,'#form.fax#' ">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeephone (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>

		<cfinvoke method="SaveResume" 
			component="#application.websitepath#.utilities.jobboard" returnvariable="resumeID">
			<cfinvokeargument name="ResumeID" value="0000000000">
			<cfinvokeargument name="EmployeeID" value="#newEmployeeID#">
			<cfinvokeargument name="Resume" value="#form.resume#">
			<cfinvokeargument name="Title" value="#form.Title#">
		</cfinvoke>
	</cfif>
	<Cflocation url="adminheader.cfm?action=jobEmployees&alphabet=#left(form.lastname,1)#">
</cfif>
 
<cfoutput>
<style>p {color: black;}</style>
<h1>Resumes</h1>

<cfif EmployeeAction is "Add" or EmployeeAction is "Update">
<!--- <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllResumes">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Resumes">
</cfinvoke> --->
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllCategories">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="JobCategories">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="states">
</cfinvoke>
<cfform name="formmain" action="adminheader.cfm?action=#action#" method="post">
<input type="hidden" name="employeeid" value="#EmployeeID#">
<input type="hidden" name="employeeaction" value="#employeeaction#">
<input type="hidden" name="emailid" value="#emailid#">
<input type="hidden" name="phoneID" value="#phoneID#">
<input type="hidden" name="faxID" value="#faxID#">
<input type="hidden" name="addressID" value="#addressID#">
<input type="hidden" name="typeid" value="#typeid#">
<input type="hidden" name="resumeID" value="#resumeID#">
<TABLE border=0 cellpadding=0 cellspacing=0 WIDTH="80%" align=center>
<TR>
<TD colSpan=2 HEIGHT="20" BGCOLOR="##F1A43F"><SPAN CLASS="heading"><FONT COLOR="##FFFFFF">&nbsp;</FONT>Step 1: Public Resume Posting Information</SPAN></TD>
</TR>
<TR>
<TD HEIGHT="50"><SPAN CLASS="body"><SPAN CLASS="heading">Status </SPAN></td>
<td>
	<cfif #active# is 0>
		<input type="radio" name="active" value="0" checked> Pending<br>
		<input type="radio" name="active" value="1"> Active
	<cfelse>
		<input type="radio" name="active" value="0"> Pending<br>
		<input type="radio" name="active" value="1" checked> Active
	</cfif>
</td>

</tr>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="body"><SPAN CLASS="heading">Job Category</SPAN> (Select the closest match)<BR>
<select name="Jobcategoryid" multiple>
		<cfloop query="AllCAtegories">
			<option value="#AllCAtegories.categoryid#"<cfif listfind(#jobcategoryid#,#allcategories.categoryid#)> selected</cfif>>#CategoryName#</option>
		</cfloop>
	</select>
</SPAN>
</tr>
<TR VALIGN="MIDDLE">
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="body"><SPAN CLASS="heading">Specific Job Title </SPAN></SPAN><FONT
face="Verdana, Arial, Helvetica, sans-serif"><BR>
<INPUT size=50 name="title" maxlength=100 value="#title#">
</FONT>

</tr>
<TR>
<TD colSpan=2><SPAN CLASS="body">

<SPAN CLASS="heading">Paste the objective and body of your resume here</SPAN>&nbsp;&nbsp;(plain text only)<BR>
<SPAN CLASS="body"><a href="javascript:GetEditor('formmain','resume')" class=box>Click here for the editor</a><br>
<TEXTAREA NAME="resume" ROWS=8 WRAP=PHYSICAL COLS=70>#resume#</TEXTAREA>
</SPAN>						
</SPAN>

</tr>
<TR>
<TD colSpan=2 height=50><SPAN CLASS="body"><SPAN CLASS="heading">Location: City</SPAN><BR>
<INPUT size=50 name=locationcity maxlength=50 value="#locationcity#">
</SPAN></TD
>
</tr>
<TR>
<TD colSpan=2 height=50><SPAN CLASS="heading">&nbsp;Location: State or Country</SPAN><BR>


<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR>
<TD CLASS="body">
<select name="StateID" size="5" multiple>
<cfloop query="AllStates">
<option value="#AllStates.StateID#"<cfif listfind(#tstateID#,#allstates.stateid#)> selected</cfif>>#stateName#</option>
</cfloop>
<OPTION value="999"<cfif listfind(#tstateID#,"999")> selected</cfif>>Nationwide</OPTION> 
<OPTION value="Australia"<cfif listfind(#tstateID#,"Australia")> selected</cfif>>Australia</OPTION>
<OPTION value="Canada"<cfif listfind(#tstateID#,"Canada")> selected</cfif>>Canada</OPTION> 
<OPTION value="United Kingdom"<cfif listfind(#tstateID#,"United Kingdom")> selected</cfif>>United Kingdom</OPTION>
<OPTION value="Other Countries"<cfif listfind(#tstateID#,"Other Countries")> selected</cfif>>Other Countries</OPTION>
</select>
</TD>
<TD>&nbsp;

</TD>
<TD VALIGN="TOP">
<SPAN CLASS="body"><cfif #tStateID# is "999"><input type="checkbox" name="nationwide" checked><cfelse><INPUT TYPE=checkbox NAME=nationwide></cfif>Would you consider Nationwide jobs outside of your State or Country?</SPAN><BR>
<SPAN CLASS="body">&nbsp;(Check here to be included on the nationwide resume listing.)</SPAN>
<!--- <br><br>or enter the number of miles from your home you would be willing to accept a position from ---> <input name="milesfromhome" type="hidden" size=15 required="no" validate="integer" value="0"></TD>
</TR>
</TABLE>
</td>
</tr>
<TR>
<TD colSpan=2 BGCOLOR="##F1A43F">
<SPAN CLASS="heading">&nbsp;<FONT COLOR="##FFFFFF">&nbsp;</FONT>Step 2. How companies and colleagues should contact you.</SPAN>
</TD>
</TR>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">Your Name<BR>
<cfINPUT size=35 name="firstname" value="#firstname#" maxlength=50 required="yes" message="please enter your first name"> <cfINPUT size=35 name="lastname" value="#lastname#" maxlength=50 required="yes" message="please enter your last name"></SPAN>

</TD>
</TR>
<TR>
<TD CLASS="body" vAlign=top colSpan=2>

<SPAN CLASS="body"><SPAN CLASS="heading">Contact Information and 
Instructions </SPAN>
</td>
</tr>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">Address<BR>
<INPUT size=35 name="address1" value="#address#" maxlength=50> <INPUT size=35 name="address2" value="#address2#" maxlength=50></SPAN>

</TD>
</TR>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">
City: <INPUT size=25 name="city" maxlength=50 value="#city#"> State: <INPUT size=25 name="state" value="#state#" maxlength=50><br>
Postal Code: <INPUT size=15 name="zip" maxlength=50 value="#zip#"></SPAN>

</TD>
</TR>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">Country<BR>
<INPUT size=35 name="Country" value="#Country#" maxlength=50></SPAN>

</TD>
</TR>
<TR>
<TD CLASS="body" colSpan=2 HEIGHT="50">

<SPAN CLASS="body"><SPAN CLASS="heading">Telephone</SPAN> (optional)<BR>
<INPUT size=50 maxlength=50 name="telephone" value="#phone#">
</SPAN>
</td>
</tr>
<TR>
<TD CLASS="body" colSpan=2 HEIGHT="50">

<SPAN CLASS="body"><SPAN CLASS="heading">Fax</SPAN> (optional)<BR>
<INPUT maxlength=50 size=50 name="fax" value="#faxphone#">
</SPAN>
</td>
</tr>
<TR>
<TD CLASS="body" colSpan=2 HEIGHT="50">

<SPAN CLASS="body"><SPAN CLASS="heading">Email</SPAN><BR>
<INPUT size=50 name="email" maxlength=255 value="#email#">
</SPAN>
</td>
</tr>
<TR>
<TD CLASS="body" colSpan=2 HEIGHT="50">

<SPAN CLASS="body"><SPAN CLASS="heading">Homepage</SPAN> (optional)<BR>
<SPAN CLASS="heading">http://</SPAN>


<INPUT size=42 name='websiteurl' maxlength=255 value="#websiteurl#">
</SPAN>
</td>
</tr>
<TR>
<TD colSpan=2 BGCOLOR="##F1A43F">
<SPAN CLASS="heading">&nbsp;<FONT COLOR="##FFFFFF">&nbsp;</FONT>Step 3. Enter a username and password</SPAN><BR>
</TD>
</TR>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">User Name<BR>
<cfINPUT name="username" type="text" size=45 maxlength=255 value="#username#" required="yes" message="Please enter a username"></SPAN>

</TD>
</TR>
<TR>
<TD colSpan=2 HEIGHT="50"><SPAN CLASS="heading">Password<BR>
<cfINPUT type="text" size=45 name="password" value="#password#" maxlength=255 required="yes" message="please enter a password"></SPAN>

</TD>
</TR>
<tr><td></td><td>
<INPUT type=submit value="Submit Resume" name=submit>
<INPUT TYPE="reset" VALUE="Reset" onClick="return confirm('Are you sure you wish to reset the form?');" NAME="reset">
</td></tr>
</TABLE>
</cfFORM>
</cfif>
</CFOUTPUT>

<cfif EmployeeAction is "list">
<cfoutput>
<style>p {color: black;}</style>
<a href="adminheader.cfm?Action=#Action#&EmployeeAction=Add">Add A Resume</a></cfoutput><br>
	<cfquery name="AllEmployees" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employees
		<cfif #alphabet# neq "all">
		where lastname like '#alphabet#%' or lastname like '#ucase(alphabet)#%'
		</cfif>
		order by StartDate desc
	</cfquery>
	<cfif #allEmployees.recordcount# gt 0>
	<cfoutput><a href="adminheader.cfm?action=#action#&alphabet=all">Click here to see them all</a>
	<a href="adminheader.cfm?Action=#action#&alphabet=a">A</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=b">B</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=c">C</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=d">D</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=e">E</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=f">F</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=g">G</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=h">H</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=i">I</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=j">J</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=k">K</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=l">L</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=m">M</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=n">N</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=o">O</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=p">P</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=q">Q</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=r">R</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=s">S</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=t">T</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=u">U</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=v">V</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=w">W</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=x">X</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=y">Y</a> | 
	<a href="adminheader.cfm?Action=#action#&alphabet=z">Z</a>
	<table border="1" align="CENTER">
	<th colspan="7" align="CENTER" bgcolor="Maroon"><p>All Resumes</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>Website</p></td>
	<td><p>Authorized</p></td>
	<td><p>Date to Start</p></td>
	<td><p>Actions</p></td>
	</tr></cfoutput>
		
	<cfoutput query="AllEmployees">
	<tr>
	<td><p>#EmployeeID#</p></td>
	<td><p>#firstName# #lastname#</p></td>
	<td><p>#WebsiteURL#</p></td>
	<td align=center><p><cfif #active# is 1>Yes<cfelse>No</cfif></p></td>
	<td><p>#dateformat(StartDate,'mm/dd/yyyy')#</p></td>
	<td><a href= "adminheader.cfm?EmployeeID=#EmployeeID#&EmployeeAction=Edit&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?EmployeeID=#EmployeeID#&EmployeeAction=Delete&action=#action#')">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

