<cfparam name="PageID" default=0>
<cfparam name="PageTypeID" default=0>
<cfparam name="StyleSheetID" default=0>
<cfparam name="TemplateID" default=0>
<cfparam name="PageName" default=''>
<cfparam name="PageTitle" default=''>
<cfparam name="BackGrColorID" default='0'>
<cfparam name="TextColorID" default='0'>
<cfparam name="BackGrImageID" default='0'>
<cfparam name="LinkColorID" default='0'>
<cfparam name="ALinkColorID" default='0'>
<cfparam name="StyleSheetID" default='0'>
<cfparam name="HLinkColorID" default='0'>
<cfparam name="VLinkColorID" default='0'>
<cfparam name="H1Size" default=0>
<cfparam name="H2Size" default=0>
<cfparam name="H3Size" default=0>
<cfparam name="PageAction" default="list">
		
<cfif PageAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="pages">
		<cfinvokeargument name="ThisFileName" value="Pages">
		<cfinvokeargument name="XMLFields" value="PageID,PageTypeID,TemplateID,StyleSheetID,PageName,PageTitle,BackGrColorID,TextColorID,BackGrImageID,LinkColorID,ALinkColorID,StyleSheetID,HLinkColorID,VLinkColorID,H1Size,H2Size,H3Size">
		<cfinvokeargument name="XMLIDField" value="PageID">
		<cfinvokeargument name="XMLIDValue" value="#PageID#">
	</cfinvoke>
	<cflocation url="adminheader.cfm?Action=pages_listview">
</cfif>

<cfif PageID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Pages">
		<cfinvokeargument name="ThisPath" value="Pages">
		<cfinvokeargument name="ThisFileName" value="Pages">
		<cfinvokeargument name="IDFieldName" value="PageID">
		<cfinvokeargument name="IDFieldValue" value="#PageID#">
	</cfinvoke>
	<cfoutput query="Pages">
		<CFSET PageTypeID = #PageTypeID#>
		<cfset StyleSheetID= #StyleSheetID#>
		<CFSET PageName = '#PageName#'>
		<CFSET PageTitle = '#PageTitle#'>
		<CFSET BackGrColorID = #BackGrColorID#>
		<CFSET TextColorID = #TextColorID#>
		<CFSET BackGrImageID = #BackGrImageID#>
		<CFSET LinkColorID = #LinkColorID#>
		<CFSET ALinkColorID = #ALinkColorID#>
		<CFSET StyleSheetID = #StyleSheetID#>
		<CFSET HLinkColorID = #HLinkColorID#>
		<CFSET VLinkColorID = #VLinkColorID#>
		<CFSET H1Size = #H1Size#>
		<CFSET H2Size = #H2Size#>
		<CFSET H3Size = #H3Size#>
		<cfset TemplateID=#TemplateID#>
	</cfoutput>
	<cfset PageAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif PageID gt 0>
		<cfif PageAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="pages">
				<cfinvokeargument name="ThisFileName" value="pages">
				<cfinvokeargument name="XMLFields" value="PageTypeID,TemplateID,StyleSheetID,PageName,PageTitle,BackGrColorID,TextColorID,BackGrImageID,LinkColorID,ALinkColorID,StyleSheetID,HLinkColorID,VLinkColorID,H1Size,H2Size,H3Size">
			<cfinvokeargument name="XMLFieldData" value="#form.PageTypeID#,#form.TemplateID#,#form.StyleSheetID#,#form.PageName#,#form.PageTitle#,#form.BackGrColorID#,#form.TextColorID#,#form.BackGrImageID#,#form.LinkColorID#,#form.ALinkColorID#,#form.StyleSheetID#,#form.HLinkColorID#,#form.VLinkColorID#,#form.H1Size#,#form.H2Size#,#form.H3Size#">
				<cfinvokeargument name="XMLIDField" value="PageID">
				<cfinvokeargument name="XMLIDValue" value="#PageID#">
			</cfinvoke>
		<cfelseif PageAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="pages">
				<cfinvokeargument name="ThisFileName" value="pages">
				<cfinvokeargument name="XMLFields" value="PageTypeID,TemplateID,StyleSheetID,PageName,PageTitle,BackGrColorID,TextColorID,BackGrImageID,LinkColorID,ALinkColorID,StyleSheetID,HLinkColorID,VLinkColorID,H1Size,H2Size,H3Size">
				<cfinvokeargument name="XMLIDField" value="PageID">
				<cfinvokeargument name="XMLIDValue" value="#PageID#">
			</cfinvoke>
		</cfif>
	<cfelse>
		<cfoutput>#form.PageTypeID#,#form.TemplateID#,#form.StyleSheetID#,#form.PageName#,#form.PageTitle#,#form.BackGrColorID#,#form.TextColorID#,#form.BackGrImageID#,#form.LinkColorID#,#form.ALinkColorID#,#form.StyleSheetID#,#form.HLinkColorID#,#form.VLinkColorID#,#form.H1Size#,#form.H2Size#,#form.H3Size#</cfoutput>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfinvokeargument name="XMLFields" value="PageTypeID,TemplateID,StyleSheetID,PageName,PageTitle,BackGrColorID,TextColorID,BackGrImageID,LinkColorID,ALinkColorID,StyleSheetID,HLinkColorID,VLinkColorID,H1Size,H2Size,H3Size">
			<cfinvokeargument name="XMLFieldData" value="#form.PageTypeID#,#form.TemplateID#,#form.StyleSheetID#,#form.PageName#,#form.PageTitle#,#form.BackGrColorID#,#form.TextColorID#,#form.BackGrImageID#,#form.LinkColorID#,#form.ALinkColorID#,#form.StyleSheetID#,#form.HLinkColorID#,#form.VLinkColorID#,#form.H1Size#,#form.H2Size#,#form.H3Size#">
			<cfinvokeargument name="XMLIDField" value="PageID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=pages_listview">

