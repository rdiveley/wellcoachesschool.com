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
		<select name="conferenceId">
			<option value="">-Select Conference-</option>
			
			<option value="YHGN8IC1NSBW84TN">Wellcoaches Aug 2020 (9wk) cohort</option>
			<option value="GG1FDN6SMHNE249C">Wellcoaches July 2020 cohort</option>
			<option value="NNGP08TEDCBKLE8Y">Monarch (DG) May 2020 </option>
			<option value="DQPPOYB6EKG0XNSI">Singapore (DG) April 2020 cohort </option>
			<option value="2A6OQNHALS3R9FYB">Wellcoaches April 2020 (9wk) cohort</option>
			<option value="EY4O3810QHIKAVT0">Wellcoaches June 2020 (4-day) </option>
			<option value="YZXKDGQ8URS4HSRU">Wellcoaches May 2020 cohort</option>
			<option value="MN41ZAL0P92RU1CM">Wellcoaches June 2020 (9wk) cohort</option>
			<option value="9BY8ANI1STJLYSZX">wellcoaches Feb 2020-A cohort</option>
			<option value="6DJKL7N9K64FQK55">Wellcoaches Feb 2020-B cohort</option>
			<option value="296ZXEWWZPF3WA4">Wellcoaches January 2020 cohort</option>
			<option value="EXL6Z17U6TUEXN2V">Wellcoaches March 2020 cohort</option>
			<option value="5TV1AYK0Y71NPMEC">Wellcoaches November 2019 Module 1 training</option>
			<option value="7XHU8ZC1PQ5Y880V">Wellcoaches Sept 2019 Module 1 training </option>
			<option value="PJIR1M5WJIK33LZE">Wellcoaches July 2019 Module 1 training </option>
			<option value="H0XTS36RWDCVXPM1">Wellcoaches May 2019 Module 1 training </option>
			<option value="I1Y0T00QO8JNGBPX">Wellcoaches January 2019 Module 1 Training</option>
			<option value="SCPNN5HU1U4OWN7">Wellcoaches March 2019 Module 1 Training</option>
			<option value="MYTFRE7MJS0E5ITB">Professional Coach Training - January - September 2019</option>
			<option value="5TLFE4S6SBS46OI1">CalU HWC PRF714 With Christina</option>
			<option value="A0WFG2KYUKRBQJ1S">HWC Competencies PRF754 with Christina</option>
			<option value="FIFXMRQEK4KK8QM1">UWM HWC Competencies With Christina</option>
		</select>
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

				<cfhttp method="get" url="http://myaccount.maestroconference.com/_access/getCallData" result="callerInfo">
					<cfhttpparam type="URL" name="customer"  value="L7B5XVTQOHXET688" />
					<cfhttpparam type="URL" name="key"  value="4ad1c09c3e999b00e3923522c0ff3602"/>
					<cfhttpparam type="formfield"  value="json" name="type"/>
					<!--- conference ID --->
					<cfhttpparam type="formfield"  value="#local.confId#" name="conferenceUID"/>
					<!--- call ID --->
					<cfhttpparam type="formfield"  value="#local.calls#" name="callUID"/>
				</cfhttp>

				<cfset local.rtnJSON = deserializeJSON(callerInfo.filecontent)>
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