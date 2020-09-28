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

#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
</style>

<cfoutput>
	<div class="overlay">
		<div id="loading-img"></div>
	</div>
	<cfset local.foundConference = 0>

	<form name="maestroClass" method="post">
		
		<p>Please select the conference from the drop down menu below to see your hours attended:</p>
		<cfinclude template="inc/attendance.cfm" />
		<input type="submit" name="displayAttendance" id="button" value="Show my attendance">

	</form>


    <cfif structKeyExists(form, 'displayAttendance')>
        <cfset  myQuery = queryNew("email,name,start,end,calltime","Varchar,Varchar,Varchar,Varchar,Varchar") />
        <cfset caller=StructNew() />
        <cfset local.emails = "" />
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
                    <cfset local.emails = listAppend(local.emails, local.person.email) />
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
                            <cfset person[local.person.pin] = local.person.email>
                            <cfset local.emails = listAppend(local.emails, local.person.email) />
						</cfif>
					</cfloop>

                    <cfloop array="#local.rtnJSON.value.caller#" index="local.caller">
                           
                                    
                        <cfif listFindNoCase(local.emails, local.caller.email)>
                            
                            <cfset local.time = ceiling(dateDiff("n",listGetat(local.caller.startTime,4,' '),listGetat(local.caller.endTime,4,' '))) />
                            
                            <cfscript>
                                caller={email=lcase(local.caller.email),name=lcase(local.caller.tag),start=DateFormat(parsedateTime(local.rtnJSON.value.call.actualStartTime,'EEE MMM dd HH:nn:ss zzz yyyy'),'mm/dd/yyyy'),end=DateFormat(parsedateTime(local.rtnJSON.value.call.actualEndTime,'EEE MMM dd HH:nn:ss zzz yyyy'),'mm/dd/yyyy'),calltime=local.time};
                                QueryAddRow(myQuery,caller);
                            </cfscript>
                        </cfif>
                       
                    </cfloop>    
                   
				</cfif>
				<!--- end local.rtnJsonDetails.value.caller --->
			</cfloop>
			<!--- end local.rtnJsonDetails.value.calls --->
			</cfif>
	</cfloop>
<cfquery name="result" dbtype="query" >
    select *
    from myQuery
    order by email asc, start
</cfquery>
<table id="customers">
    <tr>
        <td>&nbsp;</td>
        <th>Name</th>
        <th>Email</th>
        <th colspan="100%" style="align:center">Lessons</th>
    </tr>

    <cfset local.count = 1 />
    <cfloop query="result" group="email">
        <tr>
            <td style="width:2%">#local.count++#</td>
            <td style="width:10%">#name#</td>
            <td style="width:10%">#email#</td>
            
            <cfloop group="start">
                <cfset local.time = 0 />
                <cfloop>
                    <cfset local.time = local.time + calltime />
                </cfloop>
                <td <cfif local.time lte 5>style="background-color:red;color:white"</cfif>>
                    #DateFormat(result.start,'mm/dd/yyyy')#<br />
                   
                        #local.time#
                  
                    
                </td>
            </cfloop>
        </tr>
    </cfloop> 
</table>
</cfif>	
</cfoutput>
