<cfparam name="CategoryAction" default="NO">
<cfinvoke component="#application.websitepath#.utilities.newjobs" 
	method="JobCategoryAdmin" returnvariable="CategoryAction">
	<cfinvokeargument name="CategoryAction" value="#CategoryAction#">
</cfinvoke>
 