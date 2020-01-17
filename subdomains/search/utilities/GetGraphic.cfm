<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Graphics">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>

<cfloop query="graphics">
	<cfif #GraphicsTypeID# is 4>
		<cfset Details=#Details# & "<option value='#GraphicsID#' ">
		<cfif #trim(MatchID)# is #trim(GraphicsID)#>
			<cfset Details=#Details# & "selected">
		</cfif>
		<cfset Details=#Details# & ">#Description#</option>">
	</cfif>
</cfloop>
