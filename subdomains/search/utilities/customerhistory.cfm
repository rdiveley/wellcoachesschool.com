<cfparam name="CustID" default=0>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="customerorders">
	<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfparam name="OrderAction" default="list">
<cfparam name="CreateDate" default="#dateformat(now(),'mm/dd/yyyy')#">
<cfparam name="DateShipped" default="">
<cfparam name="DateClosed" default="">
<cfparam name="CustomerID" default="0">
<cfparam name="companyName" default="">
<cfparam name="billfirstname" default=''>
<cfparam name="billlastname" default=''>
<cfparam name="GIFTWRAP" default=''>
<cfparam name="GIFTWRAPID" default='0'>
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
<cfset GIFTWRAP=''>
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
<cfparam name="Invoice" default=0>

<cfif OrderAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="customerorders">
		<cfinvokeargument name="XMLFields" value="invoice,BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,orderamount,shipname,shipcompany,shipemail,time,authorization,discount,status,handling,coupon,coupondiscount,giftcertificate,giftamountused,BankRountingNo,BankAcctNo,BankCheckNo,status,orderamount,shipname,shipcompany,shipemail,time,authorization,handling,discount">
		<cfinvokeargument name="XMLIDField" value="Invoice">
		<cfinvokeargument name="XMLIDValue" value="#Invoice#">
	</cfinvoke>
	<cfset Invoice=0>
	<cfset OrderAction="List">
</cfif>
		
<cfif OrderAction is "Edit">
	<cfinvoke component="#Application.WebSitePath#.utilities.catalog"
		method="GetInvoiceHeader" returnvariable="TheOrder">
		<cfinvokeargument name="invoiceNo" value="#INvoice#">
	</cfinvoke>
	
	<cfinvoke component="#Application.WebSitePath#.utilities.catalog"
		method="GetInvoiceDetail" returnvariable="TheOrderDetail">
		<cfinvokeargument name="invoiceNo" value="#INvoice#">
	</cfinvoke>
	<cfoutput query="TheOrder">
		<cfset CUSTOMERID=#CUSTOMERID#>
		<cfset CREATEDATE=#CREATEDATE#>
		<cfset DateShipped=#dateshipped#>
		<cfset ShippingAddressID=#shippingAddressID#>
		<cfset BillingAddressID=#BillingAddressID#>
		<cfset ShippingType=#ShippingType#>
		<cfset ShippingMethod=#ShippingMethod#>
		<cfset PurchaseOrder=#PurchaseOrder#>
		<cfset SalesTAx=#SalesTAx#>
		<cfset ShippingAmt=#ShippingAmt#>
		<cfset GIFTWRAP=#GIFTWRAP#>
		<cfset STORELOCATION=#STORELOCATION#>
		<cfset Comments=#Comments#>
		<cfset EXPIREDATE=#EXPIREDATE#>
		<cfset affiliateID=#affiliateID#>
		<cfset orderamount=#orderamount#>
		<cfset shipname=#shipname#>
		<cfset shipcompany=#shipcompany#>
		<cfset shipemail=#shipemail#>
		<cfset time=#time#>
		<cfset authorization=#authorization#>
		<cfset discount=#discount#>
		<cfset status=#status#>
		<cfset handling=#handling#>
		<cfset coupon=#coupon#>
		<cfset coupondiscount=#coupondiscount#>
		<cfset giftcertificate=#giftcertificate#>
		<cfset giftamountused=#giftamountused#>
		<cfset DAteShipped=#DAteShipped#>
		<cfset Paymentmethod=#Paymentmethod#>
		<cfset BankRountingNo=#BankRountingNo#>
		<cfset BankAcctNo=#BankAcctNo#>
		<cfset BankCheckNo=#BankCheckNo#>
	</cfoutput>
	<Cfif #trim(customerID)# gt 0>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 	
			method="getCustomer" returnvariable="TheCustomer">
			<cfinvokeargument name="customerid" value="#trim(customerID)#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerAddress" returnvariable="BillingAddress">
			<cfinvokeargument name="customerid" value="#trim(customerID)#">
			<cfinvokeargument name="AddresstypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerAddress" returnvariable="ShippingAddress">
			<cfinvokeargument name="customerid" value="#trim(customerID)#">
			<cfinvokeargument name="AddresstypeID" value="2">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerEmail" returnvariable="CustEmailAddress">
			<cfinvokeargument name="customerid" value="#trim(customerID)#">
			<cfinvokeargument name="EmailTypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomerPhone" returnvariable="CustPhoneNumber">
			<cfinvokeargument name="customerid" value="#trim(customerID)#">
			<cfinvokeargument name="PhonetypeID" value="1">
		</cfinvoke>
		<cfoutput query="CustEmailAddress">
			<cfif #CustEmailAddress.Emailaddress# neq ''>
				<cfset EmailID=#EmailID#>
				<cfset Email=#emailaddress#>
			</cfif>
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
			<cfset companyName=#companyName#>
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
	<cfset OrderAction="Update">
