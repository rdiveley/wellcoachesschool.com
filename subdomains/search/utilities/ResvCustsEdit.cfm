<cfparam name="ResvCustID" default=0>
<cfparam name="alphabet" default="a">
<cfparam name="ResvCustAction" default="add">
<cfparam name="AddressID" default="0">
<cfparam name="EmailID" default="0">
<cfparam name="PhoneID" default="0">
<cfparam name="workphoneID" default="0">
<cfparam name="faxphoneID" default="0">



<CFIF #ResvCustID# gt 0>
	<cfinvoke method="GetResvCust" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="ResvCust">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
	</cfinvoke>
	<cfinvoke method="GetResvCustPhone" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="homephone">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
		<cfinvokeargument name="PhoneTypeID" value="1">
	</cfinvoke>
	<cfinvoke method="GetResvCustPhone" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="workphone">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
		<cfinvokeargument name="PhoneTypeID" value="2">
	</cfinvoke>
	<cfinvoke method="GetResvCustPhone" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="FaxPhone">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
		<cfinvokeargument name="PhoneTypeID" value="3">
	</cfinvoke>
	<cfinvoke method="GetResvCustEmail" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="EmailAddress">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
		<cfinvokeargument name="EMAILTYPEID" value="1">
	</cfinvoke>
	<cfinvoke method="GetResvCustAddress" 
		component="#Application.WebSitePath#.utilities.reservations" 
		returnvariable="ResvCustAddress">
		<cfinvokeargument name="ResvCustID" value="#ResvCustID#">
		<cfinvokeargument name="addresstypeid" value="1">
	</cfinvoke>

	<cfset workphone_value=''>
	<cfset faxphone_value=''>
	<cfset cellphone_value=''>
	<cfset workphoneID='0'>
	<cfset phoneID='0'>
	<cfset faxphoneID='0'>
	<cfset AddressID=#ResvCustAddress.AddressID#>
	<cfset EmailID=#EmailAddress.emailID#>
	
	<cfif #homephone.recordcount# gt 0>
		<cfset PhoneID=#HomePhone.PHoneID#>
	</cfif>
	<cfif FaxPhone.RecordCount gt 0>
		<cfset FaxPhone_value=#FaxPhone.PhoneNumber#>
		<cfset FaxPhoneID=#FaxPhone.PhoneID#>
	</cfif>
	<cfif workphone.RecordCount gt 0>
		<cfset workphone_value=#workphone.PhoneNumber#>
		<cfset workphoneID=#workphone.PhoneID#>
	</cfif>
		
	<CFSET FirstName_Value = '#replace(ResvCust.FirstName,"~",",","ALL")#'>
	<CFSET LastName_Value = '#replace(ResvCust.LastName,"~",",","ALL")#'>
	<CFSET Address1_Value = '#ResvCustAddress.Address1#'>
	<CFSET Active_Value=#ResvCust.Active#>
	<CFSET Address2_Value = '#ResvCustAddress.Address2#'>
	<CFSET City_Value = '#ResvCustAddress.City#'>
	<CFSET State_Value = '#ResvCustAddress.State#'>
	<CFSET PostalCode_Value = '#ResvCustAddress.PostalCode#'>
	<CFSET EMailAddress_Value = '#EmailAddress.EMailAddress#'>
	<CFSET StartDate_Value = #ResvCust.StartDate#>
	<CFSET UserName_Value = '#Trim(ResvCust.UserName)#'>
	<CFSET Password_Value = '#Trim(ResvCust.Password)#'>
	<cfset PhoneNumber_value = '#HomePhone.PhoneNumber#'>
	<CFSET Country_Value = '#ResvCustAddress.Country#'>
	<CFSET Height_Value = #ResvCust.Height#>
	<cfset weight_value=#ResvCust.weight#>
	<cfset Title_value=#replace(ResvCust.Title,"~",",","ALL")#>
	<CFSET ccno_Value=#ResvCust.ccno#>
	<CFSET cardname_Value=#ResvCust.cardname#>
	<CFSET cctype_Value=#ResvCust.cctype#>
	<CFSET ccexpire_Value=#ResvCust.ccexpire#>
	<CFSET OnMailList_Value=#ResvCust.OnMailList#>
	<cfset ResvCustACtion="update">
	<CFSET AffiliateID_Value= #ResvCust.AffiliateID#>
	<cfif not isnumeric(#AffiliateID_Value#)><cfset AffiliateID_Value=0></cfif>
<CFELSE>

	<CFSET FirstName_Value = ''>
	<CFSET LastName_Value = ''>
	<CFSET Address1_Value  = ''>
	<CFSET Active_Value= 0>
	<CFSET Address2_Value = ''>
	<CFSET City_Value = ''>
	<CFSET State_Value  = ''>
	<CFSET PostalCode_Value = ''>
	<CFSET EMailAddress_Value = ''>
	<CFSET ccno_Value = ''>
	<CFSET cardname_Value  = ''>
	<CFSET cctype_Value = ''>
	<CFSET ccexpire_Value = ''>
	<CFSET StartDate_Value = '#Dateformat(Now())#'>
	<CFSET UserName_Value = ''>
	<CFSET Password_Value = ''>
	<cfset PhoneNumber_value = 'none'>
	<CFSET Country_Value = ''>
	<CFSET Height_Value = ''>
	<cfset weight_value = ''>
	<CFSET Title_Value = ''>
	<CFSET OnMailList_Value= 0>
	<cfset ResvCustaction="insert">
	<CFSET AffiliateID_Value= 0>
	<cfset workphone_value=''>
	<cfset faxphone_value=''>
	<cfset workphoneID='0'>
	<cfset faxphoneID='0'>
</CFIF>

<cfoutput>


<h2>Reservation Customers <B><cfif #ResvCustID# gt 0>Edit<cfelse>Add</cfif> Record</B></h2>

<cfFORM action="adminheader.cfm" method="post">
	<INPUT type="hidden" name="lid" value="#lid#">
	<INPUT type="hidden" name="action" value="ResvCust_recordaction">
	<INPUT type="hidden" name="ResvCustaction" value="#ResvCustaction#">
	<input type="hidden" name="alphabet" value="#alphabet#">
	<input type="hidden" name="addressID" value="#addressID#">
	<input type="hidden" name="PhoneID" value="#PhoneID#">
	<input type="hidden" name="officephoneID" value="#workphoneID#">
	<input type="hidden" name="OnMailList" value="#OnMailList_Value#">
	<input type="hidden" name="faxphoneID" value="#faxphoneID#">
	<input type="hidden" name="EmailID" value="#EmailID#">
	<input type="hidden" name="alphabet" value="#Alphabet#">
	<INPUT type="hidden" name="ResvCustID" value="#ResvCustID#">
	<input type="hidden" name="ResvCustlist" value="1">
	<input type="hidden" name="AffiliateID" value="#affiliateid_value#">
<table align=center>
	<tr>
	    <td width="25%" align=top>
			Title: </td><td><cfinput type="Text" name="title" messHeight="Please enter a title" required="No" size="25" maxlength="250"  value="#trim(title_value)#">
	    </td>
	    <td width="25%" align=top>
	    </td>

	</tr>

	<tr>
	    <td width="25%" align=top>
			First Name: </td><td><cfinput type="Text" name="FirstName" messHeight="Please enter your first name" required="No" size="25" maxlength="25"  value="#trim(FirstName_value)#">
	    </td>
	    <td width="25%" align=top>
			Last Name: </td><td><cfinput type="Text" name="lastName" messHeight="Please enter your last name" required="No" size="25" maxlength="25"  value="#trim(lastName_value)#">
	    </td>

	</tr>
<tr>
    <td width="35%">
		User Name: <font color="red">*</font></td><td><cfinput type="Text" name="UserName" messHeight="Please enter your User Name" required="Yes" size="15" maxlength="25" value="#UserName_value#">
    </td>
    <td width="35%">
		Password: <font color="red">*</font></td><td><cfinput type="text" required="Yes" messHeight="Please enter your Password" name="Pword" size="15" maxlength="25" value="#password_value#">
    </td>

</tr>

	<tr>
	    <td width="25%" align=top>
			Address: </td> <td><cfinput type="Text" name="address1" messHeight="Please enter your Address" required="No" size="25" maxlength="50"  value="#trim(address1_value)#">
		</td>
    <td width="35%">
		Address2:</td><td><cfinput type="Text" name="address2"  required="no" size="15" maxlength="50"  value="#Address2_value#">
    </td>

</tr>


	<tr>
	    <td width="25%" align=top>
			City: </td> <td><cfinput type="Text" name="city" messHeight="Please enter your City" required="Yes" size="25" maxlength="50" value="#trim(city_value)#">
		</td>

	    <td width="25%" align=top>
			State/Province/Other: </td> <td><cfinput type="Text" name="state" messHeight="Please enter your State/Province" required="Yes" size="15" maxlength="50"  value="#trim(state_value)#">
		</td>

	 </tr>
	 <tr>

	    <td width="25%" align=top>
			Zip/Postal Code/Other: </td> <td> <cfinput type="Text" name="postalcode" messHeight="Please enter your Postal Code" required="Yes" size="15" maxlength="15" value="#trim(postalcode_value)#">
		</td>
	    <td width="25%" align=top>
			Country: </td> <td>
			<select name="country" size="1">
			<cfif #Country_value# neq ''><option value="#Country_value#">#Country_Value#</option></cfif>
 		  <cfinclude template="../files/countries.htm">
		  </select>
		</td>
	 </tr>
	  <tr>
	    <td width="25%" align=top>
			Email Address: </td> <td><cfinput type="Text" name="emailaddress" messHeight="Please enter your Email Address" required="Yes" size="25" maxlength="250" value="#trim(emailaddress_value)#">
		</td>
		<td width="25%" align=top>
			Start Date: </td> <td><cfinput type="Text" name="startdate" required="No" size="15" maxlength="25"  value="#dateformat(startdate_value,'mm/dd/yyyy')#">
		</td>
	 </tr>
	 
	<tr>
	    <td width="25%" align=top>
			Home Phone Number: </td> <td><cfinput type="Text" name="PhoneNumber" messHeight="Please enter your Phone Number" required="Yes" size="15" maxlength="25"  value="#trim(phonenumber_value)#">
		</td>
	    <td width="25%" align=top>
			Alt Phone Number:</td> <td><cfinput type="Text" name="officephone"  required="No" size="15" maxlength="25"  value="#trim(workphone_value)#">
		</td>
	 </tr>
	 
	 <tr>
	    <td width=25% align=top>
			Fax Phone Number:</td> <td><cfinput type="Text" name="faxphone"  required="No" size="15" maxlength="25"  value="#trim(faxphone_value)#">
		</td>
		<td width="25%" align=top>
			Status:</td> <td><cfselect name="active" size="1"><option value="0" <cfif #Active_Value# is "0">selected</cfif>>Pending<option value="1" <cfif #Active_Value# is "1">selected</cfif>>Active</cfselect>  
		</td>
	 </tr>

	 <tr>
	    <td width="25%" align=top>
			Height: </td> <td><cfinput type="Text" name="Height" required="No" size="15" maxlength="25"  value="#trim(Height_value)#">
		</td>

	    <td width="25%" align=top>
			Weight:</td> <td><input type="text" name="weight" value="#weight_value#">
		</td>

	 </tr>
 
	<tr>
	    <td width="25%" align=top>
			Credit Card ##: </td><td><cfinput type="Text" name="ccno" message="Please enter your credit card number" required="No" size="25" maxlength="25"  value="#trim(ccno_value)#">
	    </td>
	    <td width="25%" align=top>
			Credit Card Expiration: </td><td><cfinput type="Text" name="ccexpire" message="Please enter your Credit Card Expiration" required="No" size="25" maxlength="25"  value="#trim(ccexpire_value)#">
	    </td>

	</tr>
<tr>
    <td width="35%">
		Name on Card:</td><td><cfinput type="Text" name="cardname" message="Please enter the name on your credit card" required="No" size="15" maxlength="25" value="#cardname_value#">
    </td>
    <td width="35%">
		Credit Card Type:</td><td><cfinput type="text" required="No" message="Please enter your credit card type" name="cctype" size="15" maxlength="25" value="#cctype_value#">
    </td>

</tr>


</table>
<!--- form buttons --->
<p align=center><INPUT type="submit" name="btnEdit_OK" value="    OK    ">

</cfFORM>
</CFOUTPUT>

