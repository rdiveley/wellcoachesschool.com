<cfparam name="CartID" default=0>
<cfparam name="CartAction" default="List">
<cfparam name="CUSTOMERID" default="0">
<cfparam name="EXPIREDATE" default="">
<cfparam name="CREATEDATE" default="">
<cfparam name="DAteShipped" default="">
<cfparam name="COMMENTS" default="">
<cfparam name="GIFTWRAP" default="">
<cfparam name="PURCHASEORDER" default="">
<cfparam name="BILLINGADDRESSID" default="0">
<cfparam name="SALESTAX" default="0">
<cfparam name="SHIPPINGADDRESSID" default="0">
<cfparam name="SHIPPINGAMT" default="0">
<cfparam name="SHIPPINGMETHOD" default="0">
<cfparam name="SHIPPINGTYPE" default="0">
<cfparam name="STORELOCATION" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllCarts">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="CartHdr">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForumNames">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="ForumNames">
</cfinvoke>

<cfif CartAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.catalog" method="deletecart">
		<cfinvokeargument name="CartID" value="#CartID#">
	</cfinvoke>
	<cfset CartID=0>
	<cfset CartAction="List">
</cfif>
		
<cfif CartAction is "edit">
	<cfparam name="quantity" default=1>
	<cfparam name="action" default="Start">
	<cfparam name="invnbr" default=0>
	<cfparam name="ChangeItem" default="add">
	<cfparam name="ShippingMethod" default=0>
	<cfparam name="DetailNbr" default=0>
	<cfparam name="Message" default=''>
	<cfparam name="billfirstname" default=''>
	<cfparam name="billlastname" default=''>
	<cfparam name="email" default=''>
	<cfparam name="emailID" default='0'>
	<cfparam name="PhoneNumber" default=''>
	<cfparam name="PhoneID" default='0'>
	<cfparam name="Address1" default=''>
	<cfparam name="parish" default=''>
	<cfparam name="VolumeDiscount" default=0>
	<cfparam name="DealerID" default=0>
	<cfparam name="Address2" default=''>
	<cfparam name="Password" default=''>
	<cfparam name="CustomerNumber" default=0>
	<Cfset City=''>
	<Cfset STate=''>
	<cfparam name="Country" default="USA">
	<cfparam name="PostalCode" default=''>
	<cfset email=''>
	<cfparam name="shipfirstname" default=''>
	<cfparam name="shiplastname" default=''>
	<cfparam name="shipAdd1" default=''>
	<cfparam name="shipAdd2" default=''>
	<cfparam name="shipCity" default=''>
	<cfparam name="shipState" default=''>
	<cfparam name="shipCountry" default="USA">
	<cfparam name="shipPostal" default=''>
	<cfparam name="SalesTax" default=0>
	<cfparam name="resellnumber" default=''>
	<cfparam name="resellstate" default=''>
	<cfparam name="BillingAddressID" default="0">
	<cfparam name="ShippingAddressID" default="0">
	<cfparam name="Shipping" default=0>
	
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductConfig">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="ProductConfig">
	</cfinvoke>
	<cfoutput query="ProductConfig">
		<cfset ProductsPerPage=#ProductsPerPage#>
		<cfset ItemListStyle=#ItemListStyle#>
		<cfset CatListStyle=#CatListStyle#>
		<cfset SearchPageID=#SearchPageID#>
		<cfset ViewCartpage=#ViewCartpage#>
		<cfset CatListPage=#CatListPage#>
		<cfset SearchResultsPage=#SearchResultsPage#>
		<cfset ItemListPage=#ItemListPage#>
		<cfset ThankYouPage=#ThankYouPage#>
		<cfset ProductSpecsPage=#ProductSpecsPage#>
		<cfset UseGridsorDropDowns=#UseGridsorDropDowns#>
		<cfset ShipTrackerPage=#ShipTrackerPage#>
		<cfset CheckOutPage=#CheckOutPage#>
		<cfset NewItemDays=#NewItemDays#>
		<cfset NewItemText=#NewItemText#>
		<cfset SpecialsText=#SpecialsText#>
		<cfset ShippedEmailText=#ShippedEmailText#>
	</cfoutput>
	
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
	
	<cfset thisdate = dateformat(now(),"mm/dd/yyyy")>
	
	<cfinvoke component="#Application.WebSitePath#.Utilities.catalog" 
		method="GetCartHeader" returnvariable="MyCartHeader">
		<cfinvokeargument name="CartID" value="#cartid#">
	</cfinvoke>
	<cfoutput query="MyCartHeader">
		<cfset salestax=#salestax#>
		<cfset shipping=#ShippingAmt#>
		<cfif Shipping is ''><cfset Shipping=0></cfif>
		<cfset ShippingMethod=#ShippingMethod#>
		<cfset COMMENTS=#COMMENTS#>
		<cfset CREATEDATE=#CREATEDATE#>
		<cfset EXPIREDATE=#EXPIREDATE#>
		<cfset GIFTWRAP=#GIFTWRAP#>
		<cfset PURCHASEORDER=#PURCHASEORDER#>
		<cfset SHIPPINGTYPE=#SHIPPINGTYPE#>
		<cfset STORELOCATION=#STORELOCATION#>
	</cfoutput>
	
	<cfset CustomerID=#MyCartHeader.Customerid#>
	<Cfif #CUSTOMERID# gt 0>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 	
			method="getCustomer" returnvariable="TheCustomer">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerAddress" returnvariable="BillingAddress">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="AddresstypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerAddress" returnvariable="ShippingAddress">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="AddresstypeID" value="2">
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
			<cfset resellnumber=#resellernumber#>
			<cfset resellstate=#ResellerState#>
			<cfset CustomerNumber=#CUSTOMERNUMBER#>
			<cfset Password=#password#>
			<cfset billfirstname=#firstname#>
			<cfset billlastname=#lastname#>
			<cfset shipfirstname=#firstName#>
			<cfset shiplastname=#lastname#>
			<cfset Cardname=#cardname#>
			<cfset ccno=#ccno#>
			<cfset cctype=#cctype#>
			<cfset ccexpire=#ccexpire#>
		</cfoutput>
		<cfoutput query="BillingAddress">
			<cfset PostalCode=#postalcode#>
			<cfset Address1=#address1#>
			<cfset BillingAddressID=#AddressID#>
			<cfset Address2=#Address2#>
			<Cfset City=#city#>
			<Cfset STate=#state#>
			<cfset Country=#country#>
		</cfoutput>
		<cfoutput query="ShippingAddress">
			<cfset shipAdd1=#address1#>
			<cfset shipAdd2=#Address2#>
			<cfset shipCity=#city#>
			<cfset shipState=#state#>
			<cfset shipCountry=#country#>
			<cfset shipPostal=#postalcode#>
			<cfset ShippingAddressID=#AddressID#>
		</cfoutput>
	</cfif>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="shippingconfig">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="shippingconfig">
		<cfinvokeargument name="IDFieldName" value="shippingconfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="shippingconfig">
		<cfset RushStartAmt=#RushStartAmt#>
		<cfset RegularStartAmt=#RegularStartAmt#>
		<cfset IncrementAmt=#IncrementAmt#>
		<cfset StopAtAmt=#StopAtAmt#>
		<cfset StopAtNo=#StopAtNo#>
		<cfset SalesTaxPercent=#SalesTaxPercent#>
		<cfset GiftWrapAmt=#GiftWrapAmt#>
		<cfset disclaimer=#disclaimer#>
		<cfset ResellState=#ResellState#>
		<cfset IntershipperPword=#IntershipperPword#>
		<cfset IntershipperEmail=#IntershipperEmail#>
		<cfset SendEmail=#SendEmail#>
	</cfoutput>
	<cfparam name="shipping" default=#RegularStartAmt#>
	<cfparam name="shipping2" default=#RegularStartAmt#>
	<cfinvoke component="#Application.WebSitePath#.Utilities.catalog" 
		method="GetCart" returnvariable="MyCart">
		<cfinvokeargument name="CartID" value="#cartid#">
	</cfinvoke>
	<cfset GrandTotal=0>
	<cfif #MyCart.RecordCount# gt 0>
		<cfloop query="MyCart">
			<Cfset ThisPrice=#Price# * 100>
			<cfset ThisPrice=#round(ThisPrice)# / 100>
			<cfset ThisPrice="#ThisPrice#">
			<cfset total=#ThisPrice#*(#QTYORDERED#)>
			<cfset GrandTotal=#total# + #GrandTotal#>
		</cfloop>
	</cfif>
	<cfset CartAction="Update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.DAteShipped=replace(#Form.DAteShipped#,",","~","ALL")>
	<cfif form.BILLINGADDRESSID is ""><cfset Form.CartID="none"></cfif>
	<cfif CartID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
			<cfinvokeargument name="XMLFields" 
			value="CUSTOMERID,EXPIREDATE,CREATEDATE,DAteShipped,COMMENTS,GIFTWRAP,PURCHASEORDER,BILLINGADDRESSID,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION">
			<cfinvokeargument name="XMLFieldData" 
			value="#form.CUSTOMERID#,#form.EXPIREDATE#,#form.CREATEDATE#,#form.DAteShipped#,#form.COMMENTS#,#form.GIFTWRAP#,#form.PURCHASEORDER#,#form.BILLINGADDRESSID#,#form.SALESTAX#,#form.SHIPPINGADDRESSID#,#form.SHIPPINGAMT#,#form.SHIPPINGMETHOD#,#form.SHIPPINGTYPE#,#form.STORELOCATION#">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#CartID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
			<cfinvokeargument name="XMLFields" 
			value="CUSTOMERID,EXPIREDATE,CREATEDATE,DAteShipped,COMMENTS,GIFTWRAP,PURCHASEORDER,BILLINGADDRESSID,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION">
			<cfinvokeargument name="XMLFieldData" 
			value="#form.CUSTOMERID#,#form.EXPIREDATE#,#form.CREATEDATE#,#form.DAteShipped#,#form.COMMENTS#,#form.GIFTWRAP#,#form.PURCHASEORDER#,#form.BILLINGADDRESSID#,#form.SALESTAX#,#form.SHIPPINGADDRESSID#,#form.SHIPPINGAMT#,#form.SHIPPINGMETHOD#,#form.SHIPPINGTYPE#,#form.STORELOCATION#">
			<cfinvokeargument name="XMLIDField" value="CartID">
		</cfinvoke>
	</cfif>
	<cfset CartAction="list">
	<cfset CartID = 0>
	<cfset CUSTOMERID='0'>
	<cfset EXPIREDATE=''>
	<cfset CREATEDATE="#dateformat(now(),'mm/dd/yyyy')#">
	<cfset DAteShipped="0">
	<Cfset COMMENTS="">
	<Cfset GIFTWRAP="0">
	<Cfset PURCHASEORDER="">
	<Cfset BILLINGADDRESSID="0">
	<cfset SALESTAX="0">
	<cfset SHIPPINGADDRESSID="0">
	<cfset SHIPPINGAMT="0">
	<cfset SHIPPINGMETHOD="0">
	<cfset SHIPPINGTYPE="0">
	<cfset STORELOCATION="">
