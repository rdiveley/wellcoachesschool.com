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
			<option value="9L1KFCJNIPBIIR8H">OYM class 1 (Apr 21-Jun 21)</option>
			<option value="PISADMESIX72IK8Y">OYM class 2 (Apr 21-Jun 21)</option>  
			<option value="WTF80B2RYF045IJ">OYE (Apr 21-Jun 21)</option>  
			<option value="2JJGR7LA2209SE4">Generative Moments (Apr 21-Jun 21)</option>  
			<option value="Y8IEIUURN3LZU5D0">Wellness Vision (Apr 21-Jun 21)</option>  
    
			<option value="A97NY1P45U3RPNU">OYM class 1 (Jan 21-Mar 21)</option>
			<option value="LXP27PTBQSRMCBGQ">OYE (Jan 21-Mar 21)</option>
			<option value="33ZJ3NOOFEGBIG">Generative Moments (Jan 21-Mar 21)</option>
			<option value="YIR9GC4YKTRIG90">Wellness Vision (Jan 21-Mar 21)</option>
			<option value="GBZBWDMYQR3IURP">OYM class 2 (Jan 21-Mar 21)</option>
			<option value="8QWAN840O5FCKFOG">OYM class 1 (Oct 20-Dec 20)</option>
			<option value="86IUQZUROQ80WS">OYM class 2 Oct 20-Dec 20)</option>
			<option value="GIZA1V8S094WDXV">OYE (Oct 20-Dec 20)</option>
			<option value="3CVDA56YD1P47M2Z">Generative Moments (Oct 20-Dec 20)</option>
			<option value="4V5520GGZ6PRHUK2">Wellness Vision (Oct 20-Dec 20) </option>

			<option value="3GRN9HZQ8PIASHO5">OYM Class 1 (July 20-Sep20)</option>
			<option value="FL8AQ5CTMQ290M">OYM Class 2 (July 20-Sep 20) </option>
			<option value="B7CHMG9ZCG7LKH1A">OYE (July 20-Sep 20) </option>
			<option value="TOGSRT7G0KH30X9K">Generative Moments (July 20-Sep 20) </option>
			
			<option value="TZENVU93586VWXQ4">Wellness Vision (July 20-Sep 20)</option>
			<option value="F6WP9IOYWYW8W6VI">OYM Class 1 (Apr20-Jun20)</option>
			<option value="5FVYH9TGN9GM3L1">OYM Class 2 (Apr 20-Jun20)</option>  
			<option value="VUXB57NLLET3H5B">OYE (Apr20-Jun20)</option> 
			<option value="RB5OPS377IXNIMBK">Generative Moments (Apr20-Jun20)</option> 
			<option value="OIGI6N69EX729FJL">Wellness Vision (Apr20-Jun20)</option> 

			<option value="5RMEYEQUK102MXPI">OYM Class 1 (Jan20-Mar20)</option>
			<option value="ABSF0LFALJO5RTPG">OYE (Jan20-Mar20)</option>
			<option value="AKKPQUAPTN7H5Y0Y">Generative Moments (Jan20-Mar20)</option>
			<option value="Y5S561STUDMYKC51">Wellness Vision (Jan20-Mar20)</option>
			<option value="RHGT6VYVNB0T7QNM">OYM Class 2 (Jan20-Mar20)</option>
		
			
			<option value="9TGAVYYWUAL5KUQ">OYM Class 1 (Oct19 -Dec19)</option>
			<option value="DHFIHNZBDXNFXBDY">OYM Class 2 (Oct19 -Dec19)</option>
			<option value="39QQYKT3NEVQUV2B">Wellness Vision (Oct19 -Dec19)</option>
			<option value="JPNQ23L97HYMNTAK">Generative Moments (Oct19 -Dec19)</option>
			<option value="1CHRTF12D1XK7S">OYE (Oct19 -Dec19)</option>
			
			
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