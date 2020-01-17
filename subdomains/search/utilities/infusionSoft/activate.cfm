<cfparam name="URL.email" default="">

<cfset DSN = "wellcoaches">
<cfif NOT structKeyExists(URL,'override') >
    <cfquery name="checkExisting" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        select EMailAddress
        from [wellcoaches].[dbo].[EMAIL]
        where EMailAddress like '#URL.email#'
    </cfquery>

    <cfif checkExisting.recordcount>
        Email: <cfoutput>#URL.email#</cfoutput> already exists in our records.  Your account is active <cfabort>
    </cfif>
</cfif>

<cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
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


<cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
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

        <cfset NumbOfChars=8>
        <CFSET NewPass = "">
        <CFLOOP INDEX="RandAlhpaNumericPass" FROM="1" TO="#NumbOfChars#">
            <CFSET NewPass =NewPass&Mid('ABCDEFGHIJCLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz123456789',RandRange('1','66','SHA1PRNG'),'1')>
        </CFLOOP>

            <cftransaction>

             <cfquery name="InsertWellcoaches" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
                INSERT INTO [wellcoaches].[dbo].[members]
                 (
                 firstName,
                 lastname,
                 StartDate,
                 EndDate,
                 Logon,
                 Password,
                 SubTypeID,
                 Height,
                 Active,
                 banned)

            VALUES
                (
                 '#theData.Params[1][1]["FirstName"]#',
                 '#theData.Params[1][1]['LastName']#',
                 '#dateformat(Today)#',
                 '#dateformat(Tomorrow)#',
                 '#URL.email#',
                 '#NewPass#',
                 2,
                 1,
                 1,
                 0)
            </cfquery>

            <cfquery name="GetNextID" datasource = "#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
                select max(MemberID) as NewID from [wellcoaches].[dbo].[members]
            </cfquery>

            <cfset NewID = #GetNextID.NewID#>
            <cfquery name="Insert" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >

            INSERT INTO [wellcoaches].[dbo].[Email]
                 (
                 EMailAddress,
                 TableID,
                 ConnectID,
                 WebSiteID
                 )

            VALUES
                (
                '#URL.EMail#',
                 15,
                 #NewID#,
                 1)

            INSERT INTO [wellcoaches].[dbo].[Addresses]
                 (
                 AddressTypeID,
                 Address1,
                 Address2,
                 City,
                 State,
                 PostalCode,
                 Country,
                 TableID,
                 ConnectID)

            VALUES
                ( 1,
                 '#theData.Params[1][1]['StreetAddress1']#',
                 '#theData.Params[1][1]['StreetAddress2']#',
                 '#theData.Params[1][1]['City']#',
                 '#theData.Params[1][1]['State']#',
                 '#theData.Params[1][1]['PostalCode']#',
                 '#theData.Params[1][1]['Country']#',
                 15,
                 #NewID#)

            INSERT INTO [wellcoaches].[dbo].[PhoneNumbers]
                 (
                 PhoneNumber,
                 TableID,
                 ConnectID,
                 PhoneTypeID)

            VALUES
                (
                '#theData.Params[1][1]['Phone1']#',
                 15,
                 #NewID#,
                 1)
            </cfquery>
    </cftransaction>
    	Thanks for registering! Look for an email soon.
    <!---to="#URL.email#--->
    <cfmail from="wellcoaches@wellcoaches.com" to="#URL.email#" subject="WellCoaches Account activation" type="html">
    	Your web coaching platform has been activated. You will not need to access this component of the training program for several weeks so
    	please simply save this information for your records. You will receive additional information for accessing this tool later in the training program.
    	<br /><br />
      	Login: #URL.email#<br />
        Password: #NewPass#<br />
        <br /><br />
        Thank you
    </cfmail>

   <cfelse>
   		Email address: #URL.email# does not exist in our records.
   </cfif>
</cfoutput>








