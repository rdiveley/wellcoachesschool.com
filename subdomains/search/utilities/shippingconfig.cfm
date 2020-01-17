
<cfparam name="ShippingConfigID" default=0>
<cfparam name="RushStartAmt" default="0,0,0,0,0">
<cfparam name="RegularStartAmt" default="0,0,0">
<cfparam name="IncrementAmt" default="0,0,0">
<cfparam name="StopAtAmt" default="0,0,0">
<cfparam name="StopAtNo" default=0>
<cfparam name="SalesTaxPercent" default=0>
<cfparam name="GiftWrapAmt" default=0>
<cfparam name="disclaimer" default='none'>
<cfparam name="ResellState" default='none'>
<cfparam name="IntershipperPword" default='none'>
<cfparam name="IntershipperEmail" default='none'>
<cfparam name="SendEmail" default='none'>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="shippingconfig">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="shippingconfig">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="shippingconfig">
		<cfinvokeargument name="IDFieldName" value="shippingconfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="shippingconfig">
		<cfset tRushStartAmt=#RushStartAmt#>
		<cfif listlen(tRushStartAmt,"~") is 1><cfset tRushStartAmt="#tRushStartAmt#,0,0,0,0"></cfif>
		<cfset tRegularStartAmt=#RegularStartAmt#>
		<cfif listlen(tRegularStartAmt,"~") is 1><cfset tRegularStartAmt="#tRegularStartAmt#,0,0"></cfif>
		<cfset tIncrementAmt=#IncrementAmt#>
		<cfif listlen(tIncrementAmt,"~") is 1><cfset tIncrementAmt="#tIncrementAmt#,0,0"></cfif>
		<cfset tStopAtAmt=#StopAtAmt#>
		<cfif listlen(tStopAtAmt,"~") is 1><cfset tStopAtAmt="#tStopAtAmt#,0,0"></cfif>
		<cfset StopAtNo=#StopAtNo#>
		<cfset SalesTaxPercent=#SalesTaxPercent#>
		<cfset GiftWrapAmt=#GiftWrapAmt#>
		<cfset disclaimer=#replacenocase(disclaimer,"~",",","ALL")#>
		<cfset ResellState=#ResellState#>
		<cfset IntershipperPword=#IntershipperPword#>
		<cfset IntershipperEmail=#IntershipperEmail#>
		<cfset SendEmail=#SendEmail#>
	</cfoutput>
	<cfset StopAtAmt=#replace(tStopAtAmt,"~",",","ALL")#>
	<cfset RushStartAmt=#replace(tRushStartAmt,"~",",","ALL")#>
	<cfset RegularStartAmt=#replace(tRegularStartAmt,"~",",","ALL")#>
	<cfset IncrementAmt=#replace(tIncrementAmt,"~",",","ALL")#>
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.RushStartAmt="#form.FEdExOverNight#~#form.FedEx2ndDay#~#form.FedExGround#~#form.FedExInternational#~#form.FEdExHome#">
	<cfset form.RegularStartAmt="#form.UPSOvernight#~#form.UPS2ndDay#~#form.UPSGround#">
	<cfset form.IncrementAmt="#form.DHLOvernight#~#form.DHL2ndDay#~#form.DHLGround#">
	<cfset form.StopAtAmt="#form.USPSExpress#~#form.USPSPriority#~#form.USPSParcel#">
		
	<cfif #form.StopAtNo# is ''><cfset form.StopAtNo="0"></cfif>
	<cfif #form.SalesTaxPercent# is ''><cfset form.SalesTaxPercent="0"></cfif>
	<cfif #form.GiftWrapAmt# is ''><cfset form.GiftWrapAmt="0"></cfif>
	<cfif #form.disclaimer# is ''><cfset form.disclaimer="none"></cfif>
	<cfset form.disclaimer=#replacenocase(form.disclaimer,",","~","ALL")#>
	<cfif #form.ResellState# is ''><cfset form.ResellState="none"></cfif>
	<cfif #form.IntershipperPword# is ''><cfset form.IntershipperPword="none"></cfif>
	<cfif #form.IntershipperEmail# is ''><cfset form.IntershipperEmail="none"></cfif>
	<cfif #form.SendEmail# is ''><cfset form.SendEmail="none"></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ShippingConfig">
			<cfinvokeargument name="XMLFields" value="RushStartAmt,RegularStartAmt,IncrementAmt,StopAtAmt,StopAtNo,SalesTaxPercent,GiftWrapAmt,disclaimer,ResellState,IntershipperPword,IntershipperEmail,SendEmail">
			<cfinvokeargument name="XMLFieldData" value="#form.RushStartAmt#,#form.RegularStartAmt#,#form.IncrementAmt#,#form.StopAtAmt#,#form.StopAtNo#,#form.SalesTaxPercent#,#form.GiftWrapAmt#,#form.disclaimer#,#form.ResellState#,#form.IntershipperPword#,#form.IntershipperEmail#,#form.SendEmail#">
			<cfinvokeargument name="XMLIDField" value="ShippingConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ShippingConfig">
			<cfinvokeargument name="XMLFields" value="RushStartAmt,RegularStartAmt,IncrementAmt,StopAtAmt,StopAtNo,SalesTaxPercent,GiftWrapAmt,disclaimer,ResellState,IntershipperPword,IntershipperEmail,SendEmail">
			<cfinvokeargument name="XMLFieldData" value="#form.RushStartAmt#,#form.RegularStartAmt#,#form.IncrementAmt#,#form.StopAtAmt#,#form.StopAtNo#,#form.SalesTaxPercent#,#form.GiftWrapAmt#,#form.disclaimer#,#form.ResellState#,#form.IntershipperPword#,#form.IntershipperEmail#,#form.SendEmail#">
			<cfinvokeargument name="XMLIDField" value="ShippingConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>

