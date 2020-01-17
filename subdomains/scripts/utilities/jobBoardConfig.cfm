<cfparam name="ConfigAction" default="NO">
<cfinvoke component="#application.websitepath#.utilities.jobboard" 
	method="jobBoardConfig" returnvariable="ConfigAction">
	<cfinvokeargument name="ConfigAction" value="#ConfigAction#">
</cfinvoke>

 