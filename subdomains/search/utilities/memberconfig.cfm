<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="SurveyFileExists">
		<cfinvokeargument name="FileName" value="surveys">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>
<cfif #SurveyFileExists#>
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllSurveys">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="surveys">
	</cfinvoke>
</cfif>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="ForumFileExists">
		<cfinvokeargument name="FileName" value="ForumNames">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>
<cfif #ForumFileExists#>
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllForums">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ForumNames">
	</cfinvoke>
</cfif>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="orderbystatement" value=" order by pagename">
</cfinvoke>

<cfparam name="AfterSignupPage" default="homepage">
<cfparam name="AfterLoginPage" default="homepage">
<cfparam name="SignUpPage" default="homepage">
<cfparam name="Disclaimerpage" default="homepage">
<cfparam name="PrivacyPolicyPage" default="homepage">
<cfparam name="ConductPage" default="homepage">
<cfparam name="InformationPage" default="homepage">
<cfparam name="LoginPage" default="homepage">
<cfparam name="SearchResultsPage" default="homepage">
<cfparam name="CheckOutPage" default="homepage">
<cfparam name="ProfileSurveyID" default="0">
<cfparam name="GetPasswordPage" default="homepage">
<cfparam name="SearchPage" default="homepage">
<cfparam name="AllowContacts" default="0">
<cfparam name="AllowNewsletters" default="0">
<cfparam name="AllowArticles" default="0">
<cfparam name="MemberForum" default="0">
<cfparam name="AllowPolls" default="0">
<cfparam name="AllowGallery" default="0">
<cfparam name="AllowCalendar" default="0">
<cfparam name="CanBecomeAffiliate" default="0">
<cfparam name="AllowGuestBook" default=0>
<cfparam name="defaultNav" default=1>
<cfparam name="TypeWord" default="Category">

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="MemberConfig">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>
<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="MemberConfig">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="MemberConfig">
		<cfinvokeargument name="IDFieldName" value="MemberConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="MemberConfig">
		<cfset AfterSignupPage=#AfterSignupPage#>
		<cfset AfterLoginPage=#AfterLoginPage#>
		<cfset SignUpPage=#SignUpPage#>
		<cfset Disclaimerpage=#Disclaimerpage#>
		<cfset PrivacyPolicyPage=#PrivacyPolicyPage#>
		<cfset ConductPage=#ConductPage#>
		<cfset InformationPage=#InformationPage#>
		<cfset LoginPage=#LoginPage#>
		<cfset SearchResultsPage=#SearchResultsPage#>
		<cfset CheckOutPage=#CheckOutPage#>
		<cfset ProfileSurveyID=#ProfileSurveyID#>
		<cfset GetPasswordPage=#GetPasswordPage#>
		<cfset SearchPage=#SearchPage#>
		<cfset AllowContacts=#AllowContacts#>
		<cfset AllowNewsletters=#AllowNewsletters#>
		<cfset AllowArticles=#AllowArticles#>
		<cfset MemberForum=#MemberForum#>
		<cfset AllowPolls=#AllowPolls#>
		<cfset AllowGallery=#AllowGallery#>
		<cfset AllowCalendar=#AllowCalendar#>
		<cfset CanBecomeAffiliate=#CanBecomeAffiliate#>
		<cfset AllowGuestBook=#AllowGuestBook#>
		<cfset defaultNav=#defaultNav#>
		<cfset TypeWord=#TypeWord#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="MemberConfig">
			<cfinvokeargument name="XMLFields" value="AfterSignupPage,AfterLoginPage,SignUpPage,Disclaimerpage,PrivacyPolicyPage,ConductPage,InformationPage,LoginPage,SearchResultsPage,CheckOutPage,ProfileSurveyID,GetPasswordPage,SearchPage,AllowContacts,AllowNewsletters,AllowArticles,MemberForum,AllowPolls,AllowGallery,AllowCalendar,CanBecomeAffiliate,AllowGuestBook,defaultNav,TypeWord">
			<cfinvokeargument name="XMLFieldData" value="#form.AfterSignupPage#,#form.AfterLoginPage#,#form.SignUpPage#,#form.Disclaimerpage#,#form.PrivacyPolicyPage#,#form.ConductPage#,#form.InformationPage#,#form.LoginPage#,#form.SearchResultsPage#,#form.CheckOutPage#,#form.ProfileSurveyID#,#form.GetPasswordPage#,#form.SearchPage#,#form.AllowContacts#,#form.AllowNewsletters#,#form.AllowArticles#,#form.MemberForum#,#form.AllowPolls#,#form.AllowGallery#,#form.AllowCalendar#,#form.CanBecomeAffiliate#,#form.AllowGuestBook#,#form.defaultNav#,#form.TypeWord#">
			<cfinvokeargument name="XMLIDField" value="MemberConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="MemberConfig">
			<cfinvokeargument name="XMLFields" value="AfterSignupPage,AfterLoginPage,SignUpPage,Disclaimerpage,PrivacyPolicyPage,ConductPage,InformationPage,LoginPage,SearchResultsPage,CheckOutPage,ProfileSurveyID,GetPasswordPage,SearchPage,AllowContacts,AllowNewsletters,AllowArticles,MemberForum,AllowPolls,AllowGallery,AllowCalendar,CanBecomeAffiliate,AllowGuestBook,defaultNav,TypeWord">
			<cfinvokeargument name="XMLFieldData" value="#form.AfterSignupPage#,#form.AfterLoginPage#,#form.SignUpPage#,#form.Disclaimerpage#,#form.PrivacyPolicyPage#,#form.ConductPage#,#form.InformationPage#,#form.LoginPage#,#form.SearchResultsPage#,#form.CheckOutPage#,#form.ProfileSurveyID#,#form.GetPasswordPage#,#form.SearchPage#,#form.AllowContacts#,#form.AllowNewsletters#,#form.AllowArticles#,#form.MemberForum#,#form.AllowPolls#,#form.AllowGallery#,#form.AllowCalendar#,#form.CanBecomeAffiliate#,#form.AllowGuestBook#,#form.defaultNav#,#form.TypeWord#">
			<cfinvokeargument name="XMLIDField" value="MemberConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>

