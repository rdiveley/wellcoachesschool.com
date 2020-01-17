
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllaffMethods">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="affMethods">
</cfinvoke>

<cfparam name="TypeID" default=0>
<cfparam name="TypeAction" default="List">
<cfparam name="availability" default="">
<cfparam name="TypeDescription" default="">
<cfparam name="DateToStart" default="#now()#">
<cfparam name="Price" default="0">
<cfparam name="DateToEnd" default="">
<cfparam name="NoOfImpressions" default="30">
<cfparam name="ShowOnPage" default="homepage">


<cfif TypeAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
		<cfinvokeargument name="XMLFields" value="TypeDescription,availability,DateToStart,Price,DateToEnd,NoOfImpressions,ShowOnPage">
		<cfinvokeargument name="XMLIDField" value="TypeID">
		<cfinvokeargument name="XMLIDValue" value="#TypeID#">
	</cfinvoke>
	<cfset TypeID=0>
	<cfset TypeAction="List">
</cfif>
		
<cfif TypeID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AffDealerTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
		<cfinvokeargument name="IDFieldName" value="TypeID">
		<cfinvokeargument name="IDFieldValue" value="#TypeID#">
	</cfinvoke>
	<cfoutput query="AffDealerTypes">
		<cfset availability=#availability#>
		<cfset DateToStart=#DateToStart#>
		<cfset TypeDescription=#TypeDescription#>
		<cfset Price=#Price#>
		<cfset DateToEnd=#DateToEnd#>
		<cfset NoOfImpressions=#NoOfImpressions#>
		<cfset ShowOnPage=#ShowOnPage#>
		<cfset availability = replace(#availability#,"~",",","ALL")>
		<cfset TypeDescription = replace(#TypeDescription#,"~",",","ALL")>
	</cfoutput>
	<cfset TypeAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.TypeDescription')><cfset form.TypeDescription="none"></cfif>
	<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif not isdate(#form.DateToEnd#)><cfset form.DateToEnd=dateadd("d",3650,#form.DateToStart#)></cfif>
	<cfif #form.availability# is ''><cfset form.availability="none"></cfif>
	<cfset form.availability = replace(#form.availability#,",","~","ALL")>
	<cfif #form.TypeDescription# is ''><cfset form.TypeDescription="none"></cfif>
	<cfset form.TypeDescription = replace(#form.TypeDescription#,",","~","ALL")>
	<cfif #form.Price# is ''><cfset form.Price="0.00"></cfif>
	<cfif TypeID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,availability,DateToStart,Price,DateToEnd,NoOfImpressions,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.NoOfImpressions#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
			<cfinvokeargument name="XMLFields" value="TypeDescription,availability,DateToStart,Price,DateToEnd,NoOfImpressions,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.TypeDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.NoOfImpressions#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
	</cfif>
	<cfset TypeAction="list">
	<cfset availability="">
	<cfset DateToStart = #now()#>
	<cfset TypeID = 0>
	<cfset TypeDescription=''>
	<cfset Price='0'>
	<cfset DateToEnd=''>
	<cfset NoOfImpressions="30">
	<cfset ShowOnPage="homepage">
	<cfset TheFileExists="true">
</cfif>

<cfoutput>
<h1>Affiliate Commission Structure</h1>
<form name="thisform" action="AdminHeader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="TypeID" value="#TypeID#">
<input type="hidden" name="Action" value="#Action#">

<TABLE>
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<textarea name="TypeDescription" cols=40 rows=5>#TypeDescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Pecentage parent affiliate gets from sub affiliate sales: </TD>
    <TD>
	
		<INPUT type="text" name="Price" value="#Price#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> ## of Sub Affiliates necessary to reach<br>this commission structure: </TD>
    <TD>
	
		<INPUT type="text" name="NoOfImpressions" value="#NoOfImpressions#" maxLength="15">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Method to apply this commission structure to: </TD>
    <TD>
	<select name="Availability">
		<cfloop query="AllaffMethods">
			<option value="#MethodID#"<cfif #Availability# is #MethodID#> selected</cfif>>#MethodName#</option>
		</cfloop>
	</select>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Page where sub affiliates sign up: </TD>
    <TD>
	<select name="ShowOnPage">
		<option value="0">None
	   	<cfloop query="AllPages">
			<option value="#PageName#" <cfif #ShowOnPage# is #PageName#>selected</cfif>>#PageName#
		</cfloop>
	</select>
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date Started: </TD>
    <TD>
	
		<INPUT type="text" name="DateToStart" value="#dateformat(DateToStart,'mm/dd/yyyy')#" maxLength="16">
		(i.e. 12/31/97)
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="DateToStart_date">
	</TR>
	
	
	<TR>
	<TD valign="top"> Date Ended: </TD>
    <TD>
	
		<INPUT type="text" name="DateToEnd" value="#dateformat(DateToEnd,'mm/dd/yyyy')#" maxLength="16">
		(i.e. 12/31/97)
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="DateToEnd_date">
	</TR>
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="AffDealerTypes">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllAffDealerTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffDealerTypes">
	</cfinvoke>

<table border="1" align="CENTER">
<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Dealer Types</th>
<tr>
<td><p>ID</p></td>
<td><p>description</p></td>
<td><p>Price</p></td>
<td><p>No Of Impressions</p></td>
<td><p>Actions</p></td>
</tr>
<cfoutput query="AllAffDealerTypes">
<tr>
<td align=center><p>#int(TypeID)#</p></td>
<td><p>#TypeDescription#</p></td>
<td align=right><p>#dollarformat(Price)#</p></td>
<td align=center><p>#NoOfImpressions#</p></td>
<td><a href= "AdminHeader.cfm?TypeID=#TypeID#&TypeAction=Edit&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?TypeID=#TypeID#&TypeAction=Delete&action=#action#')">Delete</a></td>
</tr>
</cfoutput>
</table>

</cfif>