<cfcomponent>
	<cffunction access="remote" name="getBandwidth" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfset today=now()>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(Today)#
			TheWeek=#Week(Today)#>
		<cfset WeekStartDate=#dateformat(TheWeekStart,"yyyy/mm/dd")#>
		<cfset WeekEndDate=#dateformat(TheWeekEnd,"yyyy/mm/dd")#>
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="bandwidthControl">
				<cfinvokeargument name="selectSTatement" value=" where customerID='#arguments.CustomerID#' and theDate>='#WeekStartDate#' and theDate<='#WeekEndDate#'">
		</cfinvoke>
		<cfset weekend=dateformat(#weekenddate#,"dddd, mmmm dd, yyyy")>
		
		<cfset tBandwidth=QueryNew("ID,Event,attendeeType,theDate,Start,End,Bandwidth,weekend")>
		<cfloop query="results">
			<cfinvoke component="#application.websitepath#.XMLHandler"
				method="getXMLRecords" returnvariable="events">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where eventID='#results.theEvent#'">
			</cfinvoke>
			<cfif endtime lt starttime>
				<cfset newendtime=dateadd("h",12,#endtime#)>
				<Cfset newendtime=timeformat(newendtime,"HH:mm:ss")>
			<cfelse>
				<cfset newendtime=endtime>
			</cfif>
			<cfif #attendeetype# is "mod">
				<cfset usertype="moderator">
			<cfelse>
				<cfset usertype="visitor">
			</cfif>
			<cfset minutes=datediff("n",starttime,newendtime)>
			<cfset bandwidth=minutes * .05>
			<CFSET newRow  = QueryAddRow(tBandwidth, 1)>
			<CFSET temp = QuerySetCell(tBandwidth, "ID","#results.ControlID#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Event","#events.EventTitle#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "attendeeType","#usertype#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "theDate","#dateformat(results.theDate,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Start","#results.startTime#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "End","#newendtime#", #newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "Bandwidth","#bandwidth#",#newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "weekend","#weekend#",#newRow#)>
		</cfloop>
		
		<cfif #results.recordcount# gt 0>
			<cfreturn tBandwidth>
		<cfelse>
			<CFSET newRow  = QueryAddRow(tBandwidth, 1)>
			<CFSET temp = QuerySetCell(tBandwidth, "ID","0000000000", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Event","no results", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "attendeeType","none", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "theDate","#dateformat(today,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Start","00:00:00", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "End","00:00:00", #newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "Bandwidth","0",#newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "weekend","#weekend#",#newRow#)>
			<cfreturn tBandwidth>
		</cfif>
		
	</cffunction>
	
	<cffunction access="remote" name="getAssocBandwidth" output="true" returntype="query">
		<cfargument name="AssociateID" required="true" type="string">
		
		<cfset today=now()>
		<cf_AnyYearWeekStartEnd
			TheYear=#year(Today)#
			TheWeek=#Week(Today)#>
		<cfset WeekStartDate=#dateformat(TheWeekStart,"yyyy/mm/dd")#>
		<cfset WeekEndDate=#dateformat(TheWeekEnd,"yyyy/mm/dd")#>
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="bandwidthControl">
				<cfinvokeargument name="selectSTatement" value=" where AssociateID='#arguments.AssociateID#' and theDate>='#WeekStartDate#' and theDate<='#WeekEndDate#'">
		</cfinvoke>
		<cfset weekend=dateformat(#weekenddate#,"dddd, mmmm dd, yyyy")>
		
		<cfset tBandwidth=QueryNew("ID,Event,attendeeType,theDate,Start,End,Bandwidth,weekend")>
		<cfloop query="results">
			<cfinvoke component="#application.websitepath#.XMLHandler"
				method="getXMLRecords" returnvariable="events">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where eventID='#results.theEvent#'">
			</cfinvoke>
			<cfif endtime lt starttime>
				<cfset newendtime=dateadd("h",12,#endtime#)>
				<Cfset newendtime=timeformat(newendtime,"HH:mm:ss")>
			<cfelse>
				<cfset newendtime=endtime>
			</cfif>
			<cfif #attendeetype# is "mod">
				<cfset usertype="moderator">
			<cfelse>
				<cfset usertype="visitor">
			</cfif>
			<cfset minutes=datediff("n",starttime,newendtime)>
			<cfset bandwidth=minutes * .05>
			<CFSET newRow  = QueryAddRow(tBandwidth, 1)>
			<CFSET temp = QuerySetCell(tBandwidth, "ID","#results.ControlID#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Event","#events.EventTitle#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "attendeeType","#usertype#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "theDate","#dateformat(results.theDate,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Start","#results.startTime#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "End","#newendtime#", #newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "Bandwidth","#bandwidth#",#newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "weekend","#weekend#",#newRow#)>
		</cfloop>
		
		<cfif #results.recordcount# gt 0>
			<cfreturn tBandwidth>
		<cfelse>
			<CFSET newRow  = QueryAddRow(tBandwidth, 1)>
			<CFSET temp = QuerySetCell(tBandwidth, "ID","0000000000", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Event","no results", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "attendeeType","none", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "theDate","#dateformat(today,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "Start","00:00:00", #newRow#)>
			<CFSET temp = QuerySetCell(tBandwidth, "End","00:00:00", #newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "Bandwidth","0",#newRow#)>
			<cfset temp = QuerySetCell(tBandwidth, "weekend","#weekend#",#newRow#)>
			<cfreturn tBandwidth>
		</cfif>
		
	</cffunction>
	
	<cffunction access="remote" name="deleteBandwidth" output="true">
		<cfargument name="ControlID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.XMLhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="bandwidthControl">
			<cfinvokeargument name="XMLFields" value="ControlID,CustomerID,TheDate,TheBandwidth,AttendeeType,TheEvent,startTime,EndTime,AssociateID">
			<cfinvokeargument name="XMLIDField" value="ControlID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.ControlID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction access="remote" name="getOldBandwidth" output="true" returntype="query">
		<cfargument name="Today" required="true" type="string">
		<cfargument name="OrderBy" required="true" type="string">
		
		<cf_AnyYearWeekStartEnd
			TheYear=#year(arguments.Today)#
			TheWeek=#Week(arguments.Today)#>
		<cfset WeekStartDate=#dateformat(TheWeekStart,"yyyy/mm/dd")#>
		<cfset WeekEndDate=#dateformat(TheWeekEnd,"yyyy/mm/dd")#>
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="bandwidthControl">
			<cfinvokeargument name="selectSTatement" 
				value=" where theDate>='#WeekStartDate#' and theDate<='#WeekEndDate#'">
			<cfinvokeargument name="OrderByStatement" value=" order by #arguments.OrderBy#">
		</cfinvoke>
		<cfreturn results>
	</cffunction>
	
	<!--- FilesSvc.saveBandwidth(ControlID,CustomerID,Bandwidth,AttendeeType,EventID)
	Application= chat, conference, presentation, training or advertisement
	ControlID default should be  "0000000000" if this is the first time saving bandwidth for this event
	the function will return the ControlID to Flash which you can use again if you need to update 
	the bandwidth for this event. --->
	<cffunction name="saveBandwidth" access="remote" returntype="string" output="true">
		<cfargument name="ControlID" required="true" type="string">
		<cfargument name="CustomerID" required="true" type="string">
		<cfargument name="TheBandwidth" required="true" type="string">
		<cfargument name="AttendeeType" required="true" type="string">
		<cfargument name="TheEvent" required="true" type="string">
		<cfargument name="AssociateID" required="true" type="string" default="0000000000">
		
		<cfset xFields="CustomerID,TheDate,TheBandwidth,AttendeeType,TheEvent,startTime,EndTime,AssociateID">
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="bandwidthControl">
			<cfinvokeargument name="selectStatement" value=" where ControlID='#arguments.ControlID#'">
		</cfinvoke>
		
		<cfset Today=#dateformat(now(),"yyyy/mm/dd")#>
		<cfset StartTime=#timeformat(now(),"hh:mm:ss")#>
		<cfset EndTime=#timeformat(now(),"hh:mm:ss")#>
		
		<cfif #records.recordcount# is 1>
			<cfset ControlID=#records.ControlID#>
			<cfset xData="#records.CustomerID#,#records.TheDate#,#arguments.TheBandwidth#,#records.AttendeeType#,#records.TheEvent#,#records.StartTime#,#EndTime#,#records.associateID#">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="bandwidthControl">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ControlID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.ControlID#">
			</cfinvoke>
			<cfreturn ControlID>
		<cfelse>
			<cfset xData="#arguments.CustomerID#,#Today#,#arguments.TheBandwidth#,#arguments.AttendeeType#,#arguments.TheEvent#,#StartTime#,#EndTime#,#arguments.associateID#">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="ControlID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="bandwidthControl">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ControlID">
			</cfinvoke>
			<cfreturn ControlID>
		</cfif>
	</cffunction>

	<cffunction name="getBasicChatConfig" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicChat">
			<cfinvokeargument name="selectStatement" value=" where CustomerID='#arguments.CustomerID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="saveBasicChat" access="remote" output="true" returntype="string">
		<cfargument name="ConfigID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="allowPrivateChat" type="string" required="true">
		<cfargument name="allowWhiteBoardChat" type="string" required="true">
		<cfargument name="allowAssociateChat" type="string" required="true">
		<cfargument name="recordAssociateChat" type="string" required="true">
		<cfargument name="recordCustomerChat" type="string" required="true">
		<cfargument name="AssociatesPerMinuteCharge" type="string" required="true">
		<cfargument name="associatesMonthlyMinuteLimit" type="string" required="true">
		<cfargument name="billingStartDay" type="string" required="true">
		<cfargument name="billingEndDay" type="string" required="true">
		<cfargument name="recordedChatDays" type="string" required="true">
		
		<cfset xFields="CustomerID,allowPrivateChat,allowWhiteBoardChat,allowAssociateChat,recordAssociateChat,recordCustomerChat,AssociatesPerMinuteCharge,associatesMonthlyMinuteLimit,billingStartDay,billingEndDay,recordedChatDays">
		<cfset xData="#arguments.CustomerID#,#arguments.allowPrivateChat#,#arguments.allowWhiteBoardChat#,#arguments.allowAssociateChat#,#arguments.recordAssociateChat#,#arguments.recordCustomerChat#,#arguments.AssociatesPerMinuteCharge#,#arguments.associatesMonthlyMinuteLimit#,#arguments.billingStartDay#,#arguments.billingEndDay#,#arguments.recordedChatDays#">
		
		<cfset ConfigID=#arguments.ConfigID#>
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicChat">
			<cfinvokeargument name="selectStatement" value=" where ConfigID='#arguments.ConfigID#'">
		</cfinvoke>
		
		<cfif #ConfigID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="basicChat">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="#records.ConfigID#">
			</cfinvoke>
			<cfreturn ConfigID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="basicChat">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
			<cfreturn ConfigID>
		</cfif>
		
	</cffunction>
	
	<cffunction name="getBasicConferenceConfig" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicConference">
			<cfinvokeargument name="selectStatement" value=" where CustomerID='#arguments.CustomerID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="saveBasicConference" access="remote" output="true" returntype="string">
		<cfargument name="ConfigID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="allowPrivateChat" type="string" required="true">
		<cfargument name="allowWhiteBoardChat" type="string" required="true">
		<cfargument name="allowAssociateChat" type="string" required="true">
		<cfargument name="recordAssociateChat" type="string" required="true">
		<cfargument name="recordCustomerChat" type="string" required="true">
		<cfargument name="AssociatesPerMinuteCharge" type="string" required="true">
		<cfargument name="associatesMonthlyMinuteLimit" type="string" required="true">
		<cfargument name="billingStartDay" type="string" required="true">
		<cfargument name="billingEndDay" type="string" required="true">
		<cfargument name="recordedChatDays" type="string" required="true">
		
		<cfset xFields="CustomerID,allowPrivateChat,allowWhiteBoardChat,allowAssociateChat,recordAssociateChat,recordCustomerChat,AssociatesPerMinuteCharge,associatesMonthlyMinuteLimit,billingStartDay,billingEndDay,recordedChatDays">
		<cfset xData="#arguments.CustomerID#,#arguments.allowPrivateChat#,#arguments.allowWhiteBoardChat#,#arguments.allowAssociateChat#,#arguments.recordAssociateChat#,#arguments.recordCustomerChat#,#arguments.AssociatesPerMinuteCharge#,#arguments.associatesMonthlyMinuteLimit#,#arguments.billingStartDay#,#arguments.billingEndDay#,#arguments.recordedChatDays#">
		
		<cfset ConfigID=#arguments.ConfigID#>
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicConference">
			<cfinvokeargument name="selectStatement" value=" where ConfigID='#arguments.ConfigID#'">
		</cfinvoke>
		
		<cfif #ConfigID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="basicConference">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="#records.ConfigID#">
			</cfinvoke>
			<cfreturn ConfigID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="basicConference">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
			<cfreturn ConfigID>
		</cfif>
		
	</cffunction>
	
	<cffunction name="getBasicPresentationConfig" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicConference">
			<cfinvokeargument name="selectStatement" value=" where CustomerID='#arguments.CustomerID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="saveBasicPresentation" access="remote" output="true" returntype="string">
		<cfargument name="ConfigID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="allowAssociateChat" type="string" required="true">
		<cfargument name="recordAssociateChat" type="string" required="true">
		<cfargument name="recordCustomerChat" type="string" required="true">
		<cfargument name="AssociatesPerMinuteCharge" type="string" required="true">
		<cfargument name="associatesMonthlyMinuteLimit" type="string" required="true">
		<cfargument name="billingStartDay" type="string" required="true">
		<cfargument name="billingEndDay" type="string" required="true">
		<cfargument name="recordedChatDays" type="string" required="true">
		
		<cfset xFields="CustomerID,allowAssociateChat,recordAssociateChat,recordCustomerChat,AssociatesPerMinuteCharge,associatesMonthlyMinuteLimit,billingStartDay,billingEndDay,recordedChatDays">
		<cfset xData="#arguments.CustomerID#,#arguments.allowAssociateChat#,#arguments.recordAssociateChat#,#arguments.recordCustomerChat#,#arguments.AssociatesPerMinuteCharge#,#arguments.associatesMonthlyMinuteLimit#,#arguments.billingStartDay#,#arguments.billingEndDay#,#arguments.recordedChatDays#">
		
		<cfset ConfigID=#arguments.ConfigID#>
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicPresentation">
			<cfinvokeargument name="selectStatement" value=" where ConfigID='#arguments.ConfigID#'">
		</cfinvoke>
		
		<cfif #ConfigID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="basicPresentation">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="#records.ConfigID#">
			</cfinvoke>
			<cfreturn ConfigID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="basicPresentation">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
			<cfreturn ConfigID>
		</cfif>
		
	</cffunction>
	
	<cffunction name="GetBasicTrainingConfig" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="basicTraining">
			<cfinvokeargument name="selectSTatement" value=" where customerID='#arguments.CustomerID#'">
		</cfinvoke>
		
		<cfreturn results>
	</cffunction>
	
	<cffunction name="saveCustomer" access="remote" output="true" returntype="string">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="companyName" type="string" required="true">
		<cfargument name="firstName" type="string" required="true">
		<cfargument name="lastName" type="string" required="true">
		<cfargument name="address1" type="string" required="true">
		<cfargument name="address2" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="zip" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="fax" type="string" required="true">
		<cfargument name="cell" type="string" required="true">
		<cfargument name="IPAddress" type="string" required="true">
		<cfargument name="url" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="tPassword" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="status" type="string" required="false" default="Active">
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="customers">
			<cfinvokeargument name="selectStatement" value=" where CustomerID='#arguments.CustomerID#'">
		</cfinvoke>
		<cfif #arguments.CustomerID# is "0000000000">
			<cfset Status="Active">
			<cfset Today=now()>
		<cfelse>
			<cfset Status=#records.status#>
			<cfset Today=#records.DateSTarted#>
		</cfif>
		<cfset xFields="companyName,firstName,lastName,address1,address2,city,state,zip,country,phone,fax,cell,IPAddress,url,username,tPassword,DateStarted,Status,emailaddress">
		<cfset xData="#replace(arguments.companyName,',','~','ALL')# ,#replace(arguments.firstName,',','~','ALL')# ,#replace(arguments.lastName,',','~','ALL')# ,#replace(arguments.address1,',','~','ALL')# ,#replace(arguments.address2,',','~','ALL')# ,#replace(arguments.city,',','~','ALL')# ,#replace(arguments.state,',','~','ALL')# ,#arguments.zip# ,#replace(arguments.country,',','~','ALL')# ,#arguments.phone# ,#arguments.fax# ,#arguments.cell# ,#arguments.IPAddress# ,#replace(arguments.url,',','~','ALL')# ,#replace(arguments.username,',','~','ALL')# ,#replace(arguments.tPassword,',','~','ALL')# ,#Status# ,#dateformat(today,'yyyy/mm/dd')# ,#replace(arguments.emailaddress,',','~','ALL')# ">
		
		<cfset CustomerID=#arguments.CustomerID#>
		
		<cfif #CustomerID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="Customers">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="CustomerID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.CustomerID#">
			</cfinvoke>
			<cfreturn CustomerID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="CustomerID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="Customers">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="CustomerID">
			</cfinvoke>
			<cfreturn CustomerID>
		</cfif>
		
	</cffunction>
	
	<cffunction name="GetCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="Customers">
			<cfinvokeargument name="selectSTatement" value=" where customerID='#arguments.CustomerID#'">
		</cfinvoke>
		
		<cfreturn results>
	</cffunction>
	
	<cffunction name="deleteAssociate" access="remote" output="true" returntype="boolean">
		<cfargument name="AssociateID" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.XMLhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="Associates">
			<cfinvokeargument name="XMLFields" value="AssociateID,CustomerID,companyName,firstName,lastName,address1,address2,city,state,zip,country,phone,fax,cell,username,tPassword,emailaddress,cccompanyName,ccfirstName,cclastName,ccaddress1,ccaddress2,cccity,ccstate,cczip,cccountry,ccName,ccType,ccNumber,ccExpire,ccCVV,status,dateCreated">
			<cfinvokeargument name="XMLIDField" value="AssociateID">
			<cfinvokeargument name="XMLIDValue" value="#AssociateID#">
		</cfinvoke>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="getAssociatesByCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="associates">
			<cfinvokeargument name="selectStatement" 
				value=" where customerID='#arguments.customerID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="notApprovedAssociatesByCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="associates">
			<cfinvokeargument name="selectStatement" 
				value=" where customerID='#arguments.customerID#' and status <> 'Active'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="getAssociateDetails" access="remote" output="true" returntype="query">
		<cfargument name="AssociateID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="associates">
			<cfinvokeargument name="selectStatement" 
				value=" where AssociateID='#arguments.AssociateID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="getAssociate" access="remote" output="true" returntype="query">
		<cfargument name="AssociateID" type="string" required="true">
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="associates">
			<cfinvokeargument name="selectStatement" 
				value=" where AssociateID='#arguments.AssociateID#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>
	
	<cffunction name="saveAssociate" access="remote" output="true" returntype="string">
		<cfargument name="AssociateID" type="string" required="true" default="0000000000">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="companyName" type="string" required="true">
		<cfargument name="firstName" type="string" required="true">
		<cfargument name="lastName" type="string" required="true">
		<cfargument name="address1" type="string" required="true">
		<cfargument name="address2" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="zip" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="fax" type="string" required="true">
		<cfargument name="cell" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="tPassword" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="ccaddress1" type="string" required="true">
		<cfargument name="ccaddress2" type="string" required="true">
		<cfargument name="cccity" type="string" required="true">
		<cfargument name="ccstate" type="string" required="true">
		<cfargument name="cczip" type="string" required="true">
		<cfargument name="cccountry" type="string" required="true">
		<cfargument name="ccName" type="string" required="true">
		<cfargument name="ccType" type="string" required="true">
		<cfargument name="ccNumber" type="string" required="false" default=" ">
		<cfargument name="ccExpire" type="string" required="true">
		<cfargument name="ccCVV" type="string" required="true">
		<cfargument name="status" type="string" required="false" default="Active">
		
		<cfif #arguments.associateID# is "0000000000">
			<cfset Status="Active">
			<cfset Today=now()>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler"
				method="getXMLrecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="associates">
				<cfinvokeargument name="selectStatement" 
					value=" where associateID='#arguments.associateID#'">
			</cfinvoke>
			<cfset Status=#records.status#>
			<cfset Today=#records.DateCreated#>
		</cfif>
		<cfset xFields="CustomerID,companyName,firstName,lastName,address1,address2,city,state,zip,country,phone,fax,cell,username,tPassword,emailaddress,ccaddress1,ccaddress2,cccity,ccstate,cczip,cccountry,ccName,ccType,ccNumber,ccExpire,ccCVV,status,dateCreated">
		<cfset xData="#arguments.CustomerID#,#replace(arguments.companyName,',','~','ALL')# ,#replace(arguments.firstName,',','~','ALL')# ,#replace(arguments.lastName,',','~','ALL')# ,#replace(arguments.address1,',','~','ALL')# ,#replace(arguments.address2,',','~','ALL')# ,#replace(arguments.city,',','~','ALL')# ,#replace(arguments.state,',','~','ALL')# ,#arguments.zip# ,#replace(arguments.country,',','~','ALL')# ,#arguments.phone# ,#arguments.fax# ,#arguments.cell# ,#replace(arguments.username,',','~','ALL')# ,#replace(arguments.tPassword,',','~','ALL')# ,#replace(arguments.emailaddress,',','~','ALL')# ,#arguments.ccaddress1# ,#arguments.ccaddress2# ,#arguments.cccity# ,#arguments.ccstate# ,#arguments.cczip# ,#arguments.cccountry# ,#arguments.ccName# ,#arguments.ccType# ,#arguments.ccNumber# ,#arguments.ccExpire# ,#arguments.ccCVV# ,#Status# ,#dateformat(today,'yyyy/mm/dd')#">
		
		<cfset associateID=#arguments.associateID#>
		
		<cfif #associateID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="Associates">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="associateID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.associateID#">
			</cfinvoke>
			<cfreturn associateID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="associateID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="Associates">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="associateID">
			</cfinvoke>
			<cfreturn associateID>
		</cfif>
	</cffunction>

	<cffunction name="saveEvent" access="remote" output="true" returntype="string">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		<cfargument name="eventTitle" type="string" required="true">
		<cfargument name="eventSummary" type="string" required="true">
		<cfargument name="moderatorName" type="string" required="true">
		<cfargument name="EventType" type="string" required="true">
		<cfargument name="EventDate" type="string" required="true">
		<cfargument name="EventDuration" type="string" required="true">
		<cfargument name="recordChat" type="string" required="true">
		<cfargument name="allowWhiteboard" type="string" required="true">
		<cfargument name="allowPrivate" type="string" required="true">
		<cfargument name="chatType" type="string" required="true">
		<cfargument name="billingType" type="string" required="true">
		<cfargument name="registrationAmount" type="string" required="true">
		<cfargument name="recordingCharge" type="string" required="true">
		<cfargument name="archiveDays" type="string" required="true">
		<cfargument name="billingPer" type="string" required="true">
		<cfargument name="freePassCode" type="string" required="true">
		<cfargument name="status" type="string" required="false" default="Normal">
		<cfargument name="AssociateID" type="string" required="false" default="0000000000">
		
		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLrecords" returnvariable="records">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="events">
			<cfinvokeargument name="selectStatement" value=" where EventID='#arguments.EventID#'">
		</cfinvoke>
		<cfif #arguments.EventID# is "0000000000">
			<cfset Status="Normal">
			<cfset Today=now()>
		<cfelse>
			<cfset Status=#records.status#>
			<cfset Today=#records.dateCreated#>
		</cfif>
		
		<cfset arguments.EventSummary=replace(#arguments.EventSummary#,",","~","ALL")>
		<cfset arguments.moderatorName=replace(#arguments.moderatorName#,",","~","ALL")>
		<cfset arguments.EventTitle=replace(#arguments.EventTitle#,",","~","ALL")>
		
		<cfset xFields="CustomerID,EventType,EventDate,EventDuration,recordChat,allowWhiteboard,allowPrivate,chatType,billingType,registrationAmount,recordingCharge,archiveDays,billingPer,freePassCode,status,DateCreated,moderatorName,EventTitle,EventDesc,AssociateID">
		<cfset xData="#arguments.CustomerID#,#arguments.EventType#,#dateformat(arguments.EventDate,'yyyy/mm/dd')#,#arguments.EventDuration#,#arguments.recordChat#,#arguments.allowWhiteboard#,#arguments.allowPrivate#,#arguments.chatType#,#arguments.billingType#,#arguments.registrationAmount#,#arguments.recordingCharge#,#arguments.archiveDays#,#arguments.billingPer#,#arguments.freePassCode#,#arguments.status#,#dateformat(Today,'yyyy/mm/dd')#,#arguments.moderatorName#,#arguments.EventTitle#,#arguments.EventSummary#,#arguments.associateID#">
		
		<cfset EventID=#arguments.EventID#>
		
		<cfif #EventID# neq "0000000000">
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="EventID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.EventID#">
			</cfinvoke>
			<cfreturn EventID>
		<cfelse>
			<cfinvoke component="#application.websitepath#.XMLHandler" 
				method="insertXMLrecord" returnvariable="EventID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="EventID">
			</cfinvoke>
			<cfreturn EventID>
		</cfif>
		
	</cffunction>
	
	<cffunction access="remote" name="getEventDetails" output="true" returntype="query">
		<cfargument name="EventID" required="true" type="string">

		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where eventid='#arguments.eventid#'">
		</cfinvoke>
		
		<cfset Event=QueryNew("EventID,CustomerID,EventType,EventDate,EventDuration,recordChat,allowWhiteboard,allowPrivate,chatType,billingType,registrationAmount,recordingCharge,archiveDays,billingPer,freePassCode,status,DateCreated,moderatorName,EventTitle,EventDesc,AssociateID")>
		<cfif results.recordcount gt 0>
		<CFSET newRow  = QueryAddRow(Event, 1)>
		<CFSET temp = QuerySetCell(Event, "EventID","#results.EventID#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "CustomerID","#results.CustomerID#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventType","#results.EventType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventDate","#results.EventDate#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventDuration","#results.EventDuration#", #newRow#)>
		<cfset temp = QuerySetCell(Event, "recordChat","#results.recordChat#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "allowWhiteboard","#results.allowWhiteboard#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "allowPrivate","#results.allowPrivate#",#newRow#)>
		<CFSET temp = QuerySetCell(Event, "chatType","#results.chatType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "billingType","#results.billingType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "registrationAmount","#results.registrationAmount#", #newRow#)>
		<cfset temp = QuerySetCell(Event, "recordingCharge","#results.recordingCharge#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "archiveDays","#results.archiveDays#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "billingPer","#results.billingPer#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "freePassCode","#results.freePassCode#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "status","#results.status#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "DateCreated","#dateformat(results.DateCreated,'mm/dd/yyyy')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "moderatorName","#replace(results.moderatorName,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "EventTitle","#replace(results.EventTitle,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "EventDesc","#replace(results.EventDesc,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "AssociateID","#results.AssociateID#",#newRow#)>
		<cfreturn Event>
		</cfif>
	</cffunction>
	
	<cffunction access="remote" name="getEvent" output="true" returntype="query">
		<cfargument name="EventID" required="true" type="string">

		<cfinvoke component="#application.websitepath#.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where eventid='#arguments.eventid#'">
		</cfinvoke>
		
		<cfset Event=QueryNew("EventID,CustomerID,EventType,EventMonth,EventDay,EventYear,EventDuration,recordChat,allowWhiteboard,allowPrivate,chatType,billingType,registrationAmount,recordingCharge,archiveDays,billingPer,freePassCode,status,DateCreated,moderatorName,EventTitle,EventDesc,AssociateID")>
		<cfif results.recordcount gt 0>
		<CFSET newRow  = QueryAddRow(Event, 1)>
		<CFSET temp = QuerySetCell(Event, "EventID","#results.EventID#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "CustomerID","#results.CustomerID#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventType","#results.EventType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventMonth","#month(results.EventDate)#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventDay","#day(results.EventDate)#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventYear","#year(results.EventDate)#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "EventDuration","#results.EventDuration#", #newRow#)>
		<cfset temp = QuerySetCell(Event, "recordChat","#results.recordChat#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "allowWhiteboard","#results.allowWhiteboard#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "allowPrivate","#results.allowPrivate#",#newRow#)>
		<CFSET temp = QuerySetCell(Event, "chatType","#results.chatType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "billingType","#results.billingType#", #newRow#)>
		<CFSET temp = QuerySetCell(Event, "registrationAmount","#results.registrationAmount#", #newRow#)>
		<cfset temp = QuerySetCell(Event, "recordingCharge","#results.recordingCharge#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "archiveDays","#results.archiveDays#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "billingPer","#results.billingPer#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "freePassCode","#results.freePassCode#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "status","#results.status#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "DateCreated","#dateformat(results.DateCreated,'mm/dd/yyyy')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "moderatorName","#replace(results.moderatorName,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "EventTitle","#replace(results.EventTitle,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "EventDesc","#replace(results.EventDesc,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(Event, "AssociateID","#results.AssociateID#",#newRow#)>
		<cfreturn Event>
		</cfif>
	</cffunction>
	
	<cffunction access="remote" name="getAllEvents" output="true" returntype="query">
		<cfargument name="CustomerID" default="0000000000" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfif #arguments.Customerid# neq "0000000000">
					<cfinvokeargument name="selectStatement" 
						value=" where customerid='#arguments.customerid#'">
				</cfif>
		</cfinvoke>
		
		<cfset events=QueryNew("EventID,EventType,EventDate,moderatorName,EventTitle,registrationAmount,AssociateID")>
		<cfoutput query="results">
			<CFSET newRow  = QueryAddRow(events, 1)>
			<CFSET temp = QuerySetCell(events, "EventID","#results.EventID#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventType","#results.EventType#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventDate","#dateformat(results.EventDate,'mm/dd/yyyy')#", #newRow#)>
			<cfset temp = QuerySetCell(events, "moderatorName","#replace(results.moderatorName,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "EventTitle","#replace(results.EventTitle,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "registrationAmount","#dollarformat(results.registrationAmount)#",#newRow#)>
			<cfset temp = QuerySetCell(events, "AssociateID","#results.AssociateID#",#newRow#)>
		</cfoutput>
		<cfreturn events>
		
	</cffunction>
	
	<cffunction access="remote" name="getAssocEvents" output="true" returntype="query">
		<cfargument name="AssociateID" default="0000000000" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectStatement" 
					value=" where AssociateID='#arguments.AssociateID#'">
		</cfinvoke>
		
		<cfset events=QueryNew("EventID,EventType,EventDate,moderatorName,EventTitle,registrationAmount,AssociateID")>
		<cfoutput query="results">
			<CFSET newRow  = QueryAddRow(events, 1)>
			<CFSET temp = QuerySetCell(events, "EventID","#results.EventID#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventType","#results.EventType#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventDate","#dateformat(results.EventDate,'mm/dd/yyyy')#", #newRow#)>
			<cfset temp = QuerySetCell(events, "moderatorName","#replace(results.moderatorName,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "EventTitle","#replace(results.EventTitle,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "registrationAmount","#dollarformat(results.registrationAmount)#",#newRow#)>
			<cfset temp = QuerySetCell(events, "AssociateID","#results.AssociateID#",#newRow#)>
		</cfoutput>
		<cfreturn events>
		
	</cffunction>
	
	<cffunction access="remote" name="getAllAttendeesByEvent" output="true" returntype="query">
		<cfargument name="eventID" type="string" required="true">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" 
					value=" where eventID='#arguments.eventID#'">
		</cfinvoke>
		<cfreturn results>
		
	</cffunction>
	
	<cffunction access="remote" name="getAttendeeByID" output="true" returntype="query">
		<cfargument name="attendeeID" type="string" required="true">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" 
					value=" where attendeeID='#arguments.attendeeID#'">
		</cfinvoke>
		<cfreturn results>
		
	</cffunction>
	
	<cffunction access="remote" name="getAttendee" output="true" returntype="query">
		<cfargument name="username" type="string" required="true">
		<cfargument name="tPassword" type="string" required="true">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" value=" where username='#arguments.username#' and tPassword='#arguments.tPassword#'">
		</cfinvoke>
		<cfreturn results>
		
	</cffunction>
	 
	<cffunction access="remote" name="getAttendeesByEvent" output="true" returntype="query">
		<cfargument name="EventID" type="string" required="true">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" value=" where EventID='#arguments.EventID#'">
		</cfinvoke>
		<cfreturn results>
		
	</cffunction>
	
	<cffunction access="remote" name="getChatAttendee" output="true" returntype="query">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="eventid" type="string" required="true">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" value=" where username='#arguments.username#' and eventid='#arguments.eventid#' and tpassword='#arguments.password#'">
		</cfinvoke>
		<cfreturn results>
		
	</cffunction>
	
	<cffunction access="remote" name="getChatLogin" output="true" returntype="query">
		<cfargument name="attendeeID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" value=" where attendeeID='#arguments.attendeeID#'">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="event">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where EventID='#arguments.eventid#'">
		</cfinvoke>
		<cfif event.recordChat is "true"><cfset toRecord=1><cfelse><cfset toRecord=0></cfif>
		<cfif event.eventType is "conference"><cfset confType=1><cfelse><cfset confType=0></cfif>
		<cfset Attendee=QueryNew("username,realname,isModerator,room_id,toRecord,customerID,associateID,confType")>
		<CFSET newRow  = QueryAddRow(Attendee, 1)>
		<CFSET temp = QuerySetCell(Attendee, "username","#results.username#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "realname","#trim(results.firstname)# #trim(results.lastname)#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "isModerator","#results.AttendeeType#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "room_id","#arguments.eventID#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "toRecord","#toRecord#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "customerID","#results.customerID#", #newRow#)>
		<cfset temp = QuerySetCell(Attendee, "associateID","",#newRow#)>
		
		<cfset temp = QuerySetCell(Attendee, "confType","0",#newRow#)>
		
		<cfreturn attendee>
	</cffunction>
	
	<cffunction access="remote" name="getAttendeeLogin" output="true" returntype="query">
		<cfargument name="attendeeID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" value=" where attendeeID='#arguments.attendeeID#'">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="event">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" value=" where EventID='#arguments.eventid#'">
		</cfinvoke>
		<cfif event.recordChat is "true"><cfset toRecord=1><cfelse><cfset toRecord=0></cfif>
		<cfif event.eventType is "conference"><cfset confType=1><cfelse><cfset confType=0></cfif>
		<cfset Attendee=QueryNew("username,realname,isModerator,confType,room_id,toRecord,customerID,associateID,allowWhiteboard,allowPrivate")>
		<CFSET newRow  = QueryAddRow(Attendee, 1)>
		<CFSET temp = QuerySetCell(Attendee, "username","#results.username#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "realname","#trim(results.firstname)# #trim(results.lastname)#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "isModerator","#results.AttendeeType#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "confType","#confType#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "room_id","#arguments.eventID#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "toRecord","#toRecord#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "customerID","#results.customerID#", #newRow#)>
		<cfset temp = QuerySetCell(Attendee, "associateID","",#newRow#)>
		<cfset temp = QuerySetCell(Attendee, "allowWhiteboard","#event.allowWhiteboard#",#newRow#)>
		<cfset temp = QuerySetCell(Attendee, "allowPrivate","#event.allowPrivate#",#newRow#)>
		<cfreturn Attendee>
		
	</cffunction>
	
	<cffunction name="saveAttendee" access="remote" output="true" returntype="string">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		<cfargument name="AttendeeID" type="string" required="true">
		<cfargument name="FirstName" type="string" required="true">
		<cfargument name="LastName" type="string" required="true">
		<cfargument name="address1" type="string" required="true">
		<cfargument name="address2" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="zip" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="tpassword" type="string" required="true">
		<cfargument name="ccNumber" type="string" required="true">
		<cfargument name="ccExpire" type="string" required="true">
		<cfargument name="ccCVV" type="string" required="true">
		<cfargument name="ccType" type="string" required="true">
		<cfargument name="ccName" type="string" required="true">
		<cfargument name="AttendeeType" type="string" required="true" default="0">
		
		<cfset AttendeeID=#arguments.AttendeeID#>
		
		<Cfif #AttendeeID# is 0>
			<cfset xFields="CustomerID,EventID,FirstName,LastName,address1,address2,city,state,zip,country,email,username,tpassword,ccNumber,ccExpire,ccCVV,DateCreated,AttendeeType">
			<!--- ,ccType,ccName--->
			<cfset xData="#arguments.CustomerID#,#arguments.EventID#,#arguments.FirstName# ,#arguments.LastName# ,#arguments.address1# ,#arguments.address2# ,#arguments.city# ,#arguments.state# ,#arguments.zip# ,#arguments.country# ,#arguments.email# ,#arguments.username#,#arguments.tpassword#,#arguments.ccNumber# ,#arguments.ccExpire# ,#arguments.ccCVV# ,#dateformat(now(),'yyyy/mm/dd')# ,#arguments.attendeetype#,#arguments.ccType#">
			<!---  ,#arguments.ccName# --->
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="AttendeeID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="AttendeeID">
			</cfinvoke>
			
		<cfelse>
			
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				method="getXMLRecords" returnvariable="records">
					<cfinvokeargument name="ThisPath" value="data">
					<cfinvokeargument name="ThisFileName" value="attendees">
					<cfinvokeargument name="selectSTatement" value=" where attendeeID='#attendeeID#'">
			</cfinvoke>
		
			<cfset xFields="CustomerID,EventID,FirstName,LastName,address1,address2,city,state,zip,country,email,username,tpassword,ccNumber,ccExpire,ccCVV,DateCreated,AttendeeType">
			<!--- ,ccType,ccName --->
			<cfset xData="#arguments.CustomerID#,#arguments.EventID#,#arguments.FirstName# ,#arguments.LastName# ,#arguments.address1# ,#arguments.address2# ,#arguments.city# ,#arguments.state# ,#arguments.zip# ,#arguments.country# ,#arguments.email# ,#arguments.username#,#arguments.tpassword#,#arguments.ccNumber# ,#arguments.ccExpire# ,#arguments.ccCVV# ,#records.DateCreated#,#arguments.attendeetype#">
			<!--- ,#arguments.ccType#,#arguments.ccName# --->
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="updateXMLrecord" returnvariable="AttendeeID">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="AttendeeID">
				<cfinvokeargument name="XMLIDVAlue" value="#AttendeeID#">
			</cfinvoke>
		</cfif>
		<cfreturn AttendeeID>
		
	</cffunction>
	
	<cffunction name="deleteEVent" access="remote" output="true" returntype="boolean">
		<cfargument name="EventID" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="events">
			<cfinvokeargument name="XMLFields" value="EventID,CustomerID,EventType,EventDate,EventDuration,recordChat,allowWhiteboard,allowPrivate,chatType,billingType,registrationAmount,recordingCharge,archiveDays,billingPer,freePassCode,status,DateCreated,moderatorName,EventTitle,EventDesc">
			<cfinvokeargument name="XMLIDField" value="EventID">
			<cfinvokeargument name="XMLIDValue" value="#EventID#">
		</cfinvoke>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="deleteAttendee" access="remote" output="true" returntype="boolean">
		<cfargument name="attendeeID" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="attendees">
			<cfinvokeargument name="XMLFields" value="attendeeID,CustomerID,EventID,FirstName,LastName,address1,address2,city,state,zip,country,email,username,tpassword,ccNumber,ccExpire,ccCVV,DateCreated,AttendeeType">
			<cfinvokeargument name="XMLIDField" value="attendeeID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.attendeeID#">
		</cfinvoke>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction access="remote" name="getPresentation" output="true" returntype="query">
		<cfargument name="attendeeID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" 
					value=" where attendeeID='#arguments.attendeeID#'">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="event">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="events">
			<cfinvokeargument name="selectSTatement" value=" where EventID='#arguments.eventid#'">
		</cfinvoke>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="materials">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="materials">
			<cfinvokeargument name="selectSTatement" value=" where EventID='#arguments.eventid#'">
		</cfinvoke>
		
		<cfset theMaterialsFileName=''>
		<cfset theMaterialsTitle=''>
		<cfset MaterialsCounter=0>
		<cfoutput query="materials">
			<cfset MaterialsCounter=#MaterialsCounter# + 1>
			<cfset theMaterialsFileName=ListAppend(#theMaterialsFileName#,#FileName#)>
			<cfset theMaterialsTitle=ListAppend(#theMaterialsTitle#,#Title#)>
		</cfoutput>
		<cfif theMaterialsFileName is ''>
			<cfset theMaterialsFileName=ListAppend(#theMaterialsFileName#,"http://www.kotw.net/presentation/files/HasheyTour_Small.swf")>
			<cfset theMaterialsTitle=ListAppend(#theMaterialsTitle#,"Permanent Costmetics")>
			<cfset theMaterialsFileName=ListAppend(#theMaterialsFileName#,"http://www.kotw.net/presentation/files/30_Broadband_Low.swf")>
			<cfset theMaterialsTitle=ListAppend(#theMaterialsTitle#,"Internet Marketing Center")>
			<cfset theMaterialsFileName=ListAppend(#theMaterialsFileName#,"http://www.primedco.com/images/videos/AVI 2 FOR MIKE_Medium.swf")>
			<cfset theMaterialsTitle=ListAppend(#theMaterialsTitle#,"Primedco")>
		</cfif>

		<cfif event.recordChat is "true"><cfset toRecord=1><cfelse><cfset toRecord=0></cfif>
		<cfif event.eventType is "conference"><cfset confType=1><cfelse><cfset confType=0></cfif>
		<cfset Attendee=QueryNew("username,realname,isModerator,presentationName,room_id,toRecord,customerID,associateID,speakerName,materialsFileName,materialsTitle")>
		<CFSET newRow  = QueryAddRow(Attendee, 1)>
		<CFSET temp = QuerySetCell(Attendee, "username","#results.username#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "realname","#trim(results.firstname)# #trim(results.lastname)#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "isModerator","#results.AttendeeType#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "presentationName","#event.EventTitle#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "room_id","#arguments.eventID#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "toRecord","#toRecord#", #newRow#)>
		<CFSET temp = QuerySetCell(Attendee, "customerID","#results.customerID#", #newRow#)>
		<cfset temp = QuerySetCell(Attendee, "associateID","",#newRow#)>
		<cfset temp = QuerySetCell(Attendee, "speakerName","#event.moderatorName#",#newRow#)>
		<cfset temp = QuerySetCell(Attendee, "materialsFileName","#thematerialsFileName#",#newRow#)>
		<cfset temp = QuerySetCell(Attendee, "materialsTitle","#thematerialsTitle#",#newRow#)>
		<cfreturn Attendee>
		
	</cffunction>


	<cffunction name="saveMaterials" access="remote" output="true" returntype="string">
		<cfargument name="MaterialID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="EventID" type="string" required="true">
		<cfargument name="FileName" type="string" required="true">
		<cfargument name="Title" type="string" required="true">
		
		<cfset MaterialID=#arguments.MaterialID#>
		
		<Cfif #MaterialID# is 0>
			<cfset xFields="CustomerID,EventID,FileName,Title,dateUploaded">
			<cfset xData="#arguments.CustomerID#,#arguments.EventID#,#arguments.FileName#,#arguments.Title#,#dateformat(now(),'yyyy/mm/dd')#">
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="AttendeeID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="materials">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="MaterialID">
			</cfinvoke>
			
		<cfelse>
			
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				method="getXMLRecords" returnvariable="records">
					<cfinvokeargument name="ThisPath" value="data">
					<cfinvokeargument name="ThisFileName" value="materials">
					<cfinvokeargument name="selectSTatement" value=" where EventID='#EventID#'">
			</cfinvoke>
		
			<cfset xFields="CustomerID,EventID,FileName,Title,dateUploaded">
			<cfset xData="#arguments.CustomerID#,#arguments.EventID#,#arguments.FileName#,#arguments.Title#,#records.dateUploaded#">
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="updateXMLrecord" returnvariable="AttendeeID">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="Materials">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="MaterialID">
				<cfinvokeargument name="XMLIDVAlue" value="#MaterialID#">
			</cfinvoke>
		</cfif>
		<cfreturn AttendeeID>
		
	</cffunction>
	
	<cffunction name="getOneMaterial" access="remote" output="true" returntype="query">
		<cfargument name="MaterialID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="materials">
				<cfinvokeargument name="selectSTatement" value=" where MaterialID='#MaterialID#'">
		</cfinvoke>
		
		<cfreturn records>
	</cffunction>
	
	<cffunction name="getAllMaterialsByEvent" access="remote" output="true" returntype="query">
		<cfargument name="EventID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="materials">
				<cfinvokeargument name="selectSTatement" value=" where EventID='#EventID#'">
		</cfinvoke>
		
		<cfreturn records>
	</cffunction>
	
	<cffunction name="savePageContent" access="remote" output="true" returntype="string">
		<cfargument name="PageID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="homePageTitle" type="string" required="true">
		<cfargument name="homePageContent" type="string" required="true">
		<cfargument name="copyrightContent" type="string" required="true">
		<cfargument name="loginPageContent" type="string" required="true">
		<cfargument name="eventRegPageContent" type="string" required="true">
		<cfargument name="assocRegPageContent" type="string" required="true">
		<cfargument name="listingPageContent" type="string" required="true">
		
		<cfset PageID=#arguments.PageID#>
		<cfset xFields="CustomerID,homePageTitle,homePageContent,copyrightContent,loginPageContent,eventRegPageContent,assocRegPageContent,listingPageContent">
		<cfset xData="#arguments.CustomerID#,#replace(arguments.homePageTitle,',','~','ALL')#,#replace(arguments.homePageContent,',','~','ALL')#,#replace(arguments.copyrightContent,',','~','ALL')#,#replace(arguments.loginPageContent,',','~','ALL')#,#replace(arguments.eventRegPageContent,',','~','ALL')#,#replace(arguments.assocRegPageContent,',','~','ALL')#,#replace(arguments.listingPageContent,',','~','ALL')#">
		<Cfif #PageID# is 0>
			
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="NewPageID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="pageContent">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="PageID">
			</cfinvoke>
			
		<cfelse>
			<cfset NewPageID=#PageID#>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="updateXMLrecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="pageContent">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="PageID">
				<cfinvokeargument name="XMLIDVAlue" value="#PageID#">
			</cfinvoke>
		</cfif>
		<cfreturn NewPageID>
		
	</cffunction>
	
	<cffunction name="getPageContent" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="pageContent">
				<cfinvokeargument name="selectSTatement" value=" where CustomerID='#CustomerID#'">
		</cfinvoke>
		
		<cfset pageContent=QueryNew("PageID,CustomerID,homePageTitle,homePageContent,copyrightContent,loginPageContent,eventRegPageContent,assocRegPageContent,listingPageContent")>
		<CFSET newRow  = QueryAddRow(pageContent, 1)>
		<CFSET temp = QuerySetCell(pageContent, "PageID","#records.PageID#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "CustomerID","#trim(records.CustomerID)#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "homePageTitle","#replace(records.homePageTitle,'~',',','ALL')#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "homePageContent","#replace(records.homePageContent,'~',',','ALL')#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "copyrightContent","#replace(records.copyrightContent,'~',',','ALL')#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "loginPageContent","#replace(records.loginPageContent,'~',',','ALL')#", #newRow#)>
		<CFSET temp = QuerySetCell(pageContent, "eventRegPageContent","#replace(records.eventRegPageContent,'~',',','ALL')#", #newRow#)>
		<cfset temp = QuerySetCell(pageContent, "assocRegPageContent","#replace(records.assocRegPageContent,'~',',','ALL')#",#newRow#)>
		<cfset temp = QuerySetCell(pageContent, "listingPageContent","#replace(records.listingPageContent,'~',',','ALL')#",#newRow#)>
		
		<cfreturn pageContent>
	</cffunction>
	
	<cffunction access="remote" name="getEventLogin" output="true" returntype="string">
		<cfargument name="EventID" type="string" required="true">
		<cfargument name="UserName" type="string" required="true">
		<cfargument name="Password" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="attendees">
				<cfinvokeargument name="selectSTatement" 
				value=" where EventID='#arguments.EventID#' and Username='#arguments.UserName#' and tPassword='#arguments.password#'">
		</cfinvoke>
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="events">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectSTatement" 
				value=" where EventID='#arguments.EventID#'">
		</cfinvoke>
		
		<cfif results.recordcount is 0>
			<cfreturn "false">
		<cfelse>
			<cfinvoke method="saveBandwidth" returnvariable="ControlID">
				<cfinvokeargument name="ControlID" value="0000000000">
				<cfinvokeargument name="CustomerID" value="#results.CustomerID#">
				<cfinvokeargument name="TheBandwidth" value="0">
				<cfinvokeargument name="AttendeeType" value="#results.AttendeeType#">
				<cfinvokeargument name="TheEvent" value="#results.EventID#">
				<cfinvokeargument name="AssociateID" value="#events.associateID#">
			</cfinvoke>
			<cfreturn ControlID>
		</cfif>
		
	</cffunction>
	
	<cffunction name="getAllEventsByAssociate" access="remote" returntype="query" output="true">
		<cfargument name="AssociateID" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="events">
				<cfinvokeargument name="selectStatement" 
					value=" where AssociateID='#arguments.AssociateID#'">
		</cfinvoke>
		
		<cfset events=QueryNew("EventID,EventType,EventDate,moderatorName,EventTitle,registrationAmount")>
		<cfoutput query="results">
			<CFSET newRow  = QueryAddRow(events, 1)>
			<CFSET temp = QuerySetCell(events, "EventID","#results.EventID#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventType","#results.EventType#", #newRow#)>
			<CFSET temp = QuerySetCell(events, "EventDate","#dateformat(results.EventDate,'mm/dd/yyyy')#", #newRow#)>
			<cfset temp = QuerySetCell(events, "moderatorName","#replace(results.moderatorName,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "EventTitle","#replace(results.EventTitle,'~',',','ALL')#",#newRow#)>
			<cfset temp = QuerySetCell(events, "registrationAmount","#dollarformat(results.registrationAmount)#",#newRow#)>
		</cfoutput>
		<cfreturn events>
	</cffunction>
	
	<cffunction name="getOneInvoice" access="remote" output="true" returntype="query">
		<cfargument name="InvoiceID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="selectSTatement" value=" where InvoiceID='#arguments.InvoiceID#'">
		</cfinvoke>
		
		<cfreturn records>
	</cffunction>
	
	<cffunction name="getInvoicesByCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="selectSTatement" 
					value=" where CustomerID='#arguments.CustomerID#' and associateID='0000000000' ">
		</cfinvoke>
		<cfset invoices=QueryNew("InvoiceID,CustomerID,AssociateID,InvoiceDate,TotalBandwidth,TotalMinutes,DatePaid,CheckNo,PaymentType")>
		<cfoutput query="records">
			<cfif #trim(DatePaid)# eq "">
				<CFSET newRow  = QueryAddRow(invoices, 1)>
				<CFSET temp = QuerySetCell(invoices, "InvoiceID","#InvoiceID#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "CustomerID","#CustomerID#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "AssociateID","#AssociateID#", #newRow#)>
				<cfset temp = QuerySetCell(invoices, "InvoiceDate","#dateformat(InvoiceDate,'mm/dd/yyyy')#",#newRow#)>
				<cfset temp = QuerySetCell(invoices, "TotalBandwidth","#TotalBandwidth#K",#newRow#)>
				<cfset temp = QuerySetCell(invoices, "TotalMinutes","#TotalMinutes#",#newRow#)>
				<CFSET temp = QuerySetCell(invoices, "DatePaid","#DatePaid#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "CheckNo","#CheckNo#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "PaymentType","#PaymentType#", #newRow#)>
			</cfif>
		</cfoutput>
		<cfreturn invoices>
	</cffunction>
	
	<cffunction name="getClosedByCustomer" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="selectSTatement" 
					value=" where CustomerID='#arguments.CustomerID#' and associateID='0000000000' ">
		</cfinvoke>
		<cfset invoices=QueryNew("InvoiceID,CustomerID,AssociateID,InvoiceDate,TotalBandwidth,TotalMinutes,DatePaid,CheckNo,PaymentType")>
		<cfoutput query="records">
			<cfif #trim(DatePaid)# neq "">
				<CFSET newRow  = QueryAddRow(invoices, 1)>
				<CFSET temp = QuerySetCell(invoices, "InvoiceID","#InvoiceID#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "CustomerID","#CustomerID#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "AssociateID","#AssociateID#", #newRow#)>
				<cfset temp = QuerySetCell(invoices, "InvoiceDate","#dateformat(InvoiceDate,'mm/dd/yyyy')#",#newRow#)>
				<cfset temp = QuerySetCell(invoices, "TotalBandwidth","#TotalBandwidth#K",#newRow#)>
				<cfset temp = QuerySetCell(invoices, "TotalMinutes","#TotalMinutes#",#newRow#)>
				<CFSET temp = QuerySetCell(invoices, "DatePaid","#DatePaid#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "CheckNo","#CheckNo#", #newRow#)>
				<CFSET temp = QuerySetCell(invoices, "PaymentType","#PaymentType#", #newRow#)>
			</cfif>
		</cfoutput>
		<cfreturn invoices>
	</cffunction>
	
	<cffunction name="getInvoicesByAssociate" access="remote" output="true" returntype="query">
		<cfargument name="CustomerID" required="true" type="string">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="selectSTatement" 
					value=" where CustomerID='#arguments.CustomerID#' and AssociateID <> '0000000000'">
				<cfinvokeargument name="OrderByStatement" value=" order by AssociateID, DatePaid">
		</cfinvoke>
		
		<cfreturn records>
	</cffunction>
	
	<cffunction access="remote" name="getAssocLogin" output="true" returntype="string">
		<cfargument name="UserName" type="string" required="true">
		<cfargument name="Password" type="string" required="true">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="associates">
				<cfinvokeargument name="selectSTatement" 
				value=" where Username='#arguments.UserName#' and tPassword='#arguments.password#'">
		</cfinvoke>
		<cfset AssociateID='0000000000'>
		<cfif results.recordcount gt 0><cfset AssociateID=#results.AssociateID#></cfif>
		<cfreturn AssociateID>
		
	</cffunction>
	
	<cffunction access="remote" name="getInvoiceDetail" output="true" returntype="query">
		<cfargument name="InvoiceID" type="string" required="true">
		
		<cfset NewID=#arguments.InvoiceID#>
		<cfset tLen=Len(NewID)>
		<cfloop index="XX" from="#tLen#" to="9">
			<cfset NewID="0#NewID#">
		</cfloop>
		<cfset InvoiceID=#NewID#>
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="results">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoiceDetail">
				<cfinvokeargument name="selectSTatement" 
				value=" where InvoiceID='#InvoiceID#'">
		</cfinvoke>
		
		<cfreturn results>
		
	</cffunction>
	
	<cffunction name="saveInvoice" access="remote" output="true" returntype="string">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="AssociateID" type="string" required="true" default="0000000000">
		<cfargument name="InvoiceID" type="string" required="true">
		<cfargument name="TotalBandwidth" type="string" required="true">
		<cfargument name="TotalMinutes" type="string" required="true">
		<cfargument name="DatePaid" type="string" required="true">
		<cfargument name="CheckNo" type="string" required="true">
		<cfargument name="PaymentType" type="string" required="true">
		<cfargument name="BandwidthIDs" type="string" required="true">
	
		<cfset InvoiceID=#arguments.InvoiceID#>
		<cfset InvoiceDate=dateformat(now(),"yyyy/mm/dd")>
		<Cfif #InvoiceID# is 0>
			<cfset xFields="CustomerID,AssociateID,InvoiceDate,TotalBandwidth,TotalMinutes,DatePaid,CheckNo,PaymentType">
			<cfset xData="#arguments.CustomerID#,#arguments.AssociateID#,#InvoiceDate#,#arguments.TotalBandwidth# ,#arguments.TotalMinutes# ,#arguments.DatePaid# ,#arguments.CheckNo# ,#arguments.PaymentType# ">
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="InvoiceID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="InvoiceID">
			</cfinvoke>
			
			<cfinvoke method="saveInvoiceDetail">
				<cfinvokeargument name="InvoiceID" value="#InvoiceID#">
				<cfinvokeargument name="CustomerID" value="#arguments.CustomerID#">
				<cfinvokeargument name="AssociateID" value="#arguments.AssociateID#">
				<cfinvokeargument name="BandwidthIDs" value="#arguments.BandwidthIDs#">
			</cfinvoke>
			
		<cfelse>
			
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				method="getXMLRecords" returnvariable="records">
					<cfinvokeargument name="ThisPath" value="data">
					<cfinvokeargument name="ThisFileName" value="invoices">
					<cfinvokeargument name="selectSTatement" value=" where InvoiceID='#InvoiceID#'">
			</cfinvoke>
		
			<cfset xFields="CustomerID,AssociateID,InvoiceDate,TotalBandwidth,TotalMinutes,DatePaid,CheckNo,PaymentType">
			<cfset xData="#records.CustomerID#,#records.AssociateID#,#records.InvoiceDate#,#records.TotalBandwidth#,#records.TotalMinutes#,#arguments.DatePaid# ,#arguments.CheckNo#,#arguments.PaymentType#">
	
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="updateXMLrecord" returnvariable="InvoiceID">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="InvoiceID">
				<cfinvokeargument name="XMLIDVAlue" value="#InvoiceID#">
			</cfinvoke>
			
		</cfif>
		
		<cfreturn InvoiceID>
		
	</cffunction>
	
	<cffunction name="saveInvoiceDetail" access="remote" output="true">
		<cfargument name="InvoiceID" type="string" required="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="AssociateID" type="string" required="true" default="0000000000">
		<cfargument name="BandwidthIDs" type="string" required="true">
	
		<cfset xFields="InvoiceID,CustomerID,AssociateID,Event,attendeeType,theDate,Start,End">
		
		<cfset BandwidthIDs=#replace(arguments.BandwidthIDs,"~",",","ALL")#>
		<cfset TotalBandwidth=0>
		<cfset TotalMinutes=0>
		
		<cfloop index="ID" list="#BandwidthIDs#">
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				method="getXMLRecords" returnvariable="records">
					<cfinvokeargument name="ThisPath" value="data">
					<cfinvokeargument name="ThisFileName" value="bandwidthControl">
					<cfinvokeargument name="selectSTatement" value=" where ControlID='#ID#'">
			</cfinvoke>
			<cfset xData="#arguments.InvoiceID#,#arguments.CustomerID#,#arguments.AssociateID#,#records.TheEvent#,#records.attendeeType#,#records.theDate# ,#records.startTime#,#records.EndTime#,#records.TheBandwidth#">
			
			<cfif #records.EndTime# lt #records.startTime#>
				<cfset newendtime=dateadd("h",12,#records.EndTime#)>
				<Cfset newendtime=timeformat(newendtime,"HH:mm:ss")>
			<cfelse>
				<cfset newendtime=#records.EndTime#>
			</cfif>
			<cfset minutes=datediff("n",#records.startTime#,newendtime)>
			<cfset TotalMinutes=#totalMinutes# + #minutes#>
			<cfset TotalBandwidth=#TotalBandwidth# + (#Minutes#*150)>
			
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="DetailID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="invoiceDetail">
				<cfinvokeargument name="XMLFields" value="#xFields#">
				<cfinvokeargument name="XMLFieldData" value="#xData#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
			</cfinvoke>
		</cfloop>
		<cfset ThisBandwidth=#TotalBandwidth#>
		<cfset ThisMinutes=#totalMInutes#>
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="invoices">
				<cfinvokeargument name="selectSTatement" value=" where InvoiceID='#arguments.InvoiceID#'">
		</cfinvoke>
	
		<cfset yFields="CustomerID,AssociateID,InvoiceDate,TotalBandwidth,TotalMinutes,DatePaid,CheckNo,PaymentType">
		<cfset yData="#records.CustomerID#,#records.AssociateID#,#records.InvoiceDate#,#ThisBandwidth#,#ThisMinutes#,#records.DatePaid# ,#records.CheckNo#,#records.PaymentType#">

		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
			method="updateXMLrecord" returnvariable="InvoiceID">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="invoices">
			<cfinvokeargument name="XMLFields" value="#yFields#">
			<cfinvokeargument name="XMLFieldData" value="#yData#">
			<cfinvokeargument name="XMLIDField" value="InvoiceID">
			<cfinvokeargument name="XMLIDVAlue" value="#arguments.InvoiceID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction access="remote" name="recordFLVUsage" returntype="string" output="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="videoname" type="string" required="true">
		
		<cfif not isdefined('application.websitepath')>
			<cfinclude template="../website.ini">
			<cfinclude template="../application.cfm">
		</cfif>
		<cfset theTime=timeFormat(now(),"HH:mm:ss")>
		<cfset theDate=dateFormat(now(),"yyyy/mm/dd")>
		
		<cfset yFields="website,videoname,theTime,theDate,endTime">
		<cfset yData="#arguments.website#,#arguments.videoname#,#theTime#,#theDate#,none">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
			method="insertXMLrecord" returnvariable="ControlID">
			<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
			<cfinvokeargument name="ThisFileName" value="FLVUsage">
			<cfinvokeargument name="XMLFields" value="#yFields#">
			<cfinvokeargument name="XMLFieldData" value="#yData#">
			<cfinvokeargument name="XMLIDField" value="ControlID">
		</cfinvoke>
		<cfreturn ControlID>
	</cffunction>
	
	<cffunction access="remote" name="updateFLVUsage" output="true">
		<cfargument name="ControlID" type="string" required="true">
		<cfargument name="videoname" type="string" required="true">
		
		<cfset endTime=timeFormat(now(),"HH:mm:ss")>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="FLVUsage">
				<cfinvokeargument name="selectSTatement" value=" where ControlID='#arguments.ControlID#'">
		</cfinvoke>
		
		<cfset yFields="website,videoname,theTime,theDate,endTime">
		<cfset yData="#records.website#,#arguments.videoname#,#records.theTime#,#records.theDate#,#endTime#">
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
			method="updateXMLrecord" returnvariable="ControlID">
			<cfinvokeargument name="ThisPath" value="data">
			<cfinvokeargument name="ThisFileName" value="FLVUsage">
			<cfinvokeargument name="XMLFields" value="#yFields#">
			<cfinvokeargument name="XMLFieldData" value="#yData#">
			<cfinvokeargument name="XMLIDField" value="ControlID">
			<cfinvokeargument name="XMLIDVAlue" value="#arguments.ControlID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction access="remote" name="readFLVUsage" output="true">
		<cfargument name="Today" type="string" required="true" default="#now()#">
		
		<cfset Today=dateformat(today,"yyyy/mm/dd")>
		<cfset Tomorrow=dateadd("m",-1,today)>
		<cfset Tomorrow=dateformat(Tomorrow,"yyyy/mm/dd")>
		<cfoutput>where theDate>='#Tomorrow#' and theDate<='#Today#'"<br></cfoutput>
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			method="getXMLRecords" returnvariable="records">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="FLVUsage">
				<cfinvokeargument name="selectSTatement" value=" where theDate>='#Tomorrow#' and theDate<='#Today#'">
		</cfinvoke>
		<cfreturn records>
	</cffunction>

	<cffunction access="remote" name="saveVideos" returntype="string" output="true">
		<cfargument name="videoID" type="string" required="true">
		<cfargument name="videoname" type="string" required="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="bandwidth" type="string" required="true">
		
		<cfset yFields="videoname,website,bandwidth">
		<cfset yData="#arguments.videoname#,#arguments.website#,#arguments.bandwidth#">
		<cfset VideoID=#arguments.videoID#>
		
		<cfif #int(videoID)# is 0>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLrecord" returnvariable="videoID">
				<cfinvokeargument name="ThisPath" value="#application.physicalpath#/data">
				<cfinvokeargument name="ThisFileName" value="videoBandwidth">
				<cfinvokeargument name="XMLFields" value="#yFields#">
				<cfinvokeargument name="XMLFieldData" value="#yData#">
				<cfinvokeargument name="XMLIDField" value="VideoID">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="updateXMLrecord" returnvariable="videoID">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="videoBandwidth">
				<cfinvokeargument name="XMLFields" value="#yFields#">
				<cfinvokeargument name="XMLFieldData" value="#yData#">
				<cfinvokeargument name="XMLIDField" value="videoID">
				<cfinvokeargument name="XMLIDVAlue" value="#arguments.videoID#">
			</cfinvoke>
		</cfif>
		<cfreturn videoID>
	</cffunction>
</cfcomponent>