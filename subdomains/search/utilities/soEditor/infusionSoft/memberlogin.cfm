<script src="js/jquery-latest.js"></script>
<cfparam name="message" default=''>
<cfparam name="loginPageNo" default=1>
<cfparam name="uName" default="">
<cfparam name="pWord" default="">
<cfset t =  "1,0,0,0,0,0,0,0,0,0,0">
<CF_AHEX mode=TO in="#t#" crypt>
<cfset t = #CF_AHEX.out#>
<cfset password=pword>
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
  <cfset AfterLoginPage=#MemberConfig.AfterLoginPage#>
  <cfset Forgotpasswordpage=#MemberConfig.GetPasswordPage#>
  <cfset SignUpPage=#memberconfig.signuppage#>
  <cfelse>
  <cfset AfterLoginPage="homepage">
  <cfset Forgotpasswordpage="homepage">
  <cfset SignUpPage="homepage">
</cfif>

<Cfif isdefined('form.findpassword')>
  <cfif #form.loginToSite# is 0>
    <p>You need to select the type of login.  Please <a href="javascript:history.go(-1)">click here</a> to try again</p>
    <cfabort>
  </cfif>
  <cfif #form.logintosite# is "school">
    <cfquery name="GetPassword" datasource="#Application.DSN#" password="#Application.DSNpWord#" username="#Application.DSNuName#">
            select members.logon, members.password as pword from email,members
            where email.websiteid=1
            and email.tableid=15
            and email.connectid=members.memberid
            and email.emailaddress like '%#trim(form.email)#%'
        </cfquery>
    <cfif #GetPassword.RecordCount# eq 1>
      <CFMail
            To=#trim(form.email)#
            From=#trim(Application.email)#
            Subject="Password"
                    server="208.112.2.18">
        As requested your #Application.WEBSITENAME# username and password
        Username: #GetPassword.logon# Password: #GetPassword.pword#
      </cfmail>
      <cfset message="Your user name and password have been emailed to you">
      <cfelseif #getpassword.recordcount# gt 1>
      <cfset message="We have found multiple profiles with that same email address - please contact Technical Support at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a> to have this rectified.">
      <cfelse>
      <cfset message="Sorry, but the email address you provided does not exist in our member database or there is some other problem.  Please contact the system administrator at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a>">
    </cfif>
    <cfelse>
    <cfquery name="GetPassword" datasource="wellcoaches" password="#Application.DSNpWord#" username="#Application.DSNuName#">
            select members.logon, members.password as pword from email,members
            where email.websiteid=1
            and email.tableid=15
            and email.connectid=members.memberid
            and email.emailaddress like '%#trim(form.email)#%'
        </cfquery>
    <cfif #GetPassword.RecordCount# eq 1>
      <CFMail
            To=#trim(form.email)#
            From=#trim(Application.email)#
            Subject="Password"
                    server="208.112.2.18">
        As requested your #form.logintosite# username and password
        Username: #GetPassword.logon# Password: #GetPassword.pword#
      </cfmail>
      <cfset message="Your user name and password have been emailed to you">
      <cfelseif #getpassword.recordcount# gt 1>
      <cfset message="We have found multiple profiles with that same email address - please contact Technical Support at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a> to have this rectified.">
      <cfelse>
      <cfset message="Sorry, but the email address you provided does not exist in our member database or there is some other problem.  Please contact the system administrator at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a>">
    </cfif>
  </cfif>
</Cfif>
<cfif loginPageNo is 3>
  <cfif #form.loginToSite# is 0>
    <p>You need to select the type of login.  Please <a href="javascript:history.go(-1)">click here</a> to try again</p>
    <cfabort>
  </cfif>
  <!--- <cfoutput>#form.LoginToSite#/?uname=#uname#&passWord=#password#&page=memberstart&t=#T#</cfoutput><cfabort> --->
  <cflocation url="#form.LoginToSite#/?pageid=memberstart&t=#t#&uname=#uname#&passWord=#password#">
</cfif>
<cfif not isdefined('page')>
  <cfset page="homepage">
</cfif>
<cfset PageID=#page#>
<Cfif isdefined('form.findpassword')>
  <cfquery name="GetPassword" datasource="#Application.DSN#" password="#Application.DSNpWord#" username="#Application.DSNuName#">
        select members.logon, members.password as pword from email,members
        where email.websiteid=1
        and email.tableid=15
        and email.connectid=members.memberid
        and email.emailaddress like '%#trim(form.email)#%'
    </cfquery>
  <cfif #GetPassword.RecordCount# eq 1>
    <CFMail
        To=#trim(form.email)#
        From=#trim(Application.email)#
        Subject="Password"
                server="208.112.2.18">
      As requested your #Application.WEBSITENAME# username and password
      Username: #GetPassword.logon# Password: #GetPassword.pword#
    </cfmail>
    <cfset message="Your user name and password have been emailed to you">
    <cfelseif #getpassword.recordcount# gt 1>
    <cfset message="We have found multiple profiles with that same email address - please contact Technical Support at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a> to have this rectified.">
    <cfelse>
    <cfset message="3 Sorry, but the email address you provided does not exist in our member database or there is some other problem.  Please contact the system administrator at <a href=""mailto:techsupport@wellcoaches.com"">techsupport@wellcoaches.com</a>">
  </cfif>
</Cfif>
<cfparam name="AfterLoginPage" default="#page#">
<cfparam name="Forgotpasswordpage" default="#page#">
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
  <cfset AfterLoginPage=#MemberConfig.AfterLoginPage#>
  <cfset Forgotpasswordpage=#MemberConfig.GetPasswordPage#>
  <cfset SignUpPage=#memberconfig.signuppage#>
  <cfelse>
  <cfset AfterLoginPage="homepage">
  <cfset Forgotpasswordpage="homepage">
  <cfset SignUpPage="homepage">
</cfif>
<style>
.formtext{
 font-family:Arial, Helvetica, sans-serif;
 font-size:12px;
}
</style>
<script>
	function validateForm(){
		
		if($.trim($('#uName').val()) == ""){
			$('#uName_error').html('User Name is required');
			return false;
		}else if($.trim($('#pWord').val()) == ""){
			$('#pWord_error').html('Password is required');
			return false;
		}
	}

	function changeAction(urlaction){
		document.CHLogin.action=urlaction;
	}

</script> 
<cfoutput>
  <form method="post" action="http://www.wellcoaches.com/coaching/loginlogic.cfm" name="CHLogin" id="CHLogin" name="memberloginform" onSubmit="return validateForm()" target="_blank">
  <input type="hidden" name="lastURL" value="#Page#">
  <input type="hidden" name="page" value="#Page#">
  <input type="hidden" name="t" value="#t#">
  <input type="hidden" name="uName" value="#uName#">
  <input type="hidden" name="loginPageNo" value="3" />
  <table width=100%>
    <cfif #message# neq ''>
      <tr>
        <td align=center><font color="Red">#message#</font></td>
      </tr>
    </cfif>
    <tr>
      <td valign="top" class=formtext><P> 
        User Name<input name="uName" id="uName" size=25 maxlength=50 >
        <span id="uName_error" style="color:##FF0000"></span>
        <br>
        Password <input type="password" id="pWord" name="pWord" size=25 maxlength=50 >
        <span id="pWord_error" style="color:##FF0000"></span>
        <br />
       <input type="submit" value="Next" name="B1">
        </P></td>
    </tr>
  </table>
  </form>
</cfoutput> 