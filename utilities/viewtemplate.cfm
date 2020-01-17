<cfparam name="TemplateName" default=''>
<cfparam name="TemplateID" default=0>

<cfset ViewPage = trim(#TemplateName#)>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="#TemplateName#">
		<cfinvokeargument name="ThisPath" value="Templates">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="TheDetails">
		<cfinvokeargument name="ThisPath" value="Templates">
		<cfinvokeargument name="ThisFileName" value="#templateName#">
	</cfinvoke>
	<cfquery name="AllDetails" dbtype="query">
		select * from thedetails order by positionid
	</cfquery>
<cfset Details=''>

<cfoutput query="AllDetails">

<!--- Table Structure --->
<cfif #DisplayTypeID# is 1>
	<cfset Content2=''>
	<cfset Content2=replace(#Content#,'width','')>
	<cfset Content2=replace(#Content2#,'<table','<table border=1')>
	<cfset Content2=replacenocase(#content2#,'src="images/','src="../images/',"ALL")>
	<cfset Content2=replacenocase(#content2#,'background="images/','background="../images/',"ALL")>
	<cfset Details=#Details# & #Content2#>
</cfif>
<!--- Table Background Color  --->
<cfif #DisplayTypeID# is 2>

</cfif>

<!--- Table Background Image  --->
<cfif #DisplayTypeID# is 3>

</cfif>

<!--- Table Cell Background Color  --->
<cfif #DisplayTypeID# is 4>

</cfif>

<!--- Table Cell Background Image  --->
<cfif #DisplayTypeID# is 5>

</cfif>

<!--- Image --->
<cfif #DisplayTypeID# is 6>
	<cfset Details = #Details# & "<img src=../images/placeholder.jpg>">
</cfif>

<!--- Logo Image --->
<cfif #DisplayTypeID# is 13>
	<cfset Details = #Details# & "<img src=../images/placeholder.jpg>">
</cfif>

<!--- Banner Image --->
<cfif #DisplayTypeID# is 14>
	<cfset Details = #Details# & "<img src=../images/placeholder.jpg>">
</cfif>

<!--- Product Listing Script --->
<cfif #DisplayTypeID# is 15>
	<cfset Details = #Details# & "Product Listing goes here.">
</cfif>

<!--- Text --->
<cfif #DisplayTypeID# is 7>
	<cfset Details = #Details# & "The content of the Web Site goes here.">

</cfif>

<!--- One Navigation Link --->
<cfif #DisplayTypeID# is 8>
	<cfset Details = #Details# & "[Button]">
</cfif>

<!--- Navigation Drop Down List --->
<cfif #DisplayTypeID# is 17>
	<cfset Details = #Details# & "<select><option>[Button]</option></select>">
</cfif>

<!--- Navigation Link List--->
<cfif #DisplayTypeID# is 9>
	<cfloop index="I" from="1" to="10">
		<cfset Details=#Details# & "[Button]<br>">
	</cfloop>
</cfif>

<!--- Sideways Navigation Link List--->
<cfif #DisplayTypeID# is 10>
	<cfloop index="I" from="1" to="10">
		<cfset Details=#Details# & "[Button] | ">
	</cfloop>
</cfif>

<!--- Javascript --->
<cfif #DisplayTypeID# is 11>
	<cfset Details=#Details# & "<script language='JavaScript1.1'>" & #Content# & "</script>">
</cfif>




</cfoutput>


<cfoutput>
<table width="100%" border=0 bgcolor=white cellpadding=0 cellspacing=0>
<tr><td>#Details#
<br>
</td></tr>
</table>
<a href="javascript:history.go(-1)">Return to Templates</a>
</cfoutput>
</cfif>

