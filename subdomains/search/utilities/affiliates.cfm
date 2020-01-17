
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllaffMethods">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="AffMethods">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllAffDealerTypes">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMembers">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Members">
	<cfinvokeargument name="OrderByStatement" value="order by lastname">
</cfinvoke>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="affiliates">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllAffiliates">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="affiliates">
	</cfinvoke>
</cfif>

<cfparam name="DealerID" default=0>
<cfparam name="DEALERTYPEID" default=0>
<cfparam name="AffiliateAction" default="List">
<cfparam name="Active" default="">
<cfparam name="FEINSSN" default="">
<cfparam name="DATESTARTED" default="#now()#">
<cfparam name="UNIQUEIDENTIFYER" default="">
<cfparam name="BANNED" default="0">
<cfparam name="REFERREDBY" default="homepage">
<cfparam name="Firstname" default="">
<cfparam name="LastName" default="">
<cfparam name="address" default="">
<cfparam name="address2" default="">
<cfparam name="city" default="">
<cfparam name="state" default="">
<cfparam name="zip" default="">
<cfparam name="country" default="">
<cfparam name="phone" default="">
<cfparam name="officephone" default="">
<cfparam name="cellphone" default="">
<cfparam name="faxphone" default="">
<cfparam name="email" default="">
<cfparam name="companyname" default="">
<cfparam name="Alsomemberid" default="0">
<cfparam name="username" default="">
<cfparam name="password" default="">

<cfif AffiliateAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Affiliates">
		<cfinvokeargument name="XMLFields" value="DealerID,ACTIVE,BANNED,DATESTARTED,DEALERTYPEID,FEINSSN,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,Alsomemberid,username,password">
		<cfinvokeargument name="XMLIDField" value="DealerID">
		<cfinvokeargument name="XMLIDValue" value="#DealerID#">
	</cfinvoke>
	<cfset DealerID=0>
	<cfset AffiliateAction="List">
</cfif>
		
