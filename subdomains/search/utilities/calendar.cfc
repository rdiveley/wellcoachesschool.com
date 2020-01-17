<cfcomponent>
	<cffunction access="remote" name="GetMonth" output="true" returntype="query">
		<cfargument name="GoToYear" default="#year(now())#" required="false" type="numeric">
		<cfargument name="GoToMonth" default="#month(now())#" required="false" type="numeric">
		
		<cfscript>
			GoToDate = CreateDate(arguments.GoToYear, arguments.GoToMonth, 1);
			DateMonth = Month(GoToDate);
			DateMonthStr = MonthAsString(DateMonth);
			DateYear = Year(GoToDate);
			DateofFirst = CreateDate(DateYear, DateMonth, 1);
			DateDayofFirst = DayOfWeek(DateofFirst);
			DayofFirst = DayOfWeekAsString(DateDayofFirst);
			NumDays = DaysInMonth(GoToDate);
			StartRow = 1;
			FirstRunThrough = 1;
			DayIndex = 0;
			Year10Past = DateYear - 10;
			Year10Fut = DateYear + 10;
		</cfscript>
		
		<cfset Records=QueryNew("GoToDate,DateMonth,DateYear,DateOfFirst,DateDayOfFirst,DayOfFirst,NumDays,FirstRunThrough,DayIndex,Year10Past,Year10Fut,DateMonthStr,StartRow")>
		<CFSET newRow  = QueryAddRow(records, 1)>
		<CFSET temp = QuerySetCell(records, "GoToDate","#GoToDate#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DateMonth","#DateMonth#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DateYear","#DateYear#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DateofFirst","#DateofFirst#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DateDayofFirst","#DateDayofFirst#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DayofFirst","#DayofFirst#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "NumDays","#NumDays#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "FirstRunThrough","#FirstRunThrough#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DayIndex","#DayIndex#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "Year10Past","#Year10Past#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "Year10Fut","#Year10Fut#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "DateMonthStr","#DateMonthStr#", #newRow#)>
		<CFSET temp = QuerySetCell(records, "StartRow","#StartRow#", #newRow#)>
		<cfreturn records>
	</cffunction>
	
	<cffunction access="remote" name="GetEvents" output="true" returntype="query">
		<cfargument name="AllEvents" default="" required="true" type="query">
		<cfargument name="qryDateStarted" default="" required="true" type="date">
		<cfargument name="qryDateEnded" default="" required="true" type="date">
		
		<cfset Startevent="#dateformat(qryDateStarted,'mm/dd/yyyy')# 00:00">
		<cfset EndEvent="#dateformat(qryDateEnded,'mm/dd/yyyy')# 23:59">
		
		<cfif #allEvents.RecordCount# gt 0>
		<cfquery name="tGetEvents" dbtype="query">
			SELECT *
			FROM AllEvents
			WHERE ((datestarted = '#Startevent#') OR (dateended = '#EndEvent#'))
			OR (( datestarted > '#Startevent#') AND (dateended < '#EndEvent#'))
			Order by datestarted
		</cfquery>
		<cfelse>
			<cfset tGetEvents=QueryNew("EventID,DateStarted,nickname,EventDescription,DateEnded,EmailAddress,EventTitle,EventStatus")>
		</cfif>
		<cfreturn tGetEvents>
	</cffunction>
	
	<cffunction name="DisplayDaysEvents" access="private" output="true">
		<cfargument name="TheEvents" default="" required="true" type="query">
		<cfargument name="qryDateStarted" default="#now()#" required="true" type="date">
		<cfargument name="qryDateEnded" default="#now()#" required="true" type="date">
		<cfargument name="ShowSummary" default="0" required="true" type="numeric">
		<cfargument name="ShowIcons" default="0" required="true" type="numeric">
		<cfargument name="OtherAction" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
			
		<cfif #arguments.ShowIcons#>
			<cfset Pic="<img src=""../images/calendar/tack.jpg"" border=0>">
		<cfelse>
			<cfset Pic="">
		</cfif>
		
		<cfoutput query="TheEvents">
			<cfif #DateStarted# EQ #DateEnded#>
				<font class=calendarEvent>
				<a href="index.cfm?CalAction=ViewEventDetails&EventID=#EventID#&Page=#Page##OtherAction#">
				#PIC##timeformat(DateStarted)#</a>...
				</font><br>
				<cfif #arguments.ShowSummary#>#EventTitle#</cfif>
			<cfelseif #DateStarted# EQ #qryDateStarted# OR #DateEnded# EQ #qryDateEnded#>
				<cfif #DateStarted# EQ #qryDateStarted#>
					<font class=calendarEvent>
					<a href="index.cfm?CalAction=ViewEventDetails&EventID=#EventID#&Page=#Page##OtherAction#">
					#PIC##timeformat(DateStarted)#</a>...
					</font><br>
					<cfif #arguments.ShowSummary#>#EventTitle#</cfif>
				<cfelse>
					<font class=calendarEvent><font color="Red">(E)</font>&nbsp;
					<a href="index.cfm?CalAction=ViewEventDetails&EventID=#EventID#&Page=#Page##OtherAction#">
					#PIC##timeformat(DateStarted)#</a>...
					</font><br>
					<cfif #arguments.ShowSummary#>#EventTitle#</cfif>
				</cfif>
			<cfelse>
				<a class=calendarEvent href="index.cfm?CalAction=ViewEventDetails&EventID=#EventID#&Page=#Page##OtherAction#">
				<font class=calendarEvent>
				#PIC##timeformat(DateStarted)#</a>
				</font>...<br>
				<cfif #arguments.ShowSummary#>#EventTitle#</cfif>
			</cfif>
		</cfoutput>	
	</cffunction>
	
	<cffunction access="remote" name="DisplayMonth" output="true">
		<cfargument name="Page" default="homepage" required="true" type="string">
		<cfargument name="GoToYear" default="#year(now())#" required="false" type="numeric">
		<cfargument name="GoToMonth" default="#month(now())#" required="false" type="numeric">
		<cfargument name="ShowSummary" default="0" required="true" type="numeric">
		<cfargument name="ShowIcons" default="0" required="true" type="numeric">
		<cfargument name="BackToCalGraphic" default="" required="true" type="string">
		<cfargument name="AllowAdditions" default="0" required="true" type="numeric">
		<cfargument name="FilePath" default="" required="false" type="string">
		<cfargument name="ThisFilename" default="" required="false" type="string">
		<cfargument name="OtherAction" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
		<cfif #arguments.FilePath# neq ''>
			<cfset FilePath=#arguments.filepath#>
		<cfelse>
			<cfset FilePath="Files">
		</cfif>
		<cfif #arguments.ThisFilename# neq ''>
			<cfset ThisFilename=#arguments.ThisFilename#>
		<cfelse>
			<cfset ThisFilename="calevents">
		</cfif>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCalEvents">
			<cfinvokeargument name="ThisPath" value="#filePath#">
			<cfinvokeargument name="ThisFileName" value="#thisFilename#">
		</cfinvoke>

		<cfset Page=#Arguments.page#>
		<cfset MonthList = "January,February,March,April,May,June,July,August,September,October,November,December">
		
		<cfinvoke method="GetMonth" returnvariable="Dates">
			<cfinvokeargument name="GoToYear" value="#arguments.GoToYear#">
			<cfinvokeargument name="GoToMonth" value="#arguments.GoToMonth#">
		</cfinvoke>
		
		<cfoutput>
		<form><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="40px">&nbsp;</td>
		  <td width="*">

			<input type="hidden" name="page" value="#page#">
			<table class="calendar" cellspacing="0">
			<tr>
			<td colspan="3" style="height: 64px"><h1>#Dates.DateMonthStr# #Dates.DateYear#</h1></td>
			<td style="height: 64px"><div>
			<Cfif #Arguments.AllowAdditions#>
			<a href="index.cfm?CalAction=AddEvent&EventMonth=#Dates.DateMonth#&EventYear=#Dates.DateYear#&page=#page##OtherAction#" class=calendarAdd>Add Event</a></Cfif>
			</div></td>
			<td colspan="3" style="height: 64px">
			<div>
			<span class=caption>
			Go To: &nbsp;
			<select name="cboMonth">
			<cfset MonthNum = 0>
			<cfloop index="MonthIndex" list="#MonthList#">
			
				<cfif #MonthIndex# EQ #Dates.DateMonthStr#>
					<cfset MonthNum = #MonthNum# + 1>
					<option value="#MonthNum#" selected>#MonthIndex#</option>
				<cfelse>
					<cfset MonthNum = #MonthNum# + 1>
					<option value="#MonthNum#">#MonthIndex#</option>
				</cfif>
			
			</cfloop>
			</select>
			&nbsp;
			<select name="cboYear">
			<cfloop index="YearIndex" from="#Dates.Year10Past#" to="#Dates.Year10Fut#" step="1">
			
				<cfif #YearIndex# EQ #dates.DateYear#>
					<option value="#YearIndex#" selected>#YearIndex#</option>
				<cfelse>
					<option value="#YearIndex#">#YearIndex#</option>
				</cfif>
			
			</cfloop>
			</select>
			&nbsp;
			<input type="button" value="Go" onclick="JavaScript:gotoMonth()"></span>
			</div>
			</td>
			</tr>
			<tr class="tableheader"> 
			<th>Sunday</th>
			<th>Monday</th>
			<th>Tuesday</th>
			<th>Wednesday</th>
			<th>Thursday</th>
			<th>Friday</th>
			<th>Saturday</th>
			</tr>
			<cfif #FirstRunThrough# EQ 1>
				<tr>
				<cfswitch expression="#Dates.DayofFirst#">
				<cfcase value="Sunday">
					<cfloop index="StartDayIndex" from="1" to="7">
						<cfset DaysDate = #CreateDate(Dates.DateYear, Dates.DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 8>
				</cfcase>
				
				<cfcase value="Monday">
					<td class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="6">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 7>
				</cfcase>
				
				<cfcase value="Tuesday">
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="5">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 6>
				</cfcase>
				
				<cfcase value="Wednesday">
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="4">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 5>
				</cfcase>
				
				<cfcase value="Thursday">
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="3">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 4>
				</cfcase>
				
				<cfcase value="Friday">
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="2">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 3>
				</cfcase>
				
				<cfcase value="Saturday">
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<td  class="blank">&nbsp;</td>
					<cfloop index="StartDayIndex" from="1" to="1">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, StartDayIndex)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#StartDayIndex#<br>
						<cfelse>
							<td>#StartDayIndex#<br>
						</cfif>
						<cfset TempDate = CreateDate(#Dates.DateYear#,#Dates.DateMonth#,#StartDayIndex#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					</tr>
					<cfset StartDay = 2>
				</cfcase>
				
				</cfswitch>
			</cfif>
			<cfset NumDaysInMonth = #NumDays#>
			<cfloop index="DayIndex" from="#StartDay#" to="#NumDays#">
			<cfif #StartRow# EQ 1>
				<cfset EndMonthValue = #NumDaysInMonth# - #DayIndex#>
				<cfif #EndMonthValue# LT 7>
					<cfset LoopEndValue = #DayIndex# + #EndMonthValue#>
					<cfset FillerDays = 6 - #EndMonthValue#>
					<tr>
					<cfloop index="RemDay" from="#DayIndex#" to="#LoopEndValue#">
						<cfset DaysDate = #CreateDate(DateYear, DateMonth, RemDay)#>
						<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
							<td   class="today">#RemDay#<br>
						<cfelse>
							<td>#RemDay#<br>
						</cfif>
						<cfset TempDate = CreateDate(#DateYear#, #DateMonth#, #RemDay#)>
						<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
						<cfset qryDateEnded = #qryDateStarted#>
						<cfinvoke method="GetEvents" returnvariable="Events">
							<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						</cfinvoke>
						<cfinvoke method="DisplayDaysEvents">
							<cfinvokeargument name="TheEvents" value="#Events#">
							<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
							<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
							<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
							<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
							<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
						</cfinvoke>
						</font>
						</td>
					</cfloop>
					<cfloop index="FillDay" from="1" to="#FillerDays#">
						<td  class="blank">&nbsp;</td>
					</cfloop>
					</tr>
					<cfbreak>
				<cfelse>			
					<tr>
					<cfset DaysDate = #CreateDate(DateYear, DateMonth, DayIndex)#>
					<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
						<td   class="today">#DayIndex#<br>
					<cfelse>
						<td>#DayIndex#<br>
					</cfif>
					<cfset TempDate = CreateDate(#DateYear#, #DateMonth#, #DayIndex#)>
					<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
					<cfset qryDateEnded = #qryDateStarted#>
					<cfinvoke method="GetEvents" returnvariable="Events">
						<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
						<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
						<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
					</cfinvoke>
					<cfinvoke method="DisplayDaysEvents">
						<cfinvokeargument name="TheEvents" value="#Events#">
						<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
						<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
						<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
						<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
						<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
					</cfinvoke>
					</font>
					</td>
					<cfset StartRow = 0>
					<cfset RowIndex = 1>
				</cfif>
			<cfelse>
				<cfset DaysDate = #CreateDate(DateYear, DateMonth, DayIndex)#>
				<cfif #DateCompare(DaysDate, Now(), "d")# EQ 0>
					<td   class="today">#DayIndex#<br>
				<cfelse>
					<td>#DayIndex#<br>
				</cfif>
				<cfset TempDate = CreateDate(#DateYear#, #DateMonth#, #DayIndex#)>
				<cfset qryDateStarted = CreateODBCDate(#TempDate#)>
				<cfset qryDateEnded = #qryDateStarted#>
				<cfinvoke method="GetEvents" returnvariable="Events">
					<cfinvokeargument name="AllEvents" value="#AllCalEvents#">
					<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
					<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
				</cfinvoke>
				<cfinvoke method="DisplayDaysEvents">
					<cfinvokeargument name="TheEvents" value="#Events#">
					<cfinvokeargument name="qryDateStarted" value="#qryDateStarted#">
					<cfinvokeargument name="qryDateEnded" value="#qryDateEnded#">
					<cfinvokeargument name="ShowSummary" value="#arguments.ShowSummary#">
					<cfinvokeargument name="ShowIcons" value="#arguments.ShowIcons#">
					<cfif #OtherAction# neq ''>
							<cfinvokeargument name="OtherAction" value="#OtherAction#">
							</cfif>
				</cfinvoke>
				</font>
				</td>
				<cfset StartRow = 0>
				<cfset RowIndex = #RowIndex# + 1>
				<cfif #RowIndex# EQ 7>
					</tr>
					<cfset StartRow = 1>
				<cfelse>
				</cfif>
			</cfif>
		</cfloop>
		</table>
	
		</td>
		<td width="20px">&nbsp;</td>
		</tr></table>
		</form>
		<Cfif #Arguments.AllowAdditions#>
		<div align="CENTER"><p><b><a class=calendarAdd href="index.cfm?CalAction=AddEvent&EventMonth=#dates.DateMonth#&EventYear=#dates.DateYear#&page=#page##OtherAction#">Add Event</a></b></p></div>
		</cfif>
		<br>
		
		<script>
		function gotoMonth() {
		var theMonthList = document.forms[0].cboMonth;
		var theYearList = document.forms[0].cboYear;
		var theMonth = theMonthList.options[theMonthList.selectedIndex].value;
		var theYear = theYearList.options[theYearList.selectedIndex].value;
		theLocation = "index.cfm?page=#page#&CalAction=ViewMonth&GoToYear=" + theYear + "&GoToMonth=" + theMonth;
		window.open(theLocation, "_top", "")
		}
		</script>
		</cfoutput>
	</cffunction>
	
	<cffunction access="remote" name="GetEventDetail" returntype="query" output="true">
		<cfargument name="EventID" default=0 required="true" type="string">
		<cfargument name="FilePath" default="" required="true" type="string">
		<cfargument name="ThisFilename" default="" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theEvent">
			<cfinvokeargument name="ThisPath" value="#FilePath#">
			<cfinvokeargument name="ThisFileName" value="#ThisFilename#">
			<cfinvokeargument name="IDFieldName" value="EventID">
			<cfinvokeargument name="IDFieldValue" value="#Arguments.EventID#">
		</cfinvoke>
		<cfreturn theEvent>
	</cffunction>
	
	<cffunction access="remote" name="DisplayEventDetail" output="true">
		<cfargument name="Page" default="homepage" required="true" type="string">
		<cfargument name="EventID" default=0 required="true" type="string">
		<cfargument name="AllowAdditions" default=0 required="true" type="numeric">
		<cfargument name="FilePath" default="" required="false" type="string">
		<cfargument name="ThisFilename" default="" required="false" type="string">
		<cfargument name="OtherAction" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
		<cfif #arguments.FilePath# neq ''>
			<cfset FilePath=#arguments.filepath#>
		<cfelse>
			<cfset FilePath="Files">
		</cfif>
		<cfif #arguments.ThisFilename# neq ''>
			<cfset ThisFilename=#arguments.ThisFilename#>
		<cfelse>
			<cfset ThisFilename="calevents">
		</cfif>
		
		<cfinvoke method="GetEventDetail" returnvariable="theEvent">
			<cfinvokeargument name="EventID" value="#arguments.EventID#">
			<cfinvokeargument name="FilePath" value="#FilePath#">
			<cfinvokeargument name="ThisFilename" value="#ThisFilename#">
		</cfinvoke>
		
		<cfoutput query="theEvent">
		<script>
		function confirmDelete(delUrl) {
		  if (confirm("Are you sure you want to delete")) {
			document.location = delUrl;
		  }
		}</script>
			<br>
			<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr align="left" valign="top" bgcolor="Navy"> 
			<td colspan="2">
			<div align="center">
			<font face="Arial, Helvetica, sans-serif" size="3"><b><font color="white">Event 
			Details</font></b></font></div>
			</td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption>Title</td>
			<td class=qanswer>#Trim(EventTitle)#</td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption>Description:</td>
			<td class=qanswer>#Trim(eventdescription)#</td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption>Start:</td>
			<td class=qanswer>#DateFormat(datestarted, "dddd, d mmmm, yyyy")# #timeformat(datestarted,"hh:mm tt")#</td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption>End:</td>
			<td class=qanswer>#DateFormat(dateEnded, "dddd, d mmmm, yyyy")# #timeformat(dateEnded,"hh:mm tt")#</td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption>Coordinator:</td>
			<td class=qanswer><cfif #nickname# neq "none">#Nickname#</cfif> <cfif #Emailaddress# neq "none"><a href="mailto:#emailaddress#">#Emailaddress#</a></cfif></td>
			</tr>
			<tr align="left" valign="top"> 
			<td width="125" class=caption><img src="../images/b.gif" width=20 height=4></td>
			<td><img src="../images/b.gif" width=20 height=4></td>
			</tr>
			<tr align="left" valign="top"> 
			<td colspan="2">
			<div align="center" class=qanswer><b><br>
			<cfif #Arguments.allowadditions#>
			<a href="index.cfm?CalAction=EditEvent&EventID=#EventID#&Page=#Page##OtherAction#">Change Event</a> |
			<a href="javascript:confirmDelete('index.cfm?CalAction=DeleteEvent&EventID=#EventID#&Page=#Page##OtherAction#')">Delete Event</a> |</cfif>
			<a href="index.cfm?Page=#Page##OtherAction#">Return to Calendar</a>
			</b></div>
			</td>
			</tr>
			</table>
			</cfoutput>
	</cffunction>
	
	<cffunction access="remote" name="AddEvent" output="true">
		<cfargument name="PageName" default="homepage" required="true" type="string">
		<cfargument name="OtherAction" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
		<cfoutput>
		<cfform name="AddEvent" method="post" action="index.cfm?CalAction=ProcessAddEvent&page=#arguments.pagename##OtherAction#">
		
		<input type="hidden" name="EventStatus" value="1">
		<input type="hidden" name="EventID" value="0">
		<TABLE>
		
		
		<TR>
		<TD valign="top"> Date/Time this event starts: </TD>
		<TD>
		
			<cfinput name="DateStarted" type="text" value="#dateformat(now(),'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Date" validate="date"> <cfinput name="TimeStarted" type="text" value="#timeformat(now(),'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Time" validate="time"> (this is a 24 hour clock)
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Date/Time this event ends: </TD>
		<TD>
			<cfinput name="DateEnded" type="text" value="#dateformat(now(),'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Date" validate="date"> <cfinput name="TimeEnded" type="text" value="#timeformat(now(),'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Time" validate="time"> (this is a 24 hour clock)
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Event Title: </TD>
		<TD>
			<cfinput name="EventTitle" type="text" size="40" maxlength="100" required="yes" message="Please enter a title">
		</TD>
		<!--- field validation --->
		</TR>
	
		<TR>
		<TD valign="top"> Event Description: </TD>
		<TD>
		
			<textarea cols=40 rows=5 name="EventDescription"></textarea>
			
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Email Address of person managing this event: </TD>
		<TD>
		
			<cfinput name="EmailAddress" type="text"  size=50 maxlength=255 required="yes" message="Please enter an email address">
			
		</TD>
		<!--- field validation --->
		</TR>
		
			<tr>
		<td valign=top> Name of person managing this event</td>
		<td><cfinput name="nickname" type="text"  required="yes" message="Please enter a name"></td>
		</tr>


		<tr> 
		<td colspan="2"><br>
		<div align="center"><input type="submit" name="Submit" value="Add Event"></div>
		</td>
		</tr>
		</table>
		</cfform>
		</cfoutput>
	</cffunction>
	
	<cffunction name="UpdateEvent" access="remote" output="true">
		<cfargument name="PageName" type='string' required="true" default="">
		<cfargument name="EventID" type='string' required="true" default="">
		<cfargument name="XMLFields" type='string' required="true" default="">
		<cfargument name="XMLFieldData" type='string' required="true" default="">
		<cfargument name="OtherAction" default="" required="false" type="string">
		<cfargument name="FilePath" default="" required="false" type="string">
		<cfargument name="ThisFilename" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
		<cfif #arguments.FilePath# neq ''>
			<cfset FilePath=#arguments.filepath#>
		<cfelse>
			<cfset FilePath="Files">
		</cfif>
		<cfif #arguments.ThisFilename# neq ''>
			<cfset ThisFilename=#arguments.ThisFilename#>
		<cfelse>
			<cfset ThisFilename="calevents">
		</cfif>
		
		<cfif EventID gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="#filePath#">
				<cfinvokeargument name="ThisFileName" value="#thisFileName#">
				<cfinvokeargument name="XMLFields" value="#arguments.XMLFields#">
				<cfinvokeargument name="XMLFieldData" value="#arguments.XMLFieldData#">
				<cfinvokeargument name="XMLIDField" value="EventID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.EventID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
				<cfinvokeargument name="ThisPath" value="#filePath#">
				<cfinvokeargument name="ThisFileName" value="#thisFileName#">
				<cfinvokeargument name="XMLFields" value="#arguments.XMLFields#">
				<cfinvokeargument name="XMLFieldData" value="#arguments.XMLFieldData#">
				<cfinvokeargument name="XMLIDField" value="EventID">
			</cfinvoke>
		</cfif>
	</cffunction>
	
	<cffunction access="remote" name="EditEvent" output="true">
		<cfargument name="PageName" default="homepage" required="true" type="string">
		<cfargument name="EventID" default="0" required="true" type="string">
		<cfargument name="OtherAction" default="" required="false" type="string">
		<cfargument name="FilePath" default="" required="false" type="string">
		<cfargument name="ThisFilename" default="" required="false" type="string">
		
		<cfset OtherAction=#arguments.OtherAction#>
		<cfif #arguments.FilePath# neq ''>
			<cfset FilePath=#arguments.filepath#>
		<cfelse>
			<cfset FilePath="Files">
		</cfif>
		<cfif #arguments.ThisFilename# neq ''>
			<cfset ThisFilename=#arguments.ThisFilename#>
		<cfelse>
			<cfset ThisFilename="calevents">
		</cfif>
		
		<cfinvoke method="GetEventDetail" returnvariable="theEvent">
			<cfinvokeargument name="EventID" value="#arguments.EventID#">
			<cfinvokeargument name="FilePath" value="#FilePath#">
			<cfinvokeargument name="ThisFilename" value="#ThisFilename#">
		</cfinvoke>
		
		<cfoutput query="TheEvent">
		<cfform name="AddEvent" method="post" action="index.cfm?CalAction=ProcessEditEvent&page=#arguments.pagename##OtherAction#">

		<input type="hidden" name="EventStatus" value="#EventStatus#">
		<input type="hidden" name="EventID" value="#Arguments.eventid#">
		<TABLE>
		
		
		<TR>
		<TD valign="top"> Date/Time this event starts: </TD>
		<TD>
		
			<cfinput name="DateStarted" type="text" value="#dateformat(DateStarted,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Date" validate="date"> <cfinput name="TimeStarted" type="text" value="#timeformat(DateStarted,'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Starting Time" validate="time"> (this is a 24 hour clock)
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Date/Time this event ends: </TD>
		<TD>
			<cfinput name="DateEnded" type="text" value="#dateformat(DateEnded,'mm/dd/yyyy')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Date" validate="date"> <cfinput name="TimeEnded" type="text" value="#timeformat(DateEnded,'HH:mm')#" size="10" maxlength="15" required="yes" message="Please enter the Ending Time" validate="time"> (this is a 24 hour clock)
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Event Title: </TD>
		<TD>
			<cfinput name="EventTitle" type="text" size="40" maxlength="100" required="yes" message="Please enter a title" value="#EventTitle#">
		</TD>
		<!--- field validation --->
		</TR>
	
		<TR>
		<TD valign="top"> Event Description: </TD>
		<TD>
		
			<textarea cols=40 rows=5 name="EventDescription">#EventDescription#</textarea>
			
		</TD>
		<!--- field validation --->
		</TR>
		
		<TR>
		<TD valign="top"> Email Address of person managing this event: </TD>
		<TD>
		
			<cfinput name="EmailAddress" type="text"  size=50 maxlength=255 required="yes" message="Please enter an email address" value="#EmailAddress#">
			
		</TD>
		<!--- field validation --->
		</TR>
		
			<tr>
		<td valign=top> Name of person managing this event</td>
		<td><cfinput name="nickname" type="text"  required="yes" message="Please enter a name" value="#nickname#"></td>
		</tr>


		<tr> 
		<td colspan="2"><br>
		<div align="center"><input type="submit" name="Submit" value="Save Changes"></div>
		</td>
		</tr>
		</table>
		</cfform>
		</cfoutput>
	</cffunction>

	<cffunction name="DeleteEvent" access="remote" output="false">
		<cfargument name="PageName" default="homepage" required="true" type="string">
		<cfargument name="EventID" default="0" required="true" type="string">
		<cfargument name="OtherAction" default="" required="false" type="string">
		<cfargument name="FilePath" default="" required="false" type="string">
		<cfargument name="ThisFilename" default="" required="false" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="#arguments.filepath#">
			<cfinvokeargument name="ThisFileName" value="#arguments.thisfilename#">
			<cfinvokeargument name="XMLFields" value="EventID,DateStarted,nickname,EventDescription,DateEnded,EmailAddress,EventTitle,EventStatus">
			<cfinvokeargument name="XMLIDField" value="EventID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EventID#">
		</cfinvoke>
		
	</cffunction>
</cfcomponent>