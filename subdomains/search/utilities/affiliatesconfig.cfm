<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="affiliateconfig">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllSurveys">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="surveys">
</cfinvoke>


<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfparam name="AllowClickThru" default=0>
<cfparam name="ClickThruSubType" default=0>
<cfparam name="AllowByImpression" default=0>
<cfparam name="ImpressionSubType" default=0>
<cfparam name="AllowBySale" default=0>
<cfparam name="BySaleSubType" default=0>
<cfparam name="AllowPrePurchase" default=0>
<cfparam name="PrePurchaseSubType" default=0>
<cfparam name="ClickThruPrice" default=0>
<cfparam name="ImpressionPrice" default=0>
<cfparam name="PercentPer" default=0>
<cfparam name="DeleteDays" default=0>
<cfparam name="RegistrationPage" default=0>
<cfparam name="PrivacyPolicyPage" default=0>
<cfparam name="RulesPage" default=0>
<cfparam name="InformationPage" default=0>
<cfparam name="LoginPage" default=0>
<cfparam name="ClickThruPage" default=0>
<cfparam name="EmailFriendSubject" default=''>
<cfparam name="EmailFriendBody" default=''>
<cfparam name="EmailFriendFooter" default=''>
<cfparam name="CustomerRegPage" default=0>
<cfparam name="AffiliateLoginPage" default=0>
<cfparam name="ModuleAffected" default=0>
<cfparam name="NewAffEmail" default=''>
<cfparam name="AffWelcome" default=''>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.AllowClickThru')><cfset AllowClickThru=0></cfif>
	<cfif not isdefined('form.AllowByImpression')><cfset AllowByImpression=0></cfif>
	<cfif not isdefined('form.AllowPrePurchase')><cfset AllowPrePurchase=0></cfif>
	<cfif EmailFriendSubject is ""><cfset EmailFriendSubject="none"></cfif>
	<cfif EmailFriendBody is ""><cfset EmailFriendBody="none"></cfif>
	<cfif EmailFriendFooter is ""><cfset EmailFriendFooter="none"></cfif>
	<cfif AllowBySale is ''><cfset AllowBySale="None"></cfif>
	<cfif NewAffEmail is ''><cfset NewAffEmail="None"></cfif>
	<cfif AffWelcome is ''><cfset AffWelcome="None"></cfif>
	
	<cfset EmailFriendSubject=replace(EmailFriendSubject,",","~","ALL")>
	<cfset EmailFriendBody=replace(EmailFriendBody,",","~","ALL")>
	<cfset EmailFriendFooter=replace(EmailFriendFooter,",","~","ALL")>
	<cfset AllowBySale=replace(AllowBySale,",","~","ALL")>
	<cfset NewAffEmail=replace(NewAffEmail,",","~","ALL")>
	<cfset AffWelcome=replace(AffWelcome,",","~","ALL")>
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="affiliateconfig">
			<cfinvokeargument name="XMLFields" value="AllowClickThru,ClickThruSubType,AllowByImpression,ImpressionSubType,AllowBySale,BySaleSubType,AllowPrePurchase,PrePurchaseSubType,ClickThruPrice,ImpressionPrice,PercentPer,DeleteDays,RegistrationPage,PrivacyPolicyPage,RulesPage,InformationPage,LoginPage,ClickThruPage,EmailFriendSubject,EmailFriendBody,EmailFriendFooter,CustomerRegPage,AffiliateLoginPage,ModuleAffected,NewAffEmail,AffWelcome">
			<cfinvokeargument name="XMLFieldData" value="#AllowClickThru#,#ClickThruSubType#,#AllowByImpression#,#ImpressionSubType#,#AllowBySale#,#BySaleSubType#,#AllowPrePurchase#,#PrePurchaseSubType#,#ClickThruPrice#,#ImpressionPrice#,#PercentPer#,#DeleteDays#,#RegistrationPage#,#PrivacyPolicyPage#,#RulesPage#,#InformationPage#,#LoginPage#,#ClickThruPage#,#EmailFriendSubject#,#EmailFriendBody#,#EmailFriendFooter#,#CustomerRegPage#,#AffiliateLoginPage#,#ModuleAffected#,#NewAffEmail#,#AffWelcome#">
			<cfinvokeargument name="XMLIDField" value="affiliateconfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="affiliateconfig">
			<cfinvokeargument name="XMLFields" value="AllowClickThru,ClickThruSubType,AllowByImpression,ImpressionSubType,AllowBySale,BySaleSubType,AllowPrePurchase,PrePurchaseSubType,ClickThruPrice,ImpressionPrice,PercentPer,DeleteDays,RegistrationPage,PrivacyPolicyPage,RulesPage,InformationPage,LoginPage,ClickThruPage,EmailFriendSubject,EmailFriendBody,EmailFriendFooter,CustomerRegPage,AffiliateLoginPage,ModuleAffected,NewAffEmail,AffWelcome">
			<cfinvokeargument name="XMLFieldData" value="#AllowClickThru#,#ClickThruSubType#,#AllowByImpression#,#ImpressionSubType#,#AllowBySale#,#BySaleSubType#,#AllowPrePurchase#,#PrePurchaseSubType#,#ClickThruPrice#,#ImpressionPrice#,#PercentPer#,#DeleteDays#,#RegistrationPage#,#PrivacyPolicyPage#,#RulesPage#,#InformationPage#,#LoginPage#,#ClickThruPage#,#EmailFriendSubject#,#EmailFriendBody#,#EmailFriendFooter#,#CustomerRegPage#,#AffiliateLoginPage#,#ModuleAffected#,#NewAffEmail#,#AffWelcome#">
			<cfinvokeargument name="XMLIDField" value="affiliateconfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="affiliateconfig">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="affiliateconfig">
		<cfinvokeargument name="IDFieldName" value="affiliateconfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfset AllowClickThru=#affiliateconfig.AllowClickThru#>
	<cfset ClickThruSubType=#affiliateconfig.ClickThruSubType#>
	<cfset AllowByImpression=#affiliateconfig.AllowByImpression#>
	<cfset ImpressionSubType=#affiliateconfig.ImpressionSubType#>
	<cfset BySaleSubType=#affiliateconfig.BySaleSubType#>
	<cfset AllowPrePurchase=#affiliateconfig.AllowPrePurchase#>
	<cfset PrePurchaseSubType=#affiliateconfig.PrePurchaseSubType#>
	<cfset ClickThruPrice=#affiliateconfig.ClickThruPrice#>
	<cfset ImpressionPrice=#affiliateconfig.ImpressionPrice#>
	<cfset PercentPer=#affiliateconfig.PercentPer#>
	<cfset DeleteDays=#affiliateconfig.DeleteDays#>
	<cfset RegistrationPage=#affiliateconfig.RegistrationPage#>
	<cfset PrivacyPolicyPage=#affiliateconfig.PrivacyPolicyPage#>
	<cfset RulesPage=#affiliateconfig.RulesPage#>
	<cfset InformationPage=#affiliateconfig.InformationPage#>
	<cfset LoginPage=#affiliateconfig.LoginPage#>
	<cfset ClickThruPage=#affiliateconfig.ClickThruPage#>
	<cfset EmailFriendSubject='#replace(affiliateconfig.EmailFriendSubject,"~",",","ALL")#'>
	<cfset EmailFriendBody='#replace(affiliateconfig.EmailFriendBody,"~",",","ALL")#'>
	<cfset EmailFriendFooter='#replace(affiliateconfig.EmailFriendFooter,"~",",","ALL")#'>
	<cfset CustomerRegPage='#replace(affiliateconfig.CustomerRegPage,"~",",","ALL")#'>
	<cfset AffiliateLoginPage='#replace(affiliateconfig.AffiliateLoginPage,"~",",","ALL")#'>
	<cfset AllowBySale=#replace(affiliateconfig.AllowBySale,"~",",","ALL")#>
	<cfset ModuleAffected=#affiliateconfig.ModuleAffected#>
	<cfset NewAffEmail='#replace(affiliateconfig.NewAffEmail,"~",",","ALL")#'>
	<cfset AffWelcome='#replace(affiliateconfig.AffWelcome,"~",",","ALL")#'>
