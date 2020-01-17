<cfcomponent>
	<cffunction name="coachwelcome" access="remote" output="true">
		<cfargument name="coachID" type="string" required="yes">

		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACHING SITE</td></tr>
		<tr><td colspan=2 class="centerTitle">WELCOME</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<p>Welcome to your Coaching site.  Please take a moment to familiarize yourself with the new controls.</p>
		</td></tr></table>
	</cffunction>
	
	<cffunction name="clientwelcome" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfoutput><table style="padding-left: 30px; padding-right: 30px; width: 800px;">
		<tr><td colspan=2 class="centerHeader">MY HOME PAGE</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="clientProfile" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		
		<cfquery name="getClientInfo" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from members,addresses,email,phonenumbers 
			where memberid=#clientid#
			and addresses.connectid=members.memberid
			and addresses.addresstypeid=1
			and email.connectid=members.memberid
			and email.websiteid=1
			and phonenumbers.connectid=members.memberid
			and phonenumbers.phonetypeid=1
		</cfquery>
		<CFOUTPUT query="GetClientInfo">
		<cfset ClientName="#trim(GetClientInfo.firstname)# #trim(GetClientInfo.LastName)#">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
			  <td colspan="5"> 
				<h2>Client Information <cfset CoachAction="editgeneral"><a href="index.cfm?coachaction=viewclient&viewaction=editgeneral&clientid=#clientid#"><img src="../images/notepad.gif" border=0></a></h2>
			  </td>
			</tr>																
			<tr> 
			  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
			</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Name:</TD>
				  <TD>&nbsp;</TD>
				 <TD  VALIGN="TOP" CLASS="qAnswer"> #trim(FirstName)# #trim(LastName)# </TD>
				  <TD>&nbsp;</TD>
				</TR>
				<tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Street Address:</TD>
				  <TD>&nbsp;</TD>
				  <TD  VALIGN="TOP" CLASS="qAnswer"> 
					#Trim(Address1)#
					<cfif #len(trim(address2))# gt 0><BR>
					#Trim(address2)#</cfif>
					<br>
					#Trim(city)#, #Trim(state)#
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption">Phone:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer">
					#Trim(phonenumber)# 
					Home</TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="25" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> E-mail:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qanswer"> 
					#Trim(emailaddress)#
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
		
				<tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption">Occupation:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer"> #Trim(occupation)#</TD>
				  <TD>&nbsp;</TD>
				</TR>
		
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Date of birth:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer"> #dateformat(BirthDate, "mmmm d, yyyy")#</TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Age:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer"> #Trim(age)# </TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Sex:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer"> <cfif #sex# is 1>Female<cfelse>Male</cfif> </TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD CLASS="caption" VALIGN="TOP"> Children (## and ages):</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD  VALIGN="TOP" CLASS="qAnswer"> #Trim(children)#</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD valign="TOP" class="caption"> Relationship Status:</TD>
				  <TD>&nbsp;</TD>
				  <TD VALIGN="TOP" CLASS="qAnswer"> <cfif #Relationshipstatus# is 1>Married<cfelseif #Relationshipstatus# is 0>Single<cfelseif #Relationshipstatus# is 2>Committed<cfelseif #Relationshipstatus# is 3>Divorced<cfelse>Separated</cfif> </TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <tr> 
				  <td colspan="5" class="tableheader"><img src="../images/b.gif" width="100" height="1"></td>
				</tr>
				<TR> 
				  <TD COLSPAN="5">&nbsp;</TD>
				</TR>
			  </TABLE>
			
		</CFOUTPUT>
	</cffunction>
	
	<cffunction name="clientList" access="remote" output="true">
		<cfargument name="coachID" type="string" required="yes">
		<cfargument name="collapse" type="string" required="yes">
			<cfparam name="CoachAction" default="coachstart">
