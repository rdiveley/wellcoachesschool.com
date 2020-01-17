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

<cfset DSN = "wellcoaches">
<cfif structKeyExists(form,'FindUser')>
	
    
    <!--- Get all directory information in a query of queries.--->
    <cfquery name="foundUsers" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        SELECT connectID, FirstName, LastName, emailAddress
        FROM [wellcoaches].[dbo].[Email] e INNER JOIN [wellcoaches].[dbo].[Members] m
        on e.connectID = m.memberID
        WHERE 
        	<cfloop array="#listToArray(form.userPortal)#" index="email">
            	emailAddress like '%#trim(email)#%' OR
        	</cfloop>
            1!=1
            
    </cfquery>
    <cfif foundUsers.recordcount>
    <form method="post">
    
    <script language="JavaScript">
		function toggle(source) { 
			
			var aa= document.getElementsByTagName("input");
			if(document.getElementById('master').value==1){
				for (var i =0; i < aa.length; i++){
				if (aa[i].type == 'checkbox')
					aa[i].checked = true;
				}
				master.value = 0;
			}else{
				for (var i =0; i < aa.length; i++){
				if (aa[i].type == 'checkbox')
					aa[i].checked = false;
				}
				master.value = 1;
			}
		}
	
	</script>
    <input type="hidden" id="master" />
      <table class="tablesorter">
            <tr>
            	<td>User ID</td>
                <td>Portal User</td>
                <td>Email</td>
                <td>De-Activate <a href="##" onClick="toggle(this)" /> Toggle All</a></td>
            </tr>
            <cfset count = 0>
            <cfoutput query="foundUsers">
            	<cfset count = count + 1>
                <tr class="#IIf(CurrentRow Mod 2, DE('rowOdd'), DE('rowEven'))#" onmouseover="this.className='rowHighlight'" <cfif CurrentRow Mod 2>onmouseout="this.className='rowOdd'"<cfelse>onmouseout="this.className='rowEven'"</cfif>>
                    <td>#ConnectID#</td>
                    <td>#FirstName# #LastName#</td>
                    <td>#EmailAddress#</td>
                    <td><input type="checkbox" name="IDs" value="#connectID#|#emailAddress#"></td>
                </tr>
            </cfoutput>
            <tr>
            	<td align="center" colspan="2">
                <fieldset>
                	<div>
                	<input type="submit" name="deactivateList" value="Deactivate Portal(s)" class="button-link">
                	</div>
                </fieldset>	
                </td>
            </tr>    
        </table>
      </form> 
    <cfelse>
    	<table class="tablesorte">
        <tr><td>
    	No Portals were found, please try again <button class="button-link" onClick="javascript:window.location='deactivateportal.cfm'"> Back </button>
        </td>
        </tr>
        </table>
    </cfif>
<cfelseif structKeyExists(form,'deactivateList')>
	<cfoutput>
    <cfif NOT structKeyExists(form,'IDs')>
    	<table class="tablesorter">
        <tr><td>
    	No Portal sites were selected, please try again <button class="button-link" onClick="javascript:history.go(-1)"> Back </button>
        </td>
        </tr>
        </table>
        <cfabort>
    </cfif>
    <cfset UserID = '' />
    <cfset emailAddress = '' />
    <cfloop list="#FORM.IDs#" index="id">
    	<cfset UserID = listAppend(UserID,listFirst(id,"|")) />
        <cfset emailAddress = listAppend(emailAddress,listLast(id,'|')) />
    </cfloop>
    
   
    <cfquery name="deactivatePortal" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
    	update [wellcoaches].[dbo].[Members]
            set active = 0
            where memberID IN (#UserID#)
    </cfquery>
    <br />
    The following Email Addresses have been deactivated: <br />
    <cfloop list="#emailAddress#" index="email">
    	#email# <br />
    </cfloop>
    
   		<a href="javascript:window.location='deactivateportal.cfm'">Back</a>
    </cfoutput>      
<cfelse>
<table class="tablesorter">
	
	<form method="post">
		<tr><td>Email Address to deactivate: <textarea cols="50" rows="10" name="UserPortal"></textarea>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="FindUser" value="Find" class="button-link"></td></tr>
    </form>   
    </tr> 
</table>    
</cfif>

