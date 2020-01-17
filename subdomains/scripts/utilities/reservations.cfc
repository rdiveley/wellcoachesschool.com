<cfcomponent>

	<cffunction name="ReservationsAdmin" access="remote" returntype="string" output="true">
		<cfargument name="ReservationsAction" type="string" required="true" default="List">
		<cfargument name="theformdata" type="string" required="false">
		<cfset ReservationsAction=#arguments.ReservationsAction#>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllReservations">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Reservations">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllLocations">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="locations">
		</cfinvoke>
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
			method="GetXMLRecords" returnvariable="AllCustomers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="resvCusts">
			<cfinvokeargument name="orderbystatement" value=" order by lastname">
		</cfinvoke>
		
		<cfparam name="ReservationID" default=0>
		<cfparam name="rentalPeriod" default="">
		<cfparam name="DateFrom" default="#now()#">
		<cfparam name="DateCreated" default="#now()#">
		<cfparam name="ProductID" default="0">
		<cfparam name="ProgramID" default="0">
		<cfparam name="contactTime" default="">
		<cfparam name="SpecialNeeds" default=" ">
		<cfparam name="ResvCustID" default=0>
		<cfparam name="dentinationCity" default="List">
		<cfparam name="dentinationState" default="">
		<cfparam name="DateTo" default="#now()#">
		<cfparam name="dentinationCountry" default="0">
		<cfparam name="dentinationZip" default="0">
		<cfparam name="dentinationPhone" default="">
		<cfparam name="dentinationaddress" default=" ">
		<cfparam name="status" default="0">
		<cfparam name="locationid" default="0">
				
		<cfif arguments.ReservationsAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Reservations">
				<cfinvokeargument name="XMLFields" value="ReservationID,DateCreated,LocationTypeID,ProgramID,contactTime,SpecialNeeds,rentalPeriod,DateFrom,DateTo,dentinationaddress,dentinationCity,dentinationState,dentinationCountry,dentinationZip,dentinationPhone,ResvCustID,status,locationid">
				<cfinvokeargument name="XMLIDField" value="ReservationID">
				<cfinvokeargument name="XMLIDValue" value="#ReservationID#">
			</cfinvoke>
			<cfset ReservationID=0>
			<cfset arguments.ReservationsAction="List">
		</cfif>
		
		<cfif arguments.ReservationsAction is "update">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Reservations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Reservations">
				<cfinvokeargument name="IDFieldName" value="ReservationID">
				<cfinvokeargument name="IDFieldValue" value="#form.reservationID#">
			</cfinvoke>
			<cfset form.rentalPeriod="">
			<Cfset form.productid=replace(form.productID,",","~","ALL")>
			<cfset form.DateFrom="#dateformat(form.DateFrom,'yyyy/mm/dd')#">
			<cfset form.DateCreated="#dateformat(Reservations.datecreated,'yyyy/mm/dd')#">
			<cfset form.SpecialNeeds=replace(form.specialNeeds,",","~","ALL")>
			<cfset form.dentinationCity=replace(form.destinationCity,",","~","ALL")>
			<cfset form.dentinationState=replace(form.destinationState,",","~","ALL")>
			<cfset form.DateTo="#dateformat(form.DateTo,'yyyy/mm/dd')#">
			<cfset form.form.dentinationCountry=replace(form.destinationCountry,",","~","ALL")>
			<cfset form.dentinationZip=replace(form.destinationZip,",","~","ALL")>
			<cfset form.dentinationPhone=replace(form.destinationPhone,",","~","ALL")>
			<cfset form.dentinationaddress=replace(form.destinationaddress,",","~","ALL")>
			
			<cfif ReservationID gt 0>
				<cfif form.rentalperiod is ""><cfset form.rentalperiod=1>></cfif>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="reservations">
					<cfinvokeargument name="XMLFields" value="DateCreated,ProductID,ProgramID,contactTime,SpecialNeeds,rentalPeriod,DateFrom,DateTo,dentinationaddress,dentinationCity,dentinationState,dentinationCountry,dentinationZip,dentinationPhone,ResvCustID,status,locationid">
				<cfinvokeargument name="XMLFieldData" value="#dateformat(form.DateCreated,'yyyy/mm/dd')#,#Form.ProductID#,#form.ProgramID#,#form.contactTime#,#form.SpecialNeeds# ,#form.rentalperiod#,#dateformat(Form.DateFrom,'yyyy/mm/dd')# ,#dateformat(form.DateTo,'yyyy/mm/dd')# ,#Form.dentinationaddress# ,#Form.dentinationCity# ,#Form.dentinationState# ,#Form.dentinationCountry# ,#Form.dentinationZip# ,#Form.dentinationPhone# ,#ResvCustID# ,#form.status#,#form.locationid#">
					<cfinvokeargument name="XMLIDField" value="ReservationID">
					<cfinvokeargument name="XMLIDValue" value="#ReservationID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
				method="InsertXMLRecord" returnvariable="NewReservationID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="reservations">
				<cfinvokeargument name="XMLFields" value="DateCreated,ProductID,ProgramID,contactTime,SpecialNeeds,rentalPeriod,DateFrom,DateTo,dentinationaddress,dentinationCity,dentinationState,dentinationCountry,dentinationZip,dentinationPhone,ResvCustID,status,locationid">
				<cfinvokeargument name="XMLFieldData" value="#dateformat(form.DateCreated,'yyyy/mm/dd')#,#Form.ProductID#,#form.ProgramID#,#form.contactTime#,#form.SpecialNeeds# ,#form.rentalperiod#,#dateformat(Form.DateFrom,'yyyy/mm/dd')# ,#dateformat(form.DateTo,'yyyy/mm/dd')# ,#Form.dentinationaddress# ,#Form.dentinationCity# ,#Form.dentinationState# ,#Form.dentinationCountry# ,#Form.dentinationZip# ,#Form.dentinationPhone# ,#ResvCustID# ,#form.status#,#form.locationid#">
				<cfinvokeargument name="XMLIDField" value="ReservationID">
			</cfinvoke>
			</cfif>
			<cfset ReservationID=0>
			<cfset arguments.ReservationsAction="List">
			<cfset rentalPeriod="">
			<cfset DateFrom="#now()#">
			<cfset DateCreated="#now()#">
			<cfset ProductID="0">
			<cfset ProgramID="0">
			<cfset contactTime="">
			<cfset SpecialNeeds=" ">
			<cfset ResvCustID=0>
			<cfset dentinationCity="List">
			<cfset dentinationState="">
			<cfset DateTo="#now()#">
			<cfset dentinationCountry="0">
			<cfset dentinationZip="0">
			<cfset dentinationPhone="">
			<cfset dentinationaddress=" ">
			<cfset status=0>
			<cfset locationid=0>
		</cfif>
		
		<cfif arguments.ReservationsAction is "edit">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Reservations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Reservations">
				<cfinvokeargument name="IDFieldName" value="ReservationID">
				<cfinvokeargument name="IDFieldValue" value="#ReservationID#">
			</cfinvoke>
			<cfif #reservations.recordcount# gt 0>HERE<BR>
				<cfset ReservationID=#Reservations.ReservationID#>
				<cfset ReservationsAction=#arguments.ReservationsAction#>
				<cfset rentalPeriod=#Reservations.rentalPeriod#>
				<cfset DateFrom=#dateformat(Reservations.DateFrom,"mm/dd/yyyy")#>
				<cfset DateCreated=#dateformat(Reservations.DateCreated,"mm/dd/yyyy")#>
				<cfset ProductID=#replace(Reservations.ProductID,"~",",","ALL")#>
				<cfset tProductID=#ProductID#>
				<cfset ProgramID=#Reservations.ProgramID#>
				<cfset contactTime=#Reservations.contactTime#>
				<cfset SpecialNeeds=replace(Reservations.SpecialNeeds,"~",",","ALL")>
				<cfset ResvCustID=#Reservations.ResvCustID#>
				<cfset dentinationCity=replace(Reservations.dentinationCity,"~",",","ALL")>
				<cfset dentinationState=replace(Reservations.dentinationState,"~",",","ALL")>
				<cfset DateTo=#dateformat(Reservations.DateTo,"mm/dd/yyyy")#>
				<cfset dentinationCountry=replace(Reservations.dentinationCountry,"~",",","ALL")>
				<cfset dentinationZip=replace(Reservations.dentinationZip,"~",",","ALL")>
				<cfset dentinationPhone=replace(Reservations.dentinationPhone,"~",",","ALL")>
				<cfset dentinationaddress=replace(Reservations.dentinationaddress,"~",",","ALL")>
				<cfset status=reservations.status>
				<cfset locationid=reservations.locationid>
				<cfset tLocationID=LocationID>
			<cfelse>
				<cfset ReservationID=0>
				<cfset ReservationsAction="List">
				<cfset rentalPeriod="">
				<cfset DateFrom="#dateformat(now(),'mm/dd/yyyy')#">
				<cfset DateCreated="#dateformat(now(),'mm/dd/yyyy')#">
				<cfset ProductID="0">
				<cfset tProductID=0>
				<cfset ProgramID="0">
				<cfset contactTime="">
				<cfset SpecialNeeds=" ">
				<cfset ResvCustID=0>
				<cfset dentinationCity="List">
				<cfset dentinationState="">
				<cfset DateTo="#dateformat(now(),'mm/dd/yyyy')#">
				<cfset dentinationCountry="0">
				<cfset dentinationZip="0">
				<cfset dentinationPhone="">
				<cfset dentinationaddress=" ">
				<cfset status=0>
				<cfset locationid=0>
				<cfset tLocationID=0>
			</cfif>
			<cfset arguments.ReservationsAction="update">
		</cfif>
		<cfif arguments.ReservationsAction is "edit" or arguments.ReservationsACtion is "update" or arguments.ReservationsAction is "add">
		<cfoutput>
		<h1>Reservations</h1>
		<cfform name="thisform" action="AdminHeader.cfm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="ReservationID" value="#ReservationID#">
		<input type="hidden" name="ReservationsAction" value="#arguments.ReservationsAction#">
		<input type="hidden" name="Action" value="Reservations">
		<table cellpadding=0 cellspacing=0 border=1 width=100%>
		<tr><td colspan=2><font color=black><h2 style="color:black;">Reservation</h2></font></td></tr>
		<tr><td><font color=black><strong>Rental Product &raquo;:</strong></font></td><td>
		<cfloop query="allProducts">
		<Cfif listfindnocase(#tProductID#,#allproducts.ProductID#)>
		<input type="checkbox" value="#ProductID#" name="productID" checked>#replace(ProductName,"~",",","ALL")#<br>
		<cfelse>
		<input type="checkbox" value="#ProductID#" name="productID">#replace(ProductName,"~",",","ALL")#<br>
		</cfif>
		</cfloop>
		</td></tr>
		<tr><td><font color=black><strong>Rental Program &raquo;:</strong></font></td><td><cfselect name="programID"><cfloop query="allprograms"><option value="#allprograms.programid#"<cfif #programID# is #allprograms.programid#> selected</cfif>>#programDescription#</option></cfloop></cfselect></td></tr>
		<tr><td><font color=black><strong>Dealer Location &raquo;:</strong></font></td><td><cfselect name="locationID"><cfloop query="allLocations"><option value="#alllocations.locationid#"<cfif #tlocationid# is #alllocations.locationid#> selected</cfif>>#alllocations.city# #alllocations.state#</option></cfloop></cfselect></td></tr>
		<tr><td><font color=black><strong>Customer:</strong></font></td><td><cfselect name="resvCustID"><cfloop query="allCustomers"><option value="#allcustomers.resvCustID#" <cfif #reservations.resvCustID# is #allCustomers.resvCustID#> selected</cfif>>#firstname# #lastname#</option></cfloop></cfselect></td></tr>
		<tr><td><font color=black><strong>Best Time To Contact?:</strong></font></td><td><cfselect name="contacttime"><option value="Morning"<cfif #contacttime# is "Morning"> selected</cfif>>Morning</option><option value="Afternoon"<cfif #contacttime# is "Afternoon"> selected</cfif>>Afternoon</option><option value="Evening"<cfif #contacttime# is "Evening"> selected</cfif>>Evening</option><option value="Weekends"<cfif #contacttime# is "Weekends"> selected</cfif>>Weekends</option></cfselect></td></tr>
		<tr><td><font color=black><strong>Special Needs Or Requests</strong><BR>(Please specify any requested wheelchair seat size or ramp length if applies)</font></td><td><textarea name="specialneeds" rows="5" cols="20">#specialNeeds#</textarea></td></tr>
		<tr><td><font color=black><strong>Rental Period Less Or Over 14 days? &raquo:</strong></font></td><td><font color=black><cfif #rentalPeriod# is "1"><cfinput type=radio name="rentalperiod" value="1" required="Yes" message="Please select a Rental Period" checked><cfelse><cfinput type=radio name="rentalperiod" value="1" required="Yes" message="Please select a Rental Period"></cfif> Delivery and Pick Up Free if Rental Period is Over Two weeks<br><font color=black><cfif #rentalPeriod# is "2"><cfinput type=radio name="rentalperiod" value="2" required="Yes" message="Please select a Rental Period" checked><cfelse><cfinput type=radio name="rentalperiod" value="2" required="Yes" message="Please select a Rental Period"></cfif> Delivery and Pick Up Fee is $50.00 if Rental Period is less than two Weeks<br></td></tr>
		<tr><td><font color=black><strong>Date Needed From &raquo</strong></font></td><td><cfinput type="text" name="datefrom" size="25" maxlength="250" value="#datefrom#" required="Yes" message="Please enter Date Needed From."></td></tr>
		<tr><td><font color=black><strong>Date Needed To &raquo</strong></font></td><td><cfinput type="text" name="dateto" size="25" maxlength="250" value="#dateto#" required="Yes" message="Please enter Date Needed To."></td></tr>
		<tr><td colspan=2><br><br><font color=red><STRONG>Provide Rental Destination Information</STRONG></font><br><br></td></tr>
		<tr><td><font color=black><strong>Destination Address &raquo</strong></font></td><td><cfinput type="text" name="Destinationaddress" size="25" maxlength="250" value="#dentinationaddress#" required="Yes" message="Please enter destination address."></td></tr>
		<tr><td><font color=black><strong>Destination City &raquo</strong></font></td><td><cfinput type="text" name="destinationcity" size="25" maxlength="250" value="#dentinationcity#" required="Yes" message="Please enter the destination city."></td></tr>
		<tr><td><font color=black><strong>Destination State &raquo:</strong></font></td><td><cfselect name="destinationstate"><option value="#dentinationState#">#DentinationState#</option><cfinclude template="../files/states.htm"></cfselect></td></tr>
		<tr><td><font color=black><strong>Destination Country</strong></font></td><td><cfinput type="text" name="destinationcountry" size="25" maxlength="250" value="USA" required="No" message=""></td></tr>
		<tr><td><font color=black><strong>Destination Zip Code &raquo</strong></font></td><td><cfinput type="text" name="destinationzip" size="25" maxlength="250" value="#dentinationZip#" required="Yes" message="Please enter the destination ZIP Code."></td></tr></font>
		<tr><td><font color=black><strong>Destination Phone (with Area Code) &raquo</strong></font></td><td><cfinput type="text" name="destinationphone" size="25" maxlength="250" value="#dentinationPhone#" required="Yes" message="Please enter the destination Phone."></font></td></tr>
		<tr><td><font color=black><strong>Status :</strong></font></td><td><select name="status">
		<option value="0" <cfif #status# is 0> selected</cfif>>Pending</option>
		<option value="1" <cfif #status# is 1> selected</cfif>>Active</option>
		</select></font></td></tr>
		
		</table>
			
		<!--- form buttons --->
		<INPUT type="submit" name="submit" value="Submit Changes">
		
		</cfFORM>
		</CFOUTPUT>
		</cfif>

		<cfif arguments.ReservationsAction is "List">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="Reservations">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>	
		<cfoutput><a href="adminheader.cfm?action=addReservations">Add a New Reservation</a><br></cfoutput>
			<cfif #TheFileExists# is "true">
				<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
					method="GetXMLRecords" returnvariable="AllReservations">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="Reservations">
					<cfinvokeargument name="orderByStatement" value=" order by datecreated desc">
				</cfinvoke>
			
				<table border="1" align="CENTER">
				<th colspan="8" align="CENTER" bgcolor="Maroon"><p>Your Reservations</th>
				<tr>
				<td><p>ID</p></td>
				<td><p>Customer</p></td>
				<td><p>Product</p></td>
				<td><p>Program</p></td>
				<td><p>Location</p></td>
				<td><p>Dates</p></td>
				<td><p>Status</p></td>
				<td><p>Actions</p></td>
				</tr>
				<cfoutput query="AllReservations">
				<cfquery name="product" dbtype="query">
					select productname from allproducts where productID='#productID#'
				</cfquery>
				<cfquery name="program" dbtype="query">
					select programname from allprograms where ProgramID='#programID#'
				</cfquery>
				<cfquery name="customer" dbtype="query">
					select firstname,lastname from allcustomers where resvCustID='#trim(resvCustID)#'
				</cfquery>
				<tr>
				<td align=center><p>#int(ReservationID)#</p></td>
				<td align=left><p>#customer.firstname# #customer.lastname#</p></td>
				<td><p>#product.productname#</p></td>
				<td align=right><p>#program.programname#</p></td>
				<td><p>#dentinationCity#</p></td>
				<td><p>#dateformat(datefrom,"mm/dd/yyyy")# to #dateformat(dateto,"mm/dd/yyyy")#</p></td>
				<td><p><cfif #status# is 1>Active<cfelse>Pending</cfif></p></td>
				<td><a href= "AdminHeader.cfm?ReservationID=#ReservationID#&ReservationsAction=Edit&action=Reservations">Edit</a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?ReservationID#ReservationID#&ReservationsAction=Delete&action=Reservations')">Delete</a></td>
				</tr>
				
				</cfoutput>
				</table>
			
			</cfif>
		
		</cfif>
		
	</cffunction>
	
	<cffunction name="ResvProductsAdmin" access="remote" returntype="string" output="true">
		<cfargument name="ProductsAction" type="string" required="true" default="List">
		<cfargument name="theformdata" type="string" required="false">
		<cfset ProductsAction=#arguments.ProductsAction#>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllResvProducts">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvProducts">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllLocations">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="locations">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		
		<cfparam name="ProductID" default=0>
		<cfparam name="ProductsAction" default="List">
		<cfparam name="availability" default="">
		<cfparam name="ProductDescription" default="">
		<cfparam name="DateToStart" default="#now()#">
		<cfparam name="Price" default="0">
		<cfparam name="DateToEnd" default="#dateadd('yyyy',10,now())#">
		<cfparam name="ProductName" default="">
		<cfparam name="ShowOnPage" default="0">
		
		
		<cfif ProductsAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvProducts">
				<cfinvokeargument name="XMLFields" value="ProductID,ProductDescription,availability,DateToStart,Price,DateToEnd,ProductName,ShowOnPage">
				<cfinvokeargument name="XMLIDField" value="ProductID">
				<cfinvokeargument name="XMLIDValue" value="#ProductID#">
			</cfinvoke>
			<cfset ProductID=0>
			<cfset ProductsAction="List">
		</cfif>
		
		<cfif ProductsAction is "update">
			<cfif not isdefined('form.ProductDescription')><cfset form.ProductDescription="none"></cfif>
			<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
			<cfif not isdate(#form.DateToEnd#)><cfset form.DateToEnd=dateadd("d",3650,#form.DateToStart#)></cfif>
			<cfif #form.availability# is ''><cfset form.availability="none"></cfif>
			<cfset form.availability = replace(#form.availability#,",","~","ALL")>
			<cfif #form.ProductDescription# is ''><cfset form.ProductDescription="none"></cfif>
			<cfset form.ProductName = replace(#form.ProductName#,",","~","ALL")>
			<cfif #form.Price# is ''><cfset form.Price="0.00"></cfif>
			<cfif ProductID gt 0>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="ResvProducts">
					<cfinvokeargument name="XMLFields" value="ProductDescription,availability,DateToStart,Price,DateToEnd,ProductName,ShowOnPage">
				<cfinvokeargument name="XMLFieldData" value="#form.ProductDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.ProductName#,#form.ShowOnPage#">
					<cfinvokeargument name="XMLIDField" value="ProductID">
					<cfinvokeargument name="XMLIDValue" value="#ProductID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="ResvProducts">
					<cfinvokeargument name="XMLFields" value="ProductDescription,availability,DateToStart,Price,DateToEnd,ProductName,ShowOnPage">
				<cfinvokeargument name="XMLFieldData" value="#form.ProductDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.ProductName#,#form.ShowOnPage#">
					<cfinvokeargument name="XMLIDField" value="ProductID">
				</cfinvoke>
			</cfif>
			<cfset ProductsAction="list">
			<cfset availability="">
			<cfset DateToStart ="#now()#">
			<cfset ProductID = 0>
			<cfset ProductDescription=''>
			<cfset Price='0'>
			<cfset DateToEnd="#dateadd('yyyy',10,now())#">
			<cfset ProductName="">
			<cfset ShowOnPage="0">
			<cfset TheFileExists="true">
		</cfif>
		
		<cfif ProductsAction is "edit">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="ResvProducts">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvProducts">
				<cfinvokeargument name="IDFieldName" value="ProductID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.theformdata#">
			</cfinvoke>HERE<BR>
			<cfoutput query="ResvProducts">
				<cfset availability=#availability#>
				<cfset DateToStart=#DateToStart#>
				<cfset ProductDescription=#ProductDescription#>
				<cfset Price=#Price#>
				<cfset DateToEnd=#DateToEnd#>
				<cfset ProductName=#ProductName#>
				<cfset ShowOnPage=#ShowOnPage#>
				<cfset availability = replace(#availability#,"~",",","ALL")>
				<cfset ProductDescription = replace(#ProductDescription#,"~",",","ALL")>
			</cfoutput>
			<cfset ProductsAction="update">
		</cfif>
		<cfif ProductsAction is "List"><cfset ProductsAction="update"></cfif>
		<cfoutput>
		<h1>Reservation Products</h1>
		<form name="thisform" action="AdminHeader.cfm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="ProductID" value="#ProductID#">
		<input type="hidden" name="ProductsAction" value="#ProductsAction#">
		<input type="hidden" name="Action" value="resvProducts">
		<TABLE>
			<TR>
			<TD valign="top"> Product Name:</TD>
			<TD>
			
				<INPUT type="text" name="ProductName" value="#ProductName#" maxLength="75">
				
			</TD>
			<!--- field validation --->
			</TR>
			<TR>
			<TD valign="top"> Description: </TD>
			<TD>
			
				<textarea name="ProductDescription" cols=40 rows=5>#ProductDescription#</textarea>
				
			</TD>
			<!--- field validation --->
			</TR>
		
			<TR>
			<TD valign="top"> Daily Rate: </TD>
			<TD>
			
				<INPUT type="text" name="Price" value="#Price#" maxLength="15">
				
			</TD>
			<!--- field validation --->
			</TR>
			<TR>
			<TD valign="top"> Weekly rate: </TD>
			<TD>
			<input type="text" name="ShowOnPage" value="#ShowOnPage#">
			</TD>
			<!--- field validation --->
			</TR>
			<TR>
			<TD valign="top"> Two Week Rate if Applicable (leave blank or zero if not applicable): </TD>
			<TD><input type="text" name="availability" value="#availability#">
				
			</TD>
			<!--- field validation --->
			</TR>

			<TR>
			<TD valign="top"> Date to Start This Product: </TD>
			<TD>
			<cf_intelliCalendar
				FieldName="DateToStart" 
				DateFormat="US" 
				Default="#dateformat(dateToSTart,'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
				(i.e. 12/31/97)
			</TD>
			</TR>
			
			
			<TR>
			<TD valign="top"> Date to End this Product: </TD>
			<TD>
			<cf_intelliCalendar
				FieldName="DateToEnd" 
				DateFormat="US" 
				Default="#dateformat(dateToEnd,'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
				(i.e. 12/31/97)
			</TD>
			</TR>
				
		</TABLE>
			
		<!--- form buttons --->
		<INPUT type="submit" name="submit" value="    OK    ">
		
		</FORM>
		</CFOUTPUT>
		
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="ResvProducts">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>	
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllResvProducts">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvProducts">
			</cfinvoke>
		
		<table border="1" align="CENTER">
		<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Reservation Products</th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Description</p></td>
		<td><p>One Day Cost</p></td>
		<td><p>One Week Cost</p></td>
		<td><p>Two Week Cost</p></td>
		<td><p>Actions</p></td>
		</tr>
		<cfoutput query="AllResvProducts">
		<tr>
		<td align=center><p>#int(ProductID)#</p></td>
		<td align=left><p>#ProductName#</p></td>
		<td><p>#ProductDescription#</p></td>
		<td align=right><p>#dollarformat(Price)#</p></td>
		<td align=right><p><cfif #isnumeric(ShowOnPage)#>#dollarformat(ShowOnPage)#<cfelse>0</cfif></p></td>
		<td align=right><p><cfif #isnumeric(availability)#>#dollarformat(availability)#<cfelse>0</cfif></p></td>
		<td><a href= "AdminHeader.cfm?ProductID=#ProductID#&ProductsAction=Edit&action=resvProducts">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?ProductID#ProductID#&ProductsAction=Delete&action=resvProducts')">Delete</a></td>
		</tr>
		
		</cfoutput>
		</table>
		
		</cfif>
	</cffunction>
	
	<cffunction name="ResvProgramsAdmin" access="remote" returntype="string" output="true">
		<cfargument name="ProgramAction" type="string" required="true" default="List">
		<cfargument name="theformdata" type="string" required="false">
		<cfset ProgramAction=#arguments.ProgramAction#>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllResvPrograms">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvPrograms">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllLocations">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="locations">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		
		<cfparam name="ProgramID" default=0>
		<cfparam name="ProgramAction" default="List">
		<cfparam name="availability" default="">
		<cfparam name="ProgramDescription" default="">
		<cfparam name="DateToStart" default="#now()#">
		<cfparam name="Price" default="0">
		<cfparam name="DateToEnd" default="#dateadd('yyyy',10,now())#">
		<cfparam name="ProgramName" default="">
		<cfparam name="ShowOnPage" default="homepage">
		
		
		<cfif ProgramAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvPrograms">
				<cfinvokeargument name="XMLFields" value="ProgramID,ProgramDescription,availability,DateToStart,Price,DateToEnd,ProgramName,ShowOnPage">
				<cfinvokeargument name="XMLIDField" value="ProgramID">
				<cfinvokeargument name="XMLIDValue" value="#ProgramID#">
			</cfinvoke>
			<cfset ProgramID=0>
			<cfset ProgramAction="List">
		</cfif>
		
		<cfif ProgramAction is "update">
			<cfif not isdefined('form.ProgramDescription')><cfset form.ProgramDescription="none"></cfif>
			<cfif not isdate(#form.DateToStart#)><cfset form.DateToStart=#dateformat(now(),"mm/dd/yyyy")#></cfif>
			<cfif not isdate(#form.DateToEnd#)><cfset form.DateToEnd=dateadd("d",3650,#form.DateToStart#)></cfif>
			<cfif #form.availability# is ''><cfset form.availability="none"></cfif>
			<cfset form.availability = replace(#form.availability#,",","~","ALL")>
			<cfif #form.ProgramDescription# is ''><cfset form.ProgramDescription="none"></cfif>
			<cfset form.ProgramName = replace(#form.ProgramName#,",","~","ALL")>
			<cfif #form.Price# is ''><cfset form.Price="0.00"></cfif>
			<cfif ProgramID gt 0>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="ResvPrograms">
					<cfinvokeargument name="XMLFields" value="ProgramDescription,availability,DateToStart,Price,DateToEnd,ProgramName,ShowOnPage">
				<cfinvokeargument name="XMLFieldData" value="#form.ProgramDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.ProgramName#,#form.ShowOnPage#">
					<cfinvokeargument name="XMLIDField" value="ProgramID">
					<cfinvokeargument name="XMLIDValue" value="#ProgramID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="ResvPrograms">
					<cfinvokeargument name="XMLFields" value="ProgramDescription,availability,DateToStart,Price,DateToEnd,ProgramName,ShowOnPage">
				<cfinvokeargument name="XMLFieldData" value="#form.ProgramDescription#,#form.availability#,#form.DateToStart#,#form.Price#,#form.DateToEnd#,#form.ProgramName#,#form.ShowOnPage#">
					<cfinvokeargument name="XMLIDField" value="ProgramID">
				</cfinvoke>
			</cfif>
			<cfset ProgramAction="list">
			<cfset availability="">
			<cfset DateToStart ="#now()#">
			<cfset ProgramID = 0>
			<cfset ProgramDescription=''>
			<cfset Price='0'>
			<cfset DateToEnd="#dateadd('yyyy',10,now())#">
			<cfset ProgramName="">
			<cfset ShowOnPage="homepage">
			<cfset TheFileExists="true">
		</cfif>
		
		<cfif ProgramAction is "edit">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="ResvPrograms">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvPrograms">
				<cfinvokeargument name="IDFieldName" value="ProgramID">
				<cfinvokeargument name="IDFieldValue" value="#ProgramID#">
			</cfinvoke>
			<cfoutput query="ResvPrograms">
				<cfset availability=#availability#>
				<cfset DateToStart=#DateToStart#>
				<cfset ProgramDescription=#ProgramDescription#>
				<cfset Price=#Price#>
				<cfset DateToEnd=#DateToEnd#>
				<cfset ProgramName=#ProgramName#>
				<cfset ShowOnPage=#ShowOnPage#>
				<cfset availability = replace(#availability#,"~",",","ALL")>
				<cfset ProgramDescription = replace(#ProgramDescription#,"~",",","ALL")>
			</cfoutput>
			<cfset ProgramAction="update">
		</cfif>
		<cfif ProgramAction is "List"><cfset ProgramAction="update"></cfif>
		<cfoutput>
		<h1>Reservation Programs</h1>
		<form name="thisform" action="AdminHeader.cfm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="ProgramID" value="#ProgramID#">
		<input type="hidden" name="ProgramAction" value="#ProgramAction#">
		<input type="hidden" name="Action" value="resvPrograms">
		<TABLE>
			<TR>
			<TD valign="top"> Program Name:</TD>
			<TD>
			
				<INPUT type="text" name="ProgramName" value="#ProgramName#" maxLength="75">
				
			</TD>
			<!--- field validation --->
			</TR>
			<TR>
			<TD valign="top"> Description: </TD>
			<TD>
			
				<textarea name="ProgramDescription" cols=40 rows=5>#ProgramDescription#</textarea>
				
			</TD>
			<!--- field validation --->
			</TR>
		
			<TR>
			<TD valign="top"> Default Program Price: </TD>
			<TD>
			
				<INPUT type="text" name="Price" value="#Price#" maxLength="15">
				
			</TD>
			<!--- field validation --->
			</TR>
			
			<TR>
			<TD valign="top"> Locations Program Applies to: </TD>
			<TD>
			<select name="Availability" multiple="true">
				<cfloop query="AllLocations">
					<option value="#LocationID#"<cfif #Availability# is #LocationID#> selected</cfif>>#companyname#</option>
				</cfloop>
			</select>
				
			</TD>
			<!--- field validation --->
			</TR>
			
			<TR>
			<TD valign="top"> Page to show this program on: </TD>
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
			<TD valign="top"> Date to Start This Program: </TD>
			<TD>
			<cf_intelliCalendar
				FieldName="DateToStart" 
				DateFormat="US" 
				Default="#dateformat(dateToSTart,'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
				(i.e. 12/31/97)
			</TD>
			</TR>
			
			
			<TR>
			<TD valign="top"> Date to End this Program: </TD>
			<TD>
			<cf_intelliCalendar
				FieldName="DateToEnd" 
				DateFormat="US" 
				Default="#dateformat(dateToEnd,'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
				(i.e. 12/31/97)
			</TD>
			</TR>
				
		</TABLE>
			
		<!--- form buttons --->
		<INPUT type="submit" name="submit" value="    OK    ">
		
		</FORM>
		</CFOUTPUT>
		
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="ResvPrograms">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>	
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllResvPrograms">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="ResvPrograms">
			</cfinvoke>
		
		<table border="1" align="CENTER">
		<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Reservation Programs</th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Description</p></td>
		<td><p>Price</p></td>
		<td><p>Actions</p></td>
		</tr>
		<cfoutput query="AllResvPrograms">
		<tr>
		<td align=center><p>#int(ProgramID)#</p></td>
		<td align=left><p>#ProgramName#</p></td>
		<td><p>#ProgramDescription#</p></td>
		<td align=right><p>#dollarformat(Price)#</p></td>
		<td><a href= "AdminHeader.cfm?ProgramID=#ProgramID#&ProgramAction=Edit&action=resvPrograms">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('AdminHeader.cfm?ProgramID#ProgramID#&ProgramAction=Delete&action=resvPrograms')">Delete</a></td>
		</tr>
		
		</cfoutput>
		</table>
		
		</cfif>
	</cffunction>
	
	<cffunction name="locationsAdmin" access="remote" returntype="string" output="true">
		<cfargument name="LocationAction" type="string" required="true" default="List">
		<cfargument name="theformdata" type="string" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="locations">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Alllocations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
			</cfinvoke>
		</cfif>
		
		<cfparam name="LocationID" default=0>
		<cfparam name="LocationTypeID" default=0>
		<cfset LocationAction=#arguments.LocationAction#>
		<cfparam name="Active" default="">
		<cfparam name="LocationDescription" default="">
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
		<cfparam name="username" default="">
		<cfparam name="password" default="">

		<cfif #lcase(LocationAction)# is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
				<cfinvokeargument name="XMLFields" value="LocationID,ACTIVE,BANNED,DATESTARTED,LocationTypeID,LocationDescription,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,username,password">
				<cfinvokeargument name="XMLIDField" value="LocationID">
				<cfinvokeargument name="XMLIDValue" value="#trim(url.locationid)#">
			</cfinvoke>
			<cfset LocationID=0>
			<cfset LocationAction="List">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Alllocations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
			</cfinvoke>
		</cfif>

		<cfif LocationAction is "update">
			<cfset form.LocationID=ListGetAt(#arguments.theformdata#,1)>
			<cfset form.LOCATIONACTION=ListGetAt(#arguments.theformdata#,2)>
			<cfset form.ACTION=ListGetAt(#arguments.theformdata#,3)>
			<cfset form.BANNED=ListGetAt(#arguments.theformdata#,4)>
			<cfset form.Firstname=ListGetAt(#arguments.theformdata#,5)>
			<cfset form.LastName=ListGetAt(#arguments.theformdata#,6)>
			<cfset form.companyname=ListGetAt(#arguments.theformdata#,7)>
			<cfset form.address=ListGetAt(#arguments.theformdata#,8)>
			<cfset form.address2=ListGetAt(#arguments.theformdata#,9)>
			<cfset form.city=ListGetAt(#arguments.theformdata#,10)>
			<cfset form.state=ListGetAt(#arguments.theformdata#,11)>
			<cfset form.zip=ListGetAt(#arguments.theformdata#,12)>
			<cfset form.country=ListGetAt(#arguments.theformdata#,13)>
			<cfset form.username=ListGetAt(#arguments.theformdata#,14)>
			<cfset form.password=ListGetAt(#arguments.theformdata#,15)>
			<cfset form.phone=ListGetAt(#arguments.theformdata#,16)>
			<cfset form.officephone=ListGetAt(#arguments.theformdata#,17)>
			<cfset form.cellphone=ListGetAt(#arguments.theformdata#,18)>
			<cfset form.faxphone=ListGetAt(#arguments.theformdata#,19)>
			<cfset form.email=ListGetAt(#arguments.theformdata#,20)>
			<cfset form.Active=ListGetAt(#arguments.theformdata#,21)>
			<cfset form.DATESTARTED=ListGetAt(#arguments.theformdata#,22)>
			<cfset form.LocationDescription=ListGetAt(#arguments.theformdata#,23)>
			<cfset form.LocationTypeID=ListGetAt(#arguments.theformdata#,24)>
			<cfset form.REFERREDBY=ListGetAt(#arguments.theformdata#,25)>
			<cfset form.UNIQUEIDENTIFYER=ListGetAt(#arguments.theformdata#,26)>
			
			<cfif not isdate(#form.DATESTARTED#)><cfset form.DATESTARTED=#dateformat(now(),"yyyy/mm/dd")#></cfif>
			<cfif #form.Active# is ''><cfset form.Active="0"></cfif>
			<cfset form.LocationDescription = replace(#form.LocationDescription#,",","~","ALL")>
			<cfset UUID = #left(form.firstname,2)# & #left(form.lastname,2)# & #left(form.username,2)# & day(now()) & month(now()) & year(now())>
			<cfif form.LocationID gt 0>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="locations">
					<cfinvokeargument name="XMLFields" value="ACTIVE,BANNED,DATESTARTED,LocationTypeID,LocationDescription,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,username,password">
					<cfinvokeargument name="XMLFieldData" value="#form.active#,#Form.banned#,#dateformat(form.datestarted,'yyyy/mm/dd')#,#form.LocationTypeID#,#form.LocationDescription# ,#form.Firstname# ,#Form.ReferredBy# ,#UUID# ,#Form.LastName# ,#Form.address# ,#Form.address2# ,#Form.city# ,#Form.state# ,#Form.zip# ,#Form.country# ,#Form.phone# ,#Form.officephone# ,#Form.cellphone# ,#Form.faxphone# ,#Form.email# ,#Form.companyname# ,#Form.username# ,#Form.password# ">
					<cfinvokeargument name="XMLIDField" value="LocationID">
					<cfinvokeargument name="XMLIDValue" value="#form.LocationID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
					method="InsertXMLRecord" returnvariable="NewLocationID">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="locations">
					<cfinvokeargument name="XMLFields" value="ACTIVE,BANNED,DATESTARTED,LocationTypeID,LocationDescription,Firstname,REFERREDBY,UNIQUEIDENTIFYER,LastName,address,address2,city,state,zip,country,phone,officephone,cellphone,faxphone,email,companyname,username,password">
					<cfinvokeargument name="XMLFieldData" value="#form.active#,#Form.banned#,#dateformat(form.datestarted,'yyyy/mm/dd')#,#form.LocationTypeID#,#form.LocationDescription# ,#form.Firstname# ,#Form.ReferredBy# ,#UUID# ,#Form.LastName# ,#Form.address# ,#Form.address2# ,#Form.city# ,#Form.state# ,#Form.zip# ,#Form.country# ,#Form.phone# ,#Form.officephone# ,#Form.cellphone# ,#Form.faxphone# ,#Form.email# ,#Form.companyname# ,#Form.username# ,#Form.password# ">
					<cfinvokeargument name="XMLIDField" value="LocationID">
				</cfinvoke>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="LocationReservations">
					<cfinvokeargument name="XMLFields" value="CATEGORYID,COMMISSIONSDUE,COMMISSIONSYTD,LocationID,DISPUTEDAMT,IMPRESSIONSUSED,LASTCHECKNO,LASTPAIDAMT,NOOFTIMESORDERED,NextPayDate,Impressions">
					<cfinvokeargument name="XMLFieldData" value="#form.LocationTypeID#,0,0,#NewLocationID#,0,0,0,0,0,0,0">
					<cfinvokeargument name="XMLIDField" value="reservationID">
				</cfinvoke>
			</cfif>
			<cfset LocationAction="list">
			<cfset Active="">
			<cfset DATESTARTED = #now()#>
			<cfset LocationTypeID = 0>
			<cfset LocationDescription=''>
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
			<cfset Username=''>
			<cfset password=''>
			<cfset TheFileExists="true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Alllocations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
			</cfinvoke>
		</cfif>
		
		<cfif LocationAction is "edit">
			<cfparam name="LocationID" default="0">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="locations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
				<cfinvokeargument name="IDFieldName" value="LocationID">
				<cfinvokeargument name="IDFieldValue" value="#LocationID#">
			</cfinvoke>
			<cfoutput query="locations">
				<cfset Active=#Active#>
				<cfset DATESTARTED=#DATESTARTED#>
				<cfset LocationDescription=#LocationDescription#>
				<cfset UNIQUEIDENTIFYER=#UNIQUEIDENTIFYER#>
				<cfset BANNED=#BANNED#>
				<cfset REFERREDBY=#REFERREDBY#>
				<cfset Firstname=#Firstname#>
				<cfset LastName=#LastName#>
				<cfset address=#address#>
				<cfset Locationtypeid=#locationTypeid#>
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
			</cfoutput>
			<cfset LocationAction="update">
		</cfif>
		
		<cfoutput>
		<h1>Reservations Locations</h1>
		
		<cfif LocationAction is "Add" or LocationAction is "update">
		<cfform action="adminheader.cfm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="LocationID" value="#LocationID#">
		<cfif #LocationAction# is "all">
		<input type="hidden" name="LocationAction" value="edit">
		<cfelse>
		<input type="hidden" name="LocationAction" value="update">
		</cfif>
		<input type="hidden" name="Action" value="#Action#">
		<input type="hidden" name="banned" value="#banned#">
		<table width="100%" cellspacing="0" cellpadding="0" align="CENTER">
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
				 <td><input type="text" name="username" value="#username#" size=15></td>
		</tr>
		<tr>
				<td>Password </td>
				 <td><input type="Password" name="Password" value="#Password#" size=15></td>
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
				 <td><input type="text" name="email" value="#email#" size=35></td>
		</tr>
			<tr>
				<td>Status </td>
				 <td>Active<input type="Radio" name="Active" value="1" <cfif #Active# is 1>checked</cfif>><br>
				 Pending<input type="Radio" name="Active" value=0 <cfif #Active# is 0>checked</cfif>></td>
		</tr>
		
		<tr>
				<td>Date Started </td>
				 <td><input type="text" name="datestarted" value="#dateformat(datestarted,"mm/dd/yyyy")#" size=25></td>
		</tr>
			<tr>
				<td>Brief Description of this location: </td>
				<td><textarea cols=35 rows=5 name="locationDescription">#LocationDescription#</textarea></option>
				</select>
				</td>
		</tr>
		<tr>
			<td>
				<font face="Arial" size="2">Map Location:</font></td>
			<td><select name="LocationTypeID">
				<option value="#locationtypeid#">#locationtypeid#</option>
				<cfinclude template="../files/states.htm">
			</select></td>
		</tr>
		
			<tr>
				<td>Referring Affiliate</td>
				 <td><select name="ReferredBy">
					<option value="0">None</option>
					<cfif isdefined('Alllocations')>
					<cfloop query="Alllocations">
						<option value="#Alllocations.LocationID#"<cfif #ReferredBy# is #Alllocations.LocationID#> selected</cfif>>#Trim(Alllocations.firstname)# #Trim(Alllocations.Lastname)#</option>
					</cfloop></cfif>
				</select></td>
			</tr>
			<input type="hidden" name="UUID" value="#uniqueidentifyer#">
			<cfif #LocationID# gt 0>	
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
		</cfform>
		</cfif>
		</cfoutput>
		<cfif LocationAction is "list">
		<cfoutput><a href="adminheader.cfm?Action=#Action#&LocationAction=Add">Add A Location</a></cfoutput><br>
		<cfif #TheFileExists#>
		
		<table border="1" align="CENTER">
		<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Reservation Locations</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Company name</p></td>
		<td><p>Contact name</p></td>
		<td><p>Start Date</p></td>
		<td><p>Status</p></td>
		<td><p>Map Location</p></td>
		<td><p>Actions</p></td>
		</tr>
		<cfoutput query="Alllocations">
		<tr>
		<td><p>#int(LocationID)#</p></td>
		<td><p>#companyname#</p></td>
		<td><p>#firstname# #lastname#</p></td>
		<td><p>#dateformat(datestarted,"mm/dd/yyyy")#</p></td>
		<td><p><cfif #active#>Active<cfelse>Not Active</cfif></p></td>
		<td><p>#LocationTypeID#</p></td>
		<td><a href= "adminheader.cfm?LocationID=#LocationID#&LocationAction=Edit&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?LocationID=#LocationID#&LocationAction=Delete&action=#action#')">Delete</a>
						<!--- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?LocationID=#LocationID#&action=locationProducts">Products Offered & Pricing</a>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?LocationID=#LocationID#&action=reservationsMade">Reservations Made</a> ---></td>
		</tr>
		</cfoutput>
		</table>
		</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="reservationConfig" access="remote" returntype="string" output="true">
		<cfargument name="ConfigAction" required="true" default="no">
		<cfargument name="theformdata" type="string" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="resvConfig">
				<cfinvokeargument name="ThisPath" value="utilities">
		</cfinvoke>
		
		<cfparam name="EmailFrom" default='#application.email#'>
		<cfparam name="ThankYouPage" default='homepage'>
		<cfparam name="CheckOutPage" default='homepage'>
		<cfparam name="CustomerHomePage" default='homepage'>
		<cfparam name="CustomerLoginPage" default='homepage'>
		<cfparam name="SearchPage" default='homepage'>
		<cfparam name="SearchResultsPage" default='homepage'>
		<cfparam name="RegistrationPage" default='homepage'>
		<cfparam name="CustomerWelcome" default=' '>
		<cfparam name="Disclaimer" default='  '>
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="resvConfig">
				<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
				<cfinvokeargument name="ThisFileName" value="resvConfig">
				<cfinvokeargument name="IDFieldName" value="configID">
				<cfinvokeargument name="IDFieldValue" value="0000000001">
			</cfinvoke>
			<cfoutput query="resvConfig">
				<cfset EmailFrom='#EmailFrom#'>
				<cfset ThankYouPage='#trim(ThankYouPage)#'>
				<cfset CheckOutPage='#trim(CheckOutPage)#'>
				<cfset CustomerHomePage='#trim(CustomerHomePage)#'>
				<cfset CustomerLoginPage='#trim(CustomerLoginPage)#'>
				<cfset SearchPage='#trim(SearchPage)#'>
				<cfset SearchResultsPage='#trim(SearchResultsPage)#'>
				<cfset RegistrationPage='#trim(RegistrationPage)#'>
				<cfset CustomerWelcome='#replace(CustomerWelcome,"~",",","ALL")#'>
				<cfset Disclaimer='#replace(Disclaimer,"~",",","ALL")#'>
			</cfoutput>
		</cfif>
		
		<cfif #arguments.ConfigAction# is "YES">
			<cfset ConfigID="0000000001">

			<cfif #TheFileExists# is "true">
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
					<cfinvokeargument name="ThisFileName" value="resvConfig">
					<cfinvokeargument name="XMLFields" value="EmailFrom,ThankYouPage,CheckOutPage,CustomerHomePage,CustomerLoginPage,SearchPage,SearchResultsPage,RegistrationPage,CustomerWelcome,Disclaimer">
					<cfinvokeargument name="XMLFieldData" value="#form.EmailFrom#,#form.ThankYouPage#,#form.CheckOutPage#,#form.CustomerHomePage#,#form.CustomerLoginPage#,#form.SearchPage#,#form.SearchResultsPage#,#form.RegistrationPage#,#form.CustomerWelcome#,#form.Disclaimer#">
					<cfinvokeargument name="XMLIDField" value="configID">
					<cfinvokeargument name="XMLIDValue" value="0000000001">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
					<cfinvokeargument name="ThisFileName" value="resvConfig">
					<cfinvokeargument name="XMLFields" value="EmailFrom,ThankYouPage,CheckOutPage,CustomerHomePage,CustomerLoginPage,SearchPage,SearchResultsPage,RegistrationPage,CustomerWelcome,Disclaimer">
					<cfinvokeargument name="XMLFieldData" value="#form.EmailFrom#,#form.ThankYouPage#,#form.CheckOutPage#,#form.CustomerHomePage#,#form.CustomerLoginPage#,#form.SearchPage#,#form.SearchResultsPage#,#form.RegistrationPage#,#form.CustomerWelcome#,#form.Disclaimer#">
					<cfinvokeargument name="XMLIDField" value="configID">
				</cfinvoke>
			</cfif>
			<cflocation url="adminheader.cfm?action=resvConfig&ConfigAction=NO">
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="pages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
		<h1>Reservations Configuration</h1>
		<cfoutput>

		<form action="adminheader.cfm" enctype="multipart/form-data" method="post" name="thisform">
		  <input type="hidden" name="configAction" value="YES">
		  <input type="hidden" name="Action" value="#Action#">
		  <div align="center"><center>
		  <table>
			<tr>
			  <td>Enter the email address all reservation mail will be sent from:</td>
			  <td><input type="text" name="emailfrom" value="#trim(EmailFrom)#"></td>
				<tr>
			<td>Reservation Customer Home Page<br>
			  <td><select name="CustomerHomePage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #CustomerHomePage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			</tr>
			</tr><tr>
			  <td>Check out page</td>
			  <td><select name="CheckOutPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #CheckOutPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr><tr>
		<td>Thank You Page<br></td>
			  <td><select name="ThankYouPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #ThankYouPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
			</tr>
			<tr>
			<td>Customer Login Page</td>
		<td><select name="CustomerLoginPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #CustomerLoginPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Registration Page</td>
		<td><select name="RegistrationPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #RegistrationPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Products & Programs Search Page</td>
		<td><select name="SearchPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #SearchPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Search Results Page</td>
		<td><select name="SearchResultsPage">
			  	<cfloop query="pages">
					<option value="#PageName#"<cfif #SearchResultsPage# is #PageName#> selected</cfif>>#PageName#</option>
				</cfloop>
			  </select>
			  </td>
				  
			</tr>
			<tr>
			<td>Customer Welcome</td>
		<td><a href="javascript:GetEditor('thisform','CustomerWelcome')"  class=box>Click here for the editor</a><br><textarea name="CustomerWelcome" cols=40 rows=7>#CustomerWelcome#</textarea>
			  </td>
				  
			</tr>
			<tr>
			<td>Disclaimer</td>
		<td><a href="javascript:GetEditor('thisform','Disclaimer')"  class=box>Click here for the editor</a><br><textarea name="Disclaimer" cols=40 rows=7>#disclaimer#</textarea>
			  </td>
				  
			</tr>
			
			<tr>
			  <td><div align="center"><center><p><input type="submit" name="submit" value="Apply">
			  </td>
			  <td></td>
			</tr>
		  </table>
		  </center></div>
		</form>
		
		</cfoutput>
		
		<cfreturn ConfigAction>
	</cffunction>
	
	<cffunction name="GetResvCustPhone" access="remote" returntype="query" output="true">
		<cfargument name="ResvCustID" type="numeric" default="0" required="true">
		<cfargument name="PhoneTypeID" type="numeric" default="0" required="false">
		
		<cfif #Arguments.PhoneTypeID# neq 0>
			<cfset WhereStatement="Where PhoneTypeID=#Arguments.PhoneTypeID#">
		</cfif>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Phone">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustphone">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#ResvCustID#">
		</cfinvoke>
		<cfquery name="ResvCustPhone" dbtype="query">
			select * from Phone <Cfif #arguments.phoneTypeID# neq "false">where PhoneTypeID='#Arguments.PhoneTypeID#'</Cfif>
		</cfquery>
		<cfreturn ResvCustPhone>
		
	</cffunction>
	
	<cffunction name="GetResvCust" access="remote" output="true" returntype="query">
		<cfargument name="ResvCustID" default="0" type="numeric" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ResvCust">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCusts">
			<cfinvokeargument name="IDFieldName" value="ResvCustID">
			<cfinvokeargument name="IDFieldVAlue" value="#ResvCustID#">
		</cfinvoke>

		<cfreturn ResvCust>
	</cffunction>
	
	
	<cffunction name="GetResvCustAddress" access="remote" output="true" returntype="query">
		<cfargument name="ResvCustID" default="0" type="numeric" required="true">
		<cfargument name="AddressTypeID" default="0" type="numeric" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ResvCustAddress">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFilename" value="ResvCustAddress">
			<cfinvokeargument name="IDFieldName" value="ConnectID">
			<cfinvokeargument name="IDFieldName" value="#Arguments.ResvCustID#">
		</cfinvoke>
		<cfif #ResvCustAddress.RecordCount# gt 0>
		<cfquery name="tResvCustAddress" dbtype="query">
			select * from ResvCustAddress 
			<cfif #Arguments.addresstypeid# gt 0>where addresstypeid='#arguments.addresstypeid#'</cfif>
		</cfquery>
		<cfelse>
			<cfset tResvCustAddress=querynew("addressid,Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,TableID,Country")>
		</cfif>
		<cfreturn tResvCustAddress>
	</cffunction>
	
	<cffunction name="GetResvCustEmail" access="remote" output="true" returntype="query">
		<cfargument name="ResvCustID" default="0" type="string" required="true">
		<cfargument name="EMAILTYPEID" default="0" type="string" required="false">
			
		<cfif #Arguments.EMAILTYPEID# neq 0>
			<cfset WhereStatement="where EMAILTYPEID='#Arguments.EMAILTYPEID#'">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Email">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustemail">
			<cfinvokeargument name="IDFieldName" value="connectid">
			<cfinvokeargument name="IDFieldVAlue" value="#ResvCustID#">
		</cfinvoke>
		<cfquery name="ResvCustEmail" dbtype="query">
			select * from Email 
		</cfquery>
		<cfreturn ResvCustEmail>
	</cffunction>
	
	
	<cffunction name="AddAddress" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="AddressTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="Address1" type="string" required="true" default="">
		<cfargument name="Address2" type="string" required="true" default="">
		<cfargument name="City" type="string" required="true" default="">
		<cfargument name="State" type="string" required="true"default="">
		<cfargument name="PostalCode" type="string" required="true" default="">
		<cfargument name="Country" type="string" required="true" default="">
		
		<cfset Address1=#XMLFormat(arguments.Address1)#>
		<cfset Address2=#XMLFormat(arguments.Address2)#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City=#XMLFormat(arguments.City)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode=#XMLFormat(arguments.PostalCode)#>
		<cfset State=#XMLFormat(arguments.State)#>
		<cfset Country=#XMLFormat(arguments.Country)#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustaddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="addressid">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdateAddress" access="remote" output="false">
		<cfargument name="AddressID" type="numeric" required="true" default=0>
		<cfargument name="AddressTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="TableID" type="numeric" required="true" default=0>
		<cfargument name="Address1" type="string" required="true" default="">
		<cfargument name="Address2" type="string" required="true" default="">
		<cfargument name="City" type="string" required="true" default="">
		<cfargument name="State" type="string" required="true"default="">
		<cfargument name="PostalCode" type="string" required="true" default="">
		<cfargument name="Country" type="string" required="true" default="">
		
		<cfset Address1=#XMLFormat(arguments.Address1)#>
		<cfset Address2=#XMLFormat(arguments.Address2)#>
		<cfif Address2 is ''><cfset Address2="none"></cfif>
		<cfset AddressTypeID=#XMLFormat(arguments.AddressTypeID)#>
		<cfset City=#XMLFormat(arguments.City)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PostalCode=#XMLFormat(arguments.PostalCode)#>
		<cfset State=#XMLFormat(arguments.State)#>
		<cfset Country=#XMLFormat(arguments.Country)#>
		<CFSET FieldList = "Address1,Address2,AddressTypeID,City,ConnectID,PostalCode,State,Country">
		<CFSET FieldValues = "#Address1#,#Address2#,#AddressTypeID#,#City#,#ConnectID#,#PostalCode#,#State#,#Country#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustaddress">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="addressid">
			<cfinvokeargument name="XMLIDValue" value="#addressid#">
		</cfinvoke>

	</cffunction>

	<cffunction name="UpdateEmail" access="remote" output="false">
		<cfargument name="EmailID" type="numeric" required="true" default=0>
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailID=#XMLFormat(arguments.EmailID)#>
		<cfset EmailTypeID=#XMLFormat(arguments.EmailTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset EmailAddress=#XMLFormat(arguments.EmailAddress)#>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustemail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="emailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="AddEmail" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="EmailTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="EmailAddress" type="string" required="true" default="">
		
		<cfset EmailTypeID=#XMLFormat(arguments.EmailTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset EmailAddress=#XMLFormat(arguments.EmailAddress)#>
		
		<CFSET FieldList = "EmailTypeID,ConnectID,EmailAddress">
		<CFSET FieldValues = "#EmailTypeID#,#ConnectID#,#EmailAddress#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newid">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustemail">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="'#FieldValues#'">
			<cfinvokeargument name="XMLIDField" value="emailID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="AddPhone" access="remote" returntyhpe="numeric" output="true">
		<cfargument name="PhoneTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#XMLFormat(arguments.PhoneTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PhoneNumber=#XMLFormat(arguments.PhoneNumber)#>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
		</cfinvoke>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="UpdatePhone" access="remote" output="false">
		<cfargument name="PhoneID" type="numeric" required="true" default=0>
		<cfargument name="PhoneTypeID" type="numeric" required="true" default=0>
		<cfargument name="ConnectID" type="numeric" required="true" default=0>
		<cfargument name="PhoneNumber" type="string" required="true" default="">
		
		<cfset PhoneTypeID=#XMLFormat(arguments.PhoneTypeID)#>
		<cfset ConnectID=#XMLFormat(arguments.ConnectID)#>
		<cfset PhoneNumber=#XMLFormat(arguments.PhoneNumber)#>
		
		<CFSET FieldList = "PhoneTypeID,ConnectID,PhoneNumber">
		<CFSET FieldValues = "#PhoneTypeID#,#ConnectID#,#PhoneNumber#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="updateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCustphone">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="PHoneID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.PHoneID#">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="AddResvCust" access="remote" returntype="numeric" output="true">
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="">
		<cfargument name="CCExpire" type="string" required="true" default="">
		<cfargument name="CCNo" type="string" required="true" default="">
		<cfargument name="CCType" type="string" required="true"default="">
		<cfargument name="OnMailList" type="numeric" required="true"default="">
		<cfargument name="StartDate" type="date" required="true" default="">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="">
		<cfargument name="Password" type="string" required="true" default="">
		<cfargument name="AffiliateID" type="numeric" required="true" default="">
		<cfargument name="Title" type="string" required="true" default="0">
		<cfargument name="height" type="string" required="true" default="0">
		<cfargument name="weight" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<cfset OnMailList=#XMLFormat(arguments.OnMailList)#>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset AffiliateID=#XMLFormat(arguments.AffiliateID)#>
		<cfset title="#XMLFormat(arguments.title)# ">
		<cfset height="#XMLFormat(arguments.height)# ">
		<cfset weight="#XMLFormat(arguments.weight)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,title,height,weight">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType#,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#title#,#height#,#weight#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="newID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCusts">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="ResvCustID">
		</cfinvoke>
		
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="UpdateResvCust" access="remote" output="true">
		<cfargument name="ResvCustID" type="numeric" required="true" default=0>
		<cfargument name="Active" type="numeric" required="true" default=0>
		<cfargument name="CardName" type="string" required="true" default="0">
		<cfargument name="CCExpire" type="string" required="true" default="0">
		<cfargument name="CCNo" type="string" required="true" default="0">
		<cfargument name="CCType" type="string" required="true"default="0">
		<cfargument name="OnMailList" type="string" required="true"default="0">
		<cfargument name="StartDate" type="date" required="true" default="0">
		<cfargument name="firstname" type="string" required="true" default=0>
		<cfargument name="lastname" type="string" required="true" default=0>
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="Password" type="string" required="true" default="0">
		<cfargument name="AffiliateID" type="string" required="true" default="0">
		<cfargument name="title" type="string" required="true" default="0">
		<cfargument name="height" type="string" required="true" default="0">
		<cfargument name="weight" type="string" required="true" default="0">
		
		<cfset CardName="#XMLFormat(arguments.CardName)# ">
		<cfset CCExpire="#XMLFormat(arguments.CCExpire)# ">
		<cfset CCNo="#XMLFormat(arguments.CCNo)# ">
		<cfset CCType="#XMLFormat(arguments.CCType)# ">
		<cfset firstname="#XMLFormat(arguments.firstname)# ">
		<cfset username="#XMLFormat(arguments.username)# ">
		<cfset password="#XMLFormat(arguments.password)# ">
		<cfset active=#XMLFormat(arguments.active)#>
		<cfset OnMailList=#XMLFormat(arguments.OnMailList)#>
		<cfset startdate="#XMLFormat(arguments.startdate)# ">
		<cfset AffiliateID=#XMLFormat(arguments.AffiliateID)#>
		<cfset title="#XMLFormat(arguments.title)# ">
		<cfset height="#XMLFormat(arguments.height)# ">
		<cfset weight="#XMLFormat(arguments.weight)# ">
		
		<CFSET FieldList = "CardName,Active,CCExpire,CCNo,CCType,OnMailList,StartDate,firstname,lastname,username,password,AffiliateID,title,height,weight">
		<CFSET FieldValues = "#CardName#,#active#,#CCExpire#,#CCNo#,#CCType# ,#OnMailList#,#startdate#,#firstname#,#lastname#,#username#,#password#,#AffiliateID#,#title#,#height#,#weight#">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCusts">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="ResvCustID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.ResvCustID#">
		</cfinvoke>
		<cfreturn #arguments.ResvCustID#>
	</cffunction>
	
	<cffunction name="CheckLogin" access="remote" output="true" returntype="boolean">
		<cfargument name="Username" default=" " type="string" required="true">
		<cfargument name="Password" default=" " type="string" required="false">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ResvCust">
			<cfinvokeargument name="ThisFileName" value="ResvCusts">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="IDFieldName" value="username">
			<cfinvokeargument name="IDFieldValue" value="#arguments.username#">
		</cfinvoke>
		
		<cfset tResvCust=0>
		<cfif #ResvCust.RecordCount# gt 0>
			<cfquery name="CheckPassword" dbtype="query">
				select * from ResvCust where password='#arguments.password#'
			</cfquery>
			<cfif #CheckPassword.RecordCount# gt 0>
				<cfif #CheckPassword.Active# gt 0>
					<cfset tResvCust=1>
				</cfif>
			</cfif>
		</cfif>
		<cfreturn tResvCust>
	</cffunction>
	
	<cffunction name="GetResvCustByPassword" access="remote" output="true" returntype="query">
		<cfargument name="PWord" default="0" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="ResvCust">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvCusts">
			<cfinvokeargument name="IDFieldName" value="password">
			<cfinvokeargument name="IDFieldVAlue" value="#PWord#">
		</cfinvoke>

		<cfreturn ResvCust>
	</cffunction>
	
	<cffunction name="ReservationRegistration" access="remote" returntype="string" output="true">
		<cfargument name="registrationAction" type="string" required="true" default="List">
		<cfargument name="theformdata" type="string" required="false">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="reservations">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Allreservations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="reservations">
			</cfinvoke>
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="resvConfig">
			<cfinvokeargument name="ThisPath" value="#application.UtilitiesPath#">
			<cfinvokeargument name="ThisFileName" value="resvConfig">
			<cfinvokeargument name="IDFieldName" value="configID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
			
		<cfparam name="ReservationID" default=0>
		<cfparam name="ProductID" default=0> <!--- Product --->
		<cfset registrationAction=#arguments.registrationAction#>
		<cfparam name="Active" default="">
		<cfparam name="SpecialNeeds" default="">
		<cfparam name="DATESTARTED" default="#now()#">
		<cfparam name="DateFrom" default="">
		<cfparam name="DateTo" default="0">
		<cfparam name="Contacttime" default="Morning">
		<cfparam name="ResvCustID" default="">
		<cfparam name="ProgramID" default="">
		<cfparam name="destiontionAddress" default="">
		<cfparam name="rentalPeriod" default="">
		<cfparam name="destinationcity" default="">
		<cfparam name="destinationstate" default="">
		<cfparam name="destinationzip" default="">
		<cfparam name="destinationcountry" default="">
		<cfparam name="destinationphone" default="">
		<cfparam name="LocationID" default="">

		<cfif registrationAction is "update">
	
			<cfset form.DATEcreated=#dateformat(now(),"yyyy/mm/dd")#>
			<cfset form.Active="0">
			<cfset form.specialneeds = replace(#form.specialneeds#,",","~","ALL")>
			<cfset form.productID=replace(#form.ProductID#,",","~","ALL")>
			
			<cfinvoke method="AddResvCust" returnvariable="ResvCustID">
				<cfinvokeargument name="Active" value="1">
				<cfinvokeargument name="CardName" value="#Form.firstname# #form.lastname#">
				<cfinvokeargument name="CCExpire" value=" ">
				<cfinvokeargument name="CCNo" value=" ">
				<cfinvokeargument name="CCType" value=" ">
				<cfinvokeargument name="OnMailList" value="1">
				<cfinvokeargument name="StartDate" value="#dateformat(datestarted,'yyyy/mm/dd')#">
				<cfinvokeargument name="firstname" value="#Form.firstname#">
				<cfinvokeargument name="lastname" value="#form.lastname#">
				<cfinvokeargument name="username" value="#Form.email#">
				<cfinvokeargument name="Password" value="#Form.email#">
				<cfinvokeargument name="AffiliateID" value="0">
				<cfinvokeargument name="Title" value="#form.Title#">
				<cfinvokeargument name="Height" value="#form.Height#">
				<cfinvokeargument name="Weight" value="#form.Weight#">
			</cfinvoke>
			<cfset session.ResvCustID=#ResvCustID#>

			<cfinvoke method="AddAddress" returnvariable="BillingAddressID">
				<cfinvokeargument name="AddressTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#session.ResvCustID#">
				<cfinvokeargument name="Address1" value="#form.Address#">
				<cfinvokeargument name="Address2" value=" ">
				<cfinvokeargument name="City" value="#form.City#">
				<cfinvokeargument name="State" value="#form.State#">
				<cfinvokeargument name="PostalCode" value="#form.zipcode#">
				<cfinvokeargument name="Country" value="#form.Country#">
			</cfinvoke>
			<cfinvoke method="AddPhone" returnvariable="PhoneID">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#session.ResvCustID#">
				<cfinvokeargument name="PhoneNumber" value="#form.Phone1#">
			</cfinvoke>
			<cfinvoke method="AddPhone" returnvariable="PhoneID">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#session.ResvCustID#">
				<cfinvokeargument name="PhoneNumber" value="#form.phone2#">
			</cfinvoke>
			<cfinvoke method="AddPhone" returnvariable="PhoneID">
				<cfinvokeargument name="PhoneTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#session.ResvCustID#">
				<cfinvokeargument name="PhoneNumber" value="#form.fax#">
			</cfinvoke>
			<cfinvoke method="AddEmail" returnvariable="EmailID">
				<cfinvokeargument name="EmailTypeID" value="1">
				<cfinvokeargument name="ConnectID" value="#session.ResvCustID#">
				<cfinvokeargument name="EmailAddress" value="#form.Email#">
			</cfinvoke>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
				method="InsertXMLRecord" returnvariable="NewReservationID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="reservations">
				<cfinvokeargument name="XMLFields" value="DateCreated,ProductID,ProgramID,contactTime,SpecialNeeds,rentalPeriod,DateFrom,DateTo,dentinationaddress,dentinationCity,dentinationState,dentinationCountry,dentinationZip,dentinationPhone,ResvCustID,status,LocationID">
				<cfinvokeargument name="XMLFieldData" value="#dateformat(form.DateCreated,'yyyy/mm/dd')#,#Form.ProductID#,#form.ProgramID#,#form.contactTime#,#form.SpecialNeeds# ,#form.rentalPeriod#,#dateformat(Form.DateFrom,'yyyy/mm/dd')# ,#dateformat(form.DateTo,'yyyy/mm/dd')# ,#Form.destinationaddress# ,#Form.destinationCity# ,#Form.destinationState# ,#Form.destinationCountry# ,#Form.destinationZip# ,#Form.destinationPhone# ,#ResvCustID# ,0,#form.LocationID#">
				<cfinvokeargument name="XMLIDField" value="ReservationID">
			</cfinvoke>
			<cfif isdefined('page')>
				<cflocation url="index.cfm?page=#trim(resvConfig.checkoutpage)#">
			<cfelse>
				<cflocation url="adminheader.cfm?action=reservations">
			</cfif>
			
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
				method="GetXMLRecords" returnvariable="Alllocations">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="locations">
			</cfinvoke>
			<cfmail to="#resvConfig.emailfrom#" from="#resvConfig.emailfrom#"
			subject="Reservation Started - Credit Card Info to Come"
			bcc="jamie@kotw.net" type="html"
			server="#application.mailserver#">
			<table cellpadding=0 cellspacing=0 border=1 width=100%>


<tr><td colspan=2><font color=black><h2>Reservation Form</h2></font></td></tr>

<tr><td><font color=black><strong>Rental Product &raquo;:</strong></font></td><td>
<table>
		<cfloop index="item" list="#productIDs#">
				<cfquery name="GetProduct" dbtype="query">
					select * from AllProducts where productID='#trim(item)#'
				</cfquery>
				<cfset price=replace(#getProduct.price#,"$","","ALL")>
				<tr>
				<td>
				#trim(getProduct.ProductName)#
				</td>
				<td   nowrap style="text-align: right;">
				#dollarformat(price)#
				</td>
				
				<cfset totaldays=abs(datediff("d",#reservations.dateto#,#reservations.DateFrom#))>
				<cfset ThisPrice=0>
				<cfif totaldays gte 7>
					<cfif #getProduct.showonpage# gt 0 and #getProduct.availability# is 0>
						<cfset thisPrice=#getProduct.showonpage#>
						<cfif totaldays gt 7 and totaldays lt 14>
							<cfset extradays=totaldays - 7>
							<cfset thisPrice=#thisPrice# + (#Price# * #extradays#)>
						<Cfelseif totaldays gte 14>
							<cfset extradays=totaldays - 14>
							<cfset thisPrice = #thisPrice# + #thisPrice#>
							<cfif totaldays gt 14>
								<cfset newPrice=#Price# * #extradays#>
								<cfset thisPrice=#ThisPrice# + #newPrice#>
							</cfif>
						</cfif>
					<cfelseif #getProduct.availability# gt 0 and #getProduct.showonpage# is 0>
						<cfset thisprice=#getProduct.availability#>
					<cfelse>
						<cfset thisPrice=#price# * #totaldays#>
					</cfif>
				<cfelse>
					<cfif #getProduct.showonpage# gt 0 and #getProduct.price# is 0>
						<cfset thisprice=#getProduct.availability#>
					<cfelse>
						<cfset thisprice=#price# * #totaldays#>
					</cfif>
				</cfif>
				<td nowrap style="text-align: right;">#dollarformat(thisPrice)#</td>
				</tr>
				<cfset GrandTotal=#GrandTotal# + #thisprice#>
			</cfloop></td></tr>
			<cfquery name="theProgramName" dbtype="query">
				select programname from allprograms where programid='#reservations.programid#'
			</cfquery>
			<cfquery name="theProgramName" dbtype="query">
				select programname from allprograms where programid='#reservations.programid#'
			</cfquery>
			<cfquery name="thisLocation" dbtype="query">
				select city,state from alllocations where locationID='#reservations.locationID#'
			</cfquery>
			<tr><Td>Total</Td><td>#DollarFormat(grandtotal)#</td></tr></table>
</td></tr>
<tr><td><font color=black><strong>Rental Program &raquo;:</strong></font></td><td>#theProgramName.programname#</td></tr>
<tr><td><font color=black><strong>Dealer Location</strong></font></td><td>
#ThisLocation.LCity#, #thisLocation.State#</td></tr>
<tr><td><font color=black><strong>Title:</strong></font></td><td>#form.title#</td></tr>
<tr><td><font color=black><strong>First Name &raquo;</strong></font></td><td>#form.firstname#</td></tr>
<tr><td><font color=black><strong>Last Name &raquo</strong></font></td><td>#form.lastname#</td></tr>
<tr><td><font color=black><strong>Address  &raquo</strong></font></td><td>#form.address#</td></tr>
<tr><td><font color=black><strong>City &raquo</strong></font></td><td>#form.city#</td></tr>
<tr><td><font color=black><strong>State (USA Only):</strong></font></td><td>#state#</td></tr>
<tr><td><font color=black><strong>Country &raquo:</strong></font></td><td>#form.country#</td></tr>
<tr><td><font color=black><strong>Zip or Postal Code &raquo</strong></font></td><td>#form.zipcode#</td></tr>
<tr><td><font color=black><strong>Primary Phone (with Area Code) &raquo</strong></font></td><td>#form.phone1#</td></tr>
<tr><td><font color=black><strong>Secondary phone (with Area Code)</strong></font></td><td>#form.phone2#</td></tr>
<tr><td><font color=black><strong>Fax (with Area Code)</strong></font></td><td>#form.fax#</td></tr>
<tr><td><font color=black><strong>Email Address &raquo</strong></font></td><td>#form.email#</td></tr>
<tr><td><font color=black><strong>Best Time To Contact?:</strong></font></td><td>#contacttime#</td></tr>
<tr><td><font color=black><strong>What is your height? &raquo</strong></font></td><td>#form.height#</td></tr>
<tr><td><font color=black><strong>What is your weight? &raquo</strong></font></td><td>#form.weight#</td></tr>
<tr><td><font color=black><strong>Special Needs Or Requests</strong><BR>(Please specify any requested wheelchair seat size or ramp length if applies)</font></td><td>#form.specialneeds#</td></tr>
<tr><td><font color=black><strong>Rental Period Less Or Over 14 days? &raquo:</strong></font></td><td><font color=black>#rentalperiod#<br></td></tr>
<tr><td><font color=black><strong>Date Needed From &raquo</strong></font></td><td>#form.datefrom#</td></tr>
<tr><td><font color=black><strong>Date Needed To &raquo</strong></font></td><td>#form.dateto#</td></tr>
<tr><td colspan=2><br><br><font color=red><STRONG>Provide Rental Destination Information</STRONG></font><br><br></td></tr><tr><td><font color=black><strong>Destination Address &raquo</strong></font></td><td>#form.Destinationaddress#</td></tr>
<tr><td><font color=black><strong>Destination City &raquo</strong></font></td><td>#form.destinationcity#</td></tr>
<tr><td><font color=black><strong>Destination State &raquo:</strong></font></td><td>#form.destinationstate#</td></tr>
<tr><td><font color=black><strong>Destination Country</strong></font></td><td>#destinationcountry#</td></tr>
<tr><td><font color=black><strong>Destination Zip Code &raquo</strong></font></td><td>#form.destinationzip#</td></tr></font>
<tr><td><font color=black><strong>Destination Phone (with Area Code) &raquo</strong></font></td><td>#form.destinationphone#</td></tr></font>

</table>
<p>If you have any questions, please call us at #application.PHONENUMBER#, Thank you.</p>
			</cfmail>
		</cfif>
		
		
		<cfif #registrationAction# is "List">
		<cfoutput>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Products">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="resvProducts">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Programs">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="ResvPrograms">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Alllocations">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="locations">
		</cfinvoke>
		<cfif not isdefined('page')>
			<cfset page="">
			<cfset formaction="adminheader.cfm">
			<cfset fontColor="black">
			<cfset SubmitButton="Save Changes">
		<cfelse>
			<cfset formaction="index.cfm">
			<cfset fontColor="white">
			<cfset SubmitButton="Proceed to Checkout">
			<cfset Action="List">
		</cfif>
		<cfform action="#formaction#" enctype="multipart/form-data" method="post" name="thisform">
		<input type="hidden" name="ReservationID" value="#ReservationID#">
		<input type="hidden" name="registrationAction" value="update">
		<input type="hidden" name="Action" value="#Action#">
		<input type="hidden" name="page" value="#page#">
		<table cellpadding=0 cellspacing=0 border=1 width=100%>


<tr><td colspan=2><font color="#fontColor#"><h2>Reservation Form</h2></font></td></tr>
<tr><td colspan=2><font color="#fontColor#">Please fill out the form completely for best service.</font><P><font color="#fontColor#">Required fields are marked with a &raquo;</font></td></tr>
<tr><td><font color="#fontColor#"><strong>Rental Product &raquo;:</strong></font></td><td>
<cfloop query="products">
<input type="checkbox" name="productID" value="#productID#"> #replace(ProductName,"~",",","ALL")#
<cfif #price# gt 0>#dollarformat(price)#/day</cfif><cfif #showonpage# gt 0> #dollarformat(showonpage)#/week</cfif><cfif #availability# gt 0> #dollarformat(availability)#/2 weeks</cfif>
<br>
</cfloop>
</td></tr>
<tr><td><font color="#fontColor#"><strong>Rental Program &raquo;:</strong></font></td><td><cfselect name="programID"><cfloop query="programs"><option value="#programid#">#programDescription#</option></cfloop></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>Dealer Location:</strong></font></td><td><cfselect name="LocationID"><option value="0000000000">None</option><cfloop query="alllocations"><option value="#alllocations.locationID#">#alllocations.city#, #alllocations.state#</option></cfloop></cfselect><br><font color="#fontColor#">If you have selected Mobility products other then the GoGo Ultra, please select the Dealer Location closest to your destination</td></tr>
<tr><td><font color="#fontColor#"><strong>Title:</strong></font></td><td><cfselect name="title"><option value="Mr.">Mr.</option><option value="Mrs.">Mrs.</option><option value="Ms.">Ms.</option><option value="Dr.">Dr.</option><option value="Rev.">Rev.</option></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>First Name &raquo;</strong></font></td><td><cfinput type="text" name="firstname" size="25" maxlength="250" value=" " required="Yes" message="Please enter your first name."></td></tr>
<tr><td><font color="#fontColor#"><strong>Last Name &raquo</strong></font></td><td><cfinput type="text" name="lastname" size="25" maxlength="250" value=" " required="Yes" message="Please enter your last name."></td></tr>
<tr><td><font color="#fontColor#"><strong>Address  &raquo</strong></font></td><td><cfinput type="text" name="address" size="25" maxlength="250" value=" " required="Yes" message="Please enter your address"></td></tr>
<tr><td><font color="#fontColor#"><strong>City &raquo</strong></font></td><td><cfinput type="text" name="city" size="25" maxlength="250" value=" " required="Yes" message="Please enter your city of residence."></td></tr>
<tr><td><font color="#fontColor#"><strong>State (USA Only):</strong></font></td><td><cfselect name="state"><option value="None">None</option><cfinclude template="../files/states.htm"></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>Country &raquo:</strong></font></td><td><cfselect name="country"><cfinclude template="../files/countries.htm"></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>Zip or Postal Code &raquo</strong></font></td><td><cfinput type="text" name="zipcode" size="25" maxlength="250" value=" " required="Yes" message="Please enter your ZIP or Postal code"></td></tr>
<tr><td><font color="#fontColor#"><strong>Primary Phone (with Area Code) &raquo</strong></font></td><td><cfinput type="text" name="phone1" size="25" maxlength="250" value=" " required="Yes" message="Please enter your primary phone number."></td></tr>
<tr><td><font color="#fontColor#"><strong>Secondary phone (with Area Code)</strong></font></td><td><cfinput type="text" name="phone2" size="25" maxlength="250" value=" " required="No" message=""></td></tr>
<tr><td><font color="#fontColor#"><strong>Fax (with Area Code)</strong></font></td><td><cfinput type="text" name="fax" size="25" maxlength="250" value=" " required="No" message=""></td></tr>
<tr><td><font color="#fontColor#"><strong>Email Address &raquo</strong></font></td><td><cfinput type="text" name="email" size="25" maxlength="250" value=" " required="Yes" message="Please enter your email address."></td></tr>
<tr><td><font color="#fontColor#"><strong>Best Time To Contact?:</strong></font></td><td><cfselect name="contacttime"><option value="Morning">Morning</option><option value="Afternoon">Afternoon</option><option value="Evening">Evening</option><option value="Weekends">Weekends</option></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>What is your height? &raquo</strong></font></td><td><cfinput type="text" name="height" size="25" maxlength="250" value=" " required="Yes" message="Please enter your height."> in inches</td></tr>
<tr><td><font color="#fontColor#"><strong>What is your weight? &raquo</strong></font></td><td><cfinput type="text" name="weight" size="25" maxlength="250" value=" " required="Yes" message="Please enter your weight."> in pounds</td></tr>
<tr><td><font color="#fontColor#"><strong>Special Needs Or Requests</strong><BR>(Please specify any requested wheelchair seat size or ramp length if applies)</font></td><td><textarea name="specialneeds" rows="5" cols="20"> </textarea></td></tr>
<tr><td><font color="#fontColor#"><strong>Rental Period Less Or Over 14 days? &raquo:</strong></font></td><td><font color="#fontColor#"><cfinput type=radio name="rentalperiod" value="1" required="Yes" message="Please select a Rental Period" checked> Delivery and Pick Up Free if Rental Period is Over Two weeks<br><font color="#fontColor#"><cfinput type=radio name="rentalperiod" value="2" required="Yes" message="Please select a Rental Period"> Delivery and Pick Up Fee is $50.00 if Rental Period is less than two Weeks<br></td></tr>
<tr><td><font color="#fontColor#"><strong>Date Needed From &raquo</strong></font></td><td>
<cf_intelliCalendar
				FieldName="datefrom" 
				DateFormat="US" 
				Default="#dateformat(now(),'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
</td></tr>
<tr><td><font color="#fontColor#"><strong>Date Needed To &raquo</strong></font></td><td>
<cf_intelliCalendar
				FieldName="dateto" 
				DateFormat="US" 
				Default="#dateformat(now(),'mm/dd/yyyy')#"
				THColor="MidnightBlue"
				THfontColor="white"
				BodyColor="Silver"
				BodyFontColor="black"
				formname="thisform">
</td></tr>
<tr><td colspan=2><br><br><font color=red><STRONG>Provide Rental Destination Information</STRONG></font><br><br></td></tr><tr><td><font color="#fontColor#"><strong>Destination Address &raquo</strong></font></td><td><cfinput type="text" name="Destinationaddress" size="25" maxlength="250" value=" " required="Yes" message="Please enter destination address."></td></tr>
<tr><td><font color="#fontColor#"><strong>Destination City &raquo</strong></font></td><td><cfinput type="text" name="destinationcity" size="25" maxlength="250" value=" " required="Yes" message="Please enter the destination city."></td></tr>
<tr><td><font color="#fontColor#"><strong>Destination State &raquo:</strong></font></td><td><cfselect name="destinationstate"><cfinclude template="../files/states.htm"></cfselect></td></tr>
<tr><td><font color="#fontColor#"><strong>Destination Country</strong></font></td><td><cfinput type="text" name="destinationcountry" size="25" maxlength="250" value="USA" required="No" message=""></td></tr>
<tr><td><font color="#fontColor#"><strong>Destination Zip Code &raquo</strong></font></td><td><cfinput type="text" name="destinationzip" size="25" maxlength="250" value=" " required="Yes" message="Please enter the destination ZIP Code."></td></tr></font>
<tr><td><font color="#fontColor#"><strong>Destination Phone (with Area Code) &raquo</strong></font></td><td><cfinput type="text" name="destinationphone" size="25" maxlength="250" value=" " required="Yes" message="Please enter the destination Phone."></td></tr></font>
<tr><td></td><td><br><input type="submit" NAME=submit VALUE="#submitButton#"></td></tr>
</table>
		</cfform>
		</cfoutput>
		</cfif>
	</cffunction>
	
</cfcomponent>