</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllTemplates">
	<cfinvokeargument name="ThisPath" value="templates">
	<cfinvokeargument name="ThisFileName" value="templates">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStylesheets">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="stylesheets">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGraphics">
	<cfinvokeargument name="ThisPath" value="Utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>
<cfif #Allgraphics.recordcount# gt 0>
	<cfquery name="Backgrounds" dbtype="query">
		select * from AllGraphics where GraphicsTypeID='4'
	</cfquery>
</cfif>
	
<cfoutput>
<FORM name="InputForm" action="adminheader.cfm" method="post">
<INPUT type="hidden" name="Action" value="#Action#">
<INPUT type="hidden" name="PageAction" value="#PageAction#">
<INPUT type="hidden" name="PageID" value="#PageID#">
<!--- <input type="hidden" name="TemplateID" value="#TemplateID#"> --->

  <table>
    <tr> 
      <td valign="top"> Page Type: </td>
      <td colspan="2"> <select name="PageTypeID">
          <option value="2"<cfif #PageTypeID# is 2> selected</cfif>>Available to All</option>
          <option value="1"<cfif #PageTypeID# is 1> selected</cfif>>Must Login to See </option>
        </select> </td>
      <!--- field validation --->
      <input type="hidden" name="PageTypeID_float">
      <td valign="top"> Template: </td>
      <td colspan="2">
	  <cfset tTemplateID=#templateID#>
	  <select name="templateID">
	  	<cfloop query="alltemplates">
			<option value="#alltemplates.templateID#"<cfif #alltemplates.templateID# is #tTemplateID#> selected</cfif>>#alltemplates.Filename#</option>
		</cfloop>
	  </select> </td>
      <!--- field validation --->
    </tr>
    <tr> 
      <td valign="MIDDLE">Background Image (instead of using a color): </td>
      <td colspan="2"> 
	  
	  <select name="BackGrImageID">
          <option value="0">None</option>
		  <cfif #AllGraphics.REcordcount# gt 0>
			  <cfloop query="backgrounds">
				<option value="#graphicsID#" <cfif #BackGrImageID# is #graphicsID#>selected</cfif>>#description#</option>
			  </cfloop>
		  </cfif>
        </select></td>
      <!--- field validation --->
      <td valign="MIDDLE"> Style Sheet: </td>
      <td colspan="2"> <select name="StyleSheetID">
          <option value="0">None</option>
          <cfloop query="AllStylesheets">
            <option value="#styleID#" <cfif #StyleSheetID# is #styleID#>selected</cfif>>#filename#</option>
          </cfloop>
        </select> </td>
      <!--- field validation --->
      <input type="hidden" name="StyleSheetID_float">
    </tr>
    <tr> 
      <td valign="MIDDLE"> Name of this Page (no spaces, dashes or other punctuation. 
        This is the page name that your navigation links to) You <b>MUST</b> name 
        the first page of your site <b>HOMEPAGE</b>: </td>
      <td colspan="2"> <cfif #PageName# is ""><input name="PageName" value="#PageName#" maxlength="150" > <cfelse>#PageName#<input type="hidden" name="pagename" value="#Pagename#"></cfif>
      </td>
      <td valign="MIDDLE"> Title of this page: <br>This is what shows at the top of the browser</td>
      <td colspan="2"> <input name="PageTitle" value="#PageTitle#" maxlength="150" > 
      </td>
      <!--- field validation --->
    </tr>
    <tr> 
      <td valign="top"><hr> </td>
      <td colspan="2"><hr> </td>
      <td valign="top"><hr> </td>
      <td colspan="2"><hr> </td>
    </tr>
    <tr> 
      <td valign="MIDDLE" colspan="6"><strong><font color="red">If you selected 
        a style sheet for this page, do not select colors below</font></strong></td>
    </tr>
    <tr> 
      <td valign="MIDDLE"> Text Color: </td>
      <td colspan="2"> <input name="TextColorID" value="#TextColorID#" maxlength="10" size="10" > 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('InputForm','TextColorID')"> 
      </td>
      <!--- field validation --->
      <td valign="MIDDLE"> Unvisited Link Color: </td>
      <td colspan="2"> <input name="LinkColorID" value="#LinkColorID#" maxlength="10" size="10" > 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('InputForm','LinkColorID')"> 
      </td>
      <!--- field validation --->
    </tr>
    <tr> 
      <td valign="MIDDLE"> Link Color When Clicked: </td>
      <td colspan="2"> <input name="ALinkColorID" value="#ALinkColorID#" maxlength="10" size="10" > 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('InputForm','ALinkColorID')"> 
      </td>
      <!--- field validation --->
      <td valign="MIDDLE"> Link Color when mouse passes over the link: </td>
      <td colspan="2"> <input name="HLinkColorID" value="#HLinkColorID#" maxlength="10" size="10" > 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('InputForm','HLinkColorID')"> 
      </td>
      <!--- field validation --->
    </tr>
    <tr> 
      <td  valign="MIDDLE">Already Visited Link Color:</td>
      <td colspan="2"> <input name="VLinkColorID" value="#VLinkColorID#" maxlength="10" size="10" > 
        <input type="Button" name="bgcolor" value="..." onClick="selectcolor('InputForm','VLinkColorID')"> 
      </td>
      <!--- field validation --->
      <td>Background Color: </td>
      <td colspan="2"><input name="BackGrColorID" value="#BackGrColorID#" size="10" maxlength="10" > 
        <input type="Button" name="bgcolor2" value="..." onClick="selectcolor('InputForm','BackGrColorID')"> 
      </td>
    </tr>
    <tr> 
      <td valign="MIDDLE">Large Header Size: </td>
      <td> <select name="H1Size">
          <option value="#H1Size#">#int(H1Size)#</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
        </select> </td>
      <!--- field validation --->
      <input type="hidden" name="H1Size_float">
      <td valign="MIDDLE"> Medium Header Size: </td>
      <td> <select name="H2Size">
          <option value="#H2Size#">#int(H2Size)#</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
        </select> </td>
      <!--- field validation --->
      <input type="hidden" name="H2Size_float">
      <td valign="MIDDLE"> Small Header Size: </td>
      <td> <select name="H3Size">
          <option value="#H3Size#">#int(H3Size)#</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
        </select> </td>
      <!--- field validation --->
      <input type="hidden" name="H3Size_float">
    </tr>
  </table>
  <!--- form buttons --->
  <INPUT type="submit" name="submit" value="Save Changes">

</FORM>



</CFOUTPUT>