</cfif>

<cfoutput>
<h1>Shopping Carts</h1>

<cfif CartAction is "Add" or CartAction is "Update">
<cfform action="adminheader.cfm?uploadfile=true" 
	enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="CartID" value="#CartID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="CartAction" value="delete">
<input type="hidden" name="CustomerID" value="#CustomerID#">
<input type="hidden" name="EmailID" value="#EmailID#">
<input type="hidden" name="PhoneID" value="#PhoneID#">
<input type="hidden" name="invnbr" value="#invnbr#">
<input type="hidden" name="BillingAddressID" value="#BillingAddressID#">
<input type="hidden" name="ShippingAddressID" value="#ShippingAddressID#">

<table  border="0" width=100%>
  <tr>
    <td align="middle" vAlign="top">
	
	<table><tr>
	<td valign=top>
	 
	 
	  <table  width="100%" border=0>
	  <tr><th colspan=2 >Billing/Credit Card Billing Address</th></tr>

      <tr >
        <td width="50%"><font color="red">*</font>Name</td>
        <td align="left" width="50%">First: <cfinput type="Text" name="BillFirstName" required="Yes" value="#Trim(BillFirstName)#" message="Please enter the Name for Billing."><br>Last: <cfinput type="Text" name="BillLastName" required="Yes" value="#Trim(BillLastName)#" message="Please enter the Name for Billing."></td>
      </tr>
	  <tr >
        <td width="50%"><font color="red">*</font>Billing Address</td>
        <td align="left" width="50%"><cfinput type="Text" name="address1" required="Yes" value="#Trim(Address1)#" message="Please enter a Billing Address."></td>
      </tr>
	  <tr >
        <td width="50%">&nbsp;</td>
        <td align="left" width="50%"><cfinput type="Text" name="address2" required="No" value="#Trim(Address2)#"></td>
      </tr>
	  <tr >
      <td width="50%"><font color="red">*</font>City</td>
        <td width="50%"><cfinput type="Text" name="city" required="Yes" size="25" maxlength="25" value="#Trim(city)#" message="Please enter a Billing City."></td>
		</tr>
        <tr >
        <td width="50%"><font color="red">*</font>State/Province/Other</td>
        <td width="50%"><cfinput type="Text" name="state" required="Yes" size="25" maxlength="25" value="#Trim(state)#" message="Please enter a Billing State."></td>
      </tr>
	  <tr >
      <td width="50%">Postal Code</td>
        <td width="50%"><cfinput type="Text" name="postalcode" required="Yes" size="25" maxlength="9" value="#Trim(postalcode)#"></td>
		</tr>

        <tr >
        <td width="50%"><font color="red">*</font>Country</td>
        <td width="50%"><cfinput type="Text" name="country" required="Yes" size="25" maxlength="35" value="#Trim(country)#" message="Please enter a Billing Country."></td>
      </tr>
	  </table>
	  
