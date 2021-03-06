<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>

#loading-img {
    background: url(http://preloaders.net/preloaders/360/Velocity.gif) center center no-repeat;
    height: 100%;
    z-index: 20;
}

.overlay {
    background: #e9e9e9;
    display: none;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: 0.5;
}
</style>

<cfoutput>
	<div class="overlay">
		<div id="loading-img"></div>
	</div>
	<cfset local.foundConference = 0>

	<form name="maestroClass" method="post">
		<input type="hidden" name="email" value="#htmlEditFormat(url.email)#">
		<p>Please select the conference from the drop down menu below to see your hours attended:</p>
		<cfinclude template="inc/attendance.cfm" />
		<input type="submit" name="displayAttendance" id="button" value="Show my attendance">

	</form>


	<cfif structKeyExists(form, 'displayAttendance')>

		<cfloop list="#form.conferenceId#" index="local.confId">

			<cfhttp method="get" url="http://myaccount.maestroconference.com/_access/getConferenceData" result="callerDetails">
					<cfhttpparam type="URL" name="customer"  value="L7B5XVTQOHXET688" />
					<cfhttpparam type="URL" name="key"  value="4ad1c09c3e999b00e3923522c0ff3602"/>
					<cfhttpparam type="formfield"  value="json" name="type"/>
					<cfhttpparam type="formfield"  value="#local.confId#" name="conferenceUID"/>
			</cfhttp>



			<cfset local.rtnJsonDetails = deserializeJSON(callerDetails.fileContent)>

			
			<cfset local.AllPins = '' />
			<cfset person = {}>
			<cfif isDefined('local.rtnJsonDetails.value.person')>
				<cfloop array="#local.rtnJsonDetails.value.person#" index="local.person">
					<cfset local.AllPins = ListAppend(local.AllPins,local.person.pin)>
					<cfset person[local.person.pin] = local.person.email>
				</cfloop>
			</cfif>
			<!--- get all call information --->
			<cfif isDefined('local.rtnJsonDetails.value.calls')>

			<cfloop array="#local.rtnJsonDetails.value.calls#" index="local.calls">
				<CFX_HTTP5
					url="http://myaccount.maestroconference.com/_access/getCallData?customer=L7B5XVTQOHXET688&key=4ad1c09c3e999b00e3923522c0ff3602&conferenceUID=#local.confId#&callUID=#local.calls#"
					method="get"
					customer="L7B5XVTQOHXET688"
					key="4ad1c09c3e999b00e3923522c0ff3602"
					conferenceUID="#local.confId#"
					callUID="#local.calls#"
					headers="Content-Type: application/json; charset=utf-8"
					out="callerInfo"  >

				<cfset local.rtnJSON = deserializeJSON(callerInfo)>
				<cfset local.calledInList = "">
				<!--- all the callers for this conference --->
				<cfif isDefined('local.rtnJSON.value.caller')>
					<cfloop array="#local.rtnJSON.value.caller#" index="local.caller">
						<cfif structKeyExists(local.caller,'pin')>
							<cfset local.calledInList = listAppend(local.calledInList,local.caller.pin)>
						</cfif>
					</cfloop>

					<cfif !structKeyExists(form,'email')>
						<!--- all who didn't not call in --->
						Non Attendees for #local.rtnJSON.value.call.name#:<br />
						<cfset noncount = 1>
						<cfloop list="#local.allPins#" index="local.pin">
							<cfif !ListFind(local.calledInList,local.pin) AND len(person[local.pin])>
								#noncount++#. #person[local.pin]#<br />
							</cfif>
						</cfloop>
						<br />
						Attendee(s):<br />
					</cfif>
					<cfset currentrow = 1>
					<cfset local.attended = 0>
					<cfloop array="#local.rtnJSON.value.caller#" index="local.caller">
							<cfif structKeyExists(form,'email') AND form.email EQ local.caller.email>
								<cfif currentrow EQ 1>
									<h3>#local.rtnJSON.value.call.name#</h3>
									<h4>Start time: #local.rtnJSON.value.call.actualStartTime# - End time: #local.rtnJSON.value.call.actualEndTime#</h4>
								</cfif>
								<cfset local.foundConference = 1 />
								<cfset local.attended++>
								#local.caller.tag# - (#local.caller.startTime# - #local.caller.endTime#) <font color="green">#dateDiff("n",listGetat(local.caller.startTime,4,' '),listGetat(local.caller.endTime,4,' '))# minutes </font><br />
							</cfif>
					</cfloop>
				</cfif>
				<!--- end local.rtnJsonDetails.value.caller --->
			</cfloop>
			<!--- end local.rtnJsonDetails.value.calls --->
			</cfif>
	</cfloop>

	<cfif structKeyExists(form, 'conferenceId') and !len(form.conferenceId)>
		Please select a conference to see your attendance hours.

	<cfelseif structKeyExists(form,'email') AND local.foundConference EQ 0>
		#form.email# is not associated with selected Maestro conference.  Please email your concierge if you think there is an error.
	</cfif>
</cfif>	
</cfoutput>
<script language="javascript">
	$("#button").click(function () {
    	$(".overlay").show();
	});

</script>