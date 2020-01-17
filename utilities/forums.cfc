<cfcomponent>
	<cffunction name="getForumPassword" access="remote" returntype="string">
		<cfargument name="ForumID" type="string" required="yes">
		<cfinclude template="vars.cfm">
		<cfquery name="forumPword" datasource="#request.ds#" password="#session.DSNPword#" username="#session.DSNuName#">
			select * from forums where forumID=#arguments.forumID#
		</cfquery>
		<cfset myResult=#forumPword.forumpassword#>
		<cfreturn myResult>
	</cffunction>
	
	<cffunction name="deletepost" access="remote" output="true">

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "Delete message from #GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		<cfheader name="Title" value="#PageTitle#">

		<!--- Page Content Starts Here --->
		
		<center>
		<br>	

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		
		<br>
		</center>
		
		<cfparam name="error" default="">
		
		<cfif IsDefined("Form.DeleteThread")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getAdmin" returnvariable="getAdmin">
			</cfinvoke>
		
			<cfif #GetAdmin.RecordCount# IS NOT '0' AND #GetAdmin.AccessLevel#  GT 1>
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="deletepost">
				</cfinvoke>
				
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">'>
				<cfoutput><center>
				<font face="#request.fontface#" size="#evaluate(request.fontsize+1)#" color="#request.text#">
				<b><br><br><br>	<br>The message has been deleted.</b><br><br><br><br>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				
				<cfif NewDate.RecordCount IS 0>
					<a href="viewtopics.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to the discussion group</a>
				<cfelse>
					<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to the discussion</a>
				</cfif>
				
				<br><br><br><br><br><br><br>
				</cfoutput>
				
			<cfelse>
			
				<cfset error = "Sorry, that is incorrect. Please Try Again.">
				
			</cfif>
		</cfif>
		
		
			<!--- Default page --->
			<cfoutput>
			<center>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><br>
			<cfif len(error)><br>#Error#</cfif>
			<br><br>Individual messages can only be deleted by <br>
			Administrators and Moderators.</b></font>
			
			<form action="index.cfm?page=#url.page#&forumaction=deletepost&Forum=#URL.Forum#&Topic=#URL.Topic#&Message=#URL.Message#" method="post">
			<input name="MessageID" value="#URL.Message#" type="hidden">
			<input name="TopicID" value="#URL.Topic#" type="hidden">
			<table border=0 cellspacing=1 cellpadding=1>
			  <tr bgcolor="#request.catcolor#">
				<td>
					<table border=0 cellpadding=5 cellspacing=0>
					  <tr>
						<td bgcolor="#request.column2#" colspan="2">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<b><center>Administrator/Moderator Sign In:</center></b>
						</td>
					  </tr>
					  <tr>
						<td bgcolor="#request.column1#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							Username:
						</td>
						<td bgcolor="#request.column1#">
							<input type="text" name="Username" size="20" <cfif IsDefined("Cookie.Username")>value="#decrypt(Cookie.Username, request.key)#"</cfif> >
						</td>
					  </tr>
					  <tr>
						<td bgcolor="#request.column1#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							Password:
						</td>
						<td bgcolor="#request.column1#">
							<input type="Password" name="Password" size="20" <cfif IsDefined("Cookie.Password")>value="#decrypt(Cookie.Password, request.key)#"</cfif>>
						</td>
					  </tr>
					  <tr>
						<td bgcolor="#request.column1#" colspan="2">
							<center><input type="submit" name="DeleteThread" value="   Continue...  " onClick="return confirm('Are you sure you want to delete this message?')"></center>
						</td>
					  </tr>
					</table>
				</td>
			  </tr>
			</table><br>
			</form>
			</cfoutput>
			<br><br><br>
	</cffunction>
	
	<cffunction name="deletethread" access="remote" output="true">
		
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "Delete #GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<!--- Page Content Starts Here --->
		
		<center>
		<br>	

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		</center>
		
		<cfparam name="error" default="">
		
		<cfif IsDefined("Form.DeleteThread")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getAdmin" returnvariable="getAdmin">
			</cfinvoke>
			
			<cfif #GetAdmin.RecordCount# IS NOT '0' AND #GetAdmin.AccessLevel#  GT 1>		
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="deletepost">
				</cfinvoke>	
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewtopics.cfm?Forum=#URL.Forum#">'>
				<cfoutput><center>
				<font face="#request.fontface#" size="#evaluate(request.fontsize+1)#" color="#request.text#">
				<b><br><br><br>	<br>The thread has been deleted.</b><br><br><br><br>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<a href="viewtopics.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to Forums</a><br><br><br><br><br><br><br>
				</cfoutput>
			
			<cfelse>
			
				<cfset error ="Sorry, that is incorrect. Please Try Again.">		
		
			</cfif>
		
		</cfif>
		
			<cfoutput><center>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>
			<br><br>
			<cfif len(error)>#Error#<br></cfif>
			<br>Threads can only be deleted by <br>
			Administrators and Moderators.</b></font>
			<form action="index.cfm?page=#url.page#&forumaction=deletethread&Forum=#URL.Forum#&Topic=#URL.Topic#" method="post">
			<input name="topicID" value="#URL.Topic#" type="hidden">
			<table border=0 cellspacing=1 cellpadding=1>
			  <tr bgcolor="#request.catcolor#">
				<td>
				<table border=0 cellpadding=5 cellspacing=0>
				  <tr>
					<td bgcolor="#request.column2#" colspan="2">
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<b><center>Administrator/Moderator Sign In:</center></b>
					</td>
				  </tr>
				  <tr>
					<td bgcolor="#request.column1#">
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					Username:
					</td>
					<td bgcolor="#request.column1#">
					<input type="text" name="Username" size="20" <cfif IsDefined("Cookie.Username")>value="#decrypt(Cookie.Username, request.key)#"</cfif> >
					</td>
				  </tr>
				  <tr> 
					<td bgcolor="#request.column1#">
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					Password:
					</td>
					<td bgcolor="#request.column1#">
					<input type="Password" name="Password" size="20" <cfif IsDefined("Cookie.Password")>value="#decrypt(Cookie.Password, request.key)#"</cfif>>
					</td>
				  </tr>
				  <tr>
					<td bgcolor="#request.column1#" colspan="2">
					<center><input type="submit" name="DeleteThread" value="   Continue...  " onClick="return confirm('Are you sure you want to delete this discussion?')">
					</center>
					</td>
				  </tr>
				</table>
				</td>
			  </tr>
			</table>
			</form>
			</cfoutput>
			<br><br><br><br>
	</cffunction>
	
	<cffunction name="editmessage" access="remote" output="true">

		<cfset columns = "f.forumname, c.category, f.allowhtml, f.maxpollanswers">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
			<cfinvokeargument name="columns" value="#columns#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "Edit Message">
		<cfset PageSection = "Messages">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		<!--- Page Content Starts Here --->
		
		<!--- New PsuedoHTML Code Javascript buttons--->
		<script language="JavaScript">
			<CFINCLUDE template="files/pseudobuttons.js">
		</script>
		
		<center>
		<br>	
		
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>

		<br>
		</center>
		
		<cfif Session.MemberLoggedIn IS NOT "Y">
			
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="You have not logged in yet. <br><br> You must be a <a href='register.cfm'>registered member</a> to post messages.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
		<cfelseif IsDefined("Form.UpdateMessage")>
		
			<cfif #Len(Form.MessageCopy)#>
				
				<cfif form.ispollmessage eq 1>
					<cfset MessageCopy = "#Form.MessageCopy#"&chr(10)&"This message was edited by #session.username# on #DateFormat(NOW(),'m-d-yy')# @ #TimeFormat(NOW(),'h:mm tt')#">
				<cfelse>
					<cfset MessageCopy = "#Form.MessageCopy#"&chr(10)&chr(10)&"This message was edited by #session.username# on #DateFormat(NOW(),'m-d-yy')# @ #TimeFormat(NOW(),'h:mm tt')#">
				</cfif>
				<cfset MessageCopy = "#Form.MessageCopy#"&chr(10)&chr(10)&"This message was edited by #session.username# on #DateFormat(NOW(),'m-d-yy')# @ #TimeFormat(NOW(),'h:mm tt')#">
					
				
					
				<!--- bad word filter --->
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay"
					method="badwordfilter" returnvariable="MessageCopy">
					<cfinvokeargument name="Message" value="#MessageCopy#">
				</cfinvoke>

				<cfinvoke component="#application.websitepath#.utilities.forumqueries"
					method="updatemessage">
					<cfinvokeargument name="Message" value="#MessageCopy#">
				</cfinvoke>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="1;URL=viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">'>
				<cfoutput><center>
				<font face="#request.fontface#" size="#evaluate(request.fontsize+1)#" color="#request.text#">
				<b><br>	<br>The message has been updated.</b><br><br>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to Discussion.</a><br><br><br><br><br>
				</cfoutput>
			
			</cfif>
		
		<cfelseif Session.MemberLoggedIn IS "Y">	
				
			<cfinvoke component="#application.websitepath#.utilities.forumqueries"
				method="getmessage" returnvariable="getmessage">
				<cfinvokeargument name="messageID" value="#url.message#">
				<cfif IsDefined("getposts.topicid")>
					<cfinvokeargument name="topicid" value="#Getposts.TopicID#">
				</cfif>
			</cfinvoke>
			<cfif GetMessage.RecordCount eq 1>
				<cfoutput>
				<form action="index.cfm?page=#url.page#&forumaction=editmessage&Forum=#URL.Forum#&Topic=#URL.Topic#&MessageID=#URL.Message#" name="PostTopic" method="post">
				<input type="hidden" name="MessageID" value="#URL.Message#">
				<input type="hidden" name="email" value="#getmessage.email#">
				<input type="hidden" name="topicid" value="#url.topic#">	
				<input type="hidden" name="ispollmessage" value="#getmessage.ispollmessage#">
				
				<center>
				<table  Border="0" cellpadding="0" cellspacing="0">
				  <tr bgcolor="#request.column2#">
					<td>
						<table width="100%" Border="0" cellpadding="2" cellspacing="1">
						  <tr>
							<td bgcolor="#request.catcolor#" colspan=2>
							<center><font face="#request.fontface#"  color="#request.cattextcolor#" size="#request.fontsize#"><b>Edit <cfif getmessage.ispollmessage eq 1>Poll<cfelse>Reply</cfif></b></font></center>
							</td>
						  </tr>
						  <tr bgcolor="#request.bgcolor#">
							<td><p align="Right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><cfif getmessage.ispollmessage eq 1>Poll<cfelse>Topic</cfif> Title:</b></font>
							</td>
							<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#HTMLEditFormat(GetTopic.TopicTitle)#</b></font>
							</td>
						  </tr>
						  <tr bgcolor="#request.bgcolor#">
							<td valign="top"><p align="Right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><cfif getmessage.ispollmessage eq 1>Question:<cfelse>Message:</cfif></b></font><br></p>
							<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
							
							<cfif GetForum2.AllowHTML IS 'Y'>
								<li> HTML is Allowed
							<cfelse>
								<li> HTML is not Allowed
							</cfif>
							
							<!--- NEW - added 11/7/99 --->
							<br><li> PseudoHTML is On.<br><br>
							<!--- /NEW --->	
							
							</td>
							<td>
							<!--- Added code to remove "This message was edited by... " when editing again --->
							<cfset Count=#find("This message was edited by","#GetMessage.MessageCopy#")#>
							<textarea name="MessageCopy" cols="55" rows="10" wrap="PHYSICAL"><cfif Count eq 0>#trim(GetMessage.MessageCopy)#<cfelse>#trim(left(GetMessage.MessageCopy,Count - 1))#</cfif></textarea>
							<br>
							<!--- PseudoHTML Buttons - added Apr 7 --->
							</cfoutput>
							<cfinvoke component="#application.websitepath#.utilities.forumdisplay"
								method="pseudobuttons">
							</cfinvoke>
							<cfoutput>
							
							<!--- EDIT POLL ANSWERS--->
							<cfif getmessage.ispollmessage eq 1>
							
							</td>
						</tr>
						<tr>
							<td valign="top" align="Right" bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Answers:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br>
							<cfinvoke component="#application.websitepath#.utilities.forumqueries"
								method="getpollanswers" returnvariable="getpollanswers">
								<cfinvokeargument name="topic" value="#url.Topic#">
							</cfinvoke>
							<input type="hidden" name="lstpollanswerid" value="#valuelist(getpollanswers.pollanswerid, ',')#">
							
							<cfset i = 0>
							<cfloop query="getpollanswers" startrow="1" endrow="#getpollanswers.recordcount#">
							<cfset i = i +1>
							#i#. <input type="text" name="pollanswer_#i#" size="25" maxlength="30" value="#getpollanswers.pollanswer#"><br>
							</cfloop>
							<cfset i = i +1>
							<cfloop index="i" from="#i#" to="#getforum2.maxpollanswers#">					
							 #i# <input type="text" name="pollanswer_#i#" size="25" maxlength="30"><br>
							<cfset i = i +1>
							</cfloop>
								
							</cfif>
							
							
							<br><br><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<cfif getmessage.ispollmessage eq 1>
							<input type="checkbox" name="ispublicpoll" value="1" <cfif getmessage.ispollmessage eq 1> checked</cfif>> 					
							Allow non-members to vote.<br>
							</cfif>
							<cfif Session.accesslevel gte 3>				
							<input type="checkbox" name="stayontop" value="1" <cfif gettopic.stayontop eq 1> checked</cfif>>
							This topic should stay near the top.<br>				
							</cfif>
							<input type="Checkbox" name="NotifyAuthor" Value="Y" <cfif LEN(GetMessage.UserEmail)>checked </cfif> >
							Notify me when someone replies.</font>
							</td>
						  </tr>
						  <tr bgcolor="#request.bgcolor#">
							<td colspan=2>
							<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<br><br><input type="submit" name="UpdateMessage" value="   Update Message   ">
							</font></center>
							</td>				  
						  </tr>
						</table>
					</td>
				  </tr>
				</table>
				</form></cfoutput>
			
			<cfelse>
				
				<cfoutput>
				<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><br><b>Access Denied !</b><br><br>Only the original author or an administrator/moderator can edit this post.<br><br><br>
				</font></center>
				</cfoutput>
				</cfif>
		
		</cfif>	
		</center>

	</cffunction>
	
	<cffunction name="emailinfo" access="remote" output="true">

		<cfset PageTitle = "Forgotten Username/Password.">
		<cfset PageSection = "Membership">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		
		<!--- Page Content Starts Here --->	
		<br>
		<cfparam name="error" default="">
		
		<cfif IsDefined("Form.EmailAddress")>   
		
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="checkemail" returnvariable="checkemail">
			</cfinvoke>
			<cfif #CheckEmail.RecordCount# IS 0>
			   
				<cfset error =" <b>Oops, that email address doesn't exist.</b><br>Please enter the email address that you registered with.<br>">
				
				
			<cfelse>
			
		<cfmail to="#Form.EmailAddress#" From="#request.forumemail#" Subject="Requested Membership Info from #request.forumtitle#" Server="#application.mailserver#" port="#application.mailport#"
		>Here is the information you requested. 
		
			Username: #CheckEmail.UserName#
			Password: #CheckEmail.PassWord#
			   Email: #CheckEmail.email#
			
		Visit #request.forumtitle# at    
		#request.forumurl#    
		
		Hosted by #request.hometitle#
		#request.homeurl#
		</cfmail>
			
				<cfoutput><center> <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><b>Your information has been sent.</b><br><br>
				You should be receiving your username and password within the hour.<br>
				If you haven't received it within 24 hours, please contact us.</center></cfoutput>
				  
			</cfif>
		
		</cfif>    
			<cfoutput><center><br>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<cfif len(error)>
				#error#
			<cfelse>
			<b>Oops, did you forget your password?</b><br><br>
			No problem, we can send it to your registered email address.<br>
			</cfif><br>
			<form action="index.cfm?page=#url.page#&forumaction=emailinfo" method="post">
			<table border=0 cellspacing=1 cellpadding=1>
			  <tr bgcolor="#request.catcolor#">
				<td>
					<table border=0 cellpadding=5 cellspacing=0>
					  <tr>
						<td bgcolor="#request.column2#" colspan="2">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<b><center>Enter your email address:</center></b>
						</td>
					  </tr>
					  <tr>
						<td bgcolor="#request.column1#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						Email:
						</td>
						<td bgcolor="#request.column1#">
						<input type="text" name="EmailAddress" size="20"  <cfif IsDefined("Cookie.Email")>value="#Cookie.Email#"</cfif> >	
						</td>
					  </tr>
					  <tr>
						<td bgcolor="#request.column1#" colspan="2">
						<center><input type="submit" name="SendInfo" value=" Send Username/Password ">
						<br></center>
						</td>
					  </tr>
					</table>
				</td>
			  </tr>
			</table>
			<br></form>
			</cfoutput>    
			
		
		<br><br>
	</cffunction>
	
	<cffunction name="emailthread" access="remote" output="true">

		<cfparam name="error" default="">
		<cfif IsDefined("Form.Link")>
			<cfif #Form.ToEmail# IS '' OR #Form.ToName# IS '' OR #Form.FromEmail# IS '' OR #Form.FromName# IS ''>
				
				
				<cfset error = "ALL FIELDS ARE REQUIRED">
			<cfelse>
				
		<cfmail to="#Form.ToEmail#" From="#Form.FromEmail#" Subject="Interesting Discussion at #request.forumtitle#" Server="#request.mailserver#" port="#request.mailport#"
		>Hello #Form.ToName#, 
		#Form.FromName# has sent you the following comments:
		
		#Form.Comments#
		
		#Form.Link#
		
		Brought to you by #request.forumtitle#.
		#request.forumurl#
		</cfmail>
				
				<cfoutput>
				<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>The Thread has been sent to #Form.ToName#.</b><br><br>
				<form action=post><input type="button" value="  Close this Window" ONCLICK="window.close()"></form></center>		
				</cfoutput>
				<cfabort>
			</cfif>
		
		</cfif>
			<cfoutput>
			<form action="index.cfm?page=#url.page#&forumaction=emailthread" method="Post">
			<cfif IsDefined("form.link")>
			<input type="hidden" name="Link" value="#form.link#">
			<cfelse>
			<input type="hidden" name="Link" value="#request.forumurl#/viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">
			</cfif>
			
			<center>
			
			<table width="100%" Border="0" cellpadding="1" cellspacing="0">
			<tr bgcolor="#request.catcolor#">
				<td>
				  <table width="100%" Border="0" cellpadding="1" cellspacing="0">
					<tr bgcolor="#request.catcolor#">
					  <td colspan="2"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" >
					  <b><center>
					  <cfif Len(error)>#Error# <br><br></cfif>
					  Send This Thread to a Friend.</center></b>
					  </td>
					</tr>
					<tr bgcolor="#request.column1#">
					  <td align="right"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Friend's Name:
					  </td>
					  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><input type="text" name="ToName" size="20" maxlength="30">
					  </td>
					</tr>
					<tr bgcolor="#request.column2#">
					  <td align="right"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Friend's Email:
					  </td>
					  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><input type="text" name="ToEmail" size="20" maxlength="50">
					  </td>
					</tr>
					<tr bgcolor="#request.column1#">
					  <td align="right"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Your Name:
					  </td>
					  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><input type="text" name="FromName" size="20" maxlength="30">
					  </td>
					</tr>
					<tr bgcolor="#request.column2#">
					  <td align="right"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Your Email:
					  </td>
					  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><input type="text" name="FromEmail" size="20" maxlength="50" <cfif IsDefined("Cookie.Email")>value="#Cookie.Email#"</cfif>>
					  </td>
					</tr>
					<tr bgcolor="#request.column1#">
					  <td colspan=2><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  <center>Additional Comments:<br>
					  <textarea name="Comments" cols="30" rows="3" wrap="PHYSICAL" col="YES">I thought you might be interested in this thread I found at #request.forumtitle#.</textarea></center>
					  </td>
					</tr>
					<tr bgcolor="#request.column1#">
					  <td colspan=2>
					  <center><input type="submit" Value=" Send it Now "></center>	
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
			</center></form>
			</cfoutput>
	</cffunction>
	
	<cffunction name="icqmessenger" access="remote" output="true">
		<cfoutput>
		<br><br>
		<center>
		<form action="http://wwp.icq.com/scripts/WWPMsg.dll" method="post">
		<center>
		<table border="2" cellpadding="1" cellspacing="1"><tr><td>
		<table cellpadding="0" cellspacing="0" border="0" bgcolor="white">
		<tr>
		<td align="center" nowrap colspan="2" bgcolor="##0000a0">
		<font size="-1" face="arial" color="white"><b>The ICQ Online-Message Panel</b></font></td>
		</tr>
		<tr>
		<td align="center"><font size="2" face="verdana" color="black"><b>Sender Name</b> (optional):</font><br><input type="text" name="from" value="#session.username#" size=15 maxlength=40 onFocus="this.select()"></td>
		<td align="center"><font size="2" face="verdana" color="black"><b>Sender EMail</b> (optional):</font><br><input type="text" name="fromemail" value="#session.email#" size=20 maxlength=40 onFocus="this.select()">
		<input type="hidden" name="subject" value="From Your Web Page"></td>
		</tr>
		<tr>
		<td align="center" colspan="2"><font size="-2" face="ms sans serif" color="black">Message:</font><br>
		<textarea name="body" rows="8" cols="35" wrap="Virtual"></textarea><br></td>
		</tr>
		<tr>
		<td colspan="2" align="center">
		<input type="hidden" name="to" value="#url.icq#">
		<input type="submit" name="Send" value="Send Message">&nbsp;&nbsp;
		<input type="reset" value="Clear">
		</td>
		</tr>
		</table>
		</td></tr></table>
		<font face="verdana" size="-2"><a href="/public/panels/messagepanel/links/messagepanel.html">This site is powered by the ICQ Online-Message Panel</a> <br>
		&copy; 1999 ICQ Inc. All Rights Reserved.<br>Use of the ICQ Online-Message Panel is <br>subject to the 
		<a href="http://public.icq.com/public/panels/webcast/links/legal.html">Terms of Service</font></a></form>
		</center>
		
		<form action=post><input type="button" value="  Close this Window" ONCLICK="window.close()"></form></center>
				
		
		</center>
		</cfoutput>
	</cffunction>
	
	<cffunction name="inbox" access="remote" output="true">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<!--- HHHHHHHHHHHH  CHECK IF MEMBER IS LOGGED IN HHHHHHHHHHHHHHHHH --->
		<cfif Session.MemberLoggedIn IS NOT "Y">
			<cfoutput>
			<center>	
			
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="<br> Need to <a href='register.cfm'>register</a>?<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		<cfparam name="request.folder" default="inbox">
		<cfif isdefined('url.snt')>
			<cfset request.folder = "sent">
		<cfelseif isdefined('url.trsh')>
			<cfset request.folder = "trash">
		</cfif>
		
		<!--- HHHHHHH    DELETE MESSAGES      HHHHHHHHHHHHH  --->
		<cfif isdefined('form.privatemessageid') OR isdefined('url.dlt')>

			<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="deletepm">
			</cfinvoke>
		</cfif>	
		
		<script language="javascript">					
			function PopWin(url,x,y) {
					var attributes = "toolbar=no,scrollbars=yes,resizable=yes,width=" + x + ",height=" + y;
					msgWindow=window.open(url,"PopWin",attributes);
			}					
		</script>
		
		<cfoutput>
		<center>
		<br>	

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="#session.username#'s Inbox">
		</cfinvoke>
		<br>
		<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.catcolor#"><td>
			<table width="100%" Border="0" cellpadding="0" cellspacing="1">
				
				<tr>
					<td bgcolor="#request.catcolor#">&nbsp;</td>			
					<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#request.fontsize#"><b>Private Messages</b></font></td>
				</tr>
				</cfoutput>
				<cfif session.memenabledpm neq 1 or request.enablepm eq 0>
				<cfoutput>
				<tr>
					<td bgcolor="#request.column1#" colspan=5><br><br>
					<font face="#request.fontface#" Color="#request.text#" size="#request.fontsize#"><center><b>Private messaging is disabled <cfif request.enablepm eq 0> by the administrator.<cfelse>in your <a href="preferences.cfm">preferences</a>.</cfif></b></center><br><br><br></font>
					</td>
				</tr>
				</cfoutput>
				<cfelse>
				<cfoutput>
				<tr>
					<td bgcolor="#request.bgcolor#" width="75" nowrap valign="top">
					<font face="#request.fontface#" Color="#request.text#" size="#request.fontsize#"><br>
					<cfif request.folder eq "message" or request.folder eq "inbox"><img src="#request.imagedir#newfolder.gif"  border="0" align="absmiddle"> <a href="inbox.cfm"><b>Inbox</b></a><cfelse><img src="#request.imagedir#folder.gif"  border="0" align="absmiddle"> <a href="inbox.cfm">Inbox</a></cfif><br><br>
					<!--- &nbsp;&nbsp;<cfif request.folder eq "sent"><a href="inbox.cfm?snt=1"><b>SENT</b></a><cfelse> -- <a href="inbox.cfm?snt=1">Sent</a></cfif><br> --->
					<cfif request.folder eq "trash"><img src="#request.imagedir#newfolder.gif"  border="0" align="absmiddle"> <a href="inbox.cfm?trsh=1"><b>Trash</b></a><cfelse><img src="#request.imagedir#folder.gif"  border="0" align="absmiddle"> <a href="inbox.cfm?trsh=1">Trash</a></cfif><br>
					</font><br>
					
					<!--- Buddy list --->
					<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
						method="loggedin" returnvariable="loggedin">
					</cfinvoke>
					<cfset membersonline='#valuelist(loggedin.memberid)#'>
					
					<cfset request.list = "buddylist">
					<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
						method="list">
					</cfinvoke>
					<br><br>
					<cfset request.list = "ignorelist">
					<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
						method="list">
					</cfinvoke>
					
					
					</td>		
					<td bgcolor="#request.bgcolor#" width="100%" valign="top">
					</cfoutput>				
					
					<cfif isdefined('url.msg') and isnumeric(url.msg)>
						<!--- View private message --->
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="privatemsg">
						</cfinvoke>
					<cfelseif (isdefined('url.reply') and isnumeric(url.reply)) OR (isdefined('url.rid') and isnumeric(url.rid))>	
						<cfif isdefined('form.replymsgid')>
						<!--- insert reply message --->
							<cfinvoke component="#application.websitepath#.utilities.forumactions" 
								method="postpmreply">
							</cfinvoke>
						<cfelseif isdefined('form.recipientid')>
						<!--- insert new message --->
							<cfinvoke component="#application.websitepath#.utilities.forumactions" 
								method="postpm">
							</cfinvoke>
						<cfelse>
						<!--- Create new pm message --->
							<cfinvoke component="#application.websitepath#.utilities.forumactions" 
								method="postpm">
							</cfinvoke>		
						</cfif>	
					<cfelseif (isdefined('url.msg') AND NOT isnumeric(url.msg)) OR (isdefined('url.reply') AND NOT isnumberic(url.reply)) OR (isdefined('url.rid') and NOT isnumeric(url.rid))>			
						<cflocation url="inbox.cfm" addtoken="no">
								
					<cfelse>
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="inbox">
						</cfinvoke>
					</cfif>		
					</td>
				</tr>		
				</cfif>
				<cfif forum.enabletopicsubscriptions eq 1>
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="topicsubscriptions">
						</cfinvoke>
				</cfif>
				<tr><cfoutput>
					<td bgcolor="#request.catcolor#">&nbsp;</td>			
					<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#request.fontsize#"><b>&nbsp;</b></font></td>
				</tr></cfoutput>
			</table>
		</td></tr></table>		
					
		</center>


	</cffunction>
	
	<cffunction name="lockthread" access="remote" output="true">

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		<cfset PageTitle = "LOCKING #GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<center>
		<br>	

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		</center>
		
		<!--- Page Content Starts Here --->
		<cfparam name="error" default="">
		
		<cfif IsDefined("Form.LockThread")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getAdmin" returnvariable="getAdmin">
			</cfinvoke>
			<cfif #GetAdmin.RecordCount# IS NOT '0' AND #GetAdmin.AccessLevel#  GT 1>
				
				<cfset action="lock">
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="lockthread" returnvariable="lockthread">
					<cfinvokeargument name="action" value="lock">
				</cfinvoke>
				<cfoutput><center>
				<font face="#request.fontface#" size="#evaluate(request.fontsize+1)#" color="#request.text#">
				<b><br><br>The discussion has been locked successfully.</b><br><br>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to discussion.</a><br><br><br><br><br>
				</cfoutput>
				<cfabort>
				
			<cfelse>	
				<cfset Error = "Sorry, that is incorrect. Please Try Again.">
			</cfif>
		</cfif>
		
			<cfoutput><center><br><br>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>
			<cfif len(error)>#error#<br><br></cfif>
			Discussions can only be locked by <br>	Administrators and Moderators.</b></font>
			<form action="index.cfm?page=#url.page#&forumaction=lockthread&Forum=#URL.Forum#&Topic=#URL.Topic#" method="post">
			<table border=0 cellspacing=1 cellpadding=1>
			  <tr bgcolor="#request.catcolor#">
				<td>
				  <table border=0 cellpadding=5 cellspacing=0>
					<tr>
					  <td bgcolor="#request.column2#" colspan="2">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  <b><center>Administrator/Moderator Sign In:</center></b>
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Username:
					  </td>
					  <td bgcolor="#request.column1#">
					  <input type="text" name="Username" size="20" <cfif IsDefined("Cookie.Username")>value="#decrypt(Cookie.Username, request.key)#"</cfif> >
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Password:
					  </td>
					  <td bgcolor="#request.column1#">
					  <input type="Password" name="Password" size="20" <cfif IsDefined("Cookie.Password")>value="#decrypt(Cookie.Password, request.key)#"</cfif>>
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#" colspan="2">
					  <center><input type="submit" name="LockThread" value="   Continue...  "></center>
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table><br>
			</form>
			</cfoutput>

	</cffunction>
	
	<cffunction name="loggedin" access="remote" output="true">
		<!-- loggedin.cfm -->
		<cfset PageTitle = "Logged in Members">
		<cfset PageSection = "Login">

		<!--- Page Content Starts Here --->
		
		<center>
		<br>	

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="members currently logged in">
		</cfinvoke>
		<br>
		</center>
		
		<!--- WHOIS --- JAVASCRIPT POP UP WINDOW --->
		<script language="JavaScript">
		
		function launch(newURL, newName, newFeatures, orgName) {
		var remote = open(newURL, newName, newFeatures);
		if (remote.opener == null)
		  remote.opener = window;
		remote.opener.name = orgName;
		return remote;
		}
		
		function Whois(ID) {
		myRemote = launch("whois.cfm?MemID="+ID+"",
						  "myRemote",
						  "height=450,width=400,alwaysLowered=0,alwaysRaised=0,channelmode=0,dependent=0,directories=0,fullscreen=0,hotkeys=1,location=0,menubar=0,resizable=0,scrollbars=1,status=0,titlebar=1,toolbar=0,z-lock=0",
						  "myWindow");
		}				  
		</SCRIPT>	
			
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
						method="loggedin" returnvariable="loggedin">
					</cfinvoke>
		<Center>
		<cfif #Loggedin.RecordCount# IS 0>
			<cfoutput>
			<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.text#">
			<br><br><br><br><b>There are #Loggedin.RecordCount# members who have logged in within the last 15 minutes.</b><br><br><br><br><br>
			</cfoutput>
		<cfelse>
			<cfoutput>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<b>There <cfif #Loggedin.RecordCount# GT 1>are<cfelse>is</cfif> #Loggedin.RecordCount# member<cfif #Loggedin.RecordCount# GT 1>s</cfif> who <cfif #Loggedin.RecordCount# GT 1>have<cfelse>has</cfif> logged in within the last 15 minutes.</b><br><br>
			<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0">
			  <tr bgcolor="#request.catcolor#">
				<td>
				  <table width="100%" Border="0" cellpadding="2" cellspacing="1">
					<tr>
					  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Username</font></td>
					  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Member Type</font></td>
					  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Total Posts</center></font></td>
					  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Join Date</center></font></td>
					</tr>
					</cfoutput>	
					<cfloop query="Loggedin" startrow="1" endrow="#Loggedin.RecordCount#">
					<cfoutput>
					<tr bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#">
					  <td valign="top"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><a href="javascript:Whois(#Loggedin.MemberID#)"><b>#Loggedin.UserName#</b></a></td>
					  <td valign="top"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><cfif #Loggedin.AccessLevel# IS '5'>Administrator<cfelseif #Loggedin.AccessLevel# IS '3'>Moderator<cfelse>Member</cfif></font></td>
					  <td valign="top"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><center>#Loggedin.Posts#</center></font></td>        
					  <td valign="top"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><center>#dateformat(Loggedin.JoinDate, 'mmm. dd, yyyy')#</center></font></td>
					</tr>
					</cfoutput>
					</cfloop>		
				  </table>
				</td>
			  </tr>
			</table><br>		
			
		</cfif>
		
		</center>
	</cffunction>
	
	<cffunction name="login" access="remote" output="true">
		<!-- login.cfm -->
		<cfset PageTitle = "Member Login">
		<cfset PageSection = "Login">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		<!--- Page Content Starts Here --->
		
		<cfparam name="error" default="">
		
		<center><br>
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="login">
		</cfinvoke>
		<br></center>
		
		<cfif IsDefined("form.login")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="checkmember" returnvariable="checkmember">
			</cfinvoke>
			
			<cfif CheckMember.RecordCount GT '0' and checkmember.ActiveStatus IS 'A'>    
				
				<cfif IsDefined("Form.RememberMe")>
					<cfcookie name="MemberID" value="#CheckMember.MemberID#" expires="NEVER">
					<cfcookie name="Username" value="#encrypt(CheckMember.Username, request.key)#" expires="NEVER">
					<cfcookie name="Password" value="#encrypt(CheckMember.PassWord, request.key)#" expires="NEVER">
					<cfcookie name="Email" 	  value="#CheckMember.Email#" 	 expires="NEVER">
				<cfelse>
					<cfcookie name="MemberID" value="" expires="NOW">
					<cfcookie name="Username" value="" expires="NOW">
					<cfcookie name="Password" value="" expires="NOW">
					<cfcookie name="Email" 	  value="" expires="NOW">
				</cfif>
				
				<cfset Session.MemberLoggedIn = "Y">
				<cfset Session.MemberID = '#CheckMember.MemberID#'>
				<cfset session.fname = '#checkmember.fname#'>		
				<cfset Session.Username = '#CheckMember.Username#'>
				<cfset session.accesslevel = #checkmember.accesslevel#>
				<cfset session.email = '#checkmember.email#'>		
				<cfset session.memenabledpm = '#checkmember.enablepm#'>
				
				<cfif CheckMember.AccessLevel GTE 3>
					<cfset Session.AdminSignedIn = "Y">
				<cfelse>
					<cfset Session.AdminSignedIn = "N">
				</cfif>
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="lastlogin" returnvariable="lastlogin"></cfinvoke>
				
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="1;URL=#form.referrer#">'>
				<cfoutput>
				<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><br><b>Thank you for logging in.</b><br><br><br>
					
				
				<cfif FindNoCase('.cfm',Form.Referrer,1) IS 0 OR FindNoCase('login', form.referrer, 1) gt 1 OR FindNoCase('register', form.referrer, 1) gt 1>
					<form action="index.cfm?page=#url.page#&forumaction=startforum" method="post"><input type=submit name="jump" value="  Continue >> "></form>
				<cfelse>
					<form action="#Form.Referrer#" method="post"><input type=submit name="jump" value="  Continue >> "></form>
				</cfif>
				
				<br><br><br></center>
				</cfoutput>

				<cfabort>
			<cfelseif CheckMember.RecordCount GTE 1 and checkmember.ActiveStatus neq 'A'>		
				<cfset error = "Your account has been disabled. <br>Contact the webmaster for additional information.<br><br>">	
			
			<cfelse>		
				<cfif isdefined('form.emaillogin')>
					<cfset error ="Invalid Email address or Password.<br><br>">
				<cfelse>
					<cfset error = "Invalid Username or Password.<br><br>">	
				</cfif>
			</cfif>
		
		</cfif>

		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
			<cfinvokeargument name="error" value="#error#">
			<cfinvokeargument name="referrer" value="index.cfm?page=#url.page#&forumAction=#url.forumaction#">
		</cfinvoke>
		
	</cffunction>
	
	<cffunction name="movethread" access="remote" output="true">

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "Moving #GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		</center>
		
		<cfparam name="error" default="">
		<!--- Page Content Starts Here --->
		<br><br>
		<cfif IsDefined("Form.MoveThread")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getAdmin" returnvariable="getAdmin">
			</cfinvoke>
			
			<!--- check for Valid Admin or Mod --->
			<cfif #GetAdmin.RecordCount# IS NOT '0' AND #GetAdmin.AccessLevel#  GT 1>
				
				<!--- Check for Action - If present, update tables. else let user choose forum to move to. --->
				<cfif IsDefined("URL.Action")>
					
					<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="movethread"></cfinvoke>
					<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewtopics.cfm?Forum=#URL.Forum#">'>
					<center><cfoutput>
					<font face="#request.fontface#" size="#evaluate(request.fontsize +1)#" color="#request.text#">		
					<br><br><b>The thread has been moved successfully!!!</b>
					</font></center>
					<br><br></cfoutput>

					<cfabort>
				
				<cfelse>		
				
					<center><cfoutput>
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<B>Please choose the forum you would like to move <br>
					<i>'#GetTopic.TopicTitle#'</i> to: </b><br>
					<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#">
					(it is currently in '#GetForum2.ForumName#')</font>
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					
					<form action="index.cfm?page=#url.page#&forumaction=movethread&Forum=#URL.Forum#&Topic=#URL.Topic#&Action=Move" method="post">
					<input type=hidden name="MoveThread" value="#URL.Topic#">
					<input type=hidden name="TopicID" value="#URL.Topic#">
					<input type=hidden name="Username" value="#Form.Username#">
					<input type=hidden name="Password" value="#Form.Password#">					
					</cfoutput>
					
					<select name="NewForumID">	
					
					<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getforumlist" returnvariable="getforumlist"></cfinvoke>
					<cfoutput query="getforumlist"><option value="#ForumID#" <cfif #ForumID# IS #URL.Forum#>SELECTED</cfif>>-- #ForumName#</option></cfoutput>    
					</select><br><br>
					
					<input type=submit value="  Move  Thread  Now  ">
					</form>
					</center>
					
					<cfabort>
					
				</cfif>
		
				
			<!--- Incorrect Login - Try again... --->	
			<cfelse>
			
				<cfset error = "Sorry, that is incorrect. Please Try Again.">
		
			</cfif>
		</cfif>
			<!--- Default Display - Initial Login --->
		
		
			<cfoutput><center>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>
			<cfif len(error)>#error#<br><br></cfif>
			
			Threads can only be moved by <br>
			Administrators and Moderators.</b></font>
			<form action="index.cfm?page=#url.page#&forumaction=movethread&Forum=#URL.Forum#&Topic=#URL.Topic#" method="post">
			<table border=0 cellspacing=1 cellpadding=1>
			  <tr bgcolor="#request.catcolor#">
				<td>
				  <table border=0 cellpadding=5 cellspacing=0>
					<tr>
					  <td bgcolor="#request.column2#" colspan="2">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  <b><center>Administrator/Moderator Sign In:</center></b>
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Username:
					  </td>
					  <td bgcolor="#request.column1#">
					  <input type="text" name="Username" size="20" <cfif IsDefined("Cookie.Username")>value="#decrypt(Cookie.Username, request.key)#"</cfif> >
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#">
					  <font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					  Password:
					  </td>
					  <td bgcolor="#request.column1#">
					  <input type="Password" name="Password" size="20" <cfif IsDefined("Cookie.Password")>value="#decrypt(Cookie.Password, request.key)#"</cfif>>
					  </td>
					</tr>
					<tr>
					  <td bgcolor="#request.column1#" colspan="2">
					  <center><input type="submit" name="MoveThread" value="   Continue...  ">
					  </center>
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table><br>
			</form>
			</cfoutput>
		
		<br><br>

	</cffunction>
	
	<cffunction name="mytopics" access="remote" output="true">

		<cfset PageTitle = "Subscribed Topics">
		<cfset PageSection = "Subscribed Topics">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<!--- HHHHHHHHHHHH  CHECK IF MEMBER IS LOGGED IN HHHHHHHHHHHHHHHHH --->
		<cfif Session.MemberLoggedIn IS NOT "Y">
			<cfoutput>
			<center>	<br>
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
				<cfinvokeargument name="page" value="Login">
				<cfinvokeargument name="restrictaccess" value="1">
			</cfinvoke>
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="<br>You must be logged in to view your subscribed topics.<br>Need to become a <a href='register.cfm'>registered member</a>?<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
				
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="Subscribed Topics">
		</cfinvoke>
		<br><cfoutput>
		<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.catcolor#"><td>
			<table width="100%" Border="0" cellpadding="0" cellspacing="1"></cfoutput>
			
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
				method="topicsubscriptions">
			</cfinvoke>
			</table>
		</td></tr></table>		
					
		</center>

	</cffunction>
	
	<cffunction name="pollvote" access="remote" output="true">
		
		<cfset columns = "f.forumname, c.category, f.moderator,f.forumpassword, f.moderatoremail, f.allowhtml">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		<cfset PageTitle = "#GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<br><center>
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="viewmessages">
			<cfinvokeargument name="forumid" value="#form.Forumid#">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="topicid" value="#Gettopic.topicid#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		</center><br>
			
			
		<!--- HHHHHHHHHHHH  CHECK IF MEMBER IS LOGGED IN HHHHHHHHHHHHHHHHH --->
		<cfif Session.MemberLoggedIn IS NOT "Y" AND gettopic.ispublicpoll eq 0>	
			<cfoutput>
			<cfif isdefined('form.vote')>		
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
					method="login">
					<cfinvokeargument name="error" value="<br> At the request of the poll creator<br>you must be a <a href='register.cfm'>registered member</a> to vote.<br><br>">
					<cfinvokeargument name="referrer" value="viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#">
				</cfinvoke>	
			<cfelseif isdefined('form.results')>
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
					method="login">
					<cfinvokeargument name="error" value="<br>  At the request of the poll creator<br>you must be a <a href='register.cfm'>registered member</a> to view the results.<br><br>">
					<cfinvokeargument name="referrer" value="viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#&vr=1">
				</cfinvoke>		
			</cfif>	
			</cfoutput>
			</center>
			<cfabort>
			
		<cfelse>
		
			<cfif isdefined('form.vote')>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="checkvotes" returnvariable="checkvotes">
				</cfinvoke>
				<cfif checkvotes.recordcount gte 1>
					<br>
					<center><cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<br><br><br>
					<b>You have already voted in this poll.<br><br>	
					<a href="viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#&vr=1">View Results</a></b></font>
					<br></cfoutput>
					</center><br><br><br>
					<cfabort>		
				<cfelse>
					<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
						method="addpollvote" returnvariable="addpollvote">
					</cfinvoke>
					<br>
					<center><cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<br><br><br>
					<b>Thank you for voting in this poll.<br><br>	
					<a href="viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#&vr=1">View Results</a></b></font>
					<br></cfoutput>
					</center><br><br><br>
					<cfif IsDefined("cookie.votetopics")>	
						<cfif NOT listfind(cookie.votetopics, url.topic, ',')>
							<cfcookie name="votetopics" value="#listappend(cookie.votetopics, url.topic, ',')#" expires="never">
						</cfif>
					<cfelse>
						<cfcookie name="votetopics" value="#url.topic#" expires="NEVER">
					</cfif>			
					<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#&vr=1">'>			
					<cfabort>		
					
				</cfif>	
				
			<cfelseif isdefined('form.results')>
				<cflocation url="viewmessages.cfm?forum=#form.forumid#&topic=#form.topicid#&vr=1" addtoken="No">
			</cfif>
		
		</cfif>

	</cffunction>
	
	<cffunction name="posttopic" access="remote" output="true">
		<!-- posttopic.cfm -->

		<cfif IsDefined("url.Forum") AND IsNumeric(url.forum)>
		
		<cfset columns = "f.forumname,f.allowhtml,f.allowfileuploads,f.publicforum,f.forumpassword,f.notifymod,f.moderator,f.moderatoremail,f.approvalrequired, f.approvedfiletypes, f.maxfilesize, c.category, f.publicview">

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
			<cfinvokeargument name="columns" value="#columns#">
		</cfinvoke>

		<cfset PageTitle = "Post New Topic">
		<cfset PageSection = "topics">
		
		<cfparam name="error" default="">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<!--- Page Content Starts Here --->
		
		<!--- New PsuedoHTML Code Javascript buttons--->
		<script language="JavaScript">
			<cfinclude template="includes/pseudobuttons.js">
		</script>
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="post topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="forumid" value="#url.forum#">
		</cfinvoke>
		<br>
		</center>
		
		<cfif getforum2.publicview eq 'n' AND (session.memberloggedin eq 'n' OR session.accesslevel lt 3)>
			
			<cfif session.memberloggedin eq 'n'>
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
					method="login">
					<cfinvokeargument name="error" value="<br><b>Only administrators and moderators can post messages in this forum.</b><br><br>">
					<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
				</cfinvoke>
			<cfelse>
				<cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
				<br><br><br><br><center><b>Only administrators and moderators can post messages in this forum.</b></center><br><br><br><br><br><br>
			</cfif>

			</center>
			<cfabort>
		
		<!--- HHHHHHHHHHHH  CHECK IF MEMBER IS LOGGED IN HHHHHHHHHHHHHHHHH --->
		<cfelseif Session.MemberLoggedIn IS NOT "Y">
			<cfoutput>
			<center>	

			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
				method="login">
				<cfinvokeargument name="error" value="You have not logged in yet. <br><br> You must be a <a href='register.cfm'>registered member</a> to post messages.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>

			</center>
			<cfabort>
		
		<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHH Check for Public Forum HHHHHHHHHHHHHHHHHHHHHHH --->
		<cfelseif GetForum2.PublicForum IS "N" AND Session.accesslevel lt 3>
		
			<center><cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<br><br><br>
			<b>Sorry, only administrators and moderators <br>can post messages in this forum.</b><br><br>	
			<br></cfoutput>
			</center><br><br><br>
			<cfabort>
			
		<cfelseif len(trim(getforum2.forumpassword)) and not listcontains(session.authorizedforums, url.forum, ',') and  session.accesslevel lt 5>
		
			<cflocation url="viewtopics.cfm?forum=#url.forum#" addtoken="no">
		
		
		<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHH  Check for valid INPUTS FOR NEW TOPIC HHHHHHHHHHHHHHHHHH --->
		<cfelseif IsDefined("Form.InsertNewTopic")>
		
			<cfif not Len(Form.MessageCopy) or not len(form.topictitle)>
				<cfset error = "You must enter information in both fields below.">
			<cfelse>
			
			<!--- HHHHHHHHHHHHHHHHHHHHHH  INSERT NEW TOPIC INTO TABLES HHHHHHHHHHHHHHHHHHHH   --->	
			<cfif IsDefined("Form.filename")>
				<cfinvoke component="#application.websitepath#.utilities.forumactions" 
					method="fileattachments"></cfinvoke>
			</cfif> 	
			
			<cfif NOT LEN(Error)>
			<cfif IsDefined("Form.ShowSignature")>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="membersig" returnvariable="membersig"></cfinvoke>
				<cfset MessageCopy2 = "#Form.MessageCopy#"&chr(10)&chr(10)&"#membersig.Signature#">
			<cfelse>
				<cfset MessageCopy2 = "#Form.MessageCopy#">
			</cfif>
			
			<cfset TopicTitle = "#Form.TopicTitle#">
			
			<!--- bad word filter --->
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay"
				method="badwordfilter" returnvariable="MessageCopy2">
				<cfinvokeargument name="Message" value="#MessageCopy2#">
			</cfinvoke>
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay"
				method="badwordfilter" returnvariable="TopicTitle">
				<cfinvokeargument name="Message" value="#TopicTitle#">
			</cfinvoke>
			<cfif getforum2.ApprovalRequired is "y">
				<cfset IsApproved = "n">
			<cfelse>
				<cfset IsApproved = "y">
			</cfif>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="posttopic"></cfinvoke>
			<!--- Subscribe user to topic --->
			<cfif IsDefined("Form.NotifyAuthor")>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe"></cfinvoke>
			</cfif>
			
		<!--- Send email to subscribers --->
		<cfif forum.enableforumsubscriptions eq 1>
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getsubscribers" returnvariable="getsubscribers"></cfinvoke>
		<cfif getsubscribers.RecordCount>    
		<cfmail query="getsubscribers" to="#getsubscribers.email#" from="#request.forumemail#" subject="[#request.forumtitle#] New Topic: #HTMLEditFormat(TopicTitle)#" Server="#application.mailserver#" port="#application.mailport#">
		Dear #getsubscribers.username#,
		#Form.MemberName# has posted to a new topic in a forum that you 
		have subscribed to at #trim(request.forumtitle)#.
		
		Topic: #TopicTitle#
		
		To view the forum, please visit the link below.
		#request.forumurl#/viewtopics.cfm?Forum=#Form.ForumID#
		
		If you would like to un-subscribe from this forum, 
		you may do so by visiting the following link.
		#request.forumurl#/subscribe.cfm?forum=#Form.ForumID#&topic=0&sub=forum
		
		Thank you for visiting #trim(request.forumtitle)#.
		
		
		
		
		
										  Powered by CF Forum
											www.cfforum.com
		</cfmail>    
		</cfif>
		</cfif>
		
		<!--- send mail to moderators --->
		<cfif GetForum2.NotifyMod IS 'Y'>
		<cfmail to="#GetForum2.ModeratorEmail#" from="#request.forumemail#" subject="[#request.forumtitle#] New Topic in #GetForum2.ForumName#" Server="#application.mailserver#" port="#application.mailport#">
		#Form.MemberName# has posted a new topic in #GetForum2.ForumName#.
			
		Topic: #TopicTitle#
			
		#MessageCopy2#
			
		Please visit #request.forumurl#/viewtopics.cfm?Forum=#Form.ForumID#
			
		Thank you for helping moderate #request.forumtitle#.
		Webmaster
		
		
		
		
		
		
		
										   Powered by CF Forum 
											www.cfforum.com
		</cfmail>  
		</cfif>	
		
			<cfoutput>
			<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">	
			<b><br><br>Thank you, #Form.MemberName#. <br> <br><cfif getforum2.ApprovalRequired is "y">Your topic has been submitted successfully. <br>It will be displayed as soon as it is approved by a moderator or administrator.<cfelse>Your new topic has been posted successfully.</cfif><br>	<br>	<br>
			<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewtopics.cfm?Forum=#URL.Forum#">'>
			<a href="viewtopics.cfm?Forum=#URL.Forum#"> Back to #HTMLEditFormat(GetForum2.ForumName)#</a></b></font>	<br>	<br></center>
			</cfoutput>

			<cfabort>
			</cfif>
			</cfif>
		</cfif>
		
		<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHH  GATHER INPUTS FOR NEW TOPIC HHHHHHHHHHHHHHHHHH --->	
		
		<cfif #Session.MemberLoggedIn# IS "Y">	
		
			<script language="javascript">					
			function WinOpen(url,x,y) {
					var attributes = "toolbar=no,scrollbars=yes,resizable=yes,width=" + x + ",height=" + y;
					msgWindow=window.open(url,"WinOpen",attributes);
			}					
			</script>
			
			<cfoutput>
			<form action="index.cfm?page=#url.page#&forumaction=posttopic&Forum=#URL.Forum#" method="post" name="PostTopic" enctype="multipart/form-data">
			<input type="hidden" name="MemberID" value="#session.MemberID#">
			<input type="hidden" name="MemberName" value="#session.Username#">
			<input type="hidden" name="ForumID" value="#URL.Forum#">
			<input type="hidden" name="MessageDate" value="#NOW()#">
			<input type="hidden" name="Views" value="0">
			<input type="hidden" name="ThreadLocked" value="N">
			<input type="hidden" name="NotifyEmail" value="#session.Email#">
			<input type="hidden" name="IPAddress" value="#cgi.REMOTE_ADDR#">	
			<input type="hidden" name="ispoll" value="0">
			<input type="hidden" name="ispollmessage" value="0">
			<center>
			
			<cfif len(error)>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#Error#</b><br><br></font>
			</cfif>
			
			<table  Border="0" cellpadding="0" cellspacing="0">
			  <tr bgcolor="#request.column2#">
				<td>
				  <table width="100%" Border="0" cellpadding="2" cellspacing="1">
					<tr>
						<td bgcolor="#request.catcolor#" colspan=2>
						<center><font face="#request.fontface#"  color="#request.cattextcolor#" size="#request.fontsize#">
						<b>Start New Discussion</b></font></center>
						</td>
					</tr>
					<tr>
						<td align="Right" bgcolor="#request.bgcolor#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>Topic Title:</b></font>
						</td>
						<td bgcolor="#request.bgcolor#">
						<input type="text" name="TopicTitle" size=40 maxlength="50" <cfif isdefined("form.topictitle")>value="#form.topictitle#"</cfif>>
						</td>
					</tr></cfoutput>						
					
					<!--- TOPIC ICONS ---  New - Added 1-5-2001 --->
					<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
						method="topicicon"></cfinvoke>
					<!--- /New --->
					<cfoutput>
					<tr>
						<td valign="top" align="Right" bgcolor="#request.bgcolor#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Message:</b></font></p>
						<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
						<cfif #GetForum2.AllowHTML# IS 'Y'><li> HTML is Allowed<cfelse><li> HTML is not Allowed</cfif>					
						<br><li>PseudoHTML is On.    			
						</font>
						</td>
						<td bgcolor="#request.bgcolor#"><textarea name="MessageCopy" cols="55" rows="10" wrap="PHYSICAL"><cfif Isdefined("form.messagecopy")>#form.messagecopy#</cfif></textarea><br>  
		  
						<!--- PseudoHTML Buttons - added Apr 7 --->
						</cfoutput>
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
						method="pseudobuttons"></cfinvoke>
						<cfoutput>
			
						<!--- Attach a File --- added Feb 28 --->
						<cfif GetForum2.AllowFileUploads IS 'Y'>
						</td>
					</tr>
					<tr>
						<td align="Right" bgcolor="#request.bgcolor#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">File Attachment:</font>
						</td>
						<td bgcolor="#request.bgcolor#">
							<cfif isdefined("form.AttachedFile")>
								<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
								#form.AttachedFile#</font>
							<cfelse>
								<input type="file" name="filename" size=35>
							</cfif>
						</td>
					</tr>
					<tr>
						<td bgcolor="#request.bgcolor#">&nbsp;
						</td>
						<td bgcolor="#request.bgcolor#">
						</cfif>
						<!--- / end attach a file --->
						<br>
						<cfif Session.accesslevel gte 3>				
						<input type="checkbox" name="stayontop" value="1" <cfif isDefined("form.stayontop")> checked</cfif>>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">This topic should stay near the top.</font><br>				
						</cfif>
						
						<input type="Checkbox" name="ShowSignature" Value="Yes" <cfif isDefined("form.Showsignature")><cfif form.Showsignature is 'y'>checked</cfif><cfelse>checked</cfif>>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Show my signature in this message.</font><br>   				 
						<cfif forum.enabletopicsubscriptions eq 1>
						<input type="Checkbox" name="NotifyAuthor" Value="Y"  <cfif isDefined("form.NotifyAuthor")><cfif form.NotifyAuthor is 'y'>checked</cfif></cfif>>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Notify me when someone replies.</font><br>
						</cfif><br>
						</td>
					</tr>
					<tr>
						<td colspan=2 bgcolor="#request.bgcolor#">
						<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<cfif getforum2.ApprovalRequired is "y"><br>
						Note: All messages posted to this discussion group require <br>
						approval from an administrator or moderator before being displayed.
						</cfif> 
						<br><br>				
						
						<input type="button" name="Preview" value="  Preview  " onclick="WinOpen('previewmessages.cfm?forum=#url.forum#','550','400'); return false;">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" name="InsertNewTopic" value="  Post New Discussion  " >
						</font></center>
						</td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
			</form>
			</center>
			</cfoutput>	
			
		</cfif>
		
		<br><br>
		
		<cfelse>
			<cflocation url="index.cfm" addtoken="No">
		</cfif>

	</cffunction>
	
	<cffunction name="preferences" access="remote" output="true">

		<cfset PageTitle = "Membership Information">
		<cfset PageSection = "Membership">
		<cfset ERROR = "">
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="member preferences">
		</cfinvoke>
		<br>
		</center>
		
		<!--- Page Content Starts Here --->
		
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checkmemberoptions" returnvariable="checkmemberoptions">
		</cfinvoke>
		<cfif Session.MemberLoggedIn IS NOT "Y">
		
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="You have not logged in yet. <br><br> You must be a <a href='register.cfm'>registered member</a> to edit preferences.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			<cfabort>
			
		<cfelseif IsDefined("Form.JoinForum")>		
			
			<cfset Password = '#Form.Password1#'>
			
			<cfif NOT LEN(Form.Email)>
				<cfset ERROR = "Please enter a valid Email Address">
			
			<cfelseif Form.Email neq Form.OrigEmail>
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="checkemail">
				</cfinvoke>
				<cfif Checkemail.RecordCount gte 1>
					<cfset ERROR = "That email address is already in use.<br> If you have forgotten an old account, <a href='emailinfo.cfm'>click here</a>">  
				<cfelse>
					<!--- Generate Password --->
					<cfif checkmemberoptions.generatepassword eq 1>
						<CFSET Password = "#RandRange(0,9999999)#">	
					</cfif>
				</cfif>
				
			<cfelseif '#Form.Password1#' IS NOT '#Form.Password2#'>
				<cfset ERROR = "Those passwords do not match, please re-type them both.">
			</cfif>    
			
			<cfif NOT Len(ERROR)>
			
				<!--- qry updatemembers --->
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="updatemember">
				</cfinvoke>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="6;URL=index.cfm">'>
				<center>
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><br><br>
			   <b> Your information has been updated successfully.</b><br>You may need to log out for some of your changes to take effect. <br><br>
			   </cfoutput>	
			   </center>
			   <cfif checkmemberoptions.generatepassword eq 1 AND '#Form.Email#' IS NOT '#Form.OrigEmail#'>
			   <center>Since you changed your email address, a new temporary <br>
			   password has been emailed to the new address.<br>
			   </center>
					
		<cfmail to="#Form.Email#" from="#request.forumemail#" subject="Updated Membership Information for #request.forumtitle#" server="#application.mailserver#" port="#application.mailport#"
		>Your information has been updated successfully. 
		Below is your new temporary password. You may 
		change it by visiting #request.forumurl# . 
		To visit our main site, please go to 
		#request.homeurl# .
		
		Your Username is    #Form.Username#
		Your Password is    #Password#
		
		Thanks again for becoming a member.
		Regard, Webmaster - #request.forumemail#
		
		
		
		
		Powered by CF Forum - http://www.cfforum.com
		</cfmail>			
					
				</cfif>
				
				<br><br><br>
				
				<cfif #Form.StoreCookies# IS "Y">		
					<cfcookie name="MemberID" value="#session.MemberID#" expires="NEVER">
					<cfcookie name="Username" value="#encrypt(Form.Username, request.key)#" expires="NEVER">
					<cfcookie name="Password" value="#encrypt(PassWord, request.key)#" expires="NEVER">
					<cfcookie name="Email" value="#Form.Email#" expires="NEVER">		    
				<cfelse>
					<cfcookie name="MemberID" value="" expires="NOW">
					<cfcookie name="Username" value="" expires="NOW">
					<cfcookie name="Password" value="" expires="NOW">
					<cfcookie name="Email" value="" expires="NOW">		    
				</cfif>		
				<cfif isdefined("form.howmany")>
					<cfcookie name="ShowHowMany" value="#Form.HowMany#" Expires="Never">
				</cfif>
				</font>
				<cfabort>
			
			</cfif>	
		
		</cfif>
		
		
		<!--- HHHHHHHHHHHH  edit membership info HHHHHHHHHHHHH --->
		
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checkmember" returnvariable="checkmember">
		</cfinvoke>
		
		<center>
		<cfoutput>
		
		<cfif len(error)>
		<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.text#">
		<b><br>#Error#<br><br></b></font>
		</cfif>
		<table Border="0" width="#request.tablewidth#" cellpadding="2" cellspacing="0">
		  <tr>
			<td bgcolor="#request.bgcolor#">
				
				<form action="index.cfm?page=#url.page#&forumaction=preferences" method="post">
				<input type="hidden" name="OrigEmail" value="#CheckMember.Email#">
				<input type="hidden" name="OrigUserName" value="#CheckMember.Username#">
				<input type="hidden" name="MemberID" value="#CheckMember.MemberID#">
				
				<center>    
				<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td bgcolor="#request.column2#">
					
					<table width="100%" Border="0" cellpadding="2" cellspacing="1">
						<tr>
							<td colspan=2 bgcolor="#request.catcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#">REQUIRED INFORMATION</font>
							</td>
						</tr>
						<!--- UserName --->
						<tr>
							<td bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>Username:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#">
							<input type="hidden" name="Username" value="#CheckMember.Username#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.catcolor#">
							<b>&nbsp;&nbsp;&nbsp;#CheckMember.Username#</b></font>
							</td>
						</tr>				
						<!--- Email Address --->
						<tr>
							<td bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>Email Address:</b>					
							</td>
							<td bgcolor="#request.bgcolor#">
							<input type="text" name="Email" size=30 value="#CheckMember.Email#">
							<cfif checkmemberoptions.generatepassword eq 1>
							<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.text#">
							<br>If you are changing your email address, a new password will be emailed to you.</font>
							</cfif>
							</td>
						</tr>
						<!--- Password --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>Password:</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="password" name="Password1" value="#CheckMember.Password#" maxlength="20">
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>Verify Password:</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="password" name="Password2" value="#CheckMember.Password#" maxlength="20">
							</td>
						</tr>
						<!--- OPTIONAL INFORMATION --->
						<tr>
							<td colspan=2 bgcolor="#request.catcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#">
							OPTIONAL INFORMATION </font>
							</td>
						</tr>
						<!--- First Name --->
						<cfif checkmemberoptions.showfname eq 1>
						<tr>
							<td bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>First Name:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="fname" size="15" value="#CheckMember.fname#">					
							</td>
						</tr>
						</cfif>
						<!--- Last Name --->
						<cfif checkmemberoptions.showlname eq 1>
						<tr>
							<td bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><p align="right"><b>Last Name:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="lname" size="15" value="#CheckMember.lname#">					
							</td>
						</tr>
						</cfif>
						<!--- Birthday --->
						<cfif checkmemberoptions.showbday eq 1>
						<tr>
							<td bgcolor="#request.bgcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Birthdate:</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="bday" size="10" maxlength="10" value="#dateformat(CheckMember.bday, 'mm/dd/yyyy')#">	<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"> mm/dd/yyyy			
							</td>
						</tr>
						</cfif>
						<!--- Residence Address --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>City, State, Country:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="Residence" size=30 maxlength="150" value="#CheckMember.Residence#">
							</td>
						</tr>
						<!--- Occupation --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Occupation:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="Occupation" size=30 maxlength="50"  value="#CheckMember.Occupation#">
							</td>
						</tr>
						<!--- Hobbies --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Hobbies:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="interests" size=30 maxlength="150" value="#CheckMember.interests#">
							</td>
						</tr>
						<!--- HomePage --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Homepage:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="HomePage" size=30 maxlength="120" value="#CheckMember.HomePage#">
							</td>
						</tr>
						<!--- AOL Instant Messager --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>AOL Instant Messenger Handle:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="aimhandle" size=25 maxlength="25" value="#CheckMember.aimhandle#">
							</td>
						</tr>
						<!--- ICQ Number --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>ICQ Number:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="icqnumber" size=25 maxlength="25" value="#CheckMember.icqnumber#">
							</td>
						</tr>
						<!--- HomePage --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Yahoo! Messenger Handle:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="yahoohandle" size=25 maxlength="25" value="#CheckMember.yahoohandle#">
							</td>
						</tr>
						<!--- Custom 1 --->
						<cfif len(trim(checkmemberoptions.labelcustom1))>
						<tr>
							<td bgcolor="#request.bgcolor#" align="right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#checkmemberoptions.labelcustom1#</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="custom1" size="30" maxlength="50" value="#CheckMember.custom1#">		
							</td>
						</tr>
						</cfif>
						<!--- Custom 2 --->
						<cfif len(trim(checkmemberoptions.labelcustom2))>
						<tr>
							<td bgcolor="#request.bgcolor#" align="right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#checkmemberoptions.labelcustom2#</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="custom2" size="30" maxlength="50" value="#CheckMember.custom2#">		
							</td>
						</tr>
						</cfif>
						<!--- Custom 3 --->
						<cfif len(trim(checkmemberoptions.labelcustom3))>
						<tr>
							<td bgcolor="#request.bgcolor#" align="right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#checkmemberoptions.labelcustom3#</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="custom3" size="30" maxlength="50" value="#CheckMember.custom3#">		
							</td>
						</tr>
						</cfif>
						<!--- Custom 4 --->
						<cfif len(trim(checkmemberoptions.labelcustom4))>
						<tr>
							<td bgcolor="#request.bgcolor#" align="right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#checkmemberoptions.labelcustom4#</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="custom4" size="30" maxlength="50" value="#CheckMember.custom4#">		
							</td>
						</tr>
						</cfif>
						<!--- Custom 5 --->
						<cfif len(trim(checkmemberoptions.labelcustom5))>
						<tr>
							<td bgcolor="#request.bgcolor#" align="right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#checkmemberoptions.labelcustom5#</b>
							</td>
							<td bgcolor="#request.bgcolor#"><input type="text" name="custom5" size="30" maxlength="50" value="#CheckMember.custom5#">		
							</td>
						</tr>
						</cfif>
						
						
						<!--- Signature --->
						<tr>
							<td valign="top" bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Signature:</b></font><font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
							<br>
							This is text or pseudo-html <br>
							code that you want to show at the <br>    
							bottom of all your posts.      
							</td>
							<td valign="top" bgcolor="#request.bgcolor#"><textarea name="Signature" cols="30" rows="4" wrap="PHYSICAL">#CheckMember.Signature#</textarea><br>
							<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">For example: Kindest Regards, Your Name 
							</td>
						</tr>
						<!--- PREFERENCE INFORMATION --->
						<tr>
							<td colspan=2 bgcolor="#request.catcolor#">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#">
							PREFERENCES </font>
							</td>
						</tr>
						<tr>
							<td align="right" bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<b>Enable Private Messages:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="enablepm" value="1"  <cfif CheckMember.enablepm eq 1>CHECKED</cfif>> Yes <input type="radio" name="enablepm" value="0" <cfif CheckMember.enablepm neq 1>CHECKED</cfif>> No</font></td>
						</tr>
						<tr>
							<td align="right" bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<b>Notify me via email of <br>new private message:</b></font>
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="notifypm" value="1"  <cfif CheckMember.notifypm eq 1>CHECKED</cfif>> Yes <input type="radio" name="notifypm" value="0" <cfif CheckMember.notifypm neq 1>CHECKED</cfif>> No</font></td>
						</tr>
						<!--- Store Username/Password --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>* Store Username<br>and Password:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="StoreCookies" value="Y" <cfif CheckMember.StoreCookies eq "Y">CHECKED</cfif>> Yes <input type="radio" name="StoreCookies" value="N" <cfif CheckMember.StoreCookies neq "Y">CHECKED</cfif>> No
							</td>
						</tr>
						<!--- Show Email address --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>Make Email Address<br>viewable to others:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ShowEmail" value="Y"  <cfif #CheckMember.ShowEmail# IS "Y">CHECKED</cfif>> Yes <input type="radio" name="ShowEmail" value="N" <cfif #CheckMember.ShowEmail# IS "N">CHECKED</cfif>> No
							</td>
						</tr>
						<!--- Default topics at one time --->
						<tr>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<p align="right"><b>* Default Topics Returned:</b>	
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							&nbsp;&nbsp; Show me <input type="text" name="HowMany"  size="3" maxlength="2" value="#CheckMember.HowMany#"> topics/messages at a time.
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.bgcolor#" colspan="2"><center><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#">* requires cookies to be enabled on your browser</font>
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<br><br><br><input type="submit" name="JoinForum" value=" Update my Information "></center>
							</td>
						</tr>
					</table>
					
					</td>
				</tr>
			</table></center></form>
			</td>
		  </tr>
		</table>
		</cfoutput></center>

	</cffunction>
	
	<cffunction name="previewmessages" access="remote" output="true">
		
		<cfif Not IsDefined("form.showprev")>
			<cfoutput>
				<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<br><br><b>One moment please... </b>
						#repeatstring('<br>', 50)#
				</center></font>
			</cfoutput>
			<form name="prevform" method="post">
			<input type="hidden" name="topictitle">
			<input type="hidden" name="messagecopy">
			<input type="Hidden" name="membername">
			<input type="Hidden" name="messagedate">
			<input type="hidden" name="showprev">
			<input type="hidden" name="ispoll">
			<cfif isdefined('url.ispoll')>	
			<cfset columns = "f.maxpollanswers">
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getForum2" returnvariable="getforum2">
				<cfinvokeargument name="forum" value="#url.forum#">
				<cfinvokeargument name="columns" value="#url.columns#">
			</cfinvoke>
			<cfloop index="i" from="1" to="#getforum2.maxpollanswers#">
			 <cfoutput><input type="hidden" name="pollanswer_#i#"></cfoutput><br>
			</cfloop>
			</cfif>
			
			</form><cfoutput>
			<script language="javascript">
			   document.prevform.topictitle.value=window.opener.document.PostTopic.TopicTitle.value;
			   document.prevform.messagecopy.value=window.opener.document.PostTopic.MessageCopy.value; 
			   document.prevform.membername.value=window.opener.document.PostTopic.MemberName.value;
			   document.prevform.messagedate.value=window.opener.document.PostTopic.MessageDate.value;
			   document.prevform.ispoll.value=window.opener.document.PostTopic.ispoll.value;	   
			   <cfif isdefined('url.ispoll')>	
			   <cfloop index="i" from="1" to="#getforum2.maxpollanswers#">
			   document.prevform.pollanswer_#i#.value=window.opener.document.PostTopic.pollanswer_#i#.value;
			   </cfloop>
			   </cfif>
				
			   document.prevform.submit();   
			</script>
			</cfoutput>
		<cfelse>	
			<cfif len(form.messagecopy) and len(form.topictitle)>
				<cfset columns = "f.forumname,f.allowhtml,f.allowfileuploads,f.publicforum,f.forumpassword,f.notifymod,f.moderator,f.moderatoremail,f.approvalrequired, c.category">
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getForum2" returnvariable="getforum2">
					<cfinvokeargument name="forum" value="#url.forum#">
					<cfinvokeargument name="columns" value="#url.columns#">
				</cfinvoke>
				<center>
				<cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
						<b>Message Preview </b><br><br></font>
				<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
					method="previewmessage">
				</cfinvoke>
				</center>
			
			<cfelse>
			
				<center>
				<cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
						<br><br><br><b>You need to enter your <cfif not len(form.topictitle)>topic title</cfif> <cfif not len(form.messagecopy) and not len(form.topictitle)>and</cfif> <cfif not len(form.messagecopy)>message</cfif>. </b><br><br></font>		
				</center>
				
			</cfif>
			
			
		</cfif>
		
		<center><br>
		<form action=post><input type="button" value="  Close this Window  " ONCLICK="window.close()"></form></center>
		</center>

	</cffunction>
	
	<cffunction name="printthread" access="remote" output="true">

		<cfif IsDefined("url.Forum") AND IsDefined("url.topic") AND IsNumeric(url.forum) AND IsNumeric(url.topic)>
		
		<cfset columns = "f.forumname, c.category, f.allowhtml">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
			<cfinvokeargument name="columns" value="#url.columns#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "#GetTopic.TopicTitle#">
		
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
		<cfoutput>
		<html><head><title>#request.forumtitle# - <cfif IsDefined("PageTitle")>#PageTitle#</cfif></title></head>
		<body bgcolor="white" Text="black" link="black" VLink="black" ALink="black">
		</cfoutput>
		
		
		<cfoutput>
		<font face="#request.fontface#" Color="black" size="#evaluate(request.fontsize + 2)#">
		Topic: #HTMLEditFormat(GetTopic.TopicTitle)#
		</font>
		<br><br>
		
		<table width="600" Border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan=2><hr>
				</td>
			</tr>
			</cfoutput>
		
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getmessages" returnvariable="getmessages">
				<cfinvokeargument name="sortby" value="#sortby#">
				<cfinvokeargument name="topic" value="#url.topic#">
			</cfinvoke>
			<cfloop query="GetMessages" startrow="1" endrow="#GetMessages.RecordCount#">
		
			<cfset MessageCopy2 = "#GetMessages.MessageCopy#">
		
			<cfoutput>
			<tr>
				<td valign="top">
				<font face="#request.fontface#" size="#request.fontsize#" color="black"><b>#GetMessages.UserName#</b></font>
				</td>
				<td valign="top" width=100%> 
				<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#"  color="gray" > 
				&nbsp;&nbsp; -- #DateFormat(GetMessages.MessageDate,'mm-dd-yyyy')# @ #TimeFormat(GetMessages.MessageDate,'h:mm tt')#</font>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			
				</cfoutput>
				<cfinvoke method="messagecopy2" 
					component="#application.websitepath#.utilities.forumactions" 
					returnvariable="messagecopy2">
					<cfinvokeargument name="theMessage" value="#messagecopy2#">
				</cfinvoke>
				<cfoutput>
				<td valign="top" width=100%><font face="#request.fontface#" size="#request.fontsize#" color="black">
				#paragraphformat(MessageCopy2)#
				</cfoutput>
				</font>
				</td>
			</tr>
			<tr>
				<td colspan=2><hr>
				</td>
			</tr>
			</cfloop>
		</table>
		<cfoutput>
		<table border=0 cellpadding=1>
			<tr>
				<td align=right><font face="#request.fontface#" size="#request.fontsize#" color="black">
				#request.forumtitle# : 
				</td>
				<td><font face="#request.fontface#" size="#request.fontsize#" color="black">
				<a href="#request.forumurl#">#request.forumurl#</a>
				</td>
			</tr>
			<tr>
				<td align=right><font face="#request.fontface#" size="#request.fontsize#" color="black">
				Topic: 
				</td>
				<td><font face="#request.fontface#" size="#request.fontsize#" color="black">
				<a href="#request.forumurl#/viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">#request.forumurl#/viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#</a>
				</td>
			</tr>
		</table>
		
		</cfoutput>
		
		<!--- Page Content Stops Here --->
		
		<cfelse>
			<cflocation url="index.cfm" addtoken="No">
		</cfif>
	</cffunction>
	
	<cffunction name="pseudohtml" access="remote" output="true">
		
		<cfoutput>
		
		<center>
		<table width="100%" Border="0" cellpadding="1" cellspacing="0">
			<tr bgcolor="#request.catcolor#">
				<td>
					<table width="100%" Border="0" cellpadding="1" cellspacing="0">
						<tr bgcolor="#request.catcolor#">
							<td colspan="2"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" ><b><center>How to use PseudoHTML Code</center></b></td>
						</tr>
						<tr bgcolor="#request.column1#">
							<td valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><br>Code</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To submit code in your messages, <br>simply wrap the desired code between [code] and [/code]. <br><br> 
							For Example:<br> 
							[code]<br>
							&lt;table&gt;<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&lt;tr&gt;<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;td&gt;<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is a test &lt;a href="http://www.cfcode.com"&gt;Link&lt;/a&gt;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/td&gt;<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&lt;/tr&gt;<br>
							&lt;/table&gt;<br>
							[/code] will display as <br>
							<font face="Courier New,Courier,Times New Roman" color="teal">&lt;table&gt;</font><br>
							&nbsp;&nbsp;<font face="Courier New,Courier,Times New Roman" color="teal">&lt;tr&gt;</font><br>
							&nbsp;&nbsp;&nbsp;&nbsp;<font face="Courier New,Courier,Times New Roman" color="teal">&lt;td&gt;</font><br>
							&nbsp;&nbsp;&nbsp;&nbsp;This is a test <font face="Courier New,Courier,Times New Roman" color="green">&lt;a href=<font color="##0000ff">&quot;index.cfm&quot;</font>&gt;</font>Link<font face="Courier New,Courier,Times New Roman" color="green">&lt;/a&gt;</font><br>
							&nbsp;&nbsp;&nbsp;&nbsp;<font face="Courier New,Courier,Times New Roman" color="teal">&lt;/td&gt;</font><br>
							&nbsp;&nbsp;<font face="Courier New,Courier,Times New Roman" color="teal">&lt;/tr&gt;</font><br>
							<font face="Courier New,Courier,Times New Roman" color="teal">&lt;/table&gt;</font><br>
							</font><br><br></td>
						</tr>	
						<tr bgcolor="#request.column2#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Center</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To center text in your messages, <br>simply wrap the text between [center] and [/center]. <br><br> For Example:<br> [center] This is centered text [/center] will display as <center><br>This is centered text.</center></font><br><br></td>
						</tr>			
						<tr bgcolor="#request.column1#">
							<td valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><br>Bold</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To bold text in your messages, <br>simply wrap the text between [B] and [/B]. <br><br> For Example:<br> [B] This is Bold [/B] will display as <br><b>This is Bold</b>.</font><br><br></td>
						</tr>
						<tr bgcolor="#request.column2#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Italic</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To italicize text in your messages, <br>simply wrap the text between [I] and [/I]. <br><br> For Example:<br> [I] This is Italic [/I] will display as <br><i>This is Italic</i>.</font><br><br></td>
						</tr>
						<tr bgcolor="#request.column1#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Underline</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To underline text in your messages, <br>simply wrap the text between [U] and [/U]. <br><br> For Example:<br> [U] This is Underlined [/U] will display as <br><u>This is Underlined</u>.</font><br><br></td>
						</tr>
						<tr bgcolor="#request.column2#">
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Unordered List&nbsp;&nbsp;</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To create an  unordered bullet list, <br>do as follows:<br>[LIST]<br>[*] bullet point one<br>[*] bullet point two<br>[/LIST] <br><br>This will display as <br><ul><li>bullet point one<li>bullet point two</ul><br><br></td>
						</tr>
						<tr bgcolor="#request.column1#">
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Ordered List</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To create an ordered bullet list, <br>do as follows:<br>[LIST=1]<br>[*] bullet point one<br>[*] bullet point two<br>[/LIST] <br><br>This will display as <br><ol><li>bullet point one<li>bullet point two</ul><br><br></td>
						</tr>
						<tr bgcolor="#request.column2#">
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Center Text&nbsp;&nbsp;</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To center text, <br>simply wrap the text between [center] and [/center]. <br><br> For Example: <br> [center] This is centered [/center] will display as<br><center>This is centered</center><br><br></td>
						</tr>
						<tr bgcolor="#request.column1#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Quote</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To quote someone's text in your messages, <br>simply wrap the text between [QUOTE] and [/QUOTE]. <br><br> For Example:<br> [QUOTE] This is a quote...  [/QUOTE] will display as <br><blockquote><i><font size=1>quote:</font><br><hr>This is a quote...<hr></blockquote></i></font></td>
						</tr>
						<tr bgcolor="#request.column2#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Link</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To add a link in your message, <br>simply put [url=http://www.YourURL.com]Your Site Title[/url]. <br><br> For Example:<br> [url=#request.forumurl#]#request.forumtitle#[/url] will display as <br><a href="#request.forumurl#">#request.forumtitle#</a></font></td>
						</tr>
						<tr bgcolor="#request.column1#">	
							<td  valign=top><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><br><b>Email</b></td>
							<td><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><br>To add an email address in your message, <br>simply put [email=YourEmail@Domain.com]Your Name[/email]. <br><br> For Example:<br> [email=#request.forumemail#]Webmaster[/email] will display as <br><a href="mailto:#request.forumemail#">Webmaster</a></font></td>
						</tr>
					</table>
				</td>
			</tr>
		</table><br>
		
		<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#">
		NOTE: PseudoHTML code is not case sensitive. <br>For example, you may use [B] or [b], [I] or [i], etc.
		<BR>
		
		</center>
		</cfoutput>
	</cffunction>
	
	<cffunction name="register" access="remote" output="true">
		<cfset PageTitle = "Member Registration">
		<cfset PageSection = "Membership">
		<!--- Page Content Starts Here --->
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checkmemberoptions"returnvariable="checkmemberoptions">
		</cfinvoke>
		
		<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHHHH AGREED HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH--->
		
		<center><br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="Membership Registration">
		</cfinvoke>
		<br></center>
		
		<cfif IsDefined("URL.Agree")>
		
			<script language="javascript">					
			function WinOpen(url,x,y) {
					var attributes = "toolbar=no,scrollbars=yes,resizable=yes,width=" + x + ",height=" + y;
					msgWindow=window.open(url,"WinOpen",attributes);
			}					
			</script>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="checkmemberoptions" returnvariable="checkmemberoptions">
			</cfinvoke>
			<center>
			<cfoutput>
			<table Border="0" width="#request.tablewidth#" cellpadding="2" cellspacing="0">
			<tr><td colspan=2><center>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			Membership  is FREE. All we ask is that you provide a username<cfif checkmemberoptions.generatepassword neq 1>, password</cfif> and a valid email address. 
			<br>After you login, you will be able to set up your preferences.<br><br>
			</center></td></tr>
			<tr><td><form action="index.cfm?page=#url.page#&forumaction=register" method="post">
			<input type="hidden" name="JoinedDate" value="#Now()#">   
			<center>
			<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.column2#"><td>
			<table width="100%" Border="0" cellpadding="2" cellspacing="1">
			<tr><td colspan=2 bgcolor="#request.catcolor#">
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#">
			<b><center>Membership Information</center></b></font> 
			</td></tr>
			<!--- UserName --->
			<tr><td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Username:</b>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)
			</td><td bgcolor="#request.column1#"><input type="text" name="Username" size=15 maxlength=15>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>Up to 15 characters. Please... no spaces
			</td></tr>
			<!--- Email Address --->
			<tr><td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Email Address:</b>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)
			</td><td bgcolor="#request.bgcolor#"><input type="text" name="Email" size=30>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>example: JSmith@yahoo.com
			</td></tr>	
			<!--- Password --->
			<tr><td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Password:</b>
			<cfif checkmemberoptions.generatepassword neq 1><font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)</cfif>
			</td>
			
			<td bgcolor="#request.column1#">
			<cfif checkmemberoptions.generatepassword eq 1>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.timecolor#">
			A temporary password will be emailed to you. 
			<br>   It is important that you enter a valid email address above. 
			<cfelse>
			<input type="text" name="password" size=15 maxlenght=20>
			</cfif>
			</td></tr>
			<tr><td bgcolor="#request.column1#" colspan="2"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<center><br><input type="submit" name="JoinForum" value=" Submit my Information "><br><br></center>
			
			</table></td></tr></table></center></form>
			</td></tr></table>
			</cfoutput></center>
		
		<!--- HHHHHHHHHHHHHHHHHHHH check inputs and insert new membership info HHHHHHHHHHHHH --->
		<cfelseif IsDefined("Form.JoinForum")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="checkmember" returnvariable="checkmember">
			</cfinvoke>
			<cfset Error = "">
			<cfif #checkMember.RecordCount# GT 0>
				<cfif '#trim(checkMember.UserName)#' IS '#trim(Form.Username)#'>
					<cfset Error = "That username is already in use, please choose another one.">
				<cfelseif '#checkMember.Email#' IS '#Form.Email#'>
					<cfset Error = "That email address is already in use.<br> If you have forgotten an old account, <a href='emailinfo.cfm'>click here</a>">
				</cfif>
			<cfelseif NOT #LEN(Form.Username)#>
				<cfset Error = "You did not entered a Username, please do so now.">
			<cfelseif NOT #LEN(Form.Email)#>
				<cfset Error = "You did not enter an email address, please do so now.">
			<cfelseif findnocase(' ', form.username, 1)>
				<cfset error = "Your username can not contain spaces.">
			</cfif>
			
			<!--- HHHHHHHHHHHHHHHHHHH IF THERE ARE NO ERRORS HHHHHHHHHHHHHHHHHHHHHHHHH  --->
			<cfif NOT #LEN(Error)#>
				
				<!--- Generate Password --->

				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="insertmember" returnvariable="insertmember">
				</cfinvoke>
				<cfoutput><center><table Border="0" width="#request.tablewidth#" cellpadding="2" cellspacing="0">
				<tr><td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<center><br><br><b>Thank you for registering with #request.forumtitle#.</b> </center>
				<br>
				<blockquote><blockquote>
				<cfif checkmemberoptions.generatepassword eq 1>
				You should be receiving  your temporary password via the email address that you 
				provided. If you have not received it within 24 hours, please feel free to contact us. Once you receive
				your password, you may visit our site at anytime to change your membership information.
				<cfelse>
				You should be receiving an email containing your membership information.
				If you have not received it within 24 hours, please feel free to contact us. You may visit our site at anytime to change your membership information.
				</cfif></blockquote></blockquote><br><br><br>
				
				</td></tr></table></center>
				</cfoutput>
				
		
			<cfif request.mailport eq ""><cfset request.mailport=25></cfif>
		<cfmail to="#Form.Email#"
		FROM="#request.forumemail#"
		Server="#request.mailserver#" 
		port="#request.mailport#" 
		subject="Membership Information to #request.forumtitle#"
		type="html">
		<html><head><title>#request.forumtitle#</title></head>
		<body bgcolor='#request.bgcolor#' Text='#request.text#' link='#request.link#' VLink='#request.vlink#' ALink='#request.alink#'>
		<table width="100%" border="0"><tr><td>
		<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.titlecolor#">
		<b>Welcome to #request.forumtitle#</b><br><br></font>
		<font face='#request.fontface#' size='#request.fontsize#' color='#request.text#'>
		
		Thank you for registering with #request.forumtitle#. <br><br>
		Your membership information is displayed below. To make changes to this <br>
		information, including changing your  password, please visit <br>
		<a href="#request.forumurl#/preferences.cfm">#request.forumurl#/preferences.cfm</a> . <br><br>
		To visit #request.hometitle#, please go to <a href="#request.homeurl#">#request.homeurl#</a> .<br><br>
			
		Your Username is &nbsp;&nbsp;&nbsp;  <b>  #Form.Username#   </b><br>
		Your Password is &nbsp;&nbsp;&nbsp;  <b>  #LogonPassword#   </b><br>
		Your Email Address is &nbsp;&nbsp; <b>  #form.email#   </b><br><br>
			
		Thanks again for becoming a member.<br>
		Regards, Webmaster - <a href="mailto:#request.forumemail#">#request.forumemail#</a>
		
		<br><br><br><br><font face="#request.fontface#" Color="#request.copycolor#" size="1">
		<center>Powered by <a href="http://www.cfcode.com/" target="_blank">&lt; CF FORUM &gt;</a> #request.release#</center></font><br><br><br><br>
		</td></tr></table>
		</body>
		</html>
		</cfmail>
				
				
			<cfelse>
		
		
			<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH   if error occurs HHHHHHHHHHHHHHHHHHHHHHHHHHHHH --->
			<center>
			<cfoutput>
			<table Border="0" width="#request.tablewidth#" cellpadding="2" cellspacing="0">
			<tr><td colspan=2>
			<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.text#">
			<center><b><br>#Error#<br><br></b></center></font>
			</td></tr>
			<tr><td><form action="index.cfm?page=#url.page#&forumaction=register" method="post">
				<input type="hidden" name="JoinedDate" value="#Now()#">	 	    
				<center>    
				<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.column2#"><td>
			<table width="100%" Border="0" cellpadding="2" cellspacing="1">
			<tr><td colspan=2 bgcolor="#request.catcolor#">
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#">
			<b><center>Membership Information</center></b></font> 
			</td></tr>
			<!--- UserName --->
			<tr><td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Username:</b>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)
			</td><td bgcolor="#request.column1#"><input type="text" name="Username" size=15 maxlength=15 value="#form.username#">
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>Up to 15 characters. Please... no spaces
			</td></tr>
			<!--- Email Address --->
			<tr><td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Email Address:</b>
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)
			</td><td bgcolor="#request.bgcolor#"><input type="text" name="Email" size=30 value="#form.email#">
			<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>example: JSmith@yahoo.com
			</td></tr>	
			<!--- Password --->
			<tr><td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<p align="right"><b>Password:</b>
			<cfif checkmemberoptions.generatepassword neq 1><font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.timecolor#">
			<br>(required)</cfif>
			</td>
			
			<td bgcolor="#request.column1#">
			<cfif checkmemberoptions.generatepassword eq 1>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.timecolor#">
			Since a temporary password will be emailed to you,  it 
			<br>    is very important that you enter a valid email address. 
			<cfelse>
			<input type="text" name="password" size=15 maxlenght=20 value="#form.password#">
			</cfif>
			</td></tr>
				
				<tr><td bgcolor="#request.column1#" colspan="2"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<center><br><input type="submit" name="JoinForum" value=" Submit my Information "><br><br></center>
				
				</td></tr></table></td></tr></table></center></form>
			</td></tr></table>
			</cfoutput></center>
			
			</cfif>
		
		
		<!--- HHHHHHHHHHHHHHHHHHHHH   DISAGREE HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH--->
		<cfelseif IsDefined("URL.Disagree")>
			
			<cflocation url="index.cfm" addtoken="no">
			<cfabort>
		
		<!--- HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH Forum Rules Agree/Disagree HHHHHHHHHHHHHHHHHHHHHHHH--->
		<cfelse>
		
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="forumrules" returnvariable="forumrules">
			</cfinvoke>
			<cfoutput><center>
			
			<table width="#request.tablewidth#" Border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td bgcolor="#request.column2#">
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<b>Membership to #request.forumtitle# is FREE. Please read the information below. If you agree, please click the "I AGREE!" 
					button to continue or if you disagree, please click the "I Disagree" button to cancel the registration .</b>
					</td>
				</tr>
				<tr>
					<td bgcolor="#request.column1#">
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					<br>#ParagraphFormat(forumrules.ForumRules)#
					<center>
					
					<table border=0 cellpadding=5>
						<tr>
							<td>
							<form action="index.cfm?page=#url.page#&forumaction=register&Agree=Yes" method="post"><input type="Submit" name="Agree" value=" I AGREE! "></form>
							</td>
							<td>
							<form action="index.cfm?page=#url.page#&forumaction=register&Disagree=Yes" method="post"><input  type="Submit" name="Disagree" value=" I Disagree. "></form>
							</td>
						</tr>
					</table></center>
					
					</td>
				</tr>
			</table></center>
			</cfoutput>
			</center>
		
		</cfif>

	</cffunction>
	
	<cffunction name="replytotopic" access="remote" output="true">
		<!-- replytotopic.cfm -->

		<cfif IsDefined("url.Forum") AND IsDefined("url.topic") AND IsNumeric(url.forum) AND IsNumeric(url.topic)>
		
		<cfset columns = "f.forumname,f.allowhtml,f.allowfileuploads,f.publicforum,f.notifymod,f.moderator,f.moderatoremail,f.approvalrequired,f.approvedfiletypes,f.maxfilesize, c.category">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
			<cfinvokeargument name="columns" value="#columns#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfparam name="error" default="">
		
		<cfset PageTitle = "#GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		
		<!--- Page Content Starts Here --->
		
		<!--- New PsuedoHTML Code Javascript buttons--->
		<script language="JavaScript">
			<cfinclude template="includes/pseudobuttons.js">
		</script>
		
		<!--- WHOIS --- JAVASCRIPT POP UP WINDOW --->
		<script language="JavaScript">
		
		function launch(newURL, newName, newFeatures, orgName) {
		var remote = open(newURL, newName, newFeatures);
		if (remote.opener == null)
		  remote.opener = window;
		remote.opener.name = orgName;
		return remote;
		}
		
		function Whois(ID) {
		myRemote = launch("whois.cfm?MemID="+ID+"",
						  "myRemote",
						  "height=450,width=400,alwaysLowered=0,alwaysRaised=0,channelmode=0,dependent=0,directories=0,fullscreen=0,hotkeys=1,location=0,menubar=0,resizable=0,scrollbars=1,status=0,titlebar=1,toolbar=0,z-lock=0",
						  "myWindow");
		}	
		</SCRIPT>
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		</center>
		
		<cfif Session.MemberLoggedIn IS NOT "Y">
			<cfoutput>
			<center>

			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="You have not logged in yet. <br><br> You must be a <a href='register.cfm'>registered member</a> to post messages.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>
			<cfabort>
			
		<!---  Check for Public Forum  --->
		<cfelseif GetForum2.PublicForum IS "N" AND Session.AdminSignedIn IS "N">
			
			<center><cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>	
			<br><br><br><b>Sorry, only administrators and moderators <br>can post messages in this forum.</b><br><br><br><br><br><br>
			</center>
			<cfabort>	
		
		<!--- Locked thread --->
		<cfelseif #GetTopic.ThreadLocked# IS 'Y'> 
		
			<cfoutput>
			<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<b><br><br><br>Sorry, this thread is locked.<br>	<br>	<br>
			<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"> Back to '#HTMLEditFormat(GetTopic.TopicTitle)#'</a></b></font></center>	
			</cfoutput>
			<cfabort>
		
		<cfelseif IsDefined("Form.MessageCopy")>
			
			<cfif Len(Form.MessageCopy)>		
					
				<!---  INSERT REPLY POST --->
				<cfif IsDefined("Form.InsertMessage")>	
				
					<!--- Upload file attachments --->				
					<cfif IsDefined("Form.filename")>
						<cfinvoke component="#application.websitepath#.utilities.forumactions" 
					method="fileattachments"></cfinvoke>
						
					</cfif>		 		
					
					<cfif NOT LEN(Error)>			
						<cfif IsDefined("Form.ShowSignature")>
							<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="membersig" returnvariable="membersig"></cfinvoke>
							<cfset MessageCopy = "#Form.MessageCopy#"&chr(10)&chr(10)&"#membersig.Signature#">
						<cfelse>
							<cfset MessageCopy = "#Form.MessageCopy#">
						</cfif>
						
						<!--- bad word filter --->
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay"
							method="badwordfilter" returnvariable="MessageCopy">
							<cfinvokeargument name="Message" value="#MessageCopy#">
						</cfinvoke>

						
						<cfif getforum2.ApprovalRequired is "y">
							<cfset IsApproved = "n">
						<cfelse>
							<cfset IsApproved = "y">
						</cfif>
						
						<!--- Subscribe user to topic --->
						<cfif IsDefined("Form.NotifyAuthor")>
						<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe"></cfinvoke>
						</cfif>
						
						<!--- Insert new message --->	
						<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
							method="insertnewmessage"></cfinvoke>
		<!--- Send email to subscribers --->
		<cfif forum.enabletopicsubscriptions eq 1>
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
							method="getsubscribers" returnvariable="getsubscribers"></cfinvoke>
		<cfif getsubscribers.RecordCount>    
		<cfmail query="getsubscribers" to="#getsubscribers.email#" from="#request.forumemail#" subject="[#request.forumtitle#] RE: #HTMLEditFormat(GetTopic.TopicTitle)#" Server="#application.mailserver#" port="#application.mailport#">
		Dear #username#,
		#Form.MemberName# has responded to a topic that you 
		subscribed to at #trim(request.forumtitle)#.
		
		Topic: #GetTopic.TopicTitle#
		
		To view the new message, please visit the link below.
		#request.forumurl#/viewmessages.cfm?Forum=#Form.ForumID#&Topic=#Form.TopicID#
		
		If you would like to un-subscribe from this topic, 
		you may do so by visiting the following link.
		#request.forumurl#/subscribe.cfm?forum=#Form.ForumID#&topic=#Form.TopicID#&sub=topic
		
		Thank you for visiting #trim(request.forumtitle)#.
		
		
		
		
		
										   Powered by CF Forum
											 www.cfforum.com
		</cfmail>    
		</cfif>	
		</cfif>
										
						<!--- notify moderator of new message --->			
						<cfif GetForum2.NotifyMod IS 'Y'>
		<cfmail to="#GetForum2.ModeratorEmail#" from="#request.forumemail#" subject="[#request.forumtitle#] New reply to #HTMLEditFormat(GetTopic.TopicTitle)#" Server="#application.mailserver#" port="#application.mailport#">
		#Form.MemberName# has posted a message at #GetForum2.ForumName#.
		
		Topic: #GetTopic.TopicTitle#
		Message:
		#MessageCopy#
		
		To view the message, please visit the following link.
		#request.forumurl#/viewmessages.cfm?Forum=#Form.ForumID#&Topic=#Form.TopicID#
		
		Thank you for helping moderate #request.forumtitle#.
		</cfmail>  
						</cfif>			
							
				
						<!--- display "thank you" page --->
						<cfoutput>
						<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="2;URL=viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">'>
						<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<b><br><br><br>Thank you, #Form.MemberName#. <br> <br>Your message has been posted successfully .<br><br><br><br><br>
						<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"> Back to "#HTMLEditFormat(GetTopic.TopicTitle)#"</a></b></font></center><br><br><br>	
						</cfoutput>
					<cfabort>
					</cfif>
					</cfif>
					
			
				<!---  error-  missing information --->
				<cfelse>	        
					
					<Cfset error ="You must enter information into the message field below.">           
			</cfif>
			
			
		
		</cfif>
		
		
		<!--- Default "reply to message" page --  --->
		
		<cfoutput><br><br>
		<cfif Len(error)><center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#error#</b></font></center><br><br></cfif>
		
		<script language="javascript">					
		function WinOpen(url,x,y) {
				var attributes = "toolbar=no,scrollbars=yes,resizable=yes,width=" + x + ",height=" + y;
				msgWindow=window.open(url,"WinOpen",attributes);
		}					
		</script>
		
		<form action="index.cfm?page=#url.page#&forumaction=replytotopic&Forum=#URL.Forum#&Topic=#URL.Topic#" method="post" name="PostTopic" enctype="multipart/form-data">
		<input type="hidden" name="MemberID" value="#session.MemberID#">
		<input type="hidden" name="MemberName" value="#session.UserName#">
		<input type="hidden" name="Email" value="#session.Email#">
		<input type="hidden" name="ForumID" value="#URL.Forum#">
		<input type="hidden" name="TopicID" value="#URL.Topic#">
		<input type="hidden" name="MessageDate" value="#NOW()#">
		<input type="hidden" name="TopicTitle" value="#HTMLEditFormat(GetTopic.TopicTitle)#">
		<input type="hidden" name="IPAddress" value="#cgi.REMOTE_ADDR#">
		<input type="hidden" name="ispoll" value="0">
		<center>
		<table  Border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#request.column2#">
					<table width="100%" Border="0" cellpadding="2" cellspacing="1">
						<tr>
							<td bgcolor="#request.catcolor#" colspan=2>
							<center><font face="#request.fontface#"  color="#request.cattextcolor#" size="#request.fontsize#"><b>Reply to Topic</b></font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.bgcolor#"><p align="Right">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Topic Title:</font>
							</td>
							<td bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#HTMLEditFormat(GetTopic.TopicTitle)#</b></font>
							</td>
						</tr>
						</cfoutput>
						
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="topicicon"></cfinvoke>
						<cfoutput>
						<tr>
							<td valign="top" bgcolor="#request.bgcolor#"><p align="Right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Message:</font></p>				
							<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
						   <cfif #GetForum2.AllowHTML# IS 'Y'><li> HTML is Allowed<cfelse><li> HTML is not Allowed</cfif>
		
							<br><li> PseudoHTML is On			   	
						
							</font><br><br><br>				
							</td>
							<td bgcolor="#request.bgcolor#"><textarea name="MessageCopy" cols="55" rows="10" wrap="PHYSICAL"><cfif IsDefined("form.messagecopy")>#form.messagecopy#</cfif></textarea><br>
						
							
							</cfoutput>
							<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="pseudobuttons"></cfinvoke>
							<cfoutput>
							
							<cfif GetForum2.AllowFileUploads IS 'Y'>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.bgcolor#"><p align="Right">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">File Attachment:</font>
							</td>
							<td bgcolor="#request.bgcolor#">
							<cfif isdefined("form.AttachedFile")>
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							#form.AttachedFile#</font>
							<cfelse>
							<input type="file" name="filename" size=35>
							</cfif>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.bgcolor#">&nbsp;
							</td>
							<td bgcolor="#request.bgcolor#">
							</cfif>
							
							<br>
							<input type="Checkbox" name="ShowSignature" Value="Yes" checked>
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Show my signature in this message.</font><br>					
							<cfif forum.enabletopicsubscriptions eq 1>
							<input type="Checkbox" name="NotifyAuthor" Value="Y">
							<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Notify me when someone replies.</font><br>
							</cfif><br>
							</td>
						</tr>
						<tr>
							<td colspan=2 bgcolor="#request.bgcolor#">
							<center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<cfif getforum2.ApprovalRequired is "y"><br>
							Note: All messages posted to this discussion group require <br>
							approval from an administrator or moderator before being displayed.<br>
							</cfif> 
							<input type="button" name="Preview" value="  Preview  " onclick="WinOpen('previewmessages.cfm?forum=#url.forum#','550','400'); return false;">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="submit" name="InsertMessage" value="   Reply to Topic   " >
							</font></center>
							</td>
						</tr>	
					</table>
				</td>
			</tr>
		</table>
		</form></cfoutput>
		
		
		<!--- ==== DISPLAY THREAD === --->
		<iframe src="<cfoutput>viewmessages2.cfm?Forum=#url.Forum#&Topic=#url.Topic#</cfoutput>" scrolling="true" width="<cfoutput>#request.tablewidth#</cfoutput>" height="250">
		
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="viewmessages"></cfinvoke>
		</iframe>	
		</center>
		
		<!--- Page Content Stops Here --->
		
		<cfelse>
			<cflocation url="index.cfm" addtoken="No">
		</cfif>



	</cffunction>
	
	<cffunction name="search" access="remote" output="true">
		
		<cfif request.LoginRequired is 'y' and session.memberloggedin neq 'y'>
			<cfoutput>
			<center>
			<br>
			<!--- dsp_mainnavlinks.cfm --->
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
				<cfinvokeargument name="page" value="Login">
				<cfinvokeargument name="restrictaccess" value="1">
			</cfinvoke>
			<br>
						
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="You have not logged in yet. <br><br> You must be a <a href='register.cfm'>registered member</a> to search these forums.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<!--- Page Content Starts Here --->
		<center>
		<br>
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="Search">
		</cfinvoke>
		<br>
		
		<cfset error="">
		
		<cfif IsDefined("Form.Search") OR IsDefined("URL.Username")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="search" returnvariable="search">
			</cfinvoke>
			<cfif #Search.RecordCount# IS '0'>
				
				<cfset error = "Your search returned 0 topics.">		
		
			<cfelse>
			
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<cfif IsDefined("url.bookmarks")> 
					<b>You have #search.recordcount# discussion<cfif search.recordcount gt 1>s</cfif> book marked.</b>
				<cfelse>
					<b>Your search returned #Search.RecordCount# discussions.</b>
				</cfif><br><br>
				<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0">
				  <tr bgcolor="#request.catcolor#">
					<td>
					  <table width="100%" Border="0" cellpadding="2" cellspacing="1">
						<tr>
						  <td bgcolor="#request.catcolor#" colspan=2><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Discussions</font></td>
						  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Forum</font></td>
						  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Posted By</center></font></td>
						  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Views</center></font></td>
						  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Replies</center></font></td>
						  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Last Post</center></font></td>
						</tr>
				</cfoutput>	
				
				<cfloop query="Search" startrow="1" endrow="#search.RecordCount#">
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getposts" returnvariable="getposts">
				</cfinvoke>
						<tr><cfoutput>
						  <td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><cfif #DateCompare(Session.UsersLastVisit,GetPosts.LastMessageDate)# IS -1 ><img src="#request.imagedir#newpost.gif"><cfelseif #GetPosts.ThreadLocked# IS 'Y'><img src="#request.imagedir#locked.gif"><cfelse><img src="#request.imagedir#post.gif"></cfif></td>
						  <!--- added HTMLEditFormat to following line - See revision notes--->
						  <td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><a href="viewmessages.cfm?Forum=#Getposts.ForumID#&Topic=#Getposts.TopicID#<cfif isdefined('form.keywords')>&keywords=#urlencodedformat(form.keywords)#</cfif>"><cfset topictitle = '#HTMLEditFormat(Getposts.TopicTitle)#'>
						  <cfinvoke component="#application.websitepath#.utilities.forumactions"
							  method="highlightsearchwords" returnvariable="keywords">
								<cfinvokeargument name="keywords" value="#form.keywords#">
						  </cfinvoke>
						  <cfinvoke component="#application.websitepath#.utilities.forumactions"
							  method="highlightsearchwords" returnvariable="TopicTitle">
								<cfinvokeargument name="TopicTitle" value="#Getposts.TopicTitle#">
						  </cfinvoke>
						  #topictitle#</a></b></font></td>
						  <td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#Getposts.ForumName#</font></td>        
						  <td valign="top" bgcolor="#request.column2#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#Getposts.MemberName#</font></td>
						  <td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><center>#Getposts.Views#</center></font></td>
						  <td valign="top" bgcolor="#request.column2#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
						  <cfinvoke component="#application.websitepath#.utilities.forumqueries" 
							method="messagecount" returnvariable="MessageCount">
							<cfinvokeargument name="TopicID" value="#GetPosts.TopicID#">
						</cfinvoke>
						  <center><cfoutput>#Evaluate(MessageCount.messagecount - 1)#</center></font></td>
						  <td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#" nowrap><font face="#request.fontface#" color="#request.timecolor#" size="#evaluate(request.fontsize - 1)#"> #DateFormat(GetPosts.LastMessageDate,'m-d-yy')# @ #TimeFormat(GetPosts.LastMessageDate,'h:mm tt')#</center></font></td>
						</tr></cfoutput>
				
				</cfloop>	
					  </table>
					</td>
				  </tr>
				</table><br>	</center>	
				<cfabort>
				
			</cfif>
		
		</cfif>
		
		
		<cfoutput>
		
		<cfif Len(error)>
		<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
		<b>#Error#</b><br><br></font>
		</cfif>
		
		<form action="index.cfm?page=#url.page#&forumaction=search" method="post">
		<table Border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#request.catcolor#">
					<table width="100%" Border="0" cellpadding="5" cellspacing="1">
						<tr>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							Keywords:
							</td>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<input type="text" name="Keywords" maxlength="30"><br>
							<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.copycolor#">
							separate with spaces, do not use commas</font>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							In the past:
							</td>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<select name="Days"><option value="" >  <option value="2" >2 days<option value="5" >5 days<option value="10" >10 days<option value="20" >20 days<option value="30" >30 days<option value="60" selected>60 days<option value="90">90 days<option value="120">120 days<option value="365">365 days</select>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							Forum:
							</td>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							</cfoutput>
						
							<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
								method="getforumlist" returnvariable="getforumlist">
							</cfinvoke>
						
							<select name="Forums"><option value="All" selected>All Forums
							<cfoutput query="GetForumList">
								<cfif (NOT len(GetForumList.forumpassword) OR listcontains(session.authorizedforums, GetForumList.forumid, ',') OR session.accesslevel gte 3) AND (getforumlist.publicview neq 'n' OR session.accesslevel gte 3)>
								<option value="#ForumID#">#ForumName#</option>
								</cfif>
							</cfoutput></select>
							</td>
						</tr><cfoutput>
						<tr>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							Username:
							</td>
							<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
							<input type="text" name="UserName" maxlength="30"><br>
							<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.copycolor#">
							full or partial username is acceptable.</font>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#" colspan=2><center><input type="Submit" name="Search" Value="  Search Now  "></center>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</cfoutput>
		</form>
		</center>

	</cffunction>
	
	<cffunction name="smilies" access="remote" output="true">
		<cfoutput>

		
		<script language="Javascript">
		<!-- hide
		
		function Smile(smilieface){
				window.opener.document.PostTopic.MessageCopy.value+=smilieface;
				window.close();
		}
		// -->
		</script>

		<center>
		<table width="100%" Border="0" cellpadding="1" cellspacing="0">
			<tr>
				<td bgcolor="#request.catcolor#">
					<table width="100%" Border="0" cellpadding="1" cellspacing="0">
						<tr>
							<td colspan="3" bgcolor="#request.catcolor#"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" >
							<b><center>How to use Smilies</center></b>
							</td>
						</tr>	
						<tr>
							<td colspan="3" bgcolor="#request.column1#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#"  Color="#request.text#" >
							<center>Click on the face you would like to insert into your message.</center></font>
							</td>
						</tr>	
						<tr>
							<td bgcolor="#request.column2#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#"  Color="#request.text#" >
							<center>image</center></font>
							</td>
							<td bgcolor="#request.column2#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#"  Color="#request.text#" >
							<center>emotion</center></font>
							</td>
							<td bgcolor="#request.column2#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#"  Color="#request.text#" >
							<center>tag</center></font>
							</td>
						</tr>				
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :)');"><img src="images/smile.gif" width="15" height="15" alt="Smile" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Smile</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :) </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' ;)');"><img src="images/smilewink.gif" width="15" height="15" alt="Wink" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Wink</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > ;) </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :confuse:');"><img src="images/smileconfuse.gif" width="15" height="15" alt="Confused" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Confused</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :confuse: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :quest:');"><img src="images/smileconfused.gif" width="15" height="22" alt="Question" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Question</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :quest: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :|');"><img src="images/smileindiff.gif" width="15" height="15" alt="Indifference" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Indifference</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :| </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' ;p');"><img src="images/smilewinktongue.gif" width="15" height="15" alt="Playful Wink" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Playful Wink</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > ;p </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :p');"><img src="images/smilesillytongue.gif" width="15" height="15" alt="Playful" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Playful</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :p </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :8|:');"><img src="images/smilecoolindiff.gif" width="15" height="15" alt="Cool Indifference" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Cool</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :8p: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :8o:');"><img src="images/smilescared.gif" width="15" height="15" alt="Scared" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Scared</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :80: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :eg:');"><img src="images/smileevil.gif" width="15" height="15" alt="Evil Grin" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Evil Grin</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :eg: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :mad:');"><img src="images/smilemad.gif" width="15" height="15" alt="Mad" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Mad</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :mad: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :gasp:');"><img src="images/smileredoh.gif" width="15" height="15" alt="Gasp" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Gasp</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :gasp: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :blush:');"><img src="images/smileredsilly.gif" width="15" height="15" alt="Blush" border="0"></a>&nbsp;
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Blush</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :blush: </font></center>
							</td>
						</tr>
						<tr>
							<td bgcolor="#request.column1#">					
								<a href="Javascript:Smile(' :(');"><img src="images/smilefrown2.gif" width="15" height="15" alt="Frown" border="0"></a>
							</td>
							<td bgcolor="#request.column1#">
								<font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" >Frown</font>
							</td>
							<td bgcolor="#request.column1#">
								<center><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.text#" > :( </font></center>
							</td>
						</tr>							
					</table>
				</td>
			</tr>
		</table><br>
		</center>
		
		</cfoutput>
	</cffunction>
	
	<cffunction name="subscribe" access="remote" output="true">
		<cfparam name="request.sub2what" default="topic">
		<cfif isdefined('url.sub')>
			<cfset request.sub2what = '#url.sub#'>
		</cfif>
		
		<cfset PageTitle = "Subscribe to #request.sub2what#">
		<cfset PageSection = "viewmessages">
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="Subscribe to #request.sub2what#">
		</cfinvoke>
		<br><br>
		
		<cfif Session.MemberLoggedIn neq "Y">	
			<cfoutput>
			<center>	
		
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="Only <a href='register.cfm'>registered</a> members can subscribe to this #request.sub2what#<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		
		
		<!--- check to see if member is already subscribed. --->	
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checksubscriptions" returnvariable="checksubscriptions">
		</cfinvoke>
		<cfif request.sub2what eq "forum">
			<cfif forum.enableforumsubscriptions neq 1>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewtopics.cfm?forum=#url.forum#">'>		
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>Sorry, this feature has been disabled by the administrator</b> <br><br>
				<a href="viewtopics.cfm?forum=#url.forum#"><b>Return to forum</b></a></font>
				</cfoutput>
			<cfelseif checksubscriptions.recordcount eq 0>		
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewtopics.cfm?forum=#url.forum#">'>		
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe">
				</cfinvoke>
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>You have successfully subscribed to this forum.</b> <br>You will be notified via email when a new topic is posted.<br><br>
				<a href="viewtopics.cfm?forum=#url.forum#"><b>Return to forum</b></a></font>		
				</cfoutput>
			<cfelse>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewtopics.cfm?forum=#url.forum#">'>		
				<cfset request.unsubid = checksubscriptions.subscriptionid>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe">
				</cfinvoke>
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>You have successfully unsubscribed from this forum.</b> <br>You will no longer be notified via email when a new topic is posted.<br><br>
				<a href="viewtopics.cfm?forum=#url.forum#"><b>Return to forum</b></a></font>
				</cfoutput>
			</cfif>
		<cfelse>
			<cfif forum.enabletopicsubscriptions neq 1>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewmessages.cfm?forum=#url.forum#&topic=#url.topic#">'>		
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>Sorry, this feature has been disabled by the administrator</b> <br><br>
				<a href="viewmessages.cfm?forum=#url.forum#&topic=#url.topic#"><b>Return to topic</b></a></font>
				</cfoutput>
			<cfelseif checksubscriptions.recordcount eq 0>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewmessages.cfm?forum=#url.forum#&topic=#url.topic#">'>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe">
				</cfinvoke>
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>You have successfully subscribed to this topic.</b> <br>You will be notified via email when a new message is posted.<br><br>
				<a href="viewmessages.cfm?forum=#url.forum#&topic=#url.topic#"><b>Return to topic</b></a></font>
				</cfoutput>
			<cfelse>
				<CFHTMLHEAD TEXT='<meta http-equiv="refresh" content="3;URL=viewmessages.cfm?forum=#url.forum#&topic=#url.topic#">'>
				<cfset request.unsubid = checksubscriptions.subscriptionid>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="topicsubscribe">
				</cfinvoke>
				<cfoutput>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<br><br><b>You have successfully unsubscribed from this topic.</b> <br>You will no longer be notified via email when a new message is posted.<br><br>
				<a href="viewmessages.cfm?forum=#url.forum#&topic=#url.topic#"><b>Return to topic</b></a></font>
				</cfoutput>
			</cfif>
		
		</cfif>
		
		<br><br><br>
		
		</center>
	</cffunction>
	
	<cffunction name="todaytopics" access="remote" output="true">
		<cfset PageTitle = "Today's Active Discussions">
		<cfset PageSection = "Search">
		
		<!--- Page Content Starts Here --->
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="Today's Topics">
		</cfinvoke>
		<br>
		</center>
			
			<center>
			<cfset TDay = #Now()#>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="search" returnvariable="search">
			</cfinvoke>
			<cfif #Search.RecordCount# IS '0'>
				<cfoutput>
				<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.text#">
				<br><br><br><br><b>There are #Search.RecordCount# active discussions today.</b><br><br><br><br><br>
				</cfoutput>
			<cfelse>
				<cfoutput>
				<font face="#request.fontface#" size="#evaluate(request.fontsize + 1)#" color="#request.text#">
				<b>There <cfif #Search.RecordCount# GT 1>are<cfelse>is</cfif> #Search.RecordCount# active discussion<cfif #Search.RecordCount# GT 1>s</cfif> today.</b><br><br>
				<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.catcolor#"><td>
				<table width="100%" Border="0" cellpadding="2" cellspacing="1">
				<tr>
				<td bgcolor="#request.catcolor#" colspan=2><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Discussions</font></td>
				<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Forum</font></td>
				<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Posted By</center></font></td>
				<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Views</center></font></td>
				<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Replies</center></font></td>
				<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#"><center>Last Post</center></font></td>
				</tr></cfoutput>	
				<cfloop query="Search" startrow="1" endrow="#search.RecordCount#">
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getposts" returnvariable="getposts">
				</cfinvoke>
				<tr><cfoutput>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><cfif #DateCompare(Session.UsersLastVisit,GetPosts.LastMessageDate)# IS -1 ><img src="#request.imagedir#newpost.gif"><cfelseif #GetPosts.ThreadLocked# IS 'Y'><img src="#request.imagedir#locked.gif"><cfelse><img src="#request.imagedir#post.gif"></cfif></td>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><a href="viewmessages.cfm?Forum=#Getposts.ForumID#&Topic=#Getposts.TopicID#">#Getposts.TopicTitle#</a></b></font></td>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">#Getposts.ForumName#</font></td>        
				<td valign="top" bgcolor="#request.column2#"><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">#Getposts.MemberName#</font></td>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><center>#Getposts.Views#</center></font></td>
				<td valign="top" bgcolor="#request.column2#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="messagecount" returnvariable="MessageCount">
					<cfinvokeargument name="TopicID" value="#GetPosts.TopicID#">
				</cfinvoke>
				<center><cfoutput>#Evaluate(Messagecount.messagecount - 1)#</center></font></td>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#" nowrap><font face="#request.fontface#" color="#request.timecolor#" size="#evaluate(request.fontsize - 1)#"> #DateFormat(GetPosts.LastMessageDate,'m-d-yy')# @ #TimeFormat(GetPosts.LastMessageDate,'h:mm tt')#</center></font></td>
				</tr></cfoutput>
				</cfloop>	
				</table></td></tr></table><br>		
				
			</cfif>
		</center>
	</cffunction>
	
	<cffunction name="unlockthread" access="remote" output="true">
		<!-- unlockthread.cfm -->

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>
		
		<cfset PageTitle = "UNLOCKING #GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<center>
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="reply to topic">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		</center>
		
		<!--- Page Content Starts Here --->
		<cfparam name="error" default="">
		
		<cfif IsDefined("Form.LockThread")>
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getadmin" returnvariable="getadmin">
			</cfinvoke>
			<cfif #GetAdmin.RecordCount# AND #GetAdmin.AccessLevel#  GT 1>
			
				<cfset action="unlock">	
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="lockthread">
				</cfinvoke>
				<cfoutput><center>
				<font face="#request.fontface#" size="#evaluate(request.fontsize+1)#" color="#request.text#">
				<b><br>	<br>The discussion has been unlocked successfully.</b><br><br>
				<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#">Back to discussion.</a><br><br><br><br><br>
				</cfoutput>
				<cfabort>
				
			<cfelse>	
				<cfset Error = "Sorry, that is incorrect. Please Try Again.">
			</cfif>
		</cfif>
		
		<cfoutput><center><br><br>
		<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>
		<cfif len(error)>#error#<br><br></cfif>
		
		Discussions can only be unlocked by <br>
		Administrators and Moderators.</b></font>
		<form action="index.cfm?page=#url.page#&forumaction=unlockthread&Forum=#URL.Forum#&Topic=#URL.Topic#" method="post">
		<table border=0 cellspacing=1 cellpadding=1>
			<tr>
				<td bgcolor="#request.catcolor#">
				
				<table border=0 cellpadding=5 cellspacing=0>
					<tr>
						<td bgcolor="#request.column2#" colspan="2">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<b><center>Administrator/Moderator Sign In:</center></b>
						</td>
					</tr>
					<tr>
						<td bgcolor="#request.column1#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						Username:
						</td>
						<td bgcolor="#request.column1#">
						<input type="text" name="Username" size="20" <cfif IsDefined("Cookie.Username")>value="#decrypt(Cookie.Username, request.key)#"</cfif> 
						</td>
					</tr>
					<tr>
						<td bgcolor="#request.column1#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						Password:
						</td>
						<td bgcolor="#request.column1#">
						<input type="Password" name="Password" size="20" <cfif IsDefined("Cookie.Password")>value="#decrypt(Cookie.Password, request.key)#"</cfif>>
						</td>
					</tr>
					<tr>
						<td bgcolor="#request.column1#" colspan="2">
						<center><input type="submit" name="LockThread" value="   Continue...  "></center>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		</form>
		</cfoutput>
	</cffunction>
	
	<cffunction name="update" access="remote" output="true">
		

		<cfset DS = request.DS>
		
		
		<cftry>
		<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="showfname">select showfname from forumvariables</cfquery>
		<cfcatch type="database">
		<cfif request.dbType eq 'Access'>
		<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showfname integer null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showlname integer null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showbday integer null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom1 text(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom2 text(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom3 text(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom4 text(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom5 text(50) null</cfquery>
		<cfelseif request.dbType eq 'SQL'>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showfname int null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showlname int null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="name">alter table forumvariables add showbday int null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom1 varchar(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom2 varchar(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom3 varchar(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom4 varchar(50) null</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="labelcustom">alter table forumvariables add labelcustom5 varchar(50) null</cfquery>
		</cfif>
		</cfcatch>
		</cftry>
		
		<!-- topic subscriptions -->
		<cftry>
		<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">select * from forumsubscriptions</cfquery>
		<cfcatch type="database">
		<cfif request.dbType eq 'Access'>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">CREATE TABLE forumsubscriptions ( subscriptionid COUNTER CONSTRAINT PrimaryKey PRIMARY KEY , forumid integer NOT NULL, topicid integer NULL, memberid integer NOT NULL, emailaddress text(75) NULL)</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">alter table forumvariables add enabletopicsubscriptions integer null</cfquery>
		<cfelseif request.dbType eq 'SQL'>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">CREATE TABLE subscriptions ( subscriptionid int IDENTITY (1, 1) NOT NULL PRIMARY KEY, forumid int NOT NULL, topicid int NULL, memberid int NOT NULL, emailaddress varchar(75) NULL)</cfquery>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">alter table forumvariables add enabletopicsubscriptions int null</cfquery>
		</cfif>
		</cfcatch>
		</cftry>
		<!-- forum subscriptions -->
		<cftry>
		<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="generatepassword">select enableforumsubscriptions from forumvariables</cfquery>
		<cfcatch type="database">
		<cfif request.dbType eq 'Access'>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">alter table forumvariables add enableforumsubscriptions integer null</cfquery>
		<cfelseif request.dbType eq 'SQL'>
			<cfquery datasource="#application.ForumDSN#" 
				username="#application.ForumDSNuName#" password="#application.Forumdsnpword#"
				name="subscriptions">alter table forumvariables add enableforumsubscriptions int null</cfquery>
		</cfif>
		</cfcatch>
		</cftry>

		<cfoutput>
		<<center><font face=verdana,arial><b><br><br><br><br>
		Your #request.DS# database has been updated.<br><br><br></b>
		<a href="index.cfm">Visit your forum</a></font></center>
		</cfoutput>

	</cffunction>
	
	<cffunction name="viewmessages" access="remote" output="true">
		<!-- viewmessages.cfm -->
		<cfif request.LoginRequired is 'y' and session.memberloggedin neq 'y'>
			<cfset PageTitle = "messages">
			<cfset PageSection = "Messages">
			<cfoutput>
			<center><br>
			<!--- dsp_mainnavlinks.cfm --->
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
				<cfinvokeargument name="page" value="Login">
				<cfinvokeargument name="restrictaccess" value="0">
			</cfinvoke>
			<br>				
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="Welcome to #request.forumtitle#.<br> You must be a <a href='register.cfm'>registered member</a> to view this topic.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		<cfif IsDefined("url.Forum") AND IsDefined("url.topic") AND IsNumeric(url.forum) AND IsNumeric(url.topic)>
		
		<cfif isdefined("form.messageid")>
			<cfset Messageid = "#form.messageid#">
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="approvemessage" returnvariable="approvemessage">
				<cfinvokeargument name="MessageID" value="#MessageID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="addhit">
				<cfinvokeargument name="page" value="message">
			</cfinvoke>
		</cfif>
		
		<!--- includes/queries/act_bookmarktopic.cfm  --->
		<cfinvoke component="#application.websitepath#.utilities.forumactions" 
			method="bookmarktopic">
			<cfinvokeargument name="topicid" value="#URL.Topic#">
		</cfinvoke>
		<cfset columns = "f.forumname, c.category, f.moderator,f.forumpassword, f.moderatoremail, f.allowhtml">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="membertitles" returnvariable="membertitles">
		</cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checksubscriptions" returnvariable="checksubscriptions">
		</cfinvoke>
		
		<cfif gettopic.recordcount eq 0>
			<cflocation url="viewtopics.cfm?forum=#url.forum#" addtoken="no">
		</cfif>
		
		<cfset PageTitle = "#GetTopic.TopicTitle#">
		<cfset PageSection = "Messages">
		
		<!--- Close Forums --->
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="forumdown">
		</cfinvoke>
		
		<script language="javascript">					
			function PopWin(url,x,y) {
					var attributes = "toolbar=no,scrollbars=yes,resizable=yes,width=" + x + ",height=" + y;
					msgWindow=window.open(url,"PopWin",attributes);
			}					
		</script>
		
		<cfif len(trim(getforum2.forumpassword)) and not listcontains(session.authorizedforums, url.forum, ',') and session.accesslevel lt 5>
		
		 <cflocation url="viewtopics.cfm?forum=#url.forum#" addtoken="no">
		
		<cfelse>
		
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="gettopicidlist" returnvariable="gettopicidlist">
		</cfinvoke>
		<cfset NextList = "">
		<cfloop query="gettopicidlist">
			<cfif NextList IS ""><cfset NextList = "#TopicID#"><cfelse><cfset NextList = "#NextList#,#TopicID#" ></cfif>
		</cfloop>
		
		<!--- Next ---><cfif #ListLen(NextList, ',')# GT #ListFind(nextlist, URL.Topic, ',')#><cfset Next = #evaluate(ListFind(nextlist, URL.Topic , ',')+1)#><cfelse><cfset Next = #ListFind(nextlist, URL.Topic, ',')#></cfif>
		<cfset NextTopicID = '#ListGetAt(NextList, Next, ',')#'>
		<!--- Prev ---><cfif #ListFind(nextlist, URL.Topic, ',')# LTE 1><cfset Prev = #ListFind(nextlist, URL.Topic, ',')#><cfelse><cfset Prev = #evaluate(ListFind(nextlist, URL.Topic , ',')-1)#></cfif>
		<cfset PrevTopicID = '#ListGetAt(NextList, Prev, ',')#'>
		
		<cfoutput>
		<center>
		
		<br>	
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="mainnavlinks">
			<cfinvokeargument name="page" value="viewmessages">
			<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
			<cfinvokeargument name="forumid" value="#URL.Forum#">
			<cfinvokeargument name="Topic" value="#HTMLEditFormat(Gettopic.TopicTitle)#">
		</cfinvoke>
		<br>
		
		<table width="#request.tablewidth#" Border="0" cellpadding="1" cellspacing="0"><tr bgcolor="#request.catcolor#"><td>
		<table width="100%" Border="0" cellpadding="0" cellspacing="0"><TR bgcolor="#request.column1#">
		<cfif #GetTopic.ThreadLocked# IS 'Y'>
		<TD width="70%" valign="top"><img src="#request.imagedir#locked.gif" alt="Discussion is Locked." border="0" align=top><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">This discussion has been locked by #GetTopic.ThreadLockedBy#.</font>
		<cfelse>
		<TD>
			<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">	
			<cfif #Len(Trim(GetForum2.Moderator))#>	
			moderated by <a href="mailto:#GetForum2.ModeratorEmail#">#GetForum2.Moderator#</a>&nbsp;
			<cfelse>
			&nbsp;&nbsp;
			</cfif>
			</font>
		</cfif>
		<cfif IsDefined("GetTopic.ThreadLocked")>	<cfif #GetTopic.ThreadLocked# IS NOT 'Y'>
		</td><td align="center" valign="top" nowrap>
		<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
		<a href="replytotopic.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"><cfif len(request.replyimage)><img src="#request.imagedir##request.replyimage#"  alt="Reply to this Discussion" border="0" align="bottom"></cfif><b>Reply to Discussion</b></a>
		 | <a href="posttopic.cfm?Forum=#URL.Forum#"><b><cfif len(request.newtopicimage)><img src="#request.imagedir##request.newtopicimage#"  alt="Start new discussion" border="0"></cfif>New Discussion</b></a>
		 <!--- Subscribe --->	
			<cfif forum.enabletopicsubscriptions eq 1>			| 		
			<a href="subscribe.cfm?forum=#URL.Forum#&topic=#url.topic#&sub=topic"><cfif checksubscriptions.recordcount neq 0> Unsubscribe<cfelse> Subscribe</cfif></a>
			</cfif>	
		 </font>
		</cfif></cfif>
		</td><td align="right" nowrap>
				<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
				<cfif #PrevTopicID# IS NOT #URL.Topic#> << <a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#PrevTopicID#" title="Previous Discussion">previous </a></cfif>  
				<cfif #PrevTopicID# IS NOT #URL.Topic# and #NextTopicID# IS NOT #URL.Topic#> || </cfif>
				<cfif #NextTopicID# IS NOT #URL.Topic#><a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#NextTopicID#" title="Next Discussion">next </a> >></cfif>&nbsp;
		</td></tr></table></td></tr></table>
		
		<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr bgcolor="#request.catcolor#"><td>
			<table width="100%" Border="0" cellpadding="2" cellspacing="1">
				<tr bgcolor="#request.column1#" width="50">
					<td NOWRAP bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Posted By</font></td>
					<td bgcolor="#request.catcolor#"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#request.fontsize#"><cfif gettopic.ispoll eq 1>Poll<cfelse>Discussion</cfif> Topic: <cfset topictitle = '#HTMLEditFormat(GetTopic.TopicTitle)#'>
					
					<cfinvoke component="#application.websitepath#.utilities.forumactions"
					  method="highlightsearchwords" returnvariable="TopicTitle">
						<cfinvokeargument name="TopicTitle" value="#topictitle#">
				  </cfinvoke>
					#topictitle#
					
					<cfif IsDefined("Cookie.ShowHowMany") and isnumeric(cookie.showhowmany) and cookie.showhowmany neq 0>
						<cfset ShowHowMany = '#Cookie.ShowHowMany#'>
					<cfelse>
						<CFSET ShowHowMany = '10'>
					</cfif>
					
					<cfif gettopic.messagecount gt ShowHowMany>
						-- page: 
							<cfset page = 1>					
							<cfset er = showhowmany>
							<cfloop from="1" to="#gettopic.messagecount#" index="i" step="#showhowmany#">
								<cfset SR = i>
								<a href="viewmessages.cfm?Forum=#url.forum#&Topic=#url.topic#&srow=#sr#&erow=#er#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>"><font face="#request.fontface#" Color="#request.cattextcolor#" size="#request.fontsize#">#page#</font></a>
								<cfset page = page + 1>
								<cfset er = er + showhowmany>
							</cfloop>
					</cfif>
					</font>
					</td>
					<td bgcolor="#request.catcolor#"valign="top"><p align="right">
						
						<!--- Subscribe --->				
						<cfif forum.enabletopicsubscriptions eq 1>					
						<a href="subscribe.cfm?forum=#URL.Forum#&topic=#url.topic#&sub=topic"><img src="#request.imagedir#bookmark.gif"  alt="<cfif checksubscriptions.recordcount neq 0> un-subscribe from <cfelse> subscribe to </cfif> this topic" border="0" align="middle"></a>
						</cfif>				
						
						<a href="printthread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#" target="_blank"><img src="#request.imagedir#printthread.gif" alt="Printer-friendly Version" border=0 align="middle"></a>&nbsp;
						<a href="javascript:PopWin('emailthread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#', '400', '300');"><img src="#request.imagedir#emailthread.gif" alt="send this discussion to a friend" border=0 align="middle"></a>&nbsp;
						<cfif IsDefined("url.sortby")>
							<cfif url.sortby is "desc">
								 <a href="viewmessages.cfm?Forum=#url.forum#&Topic=#url.topic#&sortby=asc"><img src="#request.imagedir#up.gif"  align="middle" alt="new posts first" border=0></a>
							<cfelse>
								<a href="viewmessages.cfm?Forum=#url.forum#&Topic=#url.topic#&sortby=desc"><img src="#request.imagedir#down.gif"  align="middle" alt="new posts last" border=0></a>
							</cfif>
						<cfelse>
							<a href="viewmessages.cfm?Forum=#url.forum#&Topic=#url.topic#&sortby=desc"><img src="#request.imagedir#down.gif"  align="middle" alt="new posts last" border=0></a>
						</cfif>
						</p>
					</td>
				</tr>
				
				</cfoutput>		
				
				<cfif IsDefined("url.sortby")>
					<cfset Sortby = "#url.sortby#">
				<cfelse>
					<cfset Sortby = "asc">
				</cfif>
						
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getmessages" returnvariable="getmessages">
					<cfinvokeargument name="sortby" value="#Sortby#">
					<cfinvokeargument name="topic" value="#url.topic#">
				</cfinvoke>
				<cfif IsDefined("URL.ERow")>      <cfset ER = '#URL.ERow#'>   <cfelse>    <cfset ER = '#ShowHowMany#'></cfif>
				<cfif #Getmessages.RecordCount# GTE #ER#>  <cfset ER = '#ER#'>   <cfelse>    <cfset ER = '#Getmessages.RecordCount#'></cfif>
				<cfif IsDefined("URL.SRow")>      <cfset SR = '#URL.SRow#'>   <cfelse>    <cfset SR = '1'></cfif>
				
				<cfloop query="GetMessages" startrow="#sr#" endrow="#er#">		
				<cfset MessageCopy2 = "#GetMessages.MessageCopy#">		
				<cfoutput>
				<tr bgcolor="#request.column1#">
					<td NOWRAP valign="top" bgcolor="#request.column2#"><cfif #DateCompare(Session.UsersLastVisit,GetMessages.MessageDate)# IS -1 ><img src="#request.imagedir#newpost.gif" alt="New Message" border=0 align="top"><cfelse><img src="#request.imagedir#post.gif" alt="" align="top"></cfif>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#GetMessages.UserName#</b></font></td>
					<td valign="top" bgcolor="#request.column2#" colspan=2><table border=0 width=100%><tr><td>
					<cfif getmessages.ispollmessage eq 1><img src="#request.imagedir#poll.gif"><cfelseif Len(GetMessages.icon)><img src="#request.imagedir#topicicons/#GetMessages.icon#"><cfelse><img src="#request.imagedir#topicicons/topic.gif"></cfif>
					<font face="#request.fontface#" size="#request.fontsize#"  color="#request.timecolor#" > #DateFormat(GetMessages.MessageDate,'mm-dd-yyyy')# @ #TimeFormat(GetMessages.MessageDate,'h:mm tt')#</font>			
					#repeatstring('&nbsp;', 25)#</td><td align=right></cfoutput>
					<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
						method="messagenav">
					</cfinvoke>
					</td></tr></table>
					</td>		
				</tr><cfoutput>
				<tr bgcolor="#request.column1#">
					<td  valign="top" bgcolor="#request.column1#" width="110" NOWRAP>
					<font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#">
					</cfoutput>
					<cfif Getmessages.accesslevel is 5>Administrator
					<cfelseif Getmessages.accesslevel is 3>Moderator
					<cfelse>
						<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
							method="membertitle">
							<cfinvokeargument name="GetMessages" value="#getMessages#">
							<cfinvokeargument name="membertitles" value="#membertitles#">
							<cfinvokeargument name="requiredposts" value="#requiredposts#">
						</cfinvoke>
					</cfif><br>
					<cfoutput>
					Posts: #GetMessages.Posts#<br>
					Joined: #dateformat(Getmessages.JoinDate, "mmm yyyy")#<br>		
					<table border=0 cellpadding=0 cellspacing=0 width="110"><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>
					<cfif session.accesslevel gte 3 and len(trim(getmessages.ipaddress))>
					ip:#getmessages.ipaddress#
					</cfif>
					
					<cfif getmessages.isapproved is 'n' and session.accesslevel gte 3>				
						<form action="index.cfm?page=#url.page#&forumaction=viewmessages&Forum=#url.forum#&Topic=#url.topic#" method="post">
						<input type="hidden" name="messageid" value="#getmessages.messageid#">
						<input type="submit" value="Approve this Message">
						</form>				
					</cfif>
					
					</td>
					</cfoutput>
					
					<cfoutput>
					<td valign="top" bgcolor="#request.column1#" colspan=2><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					</cfoutput>
					<cfif Getmessages.IsApproved is 'n' and session.accesslevel lt 3>
						<br>Sorry, this message can not be displayed at this time.<br> It has not been approved by an administrator or moderator.<br><br>
					<!--- Insert Smilies into MessageCopy2 -- Added Oct 19, 1999 --->
					<cfelseif GetMessages.Isapproved is 'y' or session.accesslevel gte 3>						
						
						<cfinvoke method="messagecopy2" 
							component="#application.websitepath#.utilities.forumactions" 
							returnvariable="messagecopy2">
							<cfinvokeargument name="theMessage" value="#messagecopy2#">
						</cfinvoke>
						<cfif getmessages.ispollmessage eq 1><b>Question:</b> <br> </cfif> 
						<cfoutput>#paragraphformat(MessageCopy2)#</cfoutput>
						<cfscript>  
						if (server.os.name contains "windows"){ request.slash = "\"; }
						else { request.slash = "/"; }
						</cfscript>
						<cfif Len(Fileattachment) and FileExists(ExpandPath('fileattachments'&request.slash&fileattachment))>    
						<cfoutput>
						<br> <img src="#request.imagedir#attachedfile.gif" alt="Attached File" border=0 align="top"><a href="fileattachments/#replace(Fileattachment,' ', '%20',  'all')#" target="blank">#Fileattachment#</a>
						</cfoutput>
						<!--- This section may need to be removed if CFDIRECTORY is disabled --->
						<cfset path = "#expandpath('fileattachments')#">
						<cftry>
						<cfdirectory action="LIST" directory="#path#" name="AttachedFile" filter="#Fileattachment#">
						<cfoutput>(#evaluate(round((AttachedFile.Size/1000)+0.5))# Kbytes)</cfoutput>				
						<!--- / end CFDIRECTORY section --->
						<cfcatch type="Any">
						<!-- cfdirectory is not enabled -->
						</cfcatch>
						</cftry>
						</cfif>
						
						<!--- POLL --->			
						<cfparam name="request.vtd" default="0">
						<cfif gettopic.ispoll eq 1 and isdefined('url.vr') and getmessages.ispollmessage eq 1>							
							<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
								method="pollresults">
							</cfinvoke>					
						<cfelseif gettopic.ispoll eq 1 and getmessages.ispollmessage eq 1>
							<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
								method="checkvotes" returnvariable="checkvotes">
							</cfinvoke>
							<cfif checkvotes.recordcount gte 1>
								<cfset request.vtd = 1>
								<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
									method="pollresults">
								</cfinvoke>		
							<cfelse>
								<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
									method="pollanswers">
								</cfinvoke>		
							</cfif>					
						</cfif>
						<!--- /poll --->
					
					</cfif>
					
					</font></td>
				</tr>
			</cfloop>
			</table>
		</td>
		</tr>
		</table>
		
		<cfoutput>
		
		<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><TR bgcolor="#request.bgcolor#"><TD>
		<cfif gettopic.messagecount gt ShowHowMany>
			<b><font face="#request.fontface#" Color="#request.text#" size="#request.fontsize#">PAGE: </font>
				<cfset page = 1>					
				<cfset er = showhowmany>
				<cfloop from="1" to="#gettopic.messagecount#" index="i" step="#showhowmany#">
					<cfset SR = i>
					<a href="viewmessages.cfm?Forum=#url.forum#&Topic=#url.topic#&srow=#sr#&erow=#er#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>"><font face="#request.fontface#" Color="#request.text#" size="#request.fontsize#">#page#</font></a>
					<cfset page = page + 1>
					<cfset er = er + showhowmany>
				</cfloop>
			</b><br>
		</cfif>
		<cfif Session.AdminSignedIn IS "Y">
		<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.text#">
		<cfif #GetTopic.ThreadLocked# IS 'Y'>
		<a href="unlockthread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"><img src="#request.imagedir#locked.gif" alt="Unlock This Discussion." border="0" align=top></a>This Discussion has been locked by #GetTopic.ThreadLockedBy#.<br>
		<cfelse>
		<a href="lockthread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"><img src="#request.imagedir#locked.gif" alt="Lock This Discussion." border="0" align=top></a>
		</cfif>
		<a href="movethread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"><img src="#request.imagedir#movcpy.gif" alt="Move This Discussion" border="0" align=top></a>
		<a href="deletethread.cfm?Forum=#URL.Forum#&Topic=#URL.Topic#"><img src="#request.imagedir#delete.gif" alt="Delete This Discussion." border="0" align=top></a></font>
		</cfif>
		
		</td><td align=right><font face="#request.fontface#" Color="#request.copycolor#" size="1">
		</cfoutput>
		
		<form>
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="jumplist">
		</cfinvoke>
		</form>
		
		</td></tr></TABLE>
		</center>
		</cfif>
		
		<cfelse>
			<cflocation url="index.cfm" addtoken="No">
		</cfif>
	</cffunction>
	
	<cffunction name="viewmessages2" access="remote" output="true">
		<cfset columns = "f.forumname,f.allowhtml,f.allowfileuploads,f.publicforum,f.notifymod,f.moderator,f.moderatoremail, c.category">
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getForum2" returnvariable="getforum2">
			<cfinvokeargument name="forum" value="#url.forum#">
			<cfinvokeargument name="columns" value="#columns#">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="gettopic" returnvariable="gettopic">
			<cfinvokeargument name="topic" value="#url.topic#">
		</cfinvoke>

		<center>
		
		<!--- WHOIS --- JAVASCRIPT POP UP WINDOW --->
		<script language="JavaScript">
		
		function launch(newURL, newName, newFeatures, orgName) {
		var remote = open(newURL, newName, newFeatures);
		if (remote.opener == null)
		  remote.opener = window;
		remote.opener.name = orgName;
		return remote;
		}
		
		function Whois(ID) {
		myRemote = launch("whois.cfm?MemID="+ID+"",
						  "myRemote",
						  "height=450,width=400,alwaysLowered=0,alwaysRaised=0,channelmode=0,dependent=0,directories=0,fullscreen=0,hotkeys=1,location=0,menubar=0,resizable=0,scrollbars=1,status=0,titlebar=1,toolbar=0,z-lock=0",
						  "myWindow");
		}
		</SCRIPT>
		
		<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
			method="viewmessages">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="viewtopics" access="remote" output="true">

		<cfinvoke method="getForumPassword" returnvariable="xForumPassword">
			<cfinvokeargument name="forumID" value="#URL.forum#">
		</cfinvoke>
		<cfif #xforumPassword# is #session.subtypeid#>
			<cfset form.forumpassword="#xforumPassword#">
		<cfelse>
			<cfset form.forumpassword="n">
			<cfif #listFindNocase(session.othertypeid,xforumPassword)#>
				<cfset form.forumpassword="#xforumPassword#">
			</cfif>
		</cfif>
		
		<cfif request.LoginRequired is 'y' and session.memberloggedin neq 'y'>
			<cfset PageTitle = "topics">
			<cfset PageSection = "topics">
			<cfoutput>
			<center><br>
			<!--- dsp_mainnavlinks.cfm --->
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
				method="mainnavlinks">
				<cfinvokeargument name="page" value="Login">
				<cfinvokeargument name="restrictaccess" value="0">
			</cfinvoke>
			<br>			
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
				<cfinvokeargument name="error" value="Welcome to #request.forumtitle#.<br> You must be a <a href='register.cfm'>registered member</a> to view this forum.<br><br>">
				<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
			</cfinvoke>
			</cfoutput>
			</center>
			<cfabort>
		</cfif>
		
		<cfif IsDefined("url.Forum") AND IsNumeric(url.forum)>
		
			<cfset columns = "f.forumname, c.category, f.forumpassword, f.moderator, f.moderatoremail, f.publicview, f.allowpolls, f.pollaccesslevel">
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getForum2" returnvariable="getforum2">
				<cfinvokeargument name="forum" value="#url.forum#">
				<cfinvokeargument name="columns" value="#columns#">
			</cfinvoke>
			<cfif IsDefined("Cookie.ShowHowMany") and isnumeric(cookie.showhowmany) and cookie.showhowmany neq 0>
				<cfset ShowHowMany = '#Cookie.ShowHowMany#'>
			<cfelse>
				<CFSET ShowHowMany = '10'>
			</cfif>
			
			<cfset PageTitle = "#GetForum2.ForumName#">
			<cfset PageSection = "topics">
			
			<!--- Close Forums --->
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
				method="forumdown">
			</cfinvoke>
			
			<!--- Page Content Starts Here --->
		
			<!--- <cfset session.authorizedforums = ""> --->
			
			<cfif IsDefined("form.forumpassword")>
				<cfif '#form.forumpassword#' is '#getforum2.forumpassword#'>
					<cfset session.authorizedforums = listappend(#session.authorizedforums#, #url.forum#, ',')>
				</cfif>
			</cfif>
			
			<center>
			
			<cfif getforum2.publicview eq 'n' AND (session.memberloggedin eq 'n' OR session.accesslevel lt 3)>
				
				<cfif session.memberloggedin eq 'n'>
					<cfinvoke component="#application.websitepath#.utilities.forumdisplay" method="login">
						<cfinvokeargument name="error" value="Y<br><b>This forum can only be viewed by administrators and moderators.</b><br><br>">
						<cfinvokeargument name="referrer" value="#listlast(cgi.path_info, '/')#?#cgi.query_string#">
					</cfinvoke>
				<cfelse>
					<cfoutput><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
					<br><br><br><br><center><b>This forum can only be viewed by administrators and moderators.</b></center><br><br><br><br><br><br>
				</cfif>
		
		<cfelseif IsDefined("URL.Forum") AND (not len(trim(getforum2.forumpassword)) or listcontains(session.authorizedforums, url.forum, ',') or session.accesslevel eq 5)>
		
			<cfif IsDefined("URL.sortby")>
			<cfif url.sortby is 'AuthAsc'><cfset sort = "Order By MemberName DESC,LastMessageDate DESC">
			<cfelseif url.sortby is 'AuthDesc'><cfset sort = "Order By MemberName Asc,LastMessageDate DESC">
			<cfelseif url.sortby is 'LastPostDesc'><cfset sort = "Order By LastMessageDate DESC">
			<cfelseif url.sortby is 'LastPostAsc'><cfset sort = "Order By LastMessageDate Asc">
			<cfelseif url.sortby is 'TitleDesc'><cfset sort = "Order By TopicTitle Asc,LastMessageDate DESC">
			<cfelseif url.sortby is 'TitleAsc'><cfset sort = "Order By TopicTitle Desc,LastMessageDate DESC">
			<cfelse><cfset sort = "Order By stayontop desc, LastMessageDate DESC">
			</cfif><cfelse><cfset sort = "Order By stayontop desc, LastMessageDate DESC">
			</cfif>	
			
			<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
				method="getposts" returnvariable="getposts">
			</cfinvoke>
			<cfif IsDefined("URL.ERow")>      <cfset ER = '#URL.ERow#'>   <cfelse>    <cfset ER = '#ShowHowMany#'></cfif>
			<cfif #Getposts.RecordCount# GTE #ER#>  <cfset ER = '#ER#'>         <cfelse>    <cfset ER = '#Getposts.RecordCount#'></cfif>
			<cfif IsDefined("URL.SRow")>      <cfset SR = '#URL.SRow#'>   <cfelse>    <cfset SR = '1'></cfif>
		
			<cfoutput>
			
			<br>
			<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
				 method="mainnavlinks">
				<cfinvokeargument name="page" value="viewtopics">
				<cfinvokeargument name="forum" value="#GetForum2.ForumName#">
				<cfinvokeargument name="forumid" value="#URL.Forum#">
			</cfinvoke>
			<br>
			
				
			<table width="#request.tablewidth#" Border="0" cellpadding="1" cellspacing="0"><tr><td bgcolor="#request.catcolor#">
			<table width="100%" Border="0" cellpadding="1" cellspacing="0">
				<tr>
					<td align="left" bgcolor="#request.column1#" width="33%">
						<cfif #SR# GT 1><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"> &lt; <a href="viewtopics.cfm?Forum=#URL.Forum#&SRow=#Evaluate(URL.SRow - ShowHowMany)#&ERow=#Evaluate(URL.ERow - ShowHowMany)#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>">previous #ShowHowMany# discussions</a></font> &nbsp;&nbsp;</cfif>&nbsp;
					</td>
					<td align="center" bgcolor="#request.column1#" width="33%" nowrap>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<a href="posttopic.cfm?Forum=#URL.Forum#"><b><cfif len(request.newtopicimage)><img src="#request.imagedir##request.newtopicimage#"  alt="Start new discussion" border="0"></cfif>New Discussion</b></a>
						<cfif getforum2.allowpolls eq 1> | 
						<a href="postpoll.cfm?forum=#url.forum#"><b>New Poll</b></a>
						</cfif>								
						<cfif forum.enableforumsubscriptions eq 1>

						<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
							method="checksubscriptions" returnvariable="checksubscriptions">
						</cfinvoke>
						| <a href="subscribe.cfm?forum=#url.forum#&topic=0&sub=forum" title="<cfif checksubscriptions.recordcount neq 0>Uns<cfelse>S</cfif>ubscribe to this Forum"><cfif checksubscriptions.recordcount neq 0>Uns<cfelse>S</cfif>ubscribe</a>
						</cfif>
						
						
						
						</font>
					</td>
					<td bgcolor="#request.column1#" align="right" width="33%">&nbsp;			
						<cfif #ER# LT #Getposts.RecordCount#><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"><a href="viewtopics.cfm?Forum=#URL.Forum#&SRow=#Evaluate(SR+ShowHowMany)#&ERow=#Evaluate(ER+ShowHowMany)#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>">next <cfif #Evaluate(Getposts.RecordCount - ER)# LTE #ShowHowMany#>#Evaluate(Getposts.RecordCount - ER)#<cfelse>#ShowHowMany#</cfif> discussion<cfif #Evaluate(Getposts.RecordCount - ER)# GT '1'>s</cfif></a> &gt;</cfif>			
					</td>
				</tr>
			</table>
			</td></tr></table>
			</cfoutput>
			
			<cfoutput>
			<table width="#request.tablewidth#" Border="0" cellpadding="0" cellspacing="0"><tr><td bgcolor="#request.column2#">
			<table width="100%" Border="0" cellpadding="1" cellspacing="1">
			<tr>
			</cfoutput>
			<cfif Getposts.RecordCount IS NOT 0>
				<!--- Sort by feature ----> 
				<cfoutput>
				<td bgcolor="#request.catcolor#" colspan=3><cfif IsDefined("url.sortby")><cfif url.sortby is "TitleDesc"><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=TitleAsc"><cfelseif url.sortby is 'TitleAsc'><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=TitleDesc"><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=TitleDesc"></cfif><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=TitleDesc"></cfif><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Discussions</font></a><cfif IsDefined("url.sortby")><cfif url.sortby is "TitleDesc">&nbsp;<img src="#request.imagedir#down.gif"  align="absmiddle" alt="Descending Order"><cfelseif url.sortby is "TitleAsc">&nbsp;<img src="#request.imagedir#up.gif" alt="Ascending Order" border=0 align="absmiddle"></cfif></cfif></td>
				<td bgcolor="#request.catcolor#"><center><cfif IsDefined("url.sortby")><cfif url.sortby is "AuthDesc"><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=AuthAsc"><cfelseif url.sortby is 'AuthAsc'><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=AuthDesc"><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=AuthDesc"></cfif><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=AuthDesc"></cfif><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Posted By</font></a><cfif IsDefined("url.sortby")><cfif url.sortby is "AuthDesc">&nbsp;<img src="#request.imagedir#down.gif"  align="absmiddle" alt="Descending Order"><cfelseif url.sortby is "AuthAsc">&nbsp;<img src="#request.imagedir#up.gif" align="absmiddle" alt="Ascending Order"></cfif></cfif></center></td>
				<td bgcolor="#request.catcolor#"><center><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Views</font></center></td>
				<td bgcolor="#request.catcolor#"><center><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Replies</font></center></td>
				<td bgcolor="#request.catcolor#"><center><cfif IsDefined("url.sortby")><cfif url.sortby is "LastPostDesc"><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=LastPostAsc"><cfelseif url.sortby is 'LastPostAsc'><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=LastPostDesc"><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=LastPostDesc"></cfif><cfelse><a href="viewtopics.cfm?Forum=#URL.Forum#&sortby=LastPostAsc"></cfif><font face="#request.fontface#" Color="#request.cattextcolor#" size="#evaluate(request.fontsize-1)#">Last Post</font></a><cfif IsDefined("url.sortby")><cfif url.sortby is "LastPostDesc">&nbsp;<img src="#request.imagedir#down.gif" align="absmiddle" alt="Descending Order"><cfelseif url.sortby is "LastPostAsc">&nbsp;<img src="#request.imagedir#up.gif" align="absmiddle" alt="Ascending Order"></cfif><cfelse>&nbsp;<img src="#request.imagedir#down.gif" align="absmiddle" alt="Descending Order"></cfif></center></td>
				</tr></cfoutput>
				
				
				<!--- / sort by feature  --->
				
				<cfloop query="Getposts" startrow="#SR#" endrow="#ER#">
				
				<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
					method="getmessage" returnvariable="getmessage">
					<cfinvokeargument name="MessageID" value="#URL.Message#">
					<cfinvokeargument name="TopicID" value="#Getposts.TopicID#">
				</cfinvoke>
				<cfif IsDefined("Cookie.ShowHowMany") and isnumeric(cookie.showhowmany)>
					<cfset ShowHowMany = '#Cookie.ShowHowMany#'>
				<cfelse>
					<CFSET ShowHowMany = '10'>
				</cfif>	
				
				<tr><cfoutput>
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><cfif #DateCompare(Session.UsersLastVisit,GetPosts.LastMessageDate)# IS -1 ><img src="#request.imagedir#newpost.gif" alt="new message since your last visit"><cfelseif #GetPosts.ThreadLocked# IS 'Y'><img src="#request.imagedir#locked.gif"><cfelse>&nbsp;&nbsp;&nbsp;</cfif></center></td>		
				<td valign="top" bgcolor="#request.column1#" align="center"><cfif getposts.ispoll eq 1><img src="#request.imagedir#poll.gif" border="0"><cfelseif Len(GetMessage.icon)><img src="#request.imagedir#topicicons/#GetMessage.icon#"><cfelse><img src="#request.imagedir#topicicons/topic.gif"></cfif></td>		
				<td valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><cfif getposts.stayontop eq 1><img src="#request.imagedir#sticky.gif" alt="This is a sticky topic"> </cfif><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b><a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#Getposts.TopicID#" Title="#HTMLEditFormat(left(GetMessage.MessageCopy, 400))#"><cfif getposts.ispoll eq 1>POLL: </cfif><cfif Len(Getposts.TopicTitle) GT 30>#HTMLEditFormat(left(Getposts.TopicTitle, 30))#...<cfelse>#HTMLEditFormat(Getposts.TopicTitle)#</cfif></a></b></font>
				<cfif getmessage.messagecount gt ShowHowMany>
					<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#">
					-- page: 
						<cfset page = 1>					
						<cfset PageEr = showhowmany>
						<cfloop from="1" to="#getmessage.messagecount#" index="i" step="#showhowmany#">
							<cfset PageSR = i>
							<cfif page lte 3>
							<a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#Getposts.TopicID#&srow=#PageSR#&erow=#PageEr#">#page#</a>
							<cfelse>
								<cfif pageer gte getmessage.messagecount>
								 <cfif page neq 4> .. </cfif> <a href="viewmessages.cfm?Forum=#URL.Forum#&Topic=#Getposts.TopicID#&srow=#PageSR#&erow=#PageEr#">#page#</a>
								</cfif>				
							</cfif>
							<cfset page = page + 1>
							<cfset PageEr = PageEr + showhowmany>
						</cfloop>
					</font>
				</cfif>
				</td>
				<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#">#Getposts.MemberName#</font></td>
				<td bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#"><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><center>#Getposts.Views#</center></font></td>
				<td bgcolor="#request.column1#"><font face="#request.fontface#" size="#evaluate(request.fontsize - 1)#" color="#request.text#"><center> #evaluate(getmessage.messagecount-1)#</center></font></td>
				<td bgcolor="#IIf(CurrentRow Mod 2, DE('#request.bgcolor#'), DE('#request.column1#'))#" nowrap><font face="#request.fontface#" color="#request.timecolor#" size="#evaluate(request.fontsize - 1)#"> <cfif #DateFormat(GetPosts.LastMessageDate,'mm-dd-yyyy')# eq #DateFormat((now() - 1),'mm-dd-yyyy')#>yesterday<cfelseif #DateFormat(GetPosts.LastMessageDate,'mm-dd-yyyy')# eq #DateFormat(now(),'mm-dd-yyyy')#>today<cfelse>#DateFormat(GetPosts.LastMessageDate,'mm-dd-yyyy')#</cfif> @ #TimeFormat(GetPosts.LastMessageDate,'h:mm tt')#</center></font></td>
				</tr></cfoutput>
				</cfloop>	
			<cfelse>
				<cfoutput><td colspan=6 bgcolor="#request.bgcolor#"><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"></cfoutput>
				<br><br><br><br><center><b>There are currently 0 topics in this discussion group</b></center><br><br><br><br><br><br>
				</td></tr>
				<cfset SR = 0>
				<cfset ER = 0>
			</cfif>
			
			</table></td></tr></table>
			<cfoutput>
			<table width="#request.tablewidth#" Border="0" cellpadding="1" cellspacing="0"><tr><td bgcolor="#request.catcolor#">
			<table width="100%" Border="0" cellpadding="1" cellspacing="0">
				<tr>
					<td align="left" bgcolor="#request.column1#" width="33%">
						<cfif #SR# GT 1><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"> &lt; <a href="viewtopics.cfm?Forum=#URL.Forum#&SRow=#Evaluate(URL.SRow - ShowHowMany)#&ERow=#Evaluate(URL.ERow - ShowHowMany)#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>">previous #ShowHowMany# discussions</a></font> &nbsp;&nbsp;</cfif>&nbsp;
					</td>
					<td align="center" bgcolor="#request.column1#" width="33%" nowrap>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
						<a href="posttopic.cfm?Forum=#URL.Forum#"><b><cfif len(request.newtopicimage)><img src="#request.imagedir##request.newtopicimage#"  alt="Start new discussion" border="0"></cfif>New Discussion</b></a>
						<cfif getforum2.allowpolls eq 1 and (getforum2.pollaccesslevel eq 0 OR session.accesslevel gte 3)> | 
						<a href="postpoll.cfm?forum=#url.forum#"><b>New Poll</b></a>
						</cfif>
						<cfif forum.enableforumsubscriptions eq 1>
						<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
							method="checksubscriptions" returnvariable="checksubscriptions">
						</cfinvoke>
						| <a href="subscribe.cfm?forum=#url.forum#&topic=0&sub=forum" title="<cfif checksubscriptions.recordcount neq 0>Uns<cfelse>S</cfif>ubscribe to this Forum"><cfif checksubscriptions.recordcount neq 0>Uns<cfelse>S</cfif>ubscribe</a>
						</cfif>
						</font>
					</td>
					<td bgcolor="#request.column1#" align="right" width="33%">&nbsp;			
						<cfif #ER# LT #Getposts.RecordCount#><font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"><a href="viewtopics.cfm?Forum=#URL.Forum#&SRow=#Evaluate(SR+ShowHowMany)#&ERow=#Evaluate(ER+ShowHowMany)#<cfif IsDefined("url.sortby")>&sortby=#url.sortby#</cfif>">next <cfif #Evaluate(Getposts.RecordCount - ER)# LTE #ShowHowMany#>#Evaluate(Getposts.RecordCount - ER)#<cfelse>#ShowHowMany#</cfif> discussion<cfif #Evaluate(Getposts.RecordCount - ER)# GT '1'>s</cfif></a> &gt;</cfif>			
					</td>
				</tr>
			</table>
			</td></tr></table>	
			</cfoutput>
			
			<br><form><cfoutput>
			<table width="#request.tablewidth#" Border="0" cellpadding="1" cellspacing="0">
				<tr>
					<td bgcolor="#request.catcolor#">
						<table width="100%" Border="0" cellpadding="3" cellspacing="0">
							<tr bgcolor="#request.column1#">
								<td bgcolor="#request.column1#" valign="top">
									<img src="#request.imagedir#newpost.gif" alt="New Message" align="left">
									<font face="#request.fontface#" size="#evaluate(request.fontsize-1)#" color="#request.text#"> 
									New posts since your last visit 
										<cfif IsDefined("Session.UsersLastVisit")>  
											<br>on #DateFormat(Session.UsersLastVisit,'ddd, mmm. d, yyyy')# at #TimeFormat(Session.UsersLastVisit,'h:mm tt')#
										</cfif>.
									</font>
								</td>
								<td align="right" valign="top">
									<font face="#request.fontface#" Color="#request.copycolor#" size="1">
									</cfoutput>
							
									<!--- dsp_jumplist.cfm --->
									<cfinvoke component="#application.websitepath#.utilities.forumdisplay" 
										method="jumplist">
									</cfinvoke>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</form>	
			
		<cfelseif len(trim(getforum2.forumpassword))>		
				
				<cfoutput>
				<form action="index.cfm?page=#url.page#&forumaction=viewtopics&Forum=#URL.Forum#" method=post>
				<table Border="0" cellpadding="0" cellspacing="0"><tr><td bgcolor="#request.catcolor#">
				<table width="100%" Border="0" cellpadding="1" cellspacing="1">
				<tr>
					<td align="center" bgcolor="#request.catcolor#">
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.cattextcolor#"><b>This discussion group is restricted.</b>
						<br>Please enter the password below to enter.</font>
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#request.column1#"><br>
						<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Password: 
						</font>
						<input type="password" name="forumpassword" size=20><input type="submit" value="Enter Forum"><br><br>
					</td>
				</tr>		
				<tr>
					<td bgcolor="#request.column2#" align="center">		
					<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
					Contact <cfif Len(trim(getforum2.moderatoremail))><a href="mailto:#getforum2.moderatoremail#?subject=Need password to #getforum2.forumname#">#getforum2.moderator#</a><cfelse><a href="mailto:#request.forumemail#?subject=Need password to #getforum2.forumname#">webmaster</a></cfif> for the password.
					</font>	
					</td>
				</tr>
				</table>
				</td></tr></table>
				</form>
				</cfoutput>
				<cfabort>
		
		<cfelse>
			<cfoutput>
			<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
			<b><br><br><br><br>That Forum does not exist.<br><br><br><br></b>
			</cfoutput>
		</cfif>
		
		</center>
		
		<cfelse>
		
			<cflocation url="index.cfm" addtoken="No">
		
		</cfif>

	</cffunction>
	
	<cffunction name="whois" access="remote" output="true">
		<!-- whois.cfm -->
		<cfif IsDefined("url.memid")><cfset memberid = #URL.MemID#>
		 <cfelseif isdefined("url.rid")><cfset rid = #URL.rid#>
		 <cfelseif isdefined('form.recipientid')><cfset memberid = #form.recipientid#>
		 <cfelseif isdefined('request.rid')><cfset memberid = #request.rid#>
		 <cfelseif isdefined("session.memberid")><cfset memberid = #session.memberid#></cfif>
		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="getmember" returnvariable="getmember">
			<cfinvokeargument name="memid" value="#memberid#">
		</cfinvoke>

		<cfinvoke component="#application.websitepath#.utilities.forumqueries" 
			method="checkmemberoptions" returnvariable="checkmemberoptions">
		</cfinvoke>
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
		
		<cfoutput><html>
		<head>
			<title>#request.forumtitle# - Who is #getmember.UserName#</title>
		</head>
		
		<body bgcolor="#request.bgcolor#" <cfif #Len(request.bgimage)#> background="#request.imagedir##request.bgimage#" </cfif> Text="#request.text#" link="#request.link#" VLink="#request.vlink#" ALink="#request.alink#" leftmargin=0 topmargin=0 marginheight="0" marginwidth="0" bottommargin="0" rightmargin="0">
		
		<center>
		<table width="100%" Border="0" cellpadding="0" cellspacing="0">
		  <tr bgcolor="#request.catcolor#">
			<td>
			  <table width="100%" Border="0" cellpadding="1" cellspacing="1">
				<tr bgcolor="#request.catcolor#">
				  <td bgcolor="#request.catcolor#"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" ><b>Who is #getmember.UserName#?</b></font></td>
				  <td bgcolor="#request.catcolor#" align=right><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" >[<a href="##"  ONCLICK="window.close()"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" >Close</font></a>]</font></td>
				  </td>
				</tr>
				
				<tr bgcolor="#request.column2#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">User Name:</font>
				  </td>
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>&nbsp;#getmember.UserName#</b></font>
				  </td>
				</tr>	
				<!--- First Name --->
				<cfif checkmemberoptions.showfname eq 1>
				<tr bgcolor="#request.column1#">
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">First Name:</font>
					</td>
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>&nbsp;#getmember.fname#</b></font>					
					</td>
				</tr>
				</cfif>
				<!--- Last Name --->
				<cfif checkmemberoptions.showlname eq 1>
				<tr bgcolor="#request.column1#">
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Last Name:</font>
					</td>
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>&nbsp;#getmember.lname#</b></font>				
					</td>
				</tr>
				</cfif>
				<!--- Birthday --->
				<cfif checkmemberoptions.showbday eq 1>
				<tr bgcolor="#request.column1#">
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Birthdate:</font>
					</td>
					<td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>#dateformat(getmember.bday, 'mm/dd/yyyy')#</font>&nbsp;</td>
				</tr>
				</cfif>	
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">From:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.Residence#</font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Email:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif session.memberloggedin neq 'y'>viewable to members only<cfelseif #getmember.ShowEmail# IS "N">Disabled.<cfelse><a href="mailto:#getmember.Email#">#getmember.Email#</a></cfif> </font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Member since:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#DateFormat(getmember.JoinDate, 'mmm. d, yyyy')#</font>&nbsp;
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Last Login:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif len(trim(getmember.lastlogin))>#DateFormat(getmember.lastlogin, 'mmmm d, yyyy')# at #TimeFormat(getmember.lastlogin,'h:mm tt')#</cfif> </font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Total Posts:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.Posts#</font>
					<CFSCRIPT>
					if(DateDiff("d",getmember.JoinDate,Now()) lt 1){
					days = 1;
					}
					else{
					days = DateAdd("d",-getmember.JoinDate,Now());
					}
					</CFSCRIPT>
					<font face="#request.fontface#" size="#evaluate(request.fontsize -1)#" color="#request.text#">
					<cfif getmember.posts gt 0>&nbsp;&nbsp;&nbsp;(#NumberFormat(getmember.posts/days,"____.__")# posts per day)</cfif>
				  </font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Occupation:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.Occupation#</font>
				</td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Interests:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.Interests#</font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Website:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif len(getmember.homepage) gt 7><a href="#getmember.HomePage#" target="_blank">#getmember.HomePage#</a></cfif></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">AOL  Messenger:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif len(trim(getmember.aimhandle))><a href="aim:goim?screenname=#getmember.aimhandle#&message=Hi.+Are+you+there?">#getmember.aimhandle#</a><!--- <img src="http://www.aol.com/aim/gr/aimver_im.gif" width=117 height=39 border=0 alt="Send me an Instant Message"> ---></cfif></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">Yahoo!  Messenger:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif len(trim(getmember.yahoohandle))><a href="http://edit.yahoo.com/config/send_webmesg?.target=#getmember.yahoohandle#&.src=pg" target="_blank"><img border="0" src="http://opi.yahoo.com/online?u=#getmember.yahoohandle#&m=g&t=0" align="absmiddle" alt="Send Yahoo! Message"></a></cfif> &nbsp;&nbsp;<a href="http://edit.yahoo.com/config/send_webmesg?.target=#getmember.yahoohandle#&.src=pg" target="_blank">#getmember.yahoohandle#</a></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td nowrap><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">ICQ Number:</font>
				  </td>
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;<cfif len(trim(getmember.icqnumber))><img src="http://web.icq.com/whitepages/online?icq=#getmember.icqnumber#&img=22" align="absmiddle"> <cfif session.memberloggedin eq 'y'><a href="icqmessenger.cfm?icq=#getmember.icqnumber#">#getmember.icqnumber#</a><cfelse>#getmember.icqnumber#</cfif></cfif></font>
				  </td>
				 </tr>
				 <!--- Custom 1 --->
					<cfif len(trim(checkmemberoptions.labelcustom1))>
					<tr bgcolor="#request.column1#">
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#checkmemberoptions.labelcustom1#</font>
						</td>
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.custom1#</font>		
						</td>
					</tr>
					</cfif>
					<!--- Custom 2 --->
					<cfif len(trim(checkmemberoptions.labelcustom2))>
					<tr bgcolor="#request.column1#">
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#checkmemberoptions.labelcustom2#</font>
						</td>
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.custom2#</font>
						</td>
					</tr>
					</cfif>
					<!--- Custom 3 --->
					<cfif len(trim(checkmemberoptions.labelcustom3))>
					<tr bgcolor="#request.column1#">
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#checkmemberoptions.labelcustom3#</font>
						</td>
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.custom3#</font>
						</td>
					</tr>
					</cfif>
					<!--- Custom 4 --->
					<cfif len(trim(checkmemberoptions.labelcustom4))>
					<tr bgcolor="#request.column1#">
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#checkmemberoptions.labelcustom4#</font>
						</td>
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.custom4#</font>		
						</td>
					</tr>
					</cfif>
					<!--- Custom 5 --->
					<cfif len(trim(checkmemberoptions.labelcustom5))>
					<tr bgcolor="#request.column1#">
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">#checkmemberoptions.labelcustom5#</font>
						</td>
						<td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">&nbsp;#getmember.custom5#</font>		
						</td>
					</tr>
					</cfif>
				<cfif checkmemberoptions.enablepm eq 1>
				 <tr bgcolor="#request.catcolor#">
				  <td colspan="2"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" ><b>Private Messaging</b></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column2#">
				  <td colspan=2><center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><a href="javascript:void(0)" onClick="self.opener.location.href='index.cfm?page=#url.page#&forumaction=inbox&rid=#url.memid#'; window.close(); return false;"><b>Send #getmember.UserName# a Private Message</b></a></center></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>Buddy list:</b></font>
				  </td>
				  <td>&nbsp;&nbsp;<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				  <cfset request.table = "buddylist">
				  <cfset request.column = "buddyid">
				  <cfinvoke component="#application.websitepath#.utilities.forumqueries" 
						method="buddylist" returnvariable="buddylist">
						<cfinvokeargument name="memid" value="#url.memid#">
					</cfinvoke>
				  <cfif buddylist.recordcount>
				  <a href="index.cfm?page=#url.page#&forumaction=act_buddylist&memid=#url.memid#&act=remove&tbl=buddylist">Remove #getmember.UserName#</a>
				  <cfelse>
				  <a href="index.cfm?page=#url.page#&forumaction=act_buddylist&?memid=#url.memid#&act=add&tbl=buddylist">Add #getmember.UserName#</a>
				  </cfif>
				  </font></center>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><b>Ignore list:</b></font>
				  </td>
				  <td>&nbsp;&nbsp;<font face="#request.fontface#" size="#request.fontsize#" color="#request.text#">
				   <cfset request.table = "ignorelist">
				   <cfset request.column = "ignoredid">
				  <cfinvoke component="#application.websitepath#.utilities.forumqueries" 
						method="buddylist" returnvariable="buddylist">
						<cfinvokeargument name="memid" value="#url.memid#">
						<cfinvokeargument name="table" value="#request.table#">
						<cfinvokeargument name="column" value="#request.column#">
					</cfinvoke>
				  <cfif buddylist.recordcount>
				  <a href="index.cfm?page=#url.page#&forumaction=act_buddylist&memid=#url.memid#&act=remove&tbl=ignorelist">Remove #getmember.UserName#</a>
				  <cfelse>
				  <a href="index.cfm?page=#url.page#&forumaction=act_buddylist&memid=#url.memid#&act=add&tbl=ignorelist">Add #getmember.UserName#</a>
				  </cfif>
				 </font></center>
				  </td>
				</tr>
				</cfif>
				 <tr bgcolor="#request.catcolor#">
				  <td colspan="2"><font face="#request.fontface#" size="#request.fontsize#"  Color="#request.cattextcolor#" ><b>Posts by #getmember.UserName#</b></font>
				  </td>
				</tr>
				<tr bgcolor="#request.column1#">
				  <td colspan=2><center><font face="#request.fontface#" size="#request.fontsize#" color="#request.text#"><a href="javascript:void(0)" onClick="self.opener.location.href='index.cfm?page=#url.page#&forumaction=search&username=#getmember.UserName#'; window.close(); return false;">View posts by #getmember.UserName#</a></center></font>
				  </td>
				</tr>
				
			  </table>
			</td>
		  </tr>
		</table>
		<!--- 
		<form action=post><input type="button" value="  Close this Window" ONCLICK="window.close()"></form></center>
		   --->      
		
		</center>
		
		</body>
		</html>
		</cfoutput>
	</cffunction>
</cfcomponent>