</td>
	<td valign=top>
	<table width="100%"  border=0>
		<tr><th colspan=2 >Shipping Address</th></tr>
	  <tr >
        <td width="50%"><font color="red">*</font>Name</td>
        <td align="left" width="50%">First: <cfinput type="Text" name="shipfirstname" required="Yes" value="#Trim(shipfirstname)#" message="Please enter the name for the Shipping address."><br>Last: <cfinput type="Text" name="shiplastname" required="Yes" value="#Trim(shiplastname)#" message="Please enter the name for the Shipping address."></td>
      </tr>
	  <tr >
        <td width="50%"><font color="red">*</font>Shipping Address</td>
        <td align="left" width="50%"><cfinput type="Text" name="shipadd1" required="Yes" value="#Trim(shipAdd1)#" message="Please enter the Shipping address."></td>
      </tr>
	  <tr >
        <td width="50%">&nbsp;</td>
        <td align="left" width="50%"><cfinput type="Text" name="shipadd2" required="No" value="#Trim(shipAdd2)#"></td>
      </tr>
	  <tr >
      <td width="50%">City</td>
        <td width="50%"><cfinput type="Text" name="shipCity" required="no" size="25" maxlength="25" value="#Trim(shipcity)#" message="Please enter the City for Shipping."></td>
		</tr>
        <tr >
        <td width="50%">State/Province/Other</td>
        <td width="50%"><input type="text" name="shipstate" value="#Trim(shipState)#"></td>
      </tr>
	  <tr >
      <td width="50%">Postal Code</td>
        <td width="50%"><cfinput type="Text" name="shippostal" required="no" size="25" maxlength="9" value="#Trim(shipPostal)#" message="Please enter the Zip or Postal code for shipping."></td>
		</tr>

        <tr >
        <td width="50%">Country</td>
        <td width="50%"><cfinput type="Text" name="shipcountry" required="Yes" size="25" maxlength="35" value="#Trim(shipCountry)#" message="Please enter the Country for Shipping."><input type="hidden" name="shipcountry" value="Barbados"></td>
      </tr>
	  </table>
	  
	  
	 </td></tr></table>	  
	  
	  &nbsp;
	  <table  width="490" border=0>
	  <tr><th colspan=2 >Payment Information</th></tr>
	  <tr >
        <td width="50%">Name on the Credit Card</td>
        <td align="left" width="50%"><cfinput type="Text" name="CardName" required="Yes" value="#Cardname#"></td>
      </tr>
      <tr >
        <td width="50%">Credit Card Number</td>
        <td align="left" width="50%"><cfinput type="Text" name="CCNumber" required="Yes" value="#ccno#"></td>
      </tr>
      <tr >
        <td width="50%">Expiration Date </td>
		<cfset monthlist="January,February,March,April,May,June,July,August,September,October,November,December">
        <td align="left" width="50%">
		<cfset tCounter="01">
		<cfset gCounter=1>
		<cfselect name="ExpMonth" size="1" required="Yes">
		<cfloop list="#monthList#" index="ThisMonth">
			<option value="#tCounter#"<cfif #month(ccexpire)# is #tCounter#> selected</cfif>>#ThisMonth#</option>
			<cfset gCounter=#gCounter# + 1>
			<cfif len(gCounter) is 1>
				<cfset tCounter="0#gCounter#">
			<cfelse>
				<cfset tCounter="#gCounter#">
			</cfif>
		</cfloop>
		</cfselect>
		<cfselect name="ExpYear" size="1" required="Yes"><option value="2003">2003<option value="2004">2004<option value="2005">2005<option value="2006">2006<option value="2007">2007<option value="2008">2008<option value="2009">2009<option value="2010">2010<option value="2011">2011<option value="2012">2012<option value="2013">2013<option value="2014">2014<option value="2015">2015<option value="2016">2016<option value="2017">2017
		</cfselect>
		</td>
      </tr>
      <tr >
        <td width="50%">Credit Card Type</td>
        <td align="left" width="50%">
		<cfselect name="CCType" size="1" required="No">
		<cfif #AllowMC# is 1><option value="MasterCard"<cfif #CCType# is "MasterCard"> selected</cfif>>Master Card</cfif>
		<cfif #AllowVISA# is 1><option value="VISA"<cfif #CCType# is "VISA"> selected</cfif>>VISA</cfif>
		<cfif #AllowAMEX# is 1><option value="AMEX"<cfif #CCType# is "AMEX"> selected</cfif>>AMEX</cfif>
		<cfif #AllowDiscover# is 1><option value="Discover"<cfif #CCType# is "Discover"> selected</cfif>>Discover</cfif>
		<cfif #AllowCarteBlanch# is 1><option value="CarteBlanche"<cfif #CCType# is "CarteBlanche"> selected</cfif>>Carte Blanche</cfif>
		<cfif #AllowChecks# is 1><option value="Check"<cfif #CCType# is "Check"> selected</cfif>>Check</cfif>
		<cfif #AllowDinersClub# is 1><option value="DinersClub"<cfif #CCType# is "DinersClub"> selected</cfif>>Diners Club</cfif>
		<option value="GiftCertificate"<cfif #CCType# is "GiftCertificate"> selected</cfif>>Gift Certificate
		<option value="StorePromotion"<cfif #CCType# is "StorePromotion"> selected</cfif>>Store Promotion
		<Option value="StoreCreditCard"<cfif #CCType# is "StoreCreditCard"> selected</cfif>>Store Credit Card
		</cfselect></td>

      </tr>
	<tr >
        <td width="50%"><font color="red">*</font>Your Email Address</td>
        <td width="50%"><cfinput type="Text" name="email" required="Yes" size="25" maxlength="200" value="#Trim(Email)#" message="Please enter your email address."></td>
      </tr>
	<tr >
        <td width="50%"><font color="red">*</font>Your Password</td>
        <td width="50%"><cfinput type="Password" name="Password" required="Yes" size="25" maxlength="200" value="#Trim(Password)#" message="Please enter your Password."></td>
      </tr>
	  <tr >
        <td width="50%"><font color="red">*</font>Your Phone Number</td>
        <td width="50%"><cfinput type="Text" name="phonenumber" required="Yes" size="25" maxlength="200" value="#Trim(phonenumber)#" message="Please enter your Phone Number."></td>
      </tr>
	  <tr >
        <td width="50%">Your Comments</td>
        <td width="50%"><textarea name="Comments">#comments#</textarea></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
