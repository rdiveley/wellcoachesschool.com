<cfcomponent>
	<cffunction name="getConfig" access="remote" returntype="string" output="true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
			method="GetXMLRecords" returnvariable="ProductConfig">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="ProductConfig">
			<cfinvokeargument name="IDFieldName" value="ProductConfigID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfoutput query="ProductConfig">
			<cfset ThankYouPage=#ThankYouPage#>
		</cfoutput>
		<cfset ThankYouPageGo="#application.returnpath#/index.cfm?page=#ThankYouPage#">
		<cfreturn ThankYouPageGo>
	</cffunction>
	
	<cffunction name="GetCategoryName" access="remote" returntype="string" output="true">
		<cfargument name="CategoryID" default="" required="true" type="numeric">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetSpecials">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ProductCategories">
			<cfinvokeargument name="SelectStatement" value=" where categoryid='#arguments.categoryid#'">
		</cfinvoke>
		<cfreturn GetSpecials.categoryname>
	</cffunction>

	<cffunction name="GetProductNamebyCatalogno" access="remote" returntype="string" output="true">
		<cfargument name="Catalogno" default="" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetFieldValue" returnvariable="ProductName">
			<cfinvokeargument name="TableName" value="ProductCategories">
			<cfinvokeargument name="FieldName" value="CAtegoryname">
			<cfinvokeargument name="IDFieldName" value="Catalogno">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.Catalogno#">
		</cfinvoke>

		<cfreturn ProductName>

	</cffunction>

	<cffunction name="GetVendorName" access="remote" returntype="string" output="true">
		<cfargument name="VendorID" default="" required="true" type="numeric">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="Vendors">
			<cfinvokeargument name="FieldName" value="VendorName">
			<cfinvokeargument name="IDFieldName" value="VendorID">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.VendorID#">
		</cfinvoke>
		<cfreturn Fieldname>
	</cffunction>


  	<cffunction access="remote" name="GetSpecials" output="true" returntype="query">
		<cfset Today=dateformat(now(),"yyyy/mm/dd")>
		<cfset Tomorrow=dateadd("d",1,now())>
		<Cfset Tomorrow=dateformat(tomorrow,"yyyy/mm/dd")>
		<cfset WhereStatement=" where salestarts <= '#today#' and saleends >= '#tomorrow#'">
		<cfset OrderByStatement=" order by catalogno">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetSpecials">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="products">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#"/>
		  	<cfinvokeargument name="OrderByStatement" value="#OrderByStatement#">
		</cfinvoke>
	
		<cfreturn GetSpecials>
  	</cffunction>
  
  	<cffunction access="remote" name="GetProductDetails" output="true" returntype="query">
		<cfargument name="productID" type="string" required="true" default="0">

		<cfset OrderByStatement=" order by vendorid,status">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetProduct">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="products">
			<cfinvokeargument name="IDFieldName" value="ProductID">
			<cfinvokeargument name="IDFieldValue" value="#productID#">
		</cfinvoke>
		<cfreturn GetProduct>
  	</cffunction>
  
  	<cffunction access="remote" name="GetUnitDescription" output="true" returntype="string">
  		<cfargument name="UnitID" type="numeric" required="true" default="0">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="units">
			<cfinvokeargument name="FieldName" value="description">
			<cfinvokeargument name="IDFieldName" value="id">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.UnitID#">
		</cfinvoke>
		<cfreturn Fieldname>
  	</cffunction>

  	<cffunction access="remote" name="GetProductSpecification" output="true" returntype="string">
  		<cfargument name="ProductID" type="numeric" required="true" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="products">
			<cfinvokeargument name="FieldName" value="specifications">
			<cfinvokeargument name="IDFieldName" value="productid">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.ProductID#">
		</cfinvoke>
		<cfreturn #Fieldname#>
  	</cffunction>
  
  	<cffunction access="remote" name="GetImage" output="true" returntype="string">
  		<cfargument name="ProductID" type="string" required="true" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="products">
			<cfinvokeargument name="FieldName" value="imagename">
			<cfinvokeargument name="IDFieldName" value="productID">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.theimage#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.AdminUtilities" method="InitWebSite" 
			returnvariable="InitWebSiteRet" />
		<cfset UploadPath=#InitWebSiteRet[1][5]#>
		<cfset ReturnPath=#InitWebSiteRet[1][4]#>
		
		<cfset ImageID=''>
		<cfset ImageIs=''>
		<cfset CatalogPath="catalog">
		<cfif #Fieldname# neq ''>
			<cfset qImage=#Fieldname#>
			<cfoutput>#uploadpath#\#CatalogPath#\images\#trim(qImage)#</cfoutput>
			<cfif FileExists("#uploadpath#\#CatalogPath#\images\#trim(qImage)#")>
				<cfset ImageIs="#CatalogPath#/images/#trim(qImage)#">
			<cfelse>
				<cfset qImage = "#trim(qImage)#.jpg">
				<cfif FileExists("#uploadpath#\#CatalogPath#\images\#trim(qImage)#")>
					<cfset ImageIs="#CatalogPath#/images/#trim(qImage)#">
				</cfif>
			</cfif>
		</cfif>
  		<cfreturn ImageIs>
  	</cffunction>
  
  	<cffunction access="remote" name="DeleteFromCart" output="true" returntype="string">
		<cfargument name="CartDetailID" type="numeric" required="true" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="DeleteXMLrecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="XMLFields" value="CartDetailID,CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
			<cfinvokeargument name="XMLIDField" value="CartDetailID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.CartDetailID#">
		</cfinvoke>
		
		<cfreturn "true">
  	</cffunction>
	
	<cffunction access="remote" name="DeleteCart" output="true" returntype="string">
		<cfargument name="CartID" type="numeric" required="true" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="DeleteXMLrecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="XMLFields" value="CartID,BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateid,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.CartID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="DeleteXMLrecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="XMLFields" value="CartDetailID,CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
			<cfinvokeargument name="XMLIDField" value="CartHdrID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.CartID#">
		</cfinvoke>
		<cfset StructDelete(Session, "CartID")>
		<Cfreturn "true">
  	</cffunction>
	
	  <cffunction access="remote" name="UpdateThisQuantity" output="false">
		<cfargument name="NewQuantity" default=0 type="numeric" required="true">
		<cfargument name="CartID" default=0 type="numeric" required="true">
		<cfargument name="ThisProductID" default="" type="string" required="true">
		<cfargument name="ThisPrice" default=0 type="numeric" required="true">
		<cfargument name="ProductName" default="" type="string" required="true">
		<cfargument name="Cost" default=0 type="string" required="true">
		<cfargument name="CartDetailID" default=0 type="string" required="true">
		<cfargument name="HardwareID" default=0 type="string" required="true">
		<cfargument name="SizeID" default=0 type="string" required="true">
		<cfargument name="MaterialID" default=0 type="string" required="true">
		<cfargument name="ColorID" default=0 type="string" required="true">
		<cfargument name="StyleID" default=0 type="string" required="true">
		<cfargument name="UnitOfMeasure" default=0 type="string" required="true">
		
		<cfif #arguments.ColorID# is ""><cfset ColorID=0><cfelse><cfset ColorID=#arguments.ColorID#></cfif>
		<cfif #arguments.MaterialID# is ""><cfset MaterialID=0><cfelse><cfset MaterialID=#arguments.MaterialID#></cfif>
		<cfif #arguments.HardwareID# is ""><cfset HardwareID=0><cfelse><cfset HardwareID=#arguments.HardwareID#></cfif>
		<cfif #arguments.SizeID# is ""><cfset SizeID=0><cfelse><cfset SizeID=#arguments.SizeID#></cfif>
		<cfif #arguments.StyleID# is ""><cfset StyleID=0><cfelse><cfset StyleID=#arguments.StyleID#></cfif>
		<cfif #arguments.UnitOfMeasure# is ""><cfset UnitOfMeasure=0><cfelse><cfset UnitOfMeasure=#arguments.UnitOfMeasure#></cfif>
		<cfif #arguments.Cost# is ""><cfset Cost=0><cfelse><cfset Cost=#arguments.Cost#></cfif>
		<cfif #CartDetailID# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLrecord" returnvariable="CartDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="XMLFields" 
					value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
				<cfinvokeargument name="XMLFieldData" 
				value="#arguments.cartID#,#arguments.ThisPrice#,#arguments.thisProductID#,#replace(arguments.Productname,',','~','ALL')#,#arguments.NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
				<cfinvokeargument name="XMLIDField" value="CartDetailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.CartDetailID#">
			</cfinvoke>
		</cfif>
		<cfreturn "true">
	</cffunction>
	
  	<cffunction access="remote" name="UpdateQuantity" output="true" returntype="string">
		<cfargument name="NewQuantity" default=0 type="numeric" required="true">
		<cfargument name="CartID" default=0 type="string" required="true">
		<cfargument name="ThisProductID" default="" type="string" required="true">
		<cfargument name="ThisPrice" default=0 type="numeric" required="true">
		<cfargument name="CartDetailID" default=0 type="string" required="false">
		<cfargument name="HardwareID" default=0 type="string" required="false">
		<cfargument name="SizeID" default=0 type="string" required="false">
		<cfargument name="MaterialID" default=0 type="string" required="false">
		<cfargument name="ColorID" default=0 type="string" required="false">
		<cfargument name="StyleID" default=0 type="string" required="false">
		<cfargument name="UnitOfMeasure" default=0 type="string" required="false">
		
		<cfset ThisPrice=#Arguments.ThisPrice#>
		<cfset CartID=#Arguments.CartID#>
		<cfset NewQuantity=#Arguments.NewQuantity#>
		<cfset ThisProductID=#Arguments.ThisProductID#>
		<cfset HardwareID=#Arguments.HardwareID#>
		<cfset SizeID=#Arguments.SizeID#>
		<cfset MaterialID=#Arguments.MaterialID#>
		<cfset ColorID=#Arguments.ColorID#>
		<cfset StyleID=#Arguments.StyleID#>
		<cfset UnitOfMeasure=#Arguments.UnitOfMeasure#>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="cartdtl">
			<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ThisProduct">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="products">
			<cfinvokeargument name="IDFieldName" value="ProductID">
			<cfinvokeargument name="IDFieldValue" value="#ThisProductID#">
		</cfinvoke>
			
		<cfoutput query="ThisProduct">
			<cfset ProductName=#replace(productName,',','~','ALL')#>
			<cfset Cost=#cost#>
		</cfoutput>

		<cfif #int(CartDetailID)# neq 0>
			<cfif #cost# is ''><cfset cost=0></cfif>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLrecord" returnvariable="CartDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="XMLFields" 
					value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,CategoryID,StyleID,UnitOfMeasure">
				<cfinvokeargument name="XMLFieldData" 
				value="#cartID#,#ThisPrice#,#thisProductID#,#XMLFormat(Productname)#,#NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
				<cfinvokeargument name="XMLIDField" value="CartDetailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.CartDetailID#">
			</cfinvoke>
		</cfif>
		
		<cfif #TheFileExists# is "false">
			<cfif #cost# is ''><cfset cost=0></cfif>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLrecord" returnvariable="CartDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="XMLFields" 
					value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
				<cfinvokeargument name="XMLFieldData" 
				value="#cartID#,#ThisPrice#,#thisProductID#,#Productname#,#NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
				<cfinvokeargument name="XMLIDField" value="CartDetailID">
			</cfinvoke>
		<cfelse>
		
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="TheCartDetail">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="IDFieldName" value="CartHdrID">
				<cfinvokeargument name="IDFieldValue" value="#Arguments.CartID#">
			</cfinvoke>
			
			<cfif #TheCartDetail.RecordCount# gt 0>
				<cfquery name="GetDetailID" dbtype="query">
					select * from TheCartDetail
					where productid='#ThisProductID#'
					and CartHdrid='#CartID#'
				</cfquery>
				<cfif #GetDetailID.RecordCount# gt 0>
					<Cfoutput query="GetDetailID">
						<cfset CartDetailID=#CartDetailID#>
						<cfset ThisPrice=#PRICE#>
						<cfset Cost=#cost#>
					</Cfoutput>
					<cfif #cost# is ''><cfset cost=0></cfif>
					<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
						method="updateXMLrecord">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="cartdtl">
						<cfinvokeargument name="XMLFields" 
							value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
						<cfinvokeargument name="XMLFieldData" 
						value="#CartID#,#ThisPrice#,#thisPRODUCTID#,#XMLFormat(Productname)#,#NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
						<cfinvokeargument name="XMLIDField" value="CartDetailID">
						<cfinvokeargument name="XMLIDValue" value="#GetDetailID.CartDetailID#">
					</cfinvoke>
				<cfelse>
					<cfif #cost# is ''><cfset cost=0></cfif>
					<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
						method="InsertXMLrecord">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="cartdtl">
						<cfinvokeargument name="XMLFields" 
							value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
						<cfinvokeargument name="XMLFieldData" 
							value="#cartID#,#ThisPrice#,#thisProductID#,#XMLFormat(Productname)#,#NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
						<cfinvokeargument name="XMLIDField" value="CartDetailID">
					</cfinvoke>
				</cfif>
			<cfelse>
				<cfif #cost# is ""><cfset Cost=0></cfif>
				<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
					method="InsertXMLrecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="cartdtl">
					<cfinvokeargument name="XMLFields" 
						value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
					<cfinvokeargument name="XMLFieldData" 
						value="#cartID#,#ThisPrice#,#thisProductID#,#XMLFormat(Productname)#,#NewQuantity#,#COST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#StyleID#,#UnitOfMeasure#">
					<cfinvokeargument name="XMLIDField" value="CartDetailID">
				</cfinvoke>
			</cfif>
		</cfif>
		<cfreturn "true">
  	</cffunction>
  
  	<cffunction access="remote" name="AddNewCart" output="true" returntype="string">
  		<cfset ExpirationDate = dateformat(dateadd("d",+3,now()),"mm/dd/yyyy")>
		<cfset Today = dateformat(now(),"mm/dd/yyyy")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="XMLFields" value="BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">
			<cfinvokeargument name="XMLFieldData" value="0,0,#Today#,0,#Today#,#ExpirationDate#,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0">
			<cfinvokeargument name="XMLIDField" value="CartID">
		</cfinvoke>
		<cfreturn NewID>	
 	</cffunction>

 	<cffunction access="remote" name="AddToCart" output="true" returntype="string">
		<cfargument name="ProdIDs" default="0" type="string" required="true">
		<cfargument name="PriceList" default="0" type="string" required="true">
		<cfargument name="quantitylist" default="0" type="string" required="true">	
		<cfargument name="CartID" default="0" type="string" required="true">
		<cfargument name="HardwareIDs" default="0" type="string" required="false">
		<cfargument name="SizeIDs" default="0" type="string" required="false">
		<cfargument name="MaterialIDs" default="0" type="string" required="false">
		<cfargument name="ColorIDs" default="0" type="string" required="false">
		<cfargument name="StyleIDs" default="0" type="string" required="false">
		<cfargument name="UnitOfMeasure" default="0" type="string" required="false">

		<cfset isCart = 1>
		<cfset OldCartID=#Arguments.cartID#>
		<cfset ProdIDs=#arguments.ProdIDs#>
		<cfset QuantityList=#Arguments.quantitylist#>
		<cfset PriceList=#Arguments.PriceList#>
		<cfset ListCount = 0>
		<cfset HardwareIDs=#Arguments.HardwareIDs#>
		<cfset SizeIDs=#Arguments.SizeIDs#>
		<cfset MaterialIDs=#Arguments.MaterialIDs#>
		<cfset ColorIDs=#Arguments.ColorIDs#>
		<cfset StyleIDs=#Arguments.StyleIDs#>
		<cfset UnitsOfMeasure=#Arguments.UnitOfMeasure#>
		
		<cfif #int(OldCartID)# is 0>
			<cfinvoke method="AddNewCart" returnvariable="CartID"></cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="CheckCart">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="carthdr">
				<cfinvokeargument name="SelectStatement" value=" where CartID='#trim(Arguments.cartid)#'"/>
			</cfinvoke>
			<cfif #CheckCart.RecordCount# is 0>
				<cfinvoke method="AddNewCart" returnvariable="CartID"></cfinvoke>
			<cfelse>
				<cfset CartID=#OldCartID#>
			</cfif>
		</cfif>
		<cfloop index="ProductCount" list="#ProdIDs#">
			<cfset ListCount = #ListCount# + 1>
			<cfset ThisProductID = listgetat(#ProdIDs#,#ListCount#)>
			<cfset ThisQuantity = ListGetAt(#QuantityList#,#Listcount#)>
			<cfset ThisPrice = ListGetAt(#PriceList#,#ListCount#)>
			<cfset HardwareID = listgetat(#HardwareIDs#,#ListCount#)>
			<cfset SizeID = ListGetAt(#SizeIDs#,#Listcount#)>
			<cfset MaterialID = ListGetAt(#MaterialIDs#,#ListCount#)>
			<cfset ColorID = listgetat(#ColorIDs#,#ListCount#)>
			<cfset StyleID = ListGetAt(#StyleIDs#,#Listcount#)>
			<cfset UnitOfMeasure = ListGetAt(#UnitsOfMeasure#,#ListCount#)>
			<cfif ThisQuantity gt 0>
				<cfinvoke method="updatequantity">
					<cfinvokeargument name="NewQuantity" value="#ThisQuantity#">
					<cfinvokeargument name="CartID" value="#CartID#">
					<cfinvokeargument name="ThisProductID" value="#ThisProductID#">
					<cfinvokeargument name="ThisPrice" value="#ThisPrice#">
					<cfinvokeargument name="HardwareID" value="#HardwareID#">
					<cfinvokeargument name="SizeID" value="#SizeID#">
					<cfinvokeargument name="MaterialID" value="#MaterialID#">
					<cfinvokeargument name="ColorID" value="#ColorID#">
					<cfinvokeargument name="StyleID" value="#StyleID#">
					<cfinvokeargument name="UnitOfMeasure" value="#UnitOfMeasure#">
				</cfinvoke>
			</cfif>
		</cfloop>
		<cfset session.cartid=cartid>
		<cfreturn CartID>
  </cffunction>
  
  <cffunction access="remote" name="GetVendors" output="true" returntype="query">
		<cfargument name="VendorID" default=0 type="numeric" required="false">
		
		<Cfif #Arguments.VendorID# neq 0>
			  <cfset WhereStatement="Where VendorID=#arguments.VendorID#">
		<cfelse>
			<cfset WhereStatement="">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetVendorList" output="true" returntype="query">
		<cfargument name="VendorID" default=0 type="numeric" required="false">
		
		<Cfif #Arguments.VendorID# neq 0>
			  <cfset WhereStatement="Where VendorID=#arguments.VendorID# order by VendorName">
		<cfelse>
			<cfset WhereStatement=" order by VendorName">
		</cfif>
			
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
		  <cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetCategories" output="true" returntype="query">
		<cfargument name="CategoryID" default=0 type="numeric" required="false">
		
		<Cfif #Arguments.CategoryID# neq 0>
			  <cfset WhereStatement=" Where CategoryID=#arguments.CategoryID# order by CategoryName">
		<cfelse>
			<cfset WhereStatement=" order by CategoryName">
		</cfif>
			
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetProductsbyCatalogno" output="true" returntype="query">
		<cfargument name="catalogno" default=0 type="string" required="false">	
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
		  	<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Products">
		  <Cfif #Arguments.catalogno# neq 0>
			<cfset Catalogno=#Arguments.catalogno#>
			  <cfinvokeargument name="SelectStatement" value=" where status like '%#Trim(catalogno)#%' or catalogno='#Trim(catalogno)#'"/>
		  </cfif>
		  <cfinvokeargument name="OrderByStatement" value=" order by ProductName">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetCatalogConfiguration" output="true" returntype="array">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
			method="GetXMLRecords" returnvariable="ProductConfig">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="ProductConfig">
			<cfinvokeargument name="IDFieldName" value="ProductConfigID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfreturn ProductConfig>
  </cffunction>
  
  <cffunction access="remote" name="DumpCart" output="false">
		<cfargument name="Today" default="0" type="date" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetRecords" returnvariable="tDumpCart">
			<cfinvokeargument name="SelectStatement" value="Select * ">
			<cfinvokeargument name="FromStatement" value="from carthdr ">
			<cfinvokeargument name="SelectStatement" value="WHERE ExpireDate < #arguments.Today#">
		</cfinvoke>
	
		<CFLOOP query="tDumpCart">
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="DeleteARecord">
				<cfinvokeargument name="TableName" value="cartdtl">
				<cfinvokeargument name="IDField" value="CartHdrID">
				<cfinvokeargument name="IDFieldValue" value="#tDumpCart.cartid#">
			</cfinvoke>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="DeleteARecord">
				<cfinvokeargument name="TableName" value="CartHdr">
				<cfinvokeargument name="IDField" value="CartID">
				<cfinvokeargument name="IDFieldValue" value="#tDumpCart.cartid#">
			</cfinvoke>
		</cfloop>
  </cffunction>
  
  	<cffunction access="remote" name="GetCatalogItems" output="true" returntype="query">
		<cfargument name="CategoryID" default="0" required="true" type="string">

		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler"   
			method="GetXMLRecords"  returnvariable="GetAllProducts">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="OrderbyStatement" value="Order by ProductName">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler"   
			method="GetXMLRecords"  returnvariable="GetAllCategories">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="ProductCategories">
			<cfinvokeargument name="OrderbyStatement" value="Order by CategoryName">
		</cfinvoke>
		<cfquery name="SelectSubCategories" dbtype="query">
			select * from GetAllCategories
			where parentcatid='#arguments.categoryid#'
		</cfquery>
		<cfset SelectStatement=''>
		<cfif #selectSubCategories.recordcount# gt 0>
			<cfoutput query="SelectSubCategories">
				<cfset SelectStatement="#SelectStatement#  or categoryid='#SelectSubCategories.CategoryID#'">
			</cfoutput>
		</cfif>
		<cfquery name="GetCatalogue" dbtype="query">
			select * from GetAllProducts
			where categoryid='#arguments.categoryID#' 
			<cfif #Selectstatement# neq ''>
			#preservesinglequotes(selectstatement)#
			order by categoryid, productname
			<cfelse>
			order by productname
			</cfif>
			
		</cfquery>
		
		<cfreturn GetCatalogue>
  	</cffunction>

	<cffunction name="GetEquivalents" access="remote" output="true" returntype="query">
		<cfargument name="VendorID" type="numeric" required="true">
		<cfset SelectStatement="select p.CategoryID,p.status,p.productname,u.Description as symbol,">
		<cfset SelectStatement="#SelectStatement# p.Description,p.Price,p.Saleprice,p.SaleStarts,">
		<cfset SelectStatement="#SelectStatement# p.SaleEnds,p.OnSale,p.vendorid,p.CatalogNo,">
		<cfset SelectStatement="#SelectStatement# p.EquivalentProduct,p.ProductID,c.categoryname,">
		<cfset SelectStatement="#SelectStatement# m.vendorName,p.unitid,cc.equivalent,">
		<cfset SelectStatement="#SelectStatement# cc.vendorid as newvendorid">
		<cfset FromStatement=" from vendors m, products p, productcategories c, units u, crosscheck cc">
		<cfset WhereStatement="where c.Categoryid = (p.Categoryid )	and m.vendorid = (p.vendorid )">
		<cfset WhereStatement="#WhereStatement# and u.ID = (p.unitid ) and cc.productid=p.productid">
		<cfset WhereStatement="#WhereStatement# and cc.vendorid=#arguments.VendorID#">
		<cfset OrderByStatement="Order By p.CatalogNo">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetRecords" returnvariable="GetCatalog">
			<cfinvokeargument name="SelectStatement" value="#SelectStatement#">
			<cfinvokeargument name="FromStatement" value="#FromStatement#">
			<cfinvokeargument name="WhereStatement" value="#WhereStatement#">
			<cfinvokeargument name="OrderByStatement" value="#OrderByStatement#">
		</cfinvoke>
		
		<cfreturn GetCatalog>
	</cffunction>
	
	<cffunction name="GetOneEquivalent" access="remote" output="true" returntype="query">
		<cfargument name="catalogno" type="string" default='' required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetRecords" returnvariable="GetEquivalent">
			<cfinvokeargument name="SelectStatement" value="Select * ">
			<cfinvokeargument name="FromStatement" value="from Products ">
			<cfinvokeargument name="WhereStatement" value="where catalogno='#arguments.catalogno#'">
		</cfinvoke>
		<cfreturn GetEquivalent>
	</cffunction>
	
	<cffunction name="GetCart" access="remote" output="true" returntype="query">
		<cfargument name="CartID" default="0" type="numeric" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetXMLRecords" returnvariable="ShoppingCart">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="cartdtl">
			<cfinvokeargument name="IDFieldName" value="carthdrid">
			<cfinvokeargument name="IDFieldValue" value="#arguments.cartid#">
		</cfinvoke>
		<cfreturn ShoppingCart>
	</cffunction>
	
	<cffunction name="GetCartHeader" output="true" returntype="query" access="remote">
		<cfargument name="CartID" required="true" type="string" default="0">
 
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ShoppingCart">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="SelectStatement" value=" where CartID='#trim(arguments.CartID)#'">
		</cfinvoke>
		<cfreturn ShoppingCart>
	</cffunction>
	
	<cffunction name="GetCartDetail" output="true" returntype="query" access="remote">
		<cfargument name="CartID" required="true" type="string" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="tCartDetail">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="SelectStatement" value=" where CARTHDRID='#trim(arguments.CartID)#'">
		</cfinvoke>
		
		<cfset CartDetail=querynew("CartDetailID,CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure,ColorName,HardwareName,MaterialName,SizeName")>
		<cfloop query="tCartDetail">
			<cfoutput>hdr ID=#CartDetailID#<br></cfoutput>
			<cfinvoke method="getColors" returnvariable="theColor">
				<cfinvokeargument name="ColorIDs" value="#tCartDetail.ColorID#">
			</cfinvoke>
			<cfinvoke method="getMaterials" returnvariable="theMaterial">
				<cfinvokeargument name="MATERIALIDS" value="#tCartDetail.MaterialID#">
			</cfinvoke>
			<cfinvoke method="getHardware" returnvariable="theHardware">
				<cfinvokeargument name="HardwareIDs" value="#tCartDetail.hardwareID#">
			</cfinvoke>
			<cfinvoke method="getSizes" returnvariable="theSize">
				<cfinvokeargument name="SizeIDs" value="#tCartDetail.SizeID#">
			</cfinvoke>
			<CFSET newRow=QueryAddRow(CartDetail, 1)>
			<CFSET temp=QuerySetCell(CartDetail,"CartDetailID",#CartDetailID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"CARTHDRID",#CARTHDRID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"PRICE",#PRICE#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"PRODUCTID",#PRODUCTID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"PRODUCTNAME",#left(replace(PRODUCTNAME,'~',',','ALL'),65)#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"QTYORDERED",#QTYORDERED#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"COST",#COST#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"HardwareID",#HardwareID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"SizeID",#SizeID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"MaterialID",#MaterialID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"ColorID",#ColorID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"StyleID",#StyleID#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"UnitOfMeasure",#UnitOfMeasure#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"ColorName",#theColor.ColorName#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"HardwareName",#theHardware.HardwareName#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"MaterialName",#theMaterial.MaterialName#, #newRow#)>
			<CFSET temp=QuerySetCell(CartDetail,"SizeName",#theSize.SizeName#, #newRow#)>
		</cfloop>
		
		<cfreturn CartDetail>
	</cffunction>
	
	<cffunction name="GetCartItem" output="true" returntype="query" access="remote">
		<cfargument name="CartDetailID" required="true" type="string" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CartDetail">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="SelectStatement" value=" where CartDetailID='#trim(arguments.CartDetailID)#'">
		</cfinvoke>
		
		<cfreturn CartDetail>
	</cffunction>
	
	<cffunction name="ShippingConfiguration" access="remote" returntype="query" output="true">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ShippingConfig">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ShippingConfig">
			<cfinvokeargument name="IDFieldName" value="ShippingConfigID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfreturn ShippingConfig>
	</cffunction>
	
	<cffunction name="UpdateCartHeader" access="remote" output="false">
		<cfargument name="CustomerID" default="0" type="numeric" required="true">
		<cfargument name="BillingAddressID" default="0" type="numeric" required="true">
		<cfargument name="ShippingAddressID" default="0" type="numeric" required="true">
		<cfargument name="CartID" type="numeric" required="true" default=0>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theCart">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="IDFieldName" value="CartID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.CartID#">
		</cfinvoke>
		
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">

		<CFSET FieldValues = "#arguments.billingaddressid#,#theCart.comments# ,#thecart.createdate#,#arguments.customerid#,#thecart.DAteShipped#,#theCart.expiredate# ,#thecart.giftwrap# ,#thecart.purchaseorder# ,#thecart.salestax# ,#arguments.shippingaddressid# ,#theCart.shippingamt# ,#thecart.shippingmethod# ,#theCart.shippingtype# ,#theCart.storelocation# ,#TheCart.affiliateID# ,#theCart.Paymentmethod# ,#theCart.discountCoupon# ,#theCart.discountAmt# ,#theCart.giftCertificate# ,#theCart.giftCertAmt# ,#theCart.BankRountingNo# ,#theCart.BankAcctNo# ,#theCart.BankCheckNo#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#CartID#">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="UpdateCart" access="remote" output="true">
		<cfargument name="CartID" type="numeric" default="0" required="true">
		<cfargument name="ShippingAmt" type="numeric" default="0" required="true">
		<cfargument name="ShippingMethod" type="string" default="0" required="true">
		<cfargument name="SalesTax" type="string" default="0" required="true">
		<cfargument name="CustomerID" type="numeric" default="0" required="true">
		<cfargument name="ResellerNumber" type="string" default="" required="true">
		<cfargument name="ResellerState" type="string" default="" required="true">
		<cfargument name="CardName" type="string" required="true" default="">
		<cfargument name="CCExpire" type="string" required="true" default="">
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true"default="">
		<cfargument name="username" type="string" required="true"default="">
		<cfargument name="password" type="string" required="true"default="">
		<cfargument name="Paymentmethod" required="true"default="">
		<cfargument name="discountCoupon" required="true"default="">
		<cfargument name="discountAmt" required="true"default="">
		<cfargument name="giftCertificate" required="true"default="">
		<cfargument name="giftCertAmt" required="true"default="">
		<cfargument name="BankRountingNo" required="true"default="">
		<cfargument name="BankAcctNo" required="true"default="">
		<cfargument name="BankCheckNo" required="true"default="">

		<cfif #arguments.discountCoupon# is ""><cfset #arguments.discountCoupon# = "0"></cfif>
		<cfif #arguments.discountAmt# is ""><cfset #arguments.discountAmt# = "0"></cfif>
		<cfif #arguments.giftCertificate# is ""><cfset #arguments.giftCertificate# = "0"></cfif>
		<cfif #arguments.giftCertAmt# is ""><cfset #arguments.giftCertAmt# = "0"></cfif>
		<cfif #arguments.BankRountingNo# is ""><cfset #arguments.BankRountingNo# = "0"></cfif>
		<cfif #arguments.BankAcctNo# is ""><cfset #arguments.BankAcctNo# = "0"></cfif>
		<cfif #arguments.BankCheckNo# is ""><cfset #arguments.BankCheckNo# = "0"></cfif>

		<!--- Update Cart Shipping INformation --->
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theCart">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="IDFieldName" value="CartID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.CartID#">
		</cfinvoke>
		
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateid,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">
		<CFSET FieldValues = "#thecart.billingaddressid#,#theCart.comments# ,#thecart.createdate#,#arguments.customerid#,#thecart.DAteShipped#,#theCart.expiredate# ,#thecart.giftwrap# ,#thecart.purchaseorder# ,#replace(arguments.salestax,'$','','ALL')# ,#thecart.shippingaddressid#,#arguments.shippingamt# ,#arguments.shippingmethod# ,#theCart.shippingtype# ,#theCart.storelocation# ,#theCart.affiliateid# ,#arguments.Paymentmethod# ,#arguments.discountCoupon# ,#arguments.discountAmt# ,#arguments.giftCertificate# ,#arguments.giftCertAmt# ,#arguments.BankRountingNo# ,#arguments.BankAcctNo# ,#arguments.BankCheckNo# ">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#CartID#">
		</cfinvoke>

		<!--- update reseller information --->
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theCustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="IDFieldName" value="CustomerID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.CustomerID#">
		</cfinvoke>
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<CFSET FieldValues = "#arguments.CardName# ,#theCustomer.active#,#arguments.CCExpire# ,#arguments.CCNo# ,#arguments.CCType# ,#theCustomer.OnMailList# ,#theCustomer.startdate#,#theCustomer.firstname#,#theCustomer.lastname#,#arguments.username#,#arguments.password#,#theCustomer.AffiliateID# ,#theCustomer.resellerstate# ,#theCustomer.resellernumber# ,#theCustomer.companyname#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="customerID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.CustomerID#">
		</cfinvoke>
		
	</cffunction>
	
	<cffunction name="FinalCartHeaderUpdate" access="remote" output="true">
		<cfargument name="ccno" type="string" default="" required="true">
		<cfargument name="cctype" type="string" default="" required="true">
		<cfargument name="ccexpire" type="string" default="" required="true">
		<cfargument name="cardname" type="string" default="" required="true">
		<cfargument name="customerID" type="numeric" default="0" required="true">

		<cfinvoke method="GetCustomer" returnvariable="TheCustomer" component="#application.websitepath#.utilities.customersXML2">
			<cfinvokeargument name="customerID" value="#Arguments.customerID#">
		</cfinvoke>
		<cfset comments=replace(#arguments.comments#,",","~","ALL")>
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<CFSET FieldValues = "#arguments.CardName#,#theCustomer.Active#,#arguments.CCExpire#,#arguments.CCNo#,#arguments.CCType#,#theCustomer.OnMailList#,#theCustomer.StartDate#,#theCustomer.firstname#,#theCustomer.lastname#,#theCustomer.username#,#theCustomer.password#,#theCustomer.AffiliateID#,#theCustomer.resellerstate#,#theCustomer.resellernumber#,#theCustomer.companyname# ">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="customerID">
			<cfinvokeargument name="XMLIDValue" value="#customerID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="CreateInvoice" access="remote" output="true" returntype="string">
		<cfargument name="CartID" default="0" required="true" type="string">
		<cfargument name="Authorization" default="0" required="true" type="string">
		
		<cfinvoke method="GetCartHeader" returnvariable="Cart">
			<cfinvokeargument name="CartID" value="#arguments.CartID#">
		</cfinvoke>
		<cfinvoke method="GetCartDetail" returnvariable="Detail">
			<cfinvokeargument name="CartID" value="#arguments.CartID#">
		</cfinvoke>
		
		<cfset affiliateID=0>
		<cfif isdefined('session.affiliateID')><cfset AffiliateID=#session.affiliateid#></cfif>
		
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,coupon,coupondiscount,giftcertificate,giftamountused,BankRountingNo,BankAcctNo,BankCheckNo,status,orderamount,shipname,shipcompany,shipemail,time,authorization,handling,discount">
		<CFSET FieldValues = "#Cart.billingaddressid#,#replace(Cart.comments,',','~','ALL')#,#Cart.createdate#,#Cart.customerid#, ,#Cart.expiredate#,#Cart.giftwrap#,#Cart.purchaseorder#,#Cart.salestax#,#Cart.shippingaddressid#,#Cart.shippingamt#,#Cart.shippingmethod#,#Cart.shippingtype#,#Cart.storelocation#,#Cart.affiliateID#,#Cart.Paymentmethod#,#Cart.discountCoupon# ,#Cart.discountAmt# ,#Cart.giftCertificate# ,#cart.giftCertAmt# ,#Cart.BankRountingNo# ,#Cart.BankAcctNo# ,#Cart.BankCheckNo# , ,0, , , ,#timeformat(now())#,#arguments.authorization# ,#cart.dateshipped#,0">


		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="customerorders">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="Invoice">
		</cfinvoke>
		<cfset InvoiceNo=#NewID#>
		
		<cfset  DetailFieldList="Invoice,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure,shippedamount,backorderedamount">
		<cfset tCount=0>
		<cfoutput query="Detail">
			<cfset tCount=#tCount# + 1>
			<cfset DetailFieldVAlues="#NewID#,#Price#,#ProductID#,#Productname# ,#QTYORDERED# ,#COST# ,#HardwareID# ,#SizeID# ,#MaterialID# ,#ColorID# ,#StyleID# ,#UnitOfMeasure# ,0,0"> 

			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFilename" value="orddtl">
				<cfinvokeargument name="XMLFields" value="#DetailFieldList#">
				<cfinvokeargument name="XMLFieldData" value="#DetailFieldValues#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
			</cfinvoke>
			
			<cfif #int(trim(SizeID))# neq 0>	
				<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
					method="GetXMLRecords" returnvariable="products">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="products">
					<cfinvokeargument name="IDFieldName" value="productID">
					<cfinvokeargument name="IDFieldValue" value="#productID#">
				</cfinvoke>
				<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
					method="GetXMLRecords" returnvariable="categories">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="ProductCategories">
					<cfinvokeargument name="IDFieldName" value="categoryid">
					<cfinvokeargument name="IDFieldValue" value="#products.categoryid#">
				</cfinvoke>
				<cfif findnocase("DVD",#categories.CategoryName#)>
					<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
						method="InsertXMLRecord" returnvariable="NewDetailID">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFilename" value="customerAdjunct">
						<cfinvokeargument name="XMLFields" value="customerID,views,productid">
						<cfinvokeargument name="XMLFieldData" value="#Cart.customerid#,#QTYORDERED#,#productid#">
						<cfinvokeargument name="XMLIDField" value="adjunctID">
					</cfinvoke>
				</cfif>
			</cfif>
		</cfoutput>
		<cfinvoke method="DeleteCart">
			<cfinvokeargument name="CartID" value="#arguments.cartid#">
		</cfinvoke>
		<cfset StructDelete(Session, "CartID")>
		<cfreturn InvoiceNo>
	</cffunction>
	
	<cffunction name="GetInvoiceHeader" access="remote" output="true" returntype="query">
		<cfargument name="invoiceNo" default="0" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Order">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerorders">
			<cfinvokeargument name="IDFieldName" value="Invoice">
			<cfinvokeargument name="IDFieldValue" value="#arguments.invoiceNo#">
		</cfinvoke>
		
		<cfreturn Order>
		
	</cffunction>
	
	<cffunction name="GetInvoiceDetail" access="remote" output="true" returntype="query">
		<cfargument name="invoiceNo" default="0" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Detail">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="orddtl">
			<cfinvokeargument name="IDFieldName" value="Invoice">
			<cfinvokeargument name="IDFieldValue" value="#trim(arguments.InvoiceNo)#">
		</cfinvoke>
		<cfreturn Detail>
		
	</cffunction>
	
	<cffunction name="MailInvoice" access="remote" output="true" returntype="boolean">
		<cfargument name="INvoiceID" default="0" required="true" type="numeric">
		
		<cfinvoke method="GetInvoiceHeader" returnvariable="InvoiceHeader">
			<cfinvokeargument name="InvoiceNo" value="#arguments.INvoiceID#">
		</cfinvoke> 
		<cfinvoke method="GetInvoiceDetail" returnvariable="InvoiceDetail">
			<cfinvokeargument name="InvoiceNo" value="#arguments.INvoiceID#">
		</cfinvoke> 
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomer" returnvariable="Customer">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
		</cfinvoke> 
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="GetCustomerAddress" returnvariable="BillingAddress">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="AddressTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="GetCustomerAddress" returnvariable="ShippingAddress">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="AddressTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="GetCustomerPhone" returnvariable="Phone">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="PhoneTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="GetCustomerEmail" returnvariable="Email">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="EmailTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Thispage">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="homepage">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="sizes">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="productsizes">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="hardware">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="hardware">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="colors">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Colors">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="materials">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Materials">
		</cfinvoke>
		<cfset StyleSheetDetails="<link rel=""stylesheet"" href=""#application.returnpath#/files/hasheymain.css"" type=""text/css""> ">
		<cfset Today=now()>
		<cftry>
		<cfmail to="#email.emailaddress#" from="#application.email#" 
			bcc="jamie@kotw.net,#application.email#" subject="#application.websitename# Order ## #arguments.invoiceid#" 
			type="html" server="#application.MailServer#">
		
		
		<p>Your order has been accepted and will be shipped via <cfif #invoiceHeader.ShippingMethod# is 0>Pick Up<cfelse>#invoiceHeader.ShippingMethod#</cfif>.</p>
		
		<p>The following is a copy of your order.</p>
		
		<cfif #trim(invoiceHeader.PaymentMethod)# is "COD"><p><strong>C.O.D. ORDER</strong> If this is the first C. O. D. order you have placed, send a money order to pay for this and to establish your C. O. D. account. On the first order, shipment will be made after the money order is received.</p></cfif>
		
		<table class=blank width="100%"><tr><td valign=top><table class=blank width="100%"><tr class=tableheader><th><p>Billing Address:</th></tr>
		<tr class=tableheader><td><p>#Customer.companyname#</p></td></tr>
		<tr class=tableheader><td><p>#Customer.firstname# #Customer.lastname#</p></td></tr>
		<tr class=tableheader><td><p>#trim(BillingAddress.address1)# #trim(BillingAddress.address2)#</p></td></tr>
		<tr class=tableheader><td><p>#trim(BillingAddress.city)# #trim(BillingAddress.state)# #trim(BillingAddress.postalcode)#</td></tr>
		<tr class=tableheader><td><p>#trim(BillingAddress.country)#</td></tr></table>
		</td><td valign=top>
		<table class=blank width="100%"><tr class=tableheader><th><p>Shipping Address:</th></tr><tr class=tableheader><td><p>#trim(ShippingAddress.address1)# #trim(ShippingAddress.address2)#</td></tr>
		<tr class=tableheader><td><p>#trim(ShippingAddress.city)# #trim(ShippingAddress.state)# #trim(ShippingAddress.postalcode)#</td></tr>
		<tr class=tableheader><td><p>#trim(ShippingAddress.country)#</td></tr>
		<tr class=tableheader><td><p>Email Address: #trim(email.emailaddress)#</td></tr>
		<tr class=tableheader><td><p>Phone Number: #trim(phone.phonenumber)#</td></tr>
		</table></td></tr></table>
		
		<table class=blank width="100%">
		<tr class=tableheader><th colspan=2><p>Payment Information:</th></tr>
		<tr class=tableheader><td><p>Invoice:</td>
		<td><p>#arguments.InvoiceID#</td></tr>
		<cfif #Customer.Active# gt 0>
		<tr class=tableheader><td><p>Customer ##:</td><td><p>#customer.CustomerID#</td></tr></cfif>
		<cfif #trim(invoiceHeader.PaymentMethod)# neq "COD">
		<tr class=tableheader><td><p>CC Number:</td><td><p>xxxxxxxxxxxx#right(trim(Customer.CCNO),4)#&nbsp;</td></tr>
		<tr class=tableheader><td><p>Credit Card Type:</td><td><p>#trim(Customer.cctype)#&nbsp;</td></tr>
		<tr class=tableheader><td><p>Name on Card:</td><td><p>#trim(Customer.cardname)#&nbsp;</td></tr>
		<tr class=tableheader><td><p>Expiration:</td><td><p>#Customer.CCEXPIRE#&nbsp;</td></tr>
		</cfif>
		</table>
		
		<table class=blank width="100%">
		<tr class=tableheader><th><p>PRODUCT:</th><th><p>QUANTITY:</th><th><p>COST:</th></tr>
		<cfset GrandTotal=0>
		<cfloop query="InvoiceDetail">
		<cfset theHardware="">
		<cfset theColor="">
		<cfset theMaterial="">
		<cfset theSize="">
			<cfif #int(SizeID)# neq 0>
				<cfquery name="sizeprice" dbtype="query">
					select priceadjustment,sizename from sizes where sizeid='#trim(sizeid)#'
				</cfquery>
				<Cfset theSize=#sizePrice.sizename#>
			</cfif>
			<cfif #int(hardwareID)# neq 0>
				<cfquery name="hardwareprice" dbtype="query">
					select priceadjustment,hardwarename from hardware where hardwareID='#trim(hardwareID)#'
				</cfquery>
				<cfset theHardware=#hardwareprice.hardwarename#>
			</cfif>
			<cfif #int(materialID)# neq 0>
				<cfquery name="materialprice" dbtype="query">
					select priceadjustment,MaterialName from materials where materialID='#trim(materialID)#'
				</cfquery>
				<cfset theMaterial=#materialprice.MaterialName#>
			</cfif>
			<cfif isnumeric(colorID)>
				<cfif #int(colorID)# neq 0>
					<cfquery name="colorprice" dbtype="query">
						select priceadjustment,ColorName from colors where colorID='#trim(colorID)#'
					</cfquery>
					<cfset theColor=#colorprice.ColorName#>
				</cfif>
			</cfif>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="getprod">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="products">
				<cfinvokeargument name="IDFieldName" value="ProductID">
				<cfinvokeargument name="IDFieldValue" value="#ProductID#">
			</cfinvoke>
			<cfset ThisPrice=#qtyordered# * #price#>
			<cfset GrandTotal=#GrandTotal# + #ThisPrice#>
			<tr class=tableheader><td><p>#getprod.catalogno#  #ProductName#
				<Cfif #theColor# neq ""><br>Color selected #theColor#</Cfif>
				<Cfif #theMaterial# neq ""><br>Material selected #theMaterial#</Cfif>
				<Cfif #theHardware# neq ""><br>Hardware selected #theHardware#</Cfif>
				<Cfif #theSize# neq ""><br>Size selected #theSize#</Cfif>
			</td>
			<td style="text-align: center;"><p>#QtyORdered# </td>
			<td style="text-align: right;"><p>#dollarformat(ThisPrice)#  </td></tr>
		
		</cfloop>
		
		<tr class=tableheader><td></td><th class=tableheader><p>Total Items</th><th style="text-align: right;" class=tableheader><p>#dollarformat(GrandTotal)#</th></tr>
		<tr class=tableheader><td></td><th class=tableheader><p>Sales Tax</th><th style="text-align: right;" class=tableheader><p><cfif #InvoiceHeader.salestax# neq "none">#dollarformat(InvoiceHeader.salestax)#<cfelse>$0.00</cfif></th></tr>
		<tr class=tableheader><td></td><th><p>Shipping & Handling</th><th style="text-align: right;" class=tableheader><p><cfif #InvoiceHeader.ShippingAmt# neq "none">#dollarformat(InvoiceHeader.shippingamt)#<cfelse>$0.00</cfif></th></tr>
		<tr class=tableheader><td></td><th><p>Gift Wrap</th><th style="text-align: right;" class=tableheader>$0.00</th></tr>
		<!--- <tr class=tableheader><td></td><th><p>Handling</th><th style="text-align: right;" class=tableheader>$3.50</th></tr> --->
		<Cfif #trim(InvoiceHeader.paymentmethod)# is "COD">
				<cfset CODCharge=7.50>
			<cfelse>
				<cfset CODCharge=0>
			</Cfif>
			<tr class=tableheader><td></td><th><p>COD Charge</b></th><th style="text-align: right;" class=tableheader>#dollarformat(CODCharge)#</th></tr>
			</tr>
		<cfif #InvoiceHeader.ShippingAmt# neq "none"><cfset ShippingAmt=#InvoiceHeader.ShippingAmt#><cfelse><cfset ShippingAmt=0></cfif>
		<cfif #InvoiceHeader.salestax# neq "none"><cfset ShippingAmt=#InvoiceHeader.salestax#><cfelse><cfset salestax=0></cfif>
		
		<cfif #trim(InvoiceHeader.Coupon)# neq "">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCoupons">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="coupons">
			</cfinvoke>
			<cfif #allcoupons.recordcount# gt 0>
			<cfquery name="ThisCoupon" dbtype="query">
				select couponamount from AllCoupons where couponcode='#trim(InvoiceHeader.coupon)#'
			</cfquery>
			<cfelse>
				<cfset thiscoupon.recordcount=0>
			</cfif>
			<cfif #thisCoupon.recordcount# gt 0>
				<cfset thisDiscount=GrandTotal * (Thiscoupon.couponamount / 100)>
				<cfset thisDiscount=round(thisDiscount * 100) / 100>
				<cfset GrandTotal=Grandtotal - thisDiscount>
				
				<tr class=tableheader><td></td><th>Discount Coupon</th><th style="text-align: right;">#dollarformat(thisDiscount)#</th></tr>
			</cfif>
		</cfif>
		
		<cfif #trim(InvoiceHeader.giftCertificate)# neq "">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCertificates">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="giftcertificates">
			</cfinvoke>
			<cfif #allcertificates.recordcount# gt 0>
			<cfquery name="ThisCertificate" dbtype="query">
				select Amount from AllCertificates where articleID='#trim(InvoiceHeader.giftCertificate)#'
			</cfquery>
			<cfelse>
				<cfset thiscertificate.recordcount=0>
			</cfif>
			<cfif #ThisCertificate.recordcount# gt 0>
				<cfset GrandTotal=Grandtotal - ThisCertificate.Amount>
				
				<tr class=tableheader><td></td><th>Gift Certificate</th><th style="text-align: right;">#dollarformat(ThisCertificate.Amount)#</th></tr>
			</cfif>
		</cfif>
		<cfset GrandTotal=#GrandTotal# + #InvoiceHeader.ShippingAmt# +  #InvoiceHeader.salestax# + #CODCharge#>
		<tr class=tableheader><td></td><th><p>Grand Total</th><th style="text-align: right;"><p>#dollarformat(GrandTotal)#</th></tr>
		</table>
		<br>
		<p>Please feel free to add any comments below that you would like us to see.</p>
		
		<p>Customer Comments: #InvoiceHeader.Comments#</p>
		
		</cfmail>
		
		<cfcatch>
			<cfreturn false>
		</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
	
	<cffunction access="remote" name="AddToFavorites" output="true" returntype="string">
		<cfargument name="ProdIDs" default="0" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="false" default="0">
		
		<cfif #arguments.customerID# neq 0><cfset CustomerID=#arguments.customerID#></cfif>
		<cfif isdefined(session.customerid)><cfset CustomerID=#session.customerID#></cfif>
		<cfset Today=dateformat(now(),"mm/dd/yyyy")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="XMLFields" value="ProductID,UserID,DateCreated">
			<cfinvokeargument name="XMLFieldData" 	
				value="#arguments.ProdIDs#,#customerid#,#Today#">
			<cfinvokeargument name="XMLIDField" value="FavoriteID">
		</cfinvoke>
		<cfreturn "true">
 	</cffunction>
	
	<cffunction access="remote" name="GetFavorites" output="true">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="IDFieldName" value="UserID">
			<cfinvokeargument name="IDFieldValue" value="#session.customerid#">
		</cfinvoke>
	
 	</cffunction>
	
	<cffunction access="remote" name="DeleteFavorites" output="true">
		<cfargument name="FavoriteID" required="true" type="string" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="XMLIDField" value="FavoriteID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.FavoriteID#">
		</cfinvoke>
	
 	</cffunction>

	<cffunction name="GetAllColors" access="remote" output="true" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allColors">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="colors">
		</cfinvoke>
		<cfreturn allcolors>
	</cffunction>
	
	<cffunction name="GetColors" access="remote" output="true" returntype="query">
		<cfargument name="ColorIDs" required="true" type="string">
		
		<cfset ColorIDs=replace(arguments.colorids,"~",",","ALL")>
		<cfset newColors=QueryNew("colorID,ColorName,PriceAdj")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allColors">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="colors">
		</cfinvoke>
		
		<cfloop index="theID" list="#colorIDS#">
			<cfquery name="getTheColor" dbtype="query">
				select * from allcolors where colorid='#trim(theID)#'
			</cfquery>
			<cfif #getTheColor.recordcount# gt 0>
				<CFSET newRow=QueryAddRow(newColors, 1)>
				<CFSET temp=QuerySetCell(newColors,"colorID",#getTheColor.colorID#, #newRow#)>
				<CFSET temp=QuerySetCell(newColors,"ColorName",#getTheColor.ColorName#, #newRow#)>
				<CFSET temp=QuerySetCell(newColors,"PriceAdj",#getTheColor.PriceAdjustment#, #newRow#)>
			</cfif>
		</cfloop>
		
		<cfreturn newColors>
	</cffunction>
	
	<cffunction name="GetAllMaterials" access="remote" output="true" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allMaterials">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="materials">
		</cfinvoke>
		<cfreturn AllMaterials>
	</cffunction>
	
	<cffunction name="GetMaterials" access="remote" output="true" returntype="query">
		<cfargument name="MaterialIDS" required="true" type="string">
		
		<cfset MaterialIDS=replace(arguments.MaterialIDS,"~",",","ALL")>
		<cfset newMaterials=QueryNew("MaterialID,MaterialName,PriceAdj")>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allMaterials">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="materials">
		</cfinvoke>
		
		<cfloop index="theID" list="#MaterialIDS#">
			<Cfif #allmaterials.recordcount# gt 0>
			<cfquery name="getTheMaterial" dbtype="query">
				select MaterialID,MaterialName,PriceAdjustment 
				from allMaterials where MaterialID='#trim(theID)#'
			</cfquery>
			<cfif #getTheMaterial.recordcount# gt 0>
				<CFSET newRow=QueryAddRow(newMaterials, 1)>
				<CFSET temp=QuerySetCell(newMaterials,"MaterialID",#getTheColor.MaterialID#, #newRow#)>
				<CFSET temp=QuerySetCell(newMaterials,"MaterialName",#getTheColor.MaterialName#, #newRow#)>
				<CFSET temp=QuerySetCell(newMaterials,"PriceAdj",#getTheColor.PriceAdjustment#, #newRow#)>
			</cfif>
			</Cfif>
		</cfloop>
		
		<cfreturn newMaterials>
	</cffunction>

	<cffunction name="GetAllHardware" access="remote" output="true" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allHardware">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Hardware">
		</cfinvoke>
		<cfreturn allHardware>
	</cffunction>
	
	<cffunction name="GetHardware" access="remote" output="true" returntype="query">
		<cfargument name="HardwareIDS" required="true" type="string">
		
		<cfset HardwareIDS=replace(arguments.HardwareIDS,"~",",","ALL")>
		<cfset newHardware=QueryNew("HardwareID,HardwareName,PriceAdj")>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allHardware">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Hardware">
		</cfinvoke>
		
		<cfloop index="theID" list="#HardwareIDS#">
			<cfquery name="getTheHardware" dbtype="query">
				select HardwareID,HardwareName,PriceAdjustment 
				from allHardware where HardwareID='#trim(theID)#'
			</cfquery>
			<cfif #getTheHardware.recordcount# gt 0>
				<CFSET newRow=QueryAddRow(newHardware, 1)>
				<CFSET temp=QuerySetCell(newHardware,"HardwareID",#getTheHardware.HardwareID#, #newRow#)>
				<CFSET temp=QuerySetCell(newHardware,"HardwareName",#getTheHardware.HardwareName#, #newRow#)>
				<CFSET temp=QuerySetCell(newHardware,"PriceAdj",#getTheHardware.PriceAdjustment#, #newRow#)>
			</cfif>
		</cfloop>
		
		<cfreturn newHardware>
	</cffunction>
	
	<cffunction name="GetAllSizes" access="remote" output="true" returntype="query">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allSizes">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="productSizes">
		</cfinvoke>
		<cfreturn allSizes>
	</cffunction>
	
	<cffunction name="GetSizes" access="remote" output="true" returntype="query">
		<cfargument name="SizeIDS" required="true" type="string">
		
		<cfset SizeIDS=replace(arguments.SizeIDS,"~",",","ALL")>
		<cfset newSizes=QueryNew("SizeID,SizeName,PriceAdj")>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allSizes">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="productSizes">
		</cfinvoke>
		
		<cfloop index="theID" list="#SizeIDS#">
			<cfquery name="getTheSize" dbtype="query">
				select SizeID,SizeName,PriceAdjustment 
				from allSizes where SizeID='#trim(theID)#'
			</cfquery>
			<cfif #getTheSize.recordcount# gt 0>
				<CFSET newRow=QueryAddRow(newSizes, 1)>
				<CFSET temp=QuerySetCell(newSizes,"SizeID",#getTheSize.SizeID#, #newRow#)>
				<CFSET temp=QuerySetCell(newSizes,"SizeName",#getTheSize.SizeName#, #newRow#)>
				<CFSET temp=QuerySetCell(newSizes,"PriceAdj",#getTheSize.PriceAdjustment#, #newRow#)>
			</cfif>
		</cfloop>
		
		<cfreturn newSizes>
	</cffunction>
	
	<cffunction name="GetAccount" access="remote" output="true" returntype="query">
		<cfargument name="password" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="TheCustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="SelectStatement" value=" where password='#trim(arguments.password)#' or customerid='#trim(arguments.password)#'">
		</cfinvoke>
		<cfset theAccount=querynew("CustomerID,CompanyName,FirstName,Lastname,resellnumber,resellstate,Password,billfirstname,shipfirstname,billlastname,shiplastname,EmailID,Email,PHoneID,Phonenumber,PostalCode,Address1,BillingAddressID,Address2,City,STate,Country,shipAdd1,shipAdd2,shipCity,shipState,shipCountry,shipPostal,ShippingAddressID,username")>
		
		<cfif #theCustomer.recordcount# gt 0>
		<cfset customerid=#trim(TheCustomer.customerID)#>
		<cfset session.customerid=#customerid#>
		<cfoutput query="TheCustomer"><cfset customerid=#trim(TheCustomer.customerID)#></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="BillingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeraddress">
			<cfinvokeargument name="SelectStatement" value=" where ConnectID='#CustomerID#' and Addresstypeid='1'">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.xmlHandler" 
			method="getXMLRecords" returnvariable="ShippingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="customeraddress">
			<cfinvokeargument name="selectStatement" value=" where ConnectID='#CustomerID#' and Addresstypeid='2'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomerEmail" returnvariable="CustEmailAddress">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="EmailTypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomerPhone" returnvariable="CustPhoneNumber">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="PHonetypeID" value="1">
		</cfinvoke>
		
		<cfoutput query="CustEmailAddress">
			<cfif #custEmailAddress.Emailaddress# neq "">
			<cfoutput>query EmailID=#EmailID#<br></cfoutput>
				<cfset EmailID=#EmailID#>
				<cfset Email=#emailaddress#>
			</cfif>
		</cfoutput>
		<cfoutput query="CustPhoneNumber">
			<cfif #custphoneNumber.phonenumber# neq "">
			<cfoutput>query phoneID=#PHoneID#<br></cfoutput>
				<cfset PHoneID=#PHoneID#>
				<cfset Phonenumber=#Phonenumber#>
			</cfif>
		</cfoutput>
		<cfoutput query="TheCustomer">
			<cfset customerid=#customerID#>
			<Cfset session.customerid=#customerID#>
			<cfset companyname=#trim(companyname)#>
			<cfset resellnumber=#ResellerNumber#>
			<cfset resellstate=#ResellerState#>
			<cfset Password=#password#>
			<cfset billfirstname=#trim(firstname)#>
			<cfset shipfirstname=#trim(firstName)#>
			<cfset billlastname=#trim(lastname)#>
			<cfset shiplastname=#trim(lastname)#>
			<Cfset username=#trim(username)#>
		</cfoutput>
		<cfoutput query="BillingAddress">
			<cfif #billingaddress.address1# neq "">
			<cfoutput>query baddressID=#addressID#<br></cfoutput>
				<cfset PostalCode=#trim(postalcode)#>
				<cfset Address1=#trim(address1)#>
				<cfset BillingAddressID=#AddressID#>
				<cfset Address2=#trim(Address2)#>
				<Cfset City=#trim(city)#>
				<Cfset STate=#trim(state)#>
				<cfset Country=#trim(country)#>
			</cfif>
		</cfoutput>
		<cfoutput query="ShippingAddress">
			<cfoutput>query saddressID=#addressID#<br></cfoutput>
			<cfset shipAdd1=#trim(address1)#>
			<cfset shipAdd2=#trim(Address2)#>
			<cfset shipCity=#trim(city)#>
			<cfset shipState=#trim(state)#>
			<cfset shipCountry=#trim(country)#>
			<cfset shipPostal=#trim(postalcode)#>
			<cfset ShippingAddressID=#AddressID#>
		</cfoutput>
		
		
		<CFSET newRow=QueryAddRow(theAccount, 1)>
		<cfoutput query="TheCustomer">
		<CFSET temp=QuerySetCell(theAccount,"CustomerID",#customerID#, #newRow#)>
		<CFSET temp=QuerySetCell(theAccount,"CompanyName",#CompanyName#, #newRow#)>
		<CFSET temp=QuerySetCell(theAccount,"FirstName",#FirstName#, #newRow#)>
		<CFSET temp=QuerySetCell(theAccount,"Lastname",#Lastname#, #newRow#)>
		<cfset session.customerid=#customerID#>
		<cfset temp=QuerySetCell(theAccount,"resellnumber",#ResellerNumber#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"resellstate",#ResellerState#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Password",#password#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"billfirstname",#firstname#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipfirstname",#firstName#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"billlastname",#lastname#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shiplastname",#lastname#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"username",#username#, #newRow#)>
		</cfoutput>
		<cfoutput query="CustEmailAddress">
			<cfset temp=QuerySetCell(theAccount,"EmailID",#EmailID#, #newRow#)>
			<cfset temp=QuerySetCell(theAccount,"Email",#emailaddress#, #newRow#)>
		</cfoutput>
		<cfoutput query="CustPhoneNumber">
		<cfset temp=QuerySetCell(theAccount,"PHoneID",#PHoneID#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Phonenumber",#Phonenumber#, #newRow#)>
		</cfoutput>
		<cfoutput query="BillingAddress">
		<cfif #billingaddress.address1# neq "">
		<cfset temp=QuerySetCell(theAccount,"PostalCode",#postalcode#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Address1",#address1#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"BillingAddressID",#AddressID#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Address2",#Address2#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"City",#city#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"STate",#state#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Country",#country#, #newRow#)>
		<cfelse>
		<cfset temp=QuerySetCell(theAccount,"PostalCode",NULL , #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Address1",NULL , #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"BillingAddressID",NULL , #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Address2",NULL , #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"City",NULL , #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"STate",NULL, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"Country",NULL, #newRow#)>
		</cfif>
		</cfoutput>
		<cfoutput query="ShippingAddress">
		<cfset temp=QuerySetCell(theAccount,"shipAdd1",#address1#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipAdd2",#Address2#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipCity",#city#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipState",#state#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipCountry",#country#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"shipPostal",#postalcode#, #newRow#)>
		<cfset temp=QuerySetCell(theAccount,"ShippingAddressID",#AddressID#, #newRow#)>
		</cfoutput>
		
		</cfif>
		
		<cfreturn theAccount>
	</cffunction>

	<cffunction name="UpdateCustomer" access="remote" output="true">
		<cfargument name="CustomerID" type="string" required="true" default=0>
		<cfargument name="CompanyName" type="string" required="true" default=0>
		<cfargument name="resellnumber" type="string" required="true" default="0">
		<cfargument name="resellstate" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="billfirstname" type="string" required="true"default="0">
		<cfargument name="shipfirstname" type="string" required="true"default="0">
		<cfargument name="billlastname" type="string" required="true" default="0">
		<cfargument name="shiplastname" type="string" required="true" default=0>
		<cfargument name="EmailID" type="string" required="true" default=0>
		<cfargument name="Email" type="string" required="true" default="0">
		<cfargument name="PHoneID" type="string" required="true" default="0">
		<cfargument name="Phonenumber" type="string" required="true" default="0">
		<cfargument name="PostalCode" type="string" required="true" default="0">
		<cfargument name="Address1" type="string" required="true" default="0">
		<cfargument name="BillingAddressID" type="string" required="true" default="0">
		<cfargument name="Address2" type="string" required="true"default="0">
		<cfargument name="City" type="string" required="true"default="0">
		<cfargument name="STate" type="string" required="true" default="0">
		<cfargument name="Country" type="string" required="true" default=0>
		<cfargument name="shipAdd1" type="string" required="true" default="0">
		<cfargument name="shipAdd2" type="string" required="true" default="0">
		<cfargument name="shipCity" type="string" required="true" default="0">
		<cfargument name="shipState" type="string" required="true" default="0">
		<cfargument name="shipCountry" type="string" required="true" default="0">
		<cfargument name="shipPostal" type="string" required="true" default="0">
		<cfargument name="ShippingAddressID" type="string" required="true" default="0">
		<cfargument name="username" type="string" required="true" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="TheCustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="SelectStatement" value=" where customerID='#Arguments.customerID#'">
		</cfinvoke>
		
		<cfset CardName="#thecustomer.CardName# ">
		<cfset CCExpire="#trim(thecustomer.CCExpire)# ">
		<cfset CCNo="#trim(thecustomer.CCNo)# ">
		<cfset CCType="#trim(thecustomer.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.billfirstname)# ">
		<cfset lastname="#XMLFormat(arguments.billlastname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#thecustomer.active#>
		<cfset OnMailList=#thecustomer.onmaillist#>
		<cfset startdate="#thecustomer.startdate# ">
		<cfset AffiliateID=#thecustomer.affiliateID#>
		<cfset resellerstate="#XMLFormat(arguments.resellstate)# ">
		<cfset resellernumber="#XMLFormat(arguments.resellnumber)# ">
		<cfset companyname="#XMLFormat(arguments.companyname)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber,companyname">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#resellerstate#,#resellernumber#,#companyname#">
		<cfoutput>#fieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CustomerID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.customerID#">
		</cfinvoke>
		
		<cfset Address1="#XMLFormat(arguments.Address1)# ">
		<cfset Address2="#XMLFormat(arguments.Address2)# ">
		<cfif Address2 is ''><cfset Address2=" "></cfif>
		<cfset City="#XMLFormat(arguments.City)# ">
		<cfset ConnectID=#XMLFormat(arguments.customerid)#>
		<cfset PostalCode="#XMLFormat(arguments.PostalCode)# ">
		<cfset State="#XMLFormat(arguments.State)# ">
		<cfset Country="#XMLFormat(arguments.Country)# ">
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues= "#Address1#,#Address2#,1,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		<cfoutput>#fieldValues#<br></cfoutput>
		<Cfif #arguments.billingaddressid# is 0 or #arguments.billingaddressid# is "">
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFilename" value="customeraddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFilename" value="customeraddress">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
				<cfinvokeargument name="XMLIDField" value="addressid">
				<cfinvokeargument name="XMLIDValue" value="#arguments.billingaddressid#">
			</cfinvoke>
		</cfif>
		
		<cfset shipAdd1="#XMLFormat(arguments.shipAdd1)# ">
		<cfset shipAdd2="#XMLFormat(arguments.shipAdd2)# ">
		<cfif shipAdd2 is ''><cfset shipAdd2=" "></cfif>
		<cfset shipCity="#XMLFormat(arguments.City)# ">
		<cfset ConnectID=#XMLFormat(arguments.customerid)#>
		<cfset shipPostalCode="#XMLFormat(arguments.PostalCode)# ">
		<cfset shipState="#XMLFormat(arguments.State)# ">
		<cfset shipCountry="#XMLFormat(arguments.Country)# ">
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#shipAdd1#,#shipAdd2#,2,#shipCity#,#ConnectID#,#shipPostalCode#,#shipState#,#shipCountry#">
		<cfoutput>#fieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="customeraddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="addressid">
			<cfinvokeargument name="XMLIDValue" value="#arguments.shippingaddressid#">
		</cfinvoke>
			
		<cfset EmailID=#XMLFormat(arguments.EmailID)#>
		<cfset EmailTypeID=1>
		<cfset ConnectID=#XMLFormat(arguments.customerid)#>
		<cfset EmailAddress="#XMLFormat(arguments.Email)# ">
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		<cfoutput>#fieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customeremail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#fieldValues#">
			<cfinvokeargument name="XMLIDField" value="emailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>
		
		<cfset PhoneTypeID=1>
		<cfset ConnectID=#XMLFormat(arguments.customerid)#>
		<cfset PhoneNumber="#XMLFormat(arguments.PhoneNumber)# ">

		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber# ">
		<cfoutput>#fieldValues#<br></cfoutput>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDVAlue" value="#arguments.PHoneID#">
		</cfinvoke>
		
		<cfreturn #arguments.CustomerID#>
	</cffunction>
	
	<cffunction name="SaveNewCustomer" access="remote" returntype="string" output="true">
		<cfargument name="Companyname" type="string" required="true">
		<cfargument name="FirstName" type="string" required="true">
		<cfargument name="Lastname" type="string" required="true">
		<cfargument name="resellnumber" type="string" required="true">
		<cfargument name="resellstate" type="string" required="true">
		<cfargument name="Password" type="string" required="true">
		<cfargument name="billfirstname" type="string" required="true">
		<cfargument name="shipfirstname" type="string" required="true">
		<cfargument name="billlastname" type="string" required="true">
		<cfargument name="shiplastname" type="string" required="true">
		<cfargument name="Email" type="string" required="true">
		<cfargument name="Phonenumber" type="string" required="true">
		<cfargument name="PostalCode" type="string" required="true">
		<cfargument name="Address1" type="string" required="true">
		<cfargument name="Address2" type="string" required="true">
		<cfargument name="City" type="string" required="true">
		<cfargument name="STate" type="string" required="true">
		<cfargument name="Country" type="string" required="true">
		<cfargument name="shipAdd1" type="string" required="true">
		<cfargument name="shipAdd2" type="string" required="true">
		<cfargument name="shipCity" type="string" required="true">
		<cfargument name="shipState" type="string" required="true">
		<cfargument name="shipCountry" type="string" required="true">
		<cfargument name="shipPostal" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.customersXML2" 
			method="addcustomer" returnvariable="CustomerID">
			<cfinvokeargument name="Active" value="1">
			<cfinvokeargument name="CardName" value=" ">
			<cfinvokeargument name="CCExpire" value=" ">
			<cfinvokeargument name="CCNo" value=" ">
			<cfinvokeargument name="CCType" value=" ">
			<cfinvokeargument name="OnMailList" value="0">
			<cfinvokeargument name="StartDate" value="#dateformat(now(),'mm/dd/yyyy')#">
			<cfinvokeargument name="firstname" value="#replace(arguments.billfirstname,',','~','ALL')# ">
			<cfinvokeargument name="lastname" value="#replace(arguments.billlastname,',','~','ALL')# ">
			<cfinvokeargument name="username" value="#arguments.username# ">
			<cfinvokeargument name="Password" value="#arguments.Password# ">
			<cfinvokeargument name="AffiliateID" value="0">
			<cfinvokeargument name="resellerstate" value=" ">
			<cfinvokeargument name="resellernumber" value=" ">
			<cfinvokeargument name="companyname" value="#replace(arguments.companyname,',','~','ALL')# ">
		</cfinvoke>
		
		<cfset session.customerid=#CustomerID#>

		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="AddAddress" returnvariable="BillingAddressID">
			<cfinvokeargument name="AddressTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#session.customerid#">
			<cfinvokeargument name="Address1" value="#replace(arguments.Address1,',','~','ALL')#">
			<cfinvokeargument name="Address2" value="#replace(arguments.Address2,',','~','ALL')#">
			<cfinvokeargument name="City" value="#replace(arguments.City,',','~','ALL')#">
			<cfinvokeargument name="State" value="#replace(arguments.State,',','~','ALL')#">
			<cfinvokeargument name="PostalCode" value="#arguments.PostalCode#">
			<cfinvokeargument name="Country" value="#arguments.Country#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="AddAddress" returnvariable="ShippingAddressID">
			<cfinvokeargument name="AddressTypeID" value="2">
			<cfinvokeargument name="ConnectID" value="#session.customerid#">
			<cfinvokeargument name="Address1" value="#replace(arguments.shipadd1,',','~','ALL')#">
			<cfinvokeargument name="Address2" value="#replace(arguments.shipadd2,',','~','ALL')#">
			<cfinvokeargument name="City" value="#replace(arguments.shipCity,',','~','ALL')#">
			<cfinvokeargument name="State" value="#replace(arguments.shipState,',','~','ALL')#">
			<cfinvokeargument name="PostalCode" value="#arguments.shipPostal#">
			<cfinvokeargument name="Country" value="#arguments.shipCountry#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="AddPhone" returnvariable="PhoneID">
			<cfinvokeargument name="PhoneTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#session.customerid#">
			<cfinvokeargument name="PhoneNumber" value="#replace(arguments.PhoneNumber,',','~','ALL')#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="AddEmail" returnvariable="EmailID">
			<cfinvokeargument name="EmailTypeID" value="1">
			<cfinvokeargument name="ConnectID" value="#session.customerid#">
			<cfinvokeargument name="EmailAddress" value="#arguments.Email#">
		</cfinvoke>
		<cfreturn customerid>
	</cffunction>
	
	<cffunction name="GetShippingMethods" access="remote" returntype="query" output="true">
		<cfargument name="weight" type="string" required="true">
		<cfargument name="PostalCode" type="string" required="true">
		
		<cfset arguments.postalcode=trim(arguments.postalcode)>
		<cfset arguements.weight=trim(arguments.weight)>
		<cfset totalweight=#arguments.weight#>
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
		<cfset HandlingFee=#listgetat(RushStartAmt,6,"~")#>
		<cfset fromzip=#application.zip#>
		<cfset shippingMethod=querynew("Method,Price")>
		
		<CF_UPSPrice SERVICE="GNDRES" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPSGround=UPS_Charge>
		<cfif UPSGround is "">
			<cfset UPSGround=0>
		<cfelse>
			<cfset UPSGround=UPSGround + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS Ground", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPSGround#, #newRow#)>
		</cfif>
		
		<CF_UPSPrice SERVICE="1DM" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		
		<cfset UPSOvernightAM=UPS_Charge>
		<cfif UPSOvernightAM is "">
			<cfset UPSOvernightAM=0>
		<cfelse>
			<cfset UPSOvernightAM=UPSOvernightAM + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS Overnight AM", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPSOvernightAM#, #newRow#)>
		</cfif>
		<CF_UPSPrice SERVICE="1DA" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPSOvernight=UPS_Charge>
		<cfif UPSOvernight is "">
			<cfset UPSOvernight=0>
		<cfelse>
			<cfset UPSOvernight=UPSOvernight + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS Overnight", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPSOvernight#, #newRow#)>
		</cfif>
		<CF_UPSPrice SERVICE="2DM" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPS2ndDayAM=UPS_Charge>
		<cfif UPS2ndDayAM is "">
			<cfset UPS2ndDayAM=0>
		<cfelse>
			<cfset UPS2ndDayAM=UPS2ndDayAM + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS 2nd Day AM", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPS2ndDayAM#, #newRow#)>
		</cfif>
		<CF_UPSPrice SERVICE="2DA" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPS2ndDay=UPS_Charge>
		<cfif UPS2ndDay is "">
			<cfset UPS2ndDay=0>
		<cfelse>
			<cfset UPS2ndDay=UPS2ndDay + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS 2nd Day", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPS2ndDay#, #newRow#)>
		</cfif>
		<CF_UPSPrice SERVICE="3DS" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPS3Day=UPS_Charge>
		<cfif UPS3Day is "">
			<cfset UPS3Day=0>
		<cfelse>
			<cfset UPS3Day=UPS3Day + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS 3 Day", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPS3Day#, #newRow#)>
		</cfif>
		<CF_UPSPrice SERVICE="GNDCOM" FROM="#fromzip#" TO="#arguments.postalcode#" WEIGHT="#TotalWeight#">
		<cfset UPSGroundCommercial=UPS_Charge>
		<cfif UPSGroundCommercial is "">
			<cfset UPSGroundCommercial=0>
		<cfelse>
			<cfset UPSGroundCommercial=UPSGroundCommercial + HandlingFee>
			<CFSET newRow=QueryAddRow(shippingMethod, 1)>
			<CFSET temp=QuerySetCell(shippingMethod,"Method","UPS Ground Commercial", #newRow#)>
			<CFSET temp=QuerySetCell(shippingMethod,"Price",#UPSGroundCommercial#, #newRow#)>
		</cfif>
		
		
		<cfreturn ShippingMethod>
	</cffunction>
	
	<cffunction name="SendToProcessor" access="remote" returntype="query" output="true">
		<cfargument name="CartID" type="string" required="true">
		<cfargument name="CardName" type="string" required="true">
		<cfargument name="CCExpire" type="string" required="true">
		<cfargument name="CCNo" type="string" required="true">
		<cfargument name="CCType" type="string" required="true">
		<cfargument name="CCV" type="string" required="true">
		
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
		
		<cfinvoke method="GetCart" returnvariable="MyCart">
			<cfinvokeargument name="CartID" value="#arguments.cartid#">
		</cfinvoke>
		<cfinvoke method="GetCartHeader" returnvariable="MyCartHeader">
			<cfinvokeargument name="CartID" value="#arguments.cartid#">
		</cfinvoke>
		<cfoutput>cartheader=#myCartHeader.recordcount#<br></cfoutput>
		<cfset CustomerID=#MyCartHeader.Customerid#>
		<cfset session.customerid=#MyCartHeader.customerid#>
		<Cfset BankRountingNo=MyCartHeader.BankRountingNo>

		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomer" returnvariable="TheCustomer">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.flashcatalog" 
			method="getallhardware" returnvariable="Hardware">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.flashcatalog" 
			method="getallsizes" returnvariable="Sizes">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.flashcatalog" 
			method="getallcolors" returnvariable="colors">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.flashcatalog" 
			method="getallmaterials" returnvariable="materials">
			<cfinvokeargument name="customerid" value="#customerID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.xmlHandler" 
			method="getXMLRecords" returnvariable="BillingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="customeraddress">
			<cfinvokeargument name="selectStatement" value=" where ConnectID='#CustomerID#' and Addresstypeid='1'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.xmlHandler" 
			method="getXMLRecords" returnvariable="ShippingAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="customeraddress">
			<cfinvokeargument name="selectStatement" value=" where ConnectID='#CustomerID#' and Addresstypeid='2'">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomerEmail" returnvariable="CustEmailAddress">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="EmailTypeID" value="1">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML2" 
			method="getCustomerPhone" returnvariable="CustPhoneNumber">
			<cfinvokeargument name="customerid" value="#customerID#">
			<cfinvokeargument name="PHonetypeID" value="1">
		</cfinvoke>
		<cfoutput query="CustEmailAddress">
			<cfif #custEmailAddress.Emailaddress# neq "">
				<cfset EmailID=#EmailID#>
				<cfset Email=#emailaddress#>
			</cfif>
		</cfoutput>
		<cfoutput query="CustPhoneNumber">
			<cfif #custphoneNumber.phonenumber# neq "">
				<cfset PHoneID=#PHoneID#>
				<cfset Phonenumber=#Phonenumber#>
			</cfif>
		</cfoutput>
		<cfoutput query="TheCustomer">Customer <br>
			<cfset DealerID=#customerID#>
			<Cfset session.customerid=#customerID#>
			<cfset resellnumber=#ResellerNumber#>
			<cfset resellstate=#ResellerState#>
			<cfset Password=#password#>
			<cfset billfirstname=#firstname#>
			<cfset shipfirstname=#firstName#>
			<cfset billlastname=#lastname#>
			<cfset shiplastname=#lastname#>
			<cfset ccexpires=#dateformat(ccexpire,"mm/yy")#>
			<Cfset ccexpires=replace(ccexpires,"/","")>
			<cfset ccno=#ccno#>
			<cfset cardname=#cardname#>
			<cfset cctype=#cctype#>
		</cfoutput>
		<cfoutput query="BillingAddress">Billing address<br>
			<cfif #billingaddress.address1# neq "">
				<cfset PostalCode=#postalcode#>
				<cfset Address1=#address1#>
				<cfset BillingAddressID=#AddressID#>
				<cfset Address2=#Address2#>
				<Cfset City=#city#>
				<Cfset STate=#state#>
				<cfset Country=#country#>
			</cfif>
		</cfoutput>
		<cfoutput query="ShippingAddress">Shipping Address<br>
			<cfset shipAdd1=#address1#>
			<cfset shipAdd2=#Address2#>
			<cfset shipCity=#city#>
			<cfset shipState=#state#>
			<cfset shipCountry=#country#>
			<cfset shipPostal=#postalcode#>
			<cfset ShippingAddressID=#AddressID#>
		</cfoutput>
	
		<cfset processing=querynew("Status,Authorization")>
		<cfset ProcessedGood=0>
		<cfif #MyCArtHeader.Giftwrap# is "none"><cfset Giftwrap=0><cfelse> <cfset Giftwrap=#myCartHEader.GiftWrap#></cfif>
		<cfif #MyCArtHeader.salestax# is "none"><cfset salestax=0><cfelse> <cfset salestax=#myCartHEader.salestax#>
		</cfif>
		<cfif #MyCArtHeader.shippingamt# is "none"><cfset shippingamt=0><cfelse> <cfset shippingamt=#myCartHEader.shippingamt#></cfif>
		<cfif #myCartHeader.ShippingAmt# neq "none"><cfset ShippingAmt=#myCartHeader.ShippingAmt#><cfelse><cfset ShippingAmt=0></cfif>
		<cfif #myCartHeader.salestax# neq "none"><cfset salestax=#myCartHeader.salestax#><cfelse><cfset salestax=0></cfif>
		
		<cfset GrandTotal = 0>
		<cfset GetSpecials = 0>
		<cfset TotalQuantity = 0>
		<cfset TotalWeight=0>
		<cfoutput query="MyCart">
			<cfset theHardware="">
			<cfset theColor="">
			<cfset theMaterial="">
			<cfset theSize="">
			<Cfset ThisPrice=#Price# * 100>
			<cfset ThisPrice=#round(ThisPrice)# / 100>
			<cfset ThisPrice="#ThisPrice#">
			<cfif isnumeric(sizeID)>
			<cfif #int(SizeID)# neq 0>
				<cfquery name="sizeprice" dbtype="query">
					select priceadjustment,sizename from sizes where sizeid='#sizeid#'
				</cfquery>
				<cfset ThisPrice=#ThisPrice# + #sizeprice.priceadjustment#>
				<Cfset theSize=#sizePrice.sizename#>
			</cfif>
			</cfif>
			<cfif isnumeric(hardwareid)>
				<cfif #int(hardwareID)# neq 0>
					<cfquery name="hardwareprice" dbtype="query">
						select priceadjustment,hardwarename from hardware where hardwareID='#hardwareID#'
					</cfquery>
					<cfset ThisPrice=#ThisPrice# + #hardwareprice.priceadjustment#>
					<cfset theHardware=#hardwareprice.hardwarename#>
				</cfif>
			</cfif>
			<cfif isnumeric(materialid)>
				<cfif #int(materialID)# neq 0>
					<cfquery name="materialprice" dbtype="query">
						select priceadjustment,MaterialName from materials where materialID='#materialID#'
					</cfquery>
					<cfset ThisPrice=#ThisPrice# + #materialprice.priceadjustment#>
					<cfset theMaterial=#materialprice.MaterialName#>
				</cfif>
			</cfif>
			<cfif isnumeric(colorid)>
				<cfif #int(colorID)# neq 0>
					<cfquery name="colorprice" dbtype="query">
						select priceadjustment,ColorName from colors where colorID='#colorID#'
					</cfquery>
					<cfset ThisPrice=#ThisPrice# + #colorprice.priceadjustment#>
					<cfset theColor=#colorprice.ColorName#>
				</cfif>
			</cfif>
			<!--- <cfif #int(StyleID)# neq 0>
				<cfquery name="styleprice" dbtype="query">
					select priceadjustment from styles where StyleID='#StyleID#'
				</cfquery>
				<cfset ThisPrice=#ThisPrice# + #styleprice.priceadjustment#>
			</cfif> --->
			<cfset total=#ThisPrice#*(#QTYORDERED#)>
			<cfset TotalQuantity=#totalQuantity# + #QtyOrdered#>
			<Cfset TotalWeight=#TotalWeight# + (#StyleID# * #qtyOrdered#)>
			<cfset GrandTotal=#total# + #GrandTotal#>
		</cfoutput>
		
		<Cfset coupon=0>
		<cfif #trim(myCartHeader.discountCoupon)# neq "">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCoupons">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="coupons">
			</cfinvoke>
			<cfif #AllCoupons.recordcount# gt 0>
				<cfquery name="ThisCoupon" dbtype="query">
					select couponamount from AllCoupons where couponcode='#trim(myCartHeader.discountcoupon)#'
				</cfquery>
				<cfif #thisCoupon.recordcount# gt 0>
					<cfset thisDiscount=GrandTotal * (Thiscoupon.couponamount / 100)>
					<cfset coupon=round(thisDiscount * 100) / 100>
				</cfif>
			</cfif>
		</cfif>
		<cfoutput>GrandTotal=#GrandTotal# + #ShippingAmt# +  #salestax#</cfoutput>
		<cfset GrandTotal=#GrandTotal# + #ShippingAmt# +  #salestax# >
		
		<cfset giftcertificate=0>
		
		<cfinvoke component="#application.websitepath#.utilities.xmlhandler" 
			method="GetMaxID" returnvariable="invoiceNo">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="customerorders">
			<cfinvokeargument name="FieldName" value="Invoice">
		</cfinvoke>
		<cfset NewInvoiceNo=#int(InvoiceNo)# + 1>
		
		<cfif #trim(myCartHeader.giftCertificate)# neq "">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCertificates">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="giftcertificates">
			</cfinvoke>
			<cfif #allCertificates.recordcount# gt 0>
				<cfquery name="ThisCertificate" dbtype="query">
					select Amount from AllCertificates where articleID='#trim(myCartHeader.giftCertificate)#'
				</cfquery>
				<cfif #ThisCertificate.recordcount# gt 0>
					<cfset giftcertificate=#ThisCertificate.Amount#>
				</cfif>
			</cfif>
		</cfif>
		<cfset ProcessTotal=#GrandTotal# + #giftwrap# - #coupon# - #giftcertificate#>
		<cfset ProcessTotal=dollarformat(ProcessTotal)>
		<cfset ProcessTotal=replace(ProcessTotal,"$","")>
		
		<cfif ProcessTotal gt 0>
			<Cfif #trim(BankRountingNo)# neq "">
			<!--- 
				VID="#trim(GatewayUserName)#"
					Password="#lcase(trim(GatewayPassword))#"
					CCNum="#trim(CCNO)#"
					CVV2="#trim(BankRoutingNo)#"
					EXP="#trim(CCEXPIREs)#"
					--->
				<CF_iNetTransTagV34
					VID="#trim(GatewayUserName)#"
					Password="#lcase(trim(GatewayPassword))#"
					CCNum="#trim(CCNO)#"
					CVV2="#trim(BankRountingNo)#"
					EXP="#trim(CCEXPIREs)#"
					Action="1"
					Amount="#ProcessTotal#"
					Name="#trim(billFirstName)# #trim(billLastName)#"
					Addr="#trim(Address1)#"
					City="#trim(city)#"
					State="#trim(State)#"
					Zip="#trim(postalcode)#"
					Country="#trim(country)#"
					ProdID="#left(application.websitename,25)#"
					UIP="#cgi.REMOTE_ADDR#">
			<cfelse>
				<CF_iNetTransTagV34
					
					VID="#trim(GatewayUserName)#"
					Password="#lcase(trim(GatewayPassword))#"
					CCNum="#trim(CCNO)#"
					EXP="#trim(CCEXPIREs)#"
					Action="1"
					Amount="#ProcessTotal#"
					Name="#trim(billFirstName)# #trim(billLastName)#"
					Addr="#trim(Address1)#"
					City="#trim(city)#"
					State="#trim(State)#"
					Zip="#trim(postalcode)#"
					Country="#trim(country)#"
					ProdID="#left(application.websitename,25)#"
					UIP="#cgi.REMOTE_ADDR#">
			</cfif>
			
			<!---<cfset iNet_Processed="YES">
			<cfset iNet_Result="YES"> --->
			<!--- PROCESS BAD RESPONCE --->
			<Cfset ErrMess="">
			<cfset ProcessedGood = 1>
			<cfif #iNet_Processed# IS "NO">
				<cfset ErrMess = iNet_Err_Mess>
				<Cfset ProcessedGood=0>
			</cfif>
			
			<cfif ProcessedGood is 1>
				<cfif (#Left(Trim(iNet_Result),4)# EQ "NOT ") OR (#Left(Trim(iNet_Result),4)# EQ "DECL")>	
					<Cfset ProcessedGood=0>
					<cfset ErrMess = iNet_Result>
				</cfif>
			</cfif>
			<cfif ProcessedGood is 0>
				<cfmail to="#application.email#" from="#application.email#" 
					subject="Order Not Processed" 
					type="html" server="#application.MailServer#">
				
				
				<p>Your order has been accepted and will be shipped via <cfif #myCartHeader.ShippingMethod# is 0>Pick Up<cfelse>#mycartheader.ShippingMethod#</cfif>.</p>
				
				<p><font color="##CC0000" size="4">The following is a copy of an order that did not process through inetTrans.com</font>.</p>
				
				<table class=blank width="100%"><tr><td valign=top><table class=blank width="100%"><tr class=tableheader><th><p>Billing Address:</th></tr>
				<tr class=tableheader><td><p>#TheCustomer.companyname#</p></td></tr>
				<tr class=tableheader><td><p>#TheCustomer.firstname# #theCustomer.lastname#</p></td></tr>
				<tr class=tableheader><td><p>#trim(BillingAddress.address1)# #trim(BillingAddress.address2)#</p></td></tr>
				<tr class=tableheader><td><p>#trim(BillingAddress.city)# #trim(BillingAddress.state)# #trim(BillingAddress.postalcode)#</td></tr>
				<tr class=tableheader><td><p>#trim(BillingAddress.country)#</td></tr></table>
				</td><td valign=top>
				<table class=blank width="100%"><tr class=tableheader><th><p>Shipping Address:</th></tr><tr class=tableheader><td><p>#trim(ShippingAddress.address1)# #trim(ShippingAddress.address2)#</td></tr>
				<tr class=tableheader><td><p>#trim(ShippingAddress.city)# #trim(ShippingAddress.state)# #trim(ShippingAddress.postalcode)#</td></tr>
				<tr class=tableheader><td><p>#trim(ShippingAddress.country)#</td></tr>
				<tr class=tableheader><td><p>Email Address: #trim(CustEmailAddress.emailaddress)#</td></tr>
				<tr class=tableheader><td><p>Phone Number: #trim(phonenumber)#</td></tr>
				</table></td></tr></table>
				
				<table class=blank width="100%">
				<tr class=tableheader><th colspan=2><p>Payment Information:</th></tr>
				<tr class=tableheader><td><p>Invoice:</td>
				<td><p>#NewInvoiceNo#</td></tr>
				<cfif #TheCustomer.Active# gt 0>
				<tr class=tableheader><td><p>Customer ##:</td><td><p>#CustomerID#</td></tr></cfif>
				<tr class=tableheader><td><p>CC Number:</td><td><p>xxxxxxxxxxxx#right(trim(arguments.CCNO),4)#&nbsp;</td></tr>
				<tr class=tableheader><td><p>Credit Card Type:</td><td><p>#trim(arguments.cctype)#&nbsp;</td></tr>
				<tr class=tableheader><td><p>Name on Card:</td><td><p>#trim(arguments.cardname)#&nbsp;</td></tr>
				<tr class=tableheader><td><p>Expiration:</td><td><p>#arguments.CCEXPIRE#&nbsp;</td></tr>
				
				</table>
				
				<table class=blank width="100%">
				<tr class=tableheader><th><p>PRODUCT:</th><th><p>QUANTITY:</th><th><p>COST:</th></tr>
				<cfset GrandTotal=0>
				<cfloop query="MyCart">
					<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
						method="GetXMLRecords" returnvariable="getprod">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="products">
						<cfinvokeargument name="IDFieldName" value="ProductID">
						<cfinvokeargument name="IDFieldValue" value="#ProductID#">
					</cfinvoke>
					<cfset ThisPrice=#qtyordered# * #price#>
					<cfset GrandTotal=#GrandTotal# + #ThisPrice#>
					<tr class=tableheader><td><p>#getprod.catalogno#  #ProductName#</td>
					<td style="text-align: center;"><p>#QtyORdered# </td>
					<td style="text-align: right;"><p>#dollarformat(ThisPrice)#  </td></tr>
				
				</cfloop>
				
				<tr class=tableheader><td></td><th class=tableheader><p>Total Items</th><th style="text-align: right;" class=tableheader><p>#dollarformat(GrandTotal)#</th></tr>
				<tr class=tableheader><td></td><th class=tableheader><p>Sales Tax</th><th style="text-align: right;" class=tableheader><p><cfif #myCartHeader.salestax# neq "none">#dollarformat(MyCartHeader.salestax)#<cfelse>$0.00</cfif></th></tr>
				<tr class=tableheader><td></td><th><p>Shipping</th><th style="text-align: right;" class=tableheader><p><cfif #myCartHeader.ShippingAmt# neq "none">#dollarformat(MyCartHeader.shippingamt)#<cfelse>$0.00</cfif></th></tr>
				<tr class=tableheader><td></td><th><p>Gift Wrap</th><th style="text-align: right;" class=tableheader>$0.00</th></tr>
				<cfif #myCartHeader.ShippingAmt# neq "none"><cfset ShippingAmt=#myCartHeader.ShippingAmt#><cfelse><cfset ShippingAmt=0></cfif>
				<cfif #myCartHeader.salestax# neq "none"><cfset ShippingAmt=#myCartHeader.salestax#><cfelse><cfset salestax=0></cfif>
				<cfset GrandTotal=#GrandTotal# + #myCartHeader.ShippingAmt# +  #myCartHeader.salestax# + 3.5>
				<cfif #trim(myCartHeader.discountCoupon)# neq "">
					<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
						method="GetXMLRecords" returnvariable="AllCoupons">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="coupons">
					</cfinvoke>
					<Cfif Allcoupons.recordcount gt 0>
						<cfquery name="ThisCoupon" dbtype="query">
							select couponamount from AllCoupons where couponcode='#trim(myCartHeader.discountcoupon)#'
						</cfquery>
					<cfelse>
						<cfset thiscoupon.recordcount=0>
					</cfif>
					<cfif #thisCoupon.recordcount# gt 0>
						<cfset thisDiscount=GrandTotal * (Thiscoupon.couponamount / 100)>
						<cfset thisDiscount=round(thisDiscount * 100) / 100>
						<cfset GrandTotal=Grandtotal - thisDiscount>
						
						<tr class=tableheader><td></td><th>Discount Coupon</th><th style="text-align: right;">#dollarformat(Thiscoupon.couponamount/100)#</th></tr>
					</cfif>
				</cfif>
				
				<cfif #trim(myCartHeader.giftCertificate)# neq "">
					<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
						method="GetXMLRecords" returnvariable="AllCertificates">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="giftcertificates">
					</cfinvoke>
					<Cfif #allcertificates.recordcount# gt 0>
						<cfquery name="ThisCertificate" dbtype="query">
							select Amount from AllCertificates where articleID='#trim(myCartHeader.giftCertificate)#'
						</cfquery>
					<cfelse>
						<cfset thiscertificate.recordcount=0>
					</cfif>
					<cfif #ThisCertificate.recordcount# gt 0>
						<cfset GrandTotal=Grandtotal - ThisCertificate.Amount>
						
						<tr class=tableheader><td></td><th>Gift Certificate</th><th style="text-align: right;">#dollarformat(ThisCertificate.Amount)#</th></tr>
					</cfif>
				</cfif>
				<tr class=tableheader><td></td><th><p>Grand Total</th><th style="text-align: right;"><p>#dollarformat(GrandTotal)#</th></tr>
				</table>
				<br>
				<p>Please feel free to add any comments below that you would like us to see.</p>
				
				<p>Customer Comments: #MyCartHeader.Comments#</p>
				
				</cfmail>
				<Cfif isdefined('iNet_Result')>
				<cfset Authorization="#iNet_Result#">
				<cfelse>
				<cfset Authorization="#ErrMess#">
				</cfif>
				<cfset ProcessedGood=0>
				
			<!--- PROCESS GOOD RESPONCE --->
			<cfelseif ProcessedGood eq 1>
					<cfset Authorization=#iNet_Auth#>
					<cfset ProcessedGood=1>
					<cfinvoke method="CreateInvoice" returnvariable="InvoiceID">
						<cfinvokeargument name="CartID" value="#cartID#">
						<cfinvokeargument name="Authorization" value="#authorization#">
					</cfinvoke>
					<cfinvoke method="MailInvoice" returnvariable="InvoiceID">
						<cfinvokeargument name="INvoiceID" value="#INvoiceID#">
					</cfinvoke>
			</cfif>
		
		<cfelse>
			<cfset ProcessedGood=1>
			<cfset Authorization="COD">
			<cfinvoke method="FinalCartHeaderUpdate">
				<cfinvokeargument name="ccno" value="#arguments.ccno#">
				<cfinvokeargument name="cctype" value="#arguments.cctype#">
				<cfinvokeargument name="cardname" value="#arguments.ccno#">
				<cfinvokeargument name="ccexpire" value="#arguments.ccexpire#">
				<cfinvokeargument name="CustomerID" value="#CustomerID#">
			</cfinvoke>
			<cfinvoke method="CreateInvoice" returnvariable="InvoiceID">
				<cfinvokeargument name="CartID" value="#arguments.cartID#">
				<cfinvokeargument name="Authorization" value="#authoriztion#">
			</cfinvoke>
			<cfinvoke method="MailInvoice" returnvariable="InvoiceID">
				<cfinvokeargument name="INvoiceID" value="#INvoiceID#">
			</cfinvoke>
		</cfif>
		
		<CFSET newRow=QueryAddRow(processing, 1)>
		<CFSET temp=QuerySetCell(processing,"Status",#ProcessedGood#, #newRow#)>
		<CFSET temp=QuerySetCell(processing,"Authorization",#Authorization#, #newRow#)>

		<cfreturn processing>
	</cffunction>
	
	<cffunction name="CouponsCertificatesTaxes" access="remote" returntype="query" output="true">
		<cfargument name="discountcode" required="true" type="string">
		<cfargument name="certificatecode" required="true" type="string">
		<Cfargument name="state" required="true" type="string">
		<cfargument name="totalItems" required="true" type="numeric">
		<cfargument name="numberOfItems" required="true" type="numeric">
		
		<cfset results=querynew("discountAmt,certificateAmt,salestaxAmt,giftwrapAmt")>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCoupons">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="coupons">
		</cfinvoke>
		
		<cfif #allcoupons.recordcount# gt 0>
		<cfquery name="ThisCoupon" dbtype="query">
			select couponamount from AllCoupons where couponcode='#trim(arguments.discountcode)#'
		</cfquery>
		<cfelse>
			<cfset ThisCoupon.Recordcount=0>
		</cfif>
		
		<CFSET newRow=QueryAddRow(results, 1)>
		<cfif #thiscoupon.recordcount# gt 0>
			<cfset thisDiscount=#arguments.totalItems# * (Thiscoupon.couponamount / 100)>
			<cfset thisDiscount=round(thisDiscount * 100) / 100>
			<CFSET temp=QuerySetCell(results,"discountAmt",#ThisDiscount#, #newRow#)>
		<cfelse>
			<CFSET temp=QuerySetCell(results,"discountAmt",0, #newRow#)>
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCertificates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="giftcertificates">
		</cfinvoke>
		<cfif #allCertificates.recordcount# gt 0>
			<cfquery name="ThisCertificate" dbtype="query">
				select Amount from AllCertificates where articleID='#trim(arguments.certificatecode)#'
			</cfquery>
		<cfelse>
			<cfset ThisCertificate.recordcount=0>
		</cfif>
		<cfif #ThisCertificate.recordcount# gt 0>
			<CFSET temp=QuerySetCell(results,"certificateAmt",#ThisCertificate.Amount#, #newRow#)>
		<cfelse>
			<CFSET temp=QuerySetCell(results,"certificateAmt",0, #newRow#)>
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
		<cfif #ucase(left(arguments.state,2))# is #ucase(ResellState)#>
			<cfset SalesTAx=(#arguments.TotalItems# * #SalesTaxPercent#) / 100>
			<cfset SalesTAx=round(#salestax#*100)/100>
			<CFSET temp=QuerySetCell(results,"salesTaxAmt",#SalesTAx#, #newRow#)>
		<cfelse>
			<CFSET temp=QuerySetCell(results,"salesTaxAmt",0, #newRow#)>
		</cfif>
		
		<cfif #arguments.numberOfItems# gt 0>
			<cfset giftwrap=#arguments.numberOfItems# * #GiftWrapAmt#>
			<CFSET temp=QuerySetCell(results,"giftwrapAmt",#giftwrap#, #newRow#)>
		<cfelse>
			<CFSET temp=QuerySetCell(results,"giftwrapAmt",0, #newRow#)>
		</cfif>
		<cfreturn results>
	</cffunction>
	
	<cffunction access="remote" name="UpdateCartItem" output="true" returntype="string">
		<cfargument name="NewQuantity" default=0 type="numeric" required="true">
		<cfargument name="ThisPrice" default=0 type="numeric" required="true">
		<cfargument name="CartDetailID" default=0 type="string" required="false">
		<cfargument name="HardwareID" default=0 type="string" required="false">
		<cfargument name="SizeID" default=0 type="string" required="false">
		<cfargument name="MaterialID" default=0 type="string" required="false">
		<cfargument name="ColorID" default=0 type="string" required="false">
		
		<cfset ThisPrice=#Arguments.ThisPrice#>
		<cfset CartDetailID=#Arguments.CartDetailID#>
		<cfset NewQuantity=#Arguments.NewQuantity#>
		<cfset HardwareID=#Arguments.HardwareID#>
		<cfset SizeID=#Arguments.SizeID#>
		<cfset MaterialID=#Arguments.MaterialID#>
		<cfset ColorID=#Arguments.ColorID#>

		<cfif #int(CartDetailID)# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="TheCartDetail">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="IDFieldName" value="CartDetailID">
				<cfinvokeargument name="IDFieldValue" value="#Arguments.CartDetailID#">
			</cfinvoke>
			<Cfoutput query="TheCartDetail">
				<cfset CartDetailID=#CartDetailID#>
				<cfset ThisPrice=#PRICE#>
				<cfset thisStyleID=#styleID#>
				<cfset thisUnitofMeasure=#unitofmeasure#>
				<cfset thisProductID=#ProductID#>
				<cfset thisProductName=#ProductName#>
				<cfset thisCost=#cost#>
			</Cfoutput>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLrecord" returnvariable="CartDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="XMLFields" 
					value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
				<cfinvokeargument name="XMLFieldData" 
				value="#TheCartDetail.CartHdrID#,#ThisPrice#,#thisPRODUCTID#,#thisProductname#,#NewQuantity#,#thisCOST#,#HardwareID#,#SizeID#,#MaterialID#,#ColorID#,#thisStyleID#,#thisUnitOfMeasure#">
				<cfinvokeargument name="XMLIDField" value="CartDetailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.CartDetailID#">
			</cfinvoke>
		</cfif>
		<cfreturn true>
  	</cffunction>
	
	<cffunction name="checklogin" access="remote" returntype="string" output="true">
		<cfargument name="pWord" required="true" type="string">
		<cfargument name="uName" required="true" type="string">
		
		<cfset CustomerID=0>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="LoginExists">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="SelectStatement" value=" where Password='#trim(arguments.pWord)#' and username='#trim(arguments.uName)#'">
		</cfinvoke>
		
		<cfif #LoginExists.recordcount# is 1>
			<cfset session.customerid=#loginExists.CustomerID#>
			<cfset customerid=#loginExists.CustomerID#>
		</cfif>
		
		<cfreturn CustomerID>
	</cffunction>
	
	<cffunction name="GetSalesTax" access="remote" output="true" returntype="string">
		<cfargument name="State" required="true" type="string">
		<cfargument name="totalItems" required="true" type="string">
		
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
		
		<cfif #trim(arguments.state)# is #trim(ResellState)#>
			<cfset tTax=#arguments.totalItems# * (#SalesTaxPercent# / 100)>
			<cfset tTax=(round(tTax * 100)) / 100>
		<cfelse>
			<cfset tTax=0>
		</cfif>
		<cfreturn tTax>
	</cffunction>
	
	<cffunction name="getCustomerID" output="true" access="remote" returntype="string">
		<cfif isdefined('session.customerid')>
			<cfset customerid=session.customerid>
		<cfelse>
			<cfset session.customerid=0>
			<cfset customerid=0>
		</cfif>
		<cfreturn customerid>
	</cffunction>
</cfcomponent>