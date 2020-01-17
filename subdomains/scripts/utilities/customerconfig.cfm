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
</cfinvoke>

<cfparam name="AfterLoginPage" default="homepage">
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
<cfparam name="SelectFavorites" default="0">
<cfparam name="OrderHistory" default="0">
<cfparam name="AllowArticles" default="0">
<cfparam name="CustomerForum" default="0">
<cfparam name="ReOrderLists" default="0">
<cfparam name="SpecificPricing" default="0">
<cfparam name="SellProducts" default="0">
<cfparam name="CanBecomeAffiliate" default="0">
<cfparam name="OrderTracking" default=0>

<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="CustomerConfig">
		<cfinvokeargument name="ThisPath" value="#Application.TheFilesPath#">
</cfinvoke>
<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
		method="GetXMLRecords" returnvariable="CustomerConfig">
		<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
		<cfinvokeargument name="ThisFileName" value="CustomerConfig">
		<cfinvokeargument name="IDFieldName" value="CustomerConfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="CustomerConfig">
		<cfset AfterLoginPage=#AfterLoginPage#>
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
		<cfset SelectFavorites=#SelectFavorites#>
		<cfset OrderHistory=#OrderHistory#>
		<cfset AllowArticles=#AllowArticles#>
		<cfset CustomerForum=#CustomerForum#>
		<cfset ReOrderLists=#ReOrderLists#>
		<cfset SpecificPricing=#SpecificPricing#>
		<cfset SellProducts=#SellProducts#>
		<cfset CanBecomeAffiliate=#CanBecomeAffiliate#>
		<cfset OrderTracking=#OrderTracking#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="CustomerConfig">
			<cfinvokeargument name="XMLFields" value="AfterLoginPage,Disclaimerpage,PrivacyPolicyPage,ConductPage,InformationPage,LoginPage,SearchResultsPage,CheckOutPage,ProfileSurveyID,GetPasswordPage,SearchPage,SelectFavorites,OrderHistory,AllowArticles,CustomerForum,ReOrderLists,SpecificPricing,SellProducts,CanBecomeAffiliate,OrderTracking">
			<cfinvokeargument name="XMLFieldData" value="#form.AfterLoginPage#,#form.Disclaimerpage#,#form.PrivacyPolicyPage#,#form.ConductPage#,#form.InformationPage#,#form.LoginPage#,#form.SearchResultsPage#,#form.CheckOutPage#,#form.ProfileSurveyID#,#form.GetPasswordPage#,#form.SearchPage#,#form.SelectFavorites#,#form.OrderHistory#,#form.AllowArticles#,#form.CustomerForum#,#form.ReOrderLists#,#form.SpecificPricing#,#form.SellProducts#,#form.CanBecomeAffiliate#,#form.OrderTracking#">
			<cfinvokeargument name="XMLIDField" value="CustomerConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="CustomerConfig">
			<cfinvokeargument name="XMLFields" value="AfterLoginPage,Disclaimerpage,PrivacyPolicyPage,ConductPage,InformationPage,LoginPage,SearchResultsPage,CheckOutPage,ProfileSurveyID,GetPasswordPage,SearchPage,SelectFavorites,OrderHistory,AllowArticles,CustomerForum,ReOrderLists,SpecificPricing,SellProducts,CanBecomeAffiliate,OrderTracking">
			<cfinvokeargument name="XMLFieldData" value="#form.AfterLoginPage#,#form.Disclaimerpage#,#form.PrivacyPolicyPage#,#form.ConductPage#,#form.InformationPage#,#form.LoginPage#,#form.SearchResultsPage#,#form.CheckOutPage#,#form.ProfileSurveyID#,#form.GetPasswordPage#,#form.SearchPage#,#form.SelectFavorites#,#form.OrderHistory#,#form.AllowArticles#,#form.CustomerForum#,#form.ReOrderLists#,#form.SpecificPricing#,#form.SellProducts#,#form.CanBecomeAffiliate#,#form.OrderTracking#">
			<cfinvokeargument name="XMLIDField" value="CustomerConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>