<h1>Shipping, Miscellaneous & Sales Tax Configuration</h1>
<cfoutput>
<cfform action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="Action" value="#Action#">
  
  <div align="center"><center>
  <table>
    <tr>
      <td>
	  <table>
	  <tr><td><strong>Sales Tax</strong></td></tr>
	  <tr><td>Sales Tax Percent</td><td>
			<input type="text" size=10 name="salestaxpercent" value="#salestaxpercent#">
		<br></td></tr>
		
	<tr><td>Sales Tax State</td><td>
			<select name="ResellState">
				<option value="#resellState#">#ResellState#</option>
				<cfinclude template="../files/states.htm">
			</select>
		<br></td></tr>
		<tr><td colspan=2><hr></td></tr>
	<tr><td><strong>Miscellaneous</strong></td></tr>
		<tr><td>Gift wrap amount per item purchased</td><td>
			<cfinput type="Text" name="GiftWrapAmt" value="#GiftWrapAmt#" validate="float" size="10">
		<br></td></tr>
		<tr><td>Stores to send customers invoice to/from (comma separated list as region/store/email)</td><td>
			<textarea name="SendEmail" cols="30" rows="7">#SendEmail#</textarea>
		<br></td></tr><tr>
		<tr><td>Disclaimer/Purchasing Policy that must be agreed to<br>(leave blank if not needed)</td><td>
			<textarea name="disclaimer" cols=35 rows=5>#Disclaimer#</textarea>
		<br></td></tr><tr>
		<tr><td colspan=2><hr></td></tr>
		<td><strong>Shipping Amounts Per Item</strong></td></tr>

		<tr><td valign=top><strong>UPS</strong></td><td>
		<table><tr><td>Overnight:</td> <td><cfinput type="Text" name="UPSOvernight" value="#Listgetat(RegularStartAmt,1)#" validate="float" size="10" maxlength="10"></td></tr>
	   <tr><td>2nd Day: </td><td><cfinput type="Text" name="UPS2ndDay" value="#Listgetat(RegularStartAmt,2)#" validate="float" size="10" maxlength="10"></td></tr>
	   <tr><td>Ground: </td><td><cfinput type="Text" name="UPSGround" value="#Listgetat(RegularStartAmt,3)#" validate="float" size="10" maxlength="10"></td></tr></table>
	  </td></tr>
		<tr><td colspan=2><hr></td>
	  <tr><td valign=top><strong>Federal Express</strong></td><td>
		<table><tr><td>Overnight:</td> <td><cfinput type="Text" name="FEdExOverNight" value="#Listgetat(RushStartAmt,1)#" validate="float" size="10"></td></tr>
		<tr><td>2nd Day:</td> <td><cfinput type="Text" name="FedEx2ndDay" value="#Listgetat(RushStartAmt,2)#" validate="float" size="10"></td></tr>
		<tr><td>Ground:</td> <td><cfinput type="Text" name="FedExGround" value="#Listgetat(RushStartAmt,3)#" validate="float" size="10"></td></tr>
		<tr><td>International Ground:</td> <td><cfinput type="Text" name="FedExInternational" value="#Listgetat(RushStartAmt,4)#" validate="float" size="10"></td></tr>
		<tr><td>Home Delivery:</td> <td><cfinput type="Text" name="FedExHome" value="#Listgetat(RushStartAmt,5)#" validate="float" size="10"></td></tr></table>
		<br></td></tr>
      <tr><td colspan=2><hr></td>
      <tr><td valign=top><strong>DHL</strong></td><td>
	  <table><tr><td>Overnight:</td> <td><cfinput type="Text" name="DHLOvernight" value="#Listgetat(IncrementAmt,1)#" validate="float" size="10" maxlength="10"></td></tr>
	  <tr><td>2nd Day:</td> <td><cfinput type="Text" name="DHL2ndDay" value="#Listgetat(IncrementAmt,2)#" validate="float" size="10" maxlength="10"></td></tr>
	  <tr><td>Ground:</td> <td><cfinput type="Text" name="DHLGround" value="#Listgetat(IncrementAmt,3)#" validate="float" size="10" maxlength="10"></td></tr></table>
	  <br></td></tr>
	  <tr><td colspan=2><hr></td>
      <tr><td valign=top><strong>US Postal Service</strong> </td>
	  <td valign=top>
	  <table><cfset Express=#ListGetAt(StopAtAmt,1)#>
	  <tr><td>Express:</td> <td><cfinput type="Text" name="USPSExpress" value="#Express#" validate="float" size="10"  maxlength="10"></td></tr>
	  <cfset Priority=#ListGetAt(StopAtAmt,2)#>
	  <tr><td>Priority Mail:</td> <td><cfinput type="Text" name="USPSPriority" value="#Priority#" validate="float" size="10"  maxlength="10"></td></tr>
	  <cfset Parcel=#ListGetAt(StopAtAmt,3)#>
	  <tr><td>Parcel Post:</td> <td><cfinput type="Text" name="USPSParcel" value="#Parcel#" validate="float" size="10"  maxlength="10"></td></tr></table>
		</td></tr>
	  <tr><td colspan=2><hr></td>
	  <tr><td>Stop increasing shipping cost after</td>
	  <td><cfinput type="Text" name="StopAtNo" value="#StopAtNo#" validate="float" size="10" maxlength="10"> ## of Items Purchased
	  <br></td></tr>
	  <tr><td colspan=2><hr></td>
		</tr>
		<tr><td><strong>Enter the following only if you have an account with Intershipper</strong></td></tr>
		<tr><td>Email address for Intershipper Account</td><td>
			<input type="text" size=10 name="IntershipperEmail" value="#IntershipperEmail#">
		<br></td></tr>
		<tr><td>Intershipper Account Password</td><td>
			<input type="text" size=10 name="IntershipperPword" value="#IntershipperPword#">
		<br></td></tr>
		</tr>
	  </table>
      </td>
    </tr>
    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      </td>
      <td></td>
    </tr>
  </table>
  </center></div>
</cfform>

</cfoutput>
