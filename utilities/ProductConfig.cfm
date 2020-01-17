
<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="ProductConfig">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfparam name="ProductsPerPage" default='0'>
<cfparam name="ItemListStyle" default='0'>
<cfparam name="CatListStyle" default='0'>
<cfparam name="SearchPageID" default='0'>
<cfparam name="ViewCartpage" default='0'>
<cfparam name="CatListPage" default='0'>
<cfparam name="SearchResultsPage" default='0'>
<cfparam name="ItemListPage" default='0'>
<cfparam name="ThankYouPage" default='0'>
<cfparam name="ProductSpecsPage" default='0'>
<cfparam name="UseGridsorDropDowns" default='1'>
<cfparam name="ShipTrackerPage" default='0'>
<cfparam name="CheckOutPage" default='0'>
<cfparam name="NewItemDays" default='0'>
<cfparam name="NewItemText" default='none'>
<cfparam name="SpecialsText" default='none'>
<cfparam name="ShippedEmailText" default='none'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="ProductConfig">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="ProductConfig">
		<cfinvokeargument name="IDFieldName" value="ProductConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
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
		<cfset NewItemText=#replace(NewItemText,"~",",","ALL")#>
		<cfset SpecialsText=#replace(SpecialsText,"~",",","ALL")#>
		<cfset ShippedEmailText=#replace(ShippedEmailText,"~",",","ALL")#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="ProductConfig">
			<cfinvokeargument name="XMLFields" value="ProductsPerPage,ItemListStyle,CatListStyle,SearchPageID,ViewCartpage,CatListPage,SearchResultsPage,ItemListPage,ThankYouPage,ProductSpecsPage,UseGridsorDropDowns,ShipTrackerPage,CheckOutPage,NewItemDays,NewItemText,SpecialsText,ShippedEmailText">
			<cfinvokeargument name="XMLFieldData" value="#form.ProductsPerPage#,#form.ItemListStyle#,#form.CatListStyle#,#form.SearchPageID#,#form.ViewCartpage#,#form.CatListPage#,#form.SearchResultsPage#,#form.ItemListPage#,#form.ThankYouPage#,#form.ProductSpecsPage#,#form.UseGridsorDropDowns#,#form.ShipTrackerPage#,#form.CheckOutPage#,#form.NewItemDays#,#replace(form.NewItemText,',','~','ALL')#,#replace(form.SpecialsText,',','~','ALL')#,#replace(form.ShippedEmailText,',','~','ALL')#">
			<cfinvokeargument name="XMLIDField" value="ProductConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="ProductConfig">
			<cfinvokeargument name="XMLFields" value="ProductsPerPage,ItemListStyle,CatListStyle,SearchPageID,ViewCartpage,CatListPage,SearchResultsPage,ItemListPage,ThankYouPage,ProductSpecsPage,UseGridsorDropDowns,ShipTrackerPage,CheckOutPage,NewItemDays,NewItemText,SpecialsText,ShippedEmailText">
			<cfinvokeargument name="XMLFieldData" value="#form.ProductsPerPage#,#form.ItemListStyle#,#form.CatListStyle#,#form.SearchPageID#,#form.ViewCartpage#,#form.CatListPage#,#form.SearchResultsPage#,#form.ItemListPage#,#form.ThankYouPage#,#form.ProductSpecsPage#,#form.UseGridsorDropDowns#,#form.ShipTrackerPage#,#form.CheckOutPage#,#form.NewItemDays#,#replace(form.NewItemText,',','~','ALL')#,#replace(form.SpecialsText,',','~','ALL')#,#replace(form.ShippedEmailText,',','~','ALL')#">
			<cfinvokeargument name="XMLIDField" value="ProductConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>