</cfif>

<cfif isDefined('form.submit')>doing this<br>
	<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,coupon,coupondiscount,giftcertificate,giftamountused,BankRountingNo,BankAcctNo,BankCheckNo,status,orderamount,shipname,shipcompany,shipemail,time,authorization,handling,discount">
		<CFSET FieldValues = "#form.billingaddressid#,#form.comments#,#form.createdate#,#form.customerid#, ,#form.expiredate#,#form.giftwrap#,#form.purchaseorder#,#form.salestax#,#form.shippingaddressid#,#form.shippingamt#,#form.shippingmethod#,#form.shippingtype#,#form.storelocation#,#form.affiliateID#,#form.Paymentmethod#,#form.coupon#,#form.coupondiscount#,#form.giftCertificate#,#form.giftamountused#,#form.BankRountingNo#,#form.BankAcctNo#,#form.BankCheckNo#,#form.status#,#form.orderamount#,#form.shipname#,#form.shipcompany#,#form.shipemail#,#timeformat(form.time)#,#form.authorization# ,#form.dateshipped#,#form.discount#">
	<cfif #OrderAction# is "Update">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerorders">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="Invoice">
			<cfinvokeargument name="XMLIDValue" value="#Invoice#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerorders">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="Invoice">
		</cfinvoke>
	</cfif>
	<cfset OrderAction="list">
</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Allcustomerorders">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="customerorders">
	<cfinvokeargument name="IDFieldName" value="CustomerID">
	<cfinvokeargument name="IDFieldValue" value="#trim(CustID)#">
</cfinvoke>

<cfoutput>
<h1>Customer Orders - #companyname#</h1>

<cfif OrderAction is "Update" or #OrderAction# is "Add">
<FORM ACTION="http://wwwapps.ups.com/tracking/tracking.cgi" METHOD=POST>
	<INPUT TYPE="submit" VALUE="Track UPS Shipment">
	<INPUT TYPE="Hidden" NAME="tracknum" VALUE="#status#">