</cfif>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllAffMethods">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="AffMethods">
</cfinvoke>

<cfoutput>
<h1>Affiliate Program Configuration</h1>
<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
<input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  
<table border=0>
<tr><TD><strong>Select the methods for this affiliate program</strong></TD></tr>
<tr>
<td>
	<table>

	  <tr>
	  <td>Select Method for Pay Per Click</td><td><select name="ClickThruSubType">
			<option value="0">None</option>
				<cfloop query="AllAffMethods">
					<option value="#MethodID#" <cfif #ClickThruSubType# is #MethodID#>selected</cfif>>#MethodDescription#
				</cfloop>
			</select> </td>
	  </tr>
	  	 <tr>
	  <td>Select the module which is affected by Pay Per Click</td><td>
		<select name="ClickThruPrice">
			<option value="1"<cfif #ClickThruPrice# is 1> selected</cfif>>Memberships
			<option value="2"<cfif #ClickThruPrice# is 2> selected</cfif>>Products
			<option value="3"<cfif #ClickThruPrice# is 3> selected</cfif>>Classifieds
			<option value="4"<cfif #ClickThruPrice# is 4> selected</cfif>>Dating Service
			<option value="5"<cfif #ClickThruPrice# is 5> selected</cfif>>Auctions
			<option value="6"<cfif #ClickThruPrice# is 6> selected</cfif>>OnLine Education
			<option value="7"<cfif #ClickThruPrice# is 7> selected</cfif>>Job Board
			<option value="8"<cfif #ClickThruPrice# is 8> selected</cfif>>Hotel/Motel Reservations
			<option value="9"<cfif #ClickThruPrice# is 9> selected</cfif>>E-Cards
		</select>
	  </td>
	 </tr>
	  <tr><Td colspan=2><hr></Td></tr>

	<tr>
		<td>Select Method for Per Lead</td><td><select name="ImpressionSubType">
			<option value="0">None</option>
				<cfloop query="AllAffMethods">
					<option value="#MethodID#" <cfif #ImpressionSubType# is #MethodID#>selected</cfif>>#MethodDescription#
				</cfloop>
			</select> </td>
      </tr>
	 <tr>
	 <td>Select the module which is affected by Pay Per Lead</td><td>
		<select name="ImpressionPrice">
			<option value="1"<cfif #ImpressionPrice# is 1> selected</cfif>>Memberships
			<option value="2"<cfif #ImpressionPrice# is 2> selected</cfif>>Products
			<option value="3"<cfif #ImpressionPrice# is 3> selected</cfif>>Classifieds
			<option value="4"<cfif #ImpressionPrice# is 4> selected</cfif>>Dating Service
			<option value="5"<cfif #ImpressionPrice# is 5> selected</cfif>>Auctions
			<option value="6"<cfif #ImpressionPrice# is 6> selected</cfif>>OnLine Education
			<option value="7"<cfif #ImpressionPrice# is 7> selected</cfif>>Job Board
			<option value="8"<cfif #ImpressionPrice# is 8> selected</cfif>>Hotel/Motel Reservations
			<option value="9"<cfif #ImpressionPrice# is 9> selected</cfif>>E-Cards
		</select>
	  </td>
	 </tr>

	  <tr><Td colspan=2><hr></Td></tr>

	  <tr>
		<td>Select Method for Pay By Prepurchase</td><td><select name="PrePurchaseSubType">
			<option value="0">None</option>
				<cfloop query="AllAffMethods">
					<option value="#MethodID#" <cfif #PrePurchaseSubType# is #MethodID#>selected</cfif>>#MethodDescription#
				</cfloop>
			</select> </td>
      </tr>
	  <tr>
	  <td>Select the module which is affected by Prepurchase Method</td><td>
		<select name="ModuleAffected">
			<option value="1"<cfif #ModuleAffected# is 1> selected</cfif>>Memberships
			<option value="2"<cfif #ModuleAffected# is 2> selected</cfif>>Products
			<option value="3"<cfif #ModuleAffected# is 3> selected</cfif>>Classifieds
			<option value="4"<cfif #ModuleAffected# is 4> selected</cfif>>Dating Service
			<option value="5"<cfif #ModuleAffected# is 5> selected</cfif>>Auctions
			<option value="6"<cfif #ModuleAffected# is 6> selected</cfif>>OnLine Education
			<option value="7"<cfif #ModuleAffected# is 7> selected</cfif>>Job Board
			<option value="8"<cfif #ModuleAffected# is 8> selected</cfif>>Hotel/Motel Reservations
			<option value="9"<cfif #ModuleAffected# is 9> selected</cfif>>E-Cards
		</select>
      </td>
	  </tr>
	  <tr><Td colspan=2><hr></Td></tr>

	  <tr>
		<td>Select Method for Pay By Sale</td><td><select name="BySaleSubType">
			<option value="0">None</option>
				<cfloop query="AllAffMethods">
					<option value="#MethodID#" <cfif #BySaleSubType# is #MethodID#>selected</cfif>>#MethodDescription#
				</cfloop>
			</select> </td>
	  </tr>

		<tr>
		<td>Select the module which is affected by Pay Per Sale</td><td>
		<select name="PercentPer">
			<option value="1"<cfif #PercentPer# is 1> selected</cfif>>Memberships
			<option value="2"<cfif #PercentPer# is 2> selected</cfif>>Products
			<option value="3"<cfif #PercentPer# is 3> selected</cfif>>Classifieds
			<option value="4"<cfif #PercentPer# is 4> selected</cfif>>Dating Service
			<option value="5"<cfif #PercentPer# is 5> selected</cfif>>Auctions
			<option value="6"<cfif #PercentPer# is 6> selected</cfif>>OnLine Education
			<option value="7"<cfif #PercentPer# is 7> selected</cfif>>Job Board
			<option value="8"<cfif #PercentPer# is 8> selected</cfif>>Hotel/Motel Reservations
			<option value="9"<cfif #PercentPer# is 9> selected</cfif>>E-Cards
		</select>
	  </td>
	 </tr>
	 	 <tr><Td colspan=2><hr></Td></tr>

	</table>