<cfoutput> <h1>Members Section Configuration</h1> <br>

<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="Action" value="#Action#">
  <table>

    <tr>
      <td valign="top">
	   <table><tr><td>Membership Sign Up Page</td><td>
	   	<select name="signuppage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #SignUpPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
</td></tr>
      <tr><td>Member Log In Page</td><td>
	  <select name="LoginPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #LoginPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
</td></tr>
      <tr><td>After Signup Page</td><td>
	  
	  	<select name="AfterSignUpPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #AfterSignUpPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select>
</td></tr>
      <tr><td>After Login Page</td><td>
	  <select name="AfterLoginPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #AfterLoginPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>

			<tr><td>Privacy Policy Page</td><td>
	  <select name="PrivacyPolicyPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #PrivacyPolicyPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>
			<tr><td>Disclaimer page</td><td>
	  <select name="DisclaimerPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #DisclaimerPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>  
			<tr><td>Member Conduct page</td><td>
	  <select name="conductpage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #conductpage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr> 
			<tr><td>GetPasswordPage</td><td>
	  <select name="GetPasswordPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #GetPasswordPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr> 
			<tr><td>Member Information Page</td><td>
	  <select name="informationpage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #informationpage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>
					<tr><td>Check Out Page </td><td>
	  <select name="CheckOutPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #CheckOutPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop></td><td>
		</select></td></tr>
			<tr><td>SearchPage</td><td>
	  <select name="SearchPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #SearchPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>
			<tr><td>Search Members Results Page</td><td>
	  <select name="SearchResultsPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#pagename#" <cfif #SearchResultsPage# is #pagename#>selected</cfif>>#pagename#
		</cfloop>
		</select></td></tr>
