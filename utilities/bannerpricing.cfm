<cfset TheFileExists="false">
<cfif FileExists("#application.uploadpath#\#application.utilitiespath#\BannerConfig.xml")>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="BannerConfig">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="BannerConfig">
	</cfinvoke>
	<cfset TheFileExists="true">
</cfif>
<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
<cfif isDefined('form.submit')>

	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="BannerConfig">
			<cfinvokeargument name="XMLFields" value="VerticalBanner,FullBanner,SquareButton,SquareButton,MediumRectangle,HalfBanner,SquarePopUp,VerticalRectangle,LargeRectangle,Rectangle,MicroBar,ButtonOne,ButtonTwo,WideSkyscraper,Skyscraper,homepage,mypage,special,BannerSignUpTKU">
			<cfinvokeargument name="XMLFieldData" value="#form.VerticalBanner#,#form.FullBanner#,#form.SquareButton#,#form.SquareButton#,#form.MediumRectangle#,#form.HalfBanner#,#form.SquarePopUp#,#form.VerticalRectangle#,#form.LargeRectangle#,#form.Rectangle#,#form.MicroBar#,#form.ButtonOne#,#form.ButtonTwo#,#form.WideSkyscraper#,#form.Skyscraper#,#form.homepage#,#form.mypage#,#form.special#,#form.BannerSignUpTKU#">
			<cfinvokeargument name="XMLIDField" value="BannerConfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="BannerConfig">
			<cfinvokeargument name="XMLFields" value="VerticalBanner,FullBanner,SquareButton,SquareButton,MediumRectangle,HalfBanner,SquarePopUp,VerticalRectangle,LargeRectangle,Rectangle,MicroBar,ButtonOne,ButtonTwo,WideSkyscraper,Skyscraper,homepage,mypage,special,BannerSignUpTKU">
			<cfinvokeargument name="XMLFieldData" value="#form.VerticalBanner#,#form.FullBanner#,#form.SquareButton#,#form.SquareButton#,#form.MediumRectangle#,#form.HalfBanner#,#form.SquarePopUp#,#form.VerticalRectangle#,#form.LargeRectangle#,#form.Rectangle#,#form.MicroBar#,#form.ButtonOne#,#form.ButtonTwo#,#form.WideSkyscraper#,#form.Skyscraper#,#form.homepage#,#form.mypage#,#form.special#,#form.BannerSignUpTKU#">
			<cfinvokeargument name="XMLIDField" value="BannerConfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">
</cfif>



<cfif #TheFileExists# is "true">
	<cfset VerticalBanner=#VerticalBanner#>
	<cfset FullBanner=#FullBanner#>
	<cfset SquareButton=#SquareButton#>
	<cfset MediumRectangle=#MediumRectangle#>
	<cfset HalfBanner=#HalfBanner#>
	<cfset SquarePopUp=#SquarePopUp#>
	<cfset VerticalRectangle=#VerticalRectangle#>
	<cfset LargeRectangle=#LargeRectangle#>
	<cfset Rectangle=#Rectangle#>
	<cfset MicroBar=#MicroBar#>
	<cfset ButtonOne=#ButtonOne#>
	<cfset ButtonTwo=#ButtonTwo#>
	<cfset WideSkyscraper=#WideSkyscraper#>
	<cfset Skyscraper=#Skyscraper#>
	<cfset homepage=#homepage#>
	<cfset mypage=#mypage#>
	<cfset special=#special#>
	<Cfset BannerSignUpTKU=#BannerSignUpTKU#>
<cfelse>
	<cfset SignUpLogicMember=0>
	<cfset VerticalBanner=0>
	<cfset FullBanner=0>
	<cfset SquareButton=0>
	<cfset MediumRectangle=0>
	<cfset HalfBanner=0>
	<cfset SquarePopUp=0>
	<cfset VerticalRectangle=0>
	<cfset LargeRectangle=0>
	<cfset Rectangle=0>
	<cfset MicroBar=0>
	<cfset ButtonOne=0>
	<cfset ButtonTwo=0>
	<cfset WideSkyscraper=0>
	<cfset Skyscraper=0>
	<cfset homepage=0>
	<cfset mypage=0>
	<cfset special=0>
	<cfset BannerSignUpTKU="homepage">
</cfif>
<cfoutput>
<font size="+1">Advertisers Pricing</font>
<br>
<cfform action="adminheader.cfm?action=bannerpricing" method="post" name="thisform">
  <input type="hidden" name="action" value="#action#">
  <div align="center"><center>
  <table>
	
    <tr>
      <td valign="top">
	  <table>
	  <tr><td><strong>Banner Pricing</strong></td></tr>
	  <tr><Td>Rectangles and Pop-Ups</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput name="MediumRectangle" type="text" value="#MediumRectangle#" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer"> 300 x 250 IMU - (Medium Rectangle)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="SquarePopUP" value="#SquarePopUP#"> 250 x 250 IMU - (Square Pop-Up)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="VerticalRectangle" value="#VerticalRectangle#"> 240 x 400 IMU - (Vertical Rectangle)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="LargeRectangle" value="#LargeRectangle#"> 336 x 280 IMU - (Large Rectangle)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="Rectangle" value="#Rectangle#"> 180 x 150 IMU - (Rectangle)</Td></tr>
		<tr><Td>Banners and Buttons</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="FullBanner" value="#FullBanner#"> 468 x 60 IMU - (Full Banner)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="HalfBanner" value="#HalfBanner#"> 234 x 60 IMU - (Half Banner) </Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="MicroBar" value="#MicroBar#"> 88 x 31 IMU - (Micro Bar)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="ButtonONe" value="#ButtonONe#"> 120 x 90 IMU - (Button 1) </Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="ButtonTwo" value="#ButtonTwo#"> 120 x 60 IMU - (Button 2)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="VerticalBanner" value="#VerticalBanner#"> 120 x 240 IMU - (Vertical Banner)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="SquareButton" value="#SquareButton#"> 125 x 125 IMU - (Square Button)</Td></tr>
		<tr><Td>Skyscrapers</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="WideSkyscraper" value="#WideSkyscraper#"> 160 x 600 IMU - (Wide Skyscraper)</Td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" validate="integer" name="Skyscraper" value="#Skyscraper#"> 120 x 600 IMU - (Skyscraper)</Td></tr>
	  </table>
	  
	  </td>
	  </tr>
	  <tr><td>
	  <table>
	  <tr><td><strong>Page Showing Pricing:</strong> </td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp;  Advertiser's Sign-up Page 
			<select name="homepage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #homepage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp;  Advertiser's Sign-up Thank You Page 
			<select name="BannerSignUpTKU">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #BannerSignUpTKU# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td></tr>
		<tr><Td>&nbsp;&nbsp;&nbsp;&nbsp;  Advertiser's Home Page 
			<select name="mypage">
              <option value="0">None 
              <cfloop query="AllPages">
                <option value="#pagename#" <cfif #mypage# is #pagename#>selected</cfif>>#pagename# 
              </cfloop>
            </select></td></tr>
	</table>
	  </td></tr>
	  <tr><td><strong>Top Level Listing Price</strong></td></tr>
	  <tr><td>&nbsp;&nbsp;&nbsp;&nbsp; <cfinput type="text" size=5 maxlength=5 required="yes" message="Please do not use commas or dollar signs" name="special" value="#special#"></td></tr>
</table>
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
</cfform>

</cfoutput>
</body>
</html>