</td>
<td valign=top>
  <table border=0>

        <tr>
                <td width="50%">Affiliate Registration Page</td>
          <td width="50%">
		  <select name="RegistrationPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #RegistrationPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td>
        </tr>
	<tr>
      <td>Registration Thank You Page</td><td>
	  <select name="DeleteDays">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #DeleteDays# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td>
	 </tr>
	 	  <tr>
	  <td>Affiliate Personal Home Page</td><td>
	  <select name="AllowclickThru">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #AllowclickThru# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
	  </td>
	  </tr>
	<tr>
          <td width="50%">Affiliate Privacy Policy Page</td>
          <td width="50%">
		  <select name="PrivacyPolicyPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #PrivacyPolicyPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		</td>
        </tr>
        <tr>
                <td width="50%">Affiliate Rules of Conduct Page</td>
          <td width="50%">		  
		  <select name="RulesPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #RulesPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		</td>
        </tr>
		<tr>
        <tr>
          <td width="50%">Affilite Program Information Page</td>
          <td width="50%">	  
		  <select name="InformationPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #InformationPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		</td>
        </tr>
		<tr>
          <td width="50%">Affiliate Program Disclaimer Page</td>
          <td width="50%">
		  <select name="CustomerRegPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #CustomerRegPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td>
        </tr>
        <tr>
                <td width="50%">Affiliate Login Page</td>
          <td width="50%">
		  <select name="AffiliateLoginPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #AffiliateLoginPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		</td>
        </tr>
		<tr>
		  <td>Forgot Password Page</td>
          <td width="50%">
		  <select name="AllowByImpression">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #AllowByImpression# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		  </td>
		  </tr>	  
		<tr><td>Page where click throughs arrive on the site</td><td> 
		  <select name="ClickThruPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #ClickThruPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
		</td>
		</tr>
			  <tr>
	  <td>Affiliate Profile Survey</td><td>
	  <select name="AllowPrePurchase">
		<option value="0">None
	   	<cfloop query="allsurveys">
			<option value="#SurveyID#" <cfif #AllowPrePurchase# is #SurveyID#>selected</cfif>>#SurveyName#
		</cfloop>
		</select>
	  </td>
	  </tr>
  </table>