</FORM>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="Invoice" value="#Invoice#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="OrderAction" value="#OrderAction#">
<input type="Hidden" name="ShippingAddressID" value="#ShippingAddressID#">
<input type="Hidden" name="BILLINGADDRESSID" value="#BILLINGADDRESSID#">
<input type="Hidden" name="COMMENTS" value="#COMMENTS#">
<input type="Hidden" name="CREATEDATE" value="#CREATEDATE#">
<input type="Hidden" name="CUSTOMERID" value="#CUSTOMERID#">
<input type="Hidden" name="EXPIREDATE" value="#EXPIREDATE#">
<input type="Hidden" name="GIFTWRAP" value="#GIFTWRAP#">
<input type="Hidden" name="PURCHASEORDER" value="#PURCHASEORDER#">
<input type="Hidden" name="SALESTAX" value="#SALESTAX#">
<input type="Hidden" name="SHIPPINGAMT" value="#SHIPPINGAMT#">
<input type="Hidden" name="SHIPPINGMETHOD" value="#SHIPPINGMETHOD#">
<input type="Hidden" name="SHIPPINGTYPE" value="#SHIPPINGTYPE#">
<input type="Hidden" name="STORELOCATION" value="#STORELOCATION#">
<input type="Hidden" name="affiliateID" value="#affiliateID#">
<input type="Hidden" name="orderamount" value="#orderamount#">
<input type="Hidden" name="shipname" value="#shipname#">
<input type="Hidden" name="shipcompany" value="#shipcompany#">
<input type="Hidden" name="shipemail" value="#shipemail#">
<input type="Hidden" name="time" value="#time#">
<input type="Hidden" name="authorization" value="#authorization#">
<input type="Hidden" name="discount" value="#discount#">
<input type="Hidden" name="paymentmethod" value="#paymentmethod#">
<input type="Hidden" name="handling" value="#handling#">
<input type="Hidden" name="coupon" value="#coupon#">
<input type="Hidden" name="coupondiscount" value="#coupondiscount#">
<input type="Hidden" name="giftcertificate" value="#giftcertificate#">
<input type="Hidden" name="giftamountused" value="#giftamountused#">
<input type="Hidden" name="BankRountingNo" value="#BankRountingNo#">
<input type="Hidden" name="BankAcctNo" value="#BankAcctNo#">
<input type="Hidden" name="BankCheckNo" value="#BankCheckNo#">
<TABLE>
	<tr>
		<td>
			<table>
				<TR>
					<TD valign="top"> <strong>Customer ID</strong>: #int(CUSTOMERID)#</TD>
    				<TD><strong>Invoice ##</strong> #int(Invoice)#</TD>
				</TR>
				<TR>
					<TD valign="top"> <strong>Company Name:</strong> </TD>
    				<TD>#Companyname#</TD>
				</TR>
				<TR>
					<TD valign="top"> <strong>Customer Name:</strong> </TD>
    				<TD>#billfirstName# #billlastname#</TD>
				</TR>
				<TR>
					<TD valign="top"> <strong>Email:</strong> </TD>
				    <TD>#Email#</TD>
					<!--- field validation --->
				</TR>
				<TR>
					<TD valign="top"> <strong>Phone:</strong> </TD>
				    <TD>#phonenumber#</TD>
					<!--- field validation --->
				</TR>
			</table>
		</td>
		<td>
			<table>
				<tr>
				<TR>
					<TD valign="top"> <strong>Date Ordered:</strong> </TD>
				    <TD>#DateFormat(createdate,'mm/dd/yyyy')#</TD>
				</TR>
				
				<TR>
					<TD valign="top"> <strong>Date Shipped:</strong> </TD>
				    <TD>
					
						<INPUT type="text" name="DateShipped" value="#DateFormat(DateShipped,'mm/dd/yyyy')#" maxLength="16">
						(i.e. 12/31/1997)
					</TD>
				</TR>
				<TR>
					<TD valign="top"> <strong>Tracking Number:</strong> </TD>
				    <TD><input type="text" name="status" value="#status#" size=35>
					</TD>
					<!--- field validation --->
				</TR>
				<TR>
					<TD valign="top"> <strong>Payment Method:</strong> </TD>
				    <TD>#paymentmethod#</TD>
					<!--- field validation --->
				</TR>
			</table>

		</td>
	</tr>
</table>
<TABLE>
	<tr>

		<td valign=top>
			<table>
	
	<TR>
	<TD valign="top"> Billing Address: </TD>
    <TD>
	
		#address1#
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Billing Address1: </TD>
    <TD>
	
		#address2#
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Billing City: </TD>
    <TD>
	
		#city#
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Billing State: </TD>
    <TD>
	
		#State#
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Billing Country: </TD>
    <TD>
	
		#Country#
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Billing Zip: </TD>
    <TD>
	
		#PostalCode#
		
	</TD>
	<!--- field validation --->
	</TR>
	</table>
