<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Utilities">
	<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
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
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="customers">
	<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfparam name="CustomerID" default=0>
<cfparam name="CustomerAction" default="List">
<cfparam name="billFirstName" default="">
<cfparam name="billLastName" default="">
<cfparam name="email" default="">
<cfparam name="ResellerState" default="">
<cfparam name="PhoneNumber" default="">
<cfparam name="ResellerNumber" default="">
<cfparam name="UserName" default="">
<cfparam name="Password" default="">
<cfparam name="startdate" default="#now()#">
<cfparam name="Status" default="0">
<cfparam name="CompanyName" default="">
<cfparam name="CreditCardNumber" default="">
<cfparam name="CreditCardType" default="0">
<cfparam name="CreditCardExpire" default="">
<cfparam name="NameOnCC" default="">
<cfparam name="BillingAddress1" default="">
<cfparam name="BillingAddress2" default="">
<cfparam name="BillingCity" default="">
<cfparam name="BillingState" default="">
<cfparam name="BillingZip" default="">
<cfparam name="BillingCountry" default="">
<cfparam name="BillingPhone" default="">
<cfparam name="BillingEmail" default="">
<cfparam name="ShippingAddress1" default="">
<cfparam name="ShippingAddress2" default="">
<cfparam name="ShippingCity" default="">
<cfparam name="ShippingState" default="">
<cfparam name="ShippingZip" default="">
<cfparam name="ShippingCountry" default="">
<cfparam name="LastOrderID" default=0>
<cfparam name="AffiliateID" default=0>
<cfparam name="OnMailList" default=0>

<cfparam name="BillingAddressID" default="0">
<cfparam name="ShippingAddressID" default="0">
<cfparam name="EmailID" default="0">
<cfparam name="PhoneID" default="0">


<cfif CustomerAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="customers">
		<cfinvokeargument name="XMLFields" value="CustomerID,CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<cfinvokeargument name="XMLIDField" value="CustomerID">
		<cfinvokeargument name="XMLIDValue" value="#CustomerID#">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="CustomerPHone">
		<cfinvokeargument name="XMLFields" value="PhoneID,PhoneTypeID,ConnectID,PhoneNumber">
		<cfinvokeargument name="XMLIDField" value="ConnectID">
		<cfinvokeargument name="XMLIDValue" value="#CustomerID#">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="CustomerEmail">
		<cfinvokeargument name="XMLFields" value="EmailID,EmailTypeID,ConnectID,EmailAddress">
		<cfinvokeargument name="XMLIDField" value="ConnectID">
		<cfinvokeargument name="XMLIDValue" value="#CustomerID#">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Customeraddress">
		<cfinvokeargument name="XMLFields" value="addressID,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<cfinvokeargument name="XMLIDField" value="ConnectID">
		<cfinvokeargument name="XMLIDValue" value="#CustomerID#">
	</cfinvoke>
	<cflocation url="adminheader.cfm?action=productcustomers">
</cfif>
		
