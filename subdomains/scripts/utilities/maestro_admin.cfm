
		<cfif !structKeyExists(url,'conferenceId')>
			Conference Id was not supplied, please try again<cfabort>
		</cfif>

	<cfloop list="#url.conferenceId#" index="local.confId">
		 <cfhttp method="get" url="http://myaccount.maestroconference.com/_access/getConferenceData" result="callerDetails">
				<cfhttpparam type="URL" name="customer"  value="L7B5XVTQOHXET688" />
				<cfhttpparam type="URL" name="key"  value="4ad1c09c3e999b00e3923522c0ff3602"/>
				<cfhttpparam type="formfield"  value="json" name="type"/>
				<cfhttpparam type="formfield"  value="#local.confId#" name="conferenceUID"/>
		 </cfhttp>

		 <cfset local.rtnJsonDetails = deserializeJSON(callerDetails.fileContent)>
		 <cfset local.AllPins = '' />
		 <cfset person = {}>

		 <cfloop array="#local.rtnJsonDetails.value.person#" index="local.person">
			<cfset local.AllPins = ListAppend(local.AllPins,local.person.pin)>
			<cfset person[local.person.pin] = local.person.email>

		 </cfloop>

			<!--- get all call information --->

		  <cfloop array="#local.rtnJsonDetails.value.calls#" index="local.calls">

			<cfhttp method="get" url="http://myaccount.maestroconference.com/_access/getCallData" result="callerInfo">
				<cfhttpparam type="URL" name="customer"  value="L7B5XVTQOHXET688" />
				<cfhttpparam type="URL" name="key"  value="4ad1c09c3e999b00e3923522c0ff3602"/>
				<cfhttpparam type="formfield"  value="json" name="type"/>
				<!--- conference ID --->
				<cfhttpparam type="formfield"  value="HEXDGUJD5JS5TF0Q" name="conferenceUID"/>
				<!--- call ID --->
				<cfhttpparam type="formfield"  value="#local.calls#" name="callUID"/>
		 	</cfhttp>

		 	<cfset local.rtnJSON = deserializeJSON(callerInfo.filecontent)>

			<cfoutput>
				<h3>#local.rtnJSON.value.call.name#</h3>
				<h4>Start time: #local.rtnJSON.value.call.actualStartTime# - End time: #local.rtnJSON.value.call.actualEndTime#</h4>
			</cfoutput>

			<cfset local.calledInList = "">
			<!--- all the callers for this conference --->
			<cfloop array="#local.rtnJSON.value.caller#" index="local.caller">
				<cfif structKeyExists(local.caller,'pin')>
					<cfset local.calledInList = listAppend(local.calledInList,local.caller.pin)>
				</cfif>
			</cfloop>
			<cfif !structKeyExists(url,'email')>
				<!--- all who didn't not call in --->
				Non Attendees:<br />
				<cfset noncount = 1>
				<cfloop list="#local.allPins#" index="local.pin">
					<cfif !ListFind(local.calledInList,local.pin) AND len(person[local.pin])>
						<cfoutput>#noncount++#. #person[local.pin]#<br /></cfoutput>
					</cfif>
				</cfloop>
				<br />
			 	Attendee(s):<br />
		 	</cfif>
		 	<cfset currentrow = 1>

			<cfset local.attended = 0>
			 <cfset myQuery = queryNew('Name, Email, StartTime, EndTime','varchar,varchar,time,time')>
		 	<cfloop array="#local.rtnJSON.value.caller#" index="local.caller">

				<cfif !structKeyExists(url,'email')>
				<cfset temp = queryAddRow(myQuery)>
				<cfset temp = querysetcell(myQuery, 'Name', local.caller.tag) >
				<cfset temp = querysetcell(myQuery, 'Email', local.caller.email) >
				<cfset temp = querysetcell(myQuery, 'StartTime', local.caller.startTime) >
				<cfset temp = querysetcell(myQuery, 'EndTime', local.caller.endTime) >

			 		<!--- #currentrow++#.  #local.caller.tag# - (#local.caller.startTime# - #local.caller.endTime#) <font color="green">#dateDiff("n",listGetat(local.caller.startTime,4,' '),listGetat(local.caller.endTime,4,' '))# minutes </font><br /> --->

				</cfif>

		 	</cfloop>
			<cfquery name="local.getUsers" dbtype="query">
				select email,name,startTime,endTime from myQuery
				group by email,name,startTime,endTime
			</cfquery>


			<cfoutput query="local.getUsers" group="email">
					#Name# (#email#)- (Start Time:#startTime# - End Time:#endTime#)
					<cfset local.minutes =0>
					<cfoutput>
						<cfset local.minutes += #dateDiff('n',starttime,endtime)# />
					</cfoutput>
					<font color="green">#local.minutes# minutes</font><br />
			</cfoutput>
		 </cfloop>
</cfloop>