</td>


		<td>
			<table>
	<TR>
	<TD valign="top"> <strong>Credit Card Information:</strong> </TD>
    <TD>
		<table><tr><td>Number:</td> <td>#ccno#</td></tr>
		<tr><td>Type:</td>   <td>#cctype#</td></tr>
		<tr><td>Expiration:</td> <td>#ccexpire#</td></tr></table>
		
	</TD>
	</TR>
	
	
	<TR>
	<TD valign="top"> <strong>On-line Check Information:</strong> </TD>
    <TD>
	
		<table><tr><td>Rounting ##:</td> <td>#BankRountingNo#</td></tr>
		<tr><td>Account ##:</td>   <td>#BankAcctNo#</td></tr>
		<tr><td>Check ##:</td> <td>#BankCheckNo#</td></tr></table>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> <strong>Gift Certificate Used:</strong> </TD>
    <TD>
		
		<table><tr><td>Certificate ##:</td> <td>#giftcertificate#</td></tr>
		<tr><td>Amount:</td>   <td>#giftamountused#</td></tr></table>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> <strong>Discount Coupon Used:</strong> </TD>
    <TD>
	
		<table><tr><td>Coupon ##:</td> <td>#coupon#</td></tr>
		<tr><td>Amount:</td>   <td>#coupondiscount#</td></tr></table>
		
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	
	<tr><td></td><td><INPUT type="submit" name="submit" value="Update"></td></tr>
	</table>
</td>
</tr>
</TABLE>
	
<!--- form buttons --->


</FORM>
<cfparam name="quantity" default=1>
<cfparam name="ProductID" default=''>
<cfparam name="CategoryID" default=''>
<cfparam name="action" default="addtocart">
<cfparam name="invnbr" default=0>
<cfparam name="ChangeItem" default="add">
<cfparam name="ReturnPage" default=0>
<cfparam name="Detailnbr" default=0>
<cfparam name="CartDetailID" default=0>
<cfset ReturnProductID=#ProductID#>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="ProductConfig">
	<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
	<cfinvokeargument name="ThisFileName" value="ProductConfig">
</cfinvoke>
<cfloop query="ProductConfig">
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
</cfloop>

<cfif #ChangeItem# is "Delete">
	<cfquery name="DeleteItem" datasource="#DSN#" password="#DSNpWord#" username="#DSNuName#">
		delete from cartdtl
		where CartDetailID=#CartDetailID#
	</cfquery>
	<cfset ChangeItem=''>
	<cfset Detailnbr=0>
</cfif>

<cfif #ChangeItem# is "Change">
	<cfinvoke component="#Application.WebSitePath#.Utilities.catalog" method="updateThisquantity">
		<cfinvokeargument name="NewQuantity" value="#form.Quantity#">
		<cfinvokeargument name="CartID" value="#session.CartID#">
		<cfinvokeargument name="ThisProductID" value="#form.ThisProductID#">
		<cfinvokeargument name="ThisPrice" value="#form.Price#">
		<cfinvokeargument name="ProductName" value="#form.ProductName#">
		<cfinvokeargument name="Cost" value="#form.Cost#">
		<cfinvokeargument name="CartDetailID" value="#form.CartDetailID#">
	</cfinvoke>
	<cfset ChangeItem=''>
	<cfset Detailnbr=0>
</cfif>

<cfset thisdate = dateformat(now(),"mm/dd/yyyy")>

<cfinvoke component="#Application.WebSitePath#.Utilities.catalog" 
	method="GetInvoiceDetail" returnvariable="InvoiceDetails">
	<cfinvokeargument name="invoiceNo" value="#trim(invoice)#">
</cfinvoke>
<CFSET Quantity = #InvoiceDetails.QtyOrdered#>