</td>
</tr>
</table>
<table border=0 cellspacing=0 cellpadding=15 width=100%>
		<tr>
		<td valign=top>Set the default email subject for inviting a customer<br>
		<input type="text" size="25" maxlength="150" name="EmailFriendSubject" value="#EmailFriendSubject#"></td>

		<td>Set the default Email body for inviting a customer<br>
		<textarea name="EmailFriendBody" cols=40 rows=5>#EmailFriendBody#</textarea></td>
		</tr>
		<tr>
		<td>Set the default Email Closing for inviting a customer<br>
		<textarea name="EmailFriendFooter" cols=40 rows=5>#EmailFriendFooter#</textarea></td>

	  <td>Affiliate Personal Home Page Welcome Message<br>
		<textarea name="AllowBySale" cols=40 rows=5>#AllowBySale#</textarea></td>
	  </tr>
	  <tr>
		<td valign=top>Set the default Email For a new Affiliate<br>
		<textarea name="newAffEmail" cols=40 rows=5>#newAffEmail#</textarea><br>
		You can use the following fields (with the brackets) in this email<br>
		[firstname]<br>
		[lastname]<br>
		[username]<br>
		[password]<br>
		[affiliateID]</td>

	  <td valign=top>Text for the Affiliate Personal Home Page Title<br>
		<textarea name="affWelcome" cols=40 rows=5>#affWelcome#</textarea><br>
		You can use the following fields (with the brackets) in the welcome message<br>
		[firstname]<br>
		[lastname]</td>
	  </tr>
</table>
  </center></div>
 <p align=center><input type="submit" name="submit" value="Apply"></p>
</form>

</cfoutput>
