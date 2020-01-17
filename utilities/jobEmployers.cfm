<cfparam name="EmployerAction" default="List">
<cfparam name="alphabet" default="a">
<cfparam name="employerID" default=0>
<cfparam name="action" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfset TheFileExists="true">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="states">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="EmployerTypes">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="employertypes">
</cfinvoke>

<cfparam name="Active" default=0>
<cfparam name="CardName" default="">
<cfparam name="CCExpire" default="">
<cfparam name="CCNo" default="">
<cfparam name="CCType" default="">
<cfparam name="ContactName" default="">
<cfparam name="StartDate" default="">
<cfparam name="username" default="">
<cfparam name="Password" default="">
<cfparam name="StateID" default="">
<cfparam name="tStateID" default="">
<cfparam name="LocationCity" default="0">
<cfparam name="CompanyName" default="0">
<cfparam name="websiteURL" default="0">
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
<cfparam name="altemail" default="">
<cfparam name="username" default="">
<cfparam name="password" default="">
<cfparam name="EmailID" default="0">
<cfparam name="altEmailID" default="0">
<cfparam name="addressid" default="0">
<cfparam name="phoneID" default="0">
<cfparam name="faxphoneID" default="0">
<cfparam name="officephoneid" default="0">
<cfparam name="typeid" default="1">

<cfif employerAction is "delete">
		<cfquery name="delete" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			delete from employers where employerID=#employerID#
		</cfquery>
	<cfset employerid=0>
	<cfset employerAction="List">
</cfif>
		
