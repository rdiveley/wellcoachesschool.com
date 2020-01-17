<cfset EXPIRES = ''> 
<cfset EXPIRETIME = ''>
<cfset SESSIONID =1>
<cfset UUID = ''>

<cfset MyID=CreateUUID()>

<cfset Expires=dateformat(now(),"mm/dd/yyyy")>
<cfset Hours = timeformat(now(),"H")>
<cfset Minutes = timeformat(now(),"mm")>

<cfif Hours gt 21>
	<cfset Expires=dateadd("D",1,now())>
	<cfset Expires=dateformat(#Expires#,"mm/dd/yyyy")>
	<cfset Hours = (#Hours# + 3) - 24>
	<cfset ExpireTime = "#Hours#:#Minutes#">
<cfelse>
	<cfset Hours = #Hours# + 3>
	<cfset ExpireTime = "#Hours#:#Minutes#">
</cfif>

<cfset xUserSession=ArrayNew(2)>
<cfset xUserSession[1][1]=1>
<cfset xUserSession[1][2]=#Expires#>
<cfset xUserSession[1][3]=#ExpireTime#>
<cfset xUserSession[1][4]=#MyID#>
<cfwddx action="cfml2wddx"
	input="#xUserSession#"
	output="UserSession">
<cffile action="WRITE" file="#application.UploadPath#\#application.ScriptsPath#\usersession.xml" 
	output="#UserSession#" addnewline="No">

