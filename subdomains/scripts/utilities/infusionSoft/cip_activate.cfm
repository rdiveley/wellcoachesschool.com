<cfparam name="URL.email" default="">

<cfset DSN = "wellcoaches">

<!---<cfquery name="checkExisting" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	select EMailAddress
    from [wellcoaches].[dbo].[EMAIL]
    where EMailAddress like '#URL.email#'
</cfquery>

<cfif checkExisting.recordcount>
	Email: <cfoutput>#URL.email#</cfoutput> already exists in our records.  Your account is active <cfabort>
</cfif>--->

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "StreetAddress1">
<cfset selectedFieldsArray[2] = "City">
<cfset selectedFieldsArray[3] = "State">
<cfset selectedFieldsArray[4] = "FirstName">
<cfset selectedFieldsArray[5] = "LastName">
<cfset selectedFieldsArray[6] = "Phone1">
<cfset selectedFieldsArray[7] = "PostalCode">
<cfset selectedFieldsArray[8] = "StreetAddress2">
<cfset selectedFieldsArray[9] = "Country">
<cfset selectedFieldsArray[10] = "Id">


<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.email>
<cfset myArray[4]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
	method="CFML2XMLRPC"
	data="#myArray#"
    returnvariable="myPackage">

<!---<cfx_http5 url="https://my982.infusionsoft.com/api/xmlrpc" method="POST" body=#myPackage.Trim()# out="myResult"  >--->



        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/v1/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

<cfinvoke component="utilities/XML-RPC"
    method="XMLRPC2CFML"
    data="#myResult.Filecontent#"
    returnvariable="theData">
    <cfoutput>

  	<!---<cfdump var="#theData.PARAMS[1]#"><cfabort>--->
    <cfif not ArrayIsEmpty(theData.PARAMS[1])>
        <cfparam name="theData.Params[1][1]['StreetAddress1']" default="">
        <cfparam name="theData.Params[1][1]['StreetAddress2']" default="">
        <cfparam name="theData.Params[1][1]['City']" default="">
        <cfparam name="theData.Params[1][1]['State']" default="">
        <cfparam name="theData.Params[1][1]['FirstName']" default="">
        <cfparam name="theData.Params[1][1]['LastName']" default="">
        <cfparam name="theData.Params[1][1]['FirstName']" default="">
        <cfparam name="theData.Params[1][1]['Phone1']" default="">
        <cfparam name="theData.Params[1][1]['PostalCode']" default="">
        <cfparam name="theData.Params[1][1]['Country']" default="">
        <cfset Today=#dateformat(now())#>
		<cfset Tomorrow=#dateadd("d",365,#today#)#>


           <cfquery name="getUserID" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
           	SELECT memberID
          		FROM  [wellcoaches].[dbo].members m inner join [wellcoaches].[dbo].email e
          		ON m.memberID = e.connectID
          		where emailAddress like '#URL.email#'
           </cfquery>

          <cfif getUserID.memberID NEQ "">
              <cfquery name="updateCoachType" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
                   update  [wellcoaches].[dbo].[members]
                    set height = 2
                    ,active=1
                    where memberID = #getUserID.memberID#
              </cfquery>
              <cflocation url="http://www.wellcoaches.com/common/marketingsitesetup.cfm?coachid=#getUserID.memberID#&activate=1&email=#URL.email#" addtoken="no">
            <cfelse>
                 <cfmail from="wellcoaches@wellcoaches.com" to="techsupport@wellcoaches.com" subject="WellCoaches Account activation failed" type="html">
                    The marketing site creation failed.<br /><br />
                    User email: #URL.email# was found in InfusionSoft, however #URL.email# was not found in our database.
                 </cfmail>
 			</cfif>

    	Thanks for registering! Look for an email soon.
    <!---to="#URL.email#--->
    <cfmail from="wellcoaches@wellcoaches.com" to="#URL.email#" subject="WellCoaches Account activation" type="html">
    	Your web coaching platform has been activated. You will not need to access this component of the training program for several weeks so
    	please simply save this information for your records. You will receive additional information for accessing this tool later in the training program.
    	<br /><br />
      	Login: #URL.email#<br />

        <br /><br />
        Thank you
    </cfmail>

   <cfelse>
   		Email address: #URL.email# does not exist in our records.
         <cfmail from="wellcoaches@wellcoaches.com" to="wellcoaches@wellcoaches.com" subject="WellCoaches Account activation failed" type="html">
              User email: #URL.email# tried to activate their account and their email address was not found.
          </cfmail>
   </cfif>
</cfoutput>








