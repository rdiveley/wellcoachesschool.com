
<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="MemberParams">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfparam name="RegistrationFields" default='0'>
<cfparam name="RenewalEmail" default='none'>
<cfparam name="thankyoutext" default='none'>
<cfparam name="NLSignUP" default='No'>
<cfparam name="EmailText" default='none'>
<cfparam name="generatePassword" default='No'>
<cfparam name="UseEmailAsUserName" default='No'>
<cfparam name="MemberHomePageText" default='none'>
<cfparam name="ParamID" default='0000000001'>
<cfparam name="ProfileFields" default="0">
<cfset RegistrationFields=replace(#RegistrationFields#,"/",",","ALL")>
<cfset ProfileFields=replace(#ProfileFields#,"/",",","ALL")>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="MemberParams">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="MemberParams">
	</cfinvoke>
	<cfoutput query="MemberParams">
		<cfset RegistrationFields=#RegistrationFields#>
		<cfset RenewalEmail=#RenewalEmail#>
		<cfset RenewalEmail=replace(#RenewalEmail#,"~",",","ALL")>
		<cfset thankyoutext=#thankyoutext#>
		<cfset thankyoutext=replace(#thankyoutext#,"~",",","ALL")>
		<cfset NLSignUP=#NLSignUP#>
		<cfset EmailText=#EmailText#>
		<cfset EmailText=replace(#EmailText#,"~",",","ALL")>
		<cfset generatePassword=#generatePassword#>
		<cfset UseEmailAsUserName=#UseEmailAsUserName#>
		<cfset MemberHomePageText=#MemberHomePageText#>
		<cfset MemberHomePageText=replace(#MemberHomePageText#,"~",",","ALL")>
		<cfset RegistrationFields=replace(#RegistrationFields#,"/",",","ALL")>
		<Cfset ProfileFields=replace(#ProfileFields#,"/",",","ALL")>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif isdefined('form.RegistrationFields')>
		<cfif #form.RegistrationFields# is "">
			<cfset form.RegistrationFields="0">
		<cfelse>
			<cfset form.RegistrationFields=replace(#form.RegistrationFields#,",","/","ALL")>
		</cfif>
	<cfelse>
		<cfset form.RegistrationFields="0">
	</cfif>
	<cfif isdefined('form.ProfileFields')>
		<cfif #form.ProfileFields# is "">
			<cfset form.ProfileFields="0">
		<cfelse>
			<cfset form.ProfileFields=replace(#form.ProfileFields#,",","/","ALL")>
		</cfif>
	<cfelse>
		<cfset form.ProfileFields="0">
	</cfif>
	<cfif #form.RenewalEmail# is ""><cfset form.RenewalEmail="none"></cfif>
	<cfset #form.RenewalEmail#=replace(#form.RenewalEmail#,",","~","ALL")>
	<cfif #form.thankyoutext# is ""><cfset form.thankyoutext="none"></cfif>
	<cfset #form.thankyoutext#=replace(#form.thankyoutext#,",","~","ALL")>
	<cfif #form.EmailText# is ""><cfset form.EmailText="none"></cfif>
	<cfset #form.EmailText#=replace(#form.EmailText#,",","~","ALL")>
	<cfif #form.MemberHomePageText# is ""><cfset form.MemberHomePageText="none"></cfif>
	<cfset #form.MemberHomePageText#=replace(#form.MemberHomePageText#,",","~","ALL")>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="MemberParams">
			<cfinvokeargument name="XMLFields" 
				value="RegistrationFields,RenewalEmail,thankyoutext,NLSignUP,EmailText,generatePassword,UseEmailAsUserName,MemberHomePageText,ProfileFields">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.RegistrationFields#,#form.RenewalEmail#,#form.thankyoutext#,#form.NLSignUP#,#form.EmailText#,#form.generatePassword#,#form.UseEmailAsUserName#,#form.MemberHomePageText#,#form.ProfileFields#">
			<cfinvokeargument name="XMLIDField" value="ParamID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="MemberParams">
			<cfinvokeargument name="XMLFields" 
				value="RegistrationFields,RenewalEmail,thankyoutext,NLSignUP,EmailText,generatePassword,UseEmailAsUserName,MemberHomePageText,ProfileFields">
			<cfinvokeargument name="XMLFieldData" 
				value="#form.RegistrationFields#,#form.RenewalEmail#,#form.thankyoutext#,#form.NLSignUP#,#form.EmailText#,#form.generatePassword#,#form.UseEmailAsUserName#,#form.MemberHomePageText#,#form.ProfileFields#">
			<cfinvokeargument name="XMLIDField" value="ParamID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>

<br>
<table class=centrecol width=100%>
<tr>
<td><h2>Membership Registration Parameters</h2>
<P>This is where you select what potential members must provide you in the way of information and what the membership signup content will be.</P>
</td>
</tr></table>
<cfoutput>
<cfform action="adminheader.cfm" method="post" name="thisform">
<input type="hidden" name="Action" value="memberparams">
<table>
		<tr><td valign=top width=50%><strong>Select the fields necessary for member registration:</strong><br>
		<strong>Tip:</strong> The more information you ask for, the less likely you are to get it. People will always wonder what you are doing with the information. Only ask for what you absolutely need - you can always put additional information in a profile survey that the members can fill out later.
		</td>
		<td width=50%>
		<table><tr><TD valign=top>
			<input type="checkbox" name="RegistrationFields" value="companyname" <cfif #listfind(RegistrationFields,"companyname")#>checked</cfif>>
          Company Name<br>
		   <input type="checkbox" name="RegistrationFields" value="firstlastname" <cfif #listfind(RegistrationFields,"firstlastname")#>checked</cfif>>
          First and Last Name<br>
          <input type="checkbox" name="RegistrationFields"  value="address" <cfif #listfind(RegistrationFields,"address")#>checked</cfif>>
          Street Address<br>
		  <input type="checkbox" name="RegistrationFields"  value="city" <cfif #listfind(RegistrationFields,"city")#>checked</cfif>>
          City<br>
          <input type="checkbox" name="RegistrationFields"  value="state" <cfif #listfind(RegistrationFields,"state")#>checked</cfif>>
          State<br>
          <input type="checkbox" name="RegistrationFields"  value="zip" <cfif #listfind(RegistrationFields,"zip")#>checked</cfif>>
          Zip<br>
		  <input type="checkbox" name="RegistrationFields"  value="country" <cfif #listfind(RegistrationFields,"country")#>checked</cfif>>
		  Country<br>
		  <input type="checkbox" name="RegistrationFields"  value="phone" <cfif #listfind(RegistrationFields,"phone")#>checked</cfif>>
          Phone<br>
          <input type="checkbox" name="RegistrationFields"  value="emailaddress" <cfif #listfind(RegistrationFields,"emailaddress")#>checked</cfif>>
          Email Address<br>
		  </td><td valign=top>
          <input type="checkbox" name="RegistrationFields"  value="sex" <cfif #listfind(RegistrationFields,"sex")#>checked</cfif>>
          Sex<br>
          <input type="checkbox" name="RegistrationFields" value="MaritalStatus" <cfif #listfind(RegistrationFields,"MaritalStatus")#>checked</cfif>>
          Marital Status<br>
          <input type="checkbox" name="RegistrationFields" value="age" <cfif #listfind(RegistrationFields,"age")#>checked</cfif>>
          Age<br>
          <input type="checkbox" name="RegistrationFields" value="birthdate" <cfif #listfind(RegistrationFields,"birthdate")#>checked</cfif>>
          Birth Date<br>
          <input type="checkbox" name="RegistrationFields" value="officephone" <cfif #listfind(RegistrationFields,"officephone")#>checked</cfif>>
          Office Phone<br>
          <input type="checkbox" name="RegistrationFields" value="cellphone" <cfif #listfind(RegistrationFields,"cellphone")#>checked</cfif>>
          Cell Phone<br>
          <input type="checkbox" name="RegistrationFields" value="faxphone" <cfif #listfind(RegistrationFields,"faxphone")#>checked</cfif>>
          Fax Phone<br>
          <input type="checkbox" name="RegistrationFields" value="occupation" <cfif #listfind(RegistrationFields,"occupation")#>checked</cfif>>
          Occupation<br>
		  <input type="checkbox" name="RegistrationFields" value="reseller" <cfif #listfind(RegistrationFields,"reseller")#>checked</cfif>>
          Reseller Information <br>
		  <input type="checkbox" name="RegistrationFields" value="websiteurl" <cfif #listfind(RegistrationFields,"websiteurl")#>checked</cfif>>
          Members Web site URL<br>
        </p></TD></tr></table>
		</td></tr>
				<tr><td valign=top><strong>Select fields to be available for a member search page:</strong>
		</td>
		<td>
			<table><tr><td valign=top>
          <input type="checkbox" name="ProfileFields" value="firstlastname" <cfif #listfind(ProfileFields,"firstlastname")#>checked</cfif>>
          First and Last Name<br>
          <input type="checkbox" name="ProfileFields"  value="address" <cfif #listfind(ProfileFields,"address")#>checked</cfif>>
          Street Address<br>
		  <input type="checkbox" name="ProfileFields"  value="city" <cfif #listfind(ProfileFields,"city")#>checked</cfif>>
          City<br>
          <input type="checkbox" name="ProfileFields"  value="state" <cfif #listfind(ProfileFields,"state")#>checked</cfif>>
          State<br>
          <input type="checkbox" name="ProfileFields"  value="zip" <cfif #listfind(ProfileFields,"zip")#>checked</cfif>>
          Zip<br>
		  <input type="checkbox" name="ProfileFields"  value="country" <cfif #listfind(ProfileFields,"country")#>checked</cfif>>
		  Country<br>
		  <input type="checkbox" name="ProfileFields"  value="phone" <cfif #listfind(ProfileFields,"phone")#>checked</cfif>>
          Phone<br>
          <input type="checkbox" name="ProfileFields"  value="emailaddress" <cfif #listfind(ProfileFields,"emailaddress")#>checked</cfif>>
          Email Address<br>
		  </td><td valign=top>
          <input type="checkbox" name="ProfileFields"  value="sex" <cfif #listfind(ProfileFields,"sex")#>checked</cfif>>
          Sex<br>
          <input type="checkbox" name="ProfileFields" value="MaritalStatus" <cfif #listfind(ProfileFields,"MaritalStatus")#>checked</cfif>>
          Marital Status<br>
          <input type="checkbox" name="ProfileFields" value="age" <cfif #listfind(ProfileFields,"age")#>checked</cfif>>
          Age<br>
          <input type="checkbox" name="ProfileFields" value="birthdate" <cfif #listfind(ProfileFields,"birthdate")#>checked</cfif>>
          Birth Date<br>
          <input type="checkbox" name="ProfileFields" value="officephone" <cfif #listfind(ProfileFields,"officephone")#>checked</cfif>>
          Office Phone<br>
          <input type="checkbox" name="ProfileFields" value="cellphone" <cfif #listfind(ProfileFields,"cellphone")#>checked</cfif>>
          Cell Phone<br>
          <input type="checkbox" name="ProfileFields" value="faxphone" <cfif #listfind(ProfileFields,"faxphone")#>checked</cfif>>
          Fax Phone<br>
          <input type="checkbox" name="ProfileFields" value="occupation" <cfif #listfind(ProfileFields,"occupation")#>checked</cfif>>
          Occupation<br>
		  <input type="checkbox" name="ProfileFields" value="websiteurl" <cfif #listfind(ProfileFields,"websiteurl")#>checked</cfif>>
          Members Web site URL<br>
        </p>
		</td></tr></table>
		</td></tr>
		<tr><td>
		
		<strong>Generate Password or allow new member to type one in?:</strong></td><td> 
		<select name="generatePassword">
			<option value="doNotGenerate" <cfif #GeneratePassword# is "doNotGenerate">selected</cfif>>Allow Member entry of password</option>
			<option value="generate" <cfif #GeneratePassword# is "generate">selected</cfif>>Generate Password</option>
		</select>
		</td></tr>
		<tr>
        <td><strong>Use Email Address as the User name?:</strong></td>
        <td><select name="UseEmailAsUserName">
            <option value="Yes" <cfif #UseEmailAsUserName# is "Yes">selected</cfif>>User email address </option>
            <option value="No" <cfif #UseEmailAsUserName# is "No">selected</cfif>>Allow User Entry of User Name</option>
          </select></td>
      </tr>
		<tr>
        <td><strong>Automatically sign new members up for the newsletter?:</strong> 
        </td>
        <td><select name="NLSignUP">
            <option value="Yes" <cfif #NLSignUP# is "Yes">selected</cfif>>Yes</option>
            <option value="No" <cfif #NLSignUP# is "No">selected</cfif>>No</option>
          </select> </td>
      </tr>
		<tr>
	    <td valign=top><strong>Text for the email sent to a new member:</strong> 
        </td>
        <td>
		<a href="javascript:GetEditor('thisform','EmailText')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="EmailText">#EmailText#</textarea> </td>
      </tr>
		<tr>
        <td valign=top><strong>Text for the thank you page after a member signs 
          up:</strong><br>
        </td>
        <td valign=top>
		<a href="javascript:GetEditor('thisform','thankyoutext')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="thankyoutext">#thankyoutext#</textarea></td>
		</tr>
		<tr>
        <td valign=top><strong>Text for the Member Home page</strong></td>
        <td>
		<a href="javascript:GetEditor('thisform','MemberHomePageText')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="MemberHomePageText">#MemberHomePageText#</textarea></td>
		</tr>
			
        <td valign=top><strong>Email sent to members warning them of automatic renewal of 
          their membership</strong> </td>
        <td><a href="javascript:GetEditor('thisform','RenewalEmail')" class=box>Click here for the editor</a><br>
		<textarea cols=30 rows=5 name="RenewalEmail">#RenewalEmail#</textarea> </td>
      </tr>
	<tr>
	    <td valign=top><input type="submit" name="submit" value="Continue"></td>
        <td>&nbsp;</td>
	</tr><tr>
	    <td valign=top>&nbsp;</td>
	</tr></table>
</cfform>
</cfoutput>