<cfparam name="viewaction" default="coachwelcome">
		<cflock scope="Session" timeout="5" type="exclusive"><cfquery name="GetClients" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			SELECT Members.firstName, 
			Members.lastname,
			Addresses.City, 
			Addresses.State, 
			Email.EMailAddress,
			PhoneNumbers.PhoneNumber,
			Members.StartDate, 
			Members.MemberID,
			Members.AccessLevel,
			Members.Height
			FROM Members, Email, Addresses, PhoneNumbers
			WHERE email.tableid=15
			and email.connectid = members.memberid and email.websiteid=1
			and PhoneNumbers.TableID=15
			and PhoneNumbers.ConnectID = Members.MemberID
			and PHonenumbers.phonetypeid=1
			and Addresses.tableid=15
			and Addresses.connectid = members.memberid
			and Members.AccessLevel=#arguments.coachid#
			and Members.Active=1
		</cfquery></cflock>
		<cfset RcdCnt=#GetClients.RecordCount#>
		<cfoutput><script language="JavaScript1.1">
		function registerme(clientid,coachid)
		{
			var theURL='registercoach.cfm?CoachID='+coachid+'&clientid='+clientid;
			window.open(theURL,"RegisterCoach",'resizable=yes,width=300,height=200,scrollbars=yes');
		}listcoaches
		function listcoaches(clientid,coachID)
		{
			var theURL='listcoaches.cfm?clientid='+clientid+'&coachid='+coachID;
			window.open(theURL,"ListCoaches",'resizable=yes,width=300,height=200,scrollbars=yes');
		}
		</script></cfoutput>
		<cfset newcollapse=0>
		<cfif collapse is 0><cfset newcollapse=1></cfif>
		<cfparam name="clientid" default="0">
		<cfoutput>
		<table cellpadding="0" cellspacing=0 border=0 width=100% bgcolor="##e8eff6">
			<tr><td width="25" class="calendarHeadTD"> 
				<p class="calendarHead"><a href="index.cfm?coachaction=#coachaction#&viewaction=#viewaction#&collapse=#newcollapse#&clientid=#clientid#">CLIENTS</a></p>
			  </td></tr>
			<tr><td>
		<cfif #collapse# eq 0>
		<TABLE style="width:100%; padding: 0px 12px 0px 12px" bordercolor="##cccccc" cellspacing="0">
		
			<TR>
			<td><img src="../images/b.gif" width="15" height="1"></td>
			<TD valign="top" CLASS="tableheader" width="131"> <font face="Arial">Start Date </font></TD>
			<TD valign="top" CLASS="tableheader"> <font face="Arial">Name </font></TD>
			<TD valign="top" CLASS="tableheader"> <font face="Arial">EMail </font></TD>
			
			<TD valign="top" CLASS="tableheader"> <font face="Arial">Phone Number </font></TD>
			<TD valign="top" CLASS="tableheader"> <font face="Arial">City </font></TD>
			<TD valign="top" CLASS="tableheader"> <font face="Arial">State </font></TD>
			<td><img src="../images/b.gif" width="15" height="1"></td>
			</tr>
			<tr>
			<cfset rowCount = 1>
			<cfloop query="Getclients">
				<cfif rowCount is 2>
					<cfset rowCount=1>
					<cfset classthing="qanswer">
				<cfelse>
					<cfset rowCount=2>
					<cfset classthing="caption">
				</cfif>
				<td><img src="../images/b.gif" width="15" height="1"></td>
				<TD CLASS="#classthing#"><p>#dateformat(StartDate)#</p></TD>
				<TD CLASS="#classthing#">
				<p><a href="index.cfm?ClientID=#MemberID#&CoachAction=ViewClient&ViewAction=clientwelcome")>#trim(firstName)# #trim(LastName)#</a></p>
				</TD>
				<TD CLASS="#classthing#"><p>#EMailAddress#</p></TD>
				
				<TD CLASS="#classthing#"><p>#PhoneNumber#</p></TD>
				<TD CLASS="#classthing#"><p>#city#</p></TD>
				<TD CLASS="#classthing#"><p>#State#</p></TD>
				<td><img src="../images/b.gif" width="15" height="1"></td>
				</tr>
			</cfloop>
				
		</TABLE>
		</cfif>
		</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="clientname" access="remote" output="true">
		<cfargument name="clientid" type="string" required="yes">
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname,lastname,	startdate
			from members
			where memberid=#arguments.ClientID#
		</cfquery>
		<cfoutput query="getclient">
			<p align=><img src="../images/clientNameBar.gif"><br>
			<span class="clientTitle">CLIENT:</span><BR><span class="clientName">#trim(firstname)# #trim(lastname)#</span></p>
		</cfoutput>
		<cfif #Getclient.recordcount# eq 0>
			<p align=><img src="../images/clientNameBar.gif"><br>
		</cfif>
	</cffunction>
	
	<cffunction name="CoachInfo" access="remote" returntype="query" output="true">
		<cfquery name="GetCoachINfo" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			SELECT Members.*,
				Addresses.Address1, 
				Addresses.Address2, 
				Addresses.City, 
				Addresses.State, 
				Addresses.PostalCode, 
				Email.EMailAddress as Email, 
				PhoneNumbers.PhoneNumber,
				Addresses.Country, 
				SubscriptionType.SubDescription as SubType
				FROM Members, Email, Addresses, PhoneNumbers, SubscriptionType
				WHERE email.tableid=15
				and email.connectid = members.memberid
				and PhoneNumbers.TableID=15
				and PhoneNumbers.ConnectID = Members.MemberID
				and Addresses.tableid=15
				and Addresses.connectid = members.memberid
				and SubscriptionType.SubTypeID=Members.SubTypeID
				and Members.memberid=#session.coachid#
		</cfquery>
		<cfreturn getCoachInfo>
	</cffunction>
	
	<cffunction name="getMyCoach" access="remote" returntype="query" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="GetCoachID" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			select accesslevel from members where memberid=#arguments.clientID#
		</cfquery>
		<cfquery name="GetCoachINfo" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			SELECT Members.*
				FROM Members
				WHERE Members.memberid=#GetCoachID.accessLevel#
		</cfquery>
		<cfreturn getCoachInfo>
	</cffunction>
	

	
	<cffunction name="coachname" access="remote" output="true">
		<cfargument name="coachID" type="string" required="yes">
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname,lastname,	startdate
			from members
			where memberid=#arguments.coachid#
		</cfquery>
		<cfoutput query="getclient">
		<p><img src="../images/coachNameBar.gif" height="11" width="250"><br>
		<span class="coachTitle">COACH:</span><br><br><span class="coachName">#trim(firstname)# #trim(lastname)#</span></p>
		</cfoutput>
	</cffunction>
	
	<cffunction name="workouts" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfargument name="CoachAction" type="string" required="yes">
		<cfquery name="qGetContent" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			SELECT 	ContentID, Title, Body, Modified, userid, LIbraryID, BodyArea, LIbraryaccess.accessid
			FROM		Content,LibraryAccess
			WHERE LibraryAccess.LibraryID=Content.ContentID
			and LibraryAccess.MemberID=#clientID#
			and content.userid=1
			and content.body not like '%.jpg%'
		</cfquery>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px; width: 800px;">
		<tr><td colspan=2 class="centerHeader">MY WORKOUTS</td>
			<TD width=15>&nbsp;</td>
		  </TR>
		
		
				<cfloop query="qGetContent">
				<TR> 
				  <TD width=15>&nbsp;</td>
				  <TD> 
					<P CLASS="caption"><a href="javascript:confirmDelete('index.cfm?CoachAction=#CoachAction#&ViewAction=clientLibrary&ClientID=#ClientID#&Action=Delete&AccessID=#AccessID#')"><img src="../images/delete.gif" border=0></a>&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10"><a href="index.cfm?CoachAction=#CoachAction#&ViewAction=viewworkout&ClientID=#ClientID#&ContentID=#ContentID#&Panelname=Fitness&TypeThing=coach&PanelID=8" class=caption>#Title#</a> </P>
				  </TD>
				  <TD width=15>&nbsp;</td>
				</TR>
				</cfloop>
		
		  </td>
		  </tr>.<TR> 
			<TD width=15 colspan=2><h2></h2></td>
			<TD width=15>&nbsp;</td>
		  </TR>
		</TABLE>
		
		</cfoutput>

	</cffunction>
	<cffunction name="clientStart" access="remote" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		
		<cfoutput>Showing client start stuff</cfoutput>
	</cffunction>
	
	<cffunction name="logs" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfargument name="coachAction" type="string" required="yes">
		
		<cfoutput>
		<h2>Logs</h2>
		<table width="250">
		<tr><td>Eating Logs</td></tr>
		<tr><td>Workout Logs</td></tr>
		<tr><td><a href="##" onClick=getLogs("clientID=#clientID#&coachAction=viewclient&viewAction=otherlogs")>Other Logs</a></td></tr>
		<tr><td>Fitness Levels</td></tr>
		<tr><td>Medical Information</td></tr>
		<tr><td>Custom Logs</td></tr>
		</table>
		</cfoutput>

	</cffunction>
	
	<cffunction name="otherlogs" access="remote" output="true">		
		<cfargument name="clientID" type="string" required="yes">
		<cfparam name="TypeID"  default=0>
		<cfparam name="LogTypeID" default="Stress Rating">
		<cfparam name="Today" default="#dateformat(now())#">
		<cfif isDefined('Url.Today')>
			<cfset Today=#url.today#>
		</cfif>
		<cfset LastWeek=dateformat(dateadd("d",-7,#Today#))>
		<cfset NextWeek=dateformat(dateadd("d",7,#Today#))>
		
		<cfset ThisDay=dayofweek(#today#)>
		<cfset FirstDayDiff= (7 - #ThisDay#)>
		<cfset FirstDay=dateadd("d",-#firstDayDiff#,now())>
		<cfset LastDayDiff= abs(#ThisDay# - 7)>
		<cfset LastDay=dateadd("d",#LastDayDiff#,now())>
		
		<cfquery name="GetLogTypes" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			Select notetypes.*, subnotetypes.comments, subnotetypes.description as subdesc, subnotetypes.id as subtypeid,notecategories.description 
			from notetypes,notecategories, subnotetypes 
			where notecategories.categoryid=notetypes.notecategoryid
			and subnotetypes.notetypeid=notetypes.id
			and notetypes.typeid < 1000
			and notetypes.Typeid > 0 
			and notetypes.notecategoryid=7
			order by notetypes.typeid
		</cfquery>
		
		<cfif #TypeID# is 0>
			<cfset TypeID="Stress Rating">
			<cfset LogTypeID=5>
		</cfif>
		
		<script language="JavaScript">
		
		if (window != top) top.location.href = location.href;
		
		function mod(div,base) {
			return Math.round(div - (Math.floor(div/base)*base));
		}
		function calcBmi() {
		
			var strCom
			var strURL
			var w = document.bmi.weight.value * 1;
			var HeightFeetInt = document.bmi.htf.value * 1;
			var HeightInchesInt = document.bmi.hti.value * 1;
			HeightFeetConvert = HeightFeetInt * 12;
			h = HeightFeetConvert + HeightInchesInt;
			displaybmi = (Math.round((w * 703) / (h * h)));
			var rvalue = true;
			if ( (w <= 35) || (w >= 500)  || (h <= 48) || (h >= 120) ) {
				alert ("Invalid data.  Please check and re-enter!");
				rvalue = false;
			}
			if (rvalue) {
				if (HeightInchesInt > 11) {
					reminderinches = mod(HeightInchesInt,12);
					document.bmi.hti.value = reminderinches;
					document.bmi.htf.value = HeightFeetInt + 
					((HeightInchesInt - reminderinches)/12);
					document.bmi.answer.value = displaybmi;
				}
			
				strCom = displaybmi
				
				return window.open( 'https://www.wellcoaches.com/BMICalculator/bmi.cfm?BMI=' + strCom, 'newwindow', 'width=600,height=480,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=0' ) ; 
			
			}
		}
		
		function getexplanation(tURL) {
		window.open(tURL,'','resizable=yes,width=300,height=400,scrollbars=no');
		}
		
		</script>
		<script type="text/javascript" src="../CFIDE/scripts/cfform.js"></script>
		<script type="text/javascript" src="../CFIDE/scripts/masks.js"></script>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=3 class="centerHeader">MY LOGS</td></tr>
		<tr><td colspan=3 class="centerTitle">My Other Logs</td></tr>
		<tr><td colspan=3 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top colspan=2><p class=bold><strong>Instructions</strong>
		<ol>
		<li>	Click on the title of the log you would like to create or view.</li>
		<li>	Enter the Date of the log entry, the Current measurement, and your Goal; and add any comments. 
		<li>	Click "Save Changes" to save that day's log.
		<li>	If you need to edit an entry - make your change and click on "Save Changes".</ol></p>
		</td></tr>
		<tr><td></td><td>
			<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=146>
				
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="24"></TD>
				</TR>
				
				<cfset checkID=0>
				<cfoutput query="GetLogTypes">
					<cfif #ID# neq 44><cfif #ID# neq 43>
					<cfif #ID# neq #CheckID#>
						<tr><td class=qanswer>#typedescription#</td></tr>
						<cfset CheckID=#ID#>
					</cfif>
					<cfif #comments# is "Body Fat %">
						<cfset tComments="Body Fat">
					<cfelse>
						<cfset tComments=#Comments#>
					</cfif>
					<cfset tComments=replacenocase(tComments,'"',"''","ALL")>
					<cfset tComments=replacenocase(tComments,' ',"~","ALL")>
					<TR> 
						<TD CLASS="caption">
						<img src="../images/b.gif" height=1 width=10><a href="index.cfm?CoachAction=#coachAction#&viewaction=#viewaction#&ClientID=#ClientID#&LogTypeID=#SubTypeID#&TypeID=#tComments#">  #comments#</a>
						</TD>
					</TR>
					</cfif></cfif>
				</cfoutput>
		
			  </TABLE>
		
			  
		</td>
		
		<td valign=top>
		
		<cfinvoke component="#application.newWebSitePath#.utilities.clientlogs" 
			method="GetOtherLog" returnvariable="GetLogs">
			<cfinvokeargument name="ClientID" value="#ClientID#">
			<cfinvokeargument name="tLogType" value="#LogTypeID#">
		</cfinvoke>
		
		<cfset tCount=1>
		<cfset tMeasureTitle=''>
		<cfset tDescTitle=''>
		<cfif #getlogs.recordcount# gt 0>
			<cfset xmeasuretitle=#getLogs.measuretitle#>
			<cfset tsubdesc=#getLogs.DescTitle#>
		<cfelse>
			<cfquery name="gettLogs" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
				select comments,description from subnotetypes
				where comments like '#typeid#%'
			</cfquery>
			<cfset xmeasuretitle=#gettLogs.comments#>
			<cfset tsubdesc=#gettLogs.description#>
		</cfif>
		<cfif #trim(xmeasuretitle)# is ''>
			<cfquery name="gettLogs" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
				select comments,description from subnotetypes
				where comments like '#typeid#%'
			</cfquery>
			<cfset xmeasuretitle=#gettLogs.comments#>
			<cfset tsubdesc=#gettLogs.description#>
		</cfif>
		<cfset xmeasuretitle=replace(xmeasuretitle,"%","percent","ALL")>
		<cfset tsubdesc=replace(tsubdesc,"%","percent","ALL")>
		
		<IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="5"><br>
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=95%>
			<cfoutput>
				<cfif #TypeID# eq "39">
					<cfset xmeasuretitle="Stress Rating">
					<cfset tsubdesc="Stress Rating">
				</cfif>
				
				<TR> 
					<TD><IMG SRC="../images/b.gif" WIDTH="600" HEIGHT="32"></TD>
				</TR>
				<TR> 
					<TD class=bold>#xmeasuretitle#</TD>
				</TR>
				<TR> 
					<TD class=qanswer>Target Range: #tsubdesc#</TD>
				</TR>
				<cfif #trim(xmeasureTitle)# is "BMI">
					<tr><td>
						<form name="bmi" onsubmit="calcBmi(); return false;">
							<div align="center"><center><p class=caption>CALCULATE
							YOUR BODY MASS INDEX:<br>
							Weight: <input type="text" name="weight" size="3">lbs.&nbsp;&nbsp;
							Height:<input type="text" name="htf" size="2">ft. <input
							type="text" name="hti" size="2"> in<br>
							<small><input type="submit" value="Click Here" name="B1"></p>
							</center></div>
						</form>
					</td></tr>
				</cfif>
				<TR> 
					<TD><IMG SRC="../images/b.gif" WIDTH="375" HEIGHT="10"></TD>
				</TR>
				<cfset viewaction="viewlogs">
				<tr><td class=caption>
				<cfform action="index.cfm?coachaction=#coachaction#&viewaction=saveotherlog&clientID=#clientID#" target="_self" method="post" name="otherlogsform" preservedata="true" preloader="no" format="flash" height="450" width="550" skin="halosilver">
				<cfformgroup  type="horizontal">
					<cfgrid name="DetailGrid" height="350" width="500" 
						align="top" query="getLogs" 
						font="Arial" 
						fontsize="10" 
						appendkey="yes" 
						griddataalign="center" 
						gridlines="yes" 
						rowheaderalign="left" 
						colheaderalign="left" 
						colheaderfont="Arial" 
						colheaderfontsize="12" 
						colheaderbold="yes" 
						colHeaderTextColor="##1c5da1" 
						bgcolor="##FFFFFF" 
						selectmode="edit" 
						maxrows="10" 
						picturebar="yes"
						enabled="yes" 
						visible="yes" 
						format="flash" 
						textcolor="##000000" 
						autowidth="true">
					<cfgridcolumn name="LogID" header="Log ID" width="1" type="string_noCase" display="no" select="no">
					<cfgridcolumn name="LogDate" header="Date" headeralign="left" dataAlign="left" numberformat="xxxx/xx/xx" width="15" display="yes" type="string_nocase" mask="xxxx/xx/xx">
					<cfgridcolumn name="Goal" header="Goal"	width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Measurement" header="Current" width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Comments" header="Comments"	width="50" type="string_noCase"	display="yes" select="yes" dataAlign="left">
					</cfgrid>
				</cfformgroup>
				<cfformgroup  type="horizontal">
					<cfinput type="button" name="ins" value="Insert a new note" width="125" onClick="GridData.insertRow(DetailGrid);" class="bottombuttons">
					<cfinput type="button" name="del" value="Delete Note" width="100" onClick="GridData.deleteRow(DetailGrid);" class="bottombuttons">
					<cfinput type = "submit" name="submit" width="100" value = "Save Changes" class="bottombuttons">
					<cfinput type = "reset" name="reset" width="100" value = "Reset Fields" class="bottombuttons">
				</cfformgroup>
				</cfform>
				</td></tr>

			</cfoutput>
		</TABLE>
		
		</td>
		</tr>
		</table>
		<p>&nbsp;</p>
		<p align=center>
		<a href="#application.securepath#/coaching/getcontent.cfm?clientid=#clientID#&TypeID=#TypeID#&LogTypeID=#LogTypeID#&coachaction=#coachaction#&viewaction=printlogs" target="_blank">PRINT</a></p>
	</cffunction>
	
	<cffunction access="remote" name="SaveOtherLog" output="true" returntype="string">
		<cfargument name="ClientID" type="numeric" required="true" default="0">
		
		<cfparam name="LogID" type="string" default="0">
		<cfparam name="LogDate" type="string" default="">
		<cfparam name="TypeID" type="string" default="">
		<cfparam name="LogTypeID" type="string" default="">
		<cfparam name="Measurement" type="string" default="">
		<cfparam name="MeasureTitle" type="string" default=''>
		<cfparam name="Goal" type="string" default="">
		<cfparam name="Comments" type="string" default="">
		<cfparam name="descTitle" type="string" default=''>
		<cfparam name="coachaction" type="string" default='viewclient'>
		<cfparam name="viewaction" type="string" default='otherlogs'>
		
		<cfloop index="i" from="1" to="#arraylen(form.DetailGrid.LogID)#">
			<cfset LogDate=#form.DetailGrid.LogDate[i]#>
			<cfset LogID=#form.DetailGrid.LogID[i]#>
			<cfset Goal=#form.DetailGrid.Goal[i]#>
			<cfset Measurement=#form.DetailGrid.Measurement[i]#>
			<cfset Comments=#form.DetailGrid.Comments[i]#>
			<cfset gridAction=#form.DetailGrid.RowStatus.Action[i]#>
		
			<cfset Today=dateformat(#now()#,"yyyy/mm/dd")>
			<cfset NewLogID=#Logid#>
			<cfif left(LogDate,2) is "00"><cfset LogDate="01#right(LogDate,8)#"></cfif>
			<cfif left(LogDate,2) is "0/"><cfset LogDate="01#right(LogDate,7)#"></cfif>
			<cfset logdate=dateformat(logdate,"yyyy/mm/dd")>
			
			<cfset FieldList="ClientID, DateStarted, LogDate, LogType, Measurement, Goal, Comments, measureTitle,descTitle">
			<cfset FieldValues="#arguments.ClientID#,#Today# ,#dateformat(LogDate,'yyyy/mm/dd')# ,#LogTypeID# ,#Measurement# ,#replace(Goal,',','~','ALL')# ,#replace(Comments,',','~','ALL')# ,#replace(measureTitle,',','~','ALL')# ,#replace(descTitle,',','~','ALL')# ">
			
			<cfif ucase(gridAction) is "I">
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="InsertXMLRecord" returnvariable="NewLogID">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
					<cfinvokeargument name="XMLIDValue" value="#LogID#">
				</cfinvoke>
			</cfif>
		</cfloop>
		<cflocation url="index.cfm?coachaction=#coachaction#&viewaction=otherlogs&clientid=#clientid#&logtypeID=#logtypeID#&typeID=#typeID#">
	</cffunction>
	
	<cffunction name="viewworkout" access="remote" output="true">
		<cfargument name="ClientID" type="string" required="yes" default=0>

		<cfif isdefined('url.typeThing')>
		<cfelse>
			<cfset url.typething='coach'>
		</cfif>
		
		<cfif isdefined("url.contentID")>
			<cfquery name="qGetContent" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				SELECT 	ContentID, Title, Body, Modified, FormatTitle, PanelID, UserID, FitnessType
				FROM		Content
				WHERE		ContentID = #url.contentID#
			</cfquery>
			<cfset contentID="#qGetContent.ContentID#">
			<cfset title="#qGetContent.Title#">
			<cfset body="#qGetContent.Body#">
			<cfset modified="#qGetContent.Modified#">
			<cfset formattitle="#qGetContent.FormatTitle#">
			<cfset PanelID=#qGetContent.PanelID#>
			<cfset UserID=#qGetContent.UserID#>
		</cfif>
		<cfif fileExists("#application.newuploadpath#\files\clients\logs\WO#clientID#.xml")>
			<cfinvoke component="#Application.newWebSitePath#.Utilities.XMLHandler" 
				method="getXMLRecords" returnvariable="GetWorkout">
				<cfinvokeargument name="ThisPath" value="files/clients/logs">
				<cfinvokeargument name="ThisFileName" value="WO#clientid#">
				<cfinvokeargument name="selectstatement" value=" where libraryID='#Contentid#'">
				<cfinvokeargument name="orderbystatement" value=" order by workoutorder">
			</cfinvoke>
		
		<cfelse>
			<cfquery name="GetWorkout" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
				select * from workout
				where libraryID=#contentid#
				and memberid=#clientid#
				and coachid=#session.coachid#
				order by workoutorder
			</cfquery>
		</cfif>
		<cfoutput>
		<cfif #getWorkout.recordcount# is 0>
			<Cfset getworkout=querynew("workoutid,ClientID, COACHID, CONTENTID, LIBRARYID, DATEPREPARED, INSTRUCTIONS,LBS, REPS, SETS, WORKOUTORDER")>
		</cfif>

		</cfoutput>
		
		<cfif isdefined("form.edit")>
			<cfif form.id NEQ "">
				<!-- Update Content -->
				<cfset BodyText = replace(#Form.Body#,"'","`","ALL")>
				<cfquery name="qUpdateContent" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					UPDATE 	Content
					SET			Title = '#form.title#', Body = '#BodyText#', Modified = #Now()#, FormatTitle = '#form.formattitle#'
					WHERE		ContentID = #form.id#
				</cfquery>
		
			<cfelse>
				<!-- Used for Creating New Content Blocks -->		
				<cfset variables.modified = #DateFormat(Now(), 'mm/dd/yyyy')#>
				<cfset BodyText = replace(#Form.Body#,"'","`","ALL")>
				<cfquery name="qInsertContent" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					INSERT INTO Content (Title, Body, Modified, FormatTitle)
					VALUES ('#form.title#', '#BodyText#', #variables.modified#, '#form.formattitle#')
				</cfquery>
				
				<cfquery name="qGetLastContent" datasource="#application.wellcoachesDSN#" maxrows="1">
					SELECT	ContentID
					FROM		Content
					WHERE		Title LIKE '#form.title#' 
					<!--- AND Body LIKE '#form.body#'  --->
					AND FormatTitle LIKE '#form.formattitle#'
				</cfquery>
				
				<!-- Insert ConentID into Panel Start -->		
				<cfquery name="qGetPanelInfo" datasource="#application.wellcoachesDSN#" maxrows="1">
					SELECT	PanelID, PanelName, ContentIDs
					FROM		Panel
					WHERE		PanelName = '#form.panelname#'
				</cfquery>
		
				<cfif qGetPanelInfo.RecordCount NEQ 0>
				
				<cfwddx	action="wddx2cfml"
						input="#qGetPanelInfo.ContentIDs#"
						output="panelinfo">
						
				<cfscript>
					top = StructCount(panelinfo);
					StructInsert(panelinfo, "contentid"&top+1, "#qGetLastContent.ContentID#");
				</cfscript>
				
				<cfwddx	action="cfml2wddx"
						input="#panelinfo#"
						output="wddxpanel">
						
				<cfquery name="qUpdatePanel" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					UPDATE 	Panel
					SET			ContentIDs = '#wddxpanel#'
					WHERE		PanelName = '#form.panelName#'
				</cfquery>
				<!-- Insert ConentID into Panel End -->		
		
				<cfelse>
				<!-- Panel does not exist.  -->
				<cfscript>
					panelinfo = StructNew();
					StructInsert(panelinfo, "contentid1", "#qGetLastContent.ContentID#");
				</cfscript>
				
				<cfwddx	action="cfml2wddx"
						input="#panelinfo#"
						output="wddxpanel">
				
				<cfquery name="qInsertPanel" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					INSERT INTO Panel (PanelName, ContentIDs)
					VALUES ('#form.panelname#', '#wddxpanel#')
				</cfquery>
		
				</cfif>
		
			</cfif>
				<script language="JavaScript">
				<!--
					window.opener.document.location.href = window.opener.document.location.href;
				  window.close();
				//-->
				</script>
		
		<cfelseif isdefined("form.delete")>
			<!-- Delete Content from ALL Panels -->
				<cfquery name="qGetPanelInfo" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
					SELECT	PanelID, PanelName, ContentIDs
					FROM		Panel
				</cfquery>
		
				<cfoutput query="qGetPanelInfo">
					<cfwddx action="wddx2cfml"
							input="#ContentIDs#"
							output="panelinfo">
							
					<cfloop collection="#panelinfo#" item="i">
						<cfif panelinfo[i] EQ form.id>
							<cfscript>
								StructDelete(panelinfo, "#i#", "False");
							</cfscript>
						</cfif>
					</cfloop>
					
					<cfwddx action="cfml2wddx"
							input="#panelinfo#"
							output="panelinfowddx">
		
					<cfquery name="qUpdatePanelInfo" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
						UPDATE	Panel
						SET			ContentIDs = '#panelinfowddx#'
						WHERE		PanelID = #qGetPanelInfo.PanelID#			
					</cfquery>
					
					<cfquery name="qDeleteContent" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
						DELETE FROM	Content
						WHERE		ContentID = #form.id#			
					</cfquery>
					
				</cfoutput>
		
				<script language="JavaScript">
				<!--
					window.opener.document.location.href = window.opener.document.location.href;
				  window.close();
				//-->
				</script>
		
		<cfelse>
		<!-- Get data for editing -->
			<cfparam name="contentID" default="">
			<cfparam name="panelName" default="">
			<cfparam name="title" default="">
			<cfparam name="body" default="">
			<cfparam name="modified" default="">
			<cfparam name="formattitle" default="HTML">
			<cfparam name="PanelID" default="8">
			<cfparam name="UserID" default=1>
		<cfif isdefined("url.panelname")>
			<cfset panelname = #url.panelname#>
		</cfif>
			
		<script>
		function printarticle(){  
		if (window.print) {
			window.print() ;  
		} else {
			var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
			WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
		}
		}
		</script>		
		<cfoutput>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WORKOUTS</td></tr>
		<tr><td colspan=2 class="centerTitle">#title#</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>

					<cfset body=replace(#body#,"`","'","ALL")>
					#body#
				</td>
			</tr>
		
			<tr>
				<td></td><td>
		
		</cfoutput>
		
		<cfif #GetWorkout.recordcount# gt 0>
			<table style="border-top: solid 1px ##ccc">
				<cfset tCount=1>
				
				<cfset MR=6>
				<cf_NextRecords
					records=#GetWorkout.RecordCount#
					ThispageName="index.cfm"
					RecordsToDisplay=#MR#
					FontSize=3
					UseBold="yes"
					ExtraURL="&CoachAction=#CoachAction#&ViewAction=viewworkout&ClientID=#ClientID#&ContentID=#ContentID#"> 
				<cfset rCount = #SR#>
				<cfoutput query="GetWorkout"
						  startrow=#SR#
						  maxrows=#MR#>
					<cfif isdefined('getWorkout.id')><cfset workoutid=#GetWorkout.id#></cfif>
					<cfquery name="GetContent" datasource="#application.wellcoachesDSN#"  
						username="#application.DSNuName#" password="#application.DSNpWord#">
						select title,fitnesstype,body,userid from content, libraryaccess
						where contentid=#GetWorkout.contentid#
					</cfquery>
					<cfif tCount is 1>
						<tr>
					</cfif>
					<cfset OldViewAction=#ViewAction#>
					<cfset ViewAction="EditWorkout">
					
					<cfset ThisImage=replace(#GetContent.body#,"http://","https://")>
					<cfset ThisImage=replace(#ThisImage#,"`","'","ALL")>
					<td class=caption style="border-right: dotted 1px ##CCC; border-bottom: solid 1px ##ccc;">#ThisImage#<br>
					<span class=workoutHeader>#rCount#) #GetContent.Title# #GetContent.FitnessType#</span><br>
					<cfif #GetContent.UserID# is 2>
					Reps: <span class="captionsc">#reps#</span> 
					Sets: <span class="captionsc">#sets#</span> 
					Lbs: <span class="captionsc">#lbs#</span>
					<cfelseif #GetContent.UserID# is 1>
					Seconds: <span class="captionsc">#reps#</span> 
					Sets: <span class="captionsc">#sets#</span>
					<cfelseif #GetContent.UserID# is 3>
					Minutes: <span class="captionsc">#reps#</span> 
					</cfif>
					<br>#replace(instructions,"~",",","ALL")#
					<cfif #URL.TypeThing# neq "client"><br><a href="index.cfm?contentID=#URL.contentID#&PanelID=#panelID#&CoachAction=#CoachAction#&ViewAction=editworkout&Action=Edit&WorkoutID=#WorkoutID#&ClientID=#ClientID#&menusection=library" class=captionsc>Edit This Exercise</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="index.cfm?contentID=#URL.contentID#&panelID=#panelID#&CoachAction=#CoachAction#&ViewAction=editworkout&Action=Delete&WorkoutID=#WorkoutID#&ClientID=#ClientID#&menusection=library" class=captionsc>Delete This Exercise</a>
					</cfif>
			</td>
					<cfset ViewAction=#OldViewAction#>
					
					<cfset tCount=#tCount# + 1>
					<cfif tCount is 3>
						<cfset tCount = 1>
						</tr>
					</cfif>
					<cfset rCount=#rCount# + 1>
				</cfoutput>
			<cfif tCount is 2><td><img src="../images/b.gif"></td></tr></cfif>
			</table>
		
		
		</cfif>
		
		</cfif>
		<cfoutput>
		<p>&nbsp;</p>
		<p align=center>
		<a href= "../coaching/index.cfm?CoachAction=#CoachAction#&ViewAction=EditWorkout&Clientid=#ClientID#&Action=Add&panelID=8&workoutID=#getworkout.workoutid#&contentID=#url.contentID#&menusection=library">ADD WORKOUT</a>&nbsp;&nbsp;&nbsp;
			<a href= "../coaching/index.cfm?CoachAction=#CoachAction#&ViewAction=emailworkout&Clientid=#ClientID#&contentID=#ContentID#&PanelID=8&workoutID=#GetWorkout.WorkoutID#&menusection=library">EMAIL</a>&nbsp;&nbsp;&nbsp;
			<a href= "../coaching/index.cfm?CoachAction=#CoachAction#&ViewAction=editworkouttitle&Clientid=#ClientID#&contentID=#ContentID#&PanelID=8&workoutID=#GetWorkout.WorkoutID#&menusection=library">EDIT</a>&nbsp;&nbsp;&nbsp;
			<a href= "printworkout.cfm?ClientID=#clientID#&ContentID=#contentID#&Panelname=Fitness&TypeThing=coach&PanelID=8" target="_blank">PRINT</a>
		</p>
		</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="assessment" access="remote" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Comprehensive</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<p><a href="http://www.wellcoaches.biz/coaching/WBA_fillable.pdf" target="_blank">Print blank Assessment Form</a></p>
		<cfquery name="getAssessment" datasource="#application.newDSN#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Readiness">
			<cfinclude template="../coachingscripts/assessreport2.cfm">
		</cfif>
		
		<cfoutput>
		<p>&nbsp;</p>
		<p align=center>
			<a href="../coaching/index.cfm?CoachAction=ViewClient&viewACtion=editassess&ClientID=#ClientID#&RequestTimeout=2000">EDIT</a>
			<a href="../coachingscripts/printassess.cfm?ClientID=#ClientID#&RequestTimeout=2000" target="_blank">PRINT</a>
			<a href="../coaching/getContent.cfm?CoachAction=#coachAction#&ViewAction=emailassess&ClientID=#ClientID#&RequestTimeout=2000" target="_blank">EMAIL</a>
		</p>
		</cfoutput>
		</td></tr></table>
	</cffunction>
	
	<cffunction name="life" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Life">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="stress" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Stress">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="energy" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Energy">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="exercise" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Exercise">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="nutrition" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Nutrition">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="health" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Health">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="weight" access="remote" output="true">
		<cfargument name="clientid" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Weight">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="priorities" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select CoachingPriorities from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfset priorities="">
		<cfset priorities = ListAppend(priorities,"Improve well-being (health and happiness)")>
		<cfset priorities = ListAppend(priorities,"Increase physical activity")>
		<cfset priorities = ListAppend(priorities,"Manage or prevent injury")>
		<cfset priorities = ListAppend(priorities,"Manage stress better or reduce stress")>
		<cfset priorities = ListAppend(priorities,"Improve work/life balance")>
		<cfset priorities = ListAppend(priorities,"Lose weight")>
		<cfset priorities = ListAppend(priorities,"Improve eating habits")>
		<cfset priorities = ListAppend(priorities,"Improve health risks/conditions")>
		<cfset priorities = ListAppend(priorities,"Reduce need for medication")>
		<cfset priorities = ListAppend(priorities,"Improve energy ")>
		<cfset priorities = ListAppend(priorities,"Improve job satisfaction")>
		<cfset priorities = ListAppend(priorities,"Improve family well-being")>
		<cfset priorities = ListAppend(priorities,"Improve sleep")>
		<cfset priorities = ListAppend(priorities,"Manage drug or alcohol issues (supported by a coach who is also a licensed counselor)")>
		<cfset priorities = ListAppend(priorities,"Reduce or quit smoking")>
		<cfset priorities = ListAppend(priorities,"Increase productivity ")>
		<cfset priorities = ListAppend(priorities,"Manage or maintain current weight")>
		<cfset priorities = ListAppend(priorities,"Improve finances")>
		<cfset priorities = ListAppend(priorities,"Improve life satisfaction")>
		<cfset priorities = ListAppend(priorities,"Improve personal relationships (supported by a coach who is also a licensed counselor)")>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Priorities</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<p><strong>Your priorities for your work with a wellness coach are:</strong></p>
		<cfset cpCount=0>
		<p>
		<cfset cpSelect = 0>
		<cfoutput><cfloop index="element" list="#getAssessment.CoachingPriorities#">
		<cfset cpSelect=#cpSelect# + 1>
		<Cfif #element# is 1>
		<cfset cpCount=#cpCount# + 1>
		#cpCount#. #listgetat(Priorities,cpSelect)# <br />
		</Cfif>
		</cfloop></cfoutput>
		</p>
		</td></tr></table>
	</cffunction>
	
	<cffunction name="readiness" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfquery name="getAssessment" datasource="#application.newdsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select assessmentid from assessment where userid=#clientID# order by assessmentid desc
		</cfquery>
		<cfif #getAssessment.recordcount# gt 0>
			<cfset assessid=#getAssessment.assessmentid#>
			<cfset ID="Confidence">
			<cfinclude template="../coachingscripts/assesssection.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="editassess" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfparam name="assessid" default="0">
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where userid=#clientID#
			order by datecreated desc
		</cfquery>
		<cfset RcdCnt=#theAssessment.RecordCount#>
		<cfoutput><table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Assessment</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top></cfoutput>
		
		<cfset assessCount=0>
		<cfset TotalValue=0>
		<cfset assessIDS="">
		<cfset ListPriorities="">
		<table width="100%">
		<tr><td><p class=workoutHeader>Assessment Date</p><p>Click on date to edit</p></td></tr>
		<cfoutput query="theAssessment">
		<tr><td><p class=workoutHeader><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#theAssessment.assessmentID#&ViewAction=editassess2">#dateformat(datecreated,"mm/dd/yyyy")#</a></p>
		<cfset assessIDs=ListAppend(assessIDs,assessmentID)>
		
		</td></tr>
		</cfoutput>
		<cfoutput></table></td></tr></table></cfoutput>
	</cffunction>
	
	<cffunction name="editassess2" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		<cfparam name="assessid" default="0">
		<cfoutput><table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Assessment Page 2</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<table class=listingheader>
		<tr><td width=250 nowrap><font color="##CC0000">Please select the section you wish to edit</font></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editLife">Life Satisfaction</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editPriorities">Coaching Priorities</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editEnergy">Energy</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editWeight">Weight</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editExercise">Exercise</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editNutrition">Nutrition</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editHealth">Health</a></td></tr>
		<tr><td><a href="index.cfm?CoachAction=ViewClient&clientid=#clientid#&assessid=#assessid#&ViewAction=editStress">Mental & Emotional Fitness</a></td></tr></table></td></tr></table></cfoutput>
	
		<cfoutput>
		<p align=center><a href="index.cfm?CoachAction=ViewClient&ClientID=#ClientID#&ViewAction=assessment&menusection=home">REVIEW</a></p></cfoutput>
	
	</cffunction>
	<cffunction name="editLife" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		
		<cfif isdefined('form.lifesubmit')>
			<cfif not isdefined('form.SenseOfPurpose')><cfset form.coping=0></cfif>
			<cfif not isdefined('form.Joy')><cfset form.coping=0></cfif>
			<cfif not isdefined('form.JobSatisfaction')><cfset form.coping=0></cfif>
			<cfif not isdefined('form.Gratitude')><cfset form.coping=0></cfif>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,1,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,1,#form.lifeI#)>
			</cfif>
			
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
		
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			update assessment
			set SenseOfPurpose=#form.SenseOfPurpose#,
			Joy=#form.Joy#,
			JobSatisfaction=#form.JobSatisfaction#,
			Gratitude=#form.Gratitude#,
				Confidence='#form.Confidence#',
				Importance='#form.Importance#',
				Readiness='#form.Readiness#',
				PERSONALRELATIONSHIP='#form.PERSONALRELATIONSHIP#'
			where assessmentID=#AssessID#
		</cfquery>
			<cfoutput><p><b><font color="##993300">Your Life Satisfaction changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Life Satisfaction</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top><form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editLife" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
		<p><b><font color="##993300">Life Satisfaction</font></b><br>
			<b><font color="##993300">Sense of purpose</font></b> – I feel a strong sense of purpose in life: 
			<br>
			<cfset lifeCount=4>
			<cfset purposePercent=0>
				<input type="radio" name="SenseOfPurpose" value="1"<cfif #theAssessment.SenseOfPurpose# is 1> checked</cfif>> Never<br>
				<input type="radio" name="SenseOfPurpose" value="2"<cfif #theAssessment.SenseOfPurpose# is 2> checked</cfif>> Rarely<br>
				<input type="radio" name="SenseOfPurpose" value="3"<cfif #theAssessment.SenseOfPurpose# is 3> checked</cfif>> Sometimes<br>
				<input type="radio" name="SenseOfPurpose" value="4"<cfif #theAssessment.SenseOfPurpose# is 4> checked</cfif>> Frequently<br>
				<input type="radio" name="SenseOfPurpose" value="5"<cfif #theAssessment.SenseOfPurpose# is 5> checked</cfif>> Most of the time<br>
			</p>
			<p><b><font color="##993300">Joy</font></b> – I feel a deep satisfaction or joy in my life:<br />
			<cfset JoyPercent=0>
				<input type="radio" name="Joy" value="1"<cfif #theAssessment.Joy# is 1> checked</cfif>> Never<br>
				<input type="radio" name="Joy" value="2"<cfif #theAssessment.Joy# is 2> checked</cfif>> Rarely<br>
				<input type="radio" name="Joy" value="3"<cfif #theAssessment.Joy# is 3> checked</cfif>> Sometimes<br>
				<input type="radio" name="Joy" value="4"<cfif #theAssessment.Joy# is 4> checked</cfif>> Frequently<br>
				<input type="radio" name="Joy" value="5"<cfif #theAssessment.Joy# gte 5> checked</cfif>> Most of the time<br><br>
				</p>
			<p><b><font color="##993300">Job satisfaction</font></b> – Indicate level of satisfaction:<br />
			<cfset jobPercent=0>
				<input type="radio" name="JobSatisfaction" value="1"<cfif #theAssessment.JobSatisfaction# is 1> checked</cfif>> Disatisfied<br>
				<input type="radio" name="JobSatisfaction" value="2"<cfif #theAssessment.JobSatisfaction# is 2> checked</cfif>> Not very satisfied<br>
				<input type="radio" name="JobSatisfaction" value="3"<cfif #theAssessment.JobSatisfaction# is 3> checked</cfif>> Mostly satisfied<br>
				<input type="radio" name="JobSatisfaction" value="4"<cfif #theAssessment.JobSatisfaction# is 4> checked</cfif>> Not Applicable<br><br>
			
			<b><font color="##993300">Gratitude</font></b> – I feel grateful and appreciative for what I have:<br />
			<cfset GratitudePercent=0>
				<input type="radio" name="Gratitude" value="1"<cfif #theAssessment.Gratitude# is 1> checked</cfif>> Never<br>
				<input type="radio" name="Gratitude" value="2"<cfif #theAssessment.Gratitude# is 2> checked</cfif>> Rarely<br>
				<input type="radio" name="Gratitude" value="3"<cfif #theAssessment.Gratitude# is 3> checked</cfif>> Sometimes<br>
				<input type="radio" name="Gratitude" value="4"<cfif #theAssessment.Gratitude# is 4> checked</cfif>> Frequently<br>
				<input type="radio" name="Gratitude" value="5"<cfif #theAssessment.Gratitude# gte 5> checked</cfif>> Most of the time<br /><br />
				
				<b><font color="##993300">Personal relationship satisfaction</font></b> – I feel grateful and appreciative for what I have:<br />
			<cfset GratitudePercent=0>
				<input type="radio" name="PersonalRelationship" value="1"<cfif #theAssessment.PersonalRelationship# is 1> checked</cfif>> Disatisfied<br>
				<input type="radio" name="PersonalRelationship" value="2"<cfif #theAssessment.PersonalRelationship# is 2> checked</cfif>> Not very satisfied<br>
				<input type="radio" name="PersonalRelationship" value="3"<cfif #theAssessment.PersonalRelationship# is 3> checked</cfif>> Mostly satisfied<br>
				<input type="radio" name="PersonalRelationship" value="4"<cfif #theAssessment.PersonalRelationship# is 4> checked</cfif>> Very Satisfied<br>
				<input type="radio" name="PersonalRelationship" value="5"<cfif #theAssessment.PersonalRelationship# gte 5> checked</cfif>> Not applicable<br><br>
			</p>
		
				<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of having a high level of life satisfaction:</p>
		
		<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,1)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,1)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,1)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,1)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,1)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,1)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,1)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,1)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,1)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,1)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
		
		<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
		<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to reach and sustain a high level of life satisfaction is:</p>
		
		<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,1)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,1)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,1)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,1)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,1)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,1)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,1)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,1)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,1)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,1)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
		
		<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
		<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements in my life satisfaction</p>
		
		<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,1)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,1)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,1)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,1)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,1)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
		<br />
		
			<input type="submit" name="lifesubmit" value="Save Changes">
		</form></cfoutput>
		</td></tt></table>
		</cfif>
	</cffunction>
	<cffunction name="editConfidence" access="remote" output="true">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Confidence</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<cfinclude template="../coaching/editConfidence.cfm">
		</td></tr></table>
	</cffunction>
	<cffunction name="editReadiness" access="remote" output="true">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Readiness</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<cfinclude template="../coaching/editReadiness.cfm">
		</td></tr></table>
	</cffunction>
	<cffunction name="editPriorities" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		<cfset priorities="">
		<cfset priorities = ListAppend(priorities,"Improve well-being (health and happiness)")>
		<cfset priorities = ListAppend(priorities,"Increase physical activity")>
		<cfset priorities = ListAppend(priorities,"Manage or prevent injury")>
		<cfset priorities = ListAppend(priorities,"Manage stress better or reduce stress")>
		<cfset priorities = ListAppend(priorities,"Improve work/life balance")>
		<cfset priorities = ListAppend(priorities,"Lose weight")>
		<cfset priorities = ListAppend(priorities,"Improve eating habits")>
		<cfset priorities = ListAppend(priorities,"Improve health risks/conditions")>
		<cfset priorities = ListAppend(priorities,"Reduce need for medication")>
		<cfset priorities = ListAppend(priorities,"Improve energy ")>
		<cfset priorities = ListAppend(priorities,"Improve job satisfaction")>
		<cfset priorities = ListAppend(priorities,"Improve family well-being")>
		<cfset priorities = ListAppend(priorities,"Manage drug or alcohol issues (supported by a coach who is also a licensed counselor)")>
		<cfset priorities = ListAppend(priorities,"Reduce or quit smoking")>
		<cfset priorities = ListAppend(priorities,"Increase productivity ")>
		<cfset priorities = ListAppend(priorities,"Manage or maintain current weight")>
		<cfset priorities = ListAppend(priorities,"Improve finances")>
		<cfset priorities = ListAppend(priorities,"Improve life satisfaction")>
		<cfset priorities = ListAppend(priorities,"Improve personal relationships (supported by a coach who is also a licensed counselor)")>
		<cfif isdefined('form.prioritysubmit')>
			<cfset MyPriorities="">
			<cfloop index="element" from="1" to="19">
				<cfif isdefined('form.priorities#element#')>
					<cfset MyPriorities=ListAppend(MyPriorities,1)>
				<cfelse>
					<cfset MyPriorities=ListAppend(MyPriorities,0)>
				</cfif>
			</cfloop>
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set CoachingPriorities='#Mypriorities#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Coaching Priorities changes have been made</font></b></p></cfoutput>
		<cfelse>
			<cfif #theAssessment.CoachingPriorities# is "">
				<cfset mypriorities="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0">
			<cfelse>
				<cfset mypriorities=#replace(theassessment.CoachingPriorities,"~",",","ALL")#>
				<cfif listlen(mypriorities) lt 19><cfset mypriorities=listappend(mypriorities,0)></cfif>
			</cfif>
			<cfoutput>
			<table style="padding-left: 30px; padding-right: 30px;">
			<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
			<tr><td colspan=2 class="centerTitle">Edit Comprehensive Coaching Priorities</td></tr>
			<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
			<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
			<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editPriorities" method="post">
			<p><b><font color="##993300">I want to address the following areas with my coach (check all that apply):</font></b><br />
				
				<table>
				<cfset ItemCount=0>
				<cfoutput><cfloop index="element" list="#priorities#">
					<cfset itemCount=#itemCount# + 1>
					<tr><td><input type="checkbox" name="priorities#itemCount#" value="1"<cfif #listgetat(mypriorities,itemCount)# is 1> checked</cfif>>
					#listgetat(priorities,itemCount)#<br>
					</td></tr>
				</cfloop></cfoutput>
				</table>
			
				</p>
				<input type="submit" name="prioritysubmit" value="Save Changes">
			</form>
			</cfoutput>
			</td></td></td>
		</cfif>
	</cffunction>
	<cffunction name="editEnergy" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		
		<cfif isdefined('form.readinesssubmit')>
			<cfset drainElements="">
			<cfloop index="element" from="1" to="11">
				<cfif isdefined('form.drains#element#')>
					<cfset thisData=evaluate("form.drains#element#")>
					<cfset drainElements=ListAppend(drainElements,thisData)>
				<cfelse>
					<cfset drainElements=ListAppend(drainElements,0)>
				</cfif>
			</cfloop>
			<cfset boosterElements="">
			<cfloop index="element" from="1" to="13">
				<cfif isdefined('form.boosters#element#')>
					<cfset boosterElements=ListAppend(boosterElements,evaluate("form.boosters#element#"))>
				<cfelse>
					<cfset boosterElements=ListAppend(boosterElements,0)>
				</cfif>
			</cfloop>
			<cfset energyElements="">
			<cfset energyElements=ListAppend(energyElements,#form.bestEnergyWork#)>
			<cfset energyElements=ListAppend(energyElements,#form.avgEnergyWork#)>
			<cfset energyElements=ListAppend(energyElements,#form.lowEnergyWork#)>
			<cfset energyElements=ListAppend(energyElements,#form.bestEnergyNot#)>
			<cfset energyElements=ListAppend(energyElements,#form.avgEnergyNot#)>
			<cfset energyElements=ListAppend(energyElements,#form.lowEnergyNot#)>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,2,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,2,#form.lifeI#)>
			</cfif>
			
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
		
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set EnergyDrains='#drainElements#',
				EnergyBoosters='#boosterElements#',
				Energy='#energyElements#',
				Confidence='#form.Confidence#',
				Importance='#form.Importance#',
				Readiness='#form.Readiness#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Energy changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfif #theassessment.EnergyBoosters# is ""><cfset myboosters="0,0,0,0,0,0,0,0,0,0,0,0,0">
		<cfelse><cfset myboosters=#replace(theassessment.EnergyBoosters,"~",",","ALL")#></cfif>
		<cfif #theassessment.EnergyDrains# is ""><cfset mydrains="0,0,0,0,0,0,0,0,0,0,0">
		<cfelse><cfset mydrains=#replace(theassessment.EnergyDrains,"~",",","ALL")#></cfif>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Energy</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editEnergy" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
		<cfset Best=0><cfset Medium=0><cfset Low=0>
				<cfset Best2=0><cfset Medium2=0><cfset Low2=0>
				<cfif listlen(#theAssessment.energy#) gt 0>
					<cfset Best=#listgetat(theAssessment.energy,1)#>
					<cfif not isnumeric(Best)><cfset Best=1></cfif>
					<cfset Medium=#listgetat(theAssessment.energy,2)#>
					<cfif not isnumeric(Medium)><cfset Medium=1></cfif>
					<cfset Low=#listgetat(theAssessment.energy,3)#>
					<cfif not isnumeric(Low)><cfset Low=1></cfif>
					<cfset energy1=Best + (Medium / 2) + (Low / 4)>
					<cfif listlen(#theAssessment.energy#) gte 4>
						<cfset Best2=#listgetat(theAssessment.energy,4)#>
						<cfif not isnumeric(Best2)><cfset Best2=1></cfif>
						<cfset Medium2=#listgetat(theAssessment.energy,5)#>
						<cfif not isnumeric(Medium2)><cfset Medium2=1></cfif>
						<cfset Low2=#listgetat(theAssessment.energy,6)#>
						<cfif not isnumeric(Low2)><cfset Low2=1></cfif>
						<cfset energy2=Best2 + (Medium2 / 2) + (Low / 4)>
						<cfset energyPercent=(#energy1# + #energy2#) / 2>
					</cfif>
				</cfif>
			<b><font color="##993300">Energy</font></b><br />
			<p>In a typical work-day circle what percentage of the time are you at (all three add up to 100%) various levels of energy (physical and mental vigor or vitality):
			<cfoutput>
			<ul type="disc"><li>Best energy: <input type="text" name="bestEnergyWork" value="#Best#">
			<li>Average energy:  <input type="text" name="avgEnergyWork" value="#Medium#">
			<li>Low energy: <input type="text" name="lowEnergyWork" value="#Low#"></ul>
			</p>
			<p>When you are not working what percentage of the time are you at (all three add up to 100%):
			<ul type="disc"><li>Best energy <input type="text" name="bestEnergyNot" value="#best2#">
			<li>Average energy <input type="text" name="avgEnergyNot" value="#Medium2#">
			<li>Low energy <input type="text" name="lowEnergyNot" value="#Low2#"></ul>
			</p>
		
			<p><b><font color="##993300">Energy boosters</font></b> – Select the top three things that boost your energy:</p>
			<cfset boosters="">
			<cfset boosters = ListAppend(boosters,"a. Healthy sleep")>
			<cfset boosters = ListAppend(boosters,"b. Regular exercise")>
			<cfset boosters = ListAppend(boosters,"c. Healthy eating habits")>
			<cfset boosters = ListAppend(boosters,"d. Stress management~ relaxation~ or fun activities")>
			<cfset boosters = ListAppend(boosters,"e. Healthy mindset")>
			<cfset boosters = ListAppend(boosters,"f. Healthy family and personal relationships")>
			<cfset boosters = ListAppend(boosters,"g. Healthy work relationships")>
			<cfset boosters = ListAppend(boosters,"h. Maintaining healthy weight")>
			<cfset boosters = ListAppend(boosters,"i. Maintaining good physical health")>
			<cfset boosters = ListAppend(boosters,"j. Job satisfaction")>
			<cfset boosters = ListAppend(boosters,"k. Spiritual activities")>
			<cfset boosters = ListAppend(boosters,"l. Healthy finances")>
			<cfset boosters = ListAppend(boosters,"m. Other - describe")>
			<cfset boostCount=0><p>
			<cfloop index="energyboost" list="#boosters#">
				<cfset boostCount=#boostCount# + 1>
				<cfif boostCount gt 11><cfif #energyboost# neq 0><input type="checkbox" name="boosters#boostCount#" value="1"<cfif #listgetat(myboosters,boostCount)# is 1> checked</cfif>>#energyboost#<br /></cfif>
				<cfelse>
				<cfif #energyboost# gt 0><input type="checkbox" name="boosters#boostCount#" value="1"<cfif #listgetat(myboosters,boostCount)# is 1> checked</cfif>>#replace(energyboost,"~",",","ALL")#<br /></cfif>
				</cfif>
			</cfloop>
			</p>
			<p><b><font color="##993300">Energy drains</font></b> – Select the top three things that are draining your energy:</p>
			<cfset drains="">
			<cfset drains = ListAppend(drains,"a. Poor or insufficient sleep")>
			<cfset drains = ListAppend(drains,"b. Too little exercise")>
			<cfset drains = ListAppend(drains,"c. Unhealthy eating habits")>
			<cfset drains = ListAppend(drains,"d. Stress  ")>
			<cfset drains = ListAppend(drains,"e. Weight management issues")>
			<cfset drains = ListAppend(drains,"f. Physical health issues")>
			<cfset drains = ListAppend(drains,"g. Pessimism or emotional issues")>
			<cfset drains = ListAppend(drains,"h. Work issues ")>
			<cfset drains = ListAppend(drains,"i. Family or relationship issues")>
			<cfset drains = ListAppend(drains,"j. Financial issues")>
			<cfset drains = ListAppend(drains,"k. Other – describe ")>
			<cfset drainCount=0><p>
			<cfloop index="energydrain" list="#drains#">
				<cfset drainCount=#drainCount# + 1>
				<cfif drainCount gt 10><input type="checkbox" name="drains#drainCount#" value="1"<cfif #listgetat(mydrains,draincount)# is 1> checked</cfif>> #energydrain#<br />
				<cfelse>
				<cfif #energydrain# gt 0><input type="checkbox" name="drains#drainCount#" value="1"<cfif #listgetat(mydrains,draincount)# is 1> checked</cfif>> #energydrain#<br /></cfif>
				</cfif>
			</cfloop>
			</p>
				<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of being at my best energy level at least 50% of the time:</p>
		
			<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,2)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,2)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,2)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,2)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,2)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,2)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,2)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,2)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,2)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,2)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to reach and sustain my best energy levels at least 50% of the time is:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,2)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,2)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,2)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,2)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,2)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,2)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,2)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,2)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,2)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,2)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements in my energy levels:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,2)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,2)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,2)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,2)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,2)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
			</cfoutput>
		
			<br /><br />
			<input type="submit" name="readinesssubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>
	</cffunction>
	<cffunction name="editExercise" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		<cfif isdefined('form.exerciseubmit')>
			<cfif not isdefined('form.regularactivity')><cfset form.regularactivity=0></cfif>
			<cfif not isdefined('form.ActivityMinutes')><cfset form.ActivityMinutes=0></cfif>
			<cfif not isdefined('form.AerobicExercise')><cfset form.AerobicExercise=0></cfif>
			<cfif not isdefined('form.StrengthExercises')><cfset form.StrengthExercises=0></cfif>
			<cfif not isdefined('form.StretchingExercises')><cfset form.StretchingExercises=0></cfif>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,4,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,4,#form.lifeI#)>
			</cfif>
				
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set CurrentLimits='#form.CurrentLimits#',
				PreviousLimits='#form.PreviousLimits#',
				regularactivity='#form.regularactivity#',
				ActivityMinutes='#form.ActivityMinutes#',
				AerobicExercise='#form.AerobicExercise#',
				StrengthExercises='#form.StrengthExercises#',
				StretchingExercises='#form.StretchingExercises#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Exercise changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Exercies</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editExercise" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
		<p><b><font color="##993300">Exercise</font></b>
			<cfoutput>
			<p><strong>Current limitations on physical activity</strong> (e.g., injuries, illness, medical conditions):<br />
			<textarea name="CurrentLimits" cols=50 rows=7>#theAssessment.CurrentLimits#</textarea></p>
		
		<p><strong>Previous limitations on physical activity</strong> (over the last 5 years):<br />
		<textarea name="PreviousLimits" cols=50 rows=7>#theassessment.PreviousLimits#</textarea></p>
		
		<p><strong>Regular physical activity</strong> <br />
		Do you currently participate in regular physical activity?<br />
		A. At least 20 minutes of vigorous activity 3 or more days per week (hard enough to make you breathe heavily or make your heart beat faster)<br />
		B. At least 30 minutes of moderate intensity activity 5 or more days per week.<br />
		<strong><select name="regularactivity">
			<option value="0"<cfif #theAssessment.RegularActivity# is 0> selected</cfif>>No</option>
			<option value="1"<cfif #theAssessment.RegularActivity# is 1> selected</cfif>>A</option>
			<option value="2"<cfif #theAssessment.RegularActivity# is 2> selected</cfif>>B</option>
			</select>
		</strong>
		</p>
		
		<p><strong>Other physical activity minutes</strong> - How many minutes in an average day are you physically active (gardening, physical labor, use stairs not elevator, walk not drive, etc):<strong><input type="text" name="activityminutes" value="#theassessment.ActivityMinutes#" /> minutes</strong></p>
		
			<p><strong>Aerobic exercise</strong> – How many days per week do you engage in aerobic exercise of at least 20 minutes duration (fitness walking, cycling, jogging, swimming, aerobic dance, active sports)? <strong>
			<select name="AerobicExercise">
			<option value="0"<cfif #theassessment.AerobicExercise# is 0> selected</cfif>>None</option>
			<option value="1"<cfif #theassessment.AerobicExercise# is 1> selected</cfif>>One Day</option>
			<option value="2"<cfif #theassessment.AerobicExercise# is 2> selected</cfif>>Two Days</option>
			<option value="3"<cfif #theassessment.AerobicExercise# is 3> selected</cfif>>Three Days</option>
			<option value="4"<cfif #theassessment.AerobicExercise# is 4> selected</cfif>>Four Days</option>
			<option value="5"<cfif #theassessment.AerobicExercise# is 5> selected</cfif>>Five Days</option>
			<option value="6"<cfif #theassessment.AerobicExercise# is 6> selected</cfif>>Six Days</option>
			<option value="7"<cfif #theassessment.AerobicExercise# is 7> selected</cfif>>Seven Days</option>
			</select>
			 </strong>
			</p>
		
			<p><strong>Strength exercise</strong> – How many times per week do you do strength building exercises for ten minutes or more, such as sit-ups, pushups, or use strength training equipment?
			<strong>
			<select name="StrengthExercises">
			<option value="1"<cfif #theAssessment.StrengthExercises# is 1> selected</cfif>> 1. None</option>
			<option value="2"<cfif #theAssessment.StrengthExercises# is 2> selected</cfif>> 2. Once a week</option>
			<option value="3"<cfif #theAssessment.StrengthExercises# is 3> selected</cfif>> 3. Twice a week</option>
			<option value="0"<cfif #theAssessment.StrengthExercises# is 0> selected</cfif>> 4. Three or more</option>
			</select>
			</strong></p>
		
			<p><strong>Flexibility or stretching exercise</strong> – How many times per week do you do stretching exercises for five minutes or more to improve flexibility of your back, neck, shoulders, and legs?<strong>
			<select name="StretchingExercises">
			<option value="0"<cfif #theAssessment.StretchingExercises# is 0> selected</cfif>> 1. None</option>
			<option value="1"<cfif #theAssessment.StretchingExercises# is 1> selected</cfif>> 2. Once a week</option>
			<option value="2"<cfif #theAssessment.StretchingExercises# is 2> selected</cfif>> 3. Twice a week</option>
			<option value="3"<cfif #theAssessment.StretchingExercises# is 3> selected</cfif>> 4. Three or more</option>
			</select>
			</strong></p>
			<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of regular physical activity:</p>
		
			<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,4)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,4)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,4)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,4)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,4)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,4)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,4)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,4)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,4)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,4)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to reach and sustain regular physical activity:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,4)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,4)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,4)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,4)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,4)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,4)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,4)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,4)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,4)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,4)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements to reach or sustain regular physical activity:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,4)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,4)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,4)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,4)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,4)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
			</cfoutput>
			
			<br /></p>
			<input type="submit" name="exerciseubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>
	</cffunction>
	<cffunction name="editWeight" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		<cfif isdefined('form.weightsubmit')>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,6,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,6,#form.lifeI#)>
			</cfif>
				
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
			<cfquery name="update" datasource = "#DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set Height='#form.Height#',
				CurrentWeight='#form.CurrentWeight#',
				Waist='#form.Waist#',
				WeightOneYear='#form.OneYear#',
				WeightTwoYears='#form.TwoYears#',
				WeightFiveYears='#form.FiveYears#',
				WeightTenYears='#form.TenYears#',
				weightManagement='#form.weightManagement#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Weight changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Weight</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editweight" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
		<b><font color="##993300">Weight</font></b><br />
			<cfinvoke component="#application.newwebsitepath#.utilities.admin" method="BMI" returnvariable="thisBMI">
				<cfinvokeargument name="height" value="#theassessment.height#">
				<cfinvokeargument name="weight" value="#theassessment.CurrentWeight#">
			</cfinvoke>
			<cfoutput><p>BMI #thisBMI#<br />
			Height (without shoes): <input type="text" name="height" value="#theassessment.Height#" /> inches<br />
			Waist Measurement in inches: <input type="text" name="waist" value="#theassessment.Waist#"><br />
			Current weight (without shoes): <input type="text" name="CurrentWeight" value="#theassessment.CurrentWeight#" /><br />
			Weight one year ago: <input type="text" name="OneYear" value="#theassessment.WeightOneYear#" /><br />
			Weight two years ago: <input type="text" name="TwoYears" value="#theassessment.WeightTwoYears#" /><br />
			Weight five years ago: <input type="text" name="FiveYears" value="#theassessment.WeightFiveYears#" /><br />
			Weight ten years ago: <input type="text" name="TenYears" value="#theassessment.WeightTenYears#" /><br /><br />
			Describe any weight-management program pursued in the last 10 years:<br />
			<textarea name="weightManagement" cols=50 rows=7>#theassessment.weightManagement#</textarea><br />
			
			<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of reaching and sustaining a healthy weight:</p>
			<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<br /></p>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,6)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,6)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,6)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,6)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,6)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,6)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,6)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,6)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,6)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,6)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to reach and sustain a healthy weight:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,6)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,6)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,6)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,6)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,6)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,6)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,6)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,6)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,6)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,6)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements to reach and sustain a healthy weight:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,6)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,6)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,6)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,6)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,6)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
			</cfoutput>
			<input type="submit" name="weightsubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>
	</cffunction>
	<cffunction name="editHealth" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		<cfset PersonalHealthHistoryRadios="">
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Asthma")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Bowel")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Cancer")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"bronchitis")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"heart")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Depression")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Diabetes")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"bloodpressure")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"cholesterol")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Sciatica")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Stroke")>
			<cfset PersonalHealthHistoryRadios=ListAppend(PersonalHealthHistoryRadios,"Arthritis")>
		<cfif isdefined('form.stresssubmit')>
			<cfif not isdefined('form.OverallHealth')><cfset form.Overallhealth=0></cfif>
			<cfif not isdefined('form.PhysicianRelationship')><cfset form.PhysicianRelationship=0></cfif>
			<cfif not isdefined('form.PhysicalExam')><cfset form.PhysicalExam=0></cfif>
			<cfif not isdefined('form.Systolic')><cfset form.Systolic=0></cfif>
			<cfif not isdefined('form.Diastolic')><cfset form.Diastolic=0></cfif>
			<cfif not isdefined('form.TotalCholesterol')><cfset form.TotalCholesterol=0></cfif>
			<cfif not isdefined('form.HDL')><cfset form.HDL=0></cfif>
			<cfif not isdefined('form.LDL')><cfset form.LDL=0></cfif>
			<cfif not isdefined('form.triglyceride')><cfset form.triglyceride=0></cfif>
			<cfif not isdefined('form.SickDays')><cfset form.SickDays=0></cfif>
			<cfif not isdefined('form.TobaccoStatus')><cfset form.TobaccoStatus=0></cfif>
			<cfif not isdefined('form.Medications')><cfset form.Medications=0></cfif>
			<cfif not isdefined('form.BodilyPain')><cfset form.BodilyPain=0></cfif>
			<cfif not isdefined('form.HealthLimitations')><cfset form.HealthLimitations=0></cfif>
			<cfset MyWomenHealthIssues="">
			<cfloop index="element" from="1" to="4">
				<cfif isdefined('form.WomenHealthIssues#element#')>
					<cfset MyWomenHealthIssues=ListAppend(MyWomenHealthIssues,1)>
				<cfelse>
					<cfset MyWomenHealthIssues=ListAppend(MyWomenHealthIssues,0)>
				</cfif>
			</cfloop>
			<cfset MyMenHealthIssues="">
			<cfloop index="element" from="1" to="2">
				<cfif isdefined('form.MenHealthIssues#element#')>
					<cfset MyMenHealthIssues=ListAppend(MyMenHealthIssues,1)>
				<cfelse>
					<cfset MyMenHealthIssues=ListAppend(MyMenHealthIssues,0)>
				</cfif>
			</cfloop>
			<cfset MyFamilyHealthHistory="">
			<cfloop index="element" from="1" to="8">
				<cfif isdefined('form.FamilyHealthHistory#element#')>
					<cfset MyFamilyHealthHistory=ListAppend(MyFamilyHealthHistory,1)>
				<cfelse>
					<cfset MyFamilyHealthHistory=ListAppend(MyFamilyHealthHistory,0)>
				</cfif>
			</cfloop>
			<cfset MyCurrentSymptoms="">
			<cfloop index="element" from="1" to="7">
				<cfif isdefined('form.CurrentSymptoms#element#')>
					<cfset MyCurrentSymptoms=ListAppend(MyCurrentSymptoms,1)>
				<cfelse>
					<cfset MyCurrentSymptoms=ListAppend(MyCurrentSymptoms,0)>
				</cfif>
			</cfloop>
			<cfset PersonalHealthHistory="">
			<cfloop index="element" list="#PersonalHealthHistoryRadios#">
				<cfset PersonalHealthHistory=ListAppend(PersonalHealthHistory,evaluate("form.#element#"))>
			</cfloop>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,7,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,7,#form.lifeI#)>
			</cfif>
				
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set OverallHealth='#form.OverallHealth#',
				PhysicianRelationship='#form.PhysicianRelationship#',
				PhysicalExam='#form.PhysicalExam#',
				Systolic='#form.Systolic#',
				Diastolic='#form.Diastolic#',
				TotalCholesterol='#form.TotalCholesterol#',
				HDL='#form.HDL#',
				LDL='#form.LDL#',
				triglyceride='#form.triglyceride#',
				glucose='#form.glucose#',
				SickDays='#form.SickDays#',
				TobaccoStatus='#form.TobaccoStatus#',
				WomenHealthIssues='#MyWomenHealthIssues#',
				MenHealthIssues='#MyMenHealthIssues#',
				Medications='#form.Medications#',
				FamilyHealthHistory='#MyFamilyHealthHistory#',
				PersonalHealthHistory='#PersonalHealthHistory#',
				CurrentSymptoms='#MyCurrentSymptoms#',
				BodilyPain='#form.BodilyPain#',
				HealthLimitations='#form.HealthLimitations#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Health changes have been made</font></b></p></cfoutput>
		<cfelse>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Health</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<cfoutput><form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editHealth" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
			<cfset overallPercent=0>
			<p><strong>General Health</strong> <br />
			Complete the following statement. In general, my overall health is …<br />
			<strong>
			<input type="radio" name="OverallHealth" value="1"<cfif #theAssessment.OverallHealth# is 1> checked</cfif>>1. Poor <br />
			<input type="radio" name="OverallHealth" value="2"<cfif #theAssessment.OverallHealth# is 2> checked</cfif>>2. Fair <br />
			<input type="radio" name="OverallHealth" value="3"<cfif #theAssessment.OverallHealth# is 3> checked</cfif>>3. Good<br />
			<input type="radio" name="OverallHealth" value="4"<cfif #theAssessment.OverallHealth# is 4> checked</cfif>>4. Very good<br />
			<input type="radio" name="OverallHealth" value="5"<cfif #theAssessment.OverallHealth# is 5> checked</cfif>>5. Excellent<br /></strong></p>
			<cfset PhysicianPercent=0>
			<p><strong>Physician relationship</strong> - Do you have a primary care doctor who you trust and see regularly?<br />
			<strong>
			<input type="radio" name="PhysicianRelationship" value="1"<cfif #theAssessment.PhysicianRelationship# is 1> checked</cfif>>1. No<br />
			<input type="radio" name="PhysicianRelationship" value="2"<cfif #theAssessment.PhysicianRelationship# is 2> checked</cfif>>2. Somewhat<br />
			<input type="radio" name="PhysicianRelationship" value="3"<cfif #theAssessment.PhysicianRelationship# is 3> checked</cfif>>3. Yes<br /></strong></p>
			
			<p><strong>Physical exam</strong> – When was your last physical examination? Within the last …<br />
			<strong>
			<input type="radio" name="PhysicalExam" value="1"<cfif #theAssessment.PhysicalExam# is 1> checked</cfif>>1. Five or more<br />
			<input type="radio" name="PhysicalExam" value="2"<cfif #theAssessment.PhysicalExam# is 2> checked</cfif>>2. 3-4 years<br />
			<input type="radio" name="PhysicalExam" value="3"<cfif #theAssessment.PhysicalExam# is 3> checked</cfif>>3. 2 years<br />
			<input type="radio" name="PhysicalExam" value="4"<cfif #theAssessment.PhysicalExam# is 4> checked</cfif>>4. One year<br /></strong></p>
			
			<p><strong>What is your blood pressure:</strong><br>
		Systolic (high number): <strong><input type="text" name="Systolic" value="#theassessment.Systolic#" /></strong><br>
		Diastolic (low number):  <strong><input type="text" name="Diastolic" value="#theassessment.Diastolic#" /></strong><br>
		What is your total cholesterol:  <strong><input type="text" name="TotalCholesterol" value="#theassessment.TotalCholesterol#" /></strong><br>
		What is your HDL:  <strong><input type="text" name="HDL" value="#theassessment.HDL#" /></strong><br>
		What is your LDL: <strong><input type="text" name="LDL" value="#theassessment.LDL#" /></strong><br>
		What is your fasting Triglyceride level: <strong><input type="text" name="triglyceride" value="#theassessment.triglyceride#" /></strong><br>
		What is your fasting glucose level: <strong><input type="text" name="glucose" value="#theassessment.glucose#" /></strong></p>
		
			<p><strong>Sick days</strong> – How many days did you miss from work due to illness or injury during the last 6 months? <strong>#theASsessment.SickDays#</strong><br />
				<select name="SickDays">
					<cfloop index="NoOfDays" from="0" to="10">
						<option value="#NoOfDays#"<cfif #theASsessment.SickDays# is #NoOfDays#> selected</cfif>>#NoOfDays#</option>
					</cfloop>
				</select>
			</p>
			
			<cfset tobaccoPercent=0>	
			<p><strong>Tobacco status</strong> – Mark the appropriate response.
			</strong><br />
			<input type="radio" name="TobaccoStatus" value="1"<cfif #theAssessment.TobaccoStatus# is 1> checked</cfif>>1. Use chewing tobacco regularly <br />
			<input type="radio" name="TobaccoStatus" value="2"<cfif #theAssessment.TobaccoStatus# is 2> checked</cfif>>2. Currently smoke ten or more cigarettes daily <br />
			<input type="radio" name="TobaccoStatus" value="3"<cfif #theAssessment.TobaccoStatus# is 3> checked</cfif>>3. Currently smoke less than ten cigarettes daily <br />
			<input type="radio" name="TobaccoStatus" value="4"<cfif #theAssessment.TobaccoStatus# is 4> checked</cfif>>4. Smoke pipe or cigar only <br />
			<input type="radio" name="TobaccoStatus" value="5"<cfif #theAssessment.TobaccoStatus# is 5> checked</cfif>>5. Quit smoking less than two years ago <br />
			<input type="radio" name="TobaccoStatus" value="6"<cfif #theAssessment.TobaccoStatus# is 6> checked</cfif>>6. Quit smoking two or more years ago <br />
			<input type="radio" name="TobaccoStatus" value="7"<cfif #theAssessment.TobaccoStatus# gte 7> checked</cfif>>7. Have never smoked (or used tobacco) <br /></strong>
			</p>
		
			<cfif #theAssessment.womenHealthIssues# is ""><cfset womenHealthIssues="0,0,0,0">
			<cfelse><cfset womenHealthIssues=#replace(theassessment.womenHealthIssues,"~",",","ALL")#></cfif>
			<p><b>Women’s health issues – Mark all that apply. Men skip to next question.</b><br />
			<input type="checkbox" name="WomenHealthIssues1" value="1"<cfif #listgetat(WomenHealthIssues,1)# is 1> checked</cfif>>a. Currently pregnant.<br />
			<input type="checkbox" name="WomenHealthIssues2" value="1"<cfif #listgetat(WomenHealthIssues,2)# is 1> checked</cfif>>b. Had PAP smear within last 1-3 years.<br />
			<input type="checkbox" name="WomenHealthIssues3" value="1"<cfif #listgetat(WomenHealthIssues,3)# is 1> checked</cfif>>c. Had mammogram within last 1-2 years.<br />
			<input type="checkbox" name="WomenHealthIssues4" value="1"<cfif #listgetat(WomenHealthIssues,4)# is 1> checked</cfif>>d. Practice monthly breast self-exam. <br />
			</p>
			
			<cfif #theAssessment.MenHealthIssues# is ""><cfset MenHealthIssues="0,0">
			<cfelse><cfset MenHealthIssues=#replace(theassessment.MenHealthIssues,"~",",","ALL")#></cfif>
			<p><b>Men’s health issues – Mark all that apply. Women skip to next question.</b><br />
			<input type="checkbox" name="MenHealthIssues" value="1"<cfif #listgetat(MenHealthIssues,1)# is 1> checked</cfif>>a. Had prostate exam within last 1-2 years<br />
			<input type="checkbox" name="MenHealthIssues" value="1"<cfif #listgetat(MenHealthIssues,1)# is 1> checked</cfif>>b. Practice monthly testicle self-exam for lumps<br />
			</p>
		 
			<p><b>Medications</b> – How often do you use drugs or medicines (include prescription and nonprescription) that treat depression, affect your mood, help you relax, or help you sleep?<br />
			<input type="radio" name="Medications" value="1"<cfif #theASsessment.Medications# is 1> checked</cfif>>1. Frequently<br />
			<input type="radio" name="Medications" value="2"<cfif #theASsessment.Medications# is 2> checked</cfif>>2. Sometimes<br />
			<input type="radio" name="Medications" value="3"<cfif #theASsessment.Medications# is 3> checked</cfif>>3. Rarely<br />
			<input type="radio" name="Medications" value="4"<cfif #theASsessment.Medications# is 4> checked</cfif>>4. Never<br />
			</p>
			
			<cfif #theAssessment.FamilyHealthHistory# is ""><cfset FamilyHealthHistory="0,0,0,0,0,0,0,0">
			<cfelse><cfset FamilyHealthHistory=#replace(theassessment.FamilyHealthHistory,"~",",","ALL")#></cfif>
			<p><b>Family health history</b> – Mark any of the following health problems found in your family (parent, brother, sister).<br />
			<input type="checkbox" name="FamilyHealthHistory1" value="1"<cfif #listgetat(FamilyHealthHistory,1)# is 1> checked</cfif>>a. Colorectal cancer<br />
			<input type="checkbox" name="FamilyHealthHistory2" value="1"<cfif #listgetat(FamilyHealthHistory,2)# is 1> checked</cfif>>b. Breast cancer<br />
			<input type="checkbox" name="FamilyHealthHistory3" value="1"<cfif #listgetat(FamilyHealthHistory,3)# is 1> checked</cfif>>c. Depression<br />
			<input type="checkbox" name="FamilyHealthHistory4" value="1"<cfif #listgetat(FamilyHealthHistory,4)# is 1> checked</cfif>>d. Diabetes<br />
			<input type="checkbox" name="FamilyHealthHistory5" value="1"<cfif #listgetat(FamilyHealthHistory,5)# is 1> checked</cfif>>e. Coronary heart disease, heart attack, or coronary surgery before age 55 in men, before age 65 in women<br />
			<input type="checkbox" name="FamilyHealthHistory6" value="1"<cfif #listgetat(FamilyHealthHistory,6)# is 1> checked</cfif>>f. High blood pressure<br />
			<input type="checkbox" name="FamilyHealthHistory7" value="1"<cfif #listgetat(FamilyHealthHistory,7)# is 1> checked</cfif>>g. High blood cholesterol<br />
			<input type="checkbox" name="FamilyHealthHistory8" value="1"<cfif #listgetat(FamilyHealthHistory,8)# is 1> checked</cfif>>h. Suicide<br />
			</p>
			
			<p><b>Personal health history</b> – Has a doctor informed you that you currently have any of the following health problems?<br />
			<ul><li>1 No</li>
			<li>2 Yes and is not under control</li>
			<li>3 Yes and taking medication or is under control.</li></ul></p>
			<cfset PersonalHealthHistoryList="">
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"a. Asthma or lung disorder")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"b. Bowel polyps or inflammatory bowel disease")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"c. Cancer~ other than non-melanoma skin cancer")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"d. Chronic bronchitis or emphysema (COPD)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"e. Coronary heart disease~ congestive heart failure~ angina~ heart attack~ or heart surgery")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"f. Depression (mental illness)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"g. Diabetes (high blood sugar)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"h. High blood pressure (140/90 or higher)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"i. High blood cholesterol (200 or higher)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"j. Sciatica or chronic back problem (musculoskeletal)")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"k. Stroke or restricted blood flow to head or legs")>
			<cfset PersonalHealthHistoryList=ListAppend(PersonalHealthHistoryList,"l. Arthritis")>
		
			<br />
			<cfif #theAssessment.PersonalHealthHistory# is ""><cfset PersonalHealthHistory="0,0,0,0,0,0,0,0,0,0,0,0">
			<cfelse><cfset PersonalHealthHistory=#replace(theassessment.PersonalHealthHistory,"~",",","ALL")#></cfif>
			<table>
			<tr><td>&nbsp;</td><td>1</td><td>2</td><td>3</td></tr>
				<cfset itemCount=0>
				<cfloop index="element" list="#PersonalHealthHistoryList#">
					<cfset itemCount=#itemCount# + 1>
					<tr><td><p>#replace(element,"~",",","ALL")# </p></td>
					<td><input type="radio" name="#listgetat(PersonalHealthHistoryRadios,itemCount)#" value="0"<cfif #listgetat(PersonalHealthHistory,itemCount)# is 0> checked</cfif>></td>
					<td><input type="radio" name="#listgetat(PersonalHealthHistoryRadios,itemCount)#" value="1"<cfif #listgetat(PersonalHealthHistory,itemCount)# is 1> checked</cfif>></td>
					<td><input type="radio" name="#listgetat(PersonalHealthHistoryRadios,itemCount)#" value="2"<cfif #listgetat(PersonalHealthHistory,itemCount)# is 2> checked</cfif>></td>
				</cfloop>				
				</table>
				
			<cfif #theAssessment.CurrentSymptoms# is ""><cfset CurrentSymptoms="0,0,0,0,0,0,0">
			<cfelse><cfset CurrentSymptoms=#replace(theassessment.CurrentSymptoms,"~",",","ALL")#></cfif>
			<p><b>Current symptoms</b> – Mark any of the following symptoms you have experienced within the last four weeks.<br />
			<input type="checkbox" name="CurrentSymptoms1" value="1"<cfif #listgetat(CurrentSymptoms,1)# is 1> checked</cfif>>a. Chest pain or discomfort, frequent palpitations or fluttering in the heart<br />
			<input type="checkbox" name="CurrentSymptoms2" value="1"<cfif #listgetat(CurrentSymptoms,2)# is 1> checked</cfif>>b. Unusual shortness of breath<br />
			<input type="checkbox" name="CurrentSymptoms3" value="1"<cfif #listgetat(CurrentSymptoms,3)# is 1> checked</cfif>>c. Unexplained dizziness or fainting<br />
			<input type="checkbox" name="CurrentSymptoms4" value="1"<cfif #listgetat(CurrentSymptoms,4)# is 1> checked</cfif>>d. Temporary sensation of numbness or tingling, paralysis, vision problem, or lightheadedness<br />
			<input type="checkbox" name="CurrentSymptoms5" value="1"<cfif #listgetat(CurrentSymptoms,5)# is 1> checked</cfif>>e. Frequent urination and unusual thirst<br />
			<input type="checkbox" name="CurrentSymptoms6" value="1"<cfif #listgetat(CurrentSymptoms,6)# is 1> checked</cfif>>f. Frequent back pain<br />
			<input type="checkbox" name="CurrentSymptoms7" value="1"<cfif #listgetat(CurrentSymptoms,7)# is 1> checked</cfif>>g. Have trouble sleeping lately<br />
			</p>
			
			<p><b>Bodily pain</b> – How much bodily pain have you had during the past four weeks?<br />
				<input type="radio" name="BodilyPain" value="1"<cfif #theAssessment.BodilyPain# is 1> checked</cfif>>1. Very severe<br />
				<input type="radio" name="BodilyPain" value="2"<cfif #theAssessment.BodilyPain# is 2> checked</cfif>>2. Severe<br />
				<input type="radio" name="BodilyPain" value="3"<cfif #theAssessment.BodilyPain# is 3> checked</cfif>>3. Moderate<br />
				<input type="radio" name="BodilyPain" value="4"<cfif #theAssessment.BodilyPain# is 4> checked</cfif>>4. Mild<br />
				<input type="radio" name="BodilyPain" value="5"<cfif #theAssessment.BodilyPain# is 5> checked</cfif>>5. Very mild<br />
				<input type="radio" name="BodilyPain" value="6"<cfif #theAssessment.BodilyPain# is 6> checked</cfif>>6. None<br />
				</p>
		 
		
			<p><b>Health limitations</b> – During the past four weeks, how much difficulty did you have doing your work or other regular activities as a result of your physical health?<br />
				<input type="radio" name="HealthLimitations" value="1"<cfif #theAssessment.HealthLimitations# is 1> checked</cfif>>a. Could not do daily work<br />
				<input type="radio" name="HealthLimitations" value="2"<cfif #theAssessment.HealthLimitations# is 2> checked</cfif>>b. Quite a bit<br />
				<input type="radio" name="HealthLimitations" value="3"<cfif #theAssessment.HealthLimitations# is 3> checked</cfif>>c. Some<br />
				<input type="radio" name="HealthLimitations" value="4"<cfif #theAssessment.HealthLimitations# is 4> checked</cfif>>d. A little bit<br />
				<input type="radio" name="HealthLimitations" value="5"<cfif #theAssessment.HealthLimitations# is 5> checked</cfif>>e. None<br />
			</p>
			<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of managing my health:</p>
			<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,7)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,7)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,7)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,7)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,7)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,7)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,7)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,7)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,7)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,7)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to manage my health:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,7)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,7)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,7)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,7)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,7)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,7)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,7)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,7)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,7)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,7)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements in managing my health:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,7)# is 0> checked</cfif> />A.	No present interest in making a change <br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,7)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,7)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,7)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,7)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
			<br /><br />
			<input type="submit" name="stresssubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>
	</cffunction>
	<cffunction name="editStress" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		<cfset feelingsRadios="">
			<cfif not isdefined('form.coping')><cfset form.coping=0></cfif>
			<cfif not isdefined('form.HoursOfSleep')><cfset form.HoursOfSleep=0></cfif>
			<cfif not isdefined('form.EmotionalIssues')><cfset form.EmotionalIssues=0></cfif>
			<cfif not isdefined('form.SocialActivity')><cfset form.SocialActivity=0></cfif>
			<cfif not isdefined('form.PersonalLoss')><cfset form.PersonalLoss=0></cfif>
			<cfif not isdefined('form.SocialSupport')><cfset form.SocialSupport=0></cfif>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"peaceful")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"fenergy")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"happy")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"relax")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"downhearted")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"worthless")>
		<cfset depressionRadios="">
				<cfset depressionRadios = ListAppend(depressionRadios,"energy")>	
				<cfset depressionRadios = ListAppend(depressionRadios,"blame")>
				<cfset depressionRadios = ListAppend(depressionRadios,"appetite")>
				<cfset depressionRadios = ListAppend(depressionRadios,"asleep")>
				<cfset depressionRadios = ListAppend(depressionRadios,"hopeless")>
				<cfset depressionRadios = ListAppend(depressionRadios,"blue")>
				<cfset depressionRadios = ListAppend(depressionRadios,"interest")>
				<cfset depressionRadios = ListAppend(depressionRadios,"worthlessness")>
				<cfset depressionRadios = ListAppend(depressionRadios,"suicide")>
				<cfset depressionRadios = ListAppend(depressionRadios,"decisions")>
		<cfif isdefined('form.stresssubmit')>
			<cfset MyStress="">
			<cfloop index="element" from="1" to="6">
				<cfif isdefined('form.stress#element#')>
					<cfset MyStress=ListAppend(MyStress,1)>
				<cfelse>
					<cfset MyStress=ListAppend(MyStress,0)>
				</cfif>
			</cfloop>
			<cfset feelings="">
			<cfloop index="element" list="#feelingsradios#">
				<cfset feelings=ListAppend(feelings,evaluate("form.#element#"))>
			</cfloop>
			<cfset depressionEvaluation="">
			<cfloop index="element" list="#depressionRadios#">
				<cfset depressionEvaluation=ListAppend(depressionEvaluation,evaluate("form.#element#"))>
			</cfloop>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,3,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,3,#form.lifeI#)>
			</cfif>
				
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set coping='#form.coping#',
				stress='#MyStress#',
				HoursOfSleep='#form.HoursOfSleep#',
				EmotionalIssues='#form.EmotionalIssues#',
				SocialActivity='#form.SocialActivity#',
				PersonalLoss='#form.PersonalLoss#',
				SocialSupport='#form.SocialSupport#',
				feelings='#feelings#',
				depressionEvaluation='#depressionEvaluation#',
				Confidence='#form.Confidence#',
				Importance='#form.Importance#',
				Readiness='#form.Readiness#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Mental & Emotional Fitness changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Mental & Emotional Fitness</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editStress" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
			<p><strong>Coping</strong> – How well do you feel you are coping with your current stress load?<br />
			<input type="radio" name="coping" value="1"<cfif #theAssessment.coping# is 1> checked</cfif>>1. Feel unable to cope any more<br />
			<input type="radio" name="coping" value="2"<cfif #theAssessment.coping# is 2> checked</cfif>>2. Often have trouble coping <br />
			<input type="radio" name="coping" value="3"<cfif #theAssessment.coping# is 3> checked</cfif>>3. Have trouble coping at times<br />
			<input type="radio" name="coping" value="4"<cfif #theAssessment.coping# is 4> checked</cfif>>4. Coping fairly well<br />
			<input type="radio" name="coping" value="5"<cfif #theAssessment.coping# is 5> checked</cfif>>5. Coping very well</p>
			
			<p><strong>Stress</strong> - Mark any symptoms below that apply to you.</p>
		<cfset stressList="">
			<cfset stressList = ListAppend(stressList,"a. Minor problems throw me for a loop.")>
			<cfset stressList = ListAppend(stressList,"b. I find it difficult to get along with people I used to enjoy.")>
			<cfset stressList = ListAppend(stressList,"c. Nothing seems to give me pleasure anymore.")>
			<cfset stressList = ListAppend(stressList,"d. I am unable to stop thinking about my problems.")>
			<cfset stressList = ListAppend(stressList,"e. I feel frustrated~ impatient~ or angry much of the time.")>
			<cfset stressList = ListAppend(stressList,"f. I feel tense or anxious much of the time.")>
			<cfif #theAssessment.stress# is ""><cfset stress="0,0,0,0,0,0">
			<cfelse><cfset stress=#replace(theassessment.stress,"~",",","ALL")#></cfif>
			<cfset stressCount=0><p>
			<cfloop index="element" list="#stressList#">
				<cfset stressCount=#stressCount# + 1>
				<input type="checkbox" name="stress#stressCount#" value="1"<cfif #listgetat(stress,stressCount)# is 1> checked</cfif>>#element#<br />
			</cfloop>
			<p><strong>Sleep</strong> – How many hours of sleep do you get on average:<br />
				<input type="radio" name="HoursOfSleep" value="1"<cfif #theAssessment.HoursOfSleep# is 1> checked</cfif>>1. Less than 6<br />
				<input type="radio" name="HoursOfSleep" value="2"<cfif #theAssessment.HoursOfSleep# is 2> checked</cfif>>2. 6-7<br />
				<input type="radio" name="HoursOfSleep" value="3"<cfif #theAssessment.HoursOfSleep# is 3> checked</cfif>>3. 7-8<br />
				<input type="radio" name="HoursOfSleep" value="4"<cfif #theAssessment.HoursOfSleep# is 4> checked</cfif>>4. 8-9
			 </p>
			
			<p><strong>Emotional issues</strong> – During the past four weeks, to what extent have you accomplished less than you would like in your work or other daily activities as a result of emotional issues, such as feeling depressed or anxious?<br />
				<input type="radio" name="EmotionalIssues" value="1"<cfif #theAssessment.EmotionalIssues# is 1> checked</cfif>>Extremely<br />
				<input type="radio" name="EmotionalIssues" value="2"<cfif #theAssessment.EmotionalIssues# is 2> checked</cfif>>Quite a bit<br />
				<input type="radio" name="EmotionalIssues" value="3"<cfif #theAssessment.EmotionalIssues# is 3> checked</cfif>>Moderately<br />
				<input type="radio" name="EmotionalIssues" value="4"<cfif #theAssessment.EmotionalIssues# is 4> checked</cfif>>Slightly<br />
				<input type="radio" name="EmotionalIssues" value="5"<cfif #theAssessment.EmotionalIssues# gte 5> checked</cfif>>None at all
			</p>
			<p><strong>Social activity</strong> – during the past four weeks, to what extent has your physical health or emotional issues interfered with your normal social activities with family, friends, neighbors, or groups?<br />
				<input type="radio" name="SocialActivity" value="1"<cfif #theAssessment.SocialActivity# is 1> checked</cfif>>1. Extremely<br />
				<input type="radio" name="SocialActivity" value="2"<cfif #theAssessment.SocialActivity# is 2> checked</cfif>>2. Quite a bit<br />
				<input type="radio" name="SocialActivity" value="3"<cfif #theAssessment.SocialActivity# is 3> checked</cfif>>3. Moderately<br />
				<input type="radio" name="SocialActivity" value="4"<cfif #theAssessment.SocialActivity# is 4> checked</cfif>>4. Slightly<br />
				<input type="radio" name="SocialActivity" value="5"<cfif #theAssessment.SocialActivity# gte 5> checked</cfif>>5. Not at all
			</p>
			<p><strong>Personal loss </strong>- Have you suffered a personal loss or misfortune in the past year? (For example: a job loss, disability, divorce, separation, or the death of someone close to you)<br />
				<input type="radio" name="PersonalLoss" value="1"<cfif #theAssessment.PersonalLoss# is 1> checked</cfif>>1. No<br />
				<input type="radio" name="PersonalLoss" value="2"<cfif #theAssessment.PersonalLoss# is 2> checked</cfif>>2. Yes – one loss<br />
				<input type="radio" name="PersonalLoss" value="3"<cfif #theAssessment.PersonalLoss# is 3> checked</cfif>>3. Yes – two or more serious losses
			</p> 
			<p><strong>Social support</strong> – Do you have friends/family with whom you can share problems and get help if needed?<br />
				<input type="radio" name="SocialSupport" value="1"<cfif #theAssessment.SocialSupport# is 1> checked</cfif>>1. No<br />
				<input type="radio" name="SocialSupport" value="2"<cfif #theAssessment.SocialSupport# is 2> checked</cfif>>2. Yes
			</p>
			<p><strong>Feelings</strong> – The next questions are about how you feel things have been with you during the past four weeks. For each question, please give the one answer that comes the closest to the way you have been feeling. How much of the time during the past four weeks …</p>
			<ul><li>1. None of the time</li>
			<li>2. A little of the time</li>
			<li>3. Some of the time</li>
			<li>4. A good bit of the time</li>
			<li>5. All of the time</li></ul>
			<cfif #theAssessment.feelings# is ""><cfset feelings="0,0,0,0,0,0,0">
			<cfelse><cfset feelings=#replace(theassessment.feelings,"~",",","ALL")#></cfif>
			<cfset feelingsList="">
			<cfset feelingsList=ListAppend(feelingsList,"a. Have you felt calm and peaceful?")>
			<cfset feelingsList=ListAppend(feelingsList,"b. Did you have a lot of energy?")>
			<cfset feelingsList=ListAppend(feelingsList,"c. Have you been a happy person?")>
			<cfset feelingsList=ListAppend(feelingsList,"d. Did you take the time to relax and have fun daily?")>
			<cfset feelingsList=ListAppend(feelingsList,"e. Have you felt downhearted or blue?")>
			<cfset feelingsList=ListAppend(feelingsList,"f. Have you felt worthless~ inadequate~ or unimportant?")>
			<cfset feelingsRadios="">
			<cfset feelingsRadios=ListAppend(feelingsRadios,"peaceful")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"fenergy")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"happy")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"relax")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"downhearted")>
			<cfset feelingsRadios=ListAppend(feelingsRadios,"worthless")>
			<cfset itemCount=0>
			<table>
			<tr><td>&nbsp;</td><td><p>N/A</p></td><td><p>1</p></td><td><p>2</p></td><td><p>3</p></td><td><p>4</p></td><td><p>5</p></td></tr>
			<cfloop index="element" list="#feelingsList#">
				<cfset itemCount=#itemCount# + 1>
				<tr><td><p>#replace(element,"~",",","ALL")# </p></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="0"<cfif #listgetat(feelings,itemCount)# is 0> checked</cfif>></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="1"<cfif #listgetat(feelings,itemCount)# is 1> checked</cfif>></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="2"<cfif #listgetat(feelings,itemCount)# is 2> checked</cfif>></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="3"<cfif #listgetat(feelings,itemCount)# is 3> checked</cfif>></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="4"<cfif #listgetat(feelings,itemCount)# is 4> checked</cfif>></td>
				<td><input type="radio" name="#listgetat(feelingsRadios,itemCount)#" value="5"<cfif #listgetat(feelings,itemCount)# is 5> checked</cfif>></td></tr>
			</cfloop>
			</table>
			
			
			<p><b><font color="##993300">Depression Evaluation</font></b><br />
				 If you answered 3 or higher for e. and f. in Feelings, please complete the below:<br />
				 Over past two weeks, how often have you:	
				<Ul><li>A. None or little of the time
				<li>B. Some of the time
				<li>C. Most of the time
				<li>D. All of the time</ul></p>
			<cfif #theAssessment.depressionEvaluation# is ""><cfset depression="0,0,0,0,0,0,0,0,0,0,0">
			<cfelse><cfset depression=#replace(theassessment.depressionEvaluation,"~",",","ALL")#></cfif>
				<cfset depressionList="">
				<cfset depressionList = ListAppend(depressionList,"Been feeling low in energy~ slowed down?")>	
				<cfset depressionList = ListAppend(depressionList,"Been blaming yourself for things?")>
				<cfset depressionList = ListAppend(depressionList,"Had a poor appetite?")>
				<cfset depressionList = ListAppend(depressionList,"Had difficulty falling asleep~ staying asleep?")>
				<cfset depressionList = ListAppend(depressionList,"Been feeling hopeless about the future?")>
				<cfset depressionList = ListAppend(depressionList,"Been feeling blue?")>
				<cfset depressionList = ListAppend(depressionList,"Been feeling no interest in things?")>
				<cfset depressionList = ListAppend(depressionList,"Had feelings of worthlessness?")>
				<cfset depressionList = ListAppend(depressionList,"Thought about or wanted to commit suicide?")>
				<cfset depressionList = ListAppend(depressionList,"Had difficulty concentrating or making decisions?")>
				<cfset depressionRadios="">
				<cfset depressionRadios = ListAppend(depressionRadios,"energy")>	
				<cfset depressionRadios = ListAppend(depressionRadios,"blame")>
				<cfset depressionRadios = ListAppend(depressionRadios,"appetite")>
				<cfset depressionRadios = ListAppend(depressionRadios,"asleep")>
				<cfset depressionRadios = ListAppend(depressionRadios,"hopeless")>
				<cfset depressionRadios = ListAppend(depressionRadios,"blue")>
				<cfset depressionRadios = ListAppend(depressionRadios,"interest")>
				<cfset depressionRadios = ListAppend(depressionRadios,"worthlessness")>
				<cfset depressionRadios = ListAppend(depressionRadios,"suicide")>
				<cfset depressionRadios = ListAppend(depressionRadios,"decisions")>
				
				<table>
			<tr><td>&nbsp;</td><td>A</td><td>B</td><td>C</td><td>D</td></tr>
				<cfset itemCount=0>
				<cfloop index="element" list="#depressionList#">
					<cfset itemCount=#itemCount# + 1>
					<tr><td><p>#replace(element,"~",",","ALL")# </p></td>
					<td><input type="radio" name="#listgetat(depressionRadios,itemCount)#" value="0"<cfif #listgetat(depression,itemCount)# is 0> checked</cfif>></td>
					<td><input type="radio" name="#listgetat(depressionRadios,itemCount)#" value="1"<cfif #listgetat(depression,itemCount)# is 1> checked</cfif>></td>
					<td><input type="radio" name="#listgetat(depressionRadios,itemCount)#" value="2"<cfif #listgetat(depression,itemCount)# is 2> checked</cfif>></td>
					<td><input type="radio" name="#listgetat(depressionRadios,itemCount)#" value="3"<cfif #listgetat(depression,itemCount)# is 3> checked</cfif>></td></tr>
				</cfloop>				
				</table>
		
				<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of reaching and sustaining optimal mental and emotional fitness:</p>
		
			<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,3)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,3)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,3)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,3)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,3)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,3)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,3)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,3)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,3)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,3)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to reach and sustain optimal mental and emotional fitness:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,3)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,3)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,3)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,3)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,3)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,3)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,3)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,3)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,3)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,3)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements to reach and sustain optimal mental and physical fitness is:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,3)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,3)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,3)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,3)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,3)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
		
			<br /><br />
			<input type="submit" name="stresssubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>

	</cffunction>
	<cffunction name="editNutrition" access="remote" output="true">
		<cfparam name="AssessID" default=2>
		<cfquery name="theAssessment" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from assessment
			where assessmentID=#AssessID#
		</cfquery>
		
		<cfif isdefined('form.nutritionssubmit')>
			<cfif not isdefined('form.Breakfast')><cfset form.Breakfast=0></cfif>
			<cfif not isdefined('form.Snacks')><cfset form.Snacks=0></cfif>
			<cfif not isdefined('form.FatIntake')><cfset form.FatIntake=0></cfif>
			<cfif not isdefined('form.TransFats')><cfset form.TransFats=0></cfif>
			<cfif not isdefined('form.BreadsGrains')><cfset form.BreadsGrains=0></cfif>
			<cfif not isdefined('form.FruitsAndVeggies')><cfset form.FruitsAndVeggies=0></cfif>
			<cfif not isdefined('form.Water')><cfset form.Water=0></cfif>
			<cfif not isdefined('form.SoftDrinks')><cfset form.SoftDrinks=0></cfif>
			<cfif not isdefined('form.WeekDayAlcohol')><cfset form.WeekDayAlcohol=0></cfif>
			<cfif not isdefined('form.WeekEndAlcohol')><cfset form.WeekEndAlcohol=0></cfif>
			<cfif #listlen(form.importance)# gt 0>
				<cfset #form.importance# = ListSetAt(#form.importance#,5,#form.lifeI#)>
			<cfelse>
				<cfset form.importance="0,0,0,0,0,0,0">
				<cfset #form.importance# = ListSetAt(#form.importance#,5,#form.lifeI#)>
			</cfif>
				
			<cfif #listlen(form.confidence)# gt 0>
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			<cfelse>
				<cfset form.confidence="0,0,0,0,0,0,0">
				<cfset #form.confidence# = ListSetAt(#form.confidence#,1,#form.lifeC#)>
			</cfif>
			
			<cfif #listlen(form.readiness)# gt 0>
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			<cfelse>
				<cfset form.readiness="0,0,0,0,0,0,0">
				<cfset #form.readiness# = ListSetAt(#form.readiness#,1,#form.lifeR#)>
			</cfif>
			<cfquery name="update" datasource = "#application.newDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				update assessment
				set Breakfast='#form.Breakfast#',
				Snacks='#form.Snacks#',
				FatIntake='#form.FatIntake#',
				TransFats='#form.TransFats#',
				BreadsGrains='#form.BreadsGrains#',
				FruitsAndVeggies='#form.FruitsAndVeggies#',
				Water='#form.Water#',
				SoftDrinks='#form.SoftDrinks#',
				WeekDayAlcohol='#form.WeekDayAlcohol#',
				WeekEndAlcohol='#form.WeekEndAlcohol#'
				where assessmentID=#AssessID#
			</cfquery>
		
			<cfoutput><p><b><font color="##993300">Your Nutrition changes have been made</font></b></p></cfoutput>
		<cfelse>
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WELL BEING ASSESSMENT</td></tr>
		<tr><td colspan=2 class="centerTitle">Edit Comprehensive Nutrition</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		<form action="index.cfm?assessid=#assessid#&clientid=#clientid#&CoachAction=ViewClient&ViewAction=editNutrition" method="post">
			<input type="hidden" name="importance" value="#theassessment.importance#" />
			<input type="hidden" name="confidence" value="#theassessment.confidence#" />
			<input type="hidden" name="readiness" value="#theassessment.readiness#" />
		<cfoutput>
		
			<p><strong>Breakfast</strong> – How often do you eat breakfast, more than just a roll and a cup of coffee?<br />
			<strong>
			<input type="radio" name="Breakfast" value="1"<cfif #theAssessment.Breakfast# is 1> checked</cfif>>Seldom or never eat breakfast<br />
			<input type="radio" name="Breakfast" value="2"<cfif #theAssessment.Breakfast# is 2> checked</cfif>>Eat breakfast two to three times per week<br />
			<input type="radio" name="Breakfast" value="3"<cfif #theAssessment.Breakfast# is 3> checked</cfif>>Eat breakfast most mornings<br />
			<input type="radio" name="Breakfast" value="4"<cfif #theAssessment.Breakfast# is 4> checked</cfif>>Eat breakfast every day <br /></strong>	</p>
			
			<p><strong>Snacks</strong> – How often do you eat “junk” snack foods between meals (e.g. chips, pastries, candy, ice cream, cookies)? <br />
			<strong>
			<input type="radio" name="Snacks" value="1"<cfif #theAssessment.Snacks# is 1> checked</cfif>>1. Three or more times per day <br />
			<input type="radio" name="Snacks" value="2"<cfif #theAssessment.Snacks# is 2> checked</cfif>>2. Once or twice per day<br />
			<input type="radio" name="Snacks" value="3"<cfif #theAssessment.Snacks# is 3> checked</cfif>>3. Few times per week <br />
			<input type="radio" name="Snacks" value="4"<cfif #theAssessment.Snacks# is 4> checked</cfif>>4. Seldom or never eat "junk" snack foods<br /></strong>	</p>
			 
			<p><strong>Fat intake</strong> – Indicate the kinds of foods you usually eat.<br />
			<strong>
			<input type="radio" name="FatIntake" value="1"<cfif #theAssessment.FatIntake# is 1> checked</cfif>>1. Nearly always eat the high fat foods <br />
			<input type="radio" name="FatIntake" value="2"<cfif #theAssessment.FatIntake# is 2> checked</cfif>>2. Eat mostly the high fat foods, some low fat<br />
			<input type="radio" name="FatIntake" value="3"<cfif #theAssessment.FatIntake# is 3> checked</cfif>>3. Eat both about the same<br />
			<input type="radio" name="FatIntake" value="4"<cfif #theAssessment.FatIntake# is 4> checked</cfif>>4. Eat mostly low fat foods, some high fat<br />
			<input type="radio" name="FatIntake" value="5"<cfif #theAssessment.FatIntake# is 5> checked</cfif>>5. Eat only low fat foods<br /></strong>	</p>
		
			<p><strong>Trans fats</strong> are commonly listed as “partially hydrogenated vegetable oil” on food labels.  These processed fats increase shelf life and give foods a firmer texture, but they can greatly increase your risk of developing heart disease.  Many snacks, baked goods, and even healthy-appearing breakfast cereals contain trans fat or partially hydrogenated vegetable oil.  How often do you eat foods containing trans fats or partially hydrogenated oil? <br />
			<strong>
			<input type="radio" name="TransFats" value="1"<cfif #theAssessment.TransFats# is 1> checked</cfif>>1. I haven't paid attention to trans fats or partially hydrogenated vegetable oils before<br />
			<input type="radio" name="TransFats" value="2"<cfif #theAssessment.TransFats# is 2> checked</cfif>>2. Many times each day<br />
			<input type="radio" name="TransFats" value="3"<cfif #theAssessment.TransFats# is 3> checked</cfif>>3. At least once a day<br />
			<input type="radio" name="TransFats" value="4"<cfif #theAssessment.TransFats# is 4> checked</cfif>>4. Occasionally <br />
			<input type="radio" name="TransFats" value="5"<cfif #theAssessment.TransFats# is 5> checked</cfif>>5. Rarely, if ever<br /></strong>	</p>
		
			<p><strong>Breads and grains</strong> – Indicate the kinds of breads and grains you usually eat.<br />
			<strong>
			<input type="radio" name="BreadsGrains" value="1"<cfif #theAssessment.BreadsGrains# is 1> checked</cfif>>1. Nearly always eat refined grain products <br />
			<input type="radio" name="BreadsGrains" value="2"<cfif #theAssessment.BreadsGrains# is 2> checked</cfif>>2. Eat mostly refined grain products <br />
			<input type="radio" name="BreadsGrains" value="3"<cfif #theAssessment.BreadsGrains# is 3> checked</cfif>>3. Eat both about the same <br />
			<input type="radio" name="BreadsGrains" value="4"<cfif #theAssessment.BreadsGrains# is 4> checked</cfif>>4. Eat primarily whole grain products <br />
			<input type="radio" name="BreadsGrains" value="5"<cfif #theAssessment.BreadsGrains# is 5> checked</cfif>>5. Eat only whole grain products <br />
			<input type="radio" name="BreadsGrains" value="5"<cfif #theAssessment.BreadsGrains# is 5> checked</cfif>>6. I have gluten intolerance or allergies to certain grains.<br /></strong>	</p>
			 
			<p><strong>Fruits and vegetables</strong> – How many servings of fruits and vegetables do you eat daily? (A serving is: 1 cup fresh, ½ cup cooked, 1 medium size fruit, or ¾ cup juice)<br />
			<strong>
			<input type="radio" name="FruitsAndVeggies" value="1"<cfif #theAssessment.FruitsAndVeggies# is 1> checked</cfif>>1. one or less<br />
			<input type="radio" name="FruitsAndVeggies" value="2"<cfif #theAssessment.FruitsAndVeggies# is 2> checked</cfif>>2. two daily <br />
			<input type="radio" name="FruitsAndVeggies" value="3"<cfif #theAssessment.FruitsAndVeggies# is 3> checked</cfif>>3. three daily <br />
			<input type="radio" name="FruitsAndVeggies" value="4"<cfif #theAssessment.FruitsAndVeggies# is 4> checked</cfif>>4. four daily<br />
			<input type="radio" name="FruitsAndVeggies" value="5"<cfif #theAssessment.FruitsAndVeggies# is 5> checked</cfif>>5. five or more<br /></strong>	</p>
			 
			<p><strong>Water intake</strong> – How many eight ounce glasses of water do you drink on average per day?<br />
			<strong>
			<input type="radio" name="Water" value="1"<cfif #theAssessment.Water# is 1> checked</cfif>>1. 0-1 glasses <br />
			<input type="radio" name="Water" value="2"<cfif #theAssessment.Water# is 2> checked</cfif>>2. 2-3 glasses <br />
			<input type="radio" name="Water" value="3"<cfif #theAssessment.Water# is 3> checked</cfif>>3. 4-5 glasses<br />
			<input type="radio" name="Water" value="4"<cfif #theAssessment.Water# is 4> checked</cfif>>4. 6-7 glasses<br />
			<input type="radio" name="Water" value="5"<cfif #theAssessment.Water# is 5> checked</cfif>>5. 8 or more <br /></strong>	</p>
			 
			<p><strong>Soft drink intake</strong> – How many eight ounce glasses of non-diet or other sugary soft drinks do you drink on average per day?<br />
			<strong>
			<input type="radio" name="SoftDrinks" value="1"<cfif #theAssessment.SoftDrinks# is 1> checked</cfif>>1. 5-6 glasses<br />
			<input type="radio" name="SoftDrinks" value="2"<cfif #theAssessment.SoftDrinks# is 2> checked</cfif>>2. 3-4 glasses <br />
			<input type="radio" name="SoftDrinks" value="3"<cfif #theAssessment.SoftDrinks# is 3> checked</cfif>>3. 1-2 glasses <br />
			<input type="radio" name="SoftDrinks" value="4"<cfif #theAssessment.SoftDrinks# is 4> checked</cfif>>4. 1 glass or rarely<br />
			<input type="radio" name="SoftDrinks" value="5"<cfif #theAssessment.SoftDrinks# is 5> checked</cfif>>5. None<br /></strong>	</p>
		
			<p><strong>Number of drinks</strong> – How many alcoholic drinks do you usually have per weekday (one ounce liquor, 12 ounces beer, or 4 ounces of wine)?<br />
			<strong>
			<input type="radio" name="WeekDayAlcohol" value="1"<cfif #theAssessment.WeekDayAlcohol# is 1> checked</cfif>>1. 5 or more <br />
			<input type="radio" name="WeekDayAlcohol" value="2"<cfif #theAssessment.WeekDayAlcohol# is 2> checked</cfif>>2. 3-4 <br />
			<input type="radio" name="WeekDayAlcohol" value="3"<cfif #theAssessment.WeekDayAlcohol# is 3> checked</cfif>>3. 1-2 <br />
			<input type="radio" name="WeekDayAlcohol" value="4"<cfif #theAssessment.WeekDayAlcohol# is 4> checked</cfif>>4. Seldom or never<br /></strong>	</p>
			 
			<p><strong>Number of drinks</strong> – How many alcoholic drinks do you usually have per weekend day (one ounce liquor, 12 ounces beer, or 4 ounces of wine)?<br />
			<strong>
			<input type="radio" name="WeekEndAlcohol" value="1"<cfif #theAssessment.WeekEndAlcohol# is 1> checked</cfif>>1. 5 or more<br />
			<input type="radio" name="WeekEndAlcohol" value="2"<cfif #theAssessment.WeekEndAlcohol# is 2> checked</cfif>>2. 3-4 <br />
			<input type="radio" name="WeekEndAlcohol" value="3"<cfif #theAssessment.WeekEndAlcohol# is 3> checked</cfif>>3. 1-2<br />
			<input type="radio" name="WeekEndAlcohol" value="4"<cfif #theAssessment.WeekEndAlcohol# is 4> checked</cfif>>4. Seldom or never<br /></strong>	</p>
			
			<p><b><font color="##993300">My Importance</font></b> - Rate the importance to me of consuming healthy food and drinks most of the time:</p>
		<cfif #listlen(theassessment.importance)# gt 0>
				<cfset importance = #theassessment.importance#>
			<cfelse>
				<cfset importance="0,0,0,0,0,0,0">
			</cfif>
			<p><input type="radio" name="lifeI" value="0"<cfif #listgetat(importance,5)# is 0> checked</cfif> />1 Not important at all<br />
			<input type="radio" name="lifeI" value="1"<cfif #listgetat(importance,5)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeI" value="2"<cfif #listgetat(importance,5)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeI" value="3"<cfif #listgetat(importance,5)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeI" value="4"<cfif #listgetat(importance,5)# is 4> checked</cfif> />5 About as important as most of the other things I would like to achieve now<br />
			<input type="radio" name="lifeI" value="5"<cfif #listgetat(importance,5)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeI" value="6"<cfif #listgetat(importance,5)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeI" value="7"<cfif #listgetat(importance,5)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeI" value="8"<cfif #listgetat(importance,5)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeI" value="9"<cfif #listgetat(importance,5)# is 9> checked</cfif> />10 Most important thing in my life now<br /></p>
			
			<cfif #listlen(theassessment.confidence)# gt 0>
				<cfset confidence = #theassessment.confidence#>
			<cfelse>
				<cfset confidence="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Confidence</font></b> - My confidence level in my ability to consume healthy food and drinks most of the time:</p>
			
			<p><input type="radio" name="lifeC" value="0"<cfif #listgetat(confidence,5)# is 0> checked</cfif> />1 <br />
			<input type="radio" name="lifeC" value="1"<cfif #listgetat(confidence,5)# is 1> checked</cfif> />2<br />
			<input type="radio" name="lifeC" value="2"<cfif #listgetat(confidence,5)# is 2> checked</cfif> />3<br />
			<input type="radio" name="lifeC" value="3"<cfif #listgetat(confidence,5)# is 3> checked</cfif> />4<br />
			<input type="radio" name="lifeC" value="4"<cfif #listgetat(confidence,5)# is 4> checked</cfif> />5 <br />
			<input type="radio" name="lifeC" value="5"<cfif #listgetat(confidence,5)# is 5> checked</cfif> />6<br />
			<input type="radio" name="lifeC" value="6"<cfif #listgetat(confidence,5)# is 6> checked</cfif> />7<br />
			<input type="radio" name="lifeC" value="7"<cfif #listgetat(confidence,5)# is 7> checked</cfif> />8<br />
			<input type="radio" name="lifeC" value="8"<cfif #listgetat(confidence,5)# is 8> checked</cfif> />9<br />
			<input type="radio" name="lifeC" value="9"<cfif #listgetat(confidence,5)# is 9> checked</cfif> />10 Highest Confidence<br /></p>
			
			<cfif #listlen(theassessment.readiness)# gt 0>
				<cfset readiness = #theassessment.readiness#>
			<cfelse>
				<cfset readiness="0,0,0,0,0,0,0">
			</cfif>
			<p><b><font color="##993300">My Readiness to Change</font></b> - My readiness to make changes or improvements to consume healthy food and drinks:</p>
			
			<p><input type="radio" name="lifeR" value="0"<cfif #listgetat(readiness,5)# is 0> checked</cfif> />A.	No present interest in making a change<br />
			<input type="radio" name="lifeR" value="1"<cfif #listgetat(readiness,5)# is 1> checked</cfif> />B.	Plan a change in the next 6 months<br />
			<input type="radio" name="lifeR" value="2"<cfif #listgetat(readiness,5)# is 2> checked</cfif> />C.	Plan to change this month<br />
			<input type="radio" name="lifeR" value="3"<cfif #listgetat(readiness,5)# is 3> checked</cfif> />D.	Recently started working on this<br />
			<input type="radio" name="lifeR" value="4"<cfif #listgetat(readiness,5)# is 4> checked</cfif> />E.	Already doing this consistently (6 mos. +)</p>
			</cfoutput>
		
			<br />
			<br />
			<input type="submit" name="nutritionssubmit" value="Save Changes">
		</form></cfoutput>
		</td></tr></table>
		</cfif>
	</cffunction>
	
	<cffunction name="eatinglogs" access="remote" output="true">
		<cfparam name="clientid" default=0>
		<cfset session.clientid=#clientid#>

		<cfset Typeid=44>
		<cfparam name="Today" default="#dateformat(now())#">
		<cfparam name="ThisToday" default="#dateformat(now())#">
		<cfset LastWeek=dateformat(dateadd("d",-7,#Today#))>
		<cfset NextWeek=dateformat(dateadd("d",7,#Today#))>
		
		<cfoutput>
		<script>
		function printit(){  
		if (window.print) {
			window.print() ;  
		} else {
			var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
			WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
		}
		}
		function printthreemonth(theURL,winName,features) {
		
			window.open(theURL,winName,features);
		}
		</script>

		</cfoutput>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY LOGS</td></tr>
		<tr><td colspan=2 class="centerTitle">EATING LOGS</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		
		<cfif #today# is dateformat(Now())>
			<cfset ThisWeek=Week(Today)>
		<cfelse>
			<cfif year(today) is year(now())>
				<cfset ThisWEek=week(today)>
			<cfelse>
				<cfset 	ThisWeek=Week(Today) + 1>
			</cfif>
		</cfif>
		<cfif #thisToday# is dateformat(Now())>
			<cfset xthisWeek=Week(thisToday)>
		<cfelse>
			<cfif year(thisToday) is year(now())>
				<cfset ThisWEek=week(thisToday)>
			<cfelse>
				<cfset 	xthisWeek=Week(thisToday) + 1>
			</cfif>
		</cfif>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(thisToday)#
			TheWeek=#xthisWeek#>
		<cfset xWeekStart=#theWeekStart#>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(Today)#
			TheWeek=#ThisWeek#>
		<cfset WeekStartDate=#TheWeekStart#>
		<cfset ThisDay=#WeekStartDate#>
		<cfset WeekEndDate=#TheWeekEnd#>
		<cfset SundayDate=#dateformat(WeekStartDate,'mm/dd/yyyy')#>
		<cfset MondayDate=#dateformat(dateadd('d',1,WeekStartDate),'mm/dd/yyyy')#>
		<cfset TuesdayDate=#dateformat(dateadd('d',2,WeekStartDate),'mm/dd/yyyy')#>
		<cfset WednesdayDate=#dateformat(dateadd('d',3,WeekStartDate),'mm/dd/yyyy')#>
		<cfset ThursdayDate=#dateformat(dateadd('d',4,WeekStartDate),'mm/dd/yyyy')#>
		<cfset FridayDate=#dateformat(dateadd('d',5,WeekStartDate),'mm/dd/yyyy')#>
		<cfset SaturdayDate=#dateformat(dateadd('d',6,WeekStartDate),'mm/dd/yyyy')#>
		
		<cfoutput><cfquery name="GetWeight" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#" maxrows=1>
		select dateentered, description 
		from clientlogs
		where typeid =#TypeID#
		and memberid=#clientID#
		and goallevel=17
		order by dateentered desc
		</cfquery>
		<cfif #GetWeight.RecordCount# gt 0>
			<cfset Weight=#getWeight.description#>
			<cfset WeightDate=#GetWeight.Dateentered#>
		<cfelse>
			<cfset Weight="None">
			<cfset WeightDate=#today#>
		</cfif></cfoutput>
	  <TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100% style="padding-left: 25px;">
	  <tr><td colspan=3><p class="bold"><strong>Instructions:</strong></p>
		<p><ol><li>Enter description and comments for each meal. Note the foods and amounts consumed.</li> 
		
		<li>Enter your exercise for the day </li>
		
		<li>If you weigh yourself, do it early in the morning (before eating), and enter the ## pounds. </li>
		
		<li>Enter the ## of calories consumed at each meal or snack. When you click Save, the total calories for the day will show.</li>
		
		<li>Give your day a rating from 1 to 10. 10 means you stuck to your plan beautifully, 1 means you totally blew it. </li>
		
		<li>Click " Save " to save this week's log. </li></ol>
		
		<p class=qanswer>If you have a bad day, don't throw the chart away - just start fresh the next meal or the next day. Several studies show that people who log their food eat less and make better choices than people who don't, so stick with it! </p></td></tr>
	  <cfoutput><tr><td style="height: 50px">Week Starting:<br>#dateformat(WeekStartDate,"dddd, mmmm d, yyyy")#</td>
	  <td style="height: 50px; padding-left: 15px"><form action="index.cfm?coachaction=#coachaction#&clientid=#clientid#&viewaction=vieweatinglogs&TypeID=#TypeID#&menusection=logs" method="post">
		<select name="Today">
			<option value="#dateformat(xWeekStart,'mm/dd/yyyy')#">#dateformat(xWeekStart,'mm/dd/yyyy')#</option>
			<cfloop index=i from="1" to="20">
				<cfset Yesterday=dateformat(dateAdd("ww",-#i#,#xWeekStart#),"mm/dd/yyyy")>
				<option value="#yesterday#"<cfif #yesterday# is #today#> selected</cfif>>#yesterday#</option>
			</cfloop>
		</select><input type="submit" name="nextSubmit" value="GO">
		</form>
	  </td>
	  <td style="height: 50px; padding-left: 15px">Date:<br>#dateformat(now(),"dddd, mmmm d, yyyy")#</td>
	  </tr></cfoutput>
		<TR> 
		  <td colspan=3>
		 <cfoutput> <script type="text/javascript">
AC_FL_RunContent( 'codebase','https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0','width','775','height','775','id','EatingLog','align',' ','src','#application.flashpath#/EatingLog?clientID=#clientID#&sunday=#sundayDate#&monday=#mondayDate#&tuesday=#tuesdayDate#&wednesday=#wednesdayDate#&thursday=#thursdayDate#&friday=#fridayDate#&saturday=#saturdayDate#&CoachAction=coach','quality','high','bgcolor','##E8EFF6','name','EatingLog','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','#application.flashpath#/EatingLog?clientID=#clientID#&sunday=#sundayDate#&monday=#mondayDate#&tuesday=#tuesdayDate#&wednesday=#wednesdayDate#&thursday=#thursdayDate#&friday=#fridayDate#&saturday=#saturdayDate#&CoachAction=coach' ); //end AC code
</script><noscript><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		 codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
		 WIDTH="775" HEIGHT="775" id="EatingLog" ALIGN=" ">
		 <PARAM NAME=movie VALUE="#application.flashpath#/EatingLog.swf?clientID=#clientID#&sunday=#sundayDate#&monday=#mondayDate#&tuesday=#tuesdayDate#&wednesday=#wednesdayDate#&thursday=#thursdayDate#&friday=#fridayDate#&saturday=#saturdayDate#&CoachAction=coach"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##E8EFF6> <EMBED src="#application.flashpath#/EatingLog.swf?clientID=#clientID#&sunday=#sundayDate#&monday=#mondayDate#&tuesday=#tuesdayDate#&wednesday=#wednesdayDate#&thursday=#thursdayDate#&friday=#fridayDate#&saturday=#saturdayDate#&CoachAction=coach" quality="high" bgcolor="##E8EFF6"  WIDTH="775" HEIGHT="775" NAME="EatingLog" ALIGN=""
		 TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
		</OBJECT></noscript></cfoutput>
				  
		
		</td>
		</tr>
		<tr><td><cfoutput>	<p>&nbsp;</p>
		<p  align=center class="bottombuttons">
		<cfif #today# is dateformat(Now())>
		<a href= "#application.securepath#/coachingscipts/printeating.cfm?ClientID=#ClientID#&CoachID=#session.coachid#&Today=#Today#" target="_blank" class="bottombuttons">PRINT</a>&nbsp;&nbsp;&nbsp;
			<a href= "index.cfm?coachaction=#coachaction#&clientid=#clientid#&viewaction=eatinglogs&Today=#LastWeek#&TypeID=#TypeID#&menusection=logs" class="bottombuttons">LAST</a>&nbsp;&nbsp;&nbsp;
		
		<cfelse>
		<a href= "#application.securepath#/coachingscipts/printeating.cfm?ClientID=#ClientID#&CoachID=#session.coachid#&Today=#Today#" target="_blank" class="bottombuttons">PRINT</a>&nbsp;&nbsp;&nbsp;
			<a href= "index.cfm?coachaction=#coachaction#&clientid=#clientid#&viewaction=eatinglogs&Today=#LastWeek#&TypeID=#TypeID#&menusection=logs" class="bottombuttons">LAST</a>&nbsp;&nbsp;&nbsp;
			<a href= "index.cfm?coachaction=#coachaction#&clientid=#clientid#&viewaction=eatinglogs&Today=#NextWeek#&TypeID=#TypeID#&menusection=logs" class="bottombuttons">NEXT</a>
		</cfif>
		</p>
		</cfoutput></td></tr>
		</table>
		
	</cffunction>
	
	<cffunction name="workoutlogs" access="remote" output="true">
		<Cfset ClientID=#URL.ClientID#>

		
		<cfparam name="Today" default="#dateformat(now())#">
		<cfparam name="thisToday" default="#dateformat(now())#">
		<cfset ThisWeek=Week(Today)>
		<cfset xThisWeek=Week(thisToday)>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(thisToday)#
			TheWeek=#xThisWeek#>
		<cfset xWeekStart=#TheWeekStart#>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(Today)#
			TheWeek=#ThisWeek#>
		<cfset WeekStartDate=#TheWeekStart#>
		<cfset ThisDay=#WeekStartDate#>
		<cfset WeekEndDate=#TheWeekEnd#>
		<cfset LastWeek=dateformat(dateadd("d",-7,#TheWeekStart#))>
		
		<cfset NextWeek=dateformat(dateadd("d",7,#TheWeekEnd#))>
		<script>
		function printit(){  
		if (window.print) {
			window.print() ;  
		} else {
			var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
			WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
		}
		}
		</script>

		
		<cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY LOGS</td></tr>
		<tr><td colspan=2 class="centerTitle">My Workout Logs</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		  <p CLASS="bold"><strong>Instructions</strong>
		<ol>
		<li>	Select the workout Activity that you would like to create a log for in Add New Log.</li>
		<li>	To create a new activity, click on Add New Activity and enter the name of the activity and the activity type (Strength, Stretch, or Aerobics).
		<li>	Enter each day's workout for each activity. Fill in Reps, Sets, and Lbs for Strength activities; and Minutes for Stretch and Aerobic activities. 
		<li>	Enter your Rate of Perceived Exertion <a href="https://www.wellcoaches.com/conman/images/Rate_of_Perceived_Exertion.pdf" target="MSM">(RPE)</a>
		<li>	Click "Save" to save this week's log.
		<li>	If you need to edit an entry - make your change and click on "Save".</ol></p>

		
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=95% class=scheduledata>
		 <tr><td style="height; 40px;">Week Starting:<br>#dateformat(WeekStartDate,"mmmm d, yyyy")#</td>
		 <td style="height: 50px"><form action="index.cfm?coachaction=#coachaction#&clientid=#clientid#&viewaction=viewworkoutlogs&menusection=logs" method="post">
			  	<select name="Today">
					<option value="#dateformat(xWeekStart,'mm/dd/yyyy')#">#dateformat(xWeekStart,'mm/dd/yyyy')#</option>
					<cfloop index=i from="1" to="20">
						<cfset Yesterday=dateformat(dateAdd("ww",-#i#,#xWeekStart#),"mm/dd/yyyy")>
						<option value="#yesterday#"<cfif #yesterday# is #today#> selected</cfif>>#yesterday#</option>
					</cfloop>
				</select><input type="submit" name="nextSubmit" value="GO">
				</form></td>
		  <td style="height; 40px;">Week Ending:<br>#dateformat(WeekendDate,"mmmm d, yyyy")#</td>
		  </tr>
		</table></cfoutput>
		<cfinvoke component="#application.websitepath#.utilities.clientlogs" 
			method="GetActivities" returnvariable="Activities">
			<cfinvokeargument name="ClientID" value="#ClientID#">
		</cfinvoke>
		
		<cfoutput><TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%></cfoutput>
			<tr><Td><table BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=780>
			</table></Td></tr>
		
			<cfinvoke component="#application.websitepath#.utilities.clientlogs" 
				method="GetWorkOutLog" returnvariable="WorkOutLog">
				<cfinvokeargument name="ClientID" value="#ClientID#">
				<cfinvokeargument name="Sunday" value="#dateformat(WeekStartDate,'yyyy/mm/dd')#">
			</cfinvoke>
			<cfoutput>
				<TR> 
				<td>
				<script type="text/javascript">
AC_FL_RunContent( 'codebase','https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0','width','780','height','650','id','WorkoutLog','align','','src','#application.flashpath#/WorkoutLog?clientID=#ClientID#&sunday=#dateformat(WeekStartDate,'mm/dd/yyyy')#&CoachAction=coach','quality','high','bgcolor','##E8EFF6','name','WorkoutLog','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','#application.flashpath#/WorkoutLog?clientID=#ClientID#&sunday=#dateformat(WeekStartDate,'mm/dd/yyyy')#&CoachAction=coach' ); //end AC code
</script><noscript><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
				WIDTH="780" HEIGHT="650" id="WorkoutLog" ALIGN="">
				<PARAM NAME=movie VALUE="#application.flashpath#/WorkoutLog.swf?clientID=#ClientID#&sunday=#dateformat(WeekStartDate,'mm/dd/yyyy')#&CoachAction=coach"> 
				<PARAM NAME=quality VALUE=high> 
				<PARAM NAME=bgcolor VALUE=##E8EFF6> 
				<EMBED src="#application.flashpath#/WorkoutLog.swf?clientID=#ClientID#&sunday=#dateformat(WeekStartDate,'mm/dd/yyyy')#&CoachAction=coach" 
				quality=high bgcolor=##E8EFF6  WIDTH="780" HEIGHT="650" 
				NAME="WorkoutLog" ALIGN=""
				TYPE="application/x-shockwave-flash" 
				PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
				</OBJECT></noscript>	
				</TD>
				</TR>
			</cfoutput>
		</TABLE>
		<cfoutput>
		<p>&nbsp;</p>
		<p align=center>
		<cfif #today# is dateformat(Now())>
			<a href= "#application.securepath#/coaching/printwologs.cfm?clientid=#clientID#&ThisWeek=#thisWEek#" target="_blank">PRINT</a>&nbsp;&nbsp;&nbsp;
			<a href= "index.cfm?coachaction=viewclient&viewaction=viewworkoutlogs&ClientID=#clientID#&Today=#LastWeek#&menusection=logs">LAST</a>
		<cfelse>
			<a href= "#application.securepath#/coaching/printwologs.cfm?clientid=#clientID#&ThisWeek=#thisWEek#" target="_blank">PRINT</a>&nbsp;&nbsp;
			<a href="index.cfm?coachaction=viewclient&viewaction=viewworkoutlogs&ClientID=#clientID#&Today=#LastWeek#&menusection=logs">LAST</a>&nbsp;&nbsp;&nbsp;
			<a href="index.cfm?coachaction=viewclient&viewaction=viewworkoutlogs&ClientID=#clientID#&Today=#NextWeek#&menusection=logs">NEXT</a>
		</cfif>
		</p>
		</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="fitnesslogs" access="remote" output="true">		
		<cfargument name="clientID" type="string" required="yes">
		<cfargument name="TypeID" type="string" default=0>
		<cfargument name="LogTypeID" type="string" default="Stress Rating">
		<cfparam name="ClientID" default=0>

		
		<cfparam name="Today" default="#dateformat(now())#">
		<cfif isDefined('Url.Today')>
			<cfset Today=#url.today#>
		</cfif>
		<cfset LastWeek=dateformat(dateadd("d",-7,#Today#))>
		<cfset NextWeek=dateformat(dateadd("d",7,#Today#))>
		
		<cfset ThisDay=dayofweek(#today#)>
		<cfset FirstDayDiff= (7 - #ThisDay#)>
		<cfset FirstDay=dateadd("d",-#firstDayDiff#,now())>
		<cfset LastDayDiff= abs(#ThisDay# - 7)>
		<cfset LastDay=dateadd("d",#LastDayDiff#,now())>
		<cfquery name="GetClients" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			SELECT Members.firstName, 
				Members.lastname,
				Addresses.Address1, 
				Addresses.Address2, 
				Addresses.City, 
				Addresses.State, 
				Addresses.PostalCode, 
				Email.EMailAddress,
				PhoneNumbers.PhoneNumber,
				Members.StartDate, 
				Members.EndDate, 
				Members.WebSiteID, 
				Addresses.Country, 
				Members.MemberID,
				Members.Sex,
				Members.RelationshipStatus,
				Members.Occupation,
				Members.BirthDate,
				Members.Age,
				Members.height,
				Members.Active
				FROM Members, Email, Addresses, PhoneNumbers
				WHERE email.tableid=15
				and email.connectid = members.memberid
				and PhoneNumbers.TableID=15
				and PhoneNumbers.ConnectID = Members.MemberID
				and Addresses.tableid=15
				and Addresses.connectid = members.memberid
				and Members.memberid=#ClientID#
		</cfquery>
		<cfquery name="GetLogTypes" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			Select notetypes.*, notecategories.description from notetypes,notecategories 
			where notecategories.categoryid=notetypes.notecategoryid
			and notetypes.typeid > 999
			and notetypes.typeid < 2000
			and notecategories.categoryid=5
			order by notetypes.typeid
		</cfquery>
		<cfparam name="TypeID" default=0>
		<cfif #TypeID# is 0>
			<cfset TypeID=19>
		</cfif>
		<cfset LogTypeID=#TypeID#>
		
		<script>
		function getexplanation(tURL) {
		window.open(tURL,'explanation','resizable=yes,width=300,height=400,scrollbars=yes');
		}
		</script>
		<script>
		function printit(){  
		if (window.print) {
			window.print() ;  
		} else {
			var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
			WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
		}
		}
		</script>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY LOGS</td></tr>
		<tr><td colspan=2 class="centerTitle">My Fitness Levels</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
			<p class=bold><strong>Instructions</strong>
		<ol>
		<li>	Click on the title of the log you would like to create or view.</li>
		<li>	For guidelines and more information about each of the logs click the information button beside the log. 
		<li>	Enter the Date of the log entry, the Current measurement, and your Goal; and add any comments. 
		<li>	Click "Save Changes" to save that day's log.
		<li>	If you need to edit an entry - make your change and click on "Save Changes".</ol></p>
		<table width="100%">
		  <tr>
			<TD>&nbsp;</TD>
			<TD CLASS="captionsc" colspan=>
				  
				  <cfif TypeID is 44 or TypeID is 43>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<cfoutput>
						<a href="index.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&Today=#LastWeek#&TypeID=#TypeID#">Last Week's Log</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
					<cfif #today# is dateformat(Now())>
					<cfelse>
						<a href="index.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&Today=#NextWeek#&TypeID=#TypeID#">Next Week's Log</a>
					</cfif>
					</cfoutput>
				</cfif>
			</td>
			<td>&nbsp;</td>
		  </tr>
		</table>
		
		
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
			
		  <TR>
			<td><Cfif #TypeID# neq 43 and #TypeID# neq 44>
			<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=146>
				
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="24"></TD>
				</TR>
				
				<cfoutput query="GetLogTypes">
				<TR> 
				  <TD CLASS="caption">
				  <cfif #ID# neq 43 and #ID# neq 44>
				  <a href="index.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&TypeID=#ID#">  #TYPEDESCRIPTION#</a> <a href="##" onclick=getexplanation('../coachingscripts/getexplanation.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&ID=#ID#')><img src="../images/infoicon.gif" border=0></a><br><img src="../images/b.gif" height=1 width=5>#typecomments#
					
				  </cfif>
		</TD>
				</TR>
			
				</cfoutput>
		
			  </TABLE>
			  </cfif>
			  
		</td>
		
		<td valign=top>
		
		<cfinvoke component="#application.websitepath#.utilities.clientlogs" method="GetOtherLog" returnvariable="GetLogs">
			<cfinvokeargument name="ClientID" value="#ClientID#">
			<cfinvokeargument name="tLogType" value="#typeid#">
		</cfinvoke>
		<cfset tCount=1>
		<cfset tMeasureTitle=''>
		<cfset tDescTitle=''>
		<cfquery name="getDescrip" dbtype="query">
			Select TYPECOMMENTS, typedescription from GetLogTypes
			where ID=#TypeID#
		</cfquery>
		<cfset xMeasureTitle=#getDescrip.typedescription#>
		<cfset tSubDesc=#getDescrip.TypeComments#>
		
		<cfif #trim(xmeasuretitle)# is "Body Fat %">
			<cfset xmeasuretitle="Body Fat Percent">
		</cfif>
		
		<IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="5"><br>
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
			<cfoutput>
				<TR> 
					<TD><IMG SRC="../images/b.gif" WIDTH="600" HEIGHT="2"></TD>
				</TR>
				<TR> 
					<TD class=bold>#xmeasuretitle#</TD>
				</TR>
				<TR> 
					<TD class=qanswer>Target Range: #tsubdesc#</TD>
				</TR>
				<TR> 
					<TD><IMG SRC="../images/b.gif" WIDTH="600" HEIGHT="10"></TD>
				</TR></cfoutput>
		<cfoutput>
			<tr><td class=caption>
			  <cfform action="index.cfm?coachaction=#coachaction#&viewaction=saveFitnessLog&clientID=#clientID#" target="_self" method="post" name="fitnesslevelsform" preservedata="true" preloader="no" format="flash" height="450" width="550" skin="halosilver">
				<cfformgroup  type="horizontal">
					<cfgrid name="DetailGrid" height="350" width="500" 
						align="top" query="getLogs"  
						font="Arial" 
						fontsize="10" 
						appendkey="yes" 
						griddataalign="center" 
						gridlines="yes" 
						rowheaderalign="left" 
						colheaderalign="left" 
						colheaderfont="Arial" 
						colheaderfontsize="12" 
						colheaderbold="yes" 
						colHeaderTextColor="##1c5da1" 
						bgcolor="##FFFFFF" 
						selectmode="edit" 
						maxrows="10" 
						picturebar="yes"
						enabled="yes" 
						visible="yes" 
						format="flash" 
						textcolor="##000000" 
						autowidth="true">
					<cfgridcolumn name="LogID" header="Log ID" width="1" type="string_noCase" display="no" select="no">
					<cfgridcolumn name="LogDate" header="Date" headeralign="left" dataAlign="left" numberformat="xx/xx/xxxx" width="15" display="yes" type="string_nocase" mask="xx/xx/xxxx">
					<cfgridcolumn name="Goal" header="Goal"	width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Measurement" header="Current" width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Comments" header="Comments"	width="50" type="string_noCase"	display="yes" select="yes" dataAlign="left">
					</cfgrid>
				</cfformgroup>
				<cfformgroup  type="horizontal">
					<cfinput type="button" name="ins" value="Insert a new note" width="125" onClick="GridData.insertRow(DetailGrid);" class="bottombuttons">
					<cfinput type="button" name="del" value="Delete Note" width="100" onClick="GridData.deleteRow(DetailGrid);" class="bottombuttons">
					<cfinput type = "submit" name="submit" width="100" value = "Save Changes" class="bottombuttons">
					<cfinput type = "reset" name="reset" width="100" value = "Reset Fields" class="bottombuttons">
				</cfformgroup>
				</cfform>
			</td></tr>
			</cfoutput>

		</TABLE>
		
		</td>
		</tr>
		</table>
		<p>&nbsp;</p>
		<p align=center>
		<a href="#application.securepath#/coaching/getcontent.cfm?clientid=#clientID#&TypeID=#TypeID#&LogTypeID=#LogTypeID#&coachaction=#coachaction#&viewaction=printlogs" target="_blank">PRINT</a></p>
		</td></tr></table>
	</cffunction>
	
	<cffunction access="remote" name="SaveFitnessLog" output="true" returntype="string">
		<cfargument name="ClientID" type="numeric" required="true" default="0">
		
		<cfparam name="LogID" type="string" default="0">
		<cfparam name="LogDate" type="string" default="">
		<cfparam name="TypeID" type="string" default="">
		<cfparam name="LogTypeID" type="string" default="">
		<cfparam name="Measurement" type="string" default="">
		<cfparam name="MeasureTitle" type="string" default=''>
		<cfparam name="Goal" type="string" default="">
		<cfparam name="Comments" type="string" default="">
		<cfparam name="descTitle" type="string" default=''>
		<cfparam name="coachaction" type="string" default='viewclient'>
		<cfparam name="viewaction" type="string" default='otherlogs'>
		
		<cfloop index="i" from="1" to="#arraylen(form.DetailGrid.LogID)#">
			<cfset LogDate=#form.DetailGrid.LogDate[i]#>
			<cfset LogID=#form.DetailGrid.LogID[i]#>
			<cfset Goal=#form.DetailGrid.Goal[i]#>
			<cfset Measurement=#form.DetailGrid.Measurement[i]#>
			<cfset Comments=#form.DetailGrid.Comments[i]#>
			<cfset gridAction=#form.DetailGrid.RowStatus.Action[i]#>
		
			<cfset Today=dateformat(#now()#,"yyyy/mm/dd")>
			<cfset NewLogID=#Logid#>
			<cfif left(LogDate,2) is "00"><cfset LogDate="01#right(LogDate,8)#"></cfif>
			<cfif left(LogDate,2) is "0/"><cfset LogDate="01#right(LogDate,7)#"></cfif>
			<cfset logdate=dateformat(logdate,"yyyy/mm/dd")>
			
			<cfset FieldList="ClientID, DateStarted, LogDate, LogType, Measurement, Goal, Comments, measureTitle,descTitle">
			<cfset FieldValues="#arguments.ClientID#,#Today# ,#dateformat(LogDate,'yyyy/mm/dd')# ,#LogTypeID# ,#Measurement# ,#replace(Goal,',','~','ALL')# ,#replace(Comments,',','~','ALL')# ,#replace(measureTitle,',','~','ALL')# ,#replace(descTitle,',','~','ALL')# ">
			
			<cfif ucase(gridAction) is "I">
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="InsertXMLRecord" returnvariable="NewLogID">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
					<cfinvokeargument name="XMLIDValue" value="#LogID#">
				</cfinvoke>
			</cfif>
		</cfloop>
		<cflocation url="index.cfm?coachaction=#coachaction#&viewaction=fitnesslogs&clientid=#clientid#&logtypeID=#logtypeID#&typeID=#typeID#">
	</cffunction>
	
	<cffunction name="medicallogs" access="remote" output="true">		
		<cfargument name="clientID" type="string" required="yes">
		<cfargument name="TypeID" type="string" default=0>
		<cfargument name="LogTypeID" type="string" default="Stress Rating">
		<cfquery name="GetLogTypes" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			Select notetypes.*, notecategories.description from notetypes,notecategories 
			where notecategories.categoryid=notetypes.notecategoryid
			and notetypes.typeid < 3000
			and notetypes.Typeid > 1999
			and notetypes.notecategoryid=6
			order by notetypes.typeid
		</cfquery>
		<cfparam name="TypeID" default=0>
		<cfif #TypeID# is 0>
			<cfset TypeID=#GetLogTypes.ID#>
		</cfif>
		<cfset LogTypeID=#TypeID#>

		<cfquery name="GetClientInfo" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from members
			where memberid=#clientID#
		</cfquery>
		
		<cfinvoke component="#application.websitepath#.utilities.clientlogs" method="GetOtherLog" returnvariable="GetLogs">
			<cfinvokeargument name="ClientID" value="#ClientID#">
			<cfinvokeargument name="tLogType" value="#typeid#">
		</cfinvoke>
		<script language="JavaScript">
		<!-- Begin
		
		if (window != top) top.location.href = location.href;
		
		function mod(div,base) {
		return Math.round(div - (Math.floor(div/base)*base));
		}
		function calcBmi() {
		
		var strCom
		var strURL
		var w = document.bmi.weight.value * 1;
		var HeightFeetInt = document.bmi.htf.value * 1;
		var HeightInchesInt = document.bmi.hti.value * 1;
		HeightFeetConvert = HeightFeetInt * 12;
		h = HeightFeetConvert + HeightInchesInt;
		displaybmi = (Math.round((w * 703) / (h * h)));
		var rvalue = true;
		if ( (w <= 35) || (w >= 500)  || (h <= 48) || (h >= 120) ) {
		alert ("Invalid data.  Please check and re-enter!");
		rvalue = false;
		}
		if (rvalue) {
		if (HeightInchesInt > 11) {
		reminderinches = mod(HeightInchesInt,12);
		document.bmi.hti.value = reminderinches;
		document.bmi.htf.value = HeightFeetInt + 
		((HeightInchesInt - reminderinches)/12);
		document.bmi.answer.value = displaybmi;
		}
		
		strCom = displaybmi
		
		return window.open( 'https://www.wellcoaches.com/BMICalculator/bmi.cfm?BMI=' + strCom, 'newwindow', 'width=600,height=480,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=0' ) ; 
		
		}
		}
		function getinfo(tPath) {
			window.open( tPath, 'information', 'width=400,height=200,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ) ; 
		}	
		function printit(){  
		if (window.print) {
			window.print() ;  
		} else {
			var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
			WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
		}
		}
		</script>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=3 class="centerHeader">MY LOGS</td></tr>
		<tr><td colspan=3 class="centerTitle">My Medical Information</td></tr>
		<tr><td colspan=3 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top colspan=2><p class=bold><strong>Instructions</strong>
		<ol>
		<li>	Click on the title of the log you would like to create or view.</li>
		<li>	For guidelines and more information about each of the logs click the information button beside the log. 
		<li>	Enter the Date of the log entry, the Current measurement, and your Goal; and add any comments. 
		<li>	Click "Save Changes" to save that day's log.
		<li>	If you need to edit an entry - make your change and click on "Save Changes".</ol></p>
		</td>
		  </tr>
		  <TR> <td></td>
			<TD VALIGN="TOP"> 
			  <TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
				<TR> 
				  <TD colspan=5 background="../images/b.gif"><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="15"></TD>
				</TR>
				<TR> 
				  <TD ALIGN="left" COLSPAN="5" CLASS="caption">&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10"><A HREF="https://www.wellcoaches.com/ConMan/physiciansrelease.pdf" target="MMM">Physician's Release Form</A> </TD>
				</TR>
				<TR> 
				  <TD colspan=5 background="../images/b.gif"><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="18"></TD>
				</TR>
		
				<TR> 
				  <TD ALIGN="left" COLSPAN="4" CLASS="caption">&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10">Age </TD><cfoutput><td class="qanswer">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#GetClientInfo.Age#</td></cfoutput>
				</TR>
				<TR> 
				  <TD ALIGN="left" COLSPAN="4" CLASS="caption">&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10">Gender </TD><cfoutput><td class="qanswer">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif #GetClientInfo.Sex# is 0>Male<cfelse>Female</cfif></td></cfoutput>
				</TR>
				<TR> 
				  <TD ALIGN="left" COLSPAN="4" CLASS="caption">&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10">Height </TD><cfoutput><td class="qanswer">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#GetClientInfo.Height#</td></cfoutput>
				</TR>
				<TR> 
				<cfinvoke component="#Application.websitepath#.utilities.XMLHandler" 
					method="GetXMLRecords" returnvariable="GetFrame">
					<cfinvokeargument name="ThisPath" value="files/clients/questionnaires">
					<cfinvokeargument name="ThisFileName" value="q#clientid#">
					<cfinvokeargument name="SelectStatement" value=" Where connectid='20'">
				</cfinvoke>
				<cfif #GetFrame.RecordCount# gt 0>
				<cfloop query="getFrame">
					<cfif #GetFrame.responsetext# is 12><cfset FrameSize="Small"><cfelseif #GetFrame.responsetext# is 13><cfset FrameSize="Medium"><cfelseif #GetFrame.responsetext# is 14><cfset FrameSize="Large"><cfelse><cfset FrameSize="Medium"></cfif></cfloop>
				<cfelse>
					<cfset FrameSize="Medium">
				</cfif>
				  <cfoutput><TD ALIGN="left" COLSPAN="4" CLASS="caption">&nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10">Frame </TD><td class="qanswer">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#FrameSize#</td></cfoutput>
				</TR>
				<tr><td colspan=5><img src=../images/b.gif height=15 width=15></td></tr>
				<tr><td colspan=5 class=qanswer>&nbsp;&nbsp;&nbsp;Categories of Information</td></tr>
				<tr><td colspan=5><img src=../images/b.gif height=15 width=15></td></tr>
				
				<cfoutput query="GetLogTypes">
				<TR> 
				  <TD CLASS="caption" colspan=5>
				  &nbsp;&nbsp;&nbsp;<IMG SRC="../images/i_next.gif" WIDTH="15" HEIGHT="10"><a href="index.cfm?CoachAction=#CoachAction#&ViewAction=viewmedical&ClientID=#ClientID#&TypeID=#ID#">  #TYPEDESCRIPTION#</a> <a href="##" onclick=getinfo('../coachingscripts/getexplanation.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&ID=#ID#')><img src="../images/infoicon.gif" border=0></a>
				  </TD>
				</TR>
			
				</cfoutput>
			  </TABLE>
			</TD>
			<td>
		
		<cfset TitleCount = #GetLogs.MeasureTitle#>
		<cfset tCount=1>
		<cfset tMeasureTitle=''>
		<cfset tDescTitle=''>
		<cfquery name="getDescrip" dbtype="query">
			Select TYPECOMMENTS, typedescription from GetLogTypes
			where ID=#TypeID#
		</cfquery>
		<cfset xMeasureTitle=#getDescrip.typedescription#>
		<cfset tSubDesc=#getDescrip.TypeComments#>
		<cfset tSubDesc=replacenocase(#tSubDesc#,"%","Percent","ALL")>
		<cfset xMeasureTitle=replacenocase(#xMeasureTitle#,"%","Percent","ALL")>
		
		<cfoutput><TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
		  <TR> 
			<TD>&nbsp;</TD>
			<TD><IMG SRC="../images/b.gif" WIDTH="375" HEIGHT="32"></TD>
			<TD>&nbsp;</TD>
		  </TR>
		  <TR> 
			<TD class=bold colspan=3>#xmeasureTitle#</TD>
		  </TR>
		  <TR> 
			<TD class=qanswer colspan=3>Target Range: #tSubDesc#</TD>
		  </TR></cfoutput>
		  <cfif #trim(xmeasureTitle)# is "BMI">
			<tr><td colspan=3>
				<form name="bmi" onsubmit="calcBmi(); return false;">
					<div align="center"><center><p class=caption>CALCULATE
					YOUR BODY MASS INDEX:<br>
					Weight: <input type="text" name="weight" size="3">lbs.&nbsp;&nbsp;
					Height:<input type="text" name="htf" size="2">ft. <input
					type="text" name="hti" size="2"> in<br>
					<small><input type="submit" value="Click Here" name="B1"></p>
					</center></div>
				</form>
			</td></tr>
			</cfif>
		
	
		  
		</table>
		
		<cfoutput> 
			  <TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
				<TR> 
				  <TD background="../images/b.gif" colspan=3><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="25"></TD>
				</TR>

			   
				<TR> 
				  <TD class="caption" VALIGN="TOP" nowrap colspan=3> 
				   <cfform action="index.cfm?coachaction=#coachaction#&viewaction=SaveMedicalLog&clientID=#clientID#&TypeID=#TypeID#" target="_self" method="post" name="medicallogsform" preloader="no" format="flash" height="450" width="550" skin="haloblue">
				<cfformgroup  type="horizontal">
					<cfgrid name="DetailGrid" height="350" width="500" 
						align="top" query="getLogs"  
						font="Arial" 
						fontsize="10" 
						appendkey="yes" 
						griddataalign="center" 
						gridlines="yes" 
						rowheaderalign="left" 
						colheaderalign="left" 
						colheaderfont="Arial" 
						colheaderfontsize="12" 
						colheaderbold="yes" 
						colHeaderTextColor="##1c5da1" 
						bgcolor="##FFFFFF" 
						selectmode="edit" 
						maxrows="10" 
						picturebar="yes"
						enabled="yes" 
						visible="yes" 
						format="flash" 
						textcolor="##000000" 
						autowidth="true">
					<cfgridcolumn name="LogID" header="Log ID" width="1" type="string_noCase" display="no" select="no">
					<cfgridcolumn name="LogDate" header="Date" headeralign="left" dataAlign="left" numberformat="xxxx/xx/xx" width="15" display="yes" type="string_nocase" mask="xxxx/xx/xx">
					<cfgridcolumn name="Goal" header="Goal"	width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Measurement" header="Current" width="15" type="numeric" display="yes" select="yes" dataAlign="right">
					<cfgridcolumn name="Comments" header="Comments"	width="50" type="string_noCase"	display="yes" select="yes" dataAlign="left">
					</cfgrid>
				</cfformgroup>
				<cfformgroup  type="horizontal">
					<cfinput type="button" name="ins" value="Insert a new note" width="125" onClick="GridData.insertRow(DetailGrid);" class="bottombuttons">
					<cfinput type="button" name="del" value="Delete Note" width="100" onClick="GridData.deleteRow(DetailGrid);" class="bottombuttons">
					<cfinput type = "submit" name="submit" width="100" value = "Save Changes" class="bottombuttons">
					<cfinput type = "reset" name="reset" width="100" value = "Reset Fields" class="bottombuttons">
				</cfformgroup>
				</cfform>
				</td>
				</TR>

		</cfoutput>
  
			</TABLE>
		
		<p>&nbsp;</p>
		<p align=center>
		<a href="#application.securepath#/coaching/getcontent.cfm?clientid=#clientID#&TypeID=#TypeID#&LogTypeID=#LogTypeID#&coachaction=#coachaction#&viewaction=printlogs" target="_blank">PRINT</a></p>
		</td></tr></table>
	</cffunction>
	
	<cffunction access="remote" name="SaveMedicalLog" output="true" returntype="string">
		<cfargument name="ClientID" type="numeric" required="true" default="0">
		
		<cfparam name="LogID" type="string" default="0">
		<cfparam name="LogDate" type="string" default="">
		<cfparam name="TypeID" type="string" default="">
		<cfparam name="LogTypeID" type="string" default="">
		<cfparam name="Measurement" type="string" default="">
		<cfparam name="MeasureTitle" type="string" default=''>
		<cfparam name="Goal" type="string" default="">
		<cfparam name="Comments" type="string" default="">
		<cfparam name="descTitle" type="string" default=''>
		<cfparam name="coachaction" type="string" default='viewclient'>
		<cfparam name="viewaction" type="string" default='otherlogs'>
		
		<cfloop index="i" from="1" to="#arraylen(form.DetailGrid.LogID)#">
			<cfset LogDate=#form.DetailGrid.LogDate[i]#>
			<cfset LogID=#form.DetailGrid.LogID[i]#>
			<cfset Goal=#form.DetailGrid.Goal[i]#>
			<cfset Measurement=#form.DetailGrid.Measurement[i]#>
			<cfset Comments=#form.DetailGrid.Comments[i]#>
			<cfset gridAction=#form.DetailGrid.RowStatus.Action[i]#>
		
			<cfset Today=dateformat(#now()#,"yyyy/mm/dd")>
			<cfset NewLogID=#Logid#>
			<cfif left(LogDate,2) is "00"><cfset LogDate="01#right(LogDate,8)#"></cfif>
			<cfif left(LogDate,2) is "0/"><cfset LogDate="01#right(LogDate,7)#"></cfif>
			<cfset logdate=dateformat(logdate,"yyyy/mm/dd")>
			
			<cfset FieldList="ClientID, DateStarted, LogDate, LogType, Measurement, Goal, Comments, measureTitle,descTitle">
			<cfset FieldValues="#arguments.ClientID#,#Today# ,#dateformat(LogDate,'yyyy/mm/dd')# ,#LogTypeID# ,#Measurement# ,#replace(Goal,',','~','ALL')# ,#replace(Comments,',','~','ALL')# ,#replace(measureTitle,',','~','ALL')# ,#replace(descTitle,',','~','ALL')# ">
			
			<cfif ucase(gridAction) is "I">
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="InsertXMLRecord" returnvariable="NewLogID">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#application.newWebSitePath#.Utilities.XMLHandler" 
					method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files/clients/logs">
					<cfinvokeargument name="ThisFileName" value="OL#arguments.clientid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="LogID">
					<cfinvokeargument name="XMLIDValue" value="#LogID#">
				</cfinvoke>
			</cfif>
		</cfloop>
		<cflocation url="index.cfm?coachaction=#coachaction#&viewaction=medicallogs&clientid=#clientid#&logtypeID=#logtypeID#&typeID=#typeID#">
	</cffunction>
	
	<cffunction name="mySchedule" access="remote" output="true">
		<cfargument name="clientID" type="string" required="yes">
		
		<cfset ClientID=#arguments.clientID#>
		<cfset page="homepage">
		<cfinvoke component="#Application.newWebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Utilities">
			<cfinvokeargument name="ThisPath" value="utilities">
			<cfinvokeargument name="ThisFileName" value="calendarconfig">
			<cfinvokeargument name="IDFieldName" value="calendarconfigID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfparam name="ClientID" default=0>
		<cfparam name="StartWith" default=1>
		<cfparam name="ShowSummary" default=1>
		<cfparam name="ShowIcons" default=1>
		<cfparam name="BackToCalGraphic" default='none'>
		<cfparam name="AllowAdditions" default=1>
		<cfoutput query="Utilities">
			<cfset StartWith=#StartWith#>
			<cfset ShowSummary=#ShowSummary#>
			<cfset ShowIcons=#ShowIcons#>
			<cfset BackToCalGraphic=#BackToCalGraphic#>
			<cfset AllowAdditions=#AllowAdditions#>
		</cfoutput>
		<cfparam name="CalAction" default="ViewMonth">

		<cfif CalAction is "ViewMonth">
			<cfswitch expression="#StartWith#">
				<cfcase value="1">
					<cfset CalAction="ViewDay">
				</cfcase>
				<cfcase value="2">
					<cfset CalAction="ViewMonth">
				</cfcase>
				<cfcase value="3">
					<cfset CalAction="ViewEvents">
				</cfcase>
				<cfcase value="4">
					<cfset CalAction="ViewWeek">
				</cfcase>
			</cfswitch>
		</cfif>
		<cfparam name="GoToYear" default="#year(Now())#">
		<cfparam name="GoToMonth" default="#month(now())#">
		
		<cfswitch expression="#CalAction#">
			<cfcase value="ViewMonth">
				
				<cfset OtherAction="&CoachAction=#coachAction#&ViewAction=myschedule">
				
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  method="DisplayMonth">
					<cfinvokeargument name="Page" value="#Page#">
					<cfinvokeargument name="GoToYear" value="#GoToYear#">
					<cfinvokeargument name="GoToMonth" value="#GoToMOnth#">
					<cfinvokeargument name="ShowSummary" value="#ShowSummary#">
					<cfinvokeargument name="ShowIcons" value="#ShowIcons#">
					<cfinvokeargument name="BackToCalGraphic" value="#BackToCalGraphic#">
					<cfinvokeargument name="AllowAdditions" value="#AllowAdditions#">
					<cfinvokeargument name="FilePath" value="files/coaching">
					<cfinvokeargument name="ThisFilename" value="schedule#session.coachid#">
					<cfinvokeargument name="OtherAction" value="#OtherAction#">
					<cfif #ClientID# gt 0><cfinvokeargument name="ClientID" value="#ClientID#"></cfif>
				</cfinvoke>
			</cfcase>
			
			<cfcase value="ViewEventDetails"><cfoutput>HERE</cfoutput>
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  
					method="DisplayEventDetail">
					<cfinvokeargument name="Page" value="home">
					<cfinvokeargument name="EventID" value="#URL.EventID#">
					<cfinvokeargument name="AllowAdditions" value="#AllowAdditions#">
					<cfinvokeargument name="FilePath" value="files/coaching">
					<cfinvokeargument name="ThisFilename" value="schedule#session.coachid#">
					<cfinvokeargument name="OtherAction" value="&CoachAction=#coachAction#&ViewAction=myschedule">
					<cfif #ClientID# gt 0><cfinvokeargument name="thisClient" value="#ClientID#"></cfif>
				</cfinvoke>
			</cfcase>
			
			<cfcase value="AddEvent">
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  method="AddEvent">
					<cfinvokeargument name="PageName" value="home">
					<cfinvokeargument name="OtherAction" value="&CoachAction=#coachAction#&ViewAction=myschedule">
					<cfif #ClientID# gt 0><cfinvokeargument name="ClientID" value="#ClientID#"></cfif>
				</cfinvoke>
			</cfcase>
			
			<cfcase value="ProcessAddEvent">
				<cfquery name="GetEmail" datasource="#application.wellcoachesDSN#" 
					username="#application.DSNuname#" password="#application.DSNpword#">
					select EmailAddress from email where connectid=#form.clientid#	and websiteid=1
				</cfquery>
				<cfset Form.EmailAddress=#GetEmail.EmailAddress#>
				<cfif #form.cboAM_PM# is "PM"><cfset form.cboHour=#form.cboHour# + 12></cfif>
				<cfif #form.cboHour# is "24"><cfset form.cboHour=12></cfif>
				<cfset form.TimeStarted="#form.cboHour#:#form.cboMinute#">
				<cfset datestarted = "#form.DateStarted# #form.TimeStarted#">
				<cfif not isdate(datestarted)>
					<cfoutput>The date you have entered is not in a valid format, please <a href="javascript: history.go(-1)">Click here</a> to fix. The format must be mm/dd/yyyy.</cfoutput><cfabort>
				</cfif>
				<cfset DateEnd = dateadd("n",#form.Duration#,#datestarted#)>
				<cfset Form.DateStarted="#dateformat(Datestarted,'yyyy-mm-dd')# #timeFormat(DateStarted,'HH:mm')#">
				<cfset Form.DateEnd="#dateformat(DateEnd,'yyyy-mm-dd')# #timeFormat(DateEnd,'HH:mm')#">
				<cfif isdefined('form.eventstatus')><cfelse><cfset form.eventstatus=0></cfif>
				<cfset form.eventDescription=#replace(form.EventDescription,",","~","ALL")#>
				<cfset form.eventDescription=#replace(form.EventDescription,'"','&quot;','ALL')#>
				<cfset form.eventtitle=#replace(form.EventTitle,",","~","ALL")#>
				<cfset form.eventtitle=#replace(form.EventTitle,'"','&quot;','ALL')#>
				
				<cfif not isdate(form.EmailAlertDate)>
					<cfoutput>The email alert date you have entered is not in a valid format, please <a href="javascript: history.go(-1)">Click here</a> to fix. The format must be mm/dd/yyyy.</cfoutput><cfabort>
				</cfif>
				
				<cfset Fields = "DateStarted,ClientID,EventDescription,DateEnd,EmailAddress,EventTitle,EventStatus,EmailAlertDate,ClientTimeZoneAdjustment,CoachID,Invoice,PaidDate">
				<cfset FieldData="#form.datestarted#,#form.ClientID#,#EventDescription# ,#form.dateEnd#,#form.EmailAddress# ,#form.EventTitle# ,#form.EventStatus# ,#form.EmailAlertDate# ,#form.ClientTimeZoneAdjustment#,#session.CoachID#,0, ">
				
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  method="UpdateEvent">
					<cfinvokeargument name="PageName" value="#Page#">
					<cfinvokeargument name="EventID" value="#form.eventid#">
					<cfinvokeargument name="XMLFields" value="#Fields#">
					<cfinvokeargument name="XMLFieldData" value="#FieldData#">
					<cfinvokeargument name="OtherAction" value="&CoachAction=#coachAction#&ViewAction=myschedule">
					<cfinvokeargument name="FilePath" value="files/coaching">
					<cfinvokeargument name="ThisFilename" value="schedule#session.coachid#">
				</cfinvoke>
				<cflocation url="index.cfm?CoachAction=viewclient&ViewAction=myschedule&ClientID=#Clientid#">
			</cfcase>
			
			<cfcase value="EditEvent">
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  method="EditEvent">
					<cfinvokeargument name="PageName" value="#Page#">
					<cfinvokeargument name="EventID" value="#url.eventid#">
					<cfinvokeargument name="OtherAction" value="&CoachAction=#coachAction#&ViewAction=myschedule">
					<cfinvokeargument name="FilePath" value="files/coaching">
					<cfinvokeargument name="ThisFilename" value="schedule#session.coachid#">
				</cfinvoke>
			</cfcase>
			
			<cfcase value="ConfirmDeleteEvent">
				<p align=center class=caption>Are you sure you want to delete this session?</p>
				<cfinvoke component="#Application.newWebSitePath#.utilities.schedule"  
					method="DisplayEventDetail">
					<cfinvokeargument name="Page" value="#Page#">
					<cfinvokeargument name="EventID" value="#URL.EventID#">
					<cfinvokeargument name="AllowAdditions" value="#AllowAdditions#">
					<cfinvokeargument name="FilePath" value="files/coaching">
					<cfinvokeargument name="ThisFilename" value="schedule#session.coachid#">
					<cfinvokeargument name="OtherAction" value="&CoachAction=viewclient&ViewAction=myschedule&ClientID=#clientID#">
				</cfinvoke>
		
			</cfcase>
			
			<cfcase value="DeleteEvent">
				<cfinvoke component="#Application.newWebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
					<cfinvokeargument name="ThisPath" value="files/coaching">
					<cfinvokeargument name="ThisFileName" value="schedule#session.coachid#">
					<cfinvokeargument name="XMLFields" value="EventID,DateStarted,ClientID,EventDescription,DateEnd,EmailAddress,EventTitle,EventStatus,EmailAlertDate,ClientTimeZoneAdjustment,CoachID,Invoice,PaidDate">
					<cfinvokeargument name="XMLIDField" value="EventID">
					<cfinvokeargument name="XMLIDValue" value="#url.EventID#">
				</cfinvoke>
				<cfif isdefined('url.clientid')>
				<cflocation url="index.cfm?CoachAction=viewclient&ClientID=#Clientid#">
				<cfelse>
				<cflocation url="index.cfm?CoachAction=manageschedule">
				</cfif>
			</cfcase>
		</cfswitch>
		
		<cfoutput>
		<p>&nbsp;</p>

		</cfoutput>
	</cffunction>
	
	<cffunction name="resources" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		
		<cfquery name="AllArticles" datasource="#application.wellcoachesDSN#" password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
			SELECT Articles.*, ArticleTypes.*
			FROM Articles, ArticleTypes
			Where Articles.ArticleTypeID = ArticleTypes.TypeID
			<!--- and TypeID=#url.resourceID# --->
			order by ArticleTypeID,ArticleID
		</cfquery>
		<cfquery name="getAccess" datasource="#application.dsn#" password="#application.dsnpword#" username="#application.dsnuname#">
			select * from LibraryAccess 
			where 	clientID=#arguments.clientID#
		</cfquery>
		<cfif #getAccess.recordcount# gt 0>
		<cfquery name="GetArticles" dbtype="query">
			select AllArticles.*, getAccess.AccessID 
			from allArticles, getAccess
			where AllArticles.ArticleID=getAccess.LibraryID
			order by ArticleTypeID,ArticleID
		</cfquery>
		<cfelse>
			<cfset GetArticles=QueryNew("empty")>
		</cfif>
		<cfoutput>
		
		<script>
		function openarticle(articleid) {
		
		winStr = 'scripts/ShowArticle.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&ClientID=#ClientID#&ArticleID='+articleid;
			win = window.open(winStr, 'articles' , 'width=600,height=430,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		</script>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY RESOURCES</td></tr>
		<cfset tArticleType=0>
		<cfloop query="GetArticles">
			<Cfif tArticleType neq #articleTypeID#>
				<cfif tArticleType neq 0>
					</table></td></tr><table style="padding-left: 30px; padding-right: 30px;">
				</cfif>
				<cfquery name="ArticleType" datasource="#application.wellcoachesDSN#" 
					password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
					SELECT ArticleTypes.*
					FROM ArticleTypes
					Where TypeID=#ArticleTypeID#
				</cfquery>
				<cfset tARticleType=#articleTypeid#>
				
				<tr><td colspan=2 class="centerTitle">#trim(ArticleType.description)#</td></tr>
				<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
				<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
				<table width=100%>
			</cfif>
			<tr>
			<td>
			<cfif #Author# neq ''>
				<cfset extension=ucase(right(#Trim(author)#,3))>
	
				<cfswitch expression="#Extension#">
					<cfcase value="DOC">
						<cfset Image="<img src='../Images/icoWord.gif' width='19' height='14' alt='' border='0'>">
					</cfcase>
					<cfcase value="PDF">
						<cfset Image="<img src='../Images/icoAcrobat.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="XLS">
						<cfset Image="<img src='../Images/icoXLS.gif' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="PPT">
						<cfset Image="<img src='../Images/icoPwerPoint.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="ZIP">
						<cfset Image="<img src='../Images/icoZIP.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="MDB">
						<cfset Image="<img src='../Images/icoAccess.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="TXT">
						<cfset Image="<img src='../Images/icoText.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfcase value="HTM,TML,CFM,ASP,PHP,JSP,HMS,HTML">
						<cfset Image="<img src='../Images/icoHTML.jpg' width='16' height='18' alt='' border='0'>">
					</cfcase>
					<cfdefaultcase>
						<cfset Image="<img src='../Images/icoUnknown.jpg' width='15' height='18' alt='' border='0'>">
					</cfdefaultcase>
				</cfswitch>
				<p><a href="javascript:confirmDelete('index.cfm?CoachAction=#CoachAction#&ViewAction=deleteClientAccess&ClientID=#ClientID#&Action=Delete&AccessID=#AccessID#')"><img src="../images/delete.gif" border=0></a>&nbsp;&nbsp;&nbsp;#image#<a href="#Trim(Author)#" target="MMM" class=captionsc>#Title#</a><br>
			<cfelse>
				<p><a href="index.cfm?CoachAction=#CoachAction#&ViewAction=deleteClientAccess&ClientID=#ClientID#&Action=Delete&AccessID=#AccessID#"><img src="../images/delete.gif" border=0></a>&nbsp;&nbsp;&nbsp;<img src="../images/icoHTML.jpg" width="16" height="18" alt="" border="0"><a href="index.cfm?CoachAction=viewclient&ViewAction=ShowArticle&ClientID=#ClientID#&articleid=#ArticleID#" class=captionsc>#Title#</a> <br>
			</cfif>
			</td>
			</tr>
		</cfloop>
		</table></td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="addresource" access="remote" output="true">
		<cfoutput><script>
		function openarticle(articleid) {
		
		winStr = 'scripts/ShowArticle.cfm?CoachAction=#CoachAction#&ViewAction=#ViewAction#&Clientid=#ClientID#&ArticleID='+articleid;
			win = window.open(winStr, 'articles' , 'width=600,height=430,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		</script></cfoutput>
		<cfparam name="PanelName" default="0">
		<cfparam name="ContentID" default="0">
		<cfoutput>
		<cfif #clientID# gt 0>
			<cfset OldViewACtion=#ViewACtion#>

		</cfif>
		</cfoutput>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY RESOURCES</td></tr>
		<tr><td colspan=2 class="centerTitle">Search the Wellcoaches Library</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>

		<cfquery name="GetPanels" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			select * from articletypes
			where typeid <> 11
			order by description
		</cfquery>
		
		<form method="post" action="index.cfm?<cfoutput>Coachaction=#coachAction#&ViewAction=addresource&Clientid=#ClientID#&menusection=library</cfoutput>">
		
		
		<p class=caption>Select a Category <select name="PanelName">
		<cfoutput query="GetPanels">
			
			<option value="#typeid#">#description#
			
		</cfoutput>
		</select>
		<input type="submit" name="submit" value="Select"></p>
		</form>
		<cfif #panelname# neq "0">
			<cfset PanelName=#form.panelname#>
			<p>			
			<cf_panel
				panelName="#Panelname#"
				width="320"
				DSN=#application.wellcoachesDSN#
				page="none"
				CoachAction=#CoachAction#
				ViewAction=#ViewAction#
				Clientid=#ClientID#>
			</p>
		</cfif>
		</td></tr></table>
	</cffunction>
	
	<cffunction name="wellnessvision" access="remote" output="true">
		<cfargument name="clientid" type="string" required="yes">
		
		<cfparam name="theMonth" default="0">
		<cfparam name="theYear" default="0">
		<cfparam name="Page" default="coachstart">
		<cfset ClientID=#arguments.ClientID#>
		
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname,lastname,startdate from members
			where memberid=#clientID#
		</cfquery> 
		<cfset clientname="#trim(Getclient.firstname)# #trim(getclient.lastname)#">
		<cfinvoke component="#application.newwebsitepath#.utilities.XMLHandler"
			method="GETXMLRecords" returnvariable="GetClientThreeMonth">
			<cfinvokeargument name="ThisPath" value="files/clients/logs">
			<cfinvokeargument name="ThisFileName" value="TMG#arguments.ClientID#">
			<cfinvokeargument name="selectstatement" value=" where clientid='#arguments.ClientID#'">
			<cfinvokeargument name="orderbystatement" value=" order by monthaffected desc, yearaffected desc">
		</cfinvoke>
			
		<cfif #GetClientThreeMonth.recordCount# gt 0>
			<cfset tempThreeMonth=querynew("MonthAffected,YearAffected,sortDate")>
			<cfoutput query="GetClientThreeMonth">
				<CFSET newRow  = QueryAddRow(tempThreeMonth, 1)>
				<CFSET temp = QuerySetCell(tempThreeMonth, "MonthAffected","#MonthAffected#", #newRow#)>
				<CFSET temp = QuerySetCell(tempThreeMonth, "YearAffected","#YearAffected#", #newRow#)>
				<cfset sortDate="#YearAffected#/01/#MonthAffected#">
				<cfset sortDate=dateformat(sortDate,"yyyy/mm/dd")>
				<CFSET temp = QuerySetCell(tempThreeMonth, "sortDate","#sortDate#", #newRow#)>
			</cfoutput>
			<cfquery name="GetMonths" dbtype="query">
				select distinct MonthAffected,yearaffected from tempThreeMonth
				order by yearaffected desc,monthaffected desc
			</cfquery>
		</cfif>
		<cfif theMonth eq 0 and theYear eq 0>
			<Cfif isdefined('getmonths')>
				<cfset theMonth=#GetMonths.MonthAffected#>
				<cfset theYear=#GetMonths.YearAffected#>
			<cfelse>
				<cfset getMonths=QueryNew("")>
				<cfset theMonth=month(now())>
				<cfset theYear=year(now())>
			</Cfif>
		</cfif>

		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=3 class="centerHeader">MY GOALS</td></tr>
		<tr><td colspan=3 class="centerTitle">WELLNESS VISION</td></tr>
		<tr><td colspan=3 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top width=150><p class="subHeader">Goal Dates</p>
		<a href="index.cfm?t&menusection=goals&coachaction=viewclient&ViewAction=addwellnessvision&ClientID=#clientID#&monthAffected=#month(now())#&yearAffected=#year(now())#">
		+ Add New Today</a><br>
		<cfoutput query="getmonths">
		<a href="index.cfm?t&menusection=goals&coachaction=viewclient&ViewAction=wellnessvision&ClientID=#clientID#&theMonth=#getMonths.monthaffected#&theyear=#getmonths.yearaffected#">
		<cfswitch expression="#getmonths.MonthAffected#">
			<cfcase value="1">January, #getmonths.yearaffected#</cfcase>
			<cfcase value="2">February, #getmonths.yearaffected#</cfcase>
			<cfcase value="3">March, #getmonths.yearaffected#</cfcase>
			<cfcase value="4">April, #getmonths.yearaffected#</cfcase>
			<cfcase value="5">May, #getmonths.yearaffected#</cfcase>
			<cfcase value="6">June, #getmonths.yearaffected#</cfcase>
			<cfcase value="7">July, #getmonths.yearaffected#</cfcase>
			<cfcase value="8">August, #getmonths.yearaffected#</cfcase>
			<cfcase value="9">September, #getmonths.yearaffected#</cfcase>
			<cfcase value="10">October, #getmonths.yearaffected#</cfcase>
			<cfcase value="11">November, #getmonths.yearaffected#</cfcase>
			<cfcase value="12">December, #getmonths.yearaffected#</cfcase>
		</cfswitch>
		</a>
		<br>
		</cfoutput>
		</td>
		<td height=400 bgcolor="##E8EFF6">
		<cfoutput>
				<script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0','width','525','height','350','id','otherlogs','align','','src','#application.flashpath#/wellnessvision?ClientID=#ClientID#&CoachID=#session.Coachid#&CoachAction=coach&monthAffected=#theMonth#&yearAffected=#theYear#','quality','high','bgcolor','##E8EFF6','name','otherlogs','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','#application.flashpath#/wellnessvision?ClientID=#ClientID#&CoachID=#session.Coachid#&CoachAction=coach&monthAffected=#theMonth#&yearAffected=#theYear#' ); //end AC code
</script><noscript><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
						codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						WIDTH="525" HEIGHT="350" id="otherlogs" ALIGN="">
						<PARAM NAME=movie 
						VALUE="#application.flashpath#/wellnessvision.swf?ClientID=#ClientID#&CoachID=#session.Coachid#&CoachAction=coach&monthAffected=#theMonth#&yearAffected=#theYear#"> 
						<PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##E8EFF6> 
						<EMBED src="#application.flashpath#/wellnessvision.swf?ClientID=#ClientID#&CoachID=#session.Coachid#&CoachAction=coach&monthAffected=#theMonth#&yearAffected=#theYear#" 
						quality=high bgcolor=##E8EFF6  
						WIDTH="525" 
						HEIGHT="350" 
						NAME="otherlogs" 
						ALIGN=""
						TYPE="application/x-shockwave-flash" 
						PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
						</EMBED>
						</OBJECT></noscript>
			</cfoutput>
		</td>
		</tr>
	</TABLE>
	</cffunction>
	
	<cffunction name="threemonthgoals" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		
		<cfparam name="theMonth" default="0">
		<cfparam name="theYear" default="0">
		<cfparam name="Page" default="coachstart">
		
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname,lastname,startdate from members
			where memberid=#clientID#
		</cfquery> 
		<cfset clientname="#trim(Getclient.firstname)# #trim(getclient.lastname)#">
		<cfinvoke component="#application.newwebsitepath#.utilities.clientlogs" 
			method="GetAllThreeMonth" returnvariable="GetClientThreeMonth">
			<cfinvokeargument name="theClient" value="#ClientID#">
		</cfinvoke>

			
		<cfif #GetClientThreeMonth.recordCount# gt 0>
			<cfset tempThreeMonth=querynew("MonthAffected,YearAffected,sortDate")>
			<cfoutput query="GetClientThreeMonth">
				<CFSET newRow  = QueryAddRow(tempThreeMonth, 1)>
				<CFSET temp = QuerySetCell(tempThreeMonth, "MonthAffected","#MonthAffected#", #newRow#)>
				<CFSET temp = QuerySetCell(tempThreeMonth, "YearAffected","#YearAffected#", #newRow#)>
				<cfset sortDate="#YearAffected#/01/#MonthAffected#">
				<cfset sortDate=dateformat(sortDate,"yyyy/mm/dd")>
				<CFSET temp = QuerySetCell(tempThreeMonth, "sortDate","#sortDate#", #newRow#)>
			</cfoutput>
			<cfquery name="GetMonths" dbtype="query">
				select distinct MonthAffected,yearaffected from tempThreeMonth
				order by yearaffected desc,monthaffected desc
			</cfquery>
		</cfif>
		<cfif theMonth eq 0 and theYear eq 0>
			<Cfif isdefined('getmonths')>
				<cfset theMonth=#GetMonths.MonthAffected#>
				<cfset theYear=#GetMonths.YearAffected#>
			<cfelse>
				<cfset getMonths=QueryNew("")>
				<cfset theMonth=month(now())>
				<cfset theYear=year(now())>
			</Cfif>
		</cfif>
		
		<cfinvoke component="#application.newwebsitepath#.utilities.clientlogs" 
			method="getTMByDate" returnvariable="GetLastPlan">
			<cfinvokeargument name="ClientID" value="#ClientID#">
			<cfinvokeargument name="MonthAffected" value="#theMonth#">
			<cfinvokeargument name="YearAffected" value="#theYear#">
		</cfinvoke>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=3 class="centerHeader">MY GOALS</td></tr>
		<cfset xmonth="#themonth#/01/#theyear#">
		<tr><td colspan=3 class="centerTitle">THREE MONTH GOALS #ucase(dateformat(xmonth,"mmmm"))#, #theYear#</td></tr>
		<tr><td colspan=3 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td>
		<td valign=top width=200 bgcolor="##e8eff6"><p  class="subHeader">Goal Dates</p>
		<p><font color="##666666"><strong>NOTE</strong>: Make sure the entire goal is selected before making changes (i.e. the entire goal 
has a grey background - click the word "Go" to select ror add/edit)</font></p>
		<a href="index.cfm?coachaction=viewclient&ViewAction=threemonthgoals&ClientID=#clientID#&monthAffected=#month(now())#&yearAffected=#year(now())#">
		+ Add New Today</a><br>
		<cfoutput query="getmonths">
		<a href="index.cfm?coachaction=viewclient&ViewAction=threemonthgoals&ClientID=#clientID#&theMonth=#getMonths.monthaffected#&theyear=#getmonths.yearaffected#">
		<cfswitch expression="#getmonths.MonthAffected#">
			<cfcase value="1">January, #getmonths.yearaffected#</cfcase>
			<cfcase value="2">February, #getmonths.yearaffected#</cfcase>
			<cfcase value="3">March, #getmonths.yearaffected#</cfcase>
			<cfcase value="4">April, #getmonths.yearaffected#</cfcase>
			<cfcase value="5">May, #getmonths.yearaffected#</cfcase>
			<cfcase value="6">June, #getmonths.yearaffected#</cfcase>
			<cfcase value="7">July, #getmonths.yearaffected#</cfcase>
			<cfcase value="8">August, #getmonths.yearaffected#</cfcase>
			<cfcase value="9">September, #getmonths.yearaffected#</cfcase>
			<cfcase value="10">October, #getmonths.yearaffected#</cfcase>
			<cfcase value="11">November, #getmonths.yearaffected#</cfcase>
			<cfcase value="12">December, #getmonths.yearaffected#</cfcase>
		</cfswitch>
		</a>
		<br>
		</cfoutput>
		<cfoutput>
		<img src="../images/b.gif" height="350" width="1"><br>
		<p class="bottombuttons">
			<a href="#application.securepath#/coaching/printthreemonth.cfm?ClientID=#ClientID#&CoachID=#session.coachid#&themonth=#themonth#&theyear=#theyear#" target="_blank" class="bottombuttons">PRINT</a></cfoutput>
		</td>
		<td bgcolor="##e8eff6">
	
			<cfoutput><script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0','width','675','height','625','id','otherlogs','align','','src','#application.flashpath#/threemontheditor?ClientID=#ClientID#&MonthAffected=#theMonth#&YearAffected=#theYear#','quality','high','bgcolor','##e8eff6','name','otherlogs','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','#application.flashpath#/threemontheditor?ClientID=#ClientID#&MonthAffected=#theMonth#&YearAffected=#theYear#' ); //end AC code
</script><noscript><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
						codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
						WIDTH="675" HEIGHT="625" id="otherlogs" ALIGN="">
						<PARAM NAME=movie VALUE="#application.flashpath#/threemontheditor.swf?ClientID=#ClientID#&MonthAffected=#theMonth#&YearAffected=#theYear#"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##e8eff6> <EMBED src="#application.flashpath#/threemontheditor.swf?ClientID=#ClientID#&MonthAffected=#theMonth#&YearAffected=#theYear#" quality=high bgcolor=##e8eff6  WIDTH="675" HEIGHT="625" NAME="otherlogs" ALIGN=""
						TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
						</OBJECT></noscript></cfoutput>

		</TD>
		</tr>
		</table>
		
	</cffunction>
	
	<cffunction name="weeklygoals" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		
		<cfset ClientID=#arguments.clientID#>
		<cfparam name="Page" default="coachstart">
		<cfparam name="menusection" default="goals">
		<cfparam name="coachaction" default="viewclient">
		<cfparam name="ViewAction" default="thisWeekGoals">
		<cfparam name="WeekAffected" default="0">
		<cfparam name="sessionNo" default="0">
		<link rel="stylesheet" href="coaching.css" type="text/css">
		
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname + lastname as fullname,
			startdate
			from members
			where memberID=#clientid#
		</cfquery>

		<cfinvoke component="#application.newWebSitePath#.utilities.XMLHandler" 
			method="GETXMLRecords" returnvariable="AllSessions">
			<cfinvokeargument name="ThisPath" value="files/coaching">
			<cfinvokeargument name="ThisFileName" value="schedule#session.coachid#">
			<cfinvokeargument name="Selectstatement" 
				value=" where ClientID='#ClientID#' order by datestarted desc">
		</cfinvoke>
		<cfset today=dateformat(#getClient.startdate#)>
		
		<cfif weekaffected is 0 and sessionNo is 0>
			<cfif #allSessions.Recordcount# gt 0>
				<cfset SEssionNo=#AllSessions.recordcount#>
				<cfset weekaffected=datediff("w",#today#,#allsessions.datestarted#)>
				<cfset SessionDate=#dateformat(allsessions.datestarted,"mm/dd/yyyy")#>
			<cfelse>
				<cfset weekaffected=0>
				<cfset SessionDate=#dateformat(getClient.StartDate,"mm/dd/yyyy")#>
				<cfset thisSessionDate=#dateformat(SessionDate,"mm/dd/yyyy")#>
			</cfif>
		</cfif>

		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY GOALS</td></tr>
		<tr><td colspan=2 class="centerTitle">WEEKLY GOALS</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr bgcolor="##e8eff6">
		<td valign=top width=150 nowrap><br><p class="subHeader">Sessions</p>
		<p><font color="##666666"><strong>NOTE</strong>: Make sure the entire goal is selected before making changes (i.e. the entire goal 
has a grey background - click the word "Go" to select ror add/edit)</font></p>
			<table>
			<cfset sessionCounter=#allsessions.recordcount#>
			<cfoutput query="allSessions">
			<cfset ThisWeek=datediff("w",#today#,#allsessions.datestarted#)>
			
			<tr><td class="caption" nowrap>#sessionCounter#: <a href="index.cfm?page=coachstart&ClientID=#clientID#&CoachAction=viewclient&ViewAction=weeklygoals&WeekAffected=#ThisWeek#&menusection=goals&sessionNo=#sessionCounter#&sessionDate=#dateformat(datestarted,'mm/dd/yyyy')#">#dateformat(datestarted,"mm/dd/yyyy")#</a></td></tr>
			<cfif sessionCounter is #sessionNo#><cfset thisSessionDate=#dateformat(datestarted,"mm/dd/yyyy")#></cfif>
			<cfset sessionCounter=sessionCounter - 1>
			</cfoutput>
			<tr><td nowrap><br><p class="subHeader">Client Starting Date:</p></td></tr>
			<tr><td class="caption">#dateformat(getClient.startdate,"mm/dd/yyyy")#</td></tr>
			</table>
		<img src="../images/b.gif" height="200" width="1"><br>
			<P align=left class=bottombuttons>
			<a href="index.cfm?CoachAction=#CoachACtion#&ClientID=#ClientID#&ViewACtion=emailgoals&menusection=goals&weekaffected=#weekaffected#&sessionDate=#sessionDate#&sessionNo=#SEssionNo#" class=bottombuttons>EMAIL</a>&nbsp;&nbsp;&nbsp;
			<a href="#application.securepath#/coaching/printgoals.cfm?ClientID=#ClientID#&CoachID=#session.coachid#&weekaffected=#weekaffected#&sessionDate=#sessionDate#&sessionNo=#SEssionNo#" target="_blank" class=bottombuttons>PRINT</a>&nbsp;&nbsp;&nbsp;</P>
		</td>
		<td valign=top>
			<cfparam name="weekaffected" default="0">
		  <cfparam name="sessionDate" default="0">
		  <script type="text/javascript">
AC_FL_RunContent( 'codebase','https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0','width','625','height','500','id','otherlogs','align','','src','#application.flashpath#/goalseditor?ClientID=#ClientID#&FirstDay=#weekaffected#&sessionDate=#sessionDate#','quality','high','bgcolor','##e8eff6','name','otherlogs','pluginspage','https://www.macromedia.com/go/getflashplayer','movie','#application.flashpath#/goalseditor?ClientID=#ClientID#&FirstDay=#weekaffected#&sessionDate=#sessionDate#' ); //end AC code
</script><noscript><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
			WIDTH="625" HEIGHT="500" id="otherlogs" ALIGN="">
			<PARAM NAME=movie VALUE="#application.flashpath#/goalseditor.swf?ClientID=#ClientID#&FirstDay=#weekaffected#&sessionDate=#sessionDate#"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##E8EFF6> <EMBED src="#application.flashpath#/goalseditor.swf?ClientID=#ClientID#&FirstDay=#weekaffected#&sessionDate=#sessionDate#" quality=high bgcolor=##E8EFF6  WIDTH="625" HEIGHT="500" NAME="otherlogs" ALIGN=""
			TYPE="application/x-shockwave-flash" PLUGINSPAGE="https://www.macromedia.com/go/getflashplayer"></EMBED>
			</OBJECT></noscript>
		</td>
		</tr>
		</table>
		
		
	</cffunction>
	
	<cffunction name="coachnotes" access="remote" output="true">
		<cfargument name="ClientID" type="string" required="yes">
		
		<cfset ClientID=#arguments.clientID#>
		
		<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
					username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from members where memberID=#clientID#
		</cfquery>
		<cfset ClientName="#Trim(GetClient.firstname)# #Trim(GetClient.LastName)#">
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY GOALS</td></tr>
		<tr><td colspan=2 class="centerTitle">COACH NOTES</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
			
		  <TR>
		  	<td width="150" style="padding-left: 20px"><img src="../images/b.gif" height="1" width="150"><br><a href="../coachingscripts/printnotes.cfm?CoachAction=ViewClient&ViewAction=printnotes&ClientID=#ClientID#" target="blank" class="bottombuttons">Print &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
			<td valign=top>
		<cfinvoke component="#application.newwebsitepath#.utilities.clientlogs" 
			method="GetNotes" returnvariable="coachNotes">
			<cfinvokeargument name="CoachID" value="#session.CoachID#">
			<cfinvokeargument name="ClientID" value="#ClientID#">
		</cfinvoke>
		<cfif coachNOtes.recordcount is 0>
			<cfset coachNotes=QueryNew("NoteID,DescTitle,Description,DateEntered,ClientID,CoachID,TypeID")>
		</cfif>
		<cfset tCount=1>
				<cfform action="index.cfm?coachaction=#coachaction#&viewaction=savecoachnotes&clientID=#clientID#" target="_self" method="post" name="otherlogsform" preservedata="true" preloader="no" format="flash" height="450" width="550" skin="halosilver">
				<cfformgroup  type="horizontal">
					<cfgrid name="DetailGrid" 
						height="350" 
						width="500" 
						align="top" 
						query="coachNotes" 
						font="Arial" 
						fontsize="10" 
						appendkey="yes" 
						griddataalign="center" 
						gridlines="yes" 
						rowheaderalign="left" 
						colheaderalign="left" 
						colheaderfont="Arial" 
						colheaderfontsize="12" 
						colheaderbold="yes" 
						colHeaderTextColor="##1c5da1" 
						bgcolor="##FFFFFF" 
						selectmode="edit" 
						maxrows="10" 
						picturebar="yes"
						enabled="yes" 
						visible="yes" 
						format="flash" 
						textcolor="##000000" 
						autowidth="true">
					<cfgridcolumn name="NoteID" header="Note ID"  dataalign="left" width="1"  select="no" display="no" type="numeric">
					<cfgridcolumn name="DateEntered" header="Date" width="1" type="string_noCase" display="no" select="no">
					<cfgridcolumn name="TypeID" header="TypeID" width="1" type="string_noCase" display="no" select="no">
					<cfgridcolumn name="desctitle" header="Title" width="35" type="string_noCase" display="yes" select="yes" dataAlign="left">
					<cfgridcolumn name="Description" header="Description" headeralign="left" dataAlign="left" width="200" bold="no" italic="no" select="yes" display="yes" type="string_nocase" headerbold="no" headeritalic="no">
					</cfgrid>
				</cfformgroup>
				<cfformgroup  type="horizontal">
					<cfinput type="button" name="ins" value="Insert a new note" width="125" onClick="GridData.insertRow(DetailGrid);" class="bottombuttons">
					<cfinput type="button" name="del" value="Delete Note" width="100" onClick="GridData.deleteRow(DetailGrid);" class="bottombuttons">
					<cfinput type = "submit" name="submit" width="100" value = "Save Changes" class="bottombuttons">
					<cfinput type = "reset" name="reset" width="100" value = "Reset Fields" class="bottombuttons">
				</cfformgroup>
				</cfform>
				
		</td></tr></table>
	</cffunction>
	
	<cffunction name="printlogs" output="true" access="remote">
		<cfargument name="clientID" type="string" required="yes">
		<cfset clientID=#arguments.clientid#>
		<script>
			function printit(){  
			if (window.print) {
				window.print() ;  
			} else {
				var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
			document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
				WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
			}
			}
			</script>
			<SCRIPT Language="Javascript">  
			var NS = (navigator.appName == "Netscape");
			var VERSION = parseInt(navigator.appVersion);
			if (VERSION > 3) {
				document.write('<form><input type=button value="Print this Page" name="Print" onClick="printit()"></form>');        
			}
			</script>
			
			
			<cfoutput><div class=popmenu><p class=menucaption><IMG SRC="#application.returnpath#/images/b.gif" WIDTH="210" HEIGHT="10"><a href="javascript:printit()">Print This Page</a></p></div></cfoutput>
			
			<cfparam name="Today" default="#dateformat(now())#">
			<cfif isDefined('Url.Today')>
				<cfset Today=#url.today#>
			</cfif>
			<cfset LastWeek=dateformat(dateadd("d",-7,#Today#))>
			<cfset NextWeek=dateformat(dateadd("d",7,#Today#))>
			
			<cfset ThisDay=dayofweek(#today#)>
			<cfset FirstDayDiff= (7 - #ThisDay#)>
			<cfset FirstDay=dateadd("d",-#firstDayDiff#,now())>
			<cfset LastDayDiff= abs(#ThisDay# - 7)>
			<cfset LastDay=dateadd("d",#LastDayDiff#,now())>
			
			<cfquery name="GetLogTypes" datasource="#application.wellcoachesDSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				Select notetypes.*, subnotetypes.comments, subnotetypes.description as subdesc, subnotetypes.id as subtypeid,notecategories.description 
				from notetypes,notecategories, subnotetypes 
				where notecategories.categoryid=notetypes.notecategoryid
				and subnotetypes.notetypeid=notetypes.id
				and notetypes.typeid < 1000
				and notetypes.Typeid > 0 
				and notetypes.notecategoryid=7
				order by notetypes.typeid
			</cfquery>
			<cfparam name="TypeID" default=0>
			<cfparam name="LogTypeID" default="Stress Rating">
			<cfif #TypeID# is 0>
				<cfset TypeID="Stress Rating">
				<cfset LogTypeID=5>
			</cfif>
			
			<script>
			function getexplanation(tURL) {
			window.open(tURL,'','resizable=yes,width=300,height=400,scrollbars=no');
			}
			function printit(){  
			if (window.print) {
				window.print() ;  
			} else {
				var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
			document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
				WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box    WebBrowser1.outerHTML = "";  
			}
			}
			</script>
			
			<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
				
			  <TR>
				<TD><IMG SRC="<cfoutput>#application.returnpath#</cfoutput>/images/b.gif" WIDTH="15" HEIGHT="24"></TD>
				<td>
				<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
					
					<TR> 
					  <TD><IMG SRC="<cfoutput>#application.returnpath#</cfoutput>/images/b.gif" WIDTH="15" HEIGHT="24"></TD>
					</TR>
					
					<cfset checkID=0>
					<cfoutput query="GetLogTypes">
						<cfif #ID# neq 44><cfif #ID# neq 43>
						<cfif #ID# neq #CheckID#>
							<tr><td class=qanswer>#typedescription#</td></tr>
							<cfset CheckID=#ID#>
						</cfif>
						<cfif #comments# is "Body Fat %">
							<cfset tComments="Body Fat">
						<cfelse>
							<cfset tComments=#Comments#>
						</cfif>
						<TR> 
							<TD CLASS="caption">
							<img src="<cfoutput>#application.returnpath#</cfoutput>/images/b.gif" height=1 width=10>#comments#
							</TD>
						</TR>
						</cfif></cfif>
					</cfoutput>
			
				  </TABLE>
			
				  <p align=center>

			</td>
			<TD><IMG SRC="<cfoutput>#application.returnpath#</cfoutput>/images/b.gif" WIDTH="15" HEIGHT="24"></TD>
			<td valign=top>
			
			<cfinvoke component="#application.newwebsitepath#.utilities.clientlogs" 
				method="GetOtherLog" returnvariable="GetLogs">
				<cfinvokeargument name="ClientID" value="#ClientID#">
				<cfinvokeargument name="tLogType" value="#LogTypeID#">
			</cfinvoke>
			
			<cfset tCount=1>
			<cfset tMeasureTitle=''>
			<cfset tDescTitle=''>
			<cfif #getlogs.recordcount# gt 0>
				<cfset xmeasuretitle=#getLogs.measuretitle#>
				<cfset tsubdesc=#getLogs.DescTitle#>
			<cfelse>
				<cfquery name="gettLogs" datasource="#application.wellcoachesDSN#"  
					username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
					select comments,description from subnotetypes
					where comments like '#typeid#%'
				</cfquery>
				<cfset xmeasuretitle=#gettLogs.comments#>
				<cfset tsubdesc=#gettLogs.description#>
			</cfif>
			<cfif #trim(xmeasuretitle)# is ''>
				<cfquery name="gettLogs" datasource="#application.wellcoachesDSN#"  
					username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
					select comments,description from subnotetypes
					where comments like '#typeid#%'
				</cfquery>
				<cfset xmeasuretitle=#gettLogs.comments#>
				<cfset tsubdesc=#gettLogs.description#>
			</cfif>
			<cfset xmeasuretitle=replace(xmeasuretitle,"%","percent","ALL")>
			<cfset tsubdesc=replace(tsubdesc,"%","percent","ALL")>
			
			<IMG SRC="#application.returnpath#/images/b.gif" WIDTH="15" HEIGHT="5"><br>
			<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=95%>
				<cfoutput>
					<cfif #TypeID# eq "39">
						<cfset xmeasuretitle="Stress Rating">
						<cfset tsubdesc="Stress Rating">
					</cfif>
					
					<TR> 
						<TD><IMG SRC="#application.returnpath#/images/b.gif" WIDTH="375" HEIGHT="32"></TD>
					</TR>
					<TR> 
						<TD class=bold>#xmeasuretitle#</TD>
					</TR>
					<TR> 
						<TD class=qanswer>Target Range: #tsubdesc#</TD>
					</TR>
					<TR> 
						<TD><IMG SRC="#application.returnpath#/images/b.gif" WIDTH="375" HEIGHT="10"></TD>
					</TR></cfoutput>
				<cfoutput query="GetLogs">
					<tr><td class=caption bgcolor="##FFFFFF">
						<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
						<cfif tCount is 1>
							<TR class=tableheader> 
							  <TD width=33%>&nbsp;Date</TD>
							  <TD width=33%>&nbsp;Measurement</TD>
							  <TD width=33%>&nbsp;Goal</TD>
					<!--- 	      <TD> Comments</TD> --->
							</TR>
							<cfset tcount=2>
						</cfif>
					<TR> 
					  <TD background="#application.returnpath#/images/b.gif" colspan=3><IMG SRC="#application.returnpath#/images/b.gif" WIDTH="15" HEIGHT="1"></TD>
					</TR>
			
					<TR> 
					  <TD class="caption" VALIGN="TOP" nowrap width=33%> 
					   #dateformat(LogDate,'mm/dd/yyyy')#
					  </TD>
					  <TD class="caption" VALIGN="TOP" align="center" width=33%> 
						<center><cfif isnumeric(#measurement#)><cfif int(#measurement#) is #measurement#>#int(measurement)#<cfelse>#measurement#</cfif><cfelse>#measurement#</cfif></center>
					  </TD>
					  <TD class="caption" VALIGN="TOP" align="center" width=33%> 
						<center><cfif isnumeric(#goal#)><cfif int(#goal#) is #goal#>#int(goal)#<cfelse>#goal#</cfif><cfelse>#goal#</cfif></center>
					  </TD>
			<!---           <TD class="caption" VALIGN="TOP"> 
						#otherdesc#
					  </TD> --->
					</TR>
			<tr><td colspan=7 class=captionsc><cfif #Comments# neq ''><img src="#application.returnpath#/images/b.gif" width=18 height=1 alt="" border="0">#Comments#<cfelse>#Comments#</cfif></td></tr>
				  </TABLE>
					</td></tr>
				</cfoutput>
				
			</TABLE>
			
			</td>
			</tr>
			</table>
			

	</cffunction>
	
	<cffunction name="QuickieAssessment" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		<cfinclude template="../coachingscripts/quickieform.cfm">
	</cffunction>
	
	<cffunction name="FamilyAssessment" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		<cfinclude template="../coachingscripts/FamilyAssess.cfm">
	</cffunction>
	
	<cffunction name="EmailAssess" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		<cfinclude template="../coachingscripts/EmailAssess.cfm">
	</cffunction>
	
	<cffunction name="createworkout" access="remote" output="true">
		
		<cfparam name="PanelName" default="Fitness">
		<cfparam name="PanelID" default=8>
		<cfoutput>

		</cfoutput>
		
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY WORKOUTS</td></tr>
		<tr><td colspan=2 class="centerTitle">Build A Workout</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top><p><font color="##CC0033">To edit an existing workout, click on Return to Client Library and then select the workout to edit.</font></p></td></tr>
		
		
		
		<tr>
		<td width="15"><img src="../images/b.gif" width="15" height="1"></td>
			<td>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr>
		<td width="146"><img src="../images/b.gif" width="146" height="1"></td>
		<td>
		
			<cfif ParameterExists(Form.NewPanel)>
				<cfif #Form.NewPanel# neq ''>
					<cfset PanelName=#form.newpanel#>
				<cfelse>
					<cfset PanelName=#form.panelname#>
				</cfif>
			</cfif>
		
		<p>
		
			<cf_panel2
					panelName="#Panelname#"
					width="320"
					DSN=#application.wellcoachesDSN#
					PanelID=#PanelID#>
					</td></tr></table>
		<p>&nbsp;</p>
		<p align=center>
			<a href="index.cfm?CoachAction=viewclient&ViewAction=#ViewAction#&Clientid=#ClientID#&menusection=library">CHANGE</a>&nbsp;&nbsp;&nbsp;
			<a href="index.cfm?CoachAction=viewclient&ViewAction=ClientLibrary&Clientid=#ClientID#&menusection=library">RETURN TO LIBRARY</a>
		</p></td></tr></table>
	</cffunction>
	
	<cffunction name="savecoachnotes" access="remote" output="true">
		<cfargument name="clientID" required="yes" type="string">
		
		<cfset Today=dateformat(now())>
		<cfset TypeID=#Form.GoalSection#>
		<cfset form.description=replace(#form.description#,",","~","ALL")>
		<cfset form.DESCTITLE=replace(#form.DESCTITLE#,",","~","ALL")>
		<cfparam name="DateEntered" default="#dateformat(now(),'yyyy/mm/dd')#">
		<cfif isdate(form.DateEntered)><cfset DateEntered=form.DateEntered></cfif>
		<cfinvoke component="#application.websitepath#.utilities.clientlogs" 
			method="saveNotes" output="true" returnvariable="NewNoteID">
			<cfinvokeargument name="ClientID" value="#arguments.ClientID#">
			<cfinvokeargument name="CoachID" value="#session.coachid#">
			<cfinvokeargument name="NoteID" value="#form.noteID#">
			<cfinvokeargument name="TypeID" value="56">
			<cfinvokeargument name="description" value="#form.description# ">
			<cfinvokeargument name="DATEENTERED" value="#DateEntered# ">
			<cfinvokeargument name="DESCTITLE" value="#form.DESCTITLE# ">
		</cfinvoke>
		
		<cflocation url="Index.cfm?CoachAction=ViewClient&ViewAction=coachNOtes&ClientID=#ClientID#">
		
	</cffunction>
	
	<cffunction name="coachGeneral" access="remote" output="true">
		
		<cfinvoke method="CoachInfo" returnvariable="GetCoachInfo"></cfinvoke>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My General Information</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<cfoutput>
		<form action="index.cfm" method="post" name="questionnaire">
		<input type="hidden" name="ViewAction" value="editcoach">
		<input type="hidden" name="CoachAction" value="#coachAction#">

			  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">

				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" VALIGN="TOP" CLASS="caption"> First Name:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="FirstName" value="#trim(GetCoachInfo.FirstName)#"></TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" VALIGN="TOP" CLASS="caption"> Last Name:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="LastName" value="#trim(GetCoachInfo.LastName)#"></TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Street Address:</TD>
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> 
					<input type="text" name="Address1" value="#Trim(GetCoachInfo.Address1)#">
					<BR>
					<input type="text" name="address2" value="#Trim(GetCoachInfo.address2)#">
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" VALIGN="TOP" CLASS="caption"> City:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="City" value="#trim(GetCoachInfo.City)#"></TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" VALIGN="TOP" CLASS="caption"> State/Province:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="State" value="#trim(GetCoachInfo.State)#"></TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Zip/Postal Code:</TD>
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> 
					<input type="text" name="postalcode" value="#Trim(GetCoachInfo.postalcode)#">
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Country:</TD>
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> 
					<input type="text" name="country" value="#Trim(GetCoachInfo.country)#">
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				
				 <TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> E-mail address:</TD>
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="captiongray"> 
					<input type="text" name="email" value="#Trim(GetCoachInfo.email)#">
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				 <TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Alternate E-mail address:</TD>
				  <TD>&nbsp;</TD>
				  <cfquery name="GetAltEmail" datasource="#application.wellcoachesDSN#"  username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
				  select emailaddress from email 
				  where connectid=#session.coachid# and websiteid=2 and tableid=15
				  </cfquery>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="captiongray"> 
					<input type="text" name="altemail" value="#Trim(GetAltEmail.emailaddress)#">
				  </TD>
				  <TD>&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				
				<TR> 
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP">Phone:</TD>
				  <TD>&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"><p>
					<input type="text" name="homephonenumber" value="#Trim(GetCoachInfo.phonenumber)#">
					Home<BR>
					<cfquery name="GetWorkPhone" datasource="#application.wellcoachesDSN#"  username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
						select * from phonenumbers
						where connectid=#session.coachid#
						and tableid=15
						and phonetypeid=2
					</cfquery>
					<cfif #GetWorkPhone.Recordcount# gt 0>
					<input type="text" name="workphonenumber" value="#trim(GetWorkphone.Phonenumber)#">
					<cfelse>
					<input type="text" name="workphonenumber" value="">
					</cfif>
					Business </p></TD>
				  <TD>&nbsp;</TD>
				</TR>
			   
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Date of birth:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="BirthDate" value='#dateformat(GetCoachInfo.BirthDate)#'></TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Age:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="age" value="#Trim(GetCoachInfo.age)#"> </TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="3" CLASS="caption" VALIGN="TOP"> Web site address:</TD>
				  <TD CLASS="caption">&nbsp;</TD>
				  <TD COLSPAN="7" VALIGN="TOP" CLASS="qAnswer"> <input type="text" name="websiteURL" value="#GetCoachInfo.websiteURL#"> </TD>
				  <TD CLASS="caption">&nbsp;</TD>
				</TR>
				<TR> 
				  <TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
				  <TD COLSPAN="11" class=tableheader background=../images/b.gif><IMG SRC="../images/b.gif" WIDTH="24" HEIGHT="1"></TD>
				  <TD><IMG SRC="../images/b.gif" WIDTH="1" HEIGHT="1"></TD>
				</TR>
				<TR> 
				  <td></td><TD COLSPAN="12" align=center<br><br><input type="submit" name="submit" value="Save Changes"></TD>
				</TR>
			  </TABLE>
		</form>
		</cfoutput>
		</td></tr></table>
	</cffunction>
	
	<cffunction name="workhistory" access="remote" output="true">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Related Work History</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<form action="index.cfm" method="post" name="responses">
			<cfoutput>
			<input type="hidden" name="CoachAction" value="#CoachAction#">
			<input type="hidden" name="ViewAction" value="saveResponses">
			<input type="hidden" name="CatID" value="8">
			</cfoutput>
			<cfset sid=#session.coachid#>
			<cfset CatID=8>
			<cfinclude template="../coachingscripts/getanswers9.cfm">
			<input type="submit" name="workhistorySubmit" value="Submit Changes">
		</form>
		
		</td></tr></table>
	</cffunction>
	
	<cffunction name="coachphoto" access="remote" output="true">
		
		<cfparam name="Title" default=''>
		<cfparam name="SubTitle" default=''>
		<cfparam name="RecordID" default=0>
		<cfparam name="UploadAction" default="Add">
		<cfparam name="Description" default=''>
		<cfparam name="ImageName" default=''>
		<cfparam name="FileTypeID" default=0>
		<cfparam name="Height" default=0>
		<cfparam name="Width" default=0>
		<cfparam name="ConnectID" default=#session.coachid#>
		<cfparam name="TableID" default=0>
		<cfparam name="Description" default=''>
		<cfparam name="DateAvailable" default=''>
		
		<cfset DateEnded = dateformat(now())>
		<cfif #DateAvailable# is ''>
			<cfset DateAvailable = dateformat(now())>
		</cfif>
		<cfif #RecordID# gt 0>
			<cfif #UploadAction# is "Delete">
				<cfquery name="Delete" datasource="#application.wellcoachesDSN#" 
					password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
					delete from Images
					where ImageID = #RecordID#
					and TAbleid = 15
				</cfquery>
				<cfset UploadAction = "Add">
			</cfif>
			<cfif #UploadAction# is "Update">
				<cfset #NewImage# = #form.ImageName#>
				<cfif #Form.Image# neq ''>
					<cfset #curPath# = GetTemplatePath()>
				
					<cfset #curDirectory# = "#application.OtherUploadPath#\images\members\">
			
					<cf_FileUpload
					directory="#curDirectory#"
					weight="500"
					nameofimages="image"
					nameConflict="makeunique"
					accept="image/*"
					default="na">
					
					<cfif #image# neq #NewImage#>
						<cfset #NewImage# =  #Image#>
						<Cffile action="copy" destination="#application.OtherUploadPath#\memberships\images\#image#" source="#application.OtherUploadPath#\images\members\#image#">
					</cfif>
				</cfif>
				<cf_imagesize file="#application.OtherUploadPath#\images\members\#trim(NewImage)#">
				<cfif #form.imagetypeid# is 3><cfset form.title="Coach Profile Photo"></cfif>
				<cfif #form.imagetypeid# is 2><cfset form.title="Marketing Site Photo"></cfif>
				<cfquery name="Update" datasource="#application.wellcoachesDSN#" 
					password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
					update Images set
					description='#form.description#',
					DateEnded='#dateformat(DateEnded)#',
					Title='#form.Title#',
					ImageName='#NewImage#',
					ConnectID=#session.coachid#,
					ImageTypeID=#form.ImageTypeID#,
					SubTitle='#form.SubTitle#',
					Width=#Width#,
					Height=#Height#
					where ImageID=#form.recordid#
				</cfquery>
				<cfset UploadAction = "Add">
			</cfif>
			<cfif #UploadAction# is "Edit">
				<cfset UploadAction = "Update">
				<cfquery name="GetSet" datasource="#application.wellcoachesDSN#" 
					password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
					select * from Images
					where ImageID=#RecordID#
				</cfquery>
				<cfset Title = #GetSet.Title#>
				<cfset SubTitle = #GetSet.SubTitle#>
				<cfset ImageName = #GetSet.ImageName#>
				<cfset Description = #GetSet.Description#>
				<cfset ImageID = #GetSet.ImageID#>
				<cfset TableID = 15>
				<cfset DateAvailable = #dateformat(GetSet.DateAvailable)#>
				<cfset DateEnded = #dateformat(GetSet.DateEnded)#>
				<cfset Description = #GetSet.Description#>
				<cfset ConnectID=#session.coachid#>
				<cfset ImageTypeID=#getSet.ImageTypeID#>
			</cfif>
			<cfif #UploadAction# is "Add">
				<cfset Title = ''>
				<cfset SubTitle = ''>
				<cfset ImageName = ''>
				<cfset TableID=15>
				<cfset Description = ''>
				<cfset ImageID = 0>
				<cfset Description = ''>
				<cfset ConnectID=#session.coachid#>
				<cfset ImageTypeID=3>
			</cfif>
		<cfelse>
			<cfset Title = ''>
			<cfset SubTitle = ''>
			<cfset ImageName = ''>
			<cfset TableID=15>
			<cfset Description = ''>
			<cfset ImageID = 0>
			<cfset Description = ''>
			<cfset ConnectID=#session.coachid#>
			<cfset ImageTypeID=3>
		</cfif>
		<cfif #UploadAction# is "Insert">
			<cfset #NewImage# = #form.ImageName#>
			<cfif #Form.Image# neq ''>
				<cfset #curPath# = GetTemplatePath()>
		
				<cfset #curDirectory# = "#application.OtherUploadPath#\images\members\">
				
				<cf_FileUpload
				directory="#curDirectory#"
				weight="500"
				nameofimages="image"
				nameConflict="makeunique"
				accept="image/*"
				default="na">
				
				<cfif #image# neq #NewImage#>
					<cfset #NewImage# =  #Image#>
				</cfif>
			</cfif>
			<cf_imagesize file="#application.OtherUploadPath#\images\members\#trim(NewImage)#">
			<cfif #form.imagetypeid# is 3><cfset form.title="Coach Profile Photo"></cfif>
			<cfif #form.imagetypeid# is 2><cfset form.title="Marketing Site Photo"></cfif>
			
			<cfquery name="Insert" datasource="#application.wellcoachesDSN#" 
				password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
				insert into Images
				(ParentName,
				Title,
				SubTitle,
				Description,
				DateAvailable,
				ImageName,
				DateEnded,
				ConnectID,
				TableID,
				ImageTypeID,
				Width,
				Height)
				values(
				'#form.ParentName#',
				'#form.Title#',
				'#form.SubTitle#',
				'#form.Description#',
				'#DateAvailable#',
				'#NewImage#',
				'#DateEnded#',
				#session.coachid#,
				15,
				#form.imagetypeid#,
				#Width#,
				#Height#)
			</cfquery>
		
		</cfif>
		<cfif #UploadAction# is "Add"><cfset UploadAction = "Insert"></cfif>
		
		<cfoutput>
		<script>
		function gethelp(pagename) {
			winStr = '../files/'+pagename;
			win = window.open(winStr, 'subwin' , 'width=640,height=480,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		function confirmDelete(delUrl) {
		  if (confirm("Are you sure you want to delete")) {
			document.location = delUrl;
		  }
		}
		</script>
		</cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Photos</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<FORM action="index.cfm" method="post" enctype="multipart/form-data" name="uploadform">
		<cfoutput>
		<input type="hidden" name="CoachAction" value="responses">
		<input type="hidden" name="CatID" value="99999999">
		<input type="hidden" name="uploadaction" value="#UploadAction#">
		<input type="hidden" name="ImageName" value="#ImageName#">
		<input type="hidden" name="RecordID" value="#RecordID#">
		<input type="hidden" name="CoachAction" value="#CoachAction#">
		<input type="hidden" name="ViewAction" value="#ViewAction#">
		<TABLE width=100% cellpadding=5>
		<tr>
			<td colspan=2 valign=bottom><cfif #Title# neq ''><font size=3 color=red><strong>#Title# = #imagename#</strong></font><br></cfif><input type="File" name="image" size="20" accept="image/*"><br><font size="2">(limit 200k per file)</font></td>
			</tr>
			<TR>
			<TD valign="top" nowrap><p> <b>Image Type:</b></p></TD>
			<TD>
				<select name="ImageTypeID">
					<option value="2" <cfif #ImageTypeID# is 2>selected</cfif>>Image for Coach Marketing Site</option>
					<option value="3" <cfif #ImageTypeID# is 3>selected</cfif>>Image for Biography</option>
				</select>
				<br>
				<font face="Arial, Helvetica, sans-serif" color="red">NOTE: The Coach Marketing Site photo must be no larger then 107 pixels by 107 pixels.  No matter what size under 107X107 it is, it MUST be square.</font>
			</TD>
			<!--- field validation --->
			</TR>
			<input type="hidden" value="0" name="ParentName">
			<input type="hidden" name="SubTitle" value="">
			<input type="hidden" name="Title" value="#Title#">
			<input type="hidden" name="description" value="">
				
			</TD>
			<!--- field validation --->
			</TR>
			<tr>
			<td></td>
			<td><input type="submit" name="btnEdit_OK" value="Upload Photo"></td>
			</tr>
		</table>
		</form>
		<p>&nbsp;</p>
		</cfoutput>
		
		<cfquery name="GetLinks" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
			select * from Images
			where connectid=#session.coachid#
			and ImageTypeID < 4
			order by ImageName
		</cfquery>
		
		<table class=scheduledata width=100%>
		<tr>
		<td colspan="5"><b>Your Images</b></td>
		</tr>
		<cfoutput query="GetLinks">
		<tr class=calorietd>
		<td class=calorietd><p>#title#</p></td>
		<td class=calorietd><p><img src="https://www.wellcoaches.com/images/members/#trim(ImageName)#" border=0></p></td>
		<td  class=calorietd>
		<p>
		<a href= "index.cfm?RecordID=#ImageID#&uploadAction=Edit&ViewAction=#ViewAction#&CoachAction=#CoachAction#&CatID=99999999&TheTitle=Upload%20Photo" class=reg>Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('index.cfm?RecordID=#ImageID#&uploadAction=Delete&ViewAction=#ViewAction#&CoachAction=#CoachAction#&CatID=99999999&TheTitle=Upload%20Photo')" class=reg>Delete</a></p></td>
		</tr>
		</cfoutput>
		</table>
		</td></Tr></TABLE>
	</cffunction>

	
	<cffunction name="marketingcontent" access="remote" output="true">
	
		<cfinvoke method="coachinfo" returnvariable="getCoachInfo"></cfinvoke>

		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Marketing Site Content</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		
		<cfparam name="coachID" default="65">
		
		<cfoutput>
		<script type="text/javascript">
		AC_FL_RunContent( 'codebase','https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0','width','800','height','600','id','coachedits','align','middle','src','http://www.wellcoaches.com/coachmktgsite/flash/coachedits?coachid=#session.coachID#','quality','high','bgcolor','##E8EFF6','name','coachedits','allowscriptaccess','sameDomain','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','http://www.wellcoaches.com/coachmktgsite/flash/coachedits?coachid=#session.coachID#' ); //end AC code
		</script><noscript><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=8,0,0,0" width="800" height="600" id="coachedits" align="middle">
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="movie" value="http://www.wellcoaches.com/coachmktgsite/flash/coachedits.swf?coachid=#session.coachID#" /><param name="quality" value="high" /><param name="bgcolor" value="##E8EFF6" /><embed src="http://www.wellcoaches.com/coachmktgsite/flash/coachedits.swf?coachid=#session.coachID#" quality="high" bgcolor="##E8EFF6" width="800" height="600" name="coachedits" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object></noscript>
		<p>If you have any problems with this, please email Jamie Robinson at <a href="mailto:jrobinson@wellcoaches.com">jrobinson@wellcoaches.com</a></p>


		</cfoutput>
		
		</td></tr></table>

	</cffunction>
	
	<cffunction name="mailinglist" access="remote" output="true">
		<cfinvoke method="coachInfo" returnvariable="GetCoachInfo"></cfinvoke>
		<cfset CatID=999999>
		<cfoutput>
		<script>
		function GetEditor(form,tControl) {
			winStr = '../utilities/Editor.cfm?thisForm=' + form + '&thisContent=' + tControl+'&viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#catid=#catid#&thiscontrol=NO';
			win = window.open(winStr, 'editwin' , 'width=640,height=480,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		function confirmDelete(delUrl) {
		  if (confirm("Are you sure you want to delete")) {
			document.location = delUrl;
		  }
		}
		</script>
		<cfset TheTitle=''>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Mailing List</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		</cfoutput>
		<cfparam name="RecordID" default=0>
		<cfparam name="Action" default="Add">
		<cfparam name="alphabet" default="a">
		<cfset Firstname=replace(#GetCoachInfo.Firstname#," ","","ALL")>
		<cfset Firstname=replace(#Firstname#,".","","ALL")>
		<cfset Lastname=replace(#GetCoachInfo.Lastname#," ",".","ALL")>
		<cfset Lastname=replace(#Lastname#," ",".","ALL")>
		<cfset Lastname=replace(#Lastname#,"'","","ALL")>
		<cfset Lastname=replace(#Lastname#,",","","ALL")>
		<!--- <cfset Lastname=replace(Lastname,"-","","ALL")> --->
		<cfif #session.coachID# is 613 or #session.coachID# is 27>
			<cfset CoachSiteName="clients">
		<cfelse>
			<cfset CoachSiteName="#trim(Firstname)#.#Trim(Lastname)#">
		</cfif>
		<cfif not FileExists("c:\websites\wellcoaches\#coachSiteName#\index.cfm")>
			<cfset Lastname=replace(#Lastname#,".","","ALL")>
			<cfset CoachSiteName="#trim(Firstname)#.#Trim(Lastname)#">
		</cfif>
		<cfset findHyphen=findnocase("-",getCoachInfo.lastname)>
		<cfif findHyphen gt 0>
			<cfset lastname=left(#getCoachInfo.lastname#,findHyphen - 1)>
			<cfset Firstname=replace(#GetCoachInfo.Firstname#," ","","ALL")>
			<cfset Firstname=replace(#Firstname#,".","","ALL")>
			<cfset Lastname=replace(#Lastname#," ",".","ALL")>
			<cfset Lastname=replace(#Lastname#,"'","","ALL")>
			<cfset Lastname=replace(#Lastname#,",","","ALL")>
			<cfset CoachSiteName="#trim(firstname)#.#trim(lastname)#">
		</cfif>
		<cfset ListName="#Trim(CoachSiteName)#">
		<cfset ListName=replacenocase(#ListName#,"-","","ALL")>
		<cfset ListName=replacenocase(#ListName#,".","","ALL")>
		<cftry>
			<cfquery datasource="#application.wellcoachesDSN#" 
			password="#application.DSNpword#" username="#application.wellcoachesDSNuName#">
				select  * from #listname#
			</cfquery>
		<cfcatch>
			<cfset #ListName#="wellcoaches.#listname#">
		</cfcatch>
		</cftry>
		
		<cfif #RecordID# gt 0>
			<cfif #Action# is "Delete">
				<cfquery name="DeleteSets" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
					delete from #ListName#
					where ID = #RecordID#
				</cfquery>
				<cfset Action = "Add">
			</cfif>
			<cfif #Action# is "Update">
				<cfquery name="Editdealertypess" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
					update #ListName# set 
					firstname='#form.firstname#',	
					lastNAME='#form.lastname#',
					email='#form.email#'
					where ID=#RecordID#
				</cfquery>
				<cfset Action = "Add">
			</cfif>
			<cfif #Action# is "Edit">
				<cfset Action = "Update">
			</cfif>
			<cfquery name="GetSet" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
				select * from #ListName#
				where ID=#RecordID#
			</cfquery>
			<cfif #Action# neq "Add">
				<cfset ID = #GetSet.ID#>
				<cfset firstname='#GetSet.firstname#'>	
				<cfset lastNAME='#GetSet.lastNAME#'>	
				<cfset DateSignedUp='#dateformat(GetSet.DateSignedUp)#'>
				<cfset email='#GetSet.email#'>
			</cfif>
			<cfif #Action# is "Add">
				<cfset ID = 0>
				<cfset firstname=''>	
				<cfset lastNAME=''>
				<cfset DateSignedUp=''>	
				<cfset email=''>	
			</cfif>
		<cfelse>
			<cfset ID = 0>
			<cfset firstname=''>	
			<cfset lastNAME=''>
			<cfset DateSignedUp=''>	
			<cfset email=''>	
		</cfif>
		<cfif #Action# is "Insert">
			<cfquery name="Enternewsletteremail" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
				insert into #ListName# (
				firstname,
				lastNAME,
				DateSignedUp,
				email)
				values (
				'#form.firstname#',
				'#form.lastNAME#',
				'#dateformat(now())#',
				'#form.email#')
				</cfquery>
		
		</cfif>
		<cfif #Action# is "Add"><cfset Action = "Insert"></cfif>
		<cfoutput>
		<form name="thisform" action="index.cfm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="RecordID" value="#RecordID#">
		<input type="hidden" name="viewaction" value="#viewaction#">
		<input type="hidden" name="Action" value="#Action#">
		<input type="hidden" name="alphabet" value="#alphabet#">
		<input type="hidden" name="CoachACtion" value="#CoachACtion#">
		<input type="hidden" name="CatID" value="#CatID#">
		<input type="hidden" name="listname" value="#ListName#">
		<TABLE>
		<tr>
			<td colspan="3">
			<h4>My Mailing List</h4>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<a href="index.cfm?CoachAction=#coachaction#&CatID=#CatID#&viewaction=newsletter" class=captionsc>Send Newsletter/Email</a>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<img src="../images/b.gif" height=15 width=100>
			</td>
		</tr>
		<tr>
			<th colspan="3" class=main>
			Add a subscriber
			</th>
		</tr>
			<TR>
			<TD valign="top" class=qanswer> Name: </TD>
			<TD>
			
				<INPUT type="text" name="firstname" value="#firstname#" maxLength="50"><INPUT type="text" name="lastNAME" value="#lastNAME#" maxLength="50">
				
			</TD>
			<!--- field validation --->
			</TR>
		
			<TR>
			<TD valign="top" class=qanswer> Email Address: </TD>
			<TD>
			
				<INPUT type="text" name="email" value="#email#" maxLength="255">
			</TD>
			<!--- field validation --->
			</TR>
		
		</TABLE>
			
		<!--- form buttons --->
		<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
		<INPUT name="btnEdit_Cancel" type="reset"  value="Cancel">
		
		</FORM>
		
		<form name="viewall" action="index.cfm" method="post">
			<input type="hidden" value="#viewaction#" name="viewaction">
			<input type="hidden" value="#catID#" name="catID">
			<input type="hidden" value="#coachAction#" name="coachAction">
			<input type="hidden" value="all" name="alphabet">
			<input type="submit" name="viewallsubscribers" value="View All Subscribers">
		</form>
		<br>
		</CFOUTPUT>
		<cfparam name="alphabet" default="a">

		<cftry>
			<cfquery name="GetLevels" datasource="#application.wellcoachesDSN#" 
				password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
				select ID,
				firstNAME,
				lastname,
				DateSignedUp,
				email
				from wellcoaches.#ListName#
				<cfif #alphabet# neq "all">
				where lastNAME like '#alphabet#%' or LastName like '%#lcase(alphabet)#%'</cfif>
				order by lastNAME
			</cfquery>
		<cfcatch>
			<cfquery name="GetLevels" datasource="#application.wellcoachesDSN#" 
				password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
				select ID,
				firstNAME,
				lastname,
				DateSignedUp,
				email
				from #ListName#
				<cfif #alphabet# neq "all">
				where lastNAME like '#alphabet#%' or LastName like '%#lcase(alphabet)#%'</cfif>
				order by lastNAME
			</cfquery>
		
		</cfcatch>
		</cftry>
		<cfoutput>
		<span class=captionsc>
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=a">A</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=b">B</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=c">C</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=d">D</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=e">E</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=f">F</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=g">G</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=h">H</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=i">I</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=j">J</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=k">K</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=l">L</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=m">M</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=n">N</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=o">O</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=p">P</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=q">Q</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=r">R</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=s">S</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=t">T</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=u">U</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=v">V</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=w">W</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=x">X</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=y">Y</a> | 
		<a href="index.cfm?viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#&alphabet=z">Z</a>
		</span>
		<Table width=100%>
		<th colspan="4" align="CENTER" class=main>Subscribers</th>
		<tr>
		<th class=tableheader>Name</th>
		<th class=tableheader>Email</th>
		<th class=tableheader>Date Signed Up</th>
		<th class=tableheader>Actions</th>
		</tr>
		</cfoutput>
		<cfoutput query="GetLevels">
		<tr>
		<td class=qanswer>#trim(firstNAME)# #TRim(lastname)#</td>
		<td class=qanswer>#trim(Email)#</td>
		<td class=qanswer>#dateformat(dateSignedUP)#</td>
		<td class=captionsc><a href= "index.cfm?RecordID=#ID#&Action=Edit&viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#alphabet=#alphabet#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('index.cfm?RecordID=#ID#&Action=Delete&viewAction=#viewAction#CoachAction=#coachAction#&CatID=#CatID#alphabet=#alphabet#')">Delete</a></td>
		</tr>
		</cfoutput>
		<cfoutput></table></cfoutput>
		
		<cfquery name="getclients" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpword#" username="#application.wellcoachesDSNuName#">
			select memberid,firstname,lastname,emailaddress 
			from members,email
			where accesslevel=#session.coachid#
			and connectid=memberid and tableid=15 and email.websiteid=1
		</cfquery>
		<cfoutput><Table width=90%>
		<th colspan="5" align="CENTER" class=main>Clients</th>
		<tr>
		<th class=tableheader>Name</th>
		<th class=tableheader>Email</th>
		</tr></cfoutput>
		<cfoutput query="getclients">
		<tr>
		<td class=qanswer>#trim(firstNAME)# #TRim(lastname)#</td>
		<td class=qanswer>#trim(Emailaddress)#</td>
		</tr>
		</cfoutput>
		<cfoutput></table>
		
		</td></tr></table></cfoutput>
	</cffunction>
	
	<cffunction name="coachbiography" access="remote" output="true">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Biography</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<form action="index.cfm" method="post" name="responses">
			<cfoutput>
			<input type="hidden" name="CoachAction" value="#CoachAction#">
			<input type="hidden" name="ViewAction" value="saveResponses">
			<input type="hidden" name="CatID" value="12">
			</cfoutput>
			<cfset sid=#session.coachid#>
			<cfset CatID=12>
			<cfinclude template="../coachingscripts/getanswers9.cfm">
			<input type="submit" name="biographySubmit" value="Submit Changes">
		</form>
		
		</td></tr></table>
	</cffunction>
	
	<cffunction name="coachqualifications" access="remote" output="true">
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Qualifications</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		<form action="index.cfm" method="post" name="responses">
			<cfoutput>
			<input type="hidden" name="CoachAction" value="#CoachAction#">
			<input type="hidden" name="ViewAction" value="saveResponses">
			<input type="hidden" name="CatID" value="7">
			</cfoutput>
			<cfset sid=#session.coachid#>
			<cfset CatID=7>
			<cfinclude template="../coachingscripts/getanswers9.cfm">
			<input type="submit" name="qualificationsSubmit" value="Submit Changes">
		</form>
		
		</td></tr></table>
	</cffunction>
	
	<cffunction name="editcoach" access="remote" returntype="string" output="true">
		<cfquery name="Update" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			Update Members Set
			 FirstName='#form.FirstName#',
			 LastName='#form.LastName#',
			 <cfif isnumeric(#form.Age#)>AGe=#form.AGe#,</cfif>
			 BirthDate='#dateformat(form.BirthDate)#',
			 WebSiteURL='#form.WebSiteURL#',
			 LastModified='#dateformat(now())#'
			 where MemberID = #session.coachid#
		</cfquery>
		<cfmail to="dflin@wellcoaches.com" 
			from="#application.email#" 
			subject="Updated Profile" 
			server="#application.mailserver#">
			#Form.Firstname# #Form.Lastname# has updated his/her coach profile at wellcoaches.com
			First Name='#form.FirstName#',
			Last Name='#form.LastName#',
			EMail Address='#form.email#'
			Alt EMail Address='#form.altemail#'
			Address 1='#form.Address1#',
			Address 2='#form.Address2#',
			City='#form.City#',
			State='#form.State#',
			Postal Code='#form.PostalCode#'
			Home Phone='#trim(form.homephonenumber)#'
			Office Phone='#trim(form.workphonenumber)#'
				<cfinclude template="../coachingscripts/cNotice.cfm">
		</cfmail>
		<cfquery name="Updateemail" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#"> 
			update Email set
			EMailAddress='#form.email#'
			where TableID=15
			and ConnectID=#session.coachid#
			and WebSiteID= 1
		</cfquery>
		
		<cfquery name="CheckAltEmail" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#"> 
			select * from email where connectid=#session.coachid# and tableid=15 and websiteid=2
		</cfquery>
		<cfif #CheckAltEmail.RecordCount# gt 0>
			<cfquery name="UpdateAltemail" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#"> 
			update Email set
				 EMailAddress='#form.altemail#'
				 where TableID=15
				 and ConnectID=#session.coachid#
				 and WebSiteID= 2
			</cfquery>
		<cfelse>
			<cfquery name="InsertAltemail" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#"> 
			insert into Email (
				 EMailAddress,
				 TableID,
				 ConnectID,
				 WebSiteID )
			values (
			'#form.altemail#',15,#session.coachid#,2 
			)
			</cfquery>
		</cfif>
		<cfquery name="Updateaddress" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
		update Addresses set
			 AddressTypeID=1,
			 Address1='#form.Address1#',
			 Address2='#form.Address2#',
			 City='#form.City#',
			 State='#form.State#',
			 PostalCode='#form.PostalCode#'
			 where TableID=15
			 and ConnectID=#session.coachid#
		</cfquery>
		
		<cfquery name="checkphone" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			select * from phonenumbers where TableID=15
			 and ConnectID=#session.coachid#
			 and phonetypeid=1
		</cfquery>
		<cfif #CheckPHone.RecordCount# gt 0>
			<cfquery name="Updatephone" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			Update PhoneNumbers  set
				 PhoneNumber='#trim(form.homephonenumber)#'
				 Where TableID=15
				 and ConnectID=#session.coachid#
				 and phonetypeid=1
			</cfquery>
		<cfelse>
			<cfquery name="InsertPhont" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			insert into PhoneNumbers  (
				 PhoneNumber,
				 TableID,
				 ConnectID,
					 phonetypeid )
				 values (
				 '#trim(form.homephonenumber)#',
				 15,
				 #session.coachid#,
				 1
				 )
			</cfquery>
		</cfif>
		<cfquery name="checkphone" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			select * from phonenumbers where TableID=15
			 and ConnectID=#session.coachid#
			 and phonetypeid=2
		</cfquery>
		<cfif #CheckPHone.RecordCount# gt 0>
			<cfquery name="Updatephone" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			Update PhoneNumbers  set
				 PhoneNumber='#trim(form.workphonenumber)#'
				 Where TableID=15
				 and ConnectID=#session.coachid#
				 and phonetypeid=2
			</cfquery>
		<cfelse>
			<cfquery name="InsertPhont" datasource="#application.wellcoachesDSN#"  
			username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			insert into PhoneNumbers  (
				 PhoneNumber,
				 TableID,
				 ConnectID,
					 phonetypeid )
				 values (
				 '#trim(form.workphonenumber)#',
				 15,
				 #session.coachid#,
				 2
				 )
			</cfquery>
		</cfif>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My General Information</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>Your general information has been updated</td></tr></table>
	</cffunction>
	
	<cffunction name="coachpassword" access="remote" output="true">
		<cfinvoke method="CoachInfo" returnvariable="GetCoachInfo"></cfinvoke>
		<cfparam name="CoachAction" default="">
		
		<cfif isdefined('form.B1')>
			<CFTRANSACTION>
			<cfquery name="checkuser" datasource="#application.wellcoachesDSN#"  username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
			select logon, password, memberID
			from members
			where logon = '#FORM.OLDuName#'
			and password = '#FORM.OLDpWord#'
			and memberid=#session.coachid#
			</cfquery>
			</CFTRANSACTION>
			
			<cfif #checkuser.RecordCount# is 1>
				<cfif #form.VerifypWord# eq #form.pword#>
					<cfquery name="updatelogon" datasource="#application.wellcoachesDSN#"  username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
						update members set
						logon='#Form.uname#',
						password='#form.pword#'
						where memberid=#session.coachid#
					</cfquery>
					<cflocation url="index.cfm?page=coachstart&coachaction=changepword&CatID=12">
				<cfelse>
					New password does not verify<br>
					<a href="javascript:history.go()">CLICK HERE</a> to try again.
				</cfif>
			<cfelse>
				<cfset sid = "0">
				<cfset mname = "">
				Either your user name or password were incorrect.<br>
				<a href="javascript:history.go()">CLICK HERE</a> to try again.
			</cfif>
		</cfif>

		
		<cfoutput>
		
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Username and Password</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td>
		
		<form method="post" action="index.cfm">
		<input type="hidden" name="CoachAction" value="#CoachAction#">
		<input type="hidden" name="ViewAction" value="#ViewAction#">
		
		<table width="420" border="0" cellspacing="0" cellpadding="0">
			<tr>
		
			<TD>&nbsp;</TD>
			<td colspan=2><h1>#trim(GetCoachInfo.firstname)#'s Personal Website Password</h1></td>
			<TD>&nbsp;</TD>
			</tr>
			<TR> 
			<TD><IMG SRC="../images/b.gif" WIDTH="15" HEIGHT="1"></TD>
			 <TD colspan=2 background="../images/rule_horz.gif" valign=top><IMG SRC="../images/rule_horz.gif" WIDTH="150" HEIGHT="24"></TD>
		<TD>&nbsp;</TD>
		  </TR>
		  <tr>
			<TD>&nbsp;</TD>
			<td><p class=caption>Old User Name </td>
			<td><input type="text" size=33 name="OLDuName"></td>
			<TD>&nbsp;</TD>
			</tr>
			  <tr>
			  <TD>&nbsp;</TD>
			  <td><p class=caption>Old Password&nbsp;&nbsp;&nbsp; </td>
			  <td><input type="password" size=35 name="OldpWord"></td>
			  <TD>&nbsp;</TD>
			  </tr>
			  <tr>
			  <TD>&nbsp;</TD>
			  <td><p class=caption>New User Name </td>
			  <td><input type="text" size=33 name="uName"></td>
			  <TD>&nbsp;</TD><br>
			  </tr>
			  <tr>
			  <TD>&nbsp;</TD>
			  <td><p class=caption>New Password&nbsp;&nbsp;&nbsp; </td>
			  <td><input type="password" size=35 name="pWord"></td>
			  <TD>&nbsp;</TD></tr>
			<tr>
			  <TD>&nbsp;</TD>
			  <td><p class=caption>Verify New Password&nbsp;&nbsp;&nbsp; </td>
			  <td><input type="password" size=35 name="VerifypWord"></td>
			  <TD>&nbsp;</TD>
			  </tr>
			  <tr>
			  <TD>&nbsp;</TD>
			  <td colspan=2 align=center><br><p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p></td>
			  <TD>&nbsp;</TD>
			</tr>
		   <tr>
			 <TD>&nbsp;</TD>
			 <td colspan=2><img src="../images/b.gif" width=50 height=1 alt="" border="0"></td>
			<TD>&nbsp;</TD>
			</TR>
		</table>
		</form>
		</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="newsletter" access="remote" output="true">
		<cfinvoke method="CoachInfo" returnvariable="GetCoachInfo">
		<cfset Lastname=replace(#GetCoachInfo.Lastname#," ",".","ALL")>
		<cfset Lastname=replace(#Lastname#," ",".","ALL")>
		<cfset Lastname=replace(#Lastname#,"'","","ALL")>
		<cfset Lastname=replace(#Lastname#,",","","ALL")>
		<cfset FirstName=replace(#GetCoachInfo.FirstName#," ",".","ALL")>
		<cfset CoachSiteName="#trim(Firstname)#.#Trim(GetCoachInfo.Lastname)#">
		<cfif not FileExists("c:\websites\wellcoaches\#coachSiteName#\index.cfm")>
			<cfset Lastname=replace(#Lastname#,".","","ALL")>
		</cfif>
		<cfset NewPath=''>
		<cfif FileExists("c:\websites\wellcoaches\#coachSiteName#\index.cfm")>
			<cfset NewPath="http://www.wellcoaches.com">
		</cfif>
		<cfparam name="catID" default="13">
		<cfoutput><script>
		function GetEditor(form,tControl) {
			winStr = '../utilities/Editor.cfm?thisForm=' + form + '&thisContent=' + tControl+'&viewaction=#viewaction#&CoachAction=#coachAction#&CatID=#CatID#catid=#catid#&thiscontrol=NO';
			win = window.open(winStr, 'editwin' , 'width=640,height=480,menubar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,titlebar=no,location=no');
			win.focus();
		}
		
		</script></cfoutput>
		<cfset TheTitle=''>
		 <cfoutput>
		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">MY COACH PROFILE</td></tr>
		<tr><td colspan=2 class="centerTitle">My Newsletters</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		</cfoutput>
		
		<cfparam name="returnemail" default = #application.email#>
		<cfparam name="TheLetter" default = ''>
		<cfparam name="TheHeader" default = ''>
		<cfparam name="TheFooter" default=''>
		<cfparam name="ReturnURL" default = '#application.ReturnPath#/#CoachSiteName#'>
		<cfparam name="DateSent" default ='#Dateformat(now())#'>
		<cfparam name="name" default=''>
		<cfparam name="SendTo" default=0>
		<cfoutput>
		<FORM action="index.cfm" method="post" name="newsletterform">
		<input type="hidden" name="viewaction" value="#viewaction#">
		<input type="hidden" name="coachaction" value="previewnewsletter">
		<input type="hidden" name="DateSent" value="#DateSent#">
		<input type="hidden" name="ReturnURL" value="#application.ReturnPath#/#CoachSiteName#">
		<input type="hidden" name="returnemail" value="#returnemail#">
		<input type="hidden" name="catid" value="#catid#">
		<TABLE>
		<TR>
			<TD valign="top" > <h4>Create My Newsletter</h4> </TD>
			<TD>
				<TR>
			<TD valign="top" class=qanswer> Subject of my newsletter </TD>
			<TD>
			
				<input type="text" name="name" maxlength=50 value="#NAME#">
				
			</TD>
			</TR>
			<TR>
			<td valign="TOP" class=qanswer> The Header of my newsletter:<br></TD>
			<TD>
				<a href="javascript:GetEditor('newsletterform','TheHeader')" class=caption>Click here to open the editor</a><br>
				<TEXTAREA name="TheHeader" cols=40 rows=5>#TheHeader#</TEXTAREA>
			
			</TD>
			</TR>
			
			<TR>
			<TD valign="top" class=qanswer> The Body of my newsletter: <br>
			</TD>
			<TD>
			<a href="javascript:GetEditor('newsletterform','TheLetter')" class=caption>Click here to open the editor</a><br>
				<textarea name="TheLetter" cols="40" rows="10">#TheLetter#</textarea>
				
			</TD>
			<!--- field validation --->
			</TR>
			
				
			
			
			
			<TR>
			<TD valign="top" class=qanswer> The footer of my newsletter:<br>
			</TD>
			<td><a href="javascript:GetEditor('newsletterform','TheFooter')" class=caption>Click here to open the editor</a><br> 
					<textarea name="TheFooter" cols="40" rows="5">#TheFooter#</textarea>
		
			</TD>
			</TR>
			
		
		
		
			
			<TR>
			<TD valign="top" class=qanswer> Send my Newsletter to the following list(s): </TD>
			<TD class=qanswer>
					<input type="checkbox" name="SendTo" value="1"> Clients
					<input type="checkbox" name="SendTo" value="2"> Subscribers
			
			</TD>
			</TR>
			<tr><td></td><td>
		<!--- form buttons --->
		<INPUT type="submit" name="btnEdit_OK" value="Preview my newsletter"></td></tr>
		</TABLE>
			
		
		
		</FORM>
		
		
		</td></tr></table></CFOUTPUT>
	</cffunction>
	
	<cffunction name="deleteClientAccess" access="remote" output="true">
		<cfquery name="DeleteLibraryItem" datasource="#Application.DSN#"  
			username="#Application.DSNuName#" password="#Application.DSNpWord#">
			delete libraryaccess
			where accessid=#url.accessid#
		</cfquery>
		<cflocation url="index.cfm?page=#page#&CoachAction=#coachAction#&ClientID=#ClientID#&ViewAction=resources&resourceID=#URL.AccessID#">
	</cffunction>
	
	<cffunction name="coachdirectory" output="true" access="remote">
		
		<cfinvoke method="CoachInfo" returnvariable="GetCoachInfo"></cfinvoke>

		<cfset CoachEmail=trim(#getcoachinfo.email#)>
		<cfparam name="searchlastname" default="">
		<cfparam name="searchcoachtype" default="0">
		<cfparam name="searchstate" default="">
		
		<cfquery name="GetStates" datasource="#application.wellcoachesDSN#" 
			password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
			select distinct state from addresses,members
			where members.memberid=addresses.connectid
			and members.subtypeid=2
			order by addresses.state
		</cfquery>
		<cfoutput>

		<cfif isdefined('form.coachdirectorysubmit')>
			<cfquery name="GetCoaches" datasource="#application.wellcoachesDSN#" password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
				select members.firstname,
				members.lastname,
				members.memberid,
				email.emailaddress
				from members, email, addresses
				where email.connectid=members.memberid
				and email.tableid=15 and email.websiteid=1
				and addresses.connectid=members.memberid
				and addresses.tableid=15 
				and members.subtypeid=2
				and members.active=1
				<cfif #searchcoachType# neq 0>and members.height =#searchcoachType#</cfif>
				<cfif #searchlastname# neq ''>and members.lastname like '#searchlastname#%'</cfif>
				<cfif #searchstate# neq ''>and addresses.state like '#searchstate#%'</cfif>
				order by members.lastname
			</cfquery>
		<cfelse>
				<cfquery name="GetCoaches" datasource="#application.wellcoachesDSN#" password="#application.wellcoachesDSNpWord#" username="#application.wellcoachesDSNuName#">
					select members.firstname,
					members.lastname,
					members.memberid,
					email.emailaddress
					from members, email
					where email.connectid=members.memberid
					and email.tableid=15 and email.websiteid=1
					and members.subtypeid=2
					and members.active=1
					and members.height = 999
					order by members.lastname
				</cfquery>
		</cfif>

		<table style="padding-left: 30px; padding-right: 30px;">
		<tr><td colspan=2 class="centerHeader">CONTACT</td></tr>
		<tr><td colspan=2 class="centerTitle">Coach Directory</td></tr>
		<tr><td colspan=2 class="centerTitle"><img src="../images/centerDividerLine.jpg"></td></tr>
		<tr><td width="15"><img src="../images/b.gif" width="15"></td><td valign=top>
		
		<table><tr><td><p class=qanswer>Search by:</p></td></tr>
		<form name="searchdirectory" method="post" action="index.cfm">
		<input type="hidden" name="viewaction" value="#viewaction#">
		<Input type="hidden" name="coachaction" value="#coachaction#">
		<tr><td><p class=qanswer>Last Name</p></td> <td><input type="text" NAME="SearchLASTNAME" size="25" maxlength="35" value="#SearchLastname#"></td></tr>
		<tr><td><p class=qanswer>State/Province/Other</p></td>  
		
		<td><select name="searchstate">
			
			<cfloop query="getstates">
				<option value="#trim(State)#"<cfif #searchstate# is #trim(state)#> selected</cfif>>#trim(state)#</option>
			</cfloop>
		</select></td></tr>
		<tr><td><p class=qanswer>Coach Type:</p></td> <td><select name="searchcoachtype">
			<option value="0" <cfif searchCoachtype is 0>selected</cfif>>All</option>
			<option value="1" <cfif searchCoachtype is 1>selected</cfif>>Trainee</option>
			<option value="4" <cfif searchCoachtype is 4>selected</cfif>>Unlicensed Trained</option>
			<option value="2" <cfif searchCoachtype is 2>selected</cfif>>Licensed</option>
			<option value="3" <cfif searchCoachtype is 3>selected</cfif>>Licensed Corporate</option>
			<option value="5" <cfif searchCoachtype is 5>selected</cfif>>Licensed Executive</option>
		</select></td></tr>
		<tr><td></td><td><input type="submit" name="coachdirectorysubmit" value="Search">
		</form></cfoutput>
		
		</td></tr>
		<cfoutput query="GetCoaches">
		<tr>
			<td class=caption valign=top>
				<cfset CoachSiteName="#trim(Firstname)#.#Trim(Lastname)#">
				<cfif FileExists("#application.OtherUploadPath#\#coachSiteName#\index.cfm")>
					<a href="http://www.wellcoaches.com/#coachSiteName#" target="SMSM">
					<img src="../images/anchor2.gif" border="0" align=left></a>
				<cfelse>
					<img src="../images/b.gif" width=25 height=1 align=left>
				</cfif>
				<a href="getcoachbio.cfm?CoachID=#memberID#" target="SMSM">
				<img src="../images/bioicon.jpg" border="0" align=left></a>#trim(Firstname)# #trim(lastname)#</td> 
				<td class=captionsc valign=bottom>
				<a href="mailto:#trim(emailaddress)#">#trim(emailaddress)#</a></td>
		</tr>	
		
		</cfoutput>
		<cfoutput>
		</table>
		
		
		</td></tr></table>
		</cfoutput>
	</cffunction>
	
	<cffunction name="sendEmail" access="remote" output="true">
		<cfif #url.correspondenceAction# is "update">
			<cfset Today = dateformat(now(),'yyyy/mm/dd')>
			
			<cfquery name="getMemberinfo" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
				SELECT Members.FirstName, 
					Members.LastName,
					Email.EMailAddress as Email, 
					Members.MemberID,
					Members.AccessLevel
					FROM Members, Email
					WHERE email.tableid=15
					and email.connectid = members.memberid
					and email.websiteid=1
					and Members.memberid=#form.clientid#
			</cfquery>
			<cfset MemberName="#trim(GetMemberInfo.FirstName)# #trim(GetMemberInfo.LastName)#">
			<cfset MemberEmail=#GetMemberInfo.Email#>

			<cfset FieldList="ClientID, CoachID, SentByID, SentByType, dateCreated, DateToSEnd,  Message, subject">
			<cfset FieldValues="#form.ClientID#,#form.CoachID#,#form.sentByID#,correspondence,#Today#,sent,#replace(form.message,',','~','ALL')# ,#replace(form.subject,',','~','ALL')# ">
			
			<cfif #form.MessageID# neq 0>
				<cfinvoke component="#websitepath#.Utilities.XMLHandler" 
					method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files/correspondence">
					<cfinvokeargument name="ThisFileName" value="correspondence#arguments.coachid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="MessageID">
					<cfinvokeargument name="XMLIDValue" value="#arguments.MessageID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#websitepath#.Utilities.XMLHandler" 
					method="InsertXMLRecord" returnvariable="NewMessageID">
					<cfinvokeargument name="ThisPath" value="files/correspondence">
					<cfinvokeargument name="ThisFileName" value="correspondence#arguments.coachid#">
					<cfinvokeargument name="XMLFields" value="#FieldList#">
					<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
					<cfinvokeargument name="XMLIDField" value="MessageID">
				</cfinvoke>
			</cfif>
			
			<cfquery name="GetCoachEmail" datasource="#application.wellcoachesDSN#"  
				username="#application.DSNuName#" password="#application.DSNpWord#">
				SELECT Members.FirstName, 
					Members.LastName,
					Email.EMailAddress as Email, 
					Members.MemberID,
					Members.AccessLevel
					FROM Members, Email
					WHERE email.tableid=15
					and email.connectid = members.memberid
					and email.websiteid=1
					and Members.memberid=#session.CoachID#
			</cfquery>
			<cfset CoachName=#GetCoachEmail.FirstName#>
			<cfset CoachEmail=#getCoachEmail.Email#>
			<cfmail to="#MemberEmail#" 
				from="#application.email#" 
				subject="#form.subject#" 
				cc="#CoachEmail#" 
				type="html" 
				server="#application.mailserver#">
				<p><strong>Please don't reply to this message. Please forward your reply to #CoachName# at #CoachEmail#</strong></p>
				<p>#trim(form.message)#</p>
				<cfinclude template="../scripts/cNotice.cfm">
			
			</cfmail>
			<cfif isdefined('viewaction')>
				<cflocation url="index.cfm?page=#Page#&CoachAction=#CoachAction#&viewaction=#viewaction#&clientID=#ClientID#&menusection=email">
			<cfelse>
				<cflocation url="index.cfm?page=#Page#&CoachAction=#CoachAction#&menusection=email">
			</cfif>
		</cfif>
	
		<cfif #correspondenceAction# is "send">
		<table  border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor="##CCCCCC">
		  <TR> 
			<TD class=bold>Send Email</TD>
			 
		  </TR>
		  <TR VALIGN="TOP"> 
			<TD style="width:50%; padding: 0px 12px 0px 12px; border-left: white"> 
			  <TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
				<form action="index.cfm" method="post" name="emailCorrespondence">
				<input type="hidden" name="coachaction" value="#coachaction#">
				<input type="hidden" name="correspondenceAction" value="udpate">
				<input type="hidden" value="#ViewAction#" name="ViewAction">
				<tr>
					<td class=caption>To</td>
					<td class=caption>
					<cfif #clientid# gt 0>
						<cfquery name="GetClient" datasource="#application.wellcoachesDSN#"  
						username="#application.wellcoachesDSNuName#" password="#application.wellcoachesDSNpWord#">
							select Firstname + Lastname as fullname from members
							where memberid=#clientid#
						</cfquery>
						#getClient.fullname#
						<input type="hidden" value="#ClientID#" name="ClientID">
					<cfelse>
						<select name="ClientID">
							<cfquery name="Getclients" datasource="#application.wellcoachesDSN#" 
								username="#application.wellcoachesDSNuname#" password="#application.wellcoachesDSNpword#">
								select * from members where accesslevel=#session.coachID#
								order by lastname
							</cfquery>
							<cfloop query="GetClients">
								<option value="#memberID#">#trim(firstname)# #trim(lastname)#</option>
							</cfloop>
					  </select>
				  </cfif>
				  </td>
				</tr>
				<TR> 
				  <TD CLASS="caption"><P><SPAN CLASS="qAnswer">Enter the subject</SPAN></P></TD>
					  <td><input type="text" size="55" maxlength="255" name="subject"></TD>
				</TR>
				<TR> 
				  <TD colspan=2 CLASS="caption"><P><SPAN CLASS="qAnswer">Enter your email message</SPAN><br>
					<cfmodule 
						template="fckeditor/fckeditor.cfm"
						toolbarSet="Basic"
						basePath="fckeditor/"
						instanceName="message"
						value='#message#'
						width="450"
						height="450">
					  <textarea name="message" cols="30" rows="10"></textarea>
					</P>
				  </TD>
				</TR>
		
				<TR> 
				  <TD CLASS="caption"><P><input type="submit" name="contactcoach" value="SEND EMAIL" class=bluebutton>
					</P></TD>
				  <TD> 
					<P><input type="reset" value="RESET" class=bluebutton>
					</P>
				  </TD>
				</TR>
				</form>
			  </TABLE>
			</TD>
		  </TR>
		</TABLE>
		</cfif>
	</cffunction>
</cfcomponent>