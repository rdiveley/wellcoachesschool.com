
<cfparam name="TypeID" default=0>
<cfparam name="RecordID" default=0>
<cfparam name="alphabet" default="a">

<cfset workphone_value=''>
<cfset faxphone_value=''>
<cfset cellphone_value=''>
<cfset workphone=''>
<cfset faxphone=''>
<cfset cellphone=''>
<cfset AltEmail_value=''>
<cfset AltEmail=''>


<CFIF #RecordID# gt 0>
	<cfquery name="GetRecord" datasource="#application.dsn#" password="#application.dsnpWord#" username="#application.dsnuName#">
	SELECT Members.*,
		Addresses.Address1, 
		Addresses.Address2, 
		Addresses.City, 
		Addresses.State, 
		Addresses.PostalCode, 
		Addresses.Country,
		Email.EMailAddress,
		PhoneNumbers.PhoneNumber,
		Subscriptiontype.subdescription as subtype
		FROM Members, Email, Addresses, PhoneNumbers, subscriptiontype
		WHERE email.tableid=15
		and email.connectid = members.memberid
		and email.websiteid=1
		and PhoneNumbers.TableID=15
		and PhoneNumbers.ConnectID = Members.MemberID
		and Phonenumbers.phonetypeid=1
		and Addresses.tableid=15
		and Addresses.connectid = members.memberid
		and members.subtypeid=subscriptiontype.subtypeid
		and Members.memberid=#RecordID#
</cfquery>
<cfquery name="GetPhonenumbers" datasource="#application.dsn#" password="#application.dsnpWord#" username="#application.dsnuName#">
	select
	(select phonenumber from phonenumbers
	where connectID=#RecordID#
	and tableid=15
	and phonetypeid=2) as workphone,
	(select phonenumber from phonenumbers
	where connectID=#RecordID#
	and tableid=15
	and phonetypeid=3) as faxphone,
	(select phonenumber from phonenumbers
	where connectID=#RecordID#
	and tableid=15
	and phonetypeid=4) as cellphone
</cfquery>
<cfset workphone_value=''>
<cfset faxphone_value=''>
<cfset cellphone_value=''>
<cfset workphone=''>
<cfset faxphone=''>
<cfset cellphone=''>
<cfoutput query="GetPhonenumbers">
	<cfset workphone_value=#workphone#>
	<cfset faxphone_value=#faxphone#>
	<cfset cellphone_value=#cellphone#>
	<cfset workphone=''>
	<cfset faxphone=''>
	<cfset cellphone=''>
</cfoutput>

<cfquery name="GetAltEmail" datasource="#application.dsn#" password="#application.dsnpWord#" username="#application.dsnuName#">
	select emailaddress as altemail
	from email
	where connectid=#RecordID#
	and tableid=15
	and websiteid=2
</cfquery>
<cfset AltEmail_value=''>
<cfset AltEmail=''>
<cfoutput query="GetAltEmail">
	<cfset AltEmail_value=#altemail#>
	<cfset AltEmail=5>
</cfoutput>
		
			<CFSET FirstName_Value = '#GetRecord.FirstName#'>
			<CFSET LastName_Value = '#GetRecord.LastName#'>
			<cfset AccessLevel_value = '#GetRecord.AccessLevel#'>
			<CFSET Address1_Value = '#GetRecord.Address1#'>
			<CFSET Active_Value=#GetRecord.Active#>
			<CFSET Address2_Value = '#GetRecord.Address2#'>
			<CFSET City_Value = '#GetRecord.City#'>
			<CFSET State_Value = '#GetRecord.State#'>
			<CFSET PostalCode_Value = '#GetRecord.PostalCode#'>
			<CFSET EMailAddress_Value = '#GetRecord.EMailAddress#'>
			<CFSET StartDate_Value = #GetRecord.StartDate#>
			<CFSET EndDate_Value = #GetRecord.EndDate#>
			<CFSET Logon_Value = '#Trim(GetRecord.Logon)#'>
			<CFSET Password_Value = '#Trim(GetRecord.Password)#'>
			<CFSET SubTypeID_Value = #GetRecord.SubTypeID#>
			<CFSET Banned_Value = '#GetRecord.Banned#'>
			<CFSET WebSiteURL_Value = #GetRecord.WEbSiteURL#>
			<cfset PhoneNumber_value = '#GetRecord.PhoneNumber#'>
			<CFSET Country_Value = '#GetRecord.Country#'>
			<CFSET AGe_Value = #GetRecord.Age#>
			<cfset Occupation_value=#GetRecord.occupation#>
			<cfset sex_value=#GetRecord.sex#>
			<cfset companyname_value=#GetRecord.companyname#>
			<cfset FeePaid_value=#GetRecord.FeePaid#>
			<cfset LastModified_value=#getrecord.lastmodified#>

