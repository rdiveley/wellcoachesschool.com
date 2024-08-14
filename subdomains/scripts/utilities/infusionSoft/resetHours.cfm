<cfset DSN = "wellcoachesSchool">

<link rel="stylesheet" type="text/css" href="js/themes/blue/style.css">
<link rel="stylesheet" type="text/css" href="js/addons/pager/jquery.tablesorter.pager.css">
<style>
.input {
    border: 1px solid #006;
    background: #ffc;
}
.button {
    border: 1px solid #006;
    background: #9cf;
}
</style>
<cfoutput> 
<form action="#cgi.SCRIPT_NAME#" method="post">
	User Email address:<input  class="input" type="text" name="userEmail" style="width:280px"/><br />
    <input type="submit" class="button" name="submit" value="Submit" />
</form>
<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfif structKeyExists(form,'submit')>
    <cfquery name="getRecords" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        Select * 
        FROM [wellcoachesSchool].[dbo].[coachInPracticeFeedback] 
        WHERE email like '#trim(FORM.userEmail)#'
    </cfquery>
    
    <cfif getRecords.recordcount>
		<cfset hoursTotal = 0> 
           
        <cfloop query="getRecords">
            <cfset hoursTotal = hoursTotal + val(hours)>
        </cfloop>
        
        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]=FORM.userEmail>
        <cfset myArray[4]=selectedFieldsArray>
        
        <form name="resetHours" action="#cgi.SCRIPT_NAME#" method="post">
            <input type="hidden" name="userEmail" value="#trim(getRecords.email)#" />
            <input type="hidden" name="totalHours" value="#hoursTotal#" />
            <table class="tablesorter">
                <tr>
                    <th>Email</th>
                    <th>Hours</th>
                    <th></th>
                </tr>
                <tr>
                    <td>#getRecords.email#</td>
                    <td>#hoursTotal#</td>
                    <td><input type="submit" class="button" value="Reset Hours" name="reset_hours"></td>
                </tr>
            </table>
        </form>
     <cfelse>
     	No records exist with email #FORM.userEmail#   
     </cfif>   
</cfif>

<!---reset the hours --->
<cfif structKeyExists(form,'reset_hours')>
		
		<cfdocument format="pdf" name="pdfGenerate">
        	#FORM.totalhours# Hours reset on #DateFormat(now(),'mm/dd/yyyy')# for user: #FORM.useremail#
        </cfdocument>
        
        
		<cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Id">
        <cfset selectedFieldsArray[2] = "FirstName">
        <cfset selectedFieldsArray[3] = "LastName">
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]=FORM.useremail>
        <cfset myArray[4]=selectedFieldsArray>
        
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
     

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
        <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult.Filecontent#"
            returnvariable="theData">
        
        

        
		<cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="FileService.uploadFile">
        <cfset myArray[2]=key>
        <cfset myArray[3]="(int)#theData.Params[1][1]['id']#">
        <cfset myArray[4]="#FORM.useremail#_RESETHOURS_#FORM.totalhours#_HOURS_ON_#DateFormat(now(),'mm/dd/yyyy')#.pdf">
        <cfset myArray[5]=ToBase64(pdfGenerate)>
        
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
       
        <cfquery name="insertHistory" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
           INSERT INTO history_hours
           (email, hours, dateSubmitted)
           VALUES
           ('#trim(FORM.userEmail)#',#FORM.totalhours#, #createODBCDateTime(now())# )
        </cfquery>
        
        <cfquery name="deleteHours" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        	update  [wellcoachesSchool].[dbo].[coachInPracticeFeedback] 
            set hours = 0
        	WHERE email like '#trim(FORM.userEmail)#'
        </cfquery>
        Hour reset was successful
</cfif>
</cfoutput>