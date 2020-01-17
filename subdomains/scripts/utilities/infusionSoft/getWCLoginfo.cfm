<cfset DSN = "wellcoachesSchool">

<cfoutput>
<cfif structKeyExists(form,'Update Logon')>
    <cfquery name="getInfo" datasource="#dsn#">
        SELECT top 1
            m.logon
            ,m.password
            ,[EMailAddress] as email

      FROM [wellcoaches].[dbo].[Email] e inner join [wellcoaches].[dbo].[Members] m ON m.memberID = e.connectID
      where emailaddress like '#FORM.email#'
      and subTypeID=2
    </cfquery>

    <cfif getInfo.recordCount>

        <cfset key = "fb7d1fc8a4aab143f6246c090a135a41">
		<cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]=form.email>
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

        <cfset updateField = structNew()>
        <cfset updateField['_WCMarketingSiteLogon']=getInfo.logon>
        <cfset updateField['_Password0']=getInfo.password>


        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.update">
        <cfset myArray[2]=key>
        <cfset myArray[3]='(int)#theData.Params[1][1]['Id']#'>
        <cfset myArray[4]=updateField>

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage4">

        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
            <cfhttpparam type="XML" value="#myPackage4.Trim()#"/>
        </cfhttp>

        WC Marketing Site Logon: #getInfo.logon# <br>
        WC Marketing Site Password: #getInfo.password#<br>

    <cfelse>
        No records exist with email '#form.email#'
    </cfif>
</cfif>
<br />
<form method="post">
	Enter IS email:<input type="text" name="email">
    <input type="submit" name="Update Logon" value="Get Login Info">
</form>


</cfoutput>
