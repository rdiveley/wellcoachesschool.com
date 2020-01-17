
<cfset GetOptions=#attributes.Query#>

<cfset tCounter = 1>
<cfoutput query="GetOptions">
	<cfset tSubDescription=#PricingDescription#>
	<cfif ParameterExists(attributes.MatchID)>
		<input type="checkbox" name="PricingID" value="#Pricingid#" <cfif #attributes.MatchId# is #Pricingid#>checked</cfif>> <font face="Arial" size="2" color="Black"><strong>#trim(PricingName)#</strong> -  with<br>
		<cfloop index="JJJ" list="#pricingdescription#" delimiters="~">
		<cfif #JJJ# neq "none">
		#JJJ#<br></cfif>
		</cfloop> </font><br>
	<cfelse>
		<input type="checkbox" name="PricingID" value="#Pricingid#" <cfif #tCounter# is 1>checked</cfif>> <font face="Arial" size="2" color="Black"><strong>#trim(PricingName)#</strong> - with<br>
		<cfloop index="JJJ" list="#pricingdescription#" delimiters="~">
		#JJJ#<br>
		</cfloop> </font><br>
	</cfif>
	<cfset tCounter = #tCounter# + 1>
</cfoutput>

