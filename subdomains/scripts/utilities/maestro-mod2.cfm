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
			<option value="UID5RMEYEQUK102MXPI">OYM class 1 (Jan-Mar)</option>
			<option value="UIDRHGT6VYVNB0T7QNM">OYM Live Class 1</option>
			<option value="UIDABSF0LFALJO5RTPG">OYE (Jan- Mar) </option>
			<option value="UIDAKKPQUAPTN7H5Y0Y">Generative Moments (Jan-Mar)</option>
			<option value="UIDY5S561STUDMYKC51">Wellness Vision (Jan-Mar)</option>
			<option value="IUK71SORPXKWNWWX">Module 2: OYM Live Class 1</option>
			<option value="G9XM06OV4GX1C9">Module 2: OYM Live Class 2</option>
			<option value="KGHSD8LZBLWVRFT">Module 2: Generative Moments Course</option>
			<option value="OMKY1U9I5E863NZA">Module 2: Wellness Vision Course</option>
			<option value="CM7V9SRFTZBSL03">Module 2: Organize Your Emotions Course</option>
			<option value="9TGAVYYWUAL5KUQ">Module 2: OYM CLASS 1 (OCT-DEC)</option>
			<option value="DHFIHNZBDXNFXBDY">Module 2: OYM Class 2 (Oct-Dec)</option>
			<option value="39QQYKT3NEVQUV2B">Module 2: Wellness Vision (Oct-Dec)</option>
			<option value="JPNQ23L97HYMNTAK">Module 2: Generative Moments (Oct-Dec)</option>
			<option value="1CHRTF12D1XK7S">Module 2: Organize Your Emotions (Oct-Dec)</option>
			<option value="IUK71SORPXKWNWWX">OYM Live Class 1</option>
			<option value="G9XM06OV4GX1C9">OYM Live Class 2</option>
			<option value="KGHSD8LZBLWVRFT">Generative Moments Course</option>
			<option value="OMKY1U9I5E863NZA">Wellness Vision Course</option>
			<option value="CM7V9SRFTZBSL03">Organize Your Emotions Course</option>
			
			
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