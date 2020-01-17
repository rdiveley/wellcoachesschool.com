
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="classpageconfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
	<cfinvokeargument name="orderbystatement" value=" order by pagename">
</cfinvoke>

<cfparam name="classesPage" default='none'>
<cfparam name="membersPage" default='none'>
<cfparam name="facultyPage" default='none'>
<cfparam name="licencePage" default='none'>
<cfparam name="webcoachPage" default='none'>
<cfparam name="loginPage" default='none'>
<cfparam name="joinPage" default='none'>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="classpageconfig">
		<cfinvokeargument name="IDFieldName" value="utilityID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset classesPage=#classesPage#>
		<cfset membersPage=#membersPage#>
		<cfset facultyPage=#facultyPage#>
		<cfset licencePage=#licencePage#>
		<cfset webcoachPage=#webcoachPage#>
		<cfset loginPage=#loginPage#>
		<cfset joinPage=#joinPage#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="classpageconfig">
			<cfinvokeargument name="XMLFields" value="classesPage,membersPage,facultyPage,licencePage,webcoachPage,loginPage,joinPage">
			<cfinvokeargument name="XMLFieldData" value="#form.classesPage#,#form.membersPage#,#form.facultyPage#,#form.licencePage#,#form.webcoachPage#,#form.loginPage#,#form.joinPage#">
			<cfinvokeargument name="XMLIDField" value="UtilityID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="classpageconfig">
			<cfinvokeargument name="XMLFields" value="classesPage,membersPage,facultyPage,licencePage,webcoachPage,loginPage,joinPage">
			<cfinvokeargument name="XMLFieldData" value="#form.classesPage#,#form.membersPage#,#form.facultyPage#,#form.licencePage#,#form.webcoachPage#,#form.loginPage#,#form.joinPage#">
			<cfinvokeargument name="XMLIDField" value="UtilityID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>


<h1>Classes Pages Configuration</h1>

<p><font face="Arial, Helvetica, sans-serif" color="#CCFFFF"><b>Select the pages that are the "home" page for each section</b></font></p>
<cfoutput>
<cfset formaction=URLSessionFormat("adminheader.cfm")>
<form action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
  <input type="hidden" name="lID" value="#lID#">
  <input type="hidden" name="Action" value="#Action#">
  <div align="center"><center>
  <table>
    <tr>
      <td>Fitness Coach</td>
	  <td><select name="classesPage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #classesPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
	  </td>
	</tr><tr>
	  <td>Membership & Classes</td>
	  <td><select name="membersPage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #membersPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
	  </td>
	</tr><tr>
	<td>Faculty<br>
	  <td><select name="facultyPage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #facultyPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
	  </td>
	</tr><tr>
<td>Health Coach</td>
	  <td>
	  <select name="webcoachPage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #webcoachPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
	  </td>
	</tr><tr>
<td>Wellness Coach
	  <td>
	  <select name="licencePage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #licencePage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
      </td>
      	  
    </tr>
	<tr>
		<td>Login Page</td>
		  <td>
		  <select name="loginPage">
			<cfloop query="allPages">
				<option value="#pagename#"<cfif #loginPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
			</cfloop>
			</select>
		  </td>
	</tr><tr>
		<td>Join Now Page
	  <td>
	  <select name="joinPage">
	  	<cfloop query="allPages">
			<option value="#pagename#"<cfif #joinPage# is #pagename#> selected</cfif>>#pagename# --  #pageTitle#</option>
		</cfloop>
		</select>
      </td>
      	  
    </tr>
    <tr>
      <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit1" value="Reset"> <br>
      </td>
      <td></td>
    </tr>
  </table>
  </center></div>
</form>

</cfoutput>