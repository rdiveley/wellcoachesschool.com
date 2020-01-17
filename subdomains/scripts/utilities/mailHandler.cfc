<cfcomponent>
	<cffunction name="SendTheMail" access="remote" returntype="boolean">
		<cfargument name="EmailTo" type="string" required="true" default="">
		<cfargument name="EmailFrom" type="string" required="true" default="">
		<cfargument name="EmailBCC" type="string" required="true" default="">
		<cfargument name="EmailSubject" type="string" required="true" default="">
		<cfargument name="EmailBody" type="string" required="true" default="">
		<cfargument name="EmailServer" type="string" required="true" default="">

		<cftry>
		<cfmail 
			to="#arguments.EmailTo#" 
			from="#Arguments.EmailFrom#" 
			subject="#arguments.EmailSubject#" 
			bcc="#arguments.EmailBCC#" type="html" 
			server="#arguments.EmailServer#">#arguments.EmailBody#</cfmail>
		<cfcatch type="Any">
			<cfreturn false>
		</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="MailArticleRequest" access="remote" returntype="boolean">
		<cfargument name="EmailFrom" default="" required="true" type="string">
		<cfargument name="EmailSubject" default="" required="true" type="string">
		<cfargument name="Topic" default="" required="true" type="string">
		<cfargument name="comments" default="" required="true" type="string">
		<cfargument name="FromName" default="" required="true" type="string">
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="InitWebSite"
			 returnvariable="InitWebSiteRet">
		</cfinvoke>
		<cfinvoke component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetMailServer" returnvariable="MailServer">
		</cfinvoke>
		<cfset WEbEmail=#InitWebSiteRet[1][20]#>
		<cfset EmailServer=#MailServer#>
		<cfset EmailTo="#WebEmail#">
		<cfset Emailbcc="jamie@kotw.net">
		<cfset EmailFrom="#webEmail#">
		<cfset EmailSubject="#arguments.EmailSubject#">
		<cfset EmailBody="#arguments.FromName# at #trim(arguments.EmailFrom)#has requested the following from the Health Concerns library<br><br>#arguments.Topic#<br><br>Comments: #arguments.comments#<br><br>">
		
		<cfinvoke method="SendTheMail" returnvariable="success">
			<cfinvokeargument name="EmailTo" value="#EmailTo#">
			<cfinvokeargument name="EmailFrom" value="#EmailFrom#">
			<cfinvokeargument name="EmailBCC" value="#EmailBCC#">
			<cfinvokeargument name="EmailSubject" value="#EmailSubject#">
			<cfinvokeargument name="EmailBody" value="#EmailBody#">
			<cfinvokeargument name="EmailServer" value="#EmailServer#">
		</cfinvoke>
		<cfreturn #success#>
	</cffunction>
	
	<cffunction name="MailContactRequest" access="remote" output="true" returntype="boolean">
		<cfargument name="EmailFrom" default="" required="true" type="string">
		<cfargument name="EmailSubject" default="" required="true" type="string">
		<cfargument name="ContactName" default="" required="true" type="string">
		<cfargument name="Telephone" default="" required="true" type="string">
		<cfargument name="Comments" default="" required="true" type="string">
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="InitWebSite"
			 returnvariable="InitWebSiteRet">
		</cfinvoke>
		<cfinvoke component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetMailServer" returnvariable="MailServer">
		</cfinvoke>
		<cfset WEbEmail=#InitWebSiteRet[1][20]#>
		<cfset EmailBody="<table><tr><td>The following information has been entered into your contact form:		<HR width=60% size=4><P></P><table><tr><td>Email:</td><td>#trim(arguments.EmailFrom)#</td></tr><tr><td>Name:</td><td>#arguments.ContactName#</td></tr><tr><td>Telephone:</td> <td>#arguments.Telephone#</td></tr><tr><td>E-Mail Address:</td> <td>#arguments.EmailFrom#</td></tr><tr><td>How You Can Help:</td><td>#arguments.Comments#</td></tr></td></tr></table></td></tr></table>">
		<cfset EmailServer=#MailServer#>
		<cfset EmailTo="#WebEmail#">
		<cfset Emailbcc="jamie@kotw.net">
		<cfset EmailFrom="#webEmail">
		<cfset EmailSubject="#arguments.EmailSubject#">
		
		<cfinvoke method="SendTheMail" returnvariable="success">
			<cfinvokeargument name="EmailTo" value="#EmailTo#">
			<cfinvokeargument name="EmailFrom" value="#EmailFrom#">
			<cfinvokeargument name="EmailBCC" value="#EmailBCC#">
			<cfinvokeargument name="EmailSubject" value="#EmailSubject#">
			<cfinvokeargument name="EmailBody" value="#EmailBody#">
			<cfinvokeargument name="EmailServer" value="#EmailServer#">
		</cfinvoke>
		<cfreturn #success#>
	</cffunction>
</cfcomponent>