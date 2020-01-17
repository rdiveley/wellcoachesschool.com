<cfset GetOptions=#attributes.Query#>
<cfset tCounter = 1>
<cfoutput query="GetOptions">
	<cfset tSubDescription=#TypeDescription#>
	<cfif ParameterExists(attributes.MatchID)>
		<input type="radio" name="MemberTypeID" value="#typeid#" <cfif #attributes.MatchID# is #typeid#>checked</cfif>> <font face="Arial" size="2" color="Black"><strong>#trim(TypeName)#</strong><cfif #tSubDescription# neq "none"> - #trim(replace(tSubDescription,"~",",","ALL"))#</cfif></font><br>
	<cfelse>
		<input type="radio" name="MemberTypeID" value="#typeid#" <cfif #tCounter# is 1>checked</cfif>> <font face="Arial" size="2" color="Black"><strong>#trim(TypeName)#</strong><cfif #tSubDescription# neq "none"> - #trim(replace(tSubDescription,"~",",","ALL"))#</cfif></font><br>
	</cfif>
	<cfset tCounter = #tCounter# + 1>
</cfoutput>

