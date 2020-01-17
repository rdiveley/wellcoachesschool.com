
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="forums">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfparam name="TimeOutMinutes" default='none'>
<cfparam name="WarningMessage" default='none'>
<cfparam name="GatewayPassword" default='none'>
<cfparam name="GatewayURL" default='none'>
<cfparam name="AllowPolls" default='none'>
<cfparam name="AllowMC" default='0'>
<cfparam name="AllowDiscover" default='0'>
<cfparam name="AllowCarteBlanch" default='0'>
<cfparam name="AllowAMEX" default='0'>
<cfparam name="AllowChecks" default='0'>
<cfparam name="AllowDinersClub" default='0'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="forums">
		<cfinvokeargument name="IDFieldName" value="GatewayID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset TimeOutMinutes=#TimeOutMinutes#>
		<cfset WarningMessage=#WarningMessage#>
		<cfset GatewayPassword=#GatewayPassword#>
		<cfset GatewayURL=#GatewayURL#>
		<cfset AllowPolls=#AllowPolls#>
		<cfset AllowMC=#AllowMC#>
		<cfset AllowDiscover=#AllowDiscover#>
		<cfset AllowCarteBlanch=#AllowCarteBlanch#>
		<cfset AllowAMEX=#AllowAMEX#>
		<cfset AllowChecks=#AllowChecks#>
		<cfset AllowDinersClub=#AllowDinersClub#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.AllowPolls')><cfset form.AllowPolls=0></cfif>
	<cfif not isdefined('form.AllowMC')><cfset form.AllowMC=0></cfif>
	<cfif not isdefined('form.AllowDiscover')><cfset form.AllowDiscover=0></cfif>
	<cfif not isdefined('form.AllowCarteBlanch')><cfset form.AllowCarteBlanch=0></cfif>
	<cfif not isdefined('form.AllowAMEX')><cfset form.AllowAMEX=0></cfif>
	<cfif not isdefined('form.AllowChecks')><cfset form.AllowChecks=0></cfif>
	<cfif not isdefined('form.AllowDinersClub')><cfset form.AllowDinersClub=0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="forums">
			<cfinvokeargument name="XMLFields" value="TimeOutMinutes,WarningMessage,GatewayPassword,GatewayURL,AllowPolls,AllowMC,AllowDiscover,AllowCarteBlanch,AllowAMEX,AllowChecks,AllowDinersClub,">
			<cfinvokeargument name="XMLFieldData" value="#form.TimeOutMinutes#,#form.WarningMessage#,#form.GatewayPassword#,#form.GatewayURL#,#form.AllowPolls#,#form.AllowMC#,#form.AllowDiscover#,#form.AllowCarteBlanch#,#form.AllowAMEX#,#form.AllowChecks#,#form.AllowDinersClub#">
			<cfinvokeargument name="XMLIDField" value="GatewayID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="forums">
			<cfinvokeargument name="XMLFields" value="TimeOutMinutes,WarningMessage,GatewayPassword,GatewayURL,AllowPolls,AllowMC,AllowDiscover,AllowCarteBlanch,AllowAMEX,AllowChecks,AllowDinersClub,">
			<cfinvokeargument name="XMLFieldData" value="#form.TimeOutMinutes#,#form.WarningMessage#,#form.GatewayPassword#,#form.GatewayURL#,#form.AllowPolls#,#form.AllowMC#,#form.AllowDiscover#,#form.AllowCarteBlanch#,#form.AllowAMEX#,#form.AllowChecks#,#form.AllowDinersClub#">
			<cfinvokeargument name="XMLIDField" value="GatewayID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>


<h1>Discussion Forums Configuration</h1>
<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Select from this list of payment gateway's or enter the URL of your payment gateway below</td>
	  <td>			<select name="TimeOutMinutes">
			<option value="InetTrans" <cfif #TimeOutMinutes# is "inettrans">selected</cfif>>Inet-Trans</option>
			<option value="Authnettrans" <cfif #TimeOutMinutes# is "Authnettrans">selected</cfif>>Authorize Net</option>
			<option value="iveritrans" <cfif #TimeOutMinutes# is "iveritrans">selected</cfif>>Iveri</option>
			<option value="emailcheckout" <cfif #TimeOutMinutes# is "emailcheckout">selected</cfif>>Email</option>
			<option value="iTransacttrans" <cfif #TimeOutMinutes# is "iTransacttrans">selected</cfif>>iTransact</option>
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
	  <td><input type="text" name="WarningMessage" value="#WarningMessage#"></td>
	</tr><tr>
	<td>Select the payment types you can accept with your merchant account</td>
<td>
	  <input type="checkbox" name="AllowPolls" value="1" <cfif #AllowPolls# is 1>checked</cfif>>VISA<br>
      <input type="checkbox" name="AllowMC" value="1" <cfif #AllowMC# is 1>checked</cfif>>Master Card<br>
      <input type="checkbox" name="AllowDiscover" value="1" <cfif #AllowDiscover# is 1>checked</cfif>>Discover<br>
      <input type="checkbox" name="AllowAMEX" value="1" <cfif #AllowAMEX# is 1>checked</cfif>>AMEX<br>
      <input type="checkbox" name="Allowchecks" value="1" <cfif #Allowchecks# is 1>checked</cfif>>Checks<br>
      <input type="checkbox" name="AllowCarteBlanch" value="1" <cfif #AllowCarteBlanch# is 1>checked</cfif>>Carte Blanch<br>
      <input type="checkbox" name="AllowDinersClub" value="1" <cfif #AllowDinersClub# is 1>checked</cfif>>Diners Club</td>
      	  
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