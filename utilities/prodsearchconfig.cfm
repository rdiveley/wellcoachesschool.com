
<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="ProdSearchParams">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfparam name="ProductFields" default='0'>
<cfparam name="SearchFormText" default='none'>
<cfparam name="SaveSearchParams" default='No'>
<cfparam name="CurrencySelection" default='No'>
<cfparam name="ResultsPage" default='No'>
<cfparam name="SearchPageText" default='none'>
<cfparam name="ParamID" default='0000000001'>
<cfparam name="ProductFields" default="0">
<cfset ProductFields=replace(#ProductFields#,"/",",","ALL")>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProdSearchParams">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="ProdSearchParams">
	</cfinvoke>
	<cfoutput query="ProdSearchParams">
		<cfset ProductFields=#ProductFields#>
		<cfset SearchFormText=#SearchFormText#>
		<cfset SearchFormText=replace(#SearchFormText#,"~",",","ALL")>
		<cfset SaveSearchParams=#SaveSearchParams#>
		<cfset CurrencySelection=#CurrencySelection#>
		<cfset ResultsPage=#ResultsPage#>
		<cfset SearchPageText=#SearchPageText#>
		<cfset SearchPageText=replace(#SearchPageText#,"~",",","ALL")>
		<cfset ProductFields=replace(#ProductFields#,"/",",","ALL")>
		<Cfset ProductFields=replace(#ProductFields#,"/",",","ALL")>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif isdefined('form.ProductFields')>
		<cfif #form.ProductFields# is "">
			<cfset form.ProductFields="0">
		<cfelse>
			<cfset form.ProductFields=replace(#form.ProductFields#,",","/","ALL")>
		</cfif>
	<cfelse>
		<cfset form.ProductFields="0">
	</cfif>
	<cfif isdefined('form.ProductFields')>
		<cfif #form.ProductFields# is "">
			<cfset form.ProductFields="0">
		<cfelse>
			<cfset form.ProductFields=replace(#form.ProductFields#,",","/","ALL")>
		</cfif>
	<cfelse>
		<cfset form.ProductFields="0">
	</cfif>
	<cfif #form.SearchFormText# is ""><cfset form.SearchFormText="none"></cfif>
	<cfset #form.SearchFormText#=replace(#form.SearchFormText#,",","~","ALL")>
	<cfif #form.SearchPageText# is ""><cfset form.SearchPageText="none"></cfif>
	<cfset #form.SearchPageText#=replace(#form.SearchPageText#,",","~","ALL")>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="ProdSearchParams">
			<cfinvokeargument name="XMLFields" 
				value="ProductFields,SearchFormText,SaveSearchParams,CurrencySelection,ResultsPage,SearchPageText,ProductFields">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.ProductFields#,#form.SearchFormText#,#form.SaveSearchParams#,#form.CurrencySelection#,#form.ResultsPage#,#form.SearchPageText#,#form.ProductFields#">
			<cfinvokeargument name="XMLIDField" value="ParamID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="ProdSearchParams">
			<cfinvokeargument name="XMLFields" 
				value="ProductFields,SearchFormText,SaveSearchParams,CurrencySelection,ResultsPage,SearchPageText,ProductFields">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.ProductFields#,#form.SearchFormText#,#form.SaveSearchParams#,#form.CurrencySelection#,#form.ResultsPage#,#form.SearchPageText#,#form.ProductFields#">
			<cfinvokeargument name="XMLIDField" value="ParamID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>

<br>
<table class=centrecol width=100%>
<tr>
<td><h2>Set up Product Search Parameters</h2>
<P>This is where you select what information from products will show on the product search page.</P>
</td>
</tr></table>
<cfoutput>
<cfform action="adminheader.cfm" method="post" name="thisform">
<input type="hidden" name="Action" value="ProdSearchConfig">
<table>
		<tr><td valign=top><strong>Select the fields necessary for product searching:</strong>
		</td>
		<td>
			<input type="checkbox" name="ProductFields" value="ProductName" <cfif #listfind(ProductFields,"ProductName")#>checked</cfif>>
          Product Name<br>
		   <input type="checkbox" name="ProductFields" value="ProductCategory" <cfif #listfind(ProductFields,"ProductCategory")#>checked</cfif>>
          Product Category<br>
          <input type="checkbox" name="ProductFields"  value="Vendor" <cfif #listfind(ProductFields,"Vendor")#>checked</cfif>>
          Vendor/Manufacturer<br>
		  <input type="checkbox" name="ProductFields"  value="ProductType" <cfif #listfind(ProductFields,"ProductType")#>checked</cfif>>
          Product Type<br>
          <input type="checkbox" name="ProductFields"  value="MfgNo" <cfif #listfind(ProductFields,"MfgNo")#>checked</cfif>>
          Manufacturers Product ID<br>
          <input type="checkbox" name="ProductFields"  value="CatNo" <cfif #listfind(ProductFields,"CatNo")#>checked</cfif>>
          Your Product ID<br>
		  <input type="checkbox" name="ProductFields"  value="Price" <cfif #listfind(ProductFields,"Price")#>checked</cfif>>
		  Price<br>
		  <input type="checkbox" name="ProductFields"  value="description" <cfif #listfind(ProductFields,"description")#>checked</cfif>>
          Product description<br>
        </p>
		</td></tr>
		<!--- <tr><td>
		<strong>Allow CurrencySelection?:</strong></td><td> 
		<select name="CurrencySelection">
			<option value="1" <cfif #CurrencySelection# is "1">selected</cfif>>Yes</option>
			<option value="0" <cfif #CurrencySelection# is "0">selected</cfif>>No</option>
		</select>
		</td></tr> --->
		<input type="hidden" name="CurrencySelection" value="0">
		<tr>
        <td><strong>Page where search results are shown:</strong></td>
        <td><select name="ResultsPage">
			<option value="NONE">none</option>
            <cfloop query="AllPages">
				<option value="#PageName#"<cfif #ResultsPage# is #PageName#> selected</cfif>>#PageName#</option>
			</cfloop>
          </select></td>
      </tr>
		<tr>
        <td><strong>Allow members to save search parameters?:</strong> </td>
        <td><select name="SaveSearchParams">
            <option value="Yes" <cfif #SaveSearchParams# is "Yes">selected</cfif>>Yes</option>
            <option value="No" <cfif #SaveSearchParams# is "No">selected</cfif>>No</option>
          </select> </td>
      </tr>
		<tr>
        <td valign=top><strong>Text for the Search Form 
          up:</strong><br>
        </td>
        <td valign=top>
		<a href="javascript:GetEditor('thisform','SearchFormText')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="SearchFormText">#SearchFormText#</textarea></td>
		</tr>
		<tr>
        <td valign=top><strong>Text for the Search page</strong></td>
        <td>
		<a href="javascript:GetEditor('thisform','SearchPageText')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="SearchPageText">#SearchPageText#</textarea></td>
		</tr>
	<tr>
	    <td valign=top><input type="submit" name="submit" value="Continue"></td>
        <td>&nbsp;</td>
	</tr><tr>
	    <td valign=top>&nbsp;</td>
	</tr></table>
</cfform>
</cfoutput>