</table>
	</td><td>
	<table>

			<tr><td>Allow Member to have a Contacts List?</td><td>Yes: <input type="radio" name="AllowContacts" value="1" <cfif #AllowContacts# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowContacts" value="0" <cfif #AllowContacts# is 0>checked</cfif>></td></tr> 
			<tr><td>Allow Members to Create Newsletters?</td><td>Yes: <input type="radio" name="AllowNewsletters" value="1" <cfif #AllowContacts# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowNewsletters" value="0" <cfif #AllowNewsletters# is 0>checked</cfif>></td></tr> 
	  <tr><td>Allow Members to Create Polls?</td><td>Yes: <input type="radio" name="AllowPolls" value="1" <cfif #AllowPolls# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowPolls" value="0" <cfif #AllowPolls# is 0>checked</cfif>></td></tr>
	  <tr><td>Allow Members to Create A Gallery?</td><td>Yes: <input type="radio" name="AllowGallery" value="1" <cfif #AllowGallery# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowGallery" value="0" <cfif #AllowGallery# is 0>checked</cfif>></td></tr>
	  <tr><td>Allow Members to Create A Calendar?</td><td>Yes: <input type="radio" name="AllowCalendar" value="1" <cfif #AllowCalendar# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowCalendar" value="0" <cfif #AllowCalendar# is 0>checked</cfif>></td></tr>
			
		<tr><td>Allow Members to Create Articles?</td><td>Yes: <input type="radio" name="AllowArticles" value="1" <cfif #AllowArticles# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowArticles" value="0" <cfif #AllowArticles# is 0>checked</cfif>></td></tr> 
	  <tr><td>Allow Members to Create a Guest Book?</td><td>Yes: <input type="radio" name="AllowGuestBook" value="1" <cfif #AllowGuestBook# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="AllowGuestBook" value="0" <cfif #AllowGuestBook# is 0>checked</cfif>></td></tr> 
	  <tr><td>Member Can Become an Affiliate</td><td>Yes: <input type="radio" name="CanBecomeAffiliate" value="1" <cfif #CanBecomeAffiliate# is 1>checked</cfif>>&nbsp;&nbsp;&nbsp;
	  No: <input type="radio" name="CanBecomeAffiliate" value="0" <cfif #CanBecomeAffiliate# is 0>checked</cfif>></td></tr> 

			<tr><td>Member Basic Profile Questions</td><td>
	  <select name="ProfileSurveyID">
		<option value="0">None
			<cfif #SurveyFileExists#>
			<cfloop query="AllSurveys">
				<option value="#SurveyID#" <cfif #ProfileSurveyID# is #SurveyID#>selected</cfif>>#SurveyName#
			</cfloop></cfif>
		</select></td></tr>
		<tr><td>Member Discussion Forum</td><td>
	  <select name="MemberForum">
		<option value="0">None
			<cfif #ForumFileExists#>
			<cfloop query="AllForums">
				<option value="#NameID#" <cfif #MemberForum# is #NameID#>selected</cfif>>#ForumName#
			</cfloop></cfif>
		</select></td></tr>
		<tr><td>Use default member navigation?</td><td>
	  <select name="defaultNav">
		<option value="0"<cfif #defaultNav# is 0> selected</cfif>>Yes
		<option value="1"<cfif #defaultNav# is 1> selected</cfif>>No</option>
		</select></td></tr>
		<TR>
			<TD valign="top">
			Word to use on member category sign up page and member category home page: </TD>
			<TD><INPUT type="text" name="TypeWord" value="#TypeWord#" size=50 maxLength="125"></TD>
		</TR>
</table>
	  </td>
    </tr>

    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit1" value="Reset"> 
      </td>
      <td></td>
    </tr>
  </table>
</form>

</cfoutput>