<cfif employeraction is "Edit">

	<cfquery name="employers" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select employers.* , employerphone.phoneID, employerphone.phonenumber,
		employeremail.emailid, employeremail.emailaddress,
		employeraddress.addressid, employeraddress.address1, employeraddress.address2,
		employeraddress.city, employeraddress.state, employeraddress.country, 
		employeraddress.PostalCode
		from employers, employerphone, employeremail, employeraddress 
		where employerid=#employerID#
		and employerphone.connectid=employers.employerid
		and employerphone.PhoneTypeID=1
		and employeremail.connectid=employers.employerid
		and employeremail.emailTypeID=1
		and employeraddress.connectid=employers.employerid
		and employeraddress.AddressTypeID=1
	</cfquery>
	
	<cfquery name="employerofficephone" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employerphone where phonetypeID=2 and connectID=#employerid#
	</cfquery>
	<cfquery name="employerfaxphone" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employerphone where phonetypeID=3 and connectID=#employerid#
	</cfquery>
	<cfquery name="employeraltemail" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employeremail where emailtypeid=2 and connectID=#employerid#
	</cfquery>
	<cfif employers.recordcount is 0>
		<cfquery name="employers" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employers.*
			from employers
			where employerid=#employerID#
		</cfquery>
		<cfquery name="Ephone" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employerphone.*
			from employerphone
			where connectID=#employerID#
		</cfquery>
		<cfquery name="Eemail" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employeremail.*
			from employeremail
			where connectID=#employerID#
		</cfquery>
		<cfquery name="Eaddress" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select employeraddress.*
			from employeraddress
			where connectID=#employerID#
		</cfquery>
		<cfoutput query="employers">
			<cfset Active=#Active#>
			<cfset StartDate=#StartDate#>
			<cfset CCExpire=#CCExpire#>
			<cfset CCNo=#CCNo#>
			<cfset CCType=#CCType#>
			<cfset ContactName=#replace(ContactName,"~",",","ALL")#>
			<cfset StateID=#StateID#>
			<cfset tStateID=#trim(stateid)#>
			<cfset LocationCity=#LocationCity#>
			<cfset companyname=#replace(companyname,"~",",","ALL")#>
			<cfset websiteURL=#websiteURL#>
			<cfset username=#username#>
			<cfset password=#password#>
			<Cfset typeid=#trim(typeid)#>
		</cfoutput>
		<cfoutput query="Eaddress">
			<cfset AddressID=#addressID#>
			<cfset address=#address1#>
			<cfset address2=#address2#>
			<cfset address2=#address2#>
			<cfset city=#city#>
			<cfset state=#state#>
			<cfset zip=#zip#>
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
		<cfoutput query="employers">
			<cfset Active=#Active#>
			<cfset StartDate=#StartDate#>
			<cfset CCExpire=#CCExpire#>
			<cfset CCNo=#CCNo#>
			<cfset CCType=#CCType#>
			<cfset ContactName=#replace(ContactName,"~",",","ALL")#>
			<cfset StateID=#StateID#>
			<cfset tStateID=#trim(stateid)#>
			<cfset LocationCity=#LocationCity#>
			<cfset companyname=#replace(companyname,"~",",","ALL")#>
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
			<cfset zip=#zip#>
			<cfset country=#country#>
			<Cfset phoneID=#phoneID#>
			<cfset phone=#phonenumber#>
			<cfset emailID=#emailID#>
			<cfset email=#emailaddress#>
		</cfoutput>
	</cfif>
	<cfoutput query="employerofficephone">
		<cfset officePhoneID=#phoneID#>
		<cfset officephone=#phonenumber#>
	</cfoutput>
	<cfoutput query="employerfaxphone">
		<cfset faxPhoneID=#phoneID#>
		<cfset faxphone=#phonenumber#>
	</cfoutput>
	<cfoutput query="employeraltemail">
		<cfset altEmailID=#altEmailID#>
		<cfset altEmail=#emailaddress#>
	</cfoutput>
	<cfset employerAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.ContactName')><cfset form.ContactName="#form.firstname#"></cfif>
	<cfif not isdefined('form.ContactName')><cfset form.ContactName="&nbsp;"></cfif>
	<cfset form.ContactName = replace(#form.ContactName#,",","~","ALL")>
	<cfif not isdefined('form.CompanyName')><cfset form.CompanyName="&nbsp;"></cfif>
	<cfset form.CompanyName = replace(#form.CompanyName#,",","~","ALL")>
	<cfif not isdefined('form.websiteURL')><cfset form.websiteURL="&nbsp;"></cfif>
	<cfset form.websiteURL = replace(#form.websiteURL#,",","~","ALL")>
	<cfif not isdefined('form.LocationCity')><cfset form.LocationCity="&nbsp;"></cfif>
	<cfset form.LocationCity= replace(#form.LocationCity#,",","~","ALL")>
	<cfif not isdate(#form.StartDate#)><cfset form.StartDate=#dateformat(now(),"yyyy/mm/dd")#></cfif>
	<cfif #form.Active# is ''><cfset form.Active="0"></cfif>
	<cfif #form.CardName# is ''><cfset form.CardName="&nbsp;"></cfif>
	<cfset form.CardName = replace(#form.CardName#,",","~","ALL")>
	<cfset UUID = #left(form.ContactName,2)# & #left(form.username,2)# & day(now()) & month(now()) & year(now())>
	<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,ContactName,StartDate,username,password,StateID,LocationCity,CompanyName,websiteURL,typeid">
	<CFSET FieldValues = "'#form.CardName#' ,#form.active#,'#form.CCExpire#' ,'#form.CCNo#' ,'#form.CCType#' ,'#form.ContactName# ','#dateformat(form.startdate,'yyyy/mm/dd')#','#form.username#','#form.password#','#form.State#','#form.LocationCity#','#form.CompanyName#' ,'#form.websiteURL#' ,#form.typeid#">

	<cfif int(employerid) neq 0>
		<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			update employers set 
			CardName='#form.CardName#' ,
			Active=#form.active#,
			CCExpire='#form.CCExpire#' ,
			CCNo='#form.CCNo#' ,
			CCType='#form.CCType#' ,
			ContactName='#form.ContactName#' ,
			StartDate='#dateformat(form.startdate,'yyyy/mm/dd')#',
			username='#form.username#',
			password='#form.password#',
			StateID='#form.State#',
			LocationCity='#form.LocationCity#',
			CompanyName='#form.CompanyName#' ,
			websiteURL='#form.websiteURL#' ,
			typeid=#form.typeid#
			where employerID=#employerID#
		</cfquery>
		<cfset newEmployerID=#employerid#>
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "1,#newEmployerID#,'#form.Email#' ">
		<cfif #EmailID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeremail
					set emailaddress='#form.email#'
				where emailID=#emailid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeremail (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "2,#newEmployerID#,'#form.altemail#' ">
		<cfif #altEmailid# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeremail
					set emailaddress='#form.altemail#'
				where emailID=#altEmailid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeremail (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "1,#newEmployerID#,'#form.phone#' ">
		<cfif #PHoneID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employerphone
					set phonenumber='#form.phone#'
				where phoneID=#PHoneID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employerphone (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "2,#newEmployerID#,'#form.officephone#' ">
		<cfif #officePHoneID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employerphone
					set phonenumber='#form.officephone#'
				where phoneID=#officePHoneID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employerphone (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "3,#newEmployerID#,'#form.faxphone#' ">
		<cfif #faxPHoneID# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employerphone
					set phonenumber='#form.faxphone#'
				where phoneID=#faxPHoneID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employerphone (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
	
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#form.address#' ,'#form.address2#' ,1,'#form.city#' ,#newEmployerID#, '#form.zip#','#form.state#' ,'#form.country#' ">
		<cfif #addressid# neq "0">
			<cfquery name="update" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				update employeraddress
					set address1='#form.address#',
					address2='#form.address2#',
					city='#form.city#',
					postalcode='#form.zip#',
					state='#form.state#',
					country='#form.country#'
				where addressID=#addressid#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
				insert into employeraddress (#fieldList#)
				values (#preservesinglequotes(fieldValues)#)
			</cfquery>
		</cfif>
		<cflocation url="adminheader.cfm?action=newjobemployers&employeraction=list&alphabet=#alphabet#">
	<cfelse>
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employers (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cfquery name="getMax" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select max(employerID) as NewID from employers
		</cfquery>
		<cfset NewEmployerID=#getMax.NewID#>
		
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
		<CFSET FieldValues = "2,#newEmployerID#,'#form.officephone#' ">
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
	
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "'#form.address#','#form.address2#',1,'#form.city#',#newEmployerID# ,'#form.zip#','#form.state#','#form.country#'">
		<cfquery name="insert" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			insert into employeraddress (#fieldList#)
			values (#preservesinglequotes(fieldValues)#)
		</cfquery>
		<cflocation url="adminheader.cfm?action=newjobemployers&employeraction=list&alphabet=#alphabet#">
	</cfif>

</cfif>

<cfoutput>

<script>
function getmemberinfo() {

}
</script>
<h1>Job Board Employers</h1>

<cfif employerAction is "Add" or employerAction is "Update">

<form action="adminheader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="employerid" value="#employerid#">
<input type="hidden" name="employerAction" value="#employerAction#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="cardname" value="#cardname#">
<input type="hidden" name="cctype" value="#cctype#">
<input type="hidden" name="ccexpire" value="#ccexpire#">
<input type="hidden" name="officephoneid" value="#officephoneid#">
<input type="hidden" name="faxphoneid" value="#faxphoneid#">
<input type="hidden" name="phoneid" value="#phoneid#">
<input type="hidden" name="emailid" value="#emailid#">
<input type="hidden" name="altemailid" value="#altemailid#">
<input type="hidden" name="addressid" value="#addressid#">
<input type="hidden" name="CCNo" value="#CCNo#">
<input type="hidden" name="alphabet" value="#alphabet#">
<table width="100%" cellspacing="0" cellpadding="0" align="CENTER">
<tr>
	<td>
		<font face="Arial" size="2">Employer Type:</font></td>
	<td><select name="typeid">
		<cfloop query="employertypes">
			<option value="#employertypes.employertypeid#"<cfif #typeid# is #employertypes.employertypeid#> selected</cfif>>#typename# #typePrice#</option>
		</cfloop>
	</select></td>
</tr>
	<tr>
		<td>Contact Name </td>
		<td> <input type="text" value="#contactname#" name="firstname" size=25> </td>
</tr>
<tr>
		<td>Company Name </td>
		 <td><input type="text" name="companyname" value="#companyname#" size=25></td>
</tr>
<tr>
		<td>Address </td>
		 <td><input type="text" name="Address" value="#Address#" size=25> <input type="text" name="Address2" value="#Address2#" size=25></td>
</tr>
<tr>
		<td>City </td>
		 <td><input type="text" name="City" value="#City#" size=25></td>
</tr>
<tr>
		<td>State </td>
		 <td><input type="text" name="State" value="#State#" size=25></td>
</tr>
<tr>
		<td>Postal Code </td>
		 <td><input type="text" name="zip" value="#zip#" size=25></td>
</tr>
<tr>
		<td>Country </td>
		 <td><select name="Country">
		 	<option value="#Country#">#Country#</option>
			<cfinclude template="../files/countries.htm">
		 </select></td>
</tr>
<tr>
		<td>User Name </td>
		 <td><input type="text" name="username" value="#username#" size=45></td>
</tr>
<tr>
		<td>Password </td>
		 <td><input type="text" name="Password" value="#Password#" size=45></td>
</tr>
<tr>
		<td>Home Phone </td>
		 <td><input type="text" name="phone" value="#phone#" size=25></td>
</tr><tr>
		<td>Office Phone </td>
		 <td><input type="text" name="officephone" value="#officephone#" size=25></td>
</tr>
<tr>
		<td>Fax Phone </td>
		 <td><input type="text" name="faxphone" value="#faxphone#" size=25></td>
</tr>
<tr>
		<td>Email Address </td>
		 <td><input type="text" name="email" value="#email#" size=25></td>
</tr>

	<tr>
		<td>Alternate Email Address</td>
		<td><input type="text" name="altemail" value="#altemail#"></td>
	</tr>
	<tr>
		<td>Active </td>
		 <td>Yes<input type="Radio" name="Active" value="1" <cfif #Active# is 1 or #active# is "Active">checked</cfif>><br>
		 No<input type="Radio" name="Active" value=0 <cfif #Active# is 0 or #active# is "Pending">checked</cfif>></td>
</tr>

<tr>
		<td>Date Started </td>
		 <td>
		 <cfif isdate(startdate)>
		 <input type="text" name="StartDate" value="#dateformat(StartDate,"mm/dd/yyyy")#" size=25>
		 <cfelse>
		 <input type="text" name="StartDate" value="#StartDate#" size=25>
		 </cfif>
		 </td>
</tr>
	<tr>
		<td>Company Website </td>
		<td><input type="text" name="websiteURL" value="#websiteurl#" size=40 maxlength=255>
		</td>
</tr>

	<tr>
		<td>Location City </td>
		<td><input type="text" name="LocationCity" value="#LocationCity#" size=40 maxlength=255>
		</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" name="submit" value="Apply">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="submit" value="Reset">
	</td>
</tr>
</table>
</form>
</cfif>
</cfoutput>
<cfif employerAction is "list">
<cfif #TheFileExists# is "true">
	<cfquery name="Allemployers" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
		select * from employers
		<cfif #alphabet# is 'all'>
			order by companyname
		<cfelseif #alphabet# is "recent">
			order by StartDate desc
		<cfelse>
			where (contactname like '#ucase(alphabet)#%' or contactname like '#lcase(alphabet)#%') or (companyname like '#ucase(alphabet)#%' or companyname like '#lcase(alphabet)#%')
			order by companyname
		</cfif>
	</cfquery>
</cfif>
<cfoutput><a href="adminheader.cfm?Action=#Action#&employerAction=Add&alphabet=#alphabet#">Add An Employer</a></cfoutput><br>
<cfif #TheFileExists#><cfoutput>
<br>Search For An Employer</h2>
<a href="adminheader.cfm?action=#action#&alphabet=recent">Click here to see the 25 most recent employers</a><br>
<a href="adminheader.cfm?action=#action#&alphabet=all">Click here to see them all</a><br>
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
<a href="adminheader.cfm?Action=#action#&alphabet=z">Z</a></cfoutput>
<table border="1" align="CENTER">
<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Employers</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Company name</p></td>
<td><p>Contact name</p></td>
<td><p>Start Date</p></td>
<td><p>Status</p></td>
<td><p>Actions</p></td>
</tr>
<cfoutput query="Allemployers">
<tr>
<td><p>#int(employerid)#</p></td>
<td><p>#companyname#</p></td>
<td><p>#contactname#</p></td>
<td><p><cfif isdate(Startdate)>#dateformat(StartDate,"mm/dd/yyyy")#<cfelse>#startdate#</cfif></p></td>
<td><p><cfif #active# is 1>Active<cfelseif #active# is "Active">Active<cfelse>Not Active</cfif></p></td>
<td nowrap><a href= "adminheader.cfm?employerid=#employerid#&employerAction=Edit&action=#action#&alphabet=#alphabet#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?employerid=#employerid#&employerAction=Delete&action=#action#&alphabet=#alphabet#')">Delete</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?employerid=#employerid#&action=newemployerjobs">Jobs</a></td>
</tr>
</cfoutput>
</table>
</cfif>
</cfif>