<center><p align=center><h1>Order Details</h1></p>
<table width="100%" cellpadding=0 cellspacing="0" style="padding: 10px 10px 10px 10px; background-color: ##F5F5DC;">
 <tr>

  <td valign="top" width="10%" colspan=2>
	
		<table width="100%" class=tableheader cellpadding=0 cellspacing=0 border=0>
			<tr>
				<th class=tableheader>Item</th>
				<th class=tableheader>Unit Price</th>
				<th class=tableheader>Total Price</th>
				<th class=tableheader>Quantity</th>
				<th class=tableheader>&nbsp;</th>
			</tr>

			<cfset GrandTotal = 0>
			<cfset GetSpecials = 0>
			<cfloop query="InvoiceDetails">
				<cfif isNumeric(#Qtyordered#)>
				<Cfset ThisPrice=#Price# * 100>
				<cfset ThisPrice=#round(ThisPrice)# / 100>
				<cfset ThisPrice="#ThisPrice#">
				<cfset total=#ThisPrice#*(#QTYORDERED#)>
			<cfelse>
				<cfset Total=0>
			</cfif>
			<cfset GrandTotal=#total# + #GrandTotal#>
			
			<form action="index.cfm" method="POST" name="changeit#CartDetailID#">
			  <input type="hidden" name="Invoice" value="#invoice#">
			  <input type="hidden" name="DetailID" value="#DetailID#">
			  <input type="hidden" name="ThisProductID" value="#ProductID#">
			  <input type="hidden" name="price" value="#price#">
			  <input type="hidden" name="ProductName" value="#ProductName#">
			  <input type="hidden" name="Cost" value="#Cost#">
			<tr class=tableheader>
				<td>
				#trim(ProductName)#
				</td>
				<td   nowrap style="text-align: right;">
				#dollarformat(price)#
				</td>
				<td  nowrap style="text-align: right;">
				#dollarformat(total)#
				</td>
				<td  nowrap align=center>
				<cfif isNumeric(Qtyordered)>
				#int(QTYORDERED)#
				<cfelse>
				0
				</cfif>
				
						<input type="hidden" name="Quantity" value="#QTYORDERED#">
				</td>
				
				<td  nowrap>
					  <Cfif #shippedamount# neq #qtyordered#>
					  <input type="submit" name="ChangeItem" value="Ship" style="font-size: 8pt;">
					  <input type="submit" name="ChangeItem" value="Back Order" style="font-size: 8pt;">
					  </Cfif>
				 </td>
			</tr>
			</form>
			</cfloop>
			
			<tr class=tableheader>
				<th colspan="3" align="right">
					<b>Total:</b>
				</th>
				<th>
				<b>#dollarformat(GrandTotal)#</b>
				</th>
				<th colspan="2">&nbsp;</th>
		
	</tr>
</table>
<p>&nbsp;</p>
</center>


</cfif>
</CFOUTPUT>
	

<cfif #TheFileExists# is "true" and #OrderAction# is "List">

<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your customerorders</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Customer</p></td>
<td><p>Total</p></td>
<td><p>Date Created</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="Allcustomerorders">
<cfif #trim(customerID)# gt 0>
	<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
		method="getCustomer" returnvariable="TheCustomer">
			<cfinvokeargument name="CustomerID" value='#trim(Customerid)#'>
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
		method="GetInvoiceDetail" returnvariable="InvoiceDetail">
		<cfinvokeargument name="InvoiceNo" value="#trim(allCustomerOrders.Invoice)#">
	</cfinvoke>
	<cfset GrandTotal=0>
	<cfif #InvoiceDetail.RecordCount# gt 0>
		<cfloop query="InvoiceDetail">
			<cfif isnumeric(#QtyORdered#)>
			<Cfset ThisPrice=#Price# * 100>
			<cfset ThisPrice=#round(ThisPrice)# / 100>
			<cfset ThisPrice="#ThisPrice#">
			<cfset total=#ThisPrice#*(#QTYORDERED#)>
			<cfset GrandTotal=#total# + #GrandTotal#>
			<cfelse>
			<cfset total=0>
			
			</cfif>
		</cfloop>
	</cfif>
<tr>
<td><p>#int(allcustomerorders.Invoice)#</p></td>
<td><p>#CustomerName#</p></td>
<td><p>#dollarformat(GrandTotal)#</p></td>
<td><p>#createdate#</p></td>

<td><a href= "adminheader.cfm?Invoice=#trim(allcustomerorders.Invoice)#&OrderAction=Edit&action=#action#&CustID=#CustID#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?Invoice=#trim(allcustomerorders.Invoice)#&OrderAction=Delete&action=#action#&CustID=#CustID#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

