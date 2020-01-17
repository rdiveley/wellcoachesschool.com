<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="websiteinfo">
		<cfinvokeargument name="ThisPath" value="utilities">
</cfinvoke>

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="WebSiteInfo">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="websiteinfo">
		<cfinvokeargument name="IDFieldName" value="websiteid">
		<cfinvokeargument name="IDFieldValue" value="0000000001">
	</cfinvoke>
	<cfoutput query="WebSiteInfo">
		<cfset DSN=#DSN#>
		<cfset DSNuName=#DSNuName#>
		<cfset DSNpWord=#DSNpWord#>
		<cfset ReturnPath=#ReturnPath#>
		<cfset IPAddress=#IPAddress#>
		<cfset ACTIVE=#ACTIVE#>
		<cfset ADDRESS1=#ADDRESS1#>
		<cfset ADDRESS1=replace(#ADDRESS1#,"~",",","ALL")>
		<cfset ADDRESS2=#ADDRESS2#>
		<cfset ADDRESS2=replace(#ADDRESS2#,"~",",","ALL")>
		<cfset CELLNUMBER=#CELLNUMBER#>
		<cfset CITY=#CITY#>
		<cfset COUNTRY=#COUNTRY#>
		<cfset DateStarted=#DateStarted#>
		<cfset EMAIL=#EMAIL#>
		<cfset OWNERNAME=#OWNERNAME#>
		<cfset OWNERNAME=replace(#OWNERNAME#,"~",",","ALL")>
		<cfset MailServer=#MailServer#>
		<cfset PHONENUMBER=#PHONENUMBER#>
		<cfset PWORD=#PWORD#>
		<cfset STATE=#STATE#>
		<cfset USERNAME=#USERNAME#>
		<cfset WEBSITENAME=#WEBSITENAME#>
		<cfset WEBSITENAME=replace(#WEBSITENAME#,"~",",","ALL")>
		<cfset ZIP=#ZIP#>
		<cfset MetaKeywords=#MetaKeywords#>
		<cfset MetaKeywords=replace(#MetaKeywords#,"~",",","ALL")>
		<cfset MetaTitle=#MetaTitle#>
		<cfset MetaTitle=replace(#MetaTitle#,"~",",","ALL")>
		<cfset MetaDescription=#MetaDescription#>
		<cfset MetaDescription=replace(#MetaDescription#,"~",",","ALL")>
		<cfset CompanyName=#CompanyName#>
		<cfset CompanyName=replace(#CompanyName#,"~",",","ALL")>
		<cfset Description=#Description#>
		<cfset Description=replace(#Description#,"~",",","ALL")>
	</cfoutput>
<cfelse>
	<cfset DSN=''>
		<cfset DSNuName=''>
		<cfset DSNpWord=''>
		<cfset ReturnPath=''>
		<cfset IPAddress=''>
		<cfset ACTIVE=''>
		<cfset ADDRESS1=''>
		<cfset ADDRESS2=''>
		<cfset CELLNUMBER=''>
		<cfset CITY=''>
		<cfset COUNTRY=''>
		<cfset DateStarted=''>
		<cfset EMAIL=''>
		<cfset OWNERNAME=''>
		<cfset MailServer=''>
		<cfset PHONENUMBER=''>
		<cfset PWORD=''>
		<cfset STATE=''>
		<cfset USERNAME=''>
		<cfset WEBSITENAME=''>
		<cfset ZIP=''>
		<cfset MetaKeywords=''>
		<cfset MetaTitle=''>
		<cfset MetaDescription=''>
		<cfset CompanyName=''>
		<cfset Description=''>
</cfif>

<cfif isdefined('form.submit')>
	<cfset DSN=#form.DSN#>
	<cfset DSNuName=#form.DSNuName#>
	<cfset DSNpWord=#form.DSNpWord#>
	<cfset ReturnPath=#form.returnpath#>
	<cfset IPAddress=#form.IPAddress#>
	<cfset ACTIVE=#form.ACTIVE#>
	<cfset ADDRESS1=#form.ADDRESS1#>
	<cfset Address1=replace(#address1#,",","~","ALL")>
	<Cfif #Address1# is ''><cfset Address1="none"></Cfif>
	<cfset ADDRESS2=#form.ADDRESS2#>
	<Cfif #Address2# is ''><cfset Address2="none"></Cfif>
	<cfset ADDRESS2=replace(#ADDRESS2#,",","~","ALL")>
	<cfset CELLNUMBER=#form.CELLNUMBER#>
	<Cfif #CELLNUMBER# is ''><cfset CELLNUMBER="none"></Cfif>
	<cfset CITY=#form.CITY#>
	<Cfif #CITY# is ''><cfset CITY="none"></Cfif>
	<cfset COUNTRY=#form.COUNTRY#>
	<Cfif #COUNTRY# is ''><cfset COUNTRY="none"></Cfif>
	<cfset DateStarted=#dateformat(now())#>
	<cfset EMAIL=#form.EMAIL#>
	<cfset OWNERNAME=#form.OWNERNAME#>
	<Cfif #OWNERNAME# is ''><cfset OWNERNAME="none"></Cfif>
	<cfset MailServer=#form.MailServer#>
	<cfset PHONENUMBER=#form.PHONENUMBER#>
	<Cfif #PHONENUMBER# is ''><cfset PHONENUMBER="none"></Cfif>
	<cfset PWORD=#form.PWORD#>
	<cfset STATE=#form.STATE#>
	<Cfif #STATE# is ''><cfset STATE="none"></Cfif>
	<cfset USERNAME=#form.USERNAME#>
	<cfset WEBSITENAME=#form.WEBSITENAME#>
	<cfset WEBSITENAME=replace(#WEBSITENAME#,",","~","ALL")>
	<cfset ZIP=#form.ZIP#>
	<cfset MetaKeywords=#form.MetaKeywords#>
	<cfset MetaKeywords=replace(#MetaKeywords#,",","~","ALL")>
	<Cfif #MetaKeywords# is ''><cfset MetaKeywords="none"></Cfif>
	<cfset MetaTitle=#form.MetaTitle#>
	<cfset MetaTitle=replace(#MetaTitle#,",","~","ALL")>
	<Cfif #MetaTitle# is ''><cfset MetaTitle="none"></Cfif>
	<cfset MetaDescription=#form.MetaDescription#>
	<cfset MetaDescription=replace(#MetaDescription#,",","~","ALL")>
	<Cfif #MetaDescription# is ''><cfset MetaDescription="none"></Cfif>
	<cfset CompanyName=#form.CompanyName#>
	<cfset CompanyName=replace(#CompanyName#,",","~","ALL")>
	<Cfif #CompanyName# is ''><cfset CompanyName="none"></Cfif>
	<cfset Description=#form.Description#>
	<cfset Description=replace(#Description#,",","~","ALL")>
	<Cfif #Description# is ''><cfset Description="none"></Cfif>
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="WebSiteInfo">
			<cfinvokeargument name="XMLFields" value="DSN,DSNuName,DSNpWord,IPAddress,ACTIVE,ADDRESS1,ADDRESS2,CELLNUMBER,CITY,COUNTRY,DateStarted,EMAIL,OWNERNAME,MailServer,PHONENUMBER,PWORD,STATE,USERNAME,WEBSITENAME,ZIP,MetaKeywords,MetaTitle,MetaDescription,CompanyName,Description,ReturnPath">
			<cfinvokeargument name="XMLFieldData" value="#DSN#,#DSNuName#,#DSNpWord#,#IPAddress#,#ACTIVE#,#ADDRESS1#,#ADDRESS2#,#CELLNUMBER#,#CITY#,#COUNTRY#,#DateStarted#,#EMAIL#,#OWNERNAME#,#MailServer#,#PHONENUMBER#,#PWORD#,#STATE#,#USERNAME#,#WEBSITENAME#,#ZIP#,#MetaKeywords#,#MetaTitle#,#MetaDescription#,#CompanyName#,#Description#,#ReturnPath#">
			<cfinvokeargument name="XMLIDField" value="WebSiteID">
			<cfinvokeargument name="XMLIDValue" value="0000000001">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="websiteinfo">
			<cfinvokeargument name="XMLFields" value="DSN,DSNuName,DSNpWord,IPAddress,ACTIVE,ADDRESS1,ADDRESS2,CELLNUMBER,CITY,COUNTRY,DateStarted,EMAIL,OWNERNAME,MailServer,PHONENUMBER,PWORD,STATE,USERNAME,WEBSITENAME,ZIP,MetaKeywords,MetaTitle,MetaDescription,CompanyName,Description,ReturnPath">
			<cfinvokeargument name="XMLFieldData" value="#DSN#,#DSNuName#,#DSNpWord#,#IPAddress#,#ACTIVE#,#ADDRESS1#,#ADDRESS2#,#CELLNUMBER#,#CITY#,#COUNTRY#,#DateStarted#,#EMAIL#,#OWNERNAME#,#MailServer#,#PHONENUMBER#,#PWORD#,#STATE#,#USERNAME#,#WEBSITENAME#,#ZIP#,#MetaKeywords#,#MetaTitle#,#MetaDescription#,#CompanyName#,#Description#,#ReturnPath#">
			<cfinvokeargument name="XMLIDField" value="WebSiteID">
		</cfinvoke>
	</cfif>
	<cflocation url="../files/index.cfm">
</cfif>

<cfif #TheFileExists# is "false">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>New Web Site Information</title>

</head>
<cfoutput>
<body bgcolor="##0000A0" text="##EAEAF4" link="##DDFFDD" vlink="##FFDCB9" alink="##FFD7EB">
<font face="Arial"><center><h2>#WebSiteName# Administration</h2></cfoutput>
</cfif>

<h2 align="CENTER"><b>Enter Your Web Site Information</b></h2>
<cfform method="POST" action="../utilities/editaccount.cfm">
<cfoutput>
<input type="hidden" name="Active" value="1">
</cfoutput>
<table width="70%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
<tr>
<td width="50%"><font face="Arial"><b>Your Web site Name:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="Text" name="websitename" required="Yes" size="25" maxlength="25" value="#WebSiteName#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Your User Name:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="Text" name="username" required="Yes" size="25" maxlength="25"  value="#username#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Your Password:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput required="yes" message="please enter a passowrd"type="password" name="pWord" size="25" maxlength="25"  value="#pWord#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Verify Password:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput required="yes" message="Please verify your password" type="password" name="vWord" size="25" maxlength="25" value="#pWord#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Your Company Name:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="CompanyName" size="35" maxlength="75" value="#CompanyName#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Your Name:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="OwnerName" size="35" maxlength="75" value="#OwnerName#"> </b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Address 1:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="Address1" size="35" maxlength="75" value="#Address1#"> </b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Address 2:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="Address2" size="35" maxlength="35" value="#Address2#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>City:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="City" size="35" maxlength="35" value="#City#"></b></font></td>
</tr>
<tr>
<td width="27%"><font face="Arial"><b>State:</b></font></td>
<td width="41%"><font face="Arial"><b><cfinput type="text" name="State" size="35" maxlength="35" value="#State#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Postal Code:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="zip" size="15" maxlength="15" value="#zip#"></b></font></td>
</tr>
<tr>
<td width="27%"><font face="Arial"><b>
Country: </b></font></td>
<td width="41%"><font face="Arial"><b><cfinput type="text" name="Country" size="35" maxlength="35" value="#Country#"></b></font></td>
</tr>
<tr>
<td width="50%"><font face="Arial"><b>Phone Number:</b></font></td>
<td width="50%"><font face="Arial"><b><cfinput type="text" name="PhoneNumber" size="25" maxlength="25" value="#PhoneNumber#"></b></font></td>
</tr>
<tr>
<td width="27%"><font face="Arial"><b>Cellular Number:</b></font></td>
<td width="41%"><font face="Arial"><b><cfinput type="text" name="CellNumber" size="25" maxlength="25" value="#CellNumber#"></b></font></td>
</tr>
<tr>
<td><font face="Arial"><b>Email:</td>
<td> <cfinput type="Text" name="Email" message="Please enter your email address" required="Yes" size="35" maxlength="255" value="#Email#"></b></font></td>
</tr>

<tr>
<td><font face="Arial"><b>URL:</td>
<td> <cfinput type="Text" name="ReturnPath" message="Please enter your URL" required="Yes" size="35" maxlength="255" value="#ReturnPath#"></b></font></td>
</tr>
<tr>
<td><font face="Arial"><b>IP Address:</td>
<td> <cfinput type="Text" name="IPAddress" message="Please enter your IPAddress" required="Yes" size="35" maxlength="255" value="#IPAddress#"></b></font></td>
</tr>
<tr>
<td><font face="Arial">
<b>Web Site Description: </td>
<td> <textarea rows="5" name="description" cols="25"><cfoutput>#Description#</cfoutput></textarea></b></font></p></td>
</tr>
<tr>
<td><font face="Arial"><b>Meta Tag Keywords:</td>
<td> <textarea rows="5" name="MetaKeywords" cols="25"><cfoutput>#MetaKeywords#</cfoutput></textarea></b></font></p></td>
</tr>
<tr>
<td><font face="Arial"><b>Web Site Meta Tag Title:</td>
<td> <textarea rows="5" name="MetaTitle" cols="25"><cfoutput>#MetaTitle#</cfoutput></textarea></b></font></p></td>
</tr>
<tr>
<td><font face="Arial"><b>Meta Tag Description:</td>
<td> <textarea rows="5" name="MetaDescription" cols="25"><cfoutput>#MetaDescription#</cfoutput></textarea></b></font></p></td>
</tr>
<tr>
<td><font face="Arial"><b>Database Name:</td>
<td> <cfinput type="Text" name="DSN" message="Please enter your DSN" required="Yes" size="35" maxlength="255" value="#DSN#"></b></font></td>
</tr>
<tr>
<td><font face="Arial"><b>Database User Name:</td>
<td> <cfinput type="Text" name="DSNuName" message="Please enter your DSNuName" required="Yes" size="35" maxlength="255" value="#DSNuName#"></b></font></td>
</tr>
<tr>
<td><font face="Arial"><b>Database Password:</td>
<td> <cfinput type="Text" name="DSNpWord" message="Please enter your DSNpWord" required="Yes" size="35" maxlength="255" value="#DSNpWord#"></b></font></td>
</tr>

<tr>
<td><font face="Arial"><b>Email Server Name:</td>
<td> <cfinput type="Text" name="MailServer" message="Please enter your Email Server Name" required="Yes" size="35" maxlength="255" value="#MailServer#"></b></font></td>
</tr>

<tr>
<td>
<input type="submit" value="Apply" name="Submit"></td><td><input type="reset" value="Reset" name="Reset"></td>
</tr>
</table>
</cfform>
<cfif #TheFileExists# is "false">
</body>
</html>
</cfif>
