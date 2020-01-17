 <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
  <cfinvokeargument name="FileName" value="VotingConfig">
  <cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>
<cfparam name="AllowNonMembers" default='none'>
<cfparam name="EmailAdmin" default='none'>
<cfparam name="CaptureIPAddress" default='none'>
<cfparam name="AdminEmailText" default='none'>
<cfparam name="AllowNonMembersPolls" default='none'>
<cfif #TheFileExists# is "true">
  <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
    <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
    <cfinvokeargument name="ThisFileName" value="VotingConfig">
    <cfinvokeargument name="IDFieldName" value="VotingConfigID">
    <cfinvokeargument name="IDFieldValue" value="0000000001">
  </cfinvoke>
  <cfoutput query="Utilities"> 
    <cfset AllowNonMembers=#AllowNonMembers#>
    <cfset EmailAdmin=#EmailAdmin#>
    <cfset CaptureIPAddress=#CaptureIPAddress#>
    <cfset AdminEmailText=#AdminEmailText#>
    <cfset AllowNonMembersPolls=#AllowNonMembersPolls#>
	<cfset AdminEmailText = replace(#AdminEmailText#,"~",",","ALL")>
  </cfoutput> 
</cfif>
<cfif isDefined('form.submit')>
  <cfif not isdefined('form.AllowNonMembers')>
    <cfset form.AllowNonMembers=0>
  </cfif>
  <cfif not isdefined('form.CaptureIPAddress')>
    <cfset form.CaptureIPAddress=0>
  </cfif>
  <cfif not isdefined('form.EmailAdmin')>
    <cfset form.EmailAdmin=0>
  </cfif>
  <cfif not isdefined('form.AllowNonMembersPolls')>
    <cfset form.AllowNonMembersPolls=0>
  </cfif>
  <cfset form.AdminEmailText = replace(#form.AdminEmailText#,",","~","ALL")>
  <cfset form.AdminEmailText = replace(#form.AdminEmailText#,"'","`","ALL")>
  <cfif #TheFileExists# is "true">
    <cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
      <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
      <cfinvokeargument name="ThisFileName" value="VotingConfig">
      <cfinvokeargument name="XMLFields" value="AllowNonMembers,EmailAdmin,CaptureIPAddress,AdminEmailText,AllowNonMembersPolls">
      <cfinvokeargument name="XMLFieldData" value="#form.AllowNonMembers#,#form.EmailAdmin#,#form.CaptureIPAddress#,#form.AdminEmailText#,#form.AllowNonMembersPolls#">
      <cfinvokeargument name="XMLIDField" value="VotingConfigID">
      <cfinvokeargument name="XMLIDValue" value="0000000001">
    </cfinvoke>
    <cfelse>
    <cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
      <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
      <cfinvokeargument name="ThisFileName" value="VotingConfig">
      <cfinvokeargument name="XMLFields" value="AllowNonMembers,EmailAdmin,CaptureIPAddress,AdminEmailText,AllowNonMembersPolls">
      <cfinvokeargument name="XMLFieldData" value="#form.AllowNonMembers#,#form.EmailAdmin#,#form.CaptureIPAddress#,#form.AdminEmailText#,#form.AllowNonMembersPolls#">
      <cfinvokeargument name="XMLIDField" value="VotingConfigID">
    </cfinvoke>
  </cfif>
  <cflocation url="adminheader.cfm?action=welcome">
</cfif>
<cfoutput> <h1>Voting and Results Configuration</h1> <br>
<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"> 
    <center>
      <table>
        <tr> 
          <td valign="top"> <table>
              <tr> 
                  <td>Allow Non Members to answer polls?</td>
				<td> <input type="radio" name="AllowNonMembersPolls" value="No"<cfif #AllowNonMembersPolls# is "No">checked</cfif>>
                  No<br> <input type="radio" name="AllowNonMembersPolls" value="Yes" <cfif #AllowNonMembersPolls# is "Yes">checked</cfif>>
                  Yes<br> <br></td>
              </tr>
              <tr> 
                  <td>Allow Non Members to answer surveys?</td>
                <td> <cfif #AllowNonMembers# is "No">
                    <input type="radio" name="AllowNonMembers" value="No" checked>
                    No<br>
                    <input type="radio" name="AllowNonMembers" value="Yes">
                    Yes<br>
                    <cfelseif #AllowNonMembers# is "Yes">
                    <input type="radio" name="AllowNonMembers" value="No">
                    No<br>
                    <input type="radio" name="AllowNonMembers" value="Yes" checked>
                    Yes<br>
                    <cfelse>
                    <input type="radio" name="AllowNonMembers" value="No" checked>
                    No<br>
                    <input type="radio" name="AllowNonMembers" value="Yes">
                    Yes<br>
                  </cfif> <br></td>
              </tr>

              <tr> 
                <td>Allow users to vote more then once?</td>
                <td> <input type="radio" name="CaptureIPAddress" value="No"<cfif #CaptureIPAddress# is "No">checked</cfif>>
                  No<br> <input type="radio" name="CaptureIPAddress" value="Yes" <cfif #CaptureIPAddress# is "Yes">checked</cfif>>
                  Yes<br> <br></td>
              </tr>
			  
              <tr> 
                <td>Email Admin when Poll or Survey answered?</td>
                <td> <input type="radio" name="EmailAdmin" value="No"<cfif #EmailAdmin# is "No">checked</cfif>>
                  No<br> <input type="radio" name="EmailAdmin" value="Yes" <cfif #AllowNonMembersPolls# is "Yes">checked</cfif>>
                  Yes<br> <br></td>
              </tr>
              <tr> 
                <td>Text for Admin Email</td>
                <td> <textarea name="AdminEmailText" cols=50 rows=5>#AdminEmailText#</textarea> 
                  <br></td>
              </tr>
            </table></td>
        </tr>

        <tr> 
          <td> <p> 
              <input type="submit" name="submit" value="Apply">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="submit" name="reset" value="Reset">
              <br>
          </td>
          <td></td>
        </tr>
      </table>
    </center>
  </div>
</form>
</cfoutput>

