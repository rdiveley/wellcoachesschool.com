<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$( document ).ready(function() {
    $( ".conferenceid" ).change(function() {
       $('#conference').val($(' option:selected').text());
    });
});    
</script>
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
		<input type="hidden" name="conference" id="conference" />
		<p>Please select the conference from the drop down menu below to see your hours attended:</p>
		<cfinclude template="inc/attendance.cfm" />
		<input type="submit" name="displayAttendance" id="button" value="Show my attendance">
        <input type="checkbox" name="export" value="1">Export
        
	</form>

    

    <cfif structKeyExists(form, 'displayAttendance')>
        <cfset  myQuery = queryNew("email,name,startdate,enddate,calltime","Varchar,Varchar,date,date,Varchar") />
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
                                caller={email=lcase(local.caller.email),name=lcase(local.caller.tag),startdate=DateFormat(parsedateTime(local.rtnJSON.value.call.actualStartTime,'EEE MMM dd HH:nn:ss zzz yyyy'),'mm/dd/yyyy'),enddate=DateFormat(parsedateTime(local.rtnJSON.value.call.actualEndTime,'EEE MMM dd HH:nn:ss zzz yyyy'),'mm/dd/yyyy'),calltime=local.time};
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
    order by email asc, startdate
</cfquery>

<cfquery name="startdate" dbtype="query">
    select min(startdate) as startdate
    from result
</cfquery>

<cfquery name="enddate" dbtype="query">
    select max(enddate) as enddate
    from result
</cfquery>
<style>
    span {
    font-family: "Arial";
    font-size: 15px;
    display: inline-block;
    vertical-align: top;
    }
</style>

<cfif result.recordcount>

<cfif structKeyExists(form, 'export') and form.export EQ 1>
    <cfheader name="content-disposition" value="inline;filename=attendance-#dateFormat(now(),'mm-dd/yyyy')#.xls">
    <cfcontent type="application/msexcel">
</cfif> 
    <table id="customers">
        <tr>
            <td>&nbsp;</td>
            <th>Name</th>
            <th>Email</th>
            <cfloop from="#DateFormat(DateAdd("d", "-#DayOfWeek(startdate.startdate) - 1#", startdate.startdate), "mm/dd/yyyy")#" to="#enddate.enddate#" index="local.date" step="#CreateTimeSpan(7,0,0,0)#">
                <th  style="align:center">#dateformat(local.date, "mm/dd/yyyy")# - #DateFormat(DateAdd("d", "6", local.date), "mm/dd/yyyy")#</th>
            </cfloop>
        </tr>
        
            <cfloop query="result" group="email">
                <tr>
                <td>&nbsp;</td>
                <td style="width:10%">#name#</td>
                <td style="width:10%">#email#</td>

                <cfloop from="#DateFormat(DateAdd("d", "-#DayOfWeek(startdate.startdate) - 1#", startdate.startdate), "mm/dd/yyyy")#" to="#enddate.enddate#" index="local.date" step="#CreateTimeSpan(7,0,0,0)#">
                    <cfset local.fromdate = dateFormat(local.date,'mm/dd/yyyy') />
                    <cfset local.todate = DateFormat(DateAdd("d",7,local.date),'mm/dd/yyyy') />
                    <cfset local.count = "" />
                   
                    <td>
                        <cfloop group="startdate"> 
                            
                            <cfset local.startdate = dateFormat(result.startdate,'mm/dd/yyyy') />
                            <cfset local.enddate = dateFormat(result.enddate,'mm/dd/yyyy') />
                            <!--- start date is >= column header and < next column header --->
                            <cfif ( dateCompare(local.startdate, local.fromdate) EQ 1 OR dateCompare(local.startdate, local.fromdate) EQ 0 ) AND ( dateCompare(local.enddate, local.todate) EQ -1 ) >
                                <cfloop>
                                    <cfif form.conference contains '(9wk)'>
                                        <span > #dateFormat(local.enddate,'mm/dd')# - <span style="color:green">#calltime#</span> </span><br />
                                    </cfif>
                                    <cfset local.count = listAppend(local.count, calltime) />
                                </cfloop>
                            </cfif>
                        </cfloop>
                       
                        <cfset local.calltime = 0 />
                        
                        <cfloop list="#local.count#" item="local.time">
                            <cfset local.calltime = local.calltime + local.time />
                        </cfloop>
                            <cfset local.style = "" />

                        <cfif form.conference contains '(9wk)'>
                            <cfif local.calltime lte 100>
                                <cfset local.style="background-color:##F08080" />
                            </cfif>
                            <cfif local.calltime gte 102 and local.calltime lte 143 >
                                <cfset local.style="background-color:yellow" />
                            </cfif>

                        <cfelse>
                            <cfif local.calltime lt 50>
                                <cfset local.style="background-color:##F08080" />
                            </cfif>
                            <cfif local.calltime gt 50 and local.calltime lt 71 >
                                <cfset local.style="background-color:yellow" />
                            </cfif>
                        </cfif>

                        <div style="#local.style#;padding:5px;padding-top:5px">
                            #local.calltime# 
                        </div>
                       
                    </td>
                </cfloop>
                </tr>
            </cfloop>
    </table>
</cfif>    
</cfif>	
</cfoutput>
