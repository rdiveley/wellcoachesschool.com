<style>
	tr.rowOdd {background-color: #FFFFFF;}
	tr.rowEven {background-color: #E7E7E7;}
	tr.rowHighlight {background-color: #FFFF99;}
	/* tables */
	table.tablesorter {
		font-family:arial;
		background-color: #CDCDCD;
		margin:10px 0pt 15px;
		font-size: 8pt;
		width: 400px;
		text-align: left;
	}
	.button-link {
    padding: 10px 15px;
    background: #4479BA;
    color: #FFF;
	}

	
</style>

<cfset DSN = "wellcoachesschool">
<h2>Email Addresses Fixes for Customer Hub</h2>
<form method="post">
    <table class="tablesorter">
        <tr>
            <td>
                Email Address<br>
                (Comma deliminated list, include old email address and new one. i.e. RDiveley@hotmail.com,Rdiveley@wellcoaches.com)
            </td>
        </tr>
        <tr><td><input type="text" name="emailAddress" size="100"></td></tr>
        <tr>
            <td align="center" colspan="2">
            <fieldset>
                <div>
                <input type="submit" name="insertEmail" value="Insert Email Addresses" class="button-link">
                </div>
            </fieldset>	
            </td>
        </tr>    
    </table>
  </form> 
  
<cfif structKeyExists(form,'emailAddress') AND ListLen(form.emailaddress) gt 1>
	<cfset local.cleanEmail = Replace(form.emailAddress,' ','','all') />
	<cfquery name="deactivatePortal" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
    	insert into [wellcoachesschool].[dbo].[coachInPracticeEmailFix]
        (
        email_address
        ,date
        )
        values
       	(
        	'#local.cleanEmail#'
            ,<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />
        )
    </cfquery>
    <br />
    The following Email Addresses have been inserted into the database: <br />
    <cfloop list="#form.emailAddress#" index="email">
    	<cfoutput>#email# <br /></cfoutput>
    </cfloop>
    
   		<a href="javascript:window.location='emailFix.cfm'">Back</a>
        

</cfif>

