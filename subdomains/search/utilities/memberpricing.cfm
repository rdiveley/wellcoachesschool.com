
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="PricingID" default=0>
<cfparam name="PricingAction" default="List">
<cfparam name="PricingName" default="">
<cfparam name="PricingDescription" default="">
<cfparam name="DateToStart" default="#now()#">
<cfparam name="Price" default="0">
<cfparam name="DateToEnd" default="">
<cfparam name="PricePer" default="30">
<cfparam name="ShowOnPage" default="homepage">


<cfif PricingAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberPricing">
		<cfinvokeargument name="XMLFields" value="PricingID,PricingDescription,PricingName,DateToStart,Price,DateToEnd,PricePer,ShowOnPage">
		<cfinvokeargument name="XMLIDField" value="PricingID">
		<cfinvokeargument name="XMLIDValue" value="#PricingID#">
	</cfinvoke>
	<cfset PricingID=0>
	<cfset PricingAction="List">
</cfif>
		
<cfif PricingID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="MemberPricing">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberPricing">
		<cfinvokeargument name="IDFieldName" value="PricingID">
		<cfinvokeargument name="IDFieldValue" value="#PricingID#">
	</cfinvoke>
	<cfoutput query="MemberPricing">
		<cfset PricingName=#PricingName#>
		<cfset DateToStart=#DateToStart#>
		<cfset PricingDescription=#PricingDescription#>
		<cfset Price=#Price#>
		<cfset DateToEnd=#DateToEnd#>
		<cfset PricePer=#PricePer#>
		<cfset ShowOnPage=#ShowOnPage#>
		<cfset PricingName = replace(#PricingName#,"~",",","ALL")>
		<cfset PricingDescription = replace(#PricingDescription#,"~",",","ALL")>
	</cfoutput>
	<cfset PricingAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.pricingdescription')><cfset form.pricingDescription="none"></cfif>
	<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif #form.DateToEnd# is '' or #Form.DateToEnd# is "none"><cfset form.DateToEnd="#dateadd('d',3653,form.DateToStart)#"></cfif>
	<cfif #form.PricingName# is ''><cfset form.PricingName="none"></cfif>
	<cfset form.PricingName = replace(#form.PricingName#,",","~","ALL")>
	<cfif #form.PricingDescription# is ''><cfset form.PricingDescription="none"></cfif>
	<cfset form.PricingDescription = replace(#form.PricingDescription#,",","~","ALL")>
	<cfif #form.Price# is ''><cfset form.Price="0.00"></cfif>
	<cfif PricingID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MemberPricing">
			<cfinvokeargument name="XMLFields" value="PricingDescription,PricingName,DateToStart,Price,DateToEnd,PricePer,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.PricingDescription#,#form.PricingName#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.PricePer#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="PricingID">
			<cfinvokeargument name="XMLIDValue" value="#PricingID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="MemberPricing">
			<cfinvokeargument name="XMLFields" value="PricingDescription,PricingName,DateToStart,Price,DateToEnd,PricePer,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.PricingDescription#,#form.PricingName#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.PricePer#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="PricingID">
		</cfinvoke>
	</cfif>
	<cfset PricingAction="list">
	<cfset PricingName="">
	<cfset DateToStart = #now()#>
	<cfset PricingID = 0>
	<cfset PricingDescription=''>
	<cfset Price='0'>
	<cfset DateToEnd=''>
	<cfset PricePer="30">
	<cfset ShowOnPage="homepage">
</cfif>

<cfoutput>
<h1>MemberPricing</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="PricingID" value="#PricingID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="PricingAction" value="#PricingAction#">
<TABLE>

	<TR>
	<TD valign="top"> Pricing Name: </TD>
    <TD>
		<input type="text" name="PricingName" maxlength=150 size=25 value="#PricingName#">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Pricing Restrictions: </TD>
    <TD>
		Allow Member to have a Contacts List <input type="checkbox" name="PricingDescription" value="Contacts" <cfif #Listfind(PricingDescription,"Contacts")#>checked</cfif>><br> 
		Allow Members to Create Newsletters <input type="checkbox" name="PricingDescription" value="Newsletters" <cfif #Listfind(PricingDescription,"Newsletters")#>checked</cfif>><br> 
	  Allow Members to Create Polls <input type="checkbox" name="PricingDescription" value="Polls" <cfif #Listfind(PricingDescription,"Polls")#>checked</cfif>><br> 
	   Allow Members to Create A Gallery <input type="checkbox" name="PricingDescription" value="Gallery" <cfif #Listfind(PricingDescription,"Gallery")#>checked</cfif>><br> 
	   Allow Members to Create A Calendar <input type="checkbox" name="PricingDescription" value="Calendar" <cfif #Listfind(PricingDescription,"Calendar")#>checked</cfif>><br> 
		 Allow Members to Create Articles <input type="checkbox" name="PricingDescription" value="Articles" <cfif #Listfind(PricingDescription,"Articles")#>checked</cfif>><br> 
	   Allow Members to Create a Guest Book <input type="checkbox" name="PricingDescription" value="GuestBook" <cfif #Listfind(PricingDescription,"GuestBook")#>checked</cfif>><br> 
	   Member Can Become an Affiliate <input type="checkbox" name="PricingDescription" value="Affiliate" <cfif #Listfind(PricingDescription,"Affiliate")#>checked</cfif>><br> 
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date To Start: </TD>
    <TD>
		<input type="text" name="DateToStart" value="#dateformat(DateToStart,'mm/dd/yyyy')#"><br> (i.e. 12/31/1997)

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date To End: </TD>
    <TD>
		<input type="text" name="DateToEnd" value="#dateformat(DateToEnd,'mm/dd/yyyy')#"><br> (i.e. 12/31/1997)

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Price </td>
	<td><input type="text" value="#Price#" name="Price"> Per: <select name="PricePer">
	<option value="1"<cfif #PricePer# is "1"> selected</cfif>>Day</option>
	<option value="3"<cfif #PricePer# is "3"> selected</cfif>>3 Days</option>
	<option value="5"<cfif #PricePer# is "5"> selected</cfif>>5 Days</option>
	<option value="7"<cfif #PricePer# is "7"> selected</cfif>>Week</option>
	<option value="14"<cfif #PricePer# is "14"> selected</cfif>>Two Weeks</option>
	<option value="30"<cfif #PricePer# is "30"> selected</cfif>>Month</option>
	<option value="90"<cfif #PricePer# is "90"> selected</cfif>>Quarter</option>
	<option value="183"<cfif #PricePer# is "183"> selected</cfif>>Semi-Annually</option>
	<option value="365"<cfif #PricePer# is "365"> selected</cfif>>Year</option>
	</select></td>
	</tr>
	
	<tr>
	<td valign=top> Page to show this pricing on</td>
	<td><select name="ShowOnPage">
	   	<cfloop query="AllPages">
			<option value="#Pagename#" <cfif #ShowOnPage# is #Pagename#>selected</cfif>>#Pagename#
		</cfloop>
		</select></td>
	</tr>
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="MemberPricing">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllMemberPricing">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="MemberPricing">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="6" align="CENTER" bgcolor="Maroon"><p>Your Member Pricing</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price</p></td>
<td><p>Date To Start</p></td>
<td><p>Date To End</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllMemberPricing">
<tr>
<td><p>#PricingID#</p></td>
<td><p>#PricingName#</p></td>
<td><p>#dollarformat(Price)#</p></td>
<cfif isdate(#datetostart#)>
<td><p>#dateformat(DateTostart,'mm/dd/yyyy')#</p></td>
<cfelse>
<td><p>&nbsp;</p></td>
</cfif>
<cfif isdate(#datetoend#)>
<td><p>#dateformat(DateToEnd,'mm/dd/yyyy')#</p></td>
<cfelse>
<td><p>&nbsp;</p></td>
</cfif>

<td><a href= "adminheader.cfm?PricingID=#PricingID#&PricingAction=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?PricingID=#PricingID#&PricingAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