<CFELSE>

			<CFSET FirstName_Value = ''>
			<CFSET LastName_Value = ''>
			<cfset AccessLevel_value = 0>
			<CFSET Address1_Value  = ''>
			<CFSET Active_Value= 0>
			<CFSET Address2_Value = ''>
			<CFSET City_Value = ''>
			<CFSET State_Value  = ''>
			<CFSET PostalCode_Value = ''>
			<CFSET EMailAddress_Value = ''>
			<CFSET StartDate_Value = '#Dateformat(Now())#'>
			<CFSET EndDate_Value = ''>
			<CFSET Logon_Value = ''>
			<CFSET Password_Value = ''>
			<CFSET SubTypeID_Value = #typeID#>
			<CFSET Banned_Value= 0>
			<CFSET WebSiteURL_Value = ''>
			<cfset PhoneNumber_value = ''>
			<CFSET Country_Value = ''>
			<CFSET AGe_Value = ''>
			<cfset Occupation_value = ''>
			<cfset sex_value = ''>
			<cfset companyname_value = ''>
			<cfset FeePaid_value= 0>
			<cfset lastmodified_value=#dateformat(now())#>
</CFIF>
<cfif FileExists("#application.uploadpath#\ecourses\EcoursesConfig.xml")>
	<cffile action="READ" file="#application.uploadpath#\ecourses\EcoursesConfig.xml" variable="EcoursesConfig">
	<cfwddx action="wddx2cfml"
		input="#EcoursesConfig#"
		output="xEcoursesConfig">
	<cfset StudentType=#xECoursesConfig[1][6]#>
	<cfset FacultyType=#xECoursesConfig[1][5]#>
<cfelse>
	<cfset StudentType=0>
	<cfset FacultyType=0>
</cfif>
<cfoutput>
<HTML><HEAD>
	<TITLE><cfif #TypeID# is #FacultyType#>Faculty<cfelseif #TypeID# is #StudentType#>Students</cfif> - Edit Record</TITLE>
</HEAD>
<body bgcolor="##0000A0" text="##EAEAF4" link="##DDFFDD" vlink="##FFDCB9" alink="##FFD7EB">
<font face="Arial"><center><h2>#application.WebsiteName# Administration</h2>

<HR></cfoutput>


<FONT size="+1"><cfif #TypeID# is #FacultyType#>Faculty<cfelseif #TypeID# is #StudentType#>Students</cfif></FONT> <BR>
<FONT size="+2"><B><cfif #RecordID# gt 0>Edit<cfelse>Add</cfif> Record</B></FONT>

<CFOUTPUT>
<cfFORM action="Members_RecordAction.cfm" method="post">
	<input type="hidden" name="typeid" value="#typeID#">
	<!--- <input type="hidden" name="subtypeid" value="#subtypeID_value#"> --->
	<input type="hidden" name="workphone" value="#workphone#">
	<input type="hidden" name="faxphone" value="#faxphone#">
	<input type="hidden" name="cellphone" value="#cellphone#">
	<input type="hidden" name="AltEmail" value="#AltEmail#">
	<input type="hidden" name="alphabet" value="#Alphabet#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="MemberID" value="#URL.RecordID#">
</CFIF>

<table align=center>

	<tr>
	    <td width="50%" align=top>
			<p>Your First Name: <font color=red>*</font></p></td><td><cfinput type="Text" name="FirstName" message="Please enter your first name" required="Yes" size="25" maxlength="25"  value="#trim(FirstName_value)#">
	    </td>

	</tr>
	<tr>
	    <td width="50%" align=top>
			<p>Your Last Name: <font color=red>*</font></p></td><td><cfinput type="Text" name="lastName" message="Please enter your last name" required="Yes" size="25" maxlength="25"  value="#trim(lastName_value)#">
	    </td>

	</tr>
<tr>
    <td width="35%">
		<p>User Name: <font color="red">*</font></p></td><td><cfinput type="Text" name="logon" message="Please enter your User Name" required="Yes" size="15" maxlength="25" value="#logon_value#">
    </td>

</tr>
<tr>
    <td width="35%">
	<cfif #recordid# is 96>
		<p>Password: <font color="red">*</font></p></td><td><cfinput type="password" required="Yes" message="Please enter your Password" name="Password" size="15" maxlength="25" value="#password_value#">
	<cfelse>
		<p>Password: <font color="red">*</font></p></td><td><cfinput type="text" required="Yes" message="Please enter your Password" name="Password" size="15" maxlength="25" value="#password_value#">
	</td></cfif>
    

</tr>
	<tr>
	    <td width="50%" align=top>
			<p>Address: <font color=red>*</font></p></td> <td><cfinput type="Text" name="address1" message="Please enter your Address" required="Yes" size="25" maxlength="50"  value="#trim(address1_value)#">
		</td>

	</tr>
	<tr>
    <td width="35%">
		<p>Address2:</p></td><td><cfinput type="Text" name="address2"  required="no" size="15" maxlength="50"  value="#Address2_value#">
    </td>

