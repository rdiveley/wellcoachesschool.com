<cfset goahead=1>

<cfif isDefined('form.submitemployer')>
	<cfparam name="sortBY" default="companyname">
	<cfset goahead=0>
	<CF_aGr_password	MODE="ALPHA"
		CASE="MIXED"
		LENGHT="15"
		VAR="Download">
	
	<cfset TheFieldNames=''>
	<cfloop index="iField" list="#form.RegistrationFields#">
		<cfset TheFieldNames=ListAppend(#theFieldNames#,#iField#)>
	</cfloop>
	<cfset TheFieldData="">
	<cfloop index="iField" list="#TheFieldNames#">
		<cfswitch expression="#iField#">
			<cfcase value="companyname">
				<cfset TheFieldData=listappend(#TheFieldData#,"employers.companyname")>
			</cfcase>
		   <cfcase value="contactname">
				<cfset TheFieldData=listappend(#TheFieldData#,"employers.contactname")>
			</cfcase>
          <cfcase value="address">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactaddress")>
			</cfcase>
		  <cfcase value="city">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactcity")>
			</cfcase>
          <cfcase value="state">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactstate")>
			</cfcase>
          <cfcase value="zip">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactzip")>
			</cfcase>
		  <cfcase value="phone">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactphone")>
			</cfcase>
          <cfcase value="emailaddress">
		  		<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactemail")>
			</cfcase>
          <cfcase value="faxphone">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.contactfax")>
			</cfcase>
		  <cfcase value="websiteurl">
				<cfset TheFieldData=listappend(#TheFieldData#,"employers.websiteurl")>
			</cfcase>
		<cfcase value="startdate">
				<cfset TheFieldData=listappend(#TheFieldData#,"jobs.datecreated")>
			</cfcase>
		<cfcase value="locationcity">
				<cfset TheFieldData=listappend(#TheFieldData#,"employers.LocationCity")>
			</cfcase>
		<cfcase value="stateID">
				<cfset TheFieldData=listappend(#TheFieldData#,"employers.StateID")>
			</cfcase>
		</cfswitch>
	</cfloop>
	<cfquery name="allemployers" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select #theFieldData#
		from employers , jobs
		where jobs.employerid=employers.employerid
		order by jobs.#sortby# asc
	</cfquery>
	<cfheader name="Content-Disposition" value="inline; filename=#download#.xls">
	<cfcontent type="application/msexcel">
	<table border="1" cellspacing="0">
		 <thead>
		 <tr>
		 	<cfloop index="iField" list="#TheFieldNames#">
			  <th width="200"><div align="left"><cfoutput>#iField#</cfoutput></div></th>
			</cfloop>
		   </tr>
	  </thead>
		  <tbody>
			<cfoutput query="AllEmployers">
			  <tr align="left">
			  <cfloop index="iField" list="#TheFieldNames#">
			   <td>#evaluate(iField)#</td>
			  </cfloop>
			  </tr>
			</cfoutput>
		  </tbody>
	</table>

</cfif>
<cfif isDefined('form.submitemployee')>
	<cfset goahead=0>
	<CF_aGr_password	MODE="ALPHA"
		CASE="MIXED"
		LENGHT="15"
		VAR="Download">
	
	<cfset TheFieldNames=''>
	<cfloop index="iField" list="#form.RegistrationFields#">
		<cfset TheFieldNames=ListAppend(#theFieldNames#,#iField#)>
	</cfloop>
	<cfparam name="sortBY" default="lastname">
	<cffile action="append" file="#Application.Uploadpath#\files\downloads\#Download#.csv" output="#TheFieldNames#" addnewline="yes">
	<cfset TheFieldData=''>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllEmployees">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Employees">
		<cfinvokeargument name="orderbystatement" value=" order by #sortby# asc">
	</cfinvoke>
	<cfoutput query="AllEmployees">
	<cfset TheFieldData="">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employeephone">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeephone">
		<cfinvokeargument name="selectstatement" value=" where connectid='#Employeeid#' and phonetypeid='1'">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employeefaxphone">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeephone">
		<cfinvokeargument name="selectstatement" value=" where connectid='#Employeeid#' and phonetypeid='3'">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employeeaddress">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeeaddress">
		<cfinvokeargument name="selectstatement" value=" where connectid='#Employeeid#' and addresstypeid='1'">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="employeeemail">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="employeeemail">
		<cfinvokeargument name="selectstatement" value=" where connectid='#Employeeid#' and emailtypeid='1'">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="thisresume">
		<cfinvokeargument name="ThisPath" value="files/resumes">
		<cfinvokeargument name="ThisFileName" value="r#Employeeid#">
		<!--- <cfinvokeargument name="selectstatement" value=" where connectid='#Employeeid#'"> --->
	</cfinvoke>
	<cfloop index="iField" list="#TheFieldNames#">
		<cfswitch expression="#iField#">
			<cfcase value="firstlastname">
				<cfset theData="#trim(firstname)# #trim(lastname)#">
				<cfset TheFieldData=listappend(#TheFieldData#,#theData#)>
			</cfcase>
          <cfcase value="address">
		  		<cfset addressData="#employeeaddress.address1# #employeeaddress.address2#">
				<cfset TheFieldData=listappend(#TheFieldData#,#addressData#)>
			</cfcase>
		  <cfcase value="city">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeeaddress.City#)>
			</cfcase>
          <cfcase value="state">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeeaddress.State#)>
			</cfcase>
          <cfcase value="zip">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeeaddress.PostalCode#)>
			</cfcase>
		  <cfcase value="country">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeeaddress.Country#)>
			</cfcase>
		  <cfcase value="phone">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeephone.Phonenumber#)>
			</cfcase>
          <cfcase value="emailaddress">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeeemail.EmailAddress#)>
			</cfcase>
          <cfcase value="faxphone">
				<cfset TheFieldData=listappend(#TheFieldData#,#employeefaxphone.phonenumber#)>
			</cfcase>
		  <cfcase value="websiteurl">
				<cfset TheFieldData=listappend(#TheFieldData#,#WebSiteURL#)>
			</cfcase>
		<cfcase value="startdate">
				<cfset TheFieldData=listappend(#TheFieldData#,#WebSiteURL#)>
			</cfcase>
		<cfcase value="locationcity">
				<cfset TheFieldData=listappend(#TheFieldData#,#LocationCity#)>
			</cfcase>
		<cfcase value="stateID">
				<cfset TheFieldData=listappend(#TheFieldData#,#StateID#)>
			</cfcase>
		</cfswitch>
	</cfloop>
	<cffile action="append" file="#Application.Uploadpath#\files\downloads\#Download#.csv" output="#TheFieldData#" addnewline="yes">
	<cfset TheFieldData=''>
	</cfoutput>
	<cflocation url="../files/downloads/#download#.csv">
	<cfoutput><h1>Here is your file.  Click the file name to download. <a href="../files/downloads/#download#.csv">#Download#.csv</a></h1></cfoutput>
</cfif>
<cfif goahead is 1>

<br>
<table class=centrecol width=100%>
<tr>
<td><h2>Export Employer Contacts</h2>
</td>
</tr></table>
<cfoutput>
<cfform action="adminheader.cfm?requestTimeOut=50000" method="post" name="thisform">
<input type="hidden" name="Action" value="exportFiles">
<table>
		<tr><td>Select the field to sort by</td><td>
		<select name="sortby">
			<option value="startdate">date created</option>
			<option value="stateID">state</option>
		</select>
		</td></tr>
		<tr><td valign=top><strong>Select the fields you wish for the export:</strong>
		</td>
		<td>
		  <input type="checkbox" name="RegistrationFields" value="companyname" checked>
          Company Name<br>
		   <input type="checkbox" name="RegistrationFields" value="firstlastname" checked>
          Contact Name<br>
          <input type="checkbox" name="RegistrationFields"  value="address" checked>
          Street Address<br>
		  <input type="checkbox" name="RegistrationFields"  value="city" checked>
          City<br>
          <input type="checkbox" name="RegistrationFields"  value="state" checked>
          State<br>
          <input type="checkbox" name="RegistrationFields"  value="zip" checked>
          Zip<br>
		  <input type="checkbox" name="RegistrationFields"  value="phone" checked>
          Phone<br>
          <input type="checkbox" name="RegistrationFields"  value="faxphone" checked>
          Fax Phone<br>
          <input type="checkbox" name="RegistrationFields" value="emailaddress" checked>
          Email Address<br>
          <input type="checkbox" name="RegistrationFields" value="StartDate" checked>
          StartDate<br>
          <input type="checkbox" name="RegistrationFields" value="StateID" checked>
          StateID<br>
          <input type="checkbox" name="RegistrationFields" value="LocationCity" checked>
          LocationCity<br>
		  <input type="checkbox" name="RegistrationFields" value="websiteurl" checked>
          Web site URL<br>

        </p>
		</td></tr>
				
	<tr><td>&nbsp;</td>
	    <td valign=top><input type="submit" name="submitemployer" value="Export It"></td>
        <td>&nbsp;</td>
	</tr><tr>
	    <td valign=top>&nbsp;</td>
	</tr></table>
</cfform>
</cfoutput>

<table class=centrecol width=100%>
<tr>
<td><h2>Export Resumes</h2>
</td>
</tr></table>
<cfoutput>
<cfform action="adminheader.cfm?requestTimeOut=5000" method="post" name="thisform">
<input type="hidden" name="Action" value="exportFiles">
<table>
		<tr><td>Select the field to sort by</td><td>
		<select name="sortby">
			<option value="startdate">date created</option>
			<option value="jobcategoryID">category</option>
			<option value="stateID">state</option>
		</select>
		</td></tr>
		<tr><td valign=top><strong>Select the fields you wish for the export:</strong>
		</td>
		<td>
		  <input type="checkbox" name="RegistrationFields" value="theresume" checked>
          Resume<br>
		  <input type="checkbox" name="RegistrationFields" value="firstlastname" checked>
          Name<br>
          <input type="checkbox" name="RegistrationFields"  value="address" checked>
          Street Address<br>
		  <input type="checkbox" name="RegistrationFields"  value="city" checked>
          City<br>
          <input type="checkbox" name="RegistrationFields"  value="state" checked>
          State<br>
          <input type="checkbox" name="RegistrationFields"  value="zip" checked>
          Zip<br>
		  <input type="checkbox" name="RegistrationFields"  value="country" checked>
		  Country<br>
		  <input type="checkbox" name="RegistrationFields"  value="phone" checked>
          Phone<br>
          <input type="checkbox" name="RegistrationFields"  value="faxphone" checked>
          Fax Phone<br>
          <input type="checkbox" name="RegistrationFields" value="emailaddress" checked>
          Email Address<br>
		  <input type="checkbox" name="RegistrationFields" value="StartDate" checked>
          StartDate<br>
          <input type="checkbox" name="RegistrationFields" value="StateID" checked>
          StateID<br>
          <input type="checkbox" name="RegistrationFields" value="LocationCity" checked>
          LocationCity<br>
		  <input type="checkbox" name="RegistrationFields" value="websiteurl" checked>
          Web Site URL<br>
        </p>
		</td></tr>
				
	<tr><td>&nbsp;</td>
	    <td valign=top><input type="submit" name="submitemployee" value="Export It"></td>
        <td>&nbsp;</td>
	</tr><tr>
	    <td valign=top>&nbsp;</td>
	</tr></table>
</cfform>
</cfoutput>
</cfif>