<cfparam name="ResvCustAction" default="list">
<cfparam name="TypeID" default=0>
<cfparam name="alphabet" default="a">
<cfif #ResvCustAction# is "delete">
	<cfinclude template="../utilities/ResvCusts_recordaction.cfm">
</cfif>
<cfinvoke method="GetResvCust" 
	component="#Application.WebSitePath#.utilities.reservations" 
	returnvariable="ResvCusts">
	<cfinvokeargument name="Alphabet" value="#Alphabet#">
</cfinvoke>
<cfset RcdCnt = #ResvCusts.RecordCount#>
<cfoutput>
<h2><a href="adminheader.cfm?Action=ResvCustsedit&LID=#LID#&ResvCustAction=add&alphabet=#Alphabet#&TypeID=#TypeID#">Add A New Reservation</a><br>Total Reservation Customers: #RcdCnt#<BR><br><a href="adminheader.cfm?Action=ResvCustsearch&LID=#LID#&TypeID=#TypeID#&alphabet=#Alphabet#">Search For A  Reservation Customer</a></h2>
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=a">A</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=b">B</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=c">C</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=d">D</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=e">E</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=f">F</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=g">G</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=h">H</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=i">I</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=j">J</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=k">K</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=l">L</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=m">M</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=n">N</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=o">O</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=p">P</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=q">Q</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=r">R</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=s">S</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=t">T</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=u">U</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=v">V</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=w">W</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=x">X</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=y">Y</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=z">Z</a></cfoutput>
<br><cfoutput><a href="adminheader.cfm?action=addReservations">Add a New Customer</a><br></cfoutput>
<TABLE class=toptable>

	
	<TR>
	<Th valign="top"> Name: </Th>
	<Th valign="top"> E-Mail: </Th>
	<Th valign="top"> Start Date: </Th>
	<Th valign="top"> Phone number: </Th>
	<Th valign="top"> Active: </Th>
	<Th valign="top"> Actions </Th>
	</tr><tr>
	<cfoutput query="ResvCusts">
	<TD><p>#trim(Title)# #trim(replace(firstName,"~",",","ALL"))# #Trim(replace(lastname,"~",",","ALL"))#</p></TD>
	<cfinvoke component="#Application.WebSitePath#.utilities.reservations" 
		method="GetResvCustEmail" returnvariable="ResvCustEmail">
		<cfinvokeargument name="ResvCustID" value="#trim(ResvCustid)#">
		<cfinvokeargument name="EMAILTYPEID" value="1">
	</cfinvoke>
    <TD><a href="mailto:#trim(ResvCustEmail.EmailAddress)#">#ResvCustEmail.EMailAddress#</a></TD>
    <TD><p>#dateformat(StartDate)#</p></TD>
	<cfinvoke component="#Application.WebSitePath#.utilities.reservations" 
		method="GetResvCustPhone" returnvariable="ResvCustPhone">
		<cfinvokeargument name="ResvCustID" value="#trim(ResvCustid)#">
		<cfinvokeargument name="PhoneTypeID" value="1">
	</cfinvoke>
    <TD><p>#ResvCustPhone.PhoneNumber#</p></TD>

    <cfif #Active# is 1>
	<td><p>YES</p></td>
	<cfelse>
    <TD><p>No</p></TD>
	</cfif>
	
	<td nowrap><a href= "adminheader.cfm?ResvCustID=#ResvCustID#&ResvCustAction=edit&Action=ResvCustsedit&LID=#LID#&alphabet=#Alphabet#">Edit</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:confirmDelete('adminheader.cfm?ResvCustID=#ResvCustID#&ResvCustAction=delete&Action=#action#&LID=#LID#&alphabet=#Alphabet#')">Delete</a>
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ResvCustID=#ResvCustID#&Action=resvCustHistory&LID=#LID#&alphabet=#Alphabet#">Reservation History</a>
</td>
	</tr></CFOUTPUT>
		
</TABLE>

