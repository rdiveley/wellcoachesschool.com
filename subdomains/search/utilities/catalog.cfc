<cfcomponent>

	<cffunction name="GetCategoryName" access="remote" returntype="string" output="true">
		<cfargument name="CategoryID" default="" required="true" type="numeric">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="ProductCategories">
			<cfinvokeargument name="FieldName" value="CAtegoryname">
			<cfinvokeargument name="IDFieldName" value="CategoryID">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.CategoryID#">
		</cfinvoke>
		<cfreturn Fieldname>
	</cffunction>

	<cffunction name="GetProductNamebyCatalogno" access="remote" returntype="string" output="true">
		<cfargument name="Catalogno" default="" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="ProductName">
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
		<cfset Today=dateformat(now(),"mm/dd/yyyy")>
		<cfset Tomorrow=dateadd("d",1,now())>
		<cfset WhereStatement="where  ((SaleStarts = '#dateformat(Today)#') OR (SaleEnds = '#dateformat(Today)#')">
		<cfset WhereStatement="#WhereStatement# OR (('#dateformat(Today)#' > SaleStarts) AND ('#dateformat(Today)#' < SaleEnds)))">
		<cfset WhereStatement="#WhereStatement# and onsale=1 ">
		<cfset OrderByStatement="order by products.VendorID,products.catalogno">
		
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
			<cfinvokeargument name="TableName" value="styles">
			<cfinvokeargument name="FieldName" value="styledescription">
			<cfinvokeargument name="IDFieldName" value="productid">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.ProductID#">
		</cfinvoke>
		<cfreturn #Fieldname#>
  	</cffunction>
  
  	<cffunction access="remote" name="GetImage" output="true" returntype="string">
  		<cfargument name="TheImage" type="numeric" required="true" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="productimages">
			<cfinvokeargument name="FieldName" value="imagename">
			<cfinvokeargument name="IDFieldName" value="imageid">
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
  
  	<cffunction access="remote" name="DeleteFromCart" output="false">
		<cfargument name="CartDetailID" type="numeric" required="true" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="DeleteXMLrecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="XMLFields" value="CartDetailID,CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
			<cfinvokeargument name="XMLIDField" value="CartDetailID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.CartDetailID#">
		</cfinvoke>
  	</cffunction>
	
	<cffunction access="remote" name="DeleteCart" output="false">
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
		
		<cfif #CartDetailID# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLrecord" returnvariable="CartDetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartdtl">
				<cfinvokeargument name="XMLFields" 
					value="CARTHDRID,PRICE,PRODUCTID,PRODUCTNAME,QTYORDERED,COST,HardwareID,SizeID,MaterialID,ColorID,StyleID,UnitOfMeasure">
				<cfinvokeargument name="XMLFieldData" 
				value="#arguments.cartID#,#arguments.ThisPrice#,#arguments.thisProductID#,#arguments.Productname#,#arguments.NewQuantity#,#arguments.COST#,#arguments.HardwareID#,#arguments.SizeID#,#arguments.MaterialID#,#arguments.ColorID#,#arguments.StyleID#,#arguments.UnitOfMeasure#">
				<cfinvokeargument name="XMLIDField" value="CartDetailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.CartDetailID#">
			</cfinvoke>
		</cfif>
	</cffunction>
	
  	<cffunction access="remote" name="UpdateQuantity" output="true">
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
			<cfinvokeargument name="FileName" value="CartDtl">
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
			<cfset ProductName=#productName#>
			<cfset Cost=#cost#>
		</cfoutput>

		<cfif #CartDetailID# neq 0>
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
						<cfset NewQuantity=#NewQuantity# + #QTYORDERED#>
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
  	</cffunction>
  
  	<cffunction access="remote" name="AddNewCart" output="true" returntype="numeric">
  		<cfset ExpirationDate = dateformat(dateadd("d",+3,now()),"mm/dd/yyyy")>
		<cfset Today = dateformat(now(),"mm/dd/yyyy")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
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
		
		<cfif #OldCartID# is 0>
			<cfinvoke method="AddNewCart" returnvariable="CartID"></cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="CheckCart">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="cartHDR">
				<cfinvokeargument name="SelectStatement" value=" where CartID='#Arguments.cartid#'"/>
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
			<cfset UnitOfMeasure = ListGetAt(#UnitIDs#,#ListCount#)>
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
			<cfinvokeargument name="FromStatement" value="from CartHdr ">
			<cfinvokeargument name="SelectStatement" value="WHERE ExpireDate < #arguments.Today#">
		</cfinvoke>
	
		<CFLOOP query="tDumpCart">
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="DeleteARecord">
				<cfinvokeargument name="TableName" value="CartDtl">
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
		<cfquery name="GetCatalogueItems" dbtype="query">
			select * from GetAllProducts
			where categoryid='#arguments.categoryID#' 
			<cfif #Selectstatement# neq ''>
			#preservesinglequotes(selectstatement)#
			order by categoryid, productname
			<cfelse>
			order by productname
			</cfif>
			
		</cfquery>
		
		<cfreturn GetCatalog>
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
			<cfinvokeargument name="IDFieldname" value="CartID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.CartID#">
		</cfinvoke>
		<cfreturn ShoppingCart>
	</cffunction>
	
	<cffunction name="GetCartDetail" output="true" returntype="query" access="remote">
		<cfargument name="CartID" required="true" type="numeric" default="0">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="CartDetail">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="cartdtl">
			<cfinvokeargument name="IDFieldname" value="CartHdrID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.CartID#">
		</cfinvoke>
		
		<cfreturn CartDetail>
	</cffunction>
	
	<cffunction name="ShippingConfiguration" access="remote" returntype="query" output="true">
		select * from ShippingConfig
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
			<cfinvokeargument name="ThisFileName" value="CartHdr">
			<cfinvokeargument name="IDFieldName" value="CartID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.CartID#">
		</cfinvoke>
		
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">

		<CFSET FieldValues = "#arguments.billingaddressid#,#theCart.comments# ,#thecart.createdate#,#arguments.customerid#,#thecart.DAteShipped#,#theCart.expiredate# ,#thecart.giftwrap# ,#thecart.purchaseorder# ,#thecart.salestax# ,#arguments.shippingaddressid# ,#theCart.shippingamt# ,#thecart.shippingmethod# ,#theCart.shippingtype# ,#theCart.storelocation# ,#TheCart.affiliateID# ,#theCart.Paymentmethod# ,#theCart.discountCoupon# ,#theCart.discountAmt# ,#theCart.giftCertificate# ,#theCart.giftCertAmt# ,#theCart.BankRountingNo# ,#theCart.BankAcctNo# ,#theCart.BankCheckNo#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#CartID#">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="UpdateCartShipping" access="remote" output="true">
		<cfargument name="CartID" type="numeric" default="0" required="true">
		<cfargument name="ShippingAmt" type="numeric" default="0" required="true">
		<cfargument name="ShippingMethod" type="string" default="0" required="true">
		<cfargument name="SalesTax" type="numeric" default="0" required="true">
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
			<cfinvokeargument name="ThisFileName" value="CartHdr">
			<cfinvokeargument name="IDFieldName" value="CartID">
			<cfinvokeargument name="IDFieldValue" value="#arguments.CartID#">
		</cfinvoke>
		
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateid,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">
		<CFSET FieldValues = "#thecart.billingaddressid#,#theCart.comments# ,#thecart.createdate#,#arguments.customerid#,#thecart.DAteShipped#,#theCart.expiredate# ,#thecart.giftwrap# ,#thecart.purchaseorder# ,#arguments.salestax# ,#thecart.shippingaddressid#,#arguments.shippingamt# ,#arguments.shippingmethod# ,#theCart.shippingtype# ,#theCart.storelocation# ,#theCart.affiliateid# ,#arguments.Paymentmethod# ,#arguments.discountCoupon# ,#arguments.discountAmt# ,#arguments.giftCertificate# ,#arguments.giftCertAmt# ,#arguments.BankRountingNo# ,#arguments.BankAcctNo# ,#arguments.BankCheckNo# ">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="CartHdr">
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
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,resellerstate,resellernumber">
		<CFSET FieldValues = "#arguments.CardName# ,#theCustomer.active#,#arguments.CCExpire# ,#arguments.CCNo# ,#arguments.CCType# ,#theCustomer.OnMailList# ,#theCustomer.startdate#,#theCustomer.firstname#,#theCustomer.lastname#,#arguments.username#,#arguments.password#,#theCustomer.AffiliateID# ,#theCustomer.resellerstate# ,#theCustomer.resellernumber# ">

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
		<cfargument name="CartID" type="numeric" default="0" required="true">
		<cfargument name="comments" type="string" default="" required="true">
		<cfargument name="PurchaseOrder" type="string" default="" required="true">
		
		<cfif #Arguments.PurchaseORder# is "">
			<cfset PurchaseOrder="none">
		<cfelse>
			<cfset PurchaseOrder=#arguments.PurchaseOrder#>
		</cfif>
		<cfinvoke method="GetCartHeader" returnvariable="TheCart">
			<cfinvokeargument name="CartID" value="#Arguments.CartID#">
		</cfinvoke>
		<cfset comments=replace(#arguments.comments#,",","~","ALL")>
		<CFSET FieldList = "BILLINGADDRESSID,COMMENTS,CREATEDATE,CUSTOMERID,DAteShipped,EXPIREDATE,GIFTWRAP,PURCHASEORDER,SALESTAX,SHIPPINGADDRESSID,SHIPPINGAMT,SHIPPINGMETHOD,SHIPPINGTYPE,STORELOCATION,affiliateID,Paymentmethod,discountCoupon,discountAmt,giftCertificate,giftCertAmt,BankRountingNo,BankAcctNo,BankCheckNo">
		<CFSET FieldValues = "#thecart.billingaddressid#,#comments#,#thecart.createdate#,#TheCart.customerid#,#thecart.DAteShipped#,#theCart.expiredate# ,#thecart.giftwrap# ,#purchaseorder# ,#TheCart.salestax# ,#thecart.shippingaddressid#,#TheCart.shippingamt# ,#TheCart.shippingmethod# ,#theCart.shippingtype# ,#theCart.storelocation# ,#thecart.affiliateid# ,#TheCart.Paymentmethod# ,#TheCart.discountCoupon# ,#TheCart.discountAmt# ,#TheCart.giftCertificate# ,#TheCart.giftCertAmt# ,#TheCart.BankRountingNo# ,#TheCart.BankAcctNo# ,#TheCart.BankCheckNo# ">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="carthdr">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="CartID">
			<cfinvokeargument name="XMLIDValue" value="#CartID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="CreateInvoice" access="remote" output="true" returntype="numeric">
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
		<CFSET FieldValues = "#Cart.billingaddressid#,#Cart.comments#,#Cart.createdate#,#Cart.customerid#, ,#Cart.expiredate#,#Cart.giftwrap#,#Cart.purchaseorder#,#Cart.salestax#,#Cart.shippingaddressid#,#Cart.shippingamt#,#Cart.shippingmethod#,#Cart.shippingtype#,#Cart.storelocation#,#Cart.affiliateID#,#Cart.Paymentmethod#,#Cart.discountCoupon#,#Cart.discountAmt#,#Cart.giftCertificate#,#cart.giftCertAmt#,#Cart.BankRountingNo#,#Cart.BankAcctNo#,#Cart.BankCheckNo#, ,0, , , ,#timeformat(now())#,#arguments.authorization# ,#cart.dateshipped#,0">

		
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
		</cfoutput>
		<cfinvoke method="DeleteCart">
			<cfinvokeargument name="CartID" value="#arguments.cartid#">
		</cfinvoke>
		
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
		<cfinvoke component="" method="GetInvoiceDetail" returnvariable="InvoiceDetail">
			<cfinvokeargument name="InvoiceNo" value="#arguments.INvoiceID#">
		</cfinvoke> 
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="getCustomer" returnvariable="Customer">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
		</cfinvoke> 
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="GetCustomerAddress" returnvariable="BillingAddress">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="AddressTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="GetCustomerAddress" returnvariable="ShippingAddress">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="AddressTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="GetCustomerPhone" returnvariable="Phone">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="PhoneTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.customersXML" 
			method="GetCustomerEmail" returnvariable="Email">
			<cfinvokeargument name="CustomerID" value="#InvoiceHeader.CustomerID#">
			<cfinvokeargument name="EmailTypeID" value="1">	
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.stylesheet" 
			method="GetStyleSheet" returnvariable="StyleSheet">
			<cfinvokeargument name="StyleSheetID" value="0000000001">
		</cfinvoke>
			
		<cftry>
		<cfmail to="#Trim(Email.emailaddress)#" from="#Application.Email#"  subject="#application.websitename# Invoice #arguments.InvoiceID#"
        bcc="jamie@kotw.net" type="HTML">
		
		
		<table class=blank width="100%"><tr>
		<td valign=top><table class=blank width="100%">
		<tr class=tableheader><th>Billing Address:</th></tr>
		<tr class=tableheader><td>#Customer.firstname# #customer.lastname#</td></tr>
		<tr class=tableheader><td>#trim(billingaddress.address1)# #trim(billingaddress.address2)#</td>
		</tr>
		<tr class=tableheader><td>#trim(billingaddress.city)# #trim(billingaddress.state)# #trim(billingaddress.postalcode)#</td></tr>
		<tr class=tableheader><td>#trim(billingaddress.country)#</td></tr></table>
		</td><td valign=top>
		<table class=blank width="100%"><tr class=tableheader><th>Shipping Address:</th></tr>
		<tr class=tableheader><td>#trim(ShippingAddress.address1)# #trim(ShippingAddress.address2)#</td>
		</tr>
		<tr class=tableheader><td>#trim(ShippingAddress.city)# #trim(ShippingAddress.state)# #trim(ShippingAddress.postalcode)#</td></tr>
		<tr class=tableheader><td>#trim(ShippingAddress.country)#</td></tr>
		<tr class=tableheader><td>Email Address: #trim(Email.emailaddress)#</td></tr>
		<tr class=tableheader><td>Phone Number: #trim(Phone.phonenumber)#</td></tr>
		</table></td></tr></table>
		
		<table class=blank width="100%">
		<tr class=tableheader><th colspan=2>Payment Information:</th></tr>
		<tr class=tableheader><td>Web Invoice Number:</td><td>#trim(InvoiceHeader.invoice)#&nbsp;</td></tr>
		<tr class=tableheader><td>Date Ordered:</td><td>#dateformat(today,"mm/dd/yyyy")#&nbsp;</td></tr>
		<tr class=tableheader><td>Purchase Order Number:</td>
		<td>#trim(InvoiceHeader.purchaseorder)#&nbsp;</td></tr>
		<cfif #Customer.Active# gt 0>
		<tr class=tableheader><td>Customer ##:</td><td>#Customer.CustomerID#</td></tr>
		<cfelse>
		<tr class=tableheader><td>CC Number:</td><td>#trim(InvoiceHeader.CCNO)#&nbsp;</td></tr>
		<tr class=tableheader><td>Credit Card Type:</td><td>#trim(InvoiceHeader.cctype)#&nbsp;</td></tr>
		<tr class=tableheader><td>Name on Card:</td><td>#trim(InvoiceHeader.cardname)#&nbsp;</td></tr>
		<tr class=tableheader><td>Expiration:</td><td>#InvoiceHeader.CCEXPIRE#&nbsp;</td></tr>
		</cfif>
		</table>
		<cfset GrandTotal=0>
		<table class=blank width="100%">
		<tr class=tableheader><th>PRODUCT:</th><th>QUANTITY:</th><th>COST:</th></tr>
		<cfoutput query="InvoiceDetail">
			<cfset ThisPrice=#Price# * #qtyordered#>
			<cfset GrandTotal=#GrandTotal# + #ThisPrice#>
			<tr class=tableheader><td>#ProductID#  #ProductName#</td>
			<td style="text-align: center;">#QtyOrdered# </td>
			<td style="text-align: right;">#dollarformat(ThisPrice)#  </td></tr>
		
		</cfoutput>
		
		<tr class=tableheader><td></td><th>Total Items</th>
		<th style="text-align: right;">#dollarformat(GrandTotal)#</th></tr>
		<tr class=tableheader><td></td><th>Sales tax</th>
		<th style="text-align: right;">#InvoiceHeader.Salestax#</th></tr>
		<tr class=tableheader><td></td><th>Shipping</th>
		<th style="text-align: right;">#InvoiceHeader.ShippingAmt#</th></tr>
		
		<cfset GrandTotal=#GrandTotal# + #InvoiceHeader.Salestax# + #InvoiceHeader.ShippingAmt#>
		<tr class=tableheader><td></td><th>Grand Total</th>
		<th style="text-align: right;">#dollarformat(GrandTotal)#</th></tr>
		</table>
		<br>
		<p>#InvoiceHeader.Comments#</p>
		</cfmail>
		
		<cfcatch>
			<cfreturn false>
		</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
	
	<cffunction access="remote" name="AddToFavorites" output="true">
		<cfargument name="ProdIDs" default="0" type="string" required="true">

		<cfset Today=dateformat(now(),"mm/dd/yyyy")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="XMLFields" value="ProductID,UserID,DateCreated">
			<cfinvokeargument name="XMLFieldData" 	
				value="#arguments.ProdIDs#,#session.customerid#,#Today#">
			<cfinvokeargument name="XMLIDField" value="FavoriteID">
		</cfinvoke>
	
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
	
</cfcomponent>