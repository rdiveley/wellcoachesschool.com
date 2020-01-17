<cfparam name="ReservationsAction" default="List">
<cfparam name="formdata" default="">
<cfparam name="ReservationID" default="0">

<cfif #ReservationsAction# is "edit" or #ReservationsAction# is "update">
	<cfif #ReservationID# gt 0>
		<cfset formdata=ReservationID>
	</cfif>
	<Cfif isdefined('form.fieldnames')>
		<Cfloop index="form_element" list="#FORM.fieldnames#">
			<CFSET #form_element_qualified# = "FORM." & #form_element#>
			<cfif #trim(Evaluate(form_element_qualified))# is "">
				<cfset formdata=ListAppend(#formdata#,"none")>
			<cfelse>
				<cfset thisData=#trim(Evaluate(form_element_qualified))#>
				<cfset thisData=replacenocase(#thisdata#,",","~","ALL")>
				<cfset formdata=ListAppend(#formdata#,#thisData#)>
			</cfif>
		</cfloop>
	</Cfif>
</cfif>
<cfinvoke component="#application.websitepath#.utilities.reservations" 
	method="ReservationsAdmin" returnvariable="ReservationsAction">
	<cfinvokeargument name="ReservationsAction" value="#ReservationsAction#">
	<cfinvokeargument name="theformdata" value="#formdata#">
</cfinvoke>
