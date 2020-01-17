<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="bannerconfig">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="Pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="rotationprice" default='0,0,0,0,0,0,0,0,0,0,0,0,0,0'>
<cfparam name="homepageprice" default='0,0,0,0,0,0,0,0,0,0,0,0,0,0'>
<cfparam name="specialityprice" default='0,0,0,0,0,0,0,0,0,0,0,0,0,0'>
<cfparam name="specialityPages" default='homepage'>
<cfparam name="BannerSignUpPage" default='none'>
<cfparam name="BannerSignUpTKU" default='none'>
<cfparam name="NoOfBanners" default="1">
<cfparam name="listingStyle" default="horizontal">
<cfparam name="HalfBannerNo" default="1">

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Utilities">
		<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
		<cfinvokeargument name="ThisFileName" value="bannerconfig">
		<cfinvokeargument name="IDFieldName" value="bannerconfigID">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="Utilities">
		<cfset rotationprice=#replace(rotationprice,"~",",","ALL")#>
		<cfset homepageprice=#replace(homepageprice,"~",",","ALL")#>
		<cfset specialityprice=#replace(specialityprice,"~",",","ALL")#>
		<cfset specialityPages=#replace(specialityPages,"~",",","ALL")#>
		<cfset BannerSignUpPage=#BannerSignUpPage#>
		<cfset BannerSignUpTKU=#BannerSignUpTKU#>
		<cfset ListingStyle=#ListingStyle#>
		<cfset NoOfBanners=#NoOfBanners#>
		<cfset HalfBannerNo=#HalfBannerNo#>
	</cfoutput>
</cfif>

<cfif isDefined('form.submit')>
	<cfset form.rotationprice=replace(form.rotationprice,",","~","ALL")>
	<cfset form.homepageprice=replace(form.homepageprice,",","~","ALL")>
	<cfset form.specialityprice=replace(form.specialityprice,",","~","ALL")>
	<cfif not isdefined('form.specialityPages')><cfset form.specialityPages="homepage"></cfif>
	<cfset form.specialityPages=replace(form.specialityPages,",","~","ALL")>
	<cfif form.NoOfBanners is ""><cfset #form.NoOfBanners# = 0></cfif>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="bannerconfig">
			<cfinvokeargument name="XMLFields" value="rotationprice,homepageprice,specialityprice,specialityPages,BannerSignUpPage,BannerSignUpTKU,NoOfBanners,ListingStyle,HalfBannerNo">
			<cfinvokeargument name="XMLFieldData" value="#form.rotationprice#,#form.homepageprice#,#form.specialityprice#,#form.specialityPages#,#form.BannerSignUpPage#,#form.BannerSignUpTKU#,#form.NoOfBanners#,#form.ListingStyle#,#form.HalfBannerNo#">
			<cfinvokeargument name="XMLIDField" value="bannerconfigID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="bannerconfig">
			<cfinvokeargument name="XMLFields" value="rotationprice,homepageprice,specialityprice,specialityPages,BannerSignUpPage,BannerSignUpTKU,NoOfBanners,ListingStyle,HalfBannerNo">
			<cfinvokeargument name="XMLFieldData" value="#form.rotationprice#,#form.homepageprice#,#form.specialityprice#,#form.specialityPages#,#form.BannerSignUpPage#,#form.BannerSignUpTKU#,#form.NoOfBanners#,#form.ListingStyle#,#form.HalfBannerNo#">
			<cfinvokeargument name="XMLIDField" value="bannerconfigID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=welcome">

</cfif>

<cfoutput>
<h1>Banner Pricing and Configuration</h1>

<form name="thisform" action="adminheader.cfm?action=#action#" method="post">
<table>
<tr><td valign=top>Select all specialty pages</td><td><select name="specialitypages" size="5" multiple>
	<cfloop query="allpages">
		<option value="#pagename#"<cfif #listfind(specialitypages,pagename)#> selected</cfif>>#pagename#</option>
	</cfloop>
