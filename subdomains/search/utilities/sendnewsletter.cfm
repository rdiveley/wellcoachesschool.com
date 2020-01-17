<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllMailingLists">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="MailingLists">
</cfinvoke>

<cfif isdefined('form.sendit')>
<cfloop list="#form.listname#" index="TableName">
	
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="GetRecords">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="#TableName#">
	</cfinvoke>
	<cfif #getNewsLetter.ReturnEmailAddress# neq "none">
		<cfif #TableName# is "affiliates">
			<cfmail to="#email#" from="#GetNewsLetter.ReturnEmailAddress#" subject="#getNewsLetter.newslettername#"  type="html" query="GetRecords" server="#application.mailserver#">
				<Cfif #getNewsletter.NLHeader# neq "none">#GetNewsLetter.NLHeader#</Cfif>
				
				<Cfset tContent7=#getNewsletter.NLbody#>
				<cfset tPos=findnocase("ScriptIs",#tContent7#)>
				<cfif tPos gt 0>
					<cfset tLen = len(trim(#tContent7#))>
					<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
					<cfif #tpos# is 2>
						<cfset FirstHalf=''>
						<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
						<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfif lpos neq tlen>
							<cfset SecondHalf=#tContent7#>
						<cfelse>
							<cfset SecondHalf=''>
						</cfif>
					<cfelse>
						<cfset scriptLen=lPos - tPos >
						<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
						<cfoutput>#FirstHalf#</cfoutput>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
					</cfif>
					<cfif #SecondHalf# neq ''>
						<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
						<cfif tPos gt 0>
							<cfset tLen = len(trim(#SecondHalf#))>
							<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
							<cfif #tpos# is 2>
								<cfset FirstHalf=''>
								<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
								<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfif lpos neq tlen>
									<cfset ThirdHalf=#SecondHalf#>
								<cfelse>
									<cfset ThirdHalf=''>
								</cfif>
								<cfoutput>#ThirdHalf#</cfoutput>
							<cfelse>
								<cfset scriptLen=lPos - tPos >
								<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
								<cfoutput>#FirstHalf#</cfoutput>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
								<cfoutput>#ThirdHalf#</cfoutput>
							</cfif>
						<cfelse>
							<cfoutput>#SecondHalf#</cfoutput>
						</cfif>
					</cfif>
				<cfelse>
					<cfoutput>#tContent7#</cfoutput>
				</cfif>
				
				<cfif #getnewsletter.nlfooter# neq "none">#GetNewsLetter.NLFooter#</cfif>
				
			</cfmail>
		<cfelseif #TableName# is "customeremail">
			<cfinvoke component="#Application.WebSitePath#.utilities.customers" 
				method="getAllCustomer" returnvariable="GetRecords">
			</cfinvoke>
			<cfmail to="#Emailaddress#" from="#GetNewsLetter.ReturnEmailAddress#" subject="#getNewsLetter.newslettername#" type="html" query="GetRecords" server="#application.mailserver#">
				<Cfif #getNewsletter.NLHeader# neq "none">#GetNewsLetter.NLHeader#</Cfif>
				
				<Cfset tContent7=#getNewsletter.NLbody#>
				<cfset tPos=findnocase("ScriptIs",#tContent7#)>
				<cfif tPos gt 0>
					<cfset tLen = len(trim(#tContent7#))>
					<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
					<cfif #tpos# is 2>
						<cfset FirstHalf=''>
						<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
						<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfif lpos neq tlen>
							<cfset SecondHalf=#tContent7#>
						<cfelse>
							<cfset SecondHalf=''>
						</cfif>
					<cfelse>
						<cfset scriptLen=lPos - tPos >
						<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
						<cfoutput>#FirstHalf#</cfoutput>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
					</cfif>
					<cfif #SecondHalf# neq ''>
						<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
						<cfif tPos gt 0>
							<cfset tLen = len(trim(#SecondHalf#))>
							<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
							<cfif #tpos# is 2>
								<cfset FirstHalf=''>
								<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
								<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfif lpos neq tlen>
									<cfset ThirdHalf=#SecondHalf#>
								<cfelse>
									<cfset ThirdHalf=''>
								</cfif>
								<cfoutput>#ThirdHalf#</cfoutput>
							<cfelse>
								<cfset scriptLen=lPos - tPos >
								<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
								<cfoutput>#FirstHalf#</cfoutput>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
								<cfoutput>#ThirdHalf#</cfoutput>
							</cfif>
						<cfelse>
							<cfoutput>#SecondHalf#</cfoutput>
						</cfif>
					</cfif>
				<cfelse>
					<cfoutput>#tContent7#</cfoutput>
				</cfif>
				
				<cfif #getnewsletter.nlfooter# neq "none">#GetNewsLetter.NLFooter#</cfif>
			</cfmail>
		<cfelseif #Tablename# is "forumusers">
			<cfmail to="#Email#" from="#GetNewsLetter.ReturnEmailAddress#" subject="#getNewsLetter.newslettername#" type="html" query="GetRecords" server="#application.mailserver#">
				<Cfif #getNewsletter.NLHeader# neq "none">#GetNewsLetter.NLHeader#</Cfif>
				
				<Cfset tContent7=#getNewsletter.NLbody#>
				<cfset tPos=findnocase("ScriptIs",#tContent7#)>
				<cfif tPos gt 0>
					<cfset tLen = len(trim(#tContent7#))>
					<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
					<cfif #tpos# is 2>
						<cfset FirstHalf=''>
						<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
						<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfif lpos neq tlen>
							<cfset SecondHalf=#tContent7#>
						<cfelse>
							<cfset SecondHalf=''>
						</cfif>
					<cfelse>
						<cfset scriptLen=lPos - tPos >
						<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
						<cfoutput>#FirstHalf#</cfoutput>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
					</cfif>
					<cfif #SecondHalf# neq ''>
						<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
						<cfif tPos gt 0>
							<cfset tLen = len(trim(#SecondHalf#))>
							<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
							<cfif #tpos# is 2>
								<cfset FirstHalf=''>
								<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
								<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfif lpos neq tlen>
									<cfset ThirdHalf=#SecondHalf#>
								<cfelse>
									<cfset ThirdHalf=''>
								</cfif>
								<cfoutput>#ThirdHalf#</cfoutput>
							<cfelse>
								<cfset scriptLen=lPos - tPos >
								<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
								<cfoutput>#FirstHalf#</cfoutput>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
								<cfoutput>#ThirdHalf#</cfoutput>
							</cfif>
						<cfelse>
							<cfoutput>#SecondHalf#</cfoutput>
						</cfif>
					</cfif>
				<cfelse>
					<cfoutput>#tContent7#</cfoutput>
				</cfif>
				
				<cfif #getnewsletter.nlfooter# neq "none">#GetNewsLetter.NLFooter#</cfif>
			</cfmail>
		<cfelse>
			<cfif #getNewsLetter.ReturnEmailAddress# is "none"><cfset thisEmail=#application.email#><cfelse>
			<cfset thisEmail=#application.email#></cfif>
			<cfmail to="#emailaddress#" from="#thisEmail#" subject="#getNewsLetter.newslettername#" type="html" query="GetRecords" server="#application.mailserver#">
				
				<Cfif #getNewsletter.NLHeader# neq "none">#GetNewsLetter.NLHeader#</Cfif>
				
				<Cfset tContent7=#getNewsletter.NLbody#>
				<cfset tPos=findnocase("ScriptIs",#tContent7#)>
				<cfif tPos gt 0>
					<cfset tLen = len(trim(#tContent7#))>
					<cfset lPos=findnocase("]",#tContent7#,#tPos#)>
					<cfif #tpos# is 2>
						<cfset FirstHalf=''>
						<cfset FirstScript=left(#tContent7#,#lPos# - 1)>
						<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfif lpos neq tlen>
							<cfset SecondHalf=#tContent7#>
						<cfelse>
							<cfset SecondHalf=''>
						</cfif>
					<cfelse>
						<cfset scriptLen=lPos - tPos >
						<cfset FirstScript=mid(#tContent7#,#tPos# + 9,#scriptLen# - 9)>
						<cfset tContent7=replacenocase(#tContent7#,"[ScriptIs=#firstScript#]","")>
						<cfset FirstHalf = left(#tContent7#,#tPos# - 2)>
						<cfoutput>#FirstHalf#</cfoutput>
						<cfinclude template="../scripts/#FirstScript#.cfm">
						<cfset SecondHalf=replacenocase(#tContent7#,#firsthalf#,"")>
					</cfif>
					<cfif #SecondHalf# neq ''>
						<cfset tPos=findnocase("ScriptIs",#SecondHalf#)>
						<cfif tPos gt 0>
							<cfset tLen = len(trim(#SecondHalf#))>
							<cfset lPos=findnocase("]",#SecondHalf#,#tPos#)>
							<cfif #tpos# is 2>
								<cfset FirstHalf=''>
								<cfset FirstScript=left(#SecondHalf#,#lPos# - 1)>
								<cfset FirstScript=replacenocase(#FirstScript#,"[ScriptIs=","")>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfif lpos neq tlen>
									<cfset ThirdHalf=#SecondHalf#>
								<cfelse>
									<cfset ThirdHalf=''>
								</cfif>
								<cfoutput>#ThirdHalf#</cfoutput>
							<cfelse>
								<cfset scriptLen=lPos - tPos >
								<cfset FirstScript=mid(#SecondHalf#,#tPos# + 9,#scriptLen# - 9)>
								<cfset SecondHalf=replacenocase(#SecondHalf#,"[ScriptIs=#firstScript#]","")>
								<cfset FirstHalf = left(#SecondHalf#,#tPos# - 2)>
								<cfoutput>#FirstHalf#</cfoutput>
								<cfinclude template="../scripts/#FirstScript#.cfm">
								<cfset ThirdHalf=replacenocase(#SecondHalf#,#firsthalf#,"")>
								<cfoutput>#ThirdHalf#</cfoutput>
							</cfif>
						<cfelse>
							<cfoutput>#SecondHalf#</cfoutput>
						</cfif>
					</cfif>
				<cfelse>
					<cfoutput>#tContent7#</cfoutput>
				</cfif>
				
				<cfif #getnewsletter.nlfooter# neq "none">#GetNewsLetter.NLFooter#</cfif>
				<!---</cfoutput>  --->
			</cfmail>
		</cfif>
		
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="newsletters">
			<cfinvokeargument name="XMLFields" value="DateCreated,NewsletterName,NLHeader,DateLastSent,NLBody,newslettersentTo,NLFooter,ReturnEmailAddress,ReturnURL">
			<cfinvokeargument name="XMLFieldData" value="#GetNewsLetter.DateCreated#,#GetNewsLetter.NewsletterName#,#GetNewsLetter.NLHeader#,#dateformat(now(),'mm/dd/yyyy')#,#GetNewsLetter.NLBody#,#tablename#,#GetNewsLetter.NLFooter#,#GetNewsLetter.ReturnEmailAddress#,#GetNewsLetter.ReturnURL#">
			<cfinvokeargument name="XMLIDField" value="NewsletterID">
			<cfinvokeargument name="XMLIDValue" value="#GetNewsLetter.NewsletterID#">
		</cfinvoke>
	<Cfelse>
		<cfset getrecords.recordcount=0>
	</cfif>
</cfloop>

<cfif #Getrecords.recordcount# is 0>
	<p><font color="red"><strong>Your newsletter was not sent out due to no return address</strong></font></p>
<cfelse>
	<p><font color="red"><strong>Your newsletter has been sent to <cfoutput>#getrecords.recordcount#</cfoutput> people</strong></font></p>
</cfif>
<cfelse>
<cfoutput><form name="senditform" action="adminheader.cfm" method="post">
	<input type="hidden" name="NewsletterAction" value="Send">
	<input type="hidden" name="action" value="newsletterArchives">
	<input type="hidden" name="newsletterID" value="#newsletterID#">
	Select list(s) to send this newsletter to:<br>
	<select name="listname" size="5" multiple>
		<option value="Memberemail">Members</option>
		<option value="customeremail">Customers</option>
		<option value="affiliates">Affiliates</option>
		<option value="forumusers">Forum Users</option>
		<option value="GBEntries">Guest Book Users</option>
		<cfloop query="AllMailingLists">
			<option value="#ListName#">#MLDescription#</option>
		</cfloop>
	</select>
	<br>
	<input type="submit" name="SendIT" value="Send It">
</form></cfoutput>
</cfif>