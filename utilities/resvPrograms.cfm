<cfparam name="ProgramAction" default="List">
<cfparam name="formdata" default="">
<cfif #ProgramAction# is "edit" or #ProgramAction# is "update">
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
	method="ResvProgramsAdmin" returnvariable="ProgramAction">
	<cfinvokeargument name="ProgramAction" value="#ProgramAction#">
	<cfinvokeargument name="theformdata" value="#formdata#">
</cfinvoke>
