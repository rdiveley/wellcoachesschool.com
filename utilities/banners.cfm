<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="Pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="BannerConfig">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="BannerConfig">
</cfinvoke>
<cfset ThankYouPage=#BannerConfig.BannerSignUpTKU#>
<cfset specialityPages=#replace(BannerConfig.specialityPages,"~",",","ALL")#>

<cfparam name="BanID" default=0>
<cfparam name="BannerAction" default="List">
<cfparam name="Special" default="">
<cfparam name="Message" default="">
<cfparam name="SpecialDate" default="#now()#">
<cfparam name="AdvertOption" default="0">
<cfparam name="EndSpecial" default="">
<cfparam name="clicks" default="0">
<cfparam name="Target" default="0">
<cfparam name="CompanyName" default="">
<cfparam name="Email" default="">
<cfparam name="HREF" default="">
<cfparam name="ImgSrc" default="">
<cfparam name="Views" default="0">
<cfparam name="Border" default="0">
<cfparam name="Active" default="0">

<cfif BannerAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Banners">
		<cfinvokeargument name="XMLFields" value="Message,Special,SpecialDate,AdvertOption,EndSpecial,clicks,Target,CompanyName,Email,HREF,ImgSrc,Views,Border,Active">
		<cfinvokeargument name="XMLIDField" value="BanID">
		<cfinvokeargument name="XMLIDValue" value="#BanID#">
	</cfinvoke>
	<cfset BanID=0>
	<cfset BannerAction="List">
</cfif>
		
