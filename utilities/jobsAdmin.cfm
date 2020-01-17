<cfparam name="jobAction" default="List">
<cfparam name="alphabet" default="a">
<cfinvoke component="#application.websitepath#.utilities.newjobs" 
	method="JobsAdmin" returnvariable="jobAction">
	<cfinvokeargument name="alphabet" value="#alphabet#">
	<cfinvokeargument name="jobAction" value="#jobAction#">
</cfinvoke>

 
 