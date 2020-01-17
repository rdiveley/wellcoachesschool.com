<cfsetting enablecfoutputonly="yes">
<!-----------------------------------------
AUTHOR: Jamie Robinson
DATE: November 14, 2004
PURPOSE: To send email addresses and names to the MCSSL mailing lists for ExerciseCareers.com
------------------------------------------>

<cfscript>

	
</cfscript>

<cftry>

	<!------ use cfhttp to post to http://www.mcssl.com/app/contactsave.asp ------->
	<cfhttp url="http://www.mcssl.com/app/contactsave.asp" method="post">
		<cfhttpparam type="FORMFIELD" name="merchantid" value="59221">
		<cfhttpparam type="FORMFIELD" name="ARThankyouURL"  value="www.1shoppingcart.com/app/thankyou.asp?merchantid=59221">
		<cfhttpparam type="FORMFIELD" name="copyarresponse"  value="1">
		<cfhttpparam type="FORMFIELD" name="custom"  value="0">
		<cfhttpparam type="FORMFIELD" name="allowmulti"  value="1">
		<cfhttpparam type="FORMFIELD" name="Email1" value="#attributes.email#">
		<cfhttpparam type="FORMFIELD" name="Name" value="#attributes.name#">
		<cfhttpparam type="FORMFIELD" name="AR"  value="#attributes.AR#">
	</cfhttp>

	
	<cfcatch>
		
		<cfset product.response_reason_text = "A Cold Fusion error occurred when attempting to connect with Mailing List Server.">	   
		
	</cfcatch>
	
</cftry>

<cfsetting enablecfoutputonly="no">
