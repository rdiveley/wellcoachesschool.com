<cfparam name="resvCustID" default=0>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Customer">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="resvCusts">
	<cfinvokeargument name="selectstatement" value=" where resvCustID='#resvCustid#'">
</cfinvoke>
	
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
	<cfinvokeargument name="FileName" value="reservations">
	<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>

<cfif #theFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllProducts">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="resvProducts">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllPrograms">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="resvPrograms">
	</cfinvoke>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllReservations">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Reservations">
		<cfinvokeargument name="selectStatement" value=" where resvcustid='#resvCustID#'">
		<cfinvokeargument name="orderByStatement" value=" order by datecreated desc">
	</cfinvoke>
	<cfoutput>
	<table border="1" align="CENTER">
		<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Reservations for #Customer.firstname# #Customer.lastname#</th>
		<tr>
			<td><p>ID</p></td>
			<td><p>Product</p></td>
			<td><p>Program</p></td>
			<td><p>Location</p></td>
			<td><p>Dates</p></td>
			<td><p>Actions</p></td>
		</tr>
		<cfloop query="AllReservations">
		<cfquery name="product" dbtype="query">
			select productname from allproducts where productID='#productID#'
		</cfquery>
		<cfquery name="program" dbtype="query">
			select programname from allprograms where ProgramID='#programID#'
		</cfquery>
		<tr>
			<td align=center><p>#int(ReservationID)#</p></td>
			<td><p>#product.productname#</p></td>
			<td align=right><p>#program.programname#</p></td>
			<td><p>#dentinationCity#</p></td>
			<td><p>#dateformat(datefrom,"mm/dd/yyyy")# to #dateformat(dateto,"mm/dd/yyyy")#</p></td>
			<td><a href= "AdminHeader.cfm?ReservationID=#ReservationID#&ReservationsAction=Edit&action=Reservations">Edit</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?ReservationID#ReservationID#&ReservationsAction=Delete&action=Reservations')">Delete</a></td>
		</tr>
		
		</cfloop>
	</table>
	</cfoutput>
</cfif>