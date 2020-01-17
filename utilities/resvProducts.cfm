<cfparam name="ProductsAction" default="List">
<cfparam name="formdata" default="">
<cfparam name="ProductID" default="0">

<cfif #ProductsAction# is "edit" or #ProductsAction# is "update">
	<cfif #ProductID# gt 0>
		<cfset formdata=ProductID>
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
	method="ResvProductsAdmin" returnvariable="ProductsAction">
	<cfinvokeargument name="ProductsAction" value="#ProductsAction#">
	<cfinvokeargument name="theformdata" value="#formdata#">
</cfinvoke>