</select></td>
<td valign=top colspan=2>
	<table><tr><td>Banner Sign up page</td>
	<td><select name="BannerSignUpPage">
		<cfloop query="allpages">
		<option value="#pagename#"<cfif #BannerSignUpPage# is #pagename#> selected</cfif>>#pagename#</option>
		</cfloop>
	</select></td></tr>

	<tr><td>Sign Up Thank you Page</td>
	<td><select name="BannerSignUpTKU">
		<cfloop query="allpages">
		<option value="#pagename#"<cfif #BannerSignUpTKU# is #pagename#> selected</cfif>>#pagename#</option>
		</cfloop>
	</select></td></tr>
	</table>
	<table>
	<tr><td>With the small buttons, you can usually place more then one per page, how many would you like per page?</td>
	<td><input type="text" size="4" maxlength="4" name="NoOfBanners" value="#NoOfBanners#"></td>
	</tr>
	<tr>
	<td>Select the listing style of multiple banners</td>
	<td><select name="ListingStyle">
		<option value="horizontal"<cfif #ListingStyle# is "horizontal"> selected</cfif>>Horizontal</option>
		<option value="vertical"<cfif #ListingStyle# is "vertical"> selected</cfif>>Vertical</option>
	</select></td>
	</tr>
	<td>Would you like to show two half banners (234 x 60 pixels) per line?</td>
	<td colspan=3><select name="HalfBannerNo">
		<option value="1"<cfif #HalfBannerNo# is 1> selected</cfif>>No</option>
		<option value="2"<cfif #HalfBannerNo# is 2> selected</cfif>>Yes</option>
		</select></td>
	</table>
</td>
</tr>

<tr><td>Banner Size</td><td> -On Rotation Price- </td><td> -Home Page Price- </td><td> -Speciality Page Price- </td></tr>
<tr><td colspan=4>---Rectangles---</td></tr>
<tr><td>300 x 250 pixels - (Medium Rectangle)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,1)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,1)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,1)#"></td>
</tr>
<tr><td>250 x 250 pixels - (Square)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,2)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,2)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,2)#"></td>
</tr>
<tr><td>240 x 400 pixels - (Vertical Rectangle)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,3)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,3)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,3)#"></td>
</tr>
<tr><td>336 x 280 pixels - (Large Rectangle)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,4)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,4)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,4)#"></td>
</tr>
<tr><td>180 x 150 pixels - (Rectangle)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,5)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,5)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,5)#"></td>
</tr>
<tr><td colspan=4>---Banners and Buttons ---</td></tr>
<tr><td>468 x 60 pixels - (Full Banner)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,6)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,6)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,6)#"></td>
</tr>
<tr><td>234 x 60 pixels - (Half Banner) </td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,7)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,7)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,7)#"></td>
</tr>
<tr><td>88 x 31 pixels - (Micro Bar)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,8)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,8)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,8)#"></td>
</tr>
<tr><td>120 x 90 pixels - (Button 1) </td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,9)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,9)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,9)#"></td>
</tr>
<tr><td>120 x 60 pixels - (Button 2)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,10)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,10)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,10)#"></td>
</tr>
<tr><td>120 x 240 pixels - (Vertical Banner)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,11)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,11)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,11)#"></td>
</tr>
<tr><td>125 x 125 pixels - (Square Button)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,12)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,12)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,12)#"></td>
</tr>
<tr><td colspan=4>---Skyscrapers ---</td></tr>
<tr><td>160 x 600 pixels - (Wide Skyscraper)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,13)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,13)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,13)#"></td>
</tr>
<tr><td>120 x 600 pixels - (Skyscraper)</td>
<td align=center><input type="text" size="5" maxlength="5" name="rotationprice" value="#listgetat(RotationPrice,14)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="homepageprice" value="#listgetat(homepageprice,14)#"></td>
<td align=center><input type="text" size="5" maxlength="5" name="specialityprice" value="#listgetat(specialityprice,14)#"></td>
</tr>
<tr><td colspan=3></td><td><input type="submit" name="submit" value="Submit"></td></tr>
</table>
</form>
</cfoutput>