<table align=center >

	<tr><td colspan=2><strong>Disclaimer:</strong><br><BR>
	#ParagraphFormat(Disclaimer)#</td></tr>
	<tr><td></td><td style="text-alignment: right;"><cfInput required="yes" message="Please accept the disclaimer" type="checkbox" name="acceptdisclaimer" value="1" checked> <strong>Accept Disclaimer</strong></td></tr>
	
	
	<tr><td colspan=2><hr></td></tr>
	<tr><td>Would you like gift wrapping?<br>(Price: $#GiftWrapAmt# Per Item)</td><td>Yes: <input type="checkbox" name="giftwrap" value="1" onClick="addgiftwrap()"><input type="text" name="GiftWrapTotal" value="#giftwrap#"></td></tr>
	<tr><td colspan=2><hr></td></tr>
	
	<tr><Td>Select area for delivery: </td><td>
		<select name="parish">
		<cfif #ListLen(SendEmail)# gt 1>
			<cfloop index="UU" list="#SendEmail#">
				<option value="#ListGetAt(UU,2,'/')#" <cfif #ShipState# is "#ListGetAt(UU,1,'/')#">selected</cfif>>#ListGetAt(UU,1,'/')#</option>
			</cfloop>
		<cfelse>
			<option value="#application.EMAIL#" <cfif #ShipState# is "#application.WEbsitename#">selected</cfif>>#application.WEbsitename#</option>
		</cfif>
		</select>
	</td></tr>
	
	<tr><Td>Select Shipping Method: </td><td>
				<select name="shippingmethod" onChange="getshipping()">
			<option value="0">---Select Method---</option>
			<option value="amregular"<cfif #ShippingMethod# is "amregular"> selected</cfif>>AM Regular - Within 24 hours</option>
			<option value="pmregular"<cfif #ShippingMethod# is "pmregular"> selected</cfif>>PM Regular - Within 24 hours</option>
			<option value="amrush"<cfif #ShippingMethod# is "amrush"> selected</cfif>>AM Rush - Within 12 hours</option>
			<option value="pmrush"<cfif #ShippingMethod# is "pmrush"> selected</cfif>>PM Rush - Within 12 hours</option>
			<option value="ampickup"<cfif #ShippingMethod# is "ampickup"> selected</cfif>>AM Pickup</option>
			<option value="pmpickup"<cfif #ShippingMethod# is "pmpickup"> selected</cfif>>PM Pickup</option>
		</select>
	</td></tr>
	
	<tr><td>Item Total:</td> <td align="right">#dollarformat(GrandTotal)#</td></tr>
	<input type="Hidden" name="ItemsTotal" value="#GrandTotal#">
	<tr>
		<td>Sales TAx:</td>
		<td align="right">
		<cfif #ucase(left(shipstate,2))# is #ucase(ResellState)# and #resellnumber# is ''>
			<cfset SalesTAx=(#GrandTotal# * #SalesTaxPercent#) / 100>
			<Cfset GrandTotal=#GrandTotal# + #SalesTAx#>
			#dollarformat(SalesTAx)#
			<input type="hidden" value="#SalesTax#" name="SalesTax">
			<br>
			Resale ##: <input type="text" name="resellnumber"><br>
			Resale State: <input type="hidden" value="#ResellState#" name="resellstate">
		<cfelse>$0.00
		<input type="hidden" value="0" name="SalesTAx">
		<input type="hidden" value="" name="resellnumber">
		<input type="hidden" value="#ResellState#" name="resellstate">
		</cfif></td>
	</tr>
	<tr>
		<td>Shipping:</td><td align="right">
		<input type="text" name="shipping2" value="#shipping#" size="10" readonly>
		<input type="hidden" name="shipping" value="#shipping#"></td>
	</tr>
	<tr>
		<cfif #INtershipperEmail# neq 'none' and #IntershipperEmail# neq ''>
			<td align="right" colspan=2>
				<cfset ShippingList=''>
				<cfif ListFind(#AvailableMethods#,"FedEx")>
					<cfset ShippingList=ListAppend(#ShippingList#,"FedEx")></cfif>
				<cfif ListFind(#AvailableMethods#,"UPS")>
					<cfset ShippingList=ListAppend(#ShippingList#,"UPS")></cfif>
				<cfif ListFind(#AvailableMethods#,"USPS")>
					<cfset ShippingList=ListAppend(#ShippingList#,"USPS")></cfif>
				<cfif ListFind(#AvailableMethods#,"Airborne")>
					<cfset ShippingList=ListAppend(#ShippingList#,"Airborne")></cfif>
				<cfif ListFind(#AvailableMethods#,"DHL")>
					<cfset ShippingList=ListAppend(#ShippingList#,"DHL")></cfif>
				<cfif ListFind(#AvailableMethods#,"AirNet")>
					<cfset ShippingList=ListAppend(#ShippingList#,"AirNet")></cfif>
				<cfif ListFind(#AvailableMethods#,"Emery")>
					<cfset ShippingList=ListAppend(#ShippingList#,"Emery")></cfif>
				<cfif ListFind(#AvailableMethods#,"BAX")>
					<cfset ShippingList=ListAppend(#ShippingList#,"BAX")></cfif>
				<CF_InterShipper 		
					EMAIL="#IntershipperEmail#"
					PASSWORD="#IntershipperPWord#"
					CARRIERS="#ShippingList#"
					ORIGPOSTAL="#WebZip#"
					DESTPOSTAL="#shipPostal#"
					WEIGHT="#ShippingPounds#"
					WEIGHTUNITS="LB"
					SHIPDATE="#dateformat(now(),'mm/dd/yyyy')#"
					SHIPMETHOD="SCD"
					RETURNARRAY="results">
				<table >
				<tr ><th>Select</th><th>Carrier</th><th>Rate</th><th>Transit Days</th></tr>
				<cfloop index="loopdex" from="1" to="#arraylen(Results)#">
					<tr >
					<td><cfif #ucase(ShippingMethod)# is "#ucase(results[loopdex].carriername)# #ucase(results[loopdex].methodname)#"><input type="radio" name="ShippingMethod" value="#results[loopdex].carriername# #results[loopdex].methodname#" checked onClick="getshipping(#results[loopdex].methodrate#)"><cfelse><input type="radio" name="ShippingMethod" onClick="getshipping(#results[loopdex].methodrate#)" value="#results[loopdex].carriername# #results[loopdex].methodname#"></cfif></td> 
					<td>#results[loopdex].carriername# #results[loopdex].methodname#</td>
					<td style="text-align: right;">#dollarformat(results[loopdex].methodrate)#</td>
					<td style="text-align: center;">#results[loopdex].methodtransitdays#</td></tr>
				</cfloop>
				</table>
		</cfif>
	</tr>
	<tr>
		<td>Invoice Total:</td>
		<td align="right">
		<cfset GrandTotal=#GrandTotal# + #Shipping#>
		<input type="text" name="temptotal" value="#dollarformat(grandtotal)#" size="10" readonly>
		<input type="hidden" name="grandtotal" value="#grandtotal#">
		<input type="hidden" name="itemtotal" value="#grandtotal#">
		</td>
	</tr>
	<tr><td></td><td><input type="submit" name="submit" value="Delete"></td></tr>
</table>
</cffORM>
</cfif>


<cfif CartAction is "list">

<a href="adminheader.cfm?Action=#Action#&CartAction=Add">Add A New Cart</a><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="CartHdr">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCarts">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
		</cfinvoke>
		<table border="1" align="CENTER">
		<th colspan="6" align="CENTER" bgcolor="Maroon">Shopping Cart Headers</th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Customer</p></td>
		<td><p>Date Created</p></td>
		<td><p>Total Order</p></td>
		<td><p>Comments</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfloop query="AllCarts">
		<cfif #customerID# gt 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomer" returnvariable="TheCustomer">
				<cfinvokeargument name="CustomerID" value='#Customerid#'>
			</cfinvoke>
			<cfif #TheCustomer.recordcount# gt 0>
			<cfset CustomerName="#TheCustomer.Firstname# #TheCustomer.Lastname#">
			<cfelse>
				<cfset CustomerName="No Customer">
			</cfif>
		<cfelse>
			<cfset CustomerName="No Customer">
		</cfif>
		<cfinvoke component="#Application.WebSitePath#.Utilities.catalog" 
			method="GetCart" returnvariable="MyCart">
			<cfinvokeargument name="CartID" value="#cartid#">
		</cfinvoke>
		<cfset GrandTotal=0>
		<cfif #MyCart.RecordCount# gt 0>
			<cfloop query="MyCart">
				<Cfset ThisPrice=#Price# * 100>
				<cfset ThisPrice=#round(ThisPrice)# / 100>
				<cfset ThisPrice="#ThisPrice#">
				<cfset total=#ThisPrice#*(#QTYORDERED#)>
				<cfset GrandTotal=#total# + #GrandTotal#>
			</cfloop>
		</cfif>
		<tr>
		<td><p>#int(CartID)#</p></td>
		<td><p>#CustomerName#</p></td>
		<td><p>#createDate#</p></td>
		<td><p>#GrandTotal#</p></td>
		<td><p>#COMMENTS#</p></td>
		<td><a href= "adminheader.cfm?CartID=#CartID#&CartAction=Edit&&action=#action#">View</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CartID=#CartID#&CartAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfloop>
	</cfif>
</cfif>
</table>
</cfoutput>
