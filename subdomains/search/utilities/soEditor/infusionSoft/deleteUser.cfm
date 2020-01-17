<cfoutput>

<cfset DSN = "wellcoaches">  

<cfparam name="URL.email" default="">


<script type="text/javascript">
<!--
function confirmation() {
	var answer = confirm("Are you sure you want to delete user #URL.email#?")
	if (answer){
		window.location = "./deleteuser.cfm?email=#URL.email#&confirm=1";
	}
	else{
		alert("User has not been deleted")
	}
}
//-->
</script>
<form>
	<input type="button" name="Delete User" onClick="confirmation()" value="Delete Account #URL.email#">
</form>
<cfif isDefined("URL.confirm")>
    <cfquery name="checkExisting" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        select connectID
        from [wellcoaches].[dbo].[EMAIL]
        where EMailAddress like '#URL.email#'
    </cfquery>
    
    <cfif checkExisting.recordcount>
       
         <!---<cfquery name="deleteUserFromWellcoachesschool" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        	select banned
            from [wellcoaches].[dbo].[members] where memberID IN (#checkExisting.connectID#)
         </cfquery>
         
         <cfif deleteUserFromWellcoachesschool.banned NEQ "">
             <cfquery name="deleteUserWCS" datasource="wellcoachesSchool" username="#application.DSNuName#" password="#application.dsnpword#" >
                 delete from [wellcoachesSchool].[dbo].[members] where memberID IN (#deleteUserFromWellcoachesschool.banned#)
             </cfquery>
         </cfif>--->
         <cftransaction>
         <cfquery name="deleteUser" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
             delete from [wellcoaches].[dbo].[members] where memberID IN (#checkExisting.connectID#)
             delete from [wellcoaches].[dbo].[email] where connectID IN (#checkExisting.connectID#)
             delete FROM [wellcoaches].[dbo].[Addresses] where connectID IN (#checkExisting.connectID#)
             delete FROM [wellcoaches].[dbo].[PhoneNumbers] where connectID IN (#checkExisting.connectID#)
         </cfquery>
        
        </cftransaction>  
        User accout has been successfully deleted!
    </cfif>

</cfif>
  
</cfoutput>