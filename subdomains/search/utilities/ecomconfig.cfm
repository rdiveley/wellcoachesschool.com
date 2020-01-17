
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="eCommerce">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfparam name="PaymentGateway" default='none'>
<cfparam name="GatewayUsername" default='none'>
<cfparam name="GatewayPassword" default='none'>
<cfparam name="GatewayURL" default='none'>
<cfparam name="AllowVISA" default='none'>
<cfparam name="AllowMC" default='0'>
<cfparam name="AllowDiscover" default='0'>
<cfparam name="AllowCarteBlanch" default='0'>
<cfparam name="AllowAMEX" default='0'>
<cfparam name="AllowChecks" default='0'>
<cfparam name="AllowDinersClub" default='0'>
<cfparam name="HaveSSL" default='0'>
<cfparam name="AllowCOD" default='0'>

<cfif #TheFileExists# is "true">
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
		<cfset HaveSSL=#HaveSSL#>
		<cfset AllowCOD=#AllowCOD#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.allowvisa')><cfset form.allowvisa=0></cfif>
	<cfif not isdefined('form.AllowMC')><cfset form.AllowMC=0></cfif>
	<cfif not isdefined('form.AllowDiscover')><cfset form.AllowDiscover=0></cfif>
	<cfif not isdefined('form.AllowCarteBlanch')><cfset form.AllowCarteBlanch=0></cfif>
	<cfif not isdefined('form.AllowAMEX')><cfset form.AllowAMEX=0></cfif>
	<cfif not isdefined('form.AllowChecks')><cfset form.AllowChecks=0></cfif>
	<cfif not isdefined('form.AllowDinersClub')><cfset form.AllowDinersClub=0></cfif>
	<cfif not isdefined('form.AllowCOD')><cfset form.AllowCOD=0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="eCommerce">
			<cfinvokeargument name="XMLFields" value="PaymentGateway,GatewayUsername,GatewayPassword,GatewayURL,AllowVISA,AllowMC,AllowDiscover,AllowCarteBlanch,AllowAMEX,AllowChecks,AllowDinersClub,HaveSSL,AllowCOD">
			<cfinvokeargument name="XMLFieldData" value="#form.PaymentGateway# ,#form.GatewayUsername# ,#form.GatewayPassword# ,#form.GatewayURL# ,#form.AllowVISA#,#form.AllowMC#,#form.AllowDiscover#,#form.AllowCarteBlanch#,#form.AllowAMEX#,#form.AllowChecks#,#form.AllowDinersClub#,#form.HaveSSL#,#form.AllowCOD#">
			<cfinvokeargument name="XMLIDField" value="GatewayID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="eCommerce">
			<cfinvokeargument name="XMLFields" value="PaymentGateway,GatewayUsername,GatewayPassword,GatewayURL,AllowVISA,AllowMC,AllowDiscover,AllowCarteBlanch,AllowAMEX,AllowChecks,AllowDinersClub,HaveSSL,AllowCOD">
			<cfinvokeargument name="XMLFieldData" value="#form.PaymentGateway#,#form.GatewayUsername#,#form.GatewayPassword#,#form.GatewayURL#,#form.AllowVISA#,#form.AllowMC#,#form.AllowDiscover#,#form.AllowCarteBlanch#,#form.AllowAMEX#,#form.AllowChecks#,#form.AllowDinersClub#,#form.HaveSSL#,#AllowCod#">
			<cfinvokeargument name="XMLIDField" value="GatewayID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>


<h1>eCommerce Configuration</h1>
<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Select from this list of payment gateway's or enter the URL of your payment gateway below</td>
	  <td>			<select name="PaymentGateWay">
			<option value="InetTrans" <cfif #trim(PaymentGateway)# is "inettrans">selected</cfif>>Inet-Trans</option>
			<option value="Authnettrans" <cfif #trim(PaymentGateway)# is "Authnettrans">selected</cfif>>Authorize Net</option>
			<option value="iveritrans" <cfif #trim(PaymentGateway)# is "iveritrans">selected</cfif>>Iveri</option>
			<option value="emailcheckout" <cfif #trim(PaymentGateway)# is "emailcheckout">selected</cfif>>Email</option>
			<option value="iTransact" <cfif #trim(PaymentGateway)# is "iTransacttrans">selected</cfif>>iTransact</option>
			</select></td>
		<tr>
	<td>Gateway URL<br>
	  <td><input type="text" name="GatewayURL" value="#GatewayURL#" size="50"></td>
	</tr>
	</tr><tr>
	  <td>Payment Gateway Password</td>
	  <td><input type="password" name="GatewayPassword" value="#GatewayPassword#">
	  </td>
	</tr><tr>
<td>Payment Gateway Username<br></td>
	  <td><input type="text" name="GatewayUsername" value="#GatewayUsername#"></td>
	</tr><tr><tr>
<td>Do you have an Secure Server Certificate?<br></td>
	  <td><select name="HaveSSL">
	  <option value="0">No</option>
	  <option value="1"<cfif #HaveSSL# is 1> selected</cfif>>Yes</option>
	  </select></td>
	</tr>
	<td>Select the payment types you can accept with your merchant account</td>
<td>
	  <input type="checkbox" name="AllowVISA" value="1" <cfif #AllowVISA# is 1>checked</cfif>>VISA<br>
      <input type="checkbox" name="AllowMC" value="1" <cfif #AllowMC# is 1>checked</cfif>>Master Card<br>
      <input type="checkbox" name="AllowDiscover" value="1" <cfif #AllowDiscover# is 1>checked</cfif>>Discover<br>
      <input type="checkbox" name="AllowAMEX" value="1" <cfif #AllowAMEX# is 1>checked</cfif>>AMEX<br>
      <input type="checkbox" name="Allowchecks" value="1" <cfif #Allowchecks# is 1>checked</cfif>>Checks<br>
      <input type="checkbox" name="AllowCarteBlanch" value="1" <cfif #AllowCarteBlanch# is 1>checked</cfif>>Carte Blanch<br>
      <input type="checkbox" name="AllowDinersClub" value="1" <cfif #AllowDinersClub# is 1>checked</cfif>>Diners Club<br>
      <input type="checkbox" name="AllowCOD" value="1" <cfif #AllowCOD# is 1>checked</cfif>>COD</td>
      	  
    </tr>

    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      </td>
      <td></td>
    </tr>
  </table>
  </center></div>
</form>

</cfoutput>