</tr>
	<tr>
	    <td width="50%" align=top>
			<p>City: <font color=red>*</font></p></td> <td><cfinput type="Text" name="city" message="Please enter your City" required="Yes" size="25" maxlength="50" value="#trim(city_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>State/Province/Other: <font color=red>*</font></p></td> <td><cfinput type="Text" name="state" message="Please enter your State/Province" required="Yes" size="15" maxlength="50"  value="#trim(state_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Zip/Postal Code/Other: <font color=red>*</font></p></td> <td> <cfinput type="Text" name="postalcode" message="Please enter your Postal Code" required="Yes" size="15" maxlength="15" value="#trim(postalcode_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Country: <font color=red>*</font></p></td> <td><cfinput type="Text" name="country" message="Please enter your Country" required="Yes" size="25" maxlength="50"  value="#trim(country_value)#">
		</td>

	 </tr>
	  <tr>
	    <td width="50%" align=top>
			<p>Email Address: <font color=red>*</font></p></td> <td><cfinput type="Text" name="email" message="Please enter your Email Address" required="Yes" size="25" maxlength="250" value="#trim(emailaddress_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Alertnate Email Address:</p></td> <td><cfinput type="Text" name="altemail" required="No" size="25" maxlength="250" value="#trim(Altemail_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Web site:</p></td> <td><cfinput type="Text" name="MemberURL"  required="No" size="25" maxlength="250" value="#trim(WebSiteURL_Value)#">
		</td>

	 </tr>
	<tr>
	    <td width="50%" align=top>
			<p>Home Phone Number: <font color=red>*</font></p></td> <td><cfinput type="Text" name="phonenumber" message="Please enter your Phone Number" required="Yes" size="15" maxlength="25"  value="#trim(phonenumber_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Work Phone Number:</p></td> <td><cfinput type="Text" name="workphonenumber"  required="No" size="15" maxlength="25"  value="#trim(workphone_value)#">
		</td>

	 </tr>
	 
	 <tr>
	    <td width="50%" align=top>
			<p>Cell Phone Number: </p></td> <td><cfinput type="Text" name="cellphone"  required="No" size="15" maxlength="25"  value="#trim(cellphone_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Fax Phone Number:</p></td> <td><cfinput type="Text" name="faxphone"  required="No" size="15" maxlength="25"  value="#trim(faxphone_value)#">
		</td>

	 </tr>
	 
	 
	 <tr>
	    <td width="50%" align=top>
			<p>Start Date: </p></td> <td><cfinput type="Text" name="startdate" required="No" size="15" maxlength="25"  value="#dateformat(startdate_value,'mm/dd/yyyy')#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Next Renewal Date: </p></td> <td><cfinput type="Text" name="enddate" required="No" size="15" maxlength="25"  value="#dateformat(enddate_value,'mm/dd/yyyy')#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Last Date Modified: </p></td> <td><cfinput type="Text" name="LastModified" required="No" size="15" maxlength="25"  value="#dateformat(LastModified_value,'mm/dd/yyyy')#">
		</td>

	 </tr>
     <tr>
     <td width="50%" align="top">
     	<p>Member Type: </p></td>
        <td>
        <select name="subtypeid">
        <cf_GetOptions
				DSN=#application.dsn#
				Tablename="subscriptionType"
				IDFIeld="subtypeid"
				descriptionfield="subdescription"
				MatchID="#subtypeid_value#">
        </select>
      </td>
      </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Other Member Types: </p></td> <td>
			<select name="occupation" multiple>
			<cf_GetOptionsMultiple
				DSN=#application.dsn#
				Tablename="subscriptionType"
				IDFIeld="subtypeid"
				descriptionfield="subdescription"
				MatchID="#Occupation_value#">
			</select>
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Age: </p></td> <td><cfinput type="Text" name="age" required="No" size="15" maxlength="25"  value="#trim(age_value)#">
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Sex:</p></td> <td><cfselect name="sex" size="1"><option value="Male" <cfif #sex_value# is "Male">selected</cfif>>Male<option value="Female" <cfif #sex_value# is "Female">selected</cfif>>Female</cfselect>  
		</td>

	 </tr>
	 <tr>
	    <td width="50%" align=top>
			<p>Status:</p></td> <td><cfselect name="active" size="1"><option value="0" <cfif #Active_Value# is "0">selected</cfif>>Pending<option value="1" <cfif #Active_Value# is "1">selected</cfif>>Active</cfselect>  
		</td>

	 </tr>


</table>
<!--- form buttons --->
<p align=center><INPUT type="submit" name="btnEdit_OK" value="    OK    ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel"></p>

</cfFORM>
</CFOUTPUT>



</BODY></HTML>