<cfif BanID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Banners">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Banners">
		<cfinvokeargument name="IDFieldName" value="BanID">
		<cfinvokeargument name="IDFieldValue" value="#BanID#">
	</cfinvoke>
	<cfoutput query="Banners">
		<cfset Special=#Special#>
		<cfset SpecialDate=#SpecialDate#>
		<cfset AdvertOption=#AdvertOption#>
		<cfset EndSpecial=#EndSpecial#>
		<cfset clicks=#clicks#>
		<cfset Target=#Target#>
		<cfset Special = replace(#Special#,"~",",","ALL")>
		<cfset Message = replace(#Message#,"~",",","ALL")>
		<cfset CompanyName = replace(#CompanyName#,"~",",","ALL")>
		<cfset Email = replace(#Email#,"~",",","ALL")>
		<cfset HREF = replace(#HREF#,"~",",","ALL")>
		<cfset ImgSrc = replace(#ImgSrc#,"~",",","ALL")>
		<cfset Views=#Views#>
		<cfset Border=#Border#>
		<cfset Active=#active#>
	</cfoutput>
	<cfset BannerAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.Message')><cfset form.Message="none"></cfif>
	<cfif not isdate(#form.SpecialDate#)><cfset form.SpecialDate=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif not isdate(#form.EndSpecial#)><cfset form.EndSpecial=dateadd("d",3650,#form.SpecialDate#)></cfif>
	<cfif #form.Special# is ''><cfset form.Special="none"></cfif>
	<cfset form.Special = replace(#form.Special#,",","~","ALL")>
	<cfif #form.Message# is ''><cfset form.Message="none"></cfif>
	<cfset form.Message = replace(#form.Message#,",","~","ALL")>
	<cfif #form.AdvertOption# is ''><cfset form.AdvertOption="0"></cfif>
	
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Banners\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.ImgSrc="images/Banners/#image#">
	</cfif>
	<cfif #form.ImgSrc# is ""><cfset form.ImgSrc="none"></cfif>
	
	<cfif BanID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
			<cfinvokeargument name="XMLFields" value="Message,Special,SpecialDate,AdvertOption,EndSpecial,clicks,Target,CompanyName,Email,HREF,ImgSrc,Views,Border,Active">
			<cfinvokeargument name="XMLFieldData" value="#form.Message#,#form.Special#,#form.SpecialDate#,#form.AdvertOption#,#form.EndSpecial#,#form.clicks#,#form.Target#,#form.CompanyName#,#form.Email#,#form.HREF#,#form.ImgSrc#,#form.Views#,#form.Border#,#form.Active#">
			<cfinvokeargument name="XMLIDField" value="BanID">
			<cfinvokeargument name="XMLIDValue" value="#BanID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
			<cfinvokeargument name="XMLFields" value="Message,Special,SpecialDate,AdvertOption,EndSpecial,clicks,Target,CompanyName,Email,HREF,ImgSrc,Views,Border,Active">
			<cfinvokeargument name="XMLFieldData" value="#form.Message#,#form.Special#,#form.SpecialDate#,#form.AdvertOption#,#form.EndSpecial#,#form.clicks#,#form.Target#,#form.CompanyName#,#form.Email#,#form.HREF#,#form.ImgSrc#,#form.Views#,#form.Border#,#form.Active#">
			<cfinvokeargument name="XMLIDField" value="BanID">
		</cfinvoke>
	</cfif>
	<cflocation url="adminheader.cfm?action=#action#">
</cfif>
<h1>Advertising Banners</h1>
<p>Because advertising costs are usually large,<br>billing for banners will not occur on your web site.<br>You must bill separately and then come here to approve a banner.<br><br>All prices should be the monthly charge to the advertiser.</p>
<cfif BannerAction is "update" or BannerAction is "Add">
<cfoutput>

<form name="thisform" action="AdminHeader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="BanID" value="#BanID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ImgSRc" value="#ImgSRc#">
<table width="70%" cellspacing="4" cellpadding="2" align="CENTER">
<TR>
	<TD valign="top"> Authorized: </TD>
    <TD>
		<cfif #ACtive# is 1>
		<input type="checkbox" name="ACtive" value="1" checked>
		<cfelse>
		<input type="checkbox" name="ACtive" value="0">
		</cfif>
		
	</TD>
	<!--- field validation --->
	</TR>
<TR>
    <TD><font face="arial" size="2">Upload the banner (#trim(Imgsrc)#)</font></TD>
    <TD colspan=2><input type="file" name="image" value="#imgsrc#"><br>
	#imgsrc#</TD>
</tr>
<tr>
	<td><font face="arial" size="2">or enter code for your banner:</font></td>
	 <td ><textarea name="message" cols="30" rows=3>#Message#</textarea></td>
</tr>
<tr>
	<td><font face="arial" size="2">Name of Company/person this banner belongs to:</font></td>
	 <td ><input type="text" name="CompanyName" size="30" maxlength=100 value="#CompanyName#"></td>
</tr>
<tr>
	<td><font face="arial" size="2">Contact Email:</font> </td>
	<td >	
	<input type="text" name="Email" size="30" maxlength=250 value="#Email#">
	</td>
</tr>

<tr>
	<td><font face="arial" size="2">URL to link this banner to:</font></td>
	 <td ><input type="text" name="HREF" size="30" maxlength=250 value="#HREF#"></td>
</tr>

<tr>
	<td><font face="arial" size="2">Open in New Window?:</font> </td>
	<td >	
	<select name="Target">
		<option value="NNN"<cfif #Target# is "NNN"> selected</cfif>>Yes</option>
		<option value="_self"<cfif #Target# is "_self"> selected</cfif>>No</option>
		</select>
	</td>
</tr>
<tr>
	<td><font face="arial" size="2">No. Of Banner Views:</font></td>
	 <td ><input type="text" name="views" size="20" value="#views#"></td>
</tr>
<tr>
	<td><font face="arial" size="2">No. Of Banner Clicks:</font></td>
	 <td ><input type="text" name="clicks" size="20" value="#clicks#"></td>
</tr>

<tr>
	<td>
	<font face="arial" size="2">Select Border Size (0 for no border) around the banner:</font> </td>
	<td><select name="border">
		<option value="0"<cfif #border# is 0> selected</cfif>>0</option>
		<option value="1"<cfif #border# is 1> selected</cfif>>1</option>
		<option value="2"<cfif #border# is 2> selected</cfif>>2</option>
		<option value="3"<cfif #border# is 3> selected</cfif>>3</option>
		<option value="4"<cfif #border# is 4> selected</cfif>>4</option>
		<option value="5"<cfif #border# is 5> selected</cfif>>5</option>
		</select>
	</td>
</tr>
<tr>
	<td><font face="arial" size="2">Select Banner Size:</font> </td><td><select name="AdvertOption">
		<option value="0">---Rectangles and Pop-Ups---</option>
		<option value="4" <cfif #AdvertOption# is 1>selected</cfif>>300 x 250 pixels - (Medium Rectangle)
		<option value="6" <cfif #AdvertOption# is 2>selected</cfif>>250 x 250 pixels - (Square Pop-Up)
		<option value="7" <cfif #AdvertOption# is 3>selected</cfif>>240 x 400 pixels - (Vertical Rectangle)
		<option value="8" <cfif #AdvertOption# is 4>selected</cfif>>336 x 280 pixels - (Large Rectangle)
		<option value="9" <cfif #AdvertOption# is 5>selected</cfif>>180 x 150 pixels - (Rectangle)
		<option value="0">---Banners and Buttons ---
		<option value="2" <cfif #AdvertOption# is 6>selected</cfif>>468 x 60 pixels - (Full Banner)
		<option value="5" <cfif #AdvertOption# is 7>selected</cfif>>234 x 60 pixels - (Half Banner) 
		<option value="10" <cfif #AdvertOption# is 8>selected</cfif>>88 x 31 pixels - (Micro Bar)
		<option value="11" <cfif #AdvertOption# is 9>selected</cfif>>120 x 90 pixels - (Button 1) 
		<option value="12" <cfif #AdvertOption# is 10>selected</cfif>>120 x 60 pixels - (Button 2)
		<option value="1" <cfif #AdvertOption# is 11>selected</cfif>>120 x 240 pixels - (Vertical Banner)
		<option value="3" <cfif #AdvertOption# is 12>selected</cfif>>125 x 125 pixels - (Square Button)
		<option value="0">---Skyscrapers ---
		<option value="13" <cfif #AdvertOption# is 13>selected</cfif>>160 x 600 pixels - (Wide Skyscraper)
		<option value="14" <cfif #AdvertOption# is 14>selected</cfif>>120 x 600 pixels - (Skyscraper)
</select></td>
</tr>

<tr>
	<td><font face="arial" size="2">Show on Speciality Page/Home Page:</font> </td><td>
		<select name="special">
			<cfloop query="allpages">
				<cfif #listfind(specialityPages,pagename)#>
				<option value="#pagename#">#pagetitle#</option>
				</cfif>
			</cfloop>
		</select>
	</td>
</tr>

<tr>
	<td><font face="arial" size="2">Start Date</font> </td><td>
	<input type=text name=specialdate value="#dateformat(SpecialDate)#">
</td>
</tr>

<tr>
	<td><font face="arial" size="2">End Date</font> </td><td>
	<input type=text name=endspecial value="#dateformat(endspecial)#">
</td>
</tr>
</tr>
</table>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>
</cfif>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="Banners">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #BannerAction# is "list">
	<cfoutput><a href="adminheader.cfm?Action=#Action#&bannerAction=Add">Add A Banner</a><br></cfoutput>
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllBanners">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Banners">
		</cfinvoke>

		<table border="1" align="CENTER">
		<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Advertising Banners</th>
		<tr>
		<td>ID</td>
		<td>Company</td>
		<td>File Name</td>
		<td>Link TO</td>
		<td>Target</td>
		<td>Clicks</td>
		<td>Views</td>
		<td>Actions</td>
		</tr>
		<cfoutput query="GetBanners">
		<tr>
		<td>#int(BanID)#</td>
		<td>#CompanyName#</td>
		<td><img src="../#ImgSrc#"></td>
		<td>#HREF#</td>
		<td>#target#</td>
		<td>#Clicks#</td>
		<td>#views#</td>
		<td><a href= "AdminHeader.cfm?BanID=#BanID#&BannerAction=Edit&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?BanID=#BanID#&BannerAction=Delete&action=#action#')">Delete</a>
		<br><a href= "AdminHeader.cfm?BanID=#BanID#&BannerAction=Statistics&action=#action#">Statistics</a>
		</td>
		</tr>
		</cfoutput>
		</table>
	</cfif>
</cfif>