<cfoutput><script>
function viewliststyle(tform,tcontrol) {
	var liststylepage=document.thisform.ItemListStyle.value;
	winStr = '#Application.returnpath#/images/liststyle'+liststylepage+'.jpg';
	win = window.open(winStr, 'subwin' , 'width=300,height=200,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}
function viewcatstyle(tform,tcontrol) {
	var catstylepage=document.thisform.CatListStyle.value;
	winStr = '#Application.returnpath#/images/catstyle'+catstylepage+'.jpg';
	win = window.open(winStr, 'subwin' , 'width=300,height=200,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
	win.focus();
}
</script>
<h1>Products Configuration</h1>
<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table>
		<tr><td>Number of Products to list on each Page</td><td><input type="text" name="ProductsPerPage" size = 5 value="#ProductsPerPage#"><br></td></tr>
			<tr><td>Use grid or drop down list for styles, colors, etc.</td><td>Grids: <cfif #UseGridsorDropDowns# is 1><input type="radio" name="UseGridsorDropDowns"
      value="1" Checked><cfelse><input type="radio" name="UseGridsorDropDowns"
      value="1"></cfif><br>
	  Drop Down Lists: <cfif #UseGridsorDropDowns# is 2><input type="radio" name="UseGridsorDropDowns"
      value="2" Checked><cfelse><input type="radio" name="UseGridsorDropDowns"
      value="2"></cfif><br></td></tr> 
	    <tr><td>No of days back for New Products Listing</td><td><input type="Text" name="NewItemDays" value="#NewItemDays#"
      size="5" maxlength="5">
	  <br></td></tr>
	  <input type="hidden" name="ItemListStyle" value="1">
	  <input type="hidden" name="CatListStyle" value="1">
	  <tr>
      <td valign="top">
	   <table>
	   <tr><td>Category Listing page</td><td>
	  <select name="CatListPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #CatListPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>  
			<tr><td>Item List Page</td><td>
	 <select name="ItemListPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ItemListPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>
		<tr><td>Shipping Tracker Page</td><td>
		<select name="ShipTrackerPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ShipTrackerPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>
      <tr><td>Thank You Page ID</td><td>
	  <select name="ThankYouPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ThankYouPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>  
			<tr><td>View Cart Page ID</td><td>
	  <select name="ViewCartpage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ViewCartpage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr> 
			<tr><td>Search Page ID</td><td>
	  <select name="SearchPageID">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #SearchPageID# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr> 
			<tr><td>Search Results Page</td><td>
	  <select name="SearchResultsPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #SearchResultsPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>
			<tr><td>Check Out Page ID</td><td>
	  <select name="CheckOutPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #CheckOutPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>
			<tr><td>Product Specifications Page</td><td>
	  <select name="ProductSpecsPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ProductSpecsPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select><br></td></tr>
</table>
	</td>
    <td>
	<table>
	</td></tr>
	<tr><td>Text for New Products Page when there are no new products</td><td>
	  	<a href="javascript:GetEditor('thisform','NewItemText')"  class=box>Click here for the editor</a><br>
		<textarea name="NewItemText" cols=50 rows=5>#NewItemText#</textarea>
		<br></td></tr>
	  <tr><td>Text for Specials Page when there are no Specials</td><td>
	  	<a href="javascript:GetEditor('thisform','SpecialsText')"  class=box>Click here for the editor</a><br>
		<textarea name="SpecialsText" cols=50 rows=5>#SpecialsText#</textarea>
		<br></td></tr>
	
	<tr><td>Text for the email going to customer when invoice is shipped
	</td><td>
	  <a href="javascript:GetEditor('thisform','ShippedEmailText')"  class=box>Click here for the editor</a><br>	
		<textarea name="ShippedEmailText" cols=50 rows=5>#ShippedEmailText#</textarea><br>
		Use the following as fields to include in the email:<br>
		[firstname]<br>
		[Lastname]<br>
		be sure and include the brackets [ ] along with the field name.
		<br></td></tr>
	</table>
	
	</td></tr>
    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit1" value="Reset"> <br>
      </td>
      <td></td>
    </tr>
  </table>
  </center></div>
</form>

</cfoutput>
</body>
</html>