<cfoutput> 
  <h1>Customers Section Configuration</h1>
  <br>
  <form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
    <input type="hidden" name="Action" value="#Action#">
    <table><tr><td valign="top">
      <table>
        <tr>
          <td>Customer Log In Page</td>
          <td> <select name="LoginPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #LoginPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select> </td>
        </tr>
        <tr>
          <td>After Login Page</td>
          <td> <select name="AfterLoginPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #AfterLoginPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Privacy Policy Page</td>
          <td> <select name="PrivacyPolicyPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #PrivacyPolicyPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Disclaimer page</td>
          <td> <select name="DisclaimerPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #DisclaimerPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Customer Conduct page</td>
          <td> <select name="conductpage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #conductpage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Get Password Page</td>
          <td> <select name="GetPasswordPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #GetPasswordPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Customer Information Page</td>
          <td> <select name="informationpage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #informationpage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Check Out Page </td><td>
          <select name="CheckOutPage">
            <option value="0">None 
            <cfloop query="AllPages">
              <option value="#pagename#" <cfif #CheckOutPage# is #pagename#>selected</cfif>>#pagename# 
            </cfloop></td>
          </select></tr>
        <tr>
          <td>Customer Search Page</td>
          <td> <select name="SearchPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #SearchPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
        <tr>
          <td>Search Customers Results Page</td>
          <td> <select name="SearchResultsPage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #SearchResultsPage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td>
        </tr>
      </table></td>
      <td> <table>
          <tr> 
            <td>Allow Customers to Select Favorites?</td>
            <td>Yes: 
              <input type="radio" name="SelectFavorites" value="1" <cfif #SelectFavorites# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="SelectFavorites" value="0" <cfif #SelectFavorites# is 0>checked</cfif>></td>
          </tr>
          <tr> 
            <td>Allow Customers to View Order History?</td>
            <td>Yes: 
              <input type="radio" name="OrderHistory" value="1" <cfif #OrderHistory# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="OrderHistory" value="0" <cfif #OrderHistory# is 0>checked</cfif>></td>
          </tr>
<!---           <tr> 
            <td>Allow Customers to Create Re-Order Lists?</td>
            <td>Yes: 
              <input type="radio" name="ReOrderLists" value="1" <cfif #ReOrderLists# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="ReOrderLists" value="0" <cfif #ReOrderLists# is 0>checked</cfif>></td>
          </tr> ---><input type="hidden" name="ReOrderLists" value="0">

<!---           <tr>
            <td>Allow Customers to Sell Their Own Products?</td>
            <td>Yes: 
              <input type="radio" name="SellProducts" value="1" <cfif #SellProducts# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="SellProducts" value="0" <cfif #SellProducts# is 0>checked</cfif>></td>
          </tr> ---><input type="hidden" name="SellProducts" value="0">
          <tr> 
            <td>Allow Customers to Create Articles?</td>
            <td>Yes: 
              <input type="radio" name="AllowArticles" value="1" <cfif #AllowArticles# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="AllowArticles" value="0" <cfif #AllowArticles# is 0>checked</cfif>></td>
          </tr>
<!---           <tr> 
            <td>Allow Customer Order Tracking?</td>
            <td>Yes: 
              <input type="radio" name="OrderTracking" value="1" <cfif #OrderTracking# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="OrderTracking" value="0" <cfif #OrderTracking# is 0>checked</cfif>></td>
          </tr> ---><input type="hidden" name="OrderTracking" value="0">
          <tr> 
            <td>Customer Can Become a Member</td>
            <td>Yes: 
              <input type="radio" name="CanBecomeAffiliate" value="1" <cfif #CanBecomeAffiliate# is 1>checked</cfif>>
              &nbsp;&nbsp;&nbsp; No: 
              <input type="radio" name="CanBecomeAffiliate" value="0" <cfif #CanBecomeAffiliate# is 0>checked</cfif>></td>
          </tr>
          <tr> 
            <td>Customers Basic Profile Questions</td>
            <td> <select name="ProfileSurveyID">
                <option value="0">None 
                <cfif #SurveyFileExists#>
                  <cfloop query="AllSurveys">
                    <option value="#SurveyID#" <cfif #ProfileSurveyID# is #SurveyID#>selected</cfif>>#SurveyName# 
                  </cfloop>
                </cfif>
              </select></td>
          </tr>
          <tr> 
            <td>Customers Discussion Forum</td>
            <td> <select name="CustomerForum">
                <option value="0">None 
                <cfif #ForumFileExists#>
                  <cfloop query="AllForums">
                    <option value="#NameID#" <cfif #CustomerForum# is #NameID#>selected</cfif>>#ForumName# 
                  </cfloop>
                </cfif>
              </select></td>
          </tr>
        </table></td>
      </tr>
	            <tr> 
            <td>Text for the Customer Personal Home Page</td>
            <td><a href="javascript:GetEditor('thisform','SpecificPricing')" class=box>Click here for the editor</a><br>
              <textarea name="SpecificPricing">#SpecificPricing#</textarea></td>
          </tr>
      <tr> 
        <td><div align="center"><center>
          <p>
            <input type="submit" name="submit" value="Apply">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="submit" name="submit1" value="Reset">
        </td>
        <td></td>
      </tr>
    </table>
  </form>
</cfoutput> 