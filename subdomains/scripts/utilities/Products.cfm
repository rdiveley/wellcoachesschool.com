<cfparam name="alphabet" default="a">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="Products">
	<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfinclude template="../utilities/GetAllProductThings.cfm">
<cfparam name="searchDescription" default="">
<cfparam name="pProductID" default=0>
<cfparam name="ProductAction" default="List">
<cfparam name="ProductName" default="">
<cfparam name="ProductDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="Price" default="0">
<cfparam name="ProductImage" default="">
<cfparam name="pHardwareID" default=0>
<cfparam name="pSizeID" default=0>
<cfparam name="pMaterialID" default=0>
<cfparam name="pColorID" default=0>
<cfparam name="pTypeID" default=0>
<cfparam name="pCategoryID" default="0">
<cfparam name="pStyleID" default=0>
<cfparam name="CatalogNo" default="">
<cfparam name="MfgNO" default="">
<cfparam name="SaleStarts" default="">
<cfparam name="SaleEnds" default="">
<cfparam name="ONSale" default=0>
<cfparam name="OnHand" default=0>
<cfparam name="Committed" default=0>
<cfparam name="OnOrder" default=0>
<cfparam name="IsGiftPkg" default=0>
<cfparam name="SalePrice" default=0>
<cfparam name="EquivalentProducts" default = 0>
<cfparam name="TEQUIVALENTPRODUCTS" default="0">
<cfparam name="UnitOfMeasure" default=0>
<cfparam name="pVendorID" default=0>
<cfparam name="Specifications" default="">
<cfparam name="Cost" default=0>

<cfif ProductAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Products">
		<cfinvokeargument name="XMLFields" value="ProductID,ProductDescription,ProductName,DateCreated,Price,ProductImage,HardwareID,SizeID,MaterialID,ColorID,TypeID,CategoryID,StyleID,CatalogNo,MfgNO,SaleStarts,SaleEnds,ONSale,OnHand,Committed,OnOrder,IsGiftPkg,SalePrice,EquivalentProducts,UnitOfMeasure,VendorID,Specifications,Cost">
		<cfinvokeargument name="XMLIDField" value="ProductID">
		<cfinvokeargument name="XMLIDValue" value="#pProductID#">
	</cfinvoke>
	<cfset ProductID=0>
	<cfset ProductAction="List">
</cfif>
		