<cfif CustomerAction is "Edit">
	<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 	
			method="getCustomer" returnvariable="TheCustomer">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.xmlHandler" 
			method="getXMLRecords" returnvariable="BillingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="selectStatement" value=" where ConnectID='#trim(CustomerID)#' and Addresstypeid='1'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.xmlHandler" 
			method="getXMLRecords" returnvariable="ShippingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="CustomerAddress">
			<cfinvokeargument name="selectStatement" value=" where ConnectID='#CustomerID#' and Addresstypeid='2'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerEmail" returnvariable="CustEmailAddress">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="EmailTypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerPhone" returnvariable="CustPhoneNumber">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="PhonetypeID" value="1">
		</cfinvoke>
		<cfoutput query="CustEmailAddress">
			<cfset EmailID=#EmailID#>
			<cfset Email=#emailaddress#>
		</cfoutput>
		<cfoutput query="CustPhoneNumber">
			<cfset PHoneID=#PHoneID#>
			<cfset Phonenumber=#Phonenumber#>
		</cfoutput>
		<cfoutput query="TheCustomer">
			<cfset resellernumber=#resellernumber#>
			<cfset ResellerState=#ResellerState#>
			<cfset CompanyName='#companyName#'>
			<cfset Password=#password#>
			<cfset username=#username#>
			<cfset affiliateID=#affiliateID#>
			<cfset billfirstname=#firstname#>
			<cfset billlastname=#lastname#>
			<cfset NameOnCC=#cardname#>
			<cfset CreditCardNumber=#ccno#>
			<cfset CreditCardType=#cctype#>
			<cfset CreditCardExpire=#ccexpire#>
			<cfset Status=#active#>
			<cfset Startdate=#startdate#>
			<cfset OnMailList=#OnMailList#>
		</cfoutput>
		<cfoutput query="BillingAddress">
			<cfset BillingZip=#postalcode#>
			<cfset BillingAddress1=#address1#>
			<cfset BillingAddressID=#AddressID#>
			<cfset BillingAddress2=#Address2#>
			<Cfset BillingCity=#city#>
			<Cfset BillingSTate=#state#>
			<cfset BillingCountry=#country#>
		</cfoutput>
		<cfif #ShippingAddress.RecordCount# is 0>
			<cfset ShippingAddress1=#BillingAddress1#>
			<cfset ShippingAddress2=#BillingAddress2#>
			<cfset ShippingCity=#BillingCity#>
			<cfset ShippingState=#BillingSTate#>
			<cfset ShippingCountry=#BillingCountry#>
			<cfset ShippingZip=#BillingZip#>
			<cfset ShippingAddressID=0>	
		<cfelse>
			<cfoutput query="ShippingAddress">
				<cfset ShippingAddress1=#address1#>
				<cfset ShippingAddress2=#Address2#>
				<cfset ShippingCity=#city#>
				<cfset ShippingState=#state#>
				<cfset ShippingCountry=#country#>
				<cfset ShippingZip=#postalcode#>
				<cfset ShippingAddressID=#AddressID#>
			</cfoutput>
		</cfif>
		<cfset CustomerAction="Update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.ResellerState# is ''><cfset form.ResellerState="none"></cfif>
	<cfif #form.ResellerNumber# is ''><cfset form.ResellerNumber="none"></cfif>
	<cfif #form.Phonenumber# is ''><cfset form.Phonenumber="none"></cfif>
	<cfif #form.BillingCountry# is ''><cfset form.BillingCountry="none"></cfif>
	<cfif #form.LastName# is ''><cfset form.LastName="none"></cfif>
	<cfset form.LastName=replace(#form.LastName#,",","~","ALL")>
	<cfif #form.BillingZip# is ''><cfset form.BillingZip="none"></cfif>
	<cfif #form.BillingState# is ''><cfset form.BillingState="none"></cfif>
	<cfif #form.Email# is ''><cfset form.Email="none"></cfif>
	<cfif #form.ShippingCountry# is ''><cfset form.ShippingCountry="none"></cfif>
	<cfif #form.Firstname# is ''><cfset form.Firstname="none"></cfif>
	<cfset form.Firstname=replace(#form.Firstname#,",","~","ALL")>
	<cfif #form.ShippingZip# is ''><cfset form.ShippingZip="none"></cfif>
	<cfif #form.ShippingState# is ''><cfset form.ShippingState="none"></cfif>
	<cfif #form.companyname# is ''><cfset form.companyname="none"></cfif>
	<cfif #CustomerAction# is "Update">
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="UpdateCustomer">
			<cfinvokeargument name="CustomerID" value="#CustomerID#">
			<cfinvokeargument name="Active" value="#Form.Status#">
			<cfinvokeargument name="CardName" value="#Form.NameOnCC#">
			<cfinvokeargument name="CCExpire" value="#Form.CreditCardExpire#">
			<cfinvokeargument name="CCNo" value="#Form.CreditCardNumber#">
			<cfinvokeargument name="CCType" value="#Form.CreditCardType#">
			<cfinvokeargument name="OnMailList" value="#Form.OnMailList#">
			<cfinvokeargument name="StartDate" value="#Form.StartDate#">
			<cfinvokeargument name="firstname" value="#Form.firstname#">
			<cfinvokeargument name="lastname" value="#Form.lastname#">
			<cfinvokeargument name="username" value="#Form.username#">
			<cfinvokeargument name="Password" value="#Form.Password#">
			<cfinvokeargument name="AffiliateID" value="#Form.AffiliateID#">
			<cfinvokeargument name="resellerstate" value="#Form.resellerstate#">
			<cfinvokeargument name="resellernumber" value="#Form.resellernumber#">
			<cfinvokeargument name="companyname" value="#form.companyname#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="UpdatePhone">
			<cfinvokeargument name="PhoneID" value="#Form.PhoneID#">
			<cfinvokeargument name="PhoneTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="PhoneNumber" value="#Form.PhoneNumber#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="UpdateEmail">
			<cfinvokeargument name="EmailID" value="#Form.EmailID#">
			<cfinvokeargument name="EmailTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="EmailAddress" value="#Form.Email#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="UpdateAddress">
			<cfinvokeargument name="AddressID" value="#Form.BillingAddressID#">
			<cfinvokeargument name="AddressTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="Address1" value="#Form.BillingAddress1#">
			<cfinvokeargument name="Address2" value="#Form.BillingAddress2#">
			<cfinvokeargument name="City" value="#Form.BillingCity#">
			<cfinvokeargument name="State" value="#Form.BillingState#">
			<cfinvokeargument name="PostalCode" value="#Form.BillingZip#">
			<cfinvokeargument name="Country" value="#Form.BillingCountry#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="UpdateAddress">
			<cfinvokeargument name="AddressID" value="#Form.ShippingAddressID#">
			<cfinvokeargument name="AddressTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="TableID" value="15">
			<cfinvokeargument name="Address1" value="#Form.ShippingAddress1#">
			<cfinvokeargument name="Address2" value="#Form.ShippingAddress2#">
			<cfinvokeargument name="City" value="#Form.ShippingCity#">
			<cfinvokeargument name="State" value="#Form.ShippingState#">
			<cfinvokeargument name="PostalCode" value="#Form.ShippingZip#">
			<cfinvokeargument name="Country" value="#Form.ShippingCountry#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="AddCustomer">
			<cfinvokeargument name="Active" value="#Form.Status#">
			<cfinvokeargument name="CardName" value="#Form.NameOnCC#">
			<cfinvokeargument name="CCExpire" value="#Form.CreditCardExpire#">
			<cfinvokeargument name="CCNo" value="#Form.CreditCardNumber#">
			<cfinvokeargument name="CCType" value="#Form.CreditCardType#">
			<cfinvokeargument name="OnMailList" value="#Form.OnMailList#">
			<cfinvokeargument name="StartDate" value="#Form.StartDate#">
			<cfinvokeargument name="firstname" value="#Form.firstname#">
			<cfinvokeargument name="lastname" value="#Form.lastname#">
			<cfinvokeargument name="username" value="#Form.username#">
			<cfinvokeargument name="Password" value="#Form.Password#">
			<cfinvokeargument name="AffiliateID" value="#Form.AffiliateID#">
			<cfinvokeargument name="resellerstate" value="#Form.resellerstate#">
			<cfinvokeargument name="resellernumber" value="#Form.resellernumber#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="AddPhone">
			<cfinvokeargument name="PhoneTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="PhoneNumber" value="#Form.PhoneNumber#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="AddEmail">
			<cfinvokeargument name="EmailTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="EmailAddress" value="#Form.Email#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="AddAddress">
			<cfinvokeargument name="AddressTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="Address1" value="#Form.BillingAddress1#">
			<cfinvokeargument name="Address2" value="#Form.BillingAddress2#">
			<cfinvokeargument name="City" value="#Form.BillingCity#">
			<cfinvokeargument name="State" value="#Form.BillingState#">
			<cfinvokeargument name="PostalCode" value="#Form.BillingZip#">
			<cfinvokeargument name="Country" value="#Form.BillingCountry#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.customersXML" method="AddAddress">
			<cfinvokeargument name="AddressTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#CustomerID#">
			<cfinvokeargument name="Address1" value="#Form.ShippingAddress1#">
			<cfinvokeargument name="Address2" value="#Form.ShippingAddress2#">
			<cfinvokeargument name="City" value="#Form.ShippingCity#">
			<cfinvokeargument name="State" value="#Form.ShippingState#">
			<cfinvokeargument name="PostalCode" value="#Form.ShippingZip#">
			<cfinvokeargument name="Country" value="#Form.ShippingCountry#">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=productcustomers">
</cfif>

<cfoutput>
<h1>Customers</h1>
<p>

<cfif CustomerAction is "Update" or #CustomerAction# is "Add">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="CustomerID" value="#CustomerID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CustomerAction" value="#CustomerAction#">
<input type="Hidden" name="startdate" value="#startdate#">
<input type="hidden" name="BillingAddressID" value="#BillingAddressID#">
<input type="hidden" name="ShippingAddressID" value="#ShippingAddressID#">
<input type="hidden" name="EmailID" value="#EmailID#">
<input type="hidden" name="PhoneID" value="#PhoneID#">
      <TABLE>
	<TR>
	      <TD valign="top"> Company Name: </TD>
    <TD colspan=3>
	
		<INPUT type="text" name="Companyname" value="#Companyname#" size=40 maxLength="125">
	</td>
	</tr>
	<TR>
	      <TD valign="top"> Contact Name: </TD>
    <TD>
	
		First: <INPUT type="text" name="FirstName" value="#billFirstName#" size=40 maxLength="125">
	</td><td></td><td>
		Last: <INPUT type="text" name="LastName" value="#billLastName#" size=40 maxLength="125">
		
	</TD>
	</tr>
	<TR>
	      <TD valign="top"> User Name </TD>
          <TD> 
            <input type="text" value="#username#" name="username">	
          </TD>      
          <TD valign="top">Password </TD>
          <TD><input type="Password" value="#Password#" name="Password"> 
          </TD>
	</TR>
	<TR>
	      <TD valign="top"> Billing Address1 </TD>
          <TD> 
            <input type="text" value="#BillingAddress1#" name="BillingAddress1">	
          </TD>      
          <TD valign="top">Shipping Address1 </TD>
          <TD><input type="text" value="#ShippingAddress1#" name="ShippingAddress1"> 
          </TD>
	</TR>
	<tr>
	      <td valign=top> Billing Address2 </td>
	      <td> 
            <input type="text" value="#BillingAddress2#" name="BillingAddress2"></td>
	      <td valign=top> Shipping Address2 </td>
	      <td> 
            <input type="text" value="#ShippingAddress2#" name="ShippingAddress2"></td>
	</tr>
	
	<tr>
	      <td valign=top> Billing City </td>
	      <td> 
            <input type="text" value="#BillingCity#" name="BillingCity"></td>
	      <td valign=top>Shipping City </td>
	      <td><input type="text" value="#ShippingCity#" name="ShippingCity"></td>
	</tr>
	<tr>
	      <td valign=top> Billing State:</td>
	      <td> 
            <input type="text" name="BillingState" value="#BillingState#" size=25 maxlength="125"></td>
	      <td valign=top>Shipping State: </td>
	      <td><input type="text" value="#ShippingState#" name="ShippingState"></td>
	</tr>

	<tr>
	      <td valign=top>Zip/Postal Code/Other: </td>
	      <td><input type="text" name="BillingZip" value="#BillingZip#" size=25 maxlength="125"> 
          </td>
	      <td valign=top>Shipping Zip </td>
	      <td><input type="text" value="#ShippingZip#" name="ShippingZip"> </td>
	</tr>
	<tr>
	      <td valign=top>Billing Country: </td>
	      <td><input type="text" value="#BillingCountry#" name="BillingCountry"></td>
	      <td valign=top> Shipping Country</td>
	      <td> 
            <input type="text" value="#ShippingCountry#" name="ShippingCountry"> 
          </td>
	</tr>
	
	<tr>
	      <td valign=top> Email:</td>
	      <td><input type="text" value="#Email#" name="Email"></td>      
          <td valign=top>Phone: </td>
	      <td><input type="text" value="#Phonenumber#" name="Phonenumber"></td>
	</tr>
	<tr>
	      <td valign=top> Member ID </td>
	<td>#AffiliateID#<input type="hidden" value="#AffiliateID#" name="AffiliateID"></td>
	      <td valign=top> On Mailing List? </td>
	<td><select name="OnMailList">
		<option value="0"<cfif #OnMailList# is 0> selected</cfif>>No</option>
		<option value="1"<cfif #OnMailList# is 1> selected</cfif>>Yes</option>
	</select></td>
	</tr>

	
	<tr>
	      <td valign=top> Credit Card Type </td>
	<td><select name="CreditCardType">
		<option value="0" <cfif #ListFind(CreditCardType,"0")#>selected</cfif>>None</option>
		<cfif #AllowMC# is 1><option value="MasterCard"<cfif #ListFind(CreditCardType,"MasterCard")#>selected</cfif>>Master Card</cfif>
		<cfif #AllowVISA# is 1><option value="VISA"<cfif #ListFind(CreditCardType,"VISA")#> selected</cfif>>VISA</cfif>
		<cfif #AllowAMEX# is 1><option value="AMEX"<cfif #ListFind(CreditCardType,"AMEX")#> selected</cfif>>AMEX</cfif>
		<cfif #AllowDiscover# is 1><option value="Discover"<cfif #ListFind(CreditCardType,"Discover")#> selected</cfif>>Discover</cfif>
		<cfif #AllowCarteBlanch# is 1><option value="CarteBlanche"<cfif #ListFind(CreditCardType,"CarteBlanche")#> selected</cfif>>Carte Blanche</cfif>
		<cfif #AllowChecks# is 1><option value="Check"<cfif #ListFind(CreditCardType,"Check")#> selected</cfif>>Check</cfif>
		<cfif #AllowDinersClub# is 1><option value="DinersClub"<cfif #ListFind(CreditCardType,"DinersClub")#> selected</cfif>>Diners Club</cfif>
		<option value="GiftCertificate"<cfif #ListFind(CreditCardType,"GiftCertificate")#> selected</cfif>>Gift Certificate
		<option value="StorePromotion"<cfif #ListFind(CreditCardType,"StorePromotion")#> selected</cfif>>Store Promotion
		<Option value="StoreCreditCard"<cfif #ListFind(CreditCardType,"StoreCreditCard")#> selected</cfif>>Store Credit Card
	</select>
	</td>
	      <td valign=top> Name On CC </td>
	<td><input type="text" value="#NameOnCC#" name="NameOnCC"></td>
	</tr>
	<tr>
	      <td valign=top> Credit Card Number </td>
	<td><input type="text" value="#CreditCardNumber#" name="CreditCardNumber"></td>
	      <td valign=top> Credit Card Expire </td>
	<td><input type="text" value="#CreditCardExpire#" name="CreditCardExpire"></td>
	</tr>
	<tr>
	      <td valign=top>Status </td>
	      <td><select name="Status">
		  	<option value="0"<cfif #int(status)# is 0> selected</cfif>>Pending</option>
			<option value="1"<cfif #int(status)# is 1> selected</cfif>>Active</option>
		  </select></td>
	      <td valign=top>Reseller Information</td>
	      <td>Number: <input type="text" name="resellernumber" value="#resellernumber#"><br>
		  State: <input type="text" name="resellerstate" value="#resellerstate#"></td>
	</tr>

</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM></cfif>
</CFOUTPUT>
	
<cfif #TheFileExists# is "true" and #CustomerAction# is "List">
<cfparam name="alphabet" default="a">
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Allcustomers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="customers">
	<cfinvokeargument name="SelectStatement" value=" where (lastname like '#ucase(alphabet)#%' or lastname like '#lcase(alphabet)#%') or (companyname like '#ucase(alphabet)#%' or companyname like '#lcase(alphabet)#%')">
	<cfinvokeargument name="orderbystatement" value=" order by lastname">
</cfinvoke>
<cfoutput>
<form action="adminheader.cfm" method="post" name="findemail">
		<input type="hidden" name="CustomerAction" value="List">
		<input type="hidden" name="action" value="#action#">
		<input type="text" name="alphabet"><input type="submit" name="emailsubmit" value="Find">
	</form>
Sort is by company name or lastname so you will see both in the resulting list alphabetically by lastname<br>
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=a">A</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=b">B</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=c">C</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=d">D</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=e">E</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=f">F</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=g">G</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=h">H</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=i">I</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=j">J</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=k">K</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=l">L</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=m">M</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=n">N</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=o">O</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=p">P</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=q">Q</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=r">R</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=s">S</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=t">T</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=u">U</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=v">V</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=w">W</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=x">X</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=y">Y</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=z">Z</a></P></cfoutput>

<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Customers</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Company</p></td>
<td><p>Contact</p></td>
<td><p>Email</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="Allcustomers">
	<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
		method="getCustomerEmail" returnvariable="CustEmailAddress">
		<cfinvokeargument name="customerid" value="#customerID#">
		<cfinvokeargument name="EmailTypeID" value="1">
	</cfinvoke>
<cfset Email=#CustEmailAddress.EmailAddress#>
<tr>
<td><p>#CustomerID#</p></td>
<td><p>#CompanyName#</p></td>
<td><p>#firstname# #lastname#</p></td>
<td><p>#email#</p></td>

<td><a href= "adminheader.cfm?CustomerID=#CustomerID#&CustomerAction=Edit&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CustID=#CustomerID#&Action=customerhistory">Order History</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CustomerID=#CustomerID#&CustomerAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

