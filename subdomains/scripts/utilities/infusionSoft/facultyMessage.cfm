<style>
input[type=submit] {
    color:#08233e;
    font:2.4em Futura, ‘Century Gothic’, AppleGothic, sans-serif;
    font-size:70%;
    padding:5px;
    background:url(overlay.png) repeat-x center #ffcc00;
    background-color:rgba(255,204,0,1);
    border:1px solid #ffcc00;
    -moz-border-radius:10px;
    -webkit-border-radius:10px;
    border-radius:10px;
    border-bottom:1px solid #9f9f9f;
    -moz-box-shadow:inset 0 1px 0 rgba(255,255,255,0.5);
    -webkit-box-shadow:inset 0 1px 0 rgba(255,255,255,0.5);
    box-shadow:inset 0 1px 0 rgba(255,255,255,0.5);
    cursor:pointer;
}
input[type=button]:hover {
    background-color:rgba(255,204,0,0.8);
}
</style>
<cfset DSN = "wellcoaches">
<cfparam name="URL.email" default="">
<cfif structKeyExists(form,'submitForm')>
	<cfif len(trim(FORM.message)) GT 0>
        <cfquery name="insertRecord" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
            insert INTO [wellcoachesSchool].[dbo].[facultyMessages]
            (message,dateSubmitted, email)
            VALUES
            (
            <cfqueryparam value="#FORM.message#" cfsqltype="cf_sql_varchar">
            ,<cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp"/>
            ,<cfqueryparam value="#FORM.email#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
    </cfif>
    <cfset URL.email = FORM.email>
</cfif>
<cfset deleted= structFindValue(form,'Delete')>
<cfif NOT arrayisEmpty(deleted)>
<cfset rowID =listLast(deleted[1]['key'],'_')>

<cfquery name="deleteRecord" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
    update
    [wellcoachesSchool].[dbo].[facultyMessages]
    set deleteRow = 1
    WHERE id = #rowID#
</cfquery>
	<cfset URL.email = FORM.email>
</cfif>



<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfset selectedFieldsArray = ArrayNew(1)>
<cfset selectedFieldsArray[1] = "Email">
<cfset selectedFieldsArray[2] = "FirstName">
<cfset selectedFieldsArray[3] = "LastName">
<cfset myArray = ArrayNew(1)>
<cfset myArray[1]="ContactService.findByEmail"><!---Service.method always first param--->
<cfset myArray[2]=key>
<cfset myArray[3]=URL.email>
<cfset myArray[4]=selectedFieldsArray>


<cfinvoke component="utilities/XML-RPC"
        method="CFML2XMLRPC"
        data="#myArray#"
        returnvariable="myPackage">

        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult1">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

    <cfinvoke component="utilities/XML-RPC"
        method="XMLRPC2CFML"
        data="#myResult1.Filecontent#"
        returnvariable="theData">

<cfset facultyEmail =  theData.Params[1][1]['Email']>
<cfoutput>
Welcome #theData.Params[1][1]['FirstName']# #theData.Params[1][1]['LastName']#<br />
Please type message in text box below:<br>
<form action="#cgi.SCRIPT_NAME#" method="post" >
<input type="hidden" name="email" value="#theData.Params[1][1]['Email']#">
<textarea cols="92" rows="7" name="message"></textarea><br />
<div style="position:relative;left:660px; top:5px"><input type="submit" name="submitForm" value="Post Message"  /></div>
<br>
  <cfquery name="checkExisting" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        select id,message, email,dateSubmitted,deleteRow
        from [wellcoachesSchool].[dbo].[facultyMessages]
         where deleteRow <> 1 or deleteRow is null
        order by dateSubmitted DESC
  </cfquery>
  <div style="border : solid 2px ##000000; background : ##ffffff; color : ##ffffff; padding : 4px; width : 750px; height : 200px; overflow : auto; ">
  <table>
  <cfloop query="checkExisting">
  	<tr bgcolor="###iif(currentrow MOD 2,DE('ffffff'),DE('efefef'))#">
    	<td><span style="font-size:9px;font-weight:bold;font-family:Verdana, Geneva, sans-serif"><a href="mailto:#email#?subject=Faculty%20Message%20Board">#email#</a> - #DateFormat(dateSubmitted,'full')# #timeFormat(dateSubmitted,'short')#</span><br>
        	#Replace(message,"#chr(10)#","<br>","all")#
        </td>
        <td>
        	<input type="submit" name="deleteRow_#id#" value="Delete">
        </td>
    </tr>
  </cfloop>
  </table>
  </div>
</form>

</cfoutput>