<cfif ProductAction is "Edit">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Products">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Products">
		<cfinvokeargument name="IDFieldName" value="ProductID">
		<cfinvokeargument name="IDFieldValue" value="#pProductID#">
	</cfinvoke>
	<cfoutput query="Products">
		<cfset ProductName=#replace(ProductName,"~",",","ALL")#>
		<cfset DateCreated=#DateCreated#>
		<cfset tProductDescription=#ProductDescription#>
		<cfset ProductDescription=replace(#tProductDescription#,"~",",","ALL")>
		<cfset Price=#Price#>
		<cfset ProductImage=#ProductImage#>
		<cfset pHardwareID=#HardwareID#>
		<cfset pSizeID=#SizeID#>
		<cfset pMaterialID=#MaterialID#>
		<cfset pColorID=#ColorID#>
		<cfset pTypeID=#TypeID#>
		<cfset pCategoryID=#CategoryID#>
		<cfset pStyleID=#StyleID#>
		<cfset CatalogNo=#CatalogNo#>
		<cfset MfgNO=#MfgNO#>
		<cfset SaleStarts=#SaleStarts#>
		<cfset SaleEnds=#SaleEnds#>
		<cfset ONSale=#ONSale#>
		<cfset OnHand=#OnHand#>
		<cfset Committed=#Committed#>
		<cfset OnOrder=#OnOrder#>
		<cfset IsGiftPkg=#IsGiftPkg#>
		<cfset SalePrice=#SalePrice#>
		<cfset tEquivalentProducts=#replace(EquivalentProducts,"~",",","ALL")#>
		<cfset UnitOfMeasure=#UnitOfMeasure#>
		<cfset pVendorID=#VendorID#>
		<cfset tSpecifications=#Specifications#>
		<cfset Specifications=replace(#tSpecifications#,"~",",","ALL")>
		<cfset Cost=#Cost#>
	</cfoutput>
	<cfset ProductAction="Update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Products\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.ProductImage="images/Products/#image#">
	</cfif>
	<cfif #form.ProductImage# is ''><cfset form.ProductImage="none"></cfif>
	<cfif #isdate(form.saleends)#>
		<cfset form.saleends=dateformat(form.saleends,"yyyy/mm/dd")></cfif>
	<cfif #isdate(form.SaleStarts)#>
		<cfset form.SaleStarts=dateformat(form.SaleStarts,"yyyy/mm/dd")></cfif>
	<cfif #form.SaleEnds# is ''><cfset form.SaleEnds="none"></cfif>
	<cfif #form.SaleStarts# is ''><cfset form.SaleStarts="none"></cfif>
	<cfif #form.ProductDescription# is ''><cfset form.ProductDescription="none"></cfif>
	<cfset form.ProductDescription=replace(#form.ProductDescription#,",","~","ALL")>
	<cfif #form.ProductName# is ''><cfset form.ProductName="none"></cfif>
	<cfset form.ProductName=replace(#form.ProductName#,",","~","ALL")>
	
	<cfif not isdefined('form.pSizeID')><cfset form.pSizeID="0"></cfif>
	<cfif not isdefined('form.pMaterialID')><cfset form.pMaterialID="0"></cfif>
	<cfif not isdefined('form.pColorID')><cfset form.pColorID="0"></cfif>
	<cfif not isdefined('form.pHardwareID')><cfset form.pHardwareID="0"></cfif>
	<cfif not isdefined('form.pStyleID')><cfset form.pStyleID="0"></cfif>
	<cfif not isdefined('form.EquivalentProducts')><cfset form.EquivalentProducts="0"></cfif>
	
	<cfset form.pSizeID=replace(#form.pSizeID#,",","~","ALL")>
	<cfset form.pMaterialID=replace(#form.pMaterialID#,",","~","ALL")>
	<cfset form.pColorID=replace(#form.pColorID#,",","~","ALL")>
	<cfset form.pHardwareID=replace(#form.pHardwareID#,",","~","ALL")>
	<cfset form.pStyleID=replace(#form.pStyleID#,",","~","ALL")>
	<cfset form.EquivalentProducts=replace(#form.EquivalentProducts#,",","~","ALL")>
	
	<cfif #trim(form.EquivalentProducts)# is ""><cfset form.EquivalentProducts=0></cfif>
	<cfif #trim(form.OnOrder)# is ""><cfset form.OnOrder=0></cfif>
	<cfif #trim(form.OnHand)# is ""><cfset form.OnHand=0></cfif>
	<cfif #trim(form.IsGiftPkg)# is ""><cfset form.IsGiftPkg=0></cfif>
	<cfif #trim(form.Cost)# is ""><cfset form.Cost=0></cfif>
	<cfif #trim(form.SalePrice)# is ""><cfset form.SalePrice=0></cfif>
	<cfif #trim(form.Committed)# is ""><cfset form.Committed=0></cfif>
	<cfif #form.specifications# is ''><cfset form.specifications="none"></cfif>
	<cfset form.specifications=replace(#form.specifications#,",","~","ALL")>
	<cfif #form.mfgno# is ''><cfset form.mfgno="none"></cfif>
	<cfif #form.Catalogno# is ''><cfset form.Catalogno="none"></cfif>

	<cfif #ProductAction# is "Update">
		<cfif #form.Datecreated# is ""><cfset form.datecreated=dateformat(now(),"yyyy/mm/dd")></cfif>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="XMLFields" value="ProductDescription,ProductName,DateCreated,Price,ProductImage,HardwareID,SizeID,MaterialID,ColorID,TypeID,CategoryID,StyleID,CatalogNo,MfgNO,SaleStarts,SaleEnds,ONSale,OnHand,Committed,OnOrder,IsGiftPkg,SalePrice,EquivalentProducts,UnitOfMeasure,VendorID,Specifications,Cost">
			
			<cfinvokeargument name="XMLFieldData" value="#form.ProductDescription#,#form.ProductName#,#form.DateCreated#,#form.Price#,#form.ProductImage#,#form.pHardwareID#,#form.pSizeID#,#form.pMaterialID#,#form.pColorID#,#form.pTypeID#,#form.pCategoryID#,#form.pStyleID#,#form.CatalogNo#,#form.MfgNO#,#form.SaleStarts#,#form.SaleEnds#,#form.ONSale#,#form.OnHand#,#form.Committed#,#form.OnOrder#,#form.IsGiftPkg#,#form.SalePrice#,#form.EquivalentProducts#,#form.UnitOfMeasure#,#form.pVendorID#,#form.Specifications#,#form.Cost#">
			<cfinvokeargument name="XMLIDField" value="ProductID">
			<cfinvokeargument name="XMLIDValue" value="#pProductID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Products">
			<cfinvokeargument name="XMLFields" value="ProductDescription,ProductName,DateCreated,Price,ProductImage,HardwareID,SizeID,MaterialID,ColorID,TypeID,CategoryID,StyleID,CatalogNo,MfgNO,SaleStarts,SaleEnds,ONSale,OnHand,Committed,OnOrder,IsGiftPkg,SalePrice,EquivalentProducts,UnitOfMeasure,VendorID,Specifications,Cost">
			<cfinvokeargument name="XMLFieldData" value="#form.ProductDescription#,#form.ProductName#,#form.DateCreated#,#form.Price#,#form.ProductImage#,#form.pHardwareID#,#form.pSizeID#,#form.pMaterialID#,#form.pColorID#,#form.pTypeID#,#form.pCategoryID#,#form.pStyleID#,#form.CatalogNo#,#form.MfgNO#,#form.SaleStarts#,#form.SaleEnds#,#form.ONSale#,#form.OnHand#,#form.Committed#,#form.OnOrder#,#form.IsGiftPkg#,#form.SalePrice#,#form.EquivalentProducts#,#form.UnitOfMeasure#,#form.pVendorID#,#form.Specifications#,#form.Cost#">
			<cfinvokeargument name="XMLIDField" value="ProductID">
		</cfinvoke>
	</cfif>
	<cfset ProductAction="list">
	<cfset ProductName="">
	<cfset DateCreated = #now()#>
	<cfset pProductID = 0>
	<cfset ProductDescription=''>
	<cfset ProductName=#ProductName#>
	<cfset Price='0'>
	<cfset ProductImage=''>
	<cfset HardwareID = 0>
	<cfset pSizeID = 0>
	<cfset pMaterialID = 0>
	<cfset pColorID = 0>
	<cfset pTypeID = 0>
	<cfset pCategoryID = 0>
	<cfset pStyleID = 0>
	<cfset CatalogNo=''>
	<cfset MfgNO=''>
	<cfset SaleStarts=''>
	<cfset SaleEnds=''>
	<cfset ONSale = 0>
	<cfset OnHand = 0>
	<cfset Committed = 0>
	<cfset OnOrder = 0>
	<cfset IsGiftPkg = 0>
	<cfset SalePrice = 0>
	<cfset tEquivalentProducts = 0>
	<cfset UnitOfMeasure = 0>
	<cfset VendorID = 0>
	<cfset Specifications=''>
	<cfset Cost = 0>
</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllTheProducts">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Products">
	<cfinvokeargument name="OrderByStatement" value=" order by productname">
</cfinvoke>

<cfif #AllTheProducts.recordcount# neq 0>
	<cfquery name="AllProducts" dbtype="query">
		select * from AllTheProducts 
		<Cfif #Alphabet# neq "all" and #SearchDescription# is "">
		where (ProductName like '#ucase(left(alphabet,1))#%' 
		or ProductName like '#lcase(left(alphabet,1))#%')
		<cfelseif #SearchDescription# neq "">
		where productName like '%#SearchDescription#%' or catalogno like '%#ucase(searchDescription)#%'
		</cfif>
	</cfquery>
	
	<cfquery name="Equivalents" dbtype="query">
		select * from AllTheProducts 
		order by catalogno
	</cfquery>
<cfelse>
	<cfset AllProducts=querynew("empty")>
	<cfset Equivalents=querynew("empty")>
</cfif>
<cfoutput>
<h1>Products</h1>
<cfoutput><a href= "adminheader.cfm?ProductAction=Add&action=#action#">Add A New Product</a></cfoutput>
<cfif ProductAction is "Update" or #ProductAction# is "Add">
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="pProductID" value="#pProductID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ProductAction" value="#ProductAction#">
<cfset tProductImage=replace(#productImage#,"images/","images/products/")>
<cfset tProductImage=replace(#productImage#,"p/","images/products/")>
<input type="hidden" name="ProductImage" value="#tProductImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<input type="hidden" name="alphabet" value="#alphabet#">
<TABLE>

	<TR>
	<TD valign="top"> Product Name: </TD>
    <TD>
	
		<INPUT type="text" name="ProductName" value="#ProductName#" size=40 >
		
	</TD>
	<TD valign="top"> Upload Product Image: </TD>
    <TD>
		<input type="file" name="image"><br><strong>#replacenocase(ProductImage,"images/products/","")#</strong>

		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Manufacturers ##: </TD>
    <TD>
	
		<INPUT type="text" name="MfgNO" value="#MfgNO#" size=25 maxLength="125">
		
	</TD>
	<TD valign="top"> Catalog ##: </TD>
    <TD>
	
		<INPUT type="text" name="CatalogNo" value="#CatalogNo#" size=25 maxLength="125">
		
	</TD>
	</TR>
	<tr>
	<td valign=top> Price </td>
	<td><input type="text" value="#Price#" name="Price"></td>
	<td valign=top> Additional HTML file to include on product specifications page </td>
	<td><input type="text" value="#Cost#" name="Cost"></td>
	</tr>
	
	<tr>
	<td valign=top> Is This Item Onsale? </td>
	<td><select name="OnSale">
		<option value="0" <cfif #OnSale# is 0>selected</cfif>>No
		<option value="1" <cfif #OnSale# is 1>selected</cfif>>Yes
		</select></td>
	<td valign=top> Sale Price </td>
	<td><input type="text" value="#SalePrice#" name="SalePrice"></td>
	</tr>
	<tr>
	<td valign=top> Sale Starts: </td>
	<td><input type="text" value="#SaleStarts#" name="SaleStarts"> (i.e. mm/dd/yyyy)</td>
	<td valign=top> Sale Ends: </td>
	<td><input type="text" value="#SaleEnds#" name="SaleEnds"> (i.e. mm/dd/yyyy)</td>
	</tr>

	<tr>
	<td valign=top> Is This a Gift Pkg? </td>
	<td><select name="IsGiftPkg">
		<option value="0" <cfif #IsGiftPkg# is 0>selected</cfif>>No
		<option value="1" <cfif #IsGiftPkg# is 1>selected</cfif>>Yes
		</select></td>
	<td valign=top> On Hand </td>
	<td><input type="text" value="#OnHand#" name="OnHand"></td>
	</tr>
	<tr>
	<td valign=top> No of days of supply </td>
	<td><input type="text" value="#OnOrder#" name="OnOrder"></td>
	<td valign=top> Re-order lead days </td>
	<td><input type="text" value="#Committed#" name="Committed"></td>
	</tr>
	
	<tr>
	<td valign=top> Product Type </td>
	<td><select name="pTypeID">
		<option value="0" <cfif #pTypeID# is 0>selected</cfif>>None</option>
		<cfloop query="AllTypes">
			<option value="#AllTypes.TypeID#" <cfif #pTypeID# is #AllTypes.TypeID#>selected</cfif>>#TypeName#</option>
		</cfloop>
	</select>
	</td>
	<td valign=top> Product Category </td>
	<td><select name="pCategoryID">
		<option value="0" <cfif #pCategoryID# is 0>selected</cfif>>None</option>
		<cfloop query="AllCAtegories">
			<option value="#AllCAtegories.CategoryID#" <cfif #pCategoryID# is #AllCAtegories.CategoryID#>selected</cfif>>#CategoryName#</option>
		</cfloop>
	</select>
	</td>
	</tr>
	<tr>
	<td valign=top> Product Vendor </td>
	<td><select name="pVendorID">
		<option value="0" <cfif #pVendorID# is 0>selected</cfif>>None</option>
		<cfloop query="AllVendors">
			<option value="#AllVendors.VendorID#" <cfif #pVendorID# is #AllVendors.VendorID#>selected</cfif>>#VendorName#</option>
		</cfloop>
	</select>
	</td>
	<td valign=top> Product Unit of Measure </td>
	<td><select name="UnitOfMeasure">
		<option value="0" <cfif #UnitOfMeasure# is 0>selected</cfif>>None</option>
		<cfloop query="AllUnits">
			<option value="#UnitID#" <cfif #UnitID# is #UnitOfMeasure#>selected</cfif>>#UnitName#</option>
		</cfloop>
	</select>
	</td>
	</tr>

	
	<tr>
	<td valign=top> Product Sizes </td>
	<td><select name="pSizeID" size="5" multiple>
		<option value="0" <cfif #ListFind(pSizeID,0,"~")#>selected</cfif>>None</option>
		<cfloop query="AllSizes">
			<option value="#AllSizes.SizeID#" <cfif #ListFind(pSizeID,AllSizes.SizeID,"~")#>selected</cfif>>#SizeName#</option>
		</cfloop>
	</select>
	</td>
	<td valign=top> Product Colors </td>
	<td><select name="pColorID" size="5" multiple>
		<option value="0" <cfif #ListFind(pColorID,0,"~")#>selected</cfif>>None</option>
		<cfloop query="AllColors">
			<option value="#AllColors.ColorID#" <cfif #ListFind(pColorID,AllColors.ColorID,"~")#>selected</cfif>>#ColorName#</option>
		</cfloop>
	</select>
	</td>
	</tr>
	<tr>
	<td valign=top> Product Hardware </td>
	<td><select name="pHardwareID" size="5" multiple>
		<option value="0" <cfif #ListFind(pHardwareID,0,"~")#>selected</cfif>>None</option>
		<cfloop query="AllHardware">
			<option value="#AllHardware.HardwareID#" <cfif #ListFind(pHardwareID,AllHardware.HardwareID,"~")#>selected</cfif>>#HardwareName#</option>
		</cfloop>
	</select>
	</td>
	<td valign=top> Product Materials </td>
	<td><select name="pMaterialID" size="5" multiple>
		<option value="0" <cfif #ListFind(pMaterialID,0,"~")#>selected</cfif>>None</option>
		<cfloop query="AllMaterials">
			<option value="#AllMaterials.MaterialID#" <cfif #ListFind(pMaterialID,AllMaterials.MaterialID,"~")#>selected</cfif>>#MaterialName#</option>
		</cfloop>
	</select>
	</td>
	</tr>
	<tr>
	<td valign=top> Product Weight </td>
	<td valign=top><input type="text" name="pStyleID" size="25" value="#pStyleID#">
	</td>
	<td valign=top> Equivalent Products</td>
	<td><select name="EquivalentProducts" size="5" multiple>
		<option value="0" <cfif #ListFind(tEquivalentProducts,0)#>selected</cfif>>None</option>
		<cfloop query="Equivalents">
			 <cfif #ListFind(tEquivalentProducts,trim(Equivalents.ProductID))#>
			<option value="#trim(Equivalents.ProductID)#" selected>#catalogno#-#left(ProductName,25)#</option>
			<cfelseif #tEquivalentProducts# is #trim(equivalents.ProductID)#>
			<option value="#trim(Equivalents.ProductID)#" selected>#catalogno#-#left(ProductName,25)#</option>
			<cfelse>
			<option value="#trim(Equivalents.ProductID)#">#catalogno#-#left(ProductName,25)#</option>
			</cfif>
		</cfloop>
	</select>
	</td>
	</tr>
	
	<TR>
	<TD valign="top"> Product Short Description: </TD>
    <TD colspan=3>
	
		<TEXTAREA name="ProductDescription" cols=50 rows=5>#ProductDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
		<TR>
	<TD valign="top"> Product Long Description (specifications): </TD>
    <TD colspan=3>
		<a href="javascript:GetEditor('thisform','Specifications')" class=box>Click here for the editor</a><br>
		<TEXTAREA name="Specifications" cols=100 rows=10>#Specifications#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM></cfif>
</CFOUTPUT>
	

<cfif #TheFileExists# is "true" and #ProductAction# is "List">
<cfoutput>
<form action="adminheader.cfm?Action=products&LID=0&alphabet=all" method="post" name="searchform">
<p><font color="##000000">Search For A Product by name or catalog ## <input type="text" name="searchDescription"><input type="submit" name="searchSubmit" value="GO"> (this is case sensitive)<br>or click on the appropriate alphbetical character</font>
</form>
or <a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=all">Click Here</a> to see them all<br>
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=1">1</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=2">2</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=3">3</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=4">4</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=5">5</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=6">6</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=7">7</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=8">8</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=9">9</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=0">0</a> |
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
<a href="adminheader.cfm?Action=#action#&LID=#LID#&alphabet=z">Z</a></p></cfoutput>

<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Products</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Category</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	<cf_nextrecords Records="#AllProducts.RecordCount#"
			 ThisPageName="adminheader.cfm"
			 RecordsToDisplay="25"
			 DisplayText="Record"
			 DisplayFont="Arial"
			 FontSize=2
			 UseBold="Yes"
			 ExtraURL="&action=#action#&alphabet=#alphabet#">
<cfoutput query="AllProducts" StartRow=#SR# MaxRows=25>

<tr>
<td><p>#int(ProductID)#</p></td>
<td><p>#catalogno# - #ProductName#</p></td>
<td><p>#categoryid#</p></td>
<td><p><img src="../#ProductImage#"></p></td>

<td><a href= "adminheader.cfm?pProductID=#trim(ProductID)#&ProductAction=Edit&action=#action#&alphabet=#alphabet#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?pProductID=#ProductID#&ProductAction=Delete&action=#action#&alphabet=#alphabet#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

