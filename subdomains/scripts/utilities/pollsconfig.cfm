 <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
  <cfinvokeargument name="FileName" value="pollsconfig">
  <cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>
<cfparam name="ConnectDiscussions" default='none'>
<cfparam name="RoomToConnect" default='none'>
<cfparam name="AddNoneAnswer" default='none'>
<cfparam name="TextOfNoneAnswer" default='none'>
<cfparam name="NoOfQuestions" default='none'>
<cfif #TheFileExists# is "true">
  <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
    <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
    <cfinvokeargument name="ThisFileName" value="pollsconfig">
    <cfinvokeargument name="IDFieldName" value="pollsconfigID">
    <cfinvokeargument name="IDFieldValue" value="0000000001">
  </cfinvoke>
  <cfoutput query="Utilities"> 
    <cfset ConnectDiscussions=#ConnectDiscussions#>
    <cfset RoomToConnect=#RoomToConnect#>
    <cfset AddNoneAnswer=#AddNoneAnswer#>
    <cfset TextOfNoneAnswer=#TextOfNoneAnswer#>
    <cfset NoOfQuestions=#NoOfQuestions#>
  </cfoutput> 
</cfif>
<cfif isDefined('form.submit')>
  <cfif not isdefined('form.ConnectDiscussions')>
    <cfset form.ConnectDiscussions=0>
  </cfif>
  <cfif not isdefined('form.AddNoneAnswer')>
    <cfset form.AddNoneAnswer=0>
  </cfif>
  <cfif not isdefined('form.RoomToConnect')>
    <cfset form.RoomToConnect=0>
  </cfif>
  <cfif not isdefined('form.NoOfQuestions')>
    <cfset form.NoOfQuestions=0>
  </cfif>
  <cfif #TheFileExists# is "true">
    <cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
      <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
      <cfinvokeargument name="ThisFileName" value="pollsconfig">
      <cfinvokeargument name="XMLFields" value="ConnectDiscussions,RoomToConnect,AddNoneAnswer,TextOfNoneAnswer,NoOfQuestions">
      <cfinvokeargument name="XMLFieldData" value="#form.ConnectDiscussions#,#form.RoomToConnect#,#form.AddNoneAnswer#,#form.TextOfNoneAnswer#,#form.NoOfQuestions#">
      <cfinvokeargument name="XMLIDField" value="pollsconfigID">
      <cfinvokeargument name="XMLIDValue" value="0000000001">
    </cfinvoke>
    <cfelse>
    <cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
      <cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
      <cfinvokeargument name="ThisFileName" value="pollsconfig">
      <cfinvokeargument name="XMLFields" value="ConnectDiscussions,RoomToConnect,AddNoneAnswer,TextOfNoneAnswer,NoOfQuestions">
      <cfinvokeargument name="XMLFieldData" value="#form.ConnectDiscussions#,#form.RoomToConnect#,#form.AddNoneAnswer#,#form.TextOfNoneAnswer#,#form.NoOfQuestions#">
      <cfinvokeargument name="XMLIDField" value="pollsconfigID">
    </cfinvoke>
  </cfif>
  <cflocation url="adminheader.cfm?action=welcome">
</cfif>

<cfoutput>
<h1>Polls Configuration</h1> <br>
<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"> 
    <center>
      <table>
        <tr> 
          <td valign="top"> <table>
              <tr> 
                <td>All Users to create polls?</td>
				<td> <input type="radio" name="NoOfQuestions" value="No"<cfif #NoOfQuestions# is "No">checked</cfif>>
                  No<br> <input type="radio" name="NoOfQuestions" value="Yes" <cfif #NoOfQuestions# is "Yes">checked</cfif>>
                  Yes<br> <br></td>
              </tr>
              <tr> 
                <td>Connect All Questions to the Discussion Board?</td>
                <td> <cfif #ConnectDiscussions# is "No">
                    <input type="radio" name="ConnectDiscussions" value="No" checked>
                    No<br>
                    <input type="radio" name="ConnectDiscussions" value="Yes">
                    Yes<br>
                    <cfelseif #ConnectDiscussions# is "Yes">
                    <input type="radio" name="ConnectDiscussions" value="No">
                    No<br>
                    <input type="radio" name="ConnectDiscussions" value="Yes" checked>
                    Yes<br>
                    <cfelse>
                    <input type="radio" name="ConnectDiscussions" value="No" checked>
                    No<br>
                    <input type="radio" name="ConnectDiscussions" value="Yes">
                    Yes<br>
                  </cfif> <br></td>
              </tr>
              <tr> 
                <td>Room on the Discussion Board to Connect to</td>
                <td> <select name="RoomToConnect">
                    <cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
						method="GetXMLRecords" returnvariable="GetForums">
						<cfinvokeargument name="ThisPath" value="files">
						<cfinvokeargument name="ThisFileName" value="ForumNames">
					</cfinvoke>
                    <cfloop query="GetForums">
                      <option value="#NameID#" <cfif #RoomToConnect# is #NameID#>selected</cfif>>#trim(forumname)#
                    </cfloop>
                  </select> <br></td>
              </tr>
              <tr> 
                <td>Add "NONE" to all questions</td>
                <td> <input type="radio" name="AddNoneAnswer" value="No"<cfif #AddNoneAnswer# is "No">checked</cfif>>
                  No<br> <input type="radio" name="AddNoneAnswer" value="Yes" <cfif #AddNoneAnswer# is "Yes">checked</cfif>>
                  Yes<br> <br></td>
              </tr>
              <tr> 
                <td>Text for "NONE" Answer</td>
                <td> <textarea name="TextOfNoneAnswer" cols=50 rows=5>#TextOfNoneAnswer#</textarea> 
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

