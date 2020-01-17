
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="MethodID" default=0>
<cfparam name="MethodAction" default="List">
<cfparam name="MethodName" default="">
<cfparam name="MethodDescription" default="">
<cfparam name="DateToStart" default="#now()#">
<cfparam name="Percentage" default="0">
<cfparam name="DateToEnd" default="">
<cfparam name="PercentagePer" default="30">
<cfparam name="ShowOnPage" default="homepage">


<cfif MethodAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffMethods">
		<cfinvokeargument name="XMLFields" value="MethodID,MethodDescription,MethodName,DateToStart,Percentage,DateToEnd,PercentagePer,ShowOnPage">
		<cfinvokeargument name="XMLIDField" value="MethodID">
		<cfinvokeargument name="XMLIDValue" value="#MethodID#">
	</cfinvoke>
	<cfset MethodID=0>
	<cfset MethodAction="List">
</cfif>
		
<cfif MethodID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AffMethods">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="AffMethods">
		<cfinvokeargument name="IDFieldName" value="MethodID">
		<cfinvokeargument name="IDFieldValue" value="#MethodID#">
	</cfinvoke>
	<cfoutput query="AffMethods">
		<cfset MethodName=#MethodName#>
		<cfset DateToStart=#DateToStart#>
		<cfset MethodDescription=#MethodDescription#>
		<cfset Percentage=#Percentage#>
		<cfset DateToEnd=#DateToEnd#>
		<cfset PercentagePer=#PercentagePer#>
		<cfset ShowOnPage=#ShowOnPage#>
		<cfset MethodName = replace(#MethodName#,"~",",","ALL")>
		<cfset MethodDescription = replace(#MethodDescription#,"~",",","ALL")>
	</cfoutput>
	<cfset MethodAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif not isdefined('form.MethodDescription')><cfset form.MethodDescription="none"></cfif>
	<cfif #form.DateToEnd# is ''><cfset form.DateToEnd="none"></cfif>
	<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
	<cfif not isdate(#form.DateToEnd#)><cfset form.DateToEnd=dateadd("d",3650,#form.DateToStart#)></cfif>
	<cfif #form.MethodName# is ''><cfset form.MethodName="none"></cfif>
	<cfset form.MethodName = replace(#form.MethodName#,",","~","ALL")>
	<cfif #form.MethodDescription# is ''><cfset form.MethodDescription="none"></cfif>
	<cfset form.MethodDescription = replace(#form.MethodDescription#,",","~","ALL")>
	<cfif #form.Percentage# is ''><cfset form.Percentage="0.00"></cfif>
	<cfif MethodID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="AffMethods">
			<cfinvokeargument name="XMLFields" value="MethodDescription,MethodName,DateToStart,Percentage,DateToEnd,PercentagePer,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.MethodDescription#,#form.MethodName#,#form.DateToStart#,#form.Percentage#,#form.DateToEnd#,#form.PercentagePer#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="MethodID">
			<cfinvokeargument name="XMLIDValue" value="#MethodID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="AffMethods">
			<cfinvokeargument name="XMLFields" value="MethodDescription,MethodName,DateToStart,Percentage,DateToEnd,PercentagePer,ShowOnPage">
		<cfinvokeargument name="XMLFieldData" value="#form.MethodDescription#,#form.MethodName#,#form.DateToStart#,#form.Percentage#,#form.DateToEnd#,#form.PercentagePer#,#form.ShowOnPage#">
			<cfinvokeargument name="XMLIDField" value="MethodID">
		</cfinvoke>
	</cfif>
	<cfset MethodAction="list">
	<cfset MethodName="">
	<cfset DateToStart = #now()#>
	<cfset MethodID = 0>
	<cfset MethodDescription=''>
	<cfset Percentage='0'>
	<cfset DateToEnd=''>
	<cfset PercentagePer="30">
	<cfset ShowOnPage="homepage">
	<cfset TheFileExists="true">
</cfif>

<cfoutput>
<h1>Affiliate Program Methods</h1>
<form name="thisform" action="adminheader.cfm" enctype="multipart/form-data" method="post">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="MethodID" value="#MethodID#">
<TABLE>

	<TR>
	<TD valign="top"> Method Name: </TD>
    <TD>
	
		<INPUT type="text" name="methodname" value="#methodname#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<textarea name="Methoddescription">#Methoddescription#</textarea>
		
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Date To Start: </TD>
    <TD>
	
		<INPUT type="text" name="datetostart" value="#dateformat(datetostart,'mm/dd/yyyy')#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Date To End: </TD>
    <TD>
	
		<INPUT type="text" name="dateToEnd" value="#dateformat(dateToEnd,'mm/dd/yyyy')#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Percentage/Amount Affiliate gets from this method: </TD>
    <TD>
	
		<INPUT type="text" name="Percentage" value="#Percentage#" maxLength="5">
		
	</TD>
	<!--- field validation --->
	</TR>
	<TR>
	<TD valign="top"> Per (time period or ## of items purchased by the affiliates customer: </TD>
    <TD>
	
		<select name="PercentagePer">
			<option value=0>None
			<option value="Day"<cfif #PercentagePer# is "Day"> selected</cfif>>Per Day
			<option value="Week"<cfif #PercentagePer# is "Week"> selected</cfif>>Per Week
			<option value="Month"<cfif #PercentagePer# is "Month"> selected</cfif>>Per Month
			<option value="Quarter"<cfif #PercentagePer# is "Quarter"> selected</cfif>>Per Quarter
			<option value="Year"<cfif #PercentagePer# is "Year"> selected</cfif>>Per Year
			<option value="Subscription"<cfif #PercentagePer# is "Subscription"> selected</cfif>>Per Subscription
			<option value="Product"<cfif #PercentagePer# is "Product"> selected</cfif>>Per Product
			<option value="Item"<cfif #PercentagePer# is "Item"> selected</cfif>>Per Click
			<option value="Item"<cfif #PercentagePer# is "Impression"> selected</cfif>>Per Impression
		</select>
		
	</TD>
	<!--- field validation --->
	</TR>
	<tr>
          <td width="50%">Affiliate Registration Page for this method</td>
          <td width="50%">
		  <select name="ShowOnPage">
		<option value="0">None
	   	<cfloop query="allpages">
			<option value="#pagename#" <cfif #ShowOnPage# is #pagename#>selected</cfif>>#pagename#
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
		<cfinvokeargument name="FileName" value="affMethods">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllaffMethods">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="affMethods">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Affiliate Program Methods</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Percentage</p></td>
<td><p>Per</p></td>
<td><p>Date To Start</p></td>
<td><p>Date To End</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllaffMethods">
<tr>
<td><p>#MethodID#</p></td>
<td><p>#MethodName#</p></td>
<td><p>#Percentage#</p></td>
<td><p>#PercentagePer#</p></td>
<td><p>#dateformat(DateTostart,'mm/dd/yyyy')#</p></td>
<td><p>#dateformat(DateToEnd,'mm/dd/yyyy')#</p></td>

<td><a href= "adminheader.cfm?MethodID=#MethodID#&MethodAction=Edit&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?MethodID=#MethodID#&MethodAction=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</table>
</cfif>