<cfif DealerID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Affiliates">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Affiliates">
		<cfinvokeargument name="IDFieldName" value="DealerID">
		<cfinvokeargument name="IDFieldValue" value="#DealerID#">
	</cfinvoke>
	<cfoutput query="Affiliates">
		<cfset Active=#Active#>
		<cfset DATESTARTED=#DATESTARTED#>
		<cfset FEINSSN=#FEINSSN#>
		<cfset UNIQUEIDENTIFYER=#UNIQUEIDENTIFYER#>
		<cfset BANNED=#BANNED#>
		<cfset REFERREDBY=#REFERREDBY#>
		<cfset Firstname=#Firstname#>
		<cfset LastName=#LastName#>
		<cfset address=#address#>
		<cfset username=#username#>
		<cfset password=#password#>
		<cfset address2=#address2#>
		<cfset city=#city#>
		<cfset state=#state#>
		<cfset zip=#zip#>
		<cfset country=#country#>
		<cfset phone=#phone#>
		<cfset officephone=#officephone#>
		<cfset cellphone=#cellphone#>
		<cfset faxphone=#faxphone#>
		<cfset email=#email#>
		<cfset companyname=#companyname#>
		<cfset Alsomemberid=#Alsomemberid#>
	</cfoutput>
	<cfset AffiliateAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.FEINSSN')><cfset form.FEINSSN="none"></cfif>
	<cfif not isdate(#form.DATESTARTED#)><cfset form.DATESTARTED=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif #form.Active# is ''><cfset form.Active="0"></cfif>
	<cfif #form.FEINSSN# is ''><cfset form.FEINSSN="none"></cfif>
	<cfset form.FEINSSN = replace(#form.FEINSSN#,",","~","ALL")>
	<cfset UUID = #left(form.firstname,2)# & #left(form.lastname,2)# & #left(form.username,2)# & day(now()) & month(now()) & year(now())>
	<cfif DealerID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Affiliates">
			<cfinvokeargument name="XMLFields" value="ACTIVE,BANNED,DATESTARTED,DEALERTYPEID,FEINSSN,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,Alsomemberid,username,password">
			<cfinvokeargument name="XMLFieldData" value="#form.active#,#Form.banned#,#dateformat(form.datestarted)#,#form.DEALERTYPEID#,#form.FEINSSN#,#form.Firstname#,#Form.ReferredBy#,#UUID#,#Form.LastName#,#Form.address#,#Form.address2#,#Form.city#,#Form.state#,#Form.zip#,#Form.country#,#Form.phone#,#Form.officephone#,#Form.cellphone#,#Form.faxphone#,#Form.email#,#Form.companyname#,#Form.Alsomemberid#,#Form.username#,#Form.password#">
			<cfinvokeargument name="XMLIDField" value="DealerID">
			<cfinvokeargument name="XMLIDValue" value="#DealerID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
			method="InsertXMLRecord" returnvariable="NewDealerID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Affiliates">
			<cfinvokeargument name="XMLFields" value="ACTIVE,BANNED,DATESTARTED,DEALERTYPEID,FEINSSN,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,Alsomemberid,username,password">
			<cfinvokeargument name="XMLFieldData" value="#form.active#,#Form.banned#,#dateformat(form.datestarted)#,#form.DEALERTYPEID#,#form.FEINSSN#,#form.Firstname#,#Form.ReferredBy#,#UUID#,#Form.LastName#,#Form.address#,#Form.address2#,#Form.city#,#Form.state#,#Form.zip#,#Form.country#,#Form.phone#,#Form.officephone#,#Form.cellphone#,#Form.faxphone#,#Form.email#,#Form.companyname#,#Form.Alsomemberid#,#Form.username#,#Form.password#">
			<cfinvokeargument name="XMLIDField" value="DealerID">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="AffDealerStats">
			<cfinvokeargument name="XMLFields" value="CATEGORYID,COMMISSIONSDUE,COMMISSIONSYTD,DEALERID,DISPUTEDAMT,IMPRESSIONSUSED,LASTCHECKNO,LASTPAIDAMT,NOOFTIMESORDERED,NextPayDate,Impressions">
			<cfinvokeargument name="XMLFieldData" value="#form.DealerTypeID#,0,0,#NewDealerID#,0,0,0,0,0,0,0">
			<cfinvokeargument name="XMLIDField" value="DealerStatID">
		</cfinvoke>
	</cfif>
	<cfset AffiliateAction="list">
	<cfset Active="">
	<cfset DATESTARTED = #now()#>
	<cfset DEALERTYPEID = 0>
	<cfset FEINSSN=''>
	<cfset UNIQUEIDENTIFYER=''>
	<cfset BANNED='0'>
	<cfset REFERREDBY='0'>
	<cfset Firstname="">
	<cfset LastName=''>
	<cfset username="">
	<cfset password=''>
	<cfset address=''>
	<cfset address2=''>
	<cfset city=''>
	<cfset state=''>
	<cfset zip=''>
	<cfset country=''>
	<cfset phone="">
	<cfset officephone=''>
	<cfset cellphone=''>
	<cfset faxphone=''>
	<cfset email=''>
	<cfset companyname=''>
	<cfset Alsomemberid='0'>
	<cfset Username=''>
	<cfset password=''>
	<cfset TheFileExists="true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllAffiliates">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="affiliates">
	</cfinvoke>
</cfif>

<cfoutput>

<script>
<cfloop query="AllMembers">

</cfloop>

function getmemberinfo() {

}
</script>
<h1>Affiliate Program Members</h1>

<cfif AffiliateAction is "Add" or AffiliateAction is "Update">
<form action="adminheader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="DealerID" value="#DealerID#">
<input type="hidden" name="AffiliateAction" value="#AffiliateAction#">
<input type="hidden" name="Action" value="#Action#">
<table width="100%" cellspacing="0" cellpadding="0" align="CENTER">
	<tr>
	<td>
         Is this Affiliate also a member? </td>
		 <td>
			<select name="Alsomemberid" onChange="getmemberinfo()">
				<option value="0">No</option>
				<cfloop query="AllMembers">
				<option value="#MemberID#"<cfif #Alsomemberid# is #MemberID#> selected</cfif>>#firstname# #Lastname#</option>
				</cfloop>
			</select>
			
		</td>
	</tr>
	<tr>
		<td>Contact Name </td>
		<td> <input type="text" value="#firstname#" name="firstname" size=25> <input type="text" value="#lastname#" name="lastname" size=25></td>
</tr>
<tr>
		<td>Company Name </td>
		 <td><input type="text" name="companyname" value="#companyname#" size=25></td>
</tr>
<tr>
		<td>Address </td>
		 <td><input type="text" name="Address" value="#Address#" size=25> <input type="text" name="Address2" value="#Address2#" size=25></td>
</tr>
<tr>
		<td>City </td>
		 <td><input type="text" name="City" value="#City#" size=25></td>
</tr>
<tr>
		<td>State </td>
		 <td><input type="text" name="State" value="#State#" size=25></td>
</tr>
<tr>
		<td>Postal Code </td>
		 <td><input type="text" name="zip" value="#zip#" size=25></td>
</tr>
<tr>
		<td>Country </td>
		 <td><select name="Country">
		 	<option value="#Country#">#Country#</option>
			<cfinclude template="../files/countries.htm">
		 </select></td>
</tr>
<tr>
		<td>User Name </td>
		 <td><input type="text" name="username" value="#username#" size=25></td>
</tr>
<tr>
		<td>Password </td>
		 <td><input type="Password" name="Password" value="#Password#" size=25></td>
</tr>
<tr>
		<td>Home Phone </td>
		 <td><input type="text" name="phone" value="#phone#" size=25></td>
</tr><tr>
		<td>Office Phone </td>
		 <td><input type="text" name="officephone" value="#officephone#" size=25></td>
</tr>
<tr>
		<td>Cell Phone </td>
		 <td><input type="text" name="cellphone" value="#phone#" size=25></td>
</tr>
<tr>
		<td>Fax Phone </td>
		 <td><input type="text" name="faxphone" value="#faxphone#" size=25></td>
</tr>
<tr>
		<td>Email Address </td>
		 <td><input type="text" name="email" value="#email#" size=25></td>
</tr>

	<tr>
		<td>Federal Identification Number or Social Security Number</td>
		<td><input type="text" name="FEINSSN" value="#FEINSSN#"></td>
	</tr>
	<tr>
		<td>Active </td>
		 <td>Yes<input type="Radio" name="Active" value="1" <cfif #Active# is 1>checked</cfif>><br>
		 No<input type="Radio" name="Active" value=0 <cfif #Active# is 0>checked</cfif>></td>
</tr>

<tr>
		<td>Date Started </td>
		 <td><input type="text" name="datestarted" value="#dateformat(datestarted,"mm/dd/yyyy")#" size=25></td>
</tr>
	<tr>
		<td>Commission Structure for this Affiliate </td>
		<td><select name="Banned">
		 <cfloop query="AllAffDealerTypes">
			<option value="#TypeID#"<cfif #Banned# is #TypeID#> selected</cfif>>#TypeDescription#</option>
		</cfloop>
		</select>
		</td>
</tr>
<tr>
	<td>
		<font face="Arial" size="2">Affiliate Type:</font></td>
	<td><select name="DealerTypeID">
		<cfloop query="AllAffMethods">
			<option value="#MethodID#"<cfif #DealerTypeID# is #MethodID#> selected</cfif>>#MethodName#</option>
		</cfloop>
	</select></td>
</tr>

	<tr>
		<td>Referring Affiliate</td>
		 <td><select name="ReferredBy">
			<option value="0">None</option>
			<cfif isdefined('AllAffiliates')>
			<cfloop query="AllAffiliates">
				<option value="#AllAffiliates.DealerID#"<cfif #ReferredBy# is #AllAffiliates.DealerID#> selected</cfif>>#Trim(AllAffiliates.firstname)# #Trim(AllAffiliates.Lastname)#</option>
			</cfloop></cfif>
		</select></td>
	</tr>
	
	<cfif #DealerID# gt 0><input type="hidden" name="UUID" value="#uniqueidentifyer#">	
	<tr>
		<td>Unique Identifyer</td>
		 <td>#uniqueidentifyer#</td>
	</tr>
	</cfif>
<tr>
	<td colspan="2" align="center">
		<input type="submit" name="submit" value="Apply">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="submit" value="Reset">
	</td>
</tr>
</table>
</form>
</cfif>
</cfoutput>
<cfif AffiliateAction is "list">
<cfoutput><a href="adminheader.cfm?Action=#Action#&affiliateaction=Add">Add An Affiliate</a></cfoutput><br>
<cfif #TheFileExists#>

<table border="1" align="CENTER">
<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Affiliates</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Company name</p></td>
<td><p>Contact name</p></td>
<td><p>Start Date</p></td>
<td><p>Status</p></td>
<td><p>Actions</p></td>
</tr>
<cfoutput query="AllAffiliates">
<tr>
<td><p>#int(dealerID)#</p></td>
<td><p>#companyname#</p></td>
<td><p>#firstname# #lastname#</p></td>
<td><p>#dateformat(datestarted,"mm/dd/yyyy")#</p></td>
<td><p><cfif #active#>Active<cfelse>Not Active</cfif></p></td>
<td><a href= "adminheader.cfm?DealerID=#DealerID#&AffiliateAction=Edit&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?DealerID=#DealerID#&AffiliateAction=Delete&action=#action#')">Delete</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?DealerID=#DealerID#&action=AffiliateStats">Statistics</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?DealerID=#DealerID#&action=AffCustomers">Customers</a></td>
</tr>
</cfoutput>
</table>
</cfif>
</cfif>