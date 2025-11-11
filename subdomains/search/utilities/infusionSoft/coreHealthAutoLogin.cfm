
<cfif structKeyExists(form,'returnURL')>
	<cfset local.returnURL = form.returnURL.split('&')>

	<cfloop array="#local.returnURL#" index="local.rtn">
		<cfif FindNoCase('returnURL',local.rtn)>
			<cfset local.returnURL = local.rtn>
		</cfif>
	</cfloop>
</cfif>

<cfif structKeyExists(FORM,'email')>
	<cfset URL.email = FORM.email />
</cfif>

	<cfset key = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093" />
    <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "Password", "Groups"]>
    <cfset myArray = ["ContactService.findByEmail", key, URL.email, selectedFieldsArray]>

		<cfinvoke component="utilities/XML-RPC"
			method="CFML2XMLRPC"
			data="#myArray#"
			returnvariable="myPackage">
		
		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
			variable="myResult1"
			timeout = "200">
		</cfexecute>

		<cfinvoke component="utilities/XML-RPC"
			method="XMLRPC2CFML"
			data="#myResult1#"
			returnvariable="theData">



	<cfif !arrayLen(theData.Params[1])>
		<cflocation url="https://search.wellcoachesschool.com/wc-login/habits-login/?notvalid">
	</cfif>

<cfif arrayLen(theData.Params[1]) GT 1>
	<cfloop array="#theData.Params[1]#" index="local.index">
		<cfif local.index['Email'] EQ form.email>
			<cfset memberID =  local.index['Id']>
			<cfset local.groups = local.index['Groups']>
			<cfset local.pass = local.index['Password']>
			<cfset local.fname = local.index['FirstName']>
			<cfset local.lname = local.index['LastName']>
			<cfset local.email = local.index['Email']>
		</cfif>
	</cfloop>
<cfelse>
	<cfset memberID =  theData.Params[1][1]['Id']>
	<cfset local.groups = theData.Params[1][1]['Groups']>
	<cfset local.pass = theData.Params[1][1]['Password']>
	<cfset local.fname = theData.Params[1][1]['FirstName']>
	<cfset local.lname = theData.Params[1][1]['LastName']>
</cfif>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>

<script>
$( document ).ready(function() {

	var key = CryptoJS.enc.Utf8.parse('NxPm87S7DPv27ZVrMevne8cah94qq6GJ');
	var iv  = CryptoJS.enc.Utf8.parse('gM5xaReZ3KJTzBdB');
	var fname = <cfoutput>'#local.fname#';</cfoutput>
	var lname = <cfoutput>'#local.lname#';</cfoutput>
	var emailaddress = <cfoutput>'#FORM.email#';</cfoutput>
		  var timestamp = new Date();
		  var habits = '1,3,5,7,8';

		  var userInfo = {
		            id: emailaddress,
		            fistname: fname,
		            lastname: lname,
		     		habits: habits,
		     		timestamp: timestamp
			};

		  var message = JSON.stringify(userInfo);

		  var encrypted = CryptoJS.AES.encrypt(
		    			message,
		    			key,
		    			{
		                  keySize: '256',
		                  iv:iv,
		                  mode: CryptoJS.mode.CBC,
		                  padding: CryptoJS.pad.Pkcs7
		    			}
		 );
		 $('#payload').val(encrypted.toString());
		 $('#coreHealthAutoLogin').submit();
});
</script>

<cfoutput>

<cfset local.allow = false>
<cfloop list="#local.groups#" index="local.tag">
	<cfif local.pass EQ FORM.pass and local.tag EQ 8867>
		<cfset local.allow = true>
	</cfif>
</cfloop>

<cfif local.allow>

	<cfif structKeyExists(local,'returnURL') AND len(local.returnURL)>
		<cfset local.returnURL = local.returnURL>
	<cfelse>
		<cfset local.returnURL='%2fwellcoacheshabits%2fCoachingHabits%2fDefault.aspx%3ffilter%3dme&amp;filter=me" '>
	</cfif>


	<form id="coreHealthAutoLogin" action="https://mywell.site/wellcoacheshabits/networkpartners/wellcoaches/SignOn.aspx?#local.returnURL#" method="post">
		<input id="payload" name="payload" type="hidden" />
		<input id="fname" type="hidden" value="#theData.Params[1][1]['FirstName']#" />
		<input id="lname" type="hidden" value="#theData.Params[1][1]['LastName']#" />
		<input id="emailaddress" type="hidden" value="#FORM.email#" />

	</form>

<cfelse>
	<cflocation url="https://search.wellcoachesschool.com/wc-login/habits-login/?notvalid">
</cfif>


</cfoutput>