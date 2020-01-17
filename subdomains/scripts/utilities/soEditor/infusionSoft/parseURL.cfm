<cfoutput>
<cfloop collection="#URL#" item="i">
	 <cfif i contains "subscriptionPlan">
	 	<cfset URL.subPlanID = URL[i]>
     <cfelse>
     	<cfset URL.prodID = URL[i]>
     </cfif>
</cfloop>

<script>
		  window.open('https://my982.infusionsoft.com/app/manageCart/addProduct?productId=#URL.prodID#&subscriptionPlanId=#URL.subplanID#', '_parent'); 
</script>
<!---<cflocation url="https://my982.infusionsoft.com/app/manageCart/addProduct?productId=#productID#&subscriptionPlanId=#subscriptionPlanID#">--->
</cfoutput>

