<cfcomponent>
	<cffunction access="remote" name="getClasses" output="true" returntype="query">
		<cfargument name="status" required="false" type="string" default="all">

		<cfquery name="completeClasses" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select *, courses.status as xstatus, CONVERT(CHAR(10),courses.startDate,101) as startDate
			from courses, courseSummaries
			where courseSummaries.classid=courses.courseid
			<cfif #arguments.status# neq "all">
				and courses.status='#arguments.status#'
			</cfif>
		</cfquery>
		<cfreturn completeClasses>
	</cffunction>
	
	<cffunction name="getClassSearch" output="true" returntype="query" access="remote">
		<cfargument name="classType" type="string" required="NO" default="0">
		<cfargument name="facultyname" type="string" required="NO" default="0">
		<cfargument name="startPrice" type="string" required="NO" default="0">
		<cfargument name="endPrice" type="string" required="NO" default="0">
		<cfargument name="status" type="string" required="NO" default="YES">
		<cfargument name="StartDate" type="string" required="NO" default="0">

		<cfset StartDate=dateformat(dateadd("d",1,Arguments.StartDate),"mm/dd/yyyy")>
		<cfquery name="completeClasses" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courses, courseSummaries
			where courseSummaries.classid=courses.courseid
			<cfif #arguments.classType# neq "0">
				and courses.courseType='#arguments.classType#'
			</cfif>
			<cfif #arguments.facultyname# neq "0">
				and facultyname like '#arguments.facultyname#%'
			</cfif>	
			<cfif #arguments.StartPrice# neq "0">
				<cfset StartPrice=#arguments.StartPrice# - 1>
				and courseprice < #StartPrice#
			</cfif>
			<cfif #arguments.endPrice# neq "0">
				<cfset endPrice=#arguments.endPrice# + 1>
				and courseprice > #endPrice#
			</cfif>
			and Status='#arguments.Status#'
			and StartDate > '#StartDate#'
			and not courseCategory = 6 and not courseCategory = 7
		</cfquery>

		<cfreturn completeClasses>
	</cffunction>
	
	<cffunction access="remote" name="getClassbyCatgeory" output="true" returntype="query">
		<cfargument name="classCat" required="false" type="string" default="all">
		<cfquery name="completeClasses" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courses, courseSummaries
			where courseSummaries.classid=courses.courseid
			<cfif #arguments.classCat# neq "all">
				and courses.courseCategory='#arguments.classCat#'
			</cfif>
		</cfquery>
		
		<cfreturn completeClasses>
	</cffunction>
	
	<cffunction access="remote" name="getTheClass" output="true" returntype="query">
		<cfargument name="ClassID" required="true" type="string">
		<cfquery name="completeClass" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select courses.*, courseSummaries.*,
			CONVERT(CHAR(10),courses.startDate,101) as sdate
			from courses,courseSummaries
			where courseSummaries.classid=courses.courseid
			and courses.courseID=#arguments.ClassID#
		</cfquery>
		<cfreturn completeClass>
	</cffunction>
	
	<cffunction access="remote" name="traineeClassforReg" output="true" returntype="query">
		<cfargument name="StartDate" required="true" type="string">
		<cfquery name="completeClass" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select courses.*, courseSummaries.*,
			CONVERT(CHAR(10),courses.startDate,101) as sdate
			from courses,courseSummaries
			where courseSummaries.classid=courses.courseid
			and courses.startdate>'#arguments.StartDate#'
			and courses.courseType=2
		</cfquery>

		<cfreturn completeClass>
	</cffunction>
	
	<cffunction name="changeClassStatus" access="remote" output="true" returntype="string">
		<cfargument name="CourseID" required="true" type="string">
		<cfargument name="theStatus" required="true" type="string">
		<cfquery name="getClass" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update courses
			set status='#arguments.theStatus#'
			where courses.courseID=#arguments.ClassID#
		</cfquery>
		<cfreturn arguments.theStatus>
	</cffunction>
	
	<cffunction access="remote" name="getMovies" output="true" returntype="query">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="LessonNo" type="string" required="false" default="none">
		
		<cfif #arguments.LessonNo# is "none">
			<cfset selectstatement=" where ClassID=#arguments.ClassID#">
		<cfelse>
			<!--- <cfset LessonNo=LessonNo + 1>  --->
			<cfset selectstatement=" where ClassID=#trim(arguments.ClassID)# and LessonNo=#trim(LessonNo)#">
		</cfif>
		<cfquery name="Movies" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from recordedclasses
			#selectstatement#
		</cfquery>
		<cfif #movies.recordcount# is 0>
			<cfset selectstatement=" where classID=123 and LessonNo=#trim(LessonNo)#">
			<cfquery name="Movies" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from recordedclasses
				#selectstatement#
			</cfquery>
		</cfif>
		<cfreturn Movies>
	</cffunction>
	
	<cffunction access="remote" name="getHandouts" output="true" returntype="query">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="LessonNo" type="string" required="false" default="none">
		
		<cfif #arguments.LessonNo# is "none">
			<cfset selectstatement=" where ClassID=#arguments.ClassID#">
		<cfelse>
			<!--- <cfset LessonNo=LessonNo + 1> 
	 --->		<cfset selectstatement=" where ClassID=#arguments.ClassID# and LessonNo=#LessonNo#">
		</cfif>
		<cfquery name="Handouts" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from coursehandouts
			#selectstatement#
		</cfquery>
		<cfif #handouts.recordcount# is 0>
			<cfset selectstatement=" where ClassID=123 and LessonNo=#LessonNo#">
			<cfquery name="Handouts" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from coursehandouts
				#selectstatement#
			</cfquery>
		</cfif>
		<cfreturn Handouts>
	</cffunction>
	
	<cffunction access="remote" name="getLessons" output="true" returntype="query">
		<cfargument name="ClassID" type="string" required="true">
		<cfquery name="Lessons" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courselessons
			where classid=#arguments.classID#
			 order by lessonNumber
		</cfquery>

		<cfreturn Lessons>
	</cffunction>
	
	<cffunction access="remote" name="getFullLesson" output="true" returntype="query">
		<cfargument name="ClassTime" type="string" required="true">
		<cfargument name="CourseID" type="string" required="true">

		<cfquery name="Lessons" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select  courselessons.lessontitle , courselessons.lessonID as thisLessonID,
			members.firstname, members.lastname, courselessons.lessonNumber, courseSchedules.ScheduleDay,
			courseSchedules.ScheduleDate, courseSchedules.BridgeLine, courseSchedules.StartTime 
			from courseschedules, courselessons, members
			where courseschedules.courseid=#arguments.courseID# 
			and courseschedules.classid=#arguments.ClassTime#
			and courselessons.classid=courseschedules.courseid
			and courselessons.lessonnumber=courseschedules.lessonid
			and courseschedules.facultyID=members.memberID
		</cfquery>

		<cfreturn Lessons>
	</cffunction>
	
	<cffunction access="remote" name="getSchedules" output="true" returntype="query">
		<cfargument name="ClassID" type="string" required="true">

		<cfquery name="xSchedules" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseSchedules
			where courseID=#arguments.ClassID#
			order by ClassID, LessonID
		</cfquery>
		<Cfset Schedules=QueryNew("ScheduleID,CourseID,ClassID,LessonID,StartDate,StartTime,ScheduleDay,ScheduleDate,FacultyID,BridgeLIne,Duration,status")>
		<cfquery name="classes" dbtype="query">
			select distinct ClassID from xSchedules
		</cfquery>
		<cfoutput query="classes">
			<cfquery name="tSchedules" dbtype="query">
				select * from xSchedules where ClassID=#classes.ClassID#
			</cfquery>
			<cfloop query="tSchedules" startrow="1" endrow="1">
				<CFSET newRow  = QueryAddRow(Schedules, 1)>
				<CFSET temp = QuerySetCell(Schedules, "ScheduleID","#ScheduleID#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "CourseID","#trim(CourseID)#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "ClassID","#trim(tSchedules.ClassID)#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "LessonID","#LessonID#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "StartDate","#dateformat(StartDate,'mm/dd/yyyy')#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "StartTime","#timeformat(StartTime,'h:mm tt')#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "ScheduleDay","#ScheduleDay#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "ScheduleDate","#dateformat(ScheduleDate,'mm/dd/yyyy')#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "FacultyID","#trim(FacultyID)#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "BridgeLIne","#BridgeLIne#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "Duration","#trim(Duration)#", #newRow#)>
				<CFSET temp = QuerySetCell(Schedules, "Status","#trim(Status)#", #newRow#)>
			</cfloop>
		</cfoutput>
		<cfreturn Schedules>
	</cffunction>
	
	<cffunction access="remote" name="getMovie" output="true" returntype="query">
		<cfargument name="MovieID" type="string" required="true">

		<cfquery name="Movies" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from recordedclasses
			where RecordedID=#arguments.MovieID#
		</cfquery>
		<cfreturn Movies>
	</cffunction>
	
	<cffunction access="remote" name="getSchedule" output="true" returntype="query">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="CourseID" type="string" required="true">

		<cfquery name="xSchedule" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseSchedules
			where CourseID=#arguments.CourseID# and ClassID=#arguments.ClassID#
		</cfquery>
		<cfoutput>courseSchedules=#xSchedule.recordcount#<br></cfoutput>
		<cfset Schedule=QueryNew("ScheduleID,CourseID,ClassID,LessonID,StartDate,StartTime,ScheduleDay,ScheduleDate,FacultyID,BridgeLIne,Duration,Month,Day,Year,Status")>
		<cfoutput query="xSchedule">
			<cfset xMonth=month(scheduledate) - 1>
			<cfset xDay=day(scheduledate) - 1>
			<cfset xYear=year(scheduledate)>
			<cfset xStartTime=timeformat(StartTime,"hh:mm tt")>
			<cfset xHour=timeformat(StartTime,"hh")>
			<cfset xMinute=timeformat(StartTime,"mm")>
			<cfset xAMPM=timeformat(StartTime,"tt")>
			<cfset StartTimeIndex=0>
			<cfif xAMPM is "AM">
				<cfif xHour is "12">
					<cfif xMinute is "30">
						<cfset StartTimeIndex=1>
					<cfelse>
						<cfset StartTimeIndex=0>
					</cfif>
				<cfelse>
					<cfif xMinute is "30">
						<cfset StartTimeIndex=#xHour#*2 + 1>
					<cfelse>
						<cfset StartTimeIndex=#xHour#*2>
					</cfif>
				</cfif>
			</cfif>
			<cfif xAMPM is "PM">
			<cfoutput>xHour=#xHour#<br></cfoutput>
				<cfif xHour is "12">
					<cfif xMinute is "30">
						<cfset StartTimeIndex=23>
					<cfelse>
						<cfset StartTimeIndex=22>
					</cfif>
				<cfelse>
					<cfif xMinute is "30">
						<cfset StartTimeIndex=#xHour#*2 + 23>
					<cfelse>
						<cfset StartTimeIndex=#xHour#*2 + 22>
					</cfif>
				</cfif>
			</cfif>
			<cfset xDayOfWeek=dayofweek(scheduledate) - 1>
			<cfif #duration# is 15><cfset xDuration=0></cfif>
			<cfif #duration# is 30><cfset xDuration=1></cfif>
			<cfif #duration# is 60><cfset xDuration=2></cfif>
			<cfif #duration# is 90><cfset xDuration=3></cfif>
			<cfif #duration# is 120><cfset xDuration=4></cfif>
			<CFSET newRow  = QueryAddRow(Schedule, 1)>
			<CFSET temp = QuerySetCell(Schedule, "ScheduleID","#trim(ScheduleID)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "CourseID","#trim(CourseID)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "ClassID","#trim(ClassID)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "LessonID",#int(LessonID)#, #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "StartDate","#dateformat(StartDate,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "StartTime","#StartTimeIndex#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "ScheduleDay","#trim(xDayOfWeek)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "ScheduleDate","#dateformat(ScheduleDate,'mm/dd/yyyy')#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "FacultyID","#trim(FacultyID)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "BridgeLIne","#trim(BridgeLIne)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "Duration","#int(xDuration)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "Month","#int(xMonth)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "Day","#int(xDay)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "Year","#int(xYear)#", #newRow#)>
			<CFSET temp = QuerySetCell(Schedule, "Status","#Status#", #newRow#)>
			<br>
		</cfoutput>
		<cfreturn Schedule>
	</cffunction>
	
	<cffunction access="remote" name="getLessonSchedule" output="true" returntype="query">
		<cfargument name="SCHEDULEID" type="string" required="true">
		<cfquery name="Schedule" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select *,CONVERT(CHAR(10),ScheduleDate,101) as sDate from courseSchedules
			where SCHEDULEID=#arguments.SCHEDULEID#
		</cfquery>
		<cfreturn Schedule>
	</cffunction>
	
	<cffunction access="remote" name="getLesson" output="true" returntype="query">
		<cfargument name="LessonID" type="string" required="true">
		<cfset LessonID=#arguments.LessonID#>

		<cfquery name="Lessons" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courselessons
			where LessonID=#LessonID#
		</cfquery>
		<cfreturn Lessons>
	</cffunction>
	
	<cffunction access="remote" name="getHandout" output="true" returntype="query">
		<cfargument name="HandoutID" type="string" required="true">
		<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from coursehandouts
			where HandoutID=#arguments.HandoutID#
		</cfquery>
		<cfreturn Handout>
	</cffunction>
	
	<cffunction access="remote" name="uploadHandout" output="true" returntype="query">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="HandoutFilename" type="string" required="true">
		<cfargument name="HandoutID" type="string" required="true" default="0">
		
		<cfset Handout=#arguments.HandoutID#>
		<cfif #int(arguments.HandoutID)# is 0>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into coursehandouts (filename,classID,lessonNo,dateuploaded,dateended)
				values ('#arguments.HandoutFilename#',#arguments.ClassID#,#arguments.lessonID#,'#dateformat(now(),'yyyy/mm/dd')#','1900/01/01')
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(HandoutID) as NewID from coursehandouts
			</cfquery>
			<cfset Handout=#getNewID.NewID#>
		<cfelse>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update coursehandouts
			set filename='#arguments.HandoutFilename#', 
			classid=#arguments.ClassID#, 
			lessonNo=#arguments.lessonID#
			where HandoutID=#arguments.HandoutID#
			</cfquery>
		</cfif>
		<cfreturn Handout>
	</cffunction>
	
	<cffunction access="remote" name="uploadMovie" output="true" returntype="query">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="MovieFilename" type="string" required="true">
		<cfargument name="MovieID" type="string" required="true" default="0">
		
		<cfset Movie=#arguments.MovieID#>
		<cfif #arguments.MovieID# is 0>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into recordedclasses (recordID,Description,FileName,ClassID,LessonNo)
				values (0,'none','#arguments.FileName#',#arguments.ClassID#,#arguments.LessonID#)
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(RecordedID) as NewID from recordedclasses
			</cfquery>
			<cfset Movie=#getNewID.NewID#>
		<cfelse>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update recordedclasses
			set FileName='#arguments.filename#', 
			ClassID=#arguments.ClassID#, 
			lessonNo=#arguments.lessonID#
			where RecordedID=#arguments.MovieID#
			</cfquery>
		</cfif>
		<cfreturn Movie>
	</cffunction>
	
	<cffunction access="remote" name="deleteMovie" output="true" returntype="string">
		<cfargument name="MovieID" type="string" required="true">
		<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from recordedclasses where recordedID=#arguments.MovieID#
		</cfquery>
	</cffunction>
	
	<cffunction access="remote" name="saveMovie" output="true" returntype="string">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="MovieID" type="string" required="true">
		<cfargument name="filename" type="string" required="true">

		<cfset MovieID=#trim(arguments.MovieID)#>
		<cfset description=replace(#arguments.description#,",","~","ALL")>

		<cfif #arguments.MovieID# is 0>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into recordedclasses (recordID,Description,FileName,ClassID,LessonNo)
				values (0,'#arguments.description#','#arguments.FileName#',#arguments.ClassID#,#arguments.LessonID#)
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(recordedID) as NewID from recordedclasses
			</cfquery>
			<cfset MovieID=#getNewID.NewID#>
		<cfelse>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update recordedclasses
				set FileName='#arguments.filename#', 
				description='#arguments.description#',
				ClassID=#arguments.ClassID#, 
				lessonNo=#arguments.lessonID#
				where RecordedID=#arguments.MovieID#
			</cfquery>
		</cfif>
		
		
		<cfreturn MovieID>
	</cffunction>
	
	<cffunction access="remote" name="saveHandout" output="true" returntype="string">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="HandoutFilename" type="string" required="true">
		<cfargument name="HandoutID" type="string" required="true" default="0">
		<cfargument name="description" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="faculty" type="string" required="true">

		<cfset handoutID=#arguments.HandoutID#>
		<cfset arguments.lessonID=#arguments.lessonID# + 1>
		<cfif #arguments.HandoutID# is 0>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into coursehandouts (description,title,filename,faculty,classID,width,lessonNo,dateuploaded,dateended)
				values ('#arguments.description#','#arguments.title#','#arguments.handoutFilename#',#arguments.faculty#,#arguments.ClassID#,0,#arguments.lessonID#,'#dateformat(now(),"mm/dd/yyyy")#','1/1/1900')
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(HandoutID) as NewID from coursehandouts
			</cfquery>
			<cfset HandoutID=#getNewID.NewID#>
		<cfelse>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update coursehandouts
				set description='#arguments.description#', 
				title='#arguments.title#',
				faculty=#arguments.faculty#
				where HandoutID=#arguments.HandoutID#
			</cfquery>
		</cfif>

		<cfreturn HandoutID>
	</cffunction>
	
	<cffunction access="remote" name="deleteHandout" output="true" returntype="string">
		<cfargument name="HandoutID" type="string" required="true">
		<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from coursehandouts where HandoutID=#arguments.HandoutID#
		</cfquery>
	</cffunction>
	
	<cffunction name="saveLesson" access="remote" returntype="string" output="true">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="lessonNumber" type="string" required="true">
		<cfargument name="lessonTitle" type="string" required="true">
		<cfargument name="description" type="string" required="true">
		<cfargument name="phone" type="string" required="true">
		<cfargument name="date" type="string" required="true">
		<cfargument name="facultyID" type="string" required="true">
		
		<cfset theDate="1900/01/01">
		<cfset LessonID=#arguments.LessonID#>
		<cfif isDate(#arguments.date#)><cfset theDate=dateformat(#arguments.date#,"yyyy/mm/dd")></cfif>
		<cfif #int(LessonID)# gt 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update courselessons
				set description='#arguments.description#', 
				lessonTitle='#arguments.lessonTitle#',
				phone='#arguments.phone#', 
				ClassID=#arguments.ClassID#,
				lessonNumber=#arguments.lessonNumber#,
				theDate='#theDate#',
				facultyID=#arguments.facultyID#
				where LessonID=#arguments.LessonID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courselessons (ClassID,lessonNumber,lessonTitle,description,phone,date,facultyID)
				values (#arguments.ClassID#,#arguments.lessonNumber#,'#arguments.lessonTitle#','#arguments.description#','#arguments.phone#','#theDate#',#arguments.facultyID#)
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(LessonID) as NewID from courselessons
			</cfquery>
			<cfset LessonID=#getNewID.NewID#>
		</cfif>
		<cfreturn LessonID>
	</cffunction>
	
	<cffunction access="remote" name="saveSchedule" output="true" returntype="string">
		<cfargument name="ScheduleID" type="string" required="true">
		<cfargument name="CourseID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="StartDate" type="string" required="true">
		<cfargument name="StartTime" type="string" required="true">
		<cfargument name="ScheduleDay" type="string" required="true">
		<cfargument name="ScheduleDate" type="string" required="true">
		<cfargument name="Duration" type="string" required="true">
		<cfargument name="status" type="string" required="false" default="0">
		<cfargument name="BridgeLIne" type="string" required="false" default="0">
		
		<cfset ScheduleID=#arguments.ScheduleID#>
		
		<cfif #int(ScheduleID)# gt 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update courseSchedules
				set ScheduleDay='#arguments.ScheduleDay#',
				Duration=#arguments.Duration#, 
				StartDate='#StartDate#',
				StartTime='#arguments.StartTime#',
				status=#arguments.status#
				where CourseID=#arguments.CourseID# and ClassID=#arguments.ClassID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courseSchedules (CourseID,ClassID,LessonID,StartDate,StartTime,ScheduleDay,ScheduleDate,FacultyID,BridgeLIne,Duration,status)
				values (#arguments.CourseID#,#arguments.ClassID#,1,'#dateformat(arguments.StartDate,'yyyy/mm/dd')#','#arguments.StartTime#','#arguments.ScheduleDay#','#dateformat(arguments.ScheduleDate,'yyyy/mm/dd')#',0,'#arguments.BridgeLine#',#arguments.Duration#,#arguments.status#)
			</cfquery>
			<cfquery name="getNewID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(ScheduleID) as NewID from courseSchedules
			</cfquery>
			<cfset ScheduleID=#getNewID.NewID#>
		</cfif>
		<cfreturn ScheduleID>
	</cffunction>
	
	<cffunction access="remote" name="getFacultyList" output="true" returntype="query">

		<CFQUERY name="GetFaculty" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#" >
			SELECT Members.FirstName, 
			Members.LastName, Email.EMailAddress, Members.StartDate, Members.EndDate, 
			Members.Logon, Members.SubTypeID, Members.Banned, Members.Active, members.password,
			Members.MemberID , SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and (members.subtypeid=2 or members.occupation like '%2%')
			Order by Members.lastname
		</CFQUERY>
		
		<cfset GetRecord=QueryNew("FirstName,LastName,EMailAddress,StartDate,EndDate,Logon,SubTypeID,Banned, Active,password,MemberID,Subtype")>
		<cfoutput query="GetFaculty">
			<cfset xFirstName="#trim(firstname)# ">
			<cfset xLastname=#trim(lastname)#>
			<CFSET newRow  = QueryAddRow(GetRecord, 1)>
			<CFSET temp = QuerySetCell(GetRecord, "FirstName","#xFirstName#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "LastName","#trim(xLastName)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "lastname","#trim(lastname)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "EMailAddress","#trim(EMailAddress)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "StartDate","#trim(StartDate)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "EndDate","#EndDate#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "Logon","#trim(Logon)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "SubTypeID","#trim(SubTypeID)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "Banned","#trim(Banned)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "Active","#trim(Active)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "password","#trim(password)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "MemberID","#trim(MemberID)#", #newRow#)>
			<CFSET temp = QuerySetCell(GetRecord, "Subtype","#trim(Subtype)#", #newRow#)>
		</cfoutput>
		<cfreturn GetRecord>
	</cffunction>
	
	<cffunction access="remote" name="getStudentList" output="true" returntype="query">

		<CFQUERY name="GetRecord" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#" >
			SELECT Members.FirstName, 
			Members.LastName, Email.EMailAddress, Members.StartDate, Members.EndDate, 
			Members.Logon, Members.SubTypeID, Members.Banned, Members.Active, members.password,
			Members.MemberID , SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and ((members.subtypeid=1 or members.occupation like '%1%') or (members.subtypeid=3 or members.occupation like '%3%') or (members.subtypeid=8 or members.occupation like '%8%') or (members.subtypeid=9 or members.occupation like '%9%'))
			Order by Members.lastname
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>
	
	<cffunction access="remote" name="getTraineeList" output="true" returntype="query">

		<CFQUERY name="GetRecord" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#" >
			SELECT Members.FirstName, 
			Members.LastName, Email.EMailAddress, Members.StartDate, Members.EndDate, 
			Members.Logon, Members.SubTypeID, Members.Banned, Members.Active, members.password,
			Members.MemberID , SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and (members.subtypeid=6 or members.occupation like '%6%')
			Order by Members.lastname
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>
	
	<cffunction access="remote" name="getLicenseeList" output="true" returntype="query">

		<CFQUERY name="GetRecord" datasource="#application.DSN#" 
			password="#application.DSNpWord#" username="#application.DSNuName#" >
			SELECT Members.FirstName, 
			Members.LastName, Email.EMailAddress, Members.StartDate, Members.EndDate, 
			Members.Logon, Members.SubTypeID, Members.Banned, Members.Active, members.password,
			Members.MemberID , SubscriptionType.SubDescription as Subtype
			FROM Members, SubscriptionType, Email
			Where SubscriptionType.SubTypeID = Members.SubTypeID
			and email.tableid=15
			and email.connectid = members.memberid
			and email.websiteid=1
			and (members.subtypeid=7 or members.occupation like '%7%')
			Order by Members.lastname
		</CFQUERY>
		<cfreturn GetRecord>
	</cffunction>
	
	<cffunction name="getAMember" access="remote" output="true" returntype="query">
		<cfargument name="logon" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		<cfargument name="withemail" type="string" required="false" default="0">
		<cfargument name="withPhone" type="string" required="false" default="0">
		
		<cfquery name="theMember" datasource="#application.DSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#" maxrows=1>
			select members.memberid, members.FirstName, Members.LastName
			<Cfif #arguments.withemail# gt 0>,email.emailaddress</cfif>
			<Cfif #arguments.withPhone# gt 0>,phonenumbers.phonenumber</cfif>
			from members
			<Cfif #arguments.withemail# gt 0>,email</cfif>
			<Cfif #arguments.withPhone# gt 0>,phonenumbers</cfif>
			where members.memberid=#arguments.logon#
			and (members.subtypeid=#arguments.userType# or members.occupation like '%#arguments.userType#%')
			<Cfif #arguments.withPhone# gt 0>
			and phonenumbers.connectid=members.memberid
			and phonenumbers.phonetypeid=2
			and phonenumbers.tableid=15
			</cfif>
			<Cfif #arguments.withemail# gt 0>
			and email.connectid=members.memberid
			and email.websiteid=1
			and email.tableid=15
			</cfif>
		</cfquery>
		
		<Cfset getMember=QueryNew("memberid,firstname,lastname,emailaddress,phonenumber")>
		<cfoutput query="theMember">
		<cfif #arguments.withemail# gt 0>
			<cfif #arguments.withPhone# gt 0>
				
				<CFSET newRow  = QueryAddRow(getMember, 1)>
				<CFSET temp = QuerySetCell(getMember, "memberid","#memberid#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "firstname","#trim(firstname)#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "lastname","#trim(lastname)#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "emailaddress","#trim(emailaddress)#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "phonenumber","#trim(phonenumber)#", #newRow#)>
			<cfelse>
				<Cfset getMember=QueryNew("memberid,firstname,lastname,emailaddress")>
				<CFSET newRow  = QueryAddRow(getMember, 1)>
				<CFSET temp = QuerySetCell(getMember, "memberid","#memberid#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "firstname","#trim(firstname)#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "lastname","#trim(lastname)#", #newRow#)>
				<CFSET temp = QuerySetCell(getMember, "emailaddress","#trim(emailaddress)#", #newRow#)>
			</cfif>
		<cfelse>
			<Cfset getMember=QueryNew("memberid,firstname,lastname")>
			<CFSET newRow  = QueryAddRow(getMember, 1)>
			<CFSET temp = QuerySetCell(getMember, "memberid","#memberid#", #newRow#)>
			<CFSET temp = QuerySetCell(getMember, "firstname","#trim(firstname)#", #newRow#)>
			<CFSET temp = QuerySetCell(getMember, "lastname","#trim(lastname)#", #newRow#)>
		</cfif>
		</cfoutput>
		
		<cfreturn getMember>
	</cffunction>
	
	<cffunction name="getNewUpload" access="remote" returntype="query" output="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="LessonID" type="string" required="true">
		<cfargument name="HandoutID" type="string" required="true">
		
		<cfset HandoutID=#arguments.HandoutiD#>
		<cfset ClassID=#arguments.ClassID#>
		<cfset LessonID=#arguments.LessonID#>
		
		<cfif int(HandoutID) is 0>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from coursehandouts
				where ClassID=#ClassID# and LessonID=#LessonID#
			</cfquery>
		<cfelse>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select * from coursehandouts
				where HandoutID=#HandoutID#
			</cfquery>
		</cfif>
		
		<cfreturn Handout>
	</cffunction>
	
	<cffunction name="deleteLessonSchedule" access="remote" output="true" returntype="string">
		<cfargument name="ScheduleID" type="string" required="yes">
		<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from courseSchedules
			where ScheduleID=#ScheduleID#
		</cfquery>
		<cfreturn ScheduleID>
	</cffunction>
	
	<cffunction access="remote" name="saveLessonSchedule" output="true" returntype="string">
		<cfargument name="ScheduleID" type="string" required="true">
		<cfargument name="CourseID" type="string" required="true">
		<cfargument name="ClassID" type="string" required="true">
		<cfargument name="StartTime" type="string" required="true">
		<cfargument name="ScheduleDay" type="string" required="true">
		<cfargument name="ScheduleDate" type="string" required="true">
		<cfargument name="Duration" type="string" required="true">
		<cfargument name="LessonID" type="string" required="false" default="1">
		<cfargument name="FacultyID" type="string" required="false" default="0">
		<cfargument name="Bridgeline" type="string" required="false" default="">
		<cfargument name="status" type="string" required="false" default="0">
		<cfset ScheduleID=#arguments.ScheduleID#>
		
		<cfif #int(ScheduleID)# gt 0>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update courseSchedules set
				CourseID=#arguments.CourseID#,
				ClassID=#arguments.ClassID#,
				LessonID=#arguments.LessonID#,
				StartTime='#arguments.StartTime#',
				ScheduleDay='#arguments.ScheduleDay#',
				ScheduleDate='#dateformat(arguments.ScheduleDate,'yyyy/mm/dd')#',
				FacultyID=#arguments.FacultyID#,
				Bridgeline='#arguments.BridgeLIne#',
				Duration=#arguments.Duration#,
				Status=#arguments.status#
				Where ScheduleID=#arguments.ScheduleID#
			</cfquery>
		<cfelse>
			<cfquery name="Handout" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courseSchedules (CourseID,ClassID,LessonID,StartDate,StartTime,ScheduleDay,ScheduleDate,FacultyID,BridgeLIne,Duration,status)
				values (#arguments.CourseID#,#arguments.ClassID#,#arguments.LessonID#,'#dateformat(arguments.ScheduleDate,'yyyy/mm/dd')#','#arguments.StartTime#','#arguments.ScheduleDay#','#dateformat(arguments.ScheduleDate,'yyyy/mm/dd')#',#arguments.FacultyID#,'#arguments.BridgeLine#' ,#arguments.Duration#,#arguments.status#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ScheduleID) as NewID from courseSchedules
			</cfquery>
			<cfset ScheduleID=#getMaxID.NewID#>
		</cfif>
		<cfreturn ScheduleID>
	</cffunction>
	
	<cffunction name="saveClass" access="remote" output="true" returntype="string">
		<cfargument name="CourseID" required="true" type="string">
		<cfargument name="abbrev" required="true" type="string">
		<cfargument name="filename" required="true" type="string">
		<cfargument name="coursetype" required="true" type="string">
		<cfargument name="coursetitle" required="true" type="string">
		<cfargument name="course_summary" required="true" type="string">
		<cfargument name="startdate" required="true" type="string">
		<cfargument name="NoOfLessons" required="true" type="string">
		<cfargument name="thestatus" required="true" type="string">
		<cfargument name="CoursePrice" required="true" type="string">
		<cfargument name="CourseCategory" required="true" type="string">
		<cfargument name="Logon" required="true" type="string">
		<cfargument name="CourseName" required="true" type="string">
		<cfargument name="SummaryID" required="true" type="string">
		<cfargument name="subtitle" required="true" type="string">
		<cfargument name="distribution" required="true" type="string">
		<cfargument name="FacultyBio" required="true" type="string">
		<cfargument name="degree" required="true" type="string">
		<cfargument name="degree_other" required="true" type="string">
		<cfargument name="certifications" required="true" type="string">
		<cfargument name="experience" required="true" type="string">
		<cfargument name="studentemail" required="true" type="string">
		<cfargument name="email" required="true" type="string">
		<cfargument name="objectives" required="true" type="string">
		
		<cfset CourseID=#arguments.CourseID#>
		<cfset startdate=#dateformat(arguments.startdate,"yyyy/mm/dd")#>
		
		<cfif #int(courseID)# gt 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update courses set
				abbrev='#arguments.abbrev#',
				filename='#arguments.filename#',
				coursetype=#arguments.coursetype#,
				coursetitle='#arguments.coursetitle#' ,
				course_summary='#arguments.course_summary#',
				startdate='#arguments.startdate#',
				NoOfLessons=#arguments.NoOfLessons#,
				status='#arguments.thestatus#',
				CoursePrice=#arguments.CoursePrice#,
				CourseCategory=#arguments.CourseCategory#,
				Logon=#arguments.Logon#,
				CourseName='#arguments.CourseName#'
				where CourseID=#arguments.CourseID#
			</cfquery>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			update coursesummaries set
				ClassID=#arguments.CourseID#,
				subtitle='#arguments.subtitle#',
				distribution='#arguments.distribution#',
				FacultyBio='#arguments.FacultyBio#',
				degree='#arguments.degree#',
				degree_other='#arguments.degree_other#',
				certifications='#arguments.certifications#',
				experience='#arguments.experience#',
				studentemail='#arguments.studentemail#',
				email='#arguments.email#',
				objectives='#arguments.objectives#'
				where summaryID=#arguments.summaryID#
			</cfquery>
		<cfelse>
			<cfinvoke method="getAMember" returnvariable="facultyname">
				<cfinvokeargument name="logon" value="#arguments.Logon#">
				<cfinvokeargument name="userType" value="2">
			</cfinvoke>
			<CF_aGr_password mode="alpha" 
				case="upper" 
				length="5,8" var="Coursename">
			<cfset filename="#facultyname.firstname#_#coursename#">
			
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courses (abbrev,filename,coursetype,coursetitle,course_summary,startdate,NoOfLessons,status,CoursePrice,CourseCategory,Logon,CourseName)
				values ('#arguments.abbrev#','#filename#',#arguments.coursetype#,'#arguments.coursetitle#' ,'#arguments.course_summary#' ,'#startdate#',#arguments.NoOfLessons#,'#arguments.thestatus#',#arguments.CoursePrice#,#arguments.CourseCategory#,#arguments.Logon#,'#CourseName#')
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(CourseID) as NewID from courses
			</cfquery>
			<cfset CourseID=#getMaxID.NewID#>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into coursesummaries (ClassID,subtitle,distribution,FacultyBio,degree,degree_other,certifications,experience,studentemail,email,objectives)
				values (#CourseID#,'#arguments.subtitle#','#arguments.distribution#','#arguments.FacultyBio#' ,'#arguments.degree# ','#arguments.degree_other#', '#arguments.certifications#', '#arguments.experience#', '#arguments.studentemail#','#arguments.email#','#arguments.objectives#')
			</cfquery>
		</cfif>
		
		<cfreturn CourseID>
	</cffunction>
	
	<cffunction access="remote" name="getClassTypes" output="true" returntype="query">
		
		<cfquery name="courseTypes" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseTypes
		</cfquery>
		<cfreturn courseTypes>
	</cffunction>
	
	<cffunction access="remote" name="getClassType" output="true" returntype="query">
		<cfargument name="TypeName" required="true" type="string">
		<cfquery name="courseTypes" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseTypes
			where typename='#trim(arguments.TypeName)#'
		</cfquery>
		<cfreturn courseTypes>
	</cffunction>
	
	<cffunction access="remote" name="editClassType" output="true" returntype="query">
		<cfargument name="TypeID" required="true" type="string">
		<cfquery name="courseTypes" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseTypes
			where TypeID=#arguments.TypeID#
		</cfquery>
		<cfreturn courseTypes>
	</cffunction>
	
	<cffunction access="remote" name="getClassCategory" output="true" returntype="query">
		<cfargument name="CategoryName" required="true" type="string">
		<cfquery name="categories" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseCategories
			where CategoryName='#arguments.CategoryName#'
		</cfquery>
		<cfreturn categories>
	</cffunction>
	
	<cffunction access="remote" name="editClassCategory" output="true" returntype="query">
		<cfargument name="CatID" required="true" type="string">
		
		<cfquery name="xcategories" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseCategories
			where ClassCatID=#arguments.CatID#
		</cfquery>
	
		<cfset categories=QueryNew("ClassCatID,CategoryName,Description,showOnPage,ClassType")>
		<cfoutput query="xcategories">
			<CFSET newRow  = QueryAddRow(categories, 1)>
			<CFSET temp = QuerySetCell(categories, "ClassCatID","#ClassCatID#", #newRow#)>
			<CFSET temp = QuerySetCell(categories, "CategoryName","#CategoryName#", #newRow#)>
			<CFSET temp = QuerySetCell(categories, "Description","#Description#", #newRow#)>
			<CFSET temp = QuerySetCell(categories, "showOnPage","#showOnPage#", #newRow#)>
			<CFSET temp = QuerySetCell(categories, "ClassType","#ClassType#", #newRow#)>
		</cfoutput>
		<cfreturn categories>
	</cffunction>
	
	<cffunction access="remote" name="getClassCategories" output="true" returntype="query">
		<cfquery name="categories" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseCategories
		</cfquery>
		<cfreturn categories>
	</cffunction>
	
	<cffunction name="getStudentSummary" access="remote" output="true" returntype="query">
		<cfargument name="CourseID" type="string" required="true">
		
		<cfset CourseID=#arguments.CourseID#>
		<cfquery name="Xclass" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courses
			where CourseID=#CourseID#
		</cfquery>
		<cfset xClassID=#Xclass.CourseName#>
		<cfquery name="purchased" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from coursesPurchased
			where CourseID like '%#xClassID#%'
			order by ClassTime
		</cfquery>
		<cfquery name="schedules" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from courseSchedules
			where CourseID=#CourseID#
			order by ClassID
		</cfquery>
		<cfquery name="GetStudents" datasource="#application.DSN#" username="#application.DSNuName#" password="#application.DSNpWord#">
			select firstname, lastname, memberid from members
			where subtypeid <> 2
		</cfquery>
		<cfset getAllStudents=QueryNew("PurchaseID,TraineeID,Invoice,StudentName,ScheduleDay,Price,dateSignedUp")>
			
		<cfset tCounter=0>
		<cfset studentCounter=#purchased.recordcount#>
		<cfset totalPrice=0>
		<Cfset tClassTime="#Purchased.ClassTime#">
		<cfoutput query="purchased">
			<cfquery name="getStudent" dbtype="query">
				select * from GetStudents where memberid=#trim(MEMBERID)#
			</cfquery>
			<cfif #getStudent.recordcount# neq 0>
			<cfset totalPrice=#totalPrice# + #PRICEPAID#>
			<cfif #trim(ClassTime)# neq "">
				<cfset tCounter=#tCounter# + 1>
				<cfquery name="getSchedule" dbtype="query">
					select * from schedules where Classid=#ClassTime#
				</cfquery>
				<cfif #tClassTime# neq #ClassTime#>
					<cfquery name="getSchedule2" dbtype="query">
						select * from schedules where Classid=#tClassTime#
					</cfquery>
					<cfset tClassTime=#ClassTime#>
					<cfset tCounter=#tCounter# - 1>
					<CFSET newRow  = QueryAddRow(getAllStudents, 1)>
					<CFSET temp = QuerySetCell(getAllStudents, "PurchaseID","", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "TraineeID","", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "Invoice"," ", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "StudentName","Total Students for", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "ScheduleDay","#getSchedule2.ScheduleDay#", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "Price","#tCounter#", #newRow#)>
					<CFSET temp = QuerySetCell(getAllStudents, "dateSignedUp"," ", #newRow#)>
					<cfset tCounter=1>
				</cfif>
				<Cfif #getSchedule.recordcount# gt 0>
					<cfset ScheduleDay=dateformat(#getSchedule.ScheduleDate#,"dddd")>
					<cfset LastScheduleDay=ScheduleDay>
					<cfset ScheduleDay="#ScheduleDay#, #TimeFormat(getSchedule.StartTime,'hh:mm')# ET">
				<cfelse>
					<cfset ScheduleDay="">
				</Cfif>
			<cfelse>
				<cfset ScheduleDay="">
			</cfif>
			
			<cfset fullname="#trim(getStudent.firstname)# #trim(getStudent.lastname)#">
			
			<CFSET newRow  = QueryAddRow(getAllStudents, 1)>
			<CFSET temp = QuerySetCell(getAllStudents, "PurchaseID","#Purchased.ID#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "TraineeID","#MemberID#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "Invoice",#int(Invoice)#, #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "StudentName","#Fullname#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "ScheduleDay","#ScheduleDay#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "Price","#PRICEPAID#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "dateSignedUp","#dateformat(DATESIGNEDUP,'mm/dd/yyyy')#", #newRow#)>
			</cfif>
		</cfoutput>
		<Cfif #ScheduleDay# neq "">
			<CFSET newRow  = QueryAddRow(getAllStudents, 1)>
			<CFSET temp = QuerySetCell(getAllStudents, "PurchaseID","", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "TraineeID","", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "Invoice"," ", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "StudentName","Total Students for", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "ScheduleDay","#LastScheduleDay#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "Price","#tCounter#", #newRow#)>
			<CFSET temp = QuerySetCell(getAllStudents, "dateSignedUp"," ", #newRow#)>
		</Cfif>
		<CFSET newRow  = QueryAddRow(getAllStudents, 1)>
		<CFSET temp = QuerySetCell(getAllStudents, "PurchaseID","", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "TraineeID","", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "Invoice"," ", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "StudentName"," ", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "ScheduleDay","Total Price", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "Price","#dollarformat(totalprice)#", #newRow#)>
		<CFSET temp = QuerySetCell(getAllStudents, "dateSignedUp"," ", #newRow#)>
			
		<cfreturn GetAllStudents>
	</cffunction>
	
	<cffunction name="getPages" access="remote" returntype="query" output="true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
			<cfinvokeargument name="orderByStatement" value=" order by pagename">
		</cfinvoke>
		<cfreturn AllPages>
	</cffunction>
	
	<cffunction access="remote" name="saveClassType" output="true" returntype="string">
		<cfargument name="TypeID" type="string" required="true">
		<cfargument name="TypeName" type="string" required="true">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="ShowOnPage" type="array" required="true">

		<cfset TypeID=#trim(arguments.TypeID)#>
		<cfset description=replace(#arguments.Description#,",","~","ALL")>
		<cfset ShowOnPage=#trim(replace(arguments.ShowOnPage,",","~","ALL"))#>
		
		<cfif #TypeID# neq 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update courseTypes set 
				TypeName='#TypeName#',description='#description#',ShowOnPage='#ShowOnPage#'
				where TypeID=#TypeID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courseTypes ( TypeName,Description,ShowOnPage )
				values (
				'#TypeName#','#description#','#ShowOnPage#' )
			</cfquery>
			<cfquery name="GetMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select Max(TypeID) as NewID from courseTypes
			</cfquery>
			<cfset TypeID=#GetMaxID.NewID#>
		</cfif>
		<cfreturn TypeID>
	</cffunction>
	
	<cffunction name="deleteClassType" output="true" returntype="string" access="remote">
		<cfargument name="TypeID" type="string" required="yes">
		<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from  courseTypes 
			where TypeID=#arguments.TypeID#
		</cfquery>
	</cffunction>
	
	<cffunction access="remote" name="saveClassCategories" output="true" returntype="string">
		<cfargument name="ClassCatID" type="string" required="true">
		<cfargument name="CategoryName" type="string" required="true">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="ShowOnPage" type="array" required="true">
		<cfargument name="ClassType" type="string" required="true">

		<cfset ClassCatID=#trim(arguments.ClassCatID)#>
		<cfset description=#arguments.Description#>
		<cfset ShowOnPage=#trim(arguments.ShowOnPage)#>
		<cfset ClassType=#trim(arguments.ClassType)#>
		<cfset CategoryName=#trim(arguments.CategoryName)#>
		
		<cfif #ClassCatID# neq 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update courseCategories  set
				ClassType=#ClassType#,CategoryName='#CategoryName#',description='#Description#',showonpage='#ShowOnPage#'
				where ClassCatID=#arguments.ClassCatID#
			</cfquery>
		<cfelse>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into courseCategories  (ClassType,CategoryName,Description,showOnPage) values (
				#ClassType#,'#CategoryName#','#Description#','#ShowOnPage#'
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ClassCatID) as NewID from courseCategories
			</cfquery>
			<cfset ClassCatID=#getMaxID.NewID#>
		</cfif>
		<cfreturn ClassCatID>
	</cffunction>
	
	<cffunction name="deleteClassCategory" output="true" returntype="string" access="remote">
		<cfargument name="ClassCatID" type="string" required="yes">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from courseCategories where ClassCAtID=#arguments.ClassCatID#
		</cfquery>
	</cffunction>
	
	<cffunction name="getGeneralConfig" access="remote" returntype="query" output="true">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="generalConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfreturn config>
	</cffunction>
	
	<cffunction access="remote" name="saveGeneralConfig" output="true" returntype="string">
		<cfargument name="gateway" type="string" required="yes">
		<cfargument name="username" type="string" required="yes">
		<cfargument name="password" type="string" required="yes">
		<cfargument name="BGColor" type="string" required="yes">
		<cfargument name="studentType" type="string" required="yes">
		<cfargument name="facultyType" type="string" required="yes">
		<cfargument name="traineeType" type="string" required="yes">
		<cfargument name="licenseeType" type="string" required="yes">
		<cfargument name="NoOfDays" type="string" required="yes">
		<cfargument name="AlertText" type="string" required="yes">
		
		<cfset gateway=#arguments.gateway#>
		<cfset username=#arguments.username#>
		<cfset password=#arguments.password#>
		<cfset BGColor=#arguments.BGColor#>
		<cfset studentType=#arguments.studentType#>
		<cfset facultyType=#arguments.facultyType#>
		<cfset traineeType=#arguments.traineeType#>
		<cfset licenseeType=#arguments.licenseeType#>
		<cfset NoOfDays=#arguments.NoOfDays#>
		<cfset AlertText=#replace(arguments.AlertText,",","~","ALL")#>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="generalConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfif #config.recordcount# neq 0>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			Method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="generalConfig">
				<cfinvokeargument name="XMLFields" value="gateway,username,password,BGColor,studentType,facultyType,traineeType,licenseeType,NoOfDays,AlertText">
				<cfinvokeargument name="XMLFieldData" value="#gateway#,#username#,#password#,#BGColor#,#studentType#,#facultyType#,#traineeType#,#licenseeType#,#NoOfDays#,#AlertText#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
			<cfset ConfigID="0000000001">
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				Method="insertXMLRecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="generalConfig">
				<cfinvokeargument name="XMLFields" value="gateway,username,password,BGColor,studentType,facultyType,traineeType,licenseeType,NoOfDays,AlertText">
				<cfinvokeargument name="XMLFieldData" value="#gateway#,#username#,#password#,#BGColor#,#studentType#,#facultyType#,#traineeType#,#licenseeType#,#NoOfDays#,#AlertText#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
		</cfif>
		<cfreturn ConfigID>
	</cffunction>
	
	<cffunction access="remote" name="getMemberTypes" output="true" returntype="query">
		<cfquery name="memberTypes" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select * from subscriptionType order by SubDescription
		</cfquery>
		<cfreturn memberTypes>
	</cffunction>
	
	<cffunction name="getLicenseeConfig" access="remote" returntype="query" output="true">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="licenseeConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfreturn config>
	</cffunction>
	
	<cffunction access="remote" name="saveLicenseeConfig" output="true" returntype="string">
		<cfargument name="licenseeType" type="string" required="yes">
		<cfargument name="licenseeSignUp" type="string" required="yes">
		<cfargument name="licenseeProfile" type="string" required="yes" default="0">
		<cfargument name="licenseeCheckOut" type="string" required="yes">
		<cfargument name="licenseeHome" type="string" required="yes">
		<cfargument name="licenseeSearch" type="string" required="yes">
		<cfargument name="licenseeSchedule" type="string" required="yes">
		<cfargument name="licenseeManual" type="string" required="yes">
		<cfargument name="licenseeCert" type="string" required="yes">
		<cfargument name="licenseeCorpCert" type="string" required="yes">
		<cfargument name="licenseeCertText" type="string" required="yes">
		<cfargument name="trainingCert" type="string" required="yes">
		<cfargument name="checkOut" type="string" required="yes">
		<cfargument name="startPage" type="string" required="yes">
		<cfargument name="licenseeEmail" type="string" required="yes">
		<cfargument name="licenseeAccept" type="string" required="yes">

		<cfset licenseeType=#arguments.licenseeType#>
		<cfset licenseeSignUp=#arguments.licenseeSignUp#>
		<cfset licenseeProfile=#arguments.licenseeProfile#>
		<cfset licenseeCheckOut=#arguments.licenseeCheckOut#>
		<cfset licenseeHome=#arguments.licenseeHome#>
		<cfset licenseeSearch=#arguments.licenseeSearch#>
		<cfset licenseeSchedule=#arguments.licenseeCheckOut#>
		<cfset licenseeManual=#arguments.licenseeHome#>
		<cfset licenseeCert=#arguments.licenseeSearch#>
		<cfset licenseeCorpCert=#replace(arguments.licenseeCorpCert,",","~","ALL")#>
		<cfset licenseeCertText=#replace(arguments.licenseeCertText,",","~","ALL")#>
		<cfset trainingCert=#replace(arguments.trainingCert,",","~","ALL")#>
		<cfset checkOut=#replace(arguments.checkOut,",","~","ALL")#>
		<cfset startPage=#replace(arguments.startPage,",","~","ALL")#>
		<cfset licenseeEmail=#replace(arguments.licenseeEmail,",","~","ALL")#>
		<cfset licenseeAccept=#replace(arguments.licenseeAccept,",","~","ALL")#>
		<cfset fields="licenseeType,licenseeSignUp,licenseeProfile,licenseeCheckOut,licenseeHome,licenseeSearch,licenseeSchedule,licenseeManual,licenseeCert,licenseeCorpCert,licenseeCertText,trainingCert,checkOut,startPage,licenseeEmail,licenseeAccept">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="licenseeConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfif #config.recordcount# neq 0>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			Method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="licenseeConfig">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#licenseeType#,#licenseeSignUp#,#licenseeProfile#,#licenseeCheckOut#,#licenseeHome#,#licenseeSearch#,#licenseeSchedule#,#licenseeManual#,#licenseeCert#,#licenseeCorpCert#,#licenseeCertText#,#trainingCert#,#checkOut#,#startPage#,#licenseeEmail#,#licenseeAccept#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
			<cfset ConfigID="0000000001">
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				Method="insertXMLRecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="licenseeConfig">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#licenseeType#,#licenseeSignUp#,#licenseeProfile#,#licenseeCheckOut#,#licenseeHome#,#licenseeSearch#,#licenseeSchedule#,#licenseeManual#,#licenseeCert#,#licenseeCorpCert#,#licenseeCertText#,#trainingCert#,#checkOut#,#startPage#,#licenseeEmail#,#licenseeAccept#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
		</cfif>
		<cfreturn ConfigID>
	</cffunction>
	
	<cffunction name="getTraineeConfig" access="remote" returntype="query" output="true">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="traineeConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfreturn config>
	</cffunction>
	
	<cffunction access="remote" name="saveTraineeConfig" output="true" returntype="string">
		<cfargument name="traineeType" type="string" required="yes">
		<cfargument name="traineeSignUp" type="string" required="yes">
		<cfargument name="traineeProfile" type="string" required="yes" default="0">
		<cfargument name="traineeCheckOut" type="string" required="yes">
		<cfargument name="traineeHome" type="string" required="yes">
		<cfargument name="traineeSearch" type="string" required="yes">
		<cfargument name="profile" type="string" required="yes">
		<cfargument name="profileEdit" type="string" required="yes">
		<cfargument name="account" type="string" required="yes">
		<cfargument name="afterAccount" type="string" required="yes">
		<cfargument name="checkOut" type="string" required="yes">
		<cfargument name="startPage" type="string" required="yes">
		<cfargument name="traineeEmail" type="string" required="yes">
		<cfargument name="passwordText" type="string" required="yes">
		<cfargument name="courseType" type="string" required="yes">
		
		<cfset traineeType=#arguments.traineeType#>
		<cfset traineeSignUp=#arguments.traineeSignUp#>
		<cfset traineeProfile=#arguments.traineeProfile#>
		<cfset traineeCheckOut=#arguments.traineeCheckOut#>
		<cfset traineeHome=#arguments.traineeHome#>
		<cfset traineeSearch=#arguments.traineeSearch#>
		<cfset courseType=#arguments.courseType#>
		<cfset profile=#replace(arguments.profile,",","~","ALL")#>
		<cfset profileEdit=#replace(arguments.profileEdit,",","~","ALL")#>
		<cfset account=#replace(arguments.account,",","~","ALL")#>
		<cfset afterAccount=#replace(arguments.afterAccount,",","~","ALL")#>
		<cfset checkOut=#replace(arguments.checkOut,",","~","ALL")#>
		<cfset startPage=#replace(arguments.startPage,",","~","ALL")#>
		<cfset traineeEmail=#replace(arguments.traineeEmail,",","~","ALL")#>
		<cfset passwordText=#replace(arguments.passwordText,",","~","ALL")#>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="traineeConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfif #config.recordcount# neq 0>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			Method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="traineeConfig">
				<cfinvokeargument name="XMLFields" value="traineeType,traineeSignUp,traineeProfile,traineeCheckOut,traineeHome,traineeSearch,profile,profileEdit,account,afterAccount,checkOut,startPage,traineeEmail,passwordText,courseType">
				<cfinvokeargument name="XMLFieldData" value="#traineeType#,#traineeSignUp#,#traineeProfile#,#traineeCheckOut#,#traineeHome#,#traineeSearch#,#profile#,#profileEdit#,#account#,#afterAccount#,#checkOut#,#startPage#,#traineeEmail#,#passwordText#,#courseType#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
			<cfset ConfigID="0000000001">
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				Method="insertXMLRecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="traineeConfig">
				<cfinvokeargument name="XMLFields" value="traineeType,traineeSignUp,traineeProfile,traineeCheckOut,traineeHome,traineeSearch,profile,profileEdit,account,afterAccount,checkOut,startPage,traineeEmail,passwordText,courseType">
				<cfinvokeargument name="XMLFieldData" value="#traineeType#,#traineeSignUp#,#traineeProfile#,#traineeCheckOut#,#traineeHome#,#traineeSearch#,#profile#,#profileEdit#,#account#,#afterAccount#,#checkOut#,#startPage#,#traineeEmail#,#passwordText#,#courseType#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
		</cfif>
		<cfreturn ConfigID>
	</cffunction>
	
	<cffunction name="getStudentConfig" access="remote" returntype="query" output="true">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="studentConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfreturn config>
	</cffunction>
	
	<cffunction access="remote" name="saveStudentConfig" output="true" returntype="string">
		<cfargument name="studentType" type="string" required="yes">
		<cfargument name="studentSignUp" type="string" required="yes">
		<cfargument name="studentProfile" type="string" required="yes" default="0">
		<cfargument name="studentCheckOut" type="string" required="yes">
		<cfargument name="studentHome" type="string" required="yes">
		<cfargument name="studentSearch" type="string" required="yes">
		<cfargument name="profile" type="string" required="yes">
		<cfargument name="profileEdit" type="string" required="yes">
		<cfargument name="account" type="string" required="yes">
		<cfargument name="afterAccount" type="string" required="yes">
		<cfargument name="checkOut" type="string" required="yes">
		<cfargument name="startPage" type="string" required="yes">
		<cfargument name="studentEmail" type="string" required="yes">
		<cfargument name="passwordText" type="string" required="yes">
		
		<cfset studentType=#arguments.studentType#>
		<cfset studentSignUp=#arguments.studentSignUp#>
		<cfset studentProfile=#arguments.studentProfile#>
		<cfset studentCheckOut=#arguments.studentCheckOut#>
		<cfset studentHome=#arguments.studentHome#>
		<cfset studentSearch=#arguments.studentSearch#>
		<cfset profile=#replace(arguments.profile,",","~","ALL")#>
		<cfset profileEdit=#replace(arguments.profileEdit,",","~","ALL")#>
		<cfset account=#replace(arguments.account,",","~","ALL")#>
		<cfset afterAccount=#replace(arguments.afterAccount,",","~","ALL")#>
		<cfset checkOut=#replace(arguments.checkOut,",","~","ALL")#>
		<cfset startPage=#replace(arguments.startPage,",","~","ALL")#>
		<cfset studentEmail=#replace(arguments.studentEmail,",","~","ALL")#>
		<cfset passwordText=#replace(arguments.passwordText,",","~","ALL")#>
		
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" method="getXMLRecords" returnvariable="config">
			<cfinvokeargument name="ThisPath" value="files/courses">
			<cfinvokeargument name="ThisFileName" value="studentConfig">
			<cfinvokeargument name="selectstatement" value=" where ConfigID='0000000001'">
		</cfinvoke>
		<cfif #config.recordcount# neq 0>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
			Method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="studentConfig">
				<cfinvokeargument name="XMLFields" value="studentType,studentSignUp,studentProfile,studentCheckOut,studentHome,studentSearch,profile,profileEdit,account,afterAccount,checkOut,startPage,studentEmail,passwordText">
				<cfinvokeargument name="XMLFieldData" value="#studentType#,#studentSignUp#,#studentProfile#,#studentCheckOut#,#studentHome#,#studentSearch#,#profile#,#profileEdit#,#account#,#afterAccount#,#checkOut#,#startPage#,#studentEmail#,#passwordText#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
				<cfinvokeargument name="XMLIDValue" value="0000000001">
			</cfinvoke>
			<cfset ConfigID="0000000001">
		<cfelse>
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler"
				Method="insertXMLRecord" returnvariable="ConfigID">
				<cfinvokeargument name="ThisPath" value="files/courses">
				<cfinvokeargument name="ThisFileName" value="studentConfig">
				<cfinvokeargument name="XMLFields" value="studentType,studentSignUp,studentProfile,studentCheckOut,studentHome,studentSearch,profile,profileEdit,account,afterAccount,checkOut,startPage,studentEmail,passwordText">
				<cfinvokeargument name="XMLFieldData" value="#studentType#,#studentSignUp#,#studentProfile#,#studentCheckOut#,#studentHome#,#studentSearch#,#profile#,#profileEdit#,#account#,#afterAccount#,#checkOut#,#startPage#,#studentEmail#,#passwordText#">
				<cfinvokeargument name="XMLIDField" value="ConfigID">
			</cfinvoke>
		</cfif>
		<cfreturn ConfigID>
	</cffunction>
	
	<cffunction name="getMembers" access="remote" returntype="query" output="true">
		<cfargument name="TypeID" default="0" required="false" type="string">
		<cfargument name="alphabet" default="a" required="false" type="string">
		<cfquery name="members" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from members, email
			where email.connectid=members.memberid
			and email.websiteid=1
			and (members.lastname like '#arguments.alphabet#%' or members.lastname like '#ucase(arguments.alphabet)#%')
			<cfif #arguments.TypeID# neq 0>
				and ((members.subtypeid=#arguments.TypeID#) or (occupation like '%#arguments.TypeID#%'))
			</cfif>
		</cfquery>
		<cfreturn members>
	</cffunction>
	
	<cffunction name="deleteMember" access="remote" returntype="string" output="true">
		<cfargument name="MemberID" type="string" required="yes">
		
		<cfset MemberID=#arguments.MemberID#>
		<CFQUERY name="DeleteRecord" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#" maxRows=1>
			DELETE
			FROM Members
			WHERE Members.MemberID = #MemberID#
			
					
			Delete from email
			where connectid=#MemberID#
			and tableid=15
			
			delete from addresses
			where connectid=#MemberID#
			and tableid=15
			
			delete from phonenumbers
			where connectid=#MemberID#
			and tableid=15
		</CFQUERY>
	</cffunction>
	
	<cffunction name="saveMember" access="remote" returntype="string" output="true">
		<cfargument name="MemberID" type="string" required="yes">
		<cfargument name="firstName" type="string" required="yes">
		<cfargument name="lastname" type="string" required="yes">
		<cfargument name="company" type="string" required="yes">
		<cfargument name="username" type="string" required="yes">
		<cfargument name="Pword" type="string" required="yes">
		<cfargument name="SubTypeID" type="string" required="yes">
		<cfargument name="MembershipCost" type="string" required="yes">
		<cfargument name="active" type="string" required="yes">
		<cfargument name="email" type="string" required="yes">
		<cfargument name="Address1" type="string" required="yes">
		<cfargument name="Address2" type="string" required="yes">
		<cfargument name="City" type="string" required="yes">
		<cfargument name="State" type="string" required="yes">
		<cfargument name="PostalCode" type="string" required="yes">
		<cfargument name="Country" type="string" required="yes">
		<cfargument name="PhoneNumber" type="string" required="yes">
		<cfargument name="WorkPHone" type="string" required="yes">
		<cfargument name="FaxPhone" type="string" required="yes">
		<cfargument name="CellPhone" type="string" required="yes">
		<cfargument name="AGe" type="string" required="yes">
		<cfargument name="birthDAY" type="string" required="yes">
		<cfargument name="Occupation" type="string" required="yes">
		<cfargument name="MemberURL" type="string" required="yes">
		<cfargument name="startdate" type="string" required="yes">
		<cfargument name="enddate" type="string" required="yes">
		<cfargument name="altemail" type="string" required="yes">
		<cfargument name="sex" type="string" required="yes">
		
		<cfset today=#dateformat(now())#>
		
		<cfif not isdate(arguments.startdate)>
			<cfset arguments.startdate=#dateformat(now())#>
			<cfset arguments.enddate=#dateadd("d",365,#today#)#>
		</cfif>
		
		<cfset arguments.LastModified=#today#>
		
		<cfif #arguments.MemberID# is 0>
			<cfquery name="Insert" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
		INSERT INTO Members
				 ( firstName,
				 lastname,
				 companyname,
				 StartDate,
				 EndDate,
				 Logon,
				 Password,
				 SubTypeID,
				 WebSiteID,
				 FeePaid,
				 Active,
				 LastModified,
				 WebSiteURL,
				 age,
				 sex,
				 occupation,
				 birthdate) 
			 
			VALUES 
				( '#arguments.firstName#',
				'#arguments.lastname#',
				<cfif isdefined('company')>'#arguments.company#',<cfelse>'',</cfif>
				 '#dateformat(Today)#',
				 '#dateformat(enddate)#',
				 '#arguments.username#',
				 '#arguments.Pword#',
				 #arguments.SubTypeID#,
				 0,
				 #MembershipCost#,
				 0,
				 '#arguments.LastModified#',
				 '#arguments.memberURL#',
				 #arguments.age#,
				 '#arguments.sex#',
				 '#arguments.occupation#',
				 '#arguments.birthday#')
			</cfquery>
			<cfquery name="GetNextID" datasource = "#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
				select max(MemberID) as NewID from Members
			</cfquery>
			<cfset NewID = #GetNextID.NewID#>
			<cfquery name="Insert" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
				 
			INSERT INTO Email 
				 ( EMailAddress,
				 TableID,
				 ConnectID,
				 WebSiteID) 
			 
			VALUES 
				( '#arguments.EMail#',
				 15,
				 #NewID#,
				 1)
			
			INSERT INTO Email 
				 ( EMailAddress,
				 TableID,
				 ConnectID,
				 WebSiteID) 
			 
			VALUES 
				( '#arguments.altemail#',
				 15,
				 #NewID#,
				 2)
				
			INSERT INTO Addresses
				 ( AddressTypeID,
				 Address1,
				 Address2,
				 City,
				 State,
				 PostalCode,
				 Country,
				 TableID,
				 ConnectID) 
			 
			VALUES 
				( 1,
				 '#arguments.Address1#',
				 '#arguments.Address2#',
				 '#arguments.City#',
				 '#arguments.State#',
				 '#arguments.PostalCode#',
				 '#arguments.Country#',
				 15,
				 #NewID#)
				
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.PhoneNumber#',
				 15,
				 #NewID#,
				 1)
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.WorkPhone#',
				 15,
				 #NewID#,
				 2)
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.faxPhone#',
				 15,
				 #NewID#,
				 3)
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.cellPhone#',
				 15,
				 #NewID#,
				 4)
			</cfquery>
			<cfset memberid=#newid#>
		<cfelse>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
Update Members Set
			 FirstName='#arguments.FirstName#',
			 LastName='#arguments.LastName#',
			 <cfif isnumeric(#arguments.Age#)>AGe=#arguments.AGe#,</cfif>
			 <cfif isdate(#arguments.birthday#)>
		BirthDate='#dateformat(arguments.birthday,"mm/dd/yyyy")#',</cfif>
			 Occupation='#arguments.Occupation#',
			 sex='#arguments.sex#',
			 CompanyName='#arguments.company#',
			 LastModified='#dateformat(now())#',
			 WebSiteURL='#arguments.MemberURL#',
			 Active=#arguments.Active#,
			 logon='#arguments.username#',
			 Password='#arguments.Pword#',
			 enddate='#dateformat(arguments.enddate)#'
			 where MemberID = #MemberID#
		
			update Email set
			 EMailAddress='#arguments.email#'
			 where TableID=15
			 and ConnectID=#MemberID#
			 and WebSiteID= 1
			 
			update email set
			 EMailAddress='#arguments.altemail#'
			 where TableID=15
			 and ConnectID=#MemberID#
			 and WebSiteID= 2
		
			update Addresses set
			 AddressTypeID=1,
			 Address1='#arguments.Address1#',
			 Address2='#arguments.Address2#',
			 City='#arguments.City#',
			 State='#arguments.State#',
			 PostalCode='#arguments.PostalCode#'
			 where TableID=15
			 and ConnectID=#MemberID#
			
			Update PhoneNumbers  set
			 PhoneNumber='#trim(arguments.phonenumber)#'
			 Where TableID=15
			 and ConnectID=#MemberID#
			 and phonetypeid=1
		
		 
		</cfquery>
		
		<cfquery name="GetPHones" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select (select phoneid from phonenumbers where connectid=#MemberID# and tableid=15 and phonetypeid=2) as workphoneid,
			(select phoneid from phonenumbers where connectid=#MemberID# and tableid=15 and phonetypeid=3) as faxphoneID,
			(select phoneid from phonenumbers where connectid=#MemberID# and tableid=15 and phonetypeid=4) as cellphoneID
		</cfquery>
		<cfset WorkPhoneID=0>
		<cfset FaxPhoneID=0>
		<cfset CellPhoneID=0>
		<cfif GetPhones.Recordcount gt 0>
			<cfset WorkPhoneID=GetPhones.workphoneid>
			<cfset FaxPhoneID=GetPhones.FaxPhoneID>
			<cfset CellPhoneID=GetPhones.CellPhoneID>
		</cfif>
		
		<cfif #arguments.WorkPHone# is 5>
			<cfset arguments.WorkPHone=''>
		</cfif>
		<cfif left(#arguments.WorkPHone#,3) is "5,5">
			<cfset arguments.WorkPHone=replacenocase(#arguments.WorkPHone#,"5,5","")>
		</cfif>
		<cfif #WorkPhoneID# gt 0>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			Update PhoneNumbers  set
			 PhoneNumber='#trim(arguments.WorkPHone)#'
			 Where PhoneID=#WorkPHoneID#
			 </cfquery>
		<cfelse>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.WorkPHone#',
				 15,
				 #MemberID#,
				 2)
			 </cfquery>
		</cfif>
		
		<cfif #arguments.faxphone# is 5>
			<cfset arguments.faxphone=''>
		</cfif>
		<cfif left(#arguments.faxphone#,3) is "5,5">
			<cfset arguments.faxphone=replacenocase(#arguments.faxphone#,"5,5","")>
		</cfif>
		<cfif #faxphoneID# gt 0>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			 Update PhoneNumbers  set
			 PhoneNumber='#trim(arguments.faxphone)#'
			 Where PhoneID=#FaxPhoneID#
			 </cfquery>
		<cfelse>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.faxphone#',
				 15,
				 #MemberID#,
				 3)
			 </cfquery>
		</cfif>

		<cfif #arguments.cellphone# is 5>
			<cfset arguments.cellphone=''>
		</cfif>
		<cfif left(#arguments.cellphone#,3) is "5,5">
			<cfset arguments.cellphone=replacenocase(#arguments.cellphone#,"5,5","")>
		</cfif>
		<cfif #cellphoneID# gt 0>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			Update PhoneNumbers  set
			 PhoneNumber='#trim(arguments.cellphone)#'
			 Where PhoneID=#CellPHoneID#
			 </cfquery>
		<cfelse>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			INSERT INTO PhoneNumbers 
				 ( PhoneNumber,
				 TableID,
				 ConnectID,
				 PhoneTypeID) 
			 
			VALUES 
				( '#arguments.cellphone#',
				 15,
				 #MemberID#,
				 4)
			 </cfquery>
		</cfif>
		
		<cfset AltEmailID=0>
		<cfquery name="GetAltEmail" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select EmailID from email where connectid=#MemberID# and tableid=15 and websiteid=2
		</cfquery>
		<cfif #GetAltEmail.RecordCount# gt 0>
			<cfset AltEmailID=#GetAltEmail.EmailID#>
		</cfif>
		<cfif #arguments.AltEmail# is 5 or #arguments.AltEmail# is "5,5">
			<cfset arguments.AltEmail=''>
		</cfif>
		<cfif #AltEmailID# gt 0>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			update email set
			 EMailAddress='#arguments.altemail#'
			 where EmailID=#AltEmailID#
			 </cfquery>
		<cfelse>
			<cfquery name="Update" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			insert into email (
			emailaddress,connectid,tableid,websiteid)
			values(
			'#arguments.altemail#',
			#MemberID#,15,2)
			 </cfquery>
		</cfif>
		</cfif>
		<cfreturn MemberID>
	</cffunction>
	
	<cffunction name="editMember" access="remote" output="true" returntype="query">
		<cfargument name="MemberID" type="string" required="yes">
		<cfquery name="themember" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			select top 1 *,
			(select phonenumber from phonenumbers 
			where phonenumbers.phonetypeid=2 
			and phonenumbers.connectid=#arguments.MemberID#) as workphone,
			(select phonenumber from phonenumbers 
			where phonenumbers.phonetypeid=3 
			and phonenumbers.connectid=#arguments.MemberID#) as faxphone,
			(select phonenumber from phonenumbers 
			where phonenumbers.phonetypeid=4 
			and phonenumbers.connectid=#arguments.MemberID#) as cellphone
			from members,email,phonenumbers,addresses
			where memberid=#arguments.MemberID#
			and email.connectID=members.memberid
			and email.websiteid=1
			and phonenumbers.connectid=members.memberid
			and phonenumbers.phonetypeid=1
			and addresses.connectid=members.memberid
			and addresses.addresstypeid=1
			order by addresses.addressid desc
		 </cfquery>
		 <cfquery name="email" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			 select connectid,emailaddress as altemail from email 
			 where email.connectid=#arguments.memberid# and email.websiteid=2
		 </cfquery>
		 <cfquery name="member" dbtype="query">
		 	select * from themember,email where email.connectid=themember.memberid
		 </cfquery>
		<cfreturn member>
	</cffunction>

	<cffunction name="getProfiles" access="remote" returntype="query" output="true">
		<cfargument name="ProfileID" required="no" default="0" >
		<cfquery name="Profiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from questionaires
			<cfif #arguments.ProfileID# neq 0>
				where ID=#arguments.ProfileID#
			</cfif>
		</cfquery>
		<cfset AllProfiles=QueryNew("ProfileID,ProfileDescription,ProfileName,DateStarted,DateEnded,NoOfQsPerPage,NoOfColumns,ProfileType")>
		<cfoutput query="Profiles">
			<cfset xDateStarted=#dateformat(DateStarted,"mm/dd/yyyy")#>
			<cfset xDateEnded=#dateFormat(DateEnded,"mm/dd/yyyy")#>
			<CFSET newRow  = QueryAddRow(AllProfiles, 1)>
			<CFSET temp = QuerySetCell(AllProfiles, "ProfileID",#Profiles.ID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "ProfileDescription",#Description#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "ProfileName",#Name#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "DateStarted",#xDateStarted#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "DateEnded",#xDateEnded#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "NoOfQsPerPage",#NoOfQsPerPage#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "NoOfColumns",#NoOfColumns#, #newRow#)>
			<CFSET temp = QuerySetCell(AllProfiles, "ProfileType",#PositionID#, #newRow#)>
		</cfoutput>
		<cfreturn AllProfiles>
	</cffunction>
	
	<cffunction name="deleteProfile" access="remote" output="true" returntype="string">
		<cfargument name="ProfileID" required="yes" type="string">
		<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from questionaires where ID=#arguments.ProfileID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveProfile" returntype="string" output="true">
		<cfargument name="ProfileID" type="string" required="yes">
		<cfargument name="ProfileDescription" type="string" required="yes">
		<cfargument name="ProfileName" type="string" required="yes">
		<cfargument name="DateStarted" type="string" required="yes">
		<cfargument name="DateEnded" type="string" required="yes">
		<cfargument name="NoOfQsPerPage" type="string" required="yes">
		<cfargument name="NoOfColumns" type="string" required="yes">
		<cfargument name="ProfileType" type="string" required="yes">
		
		<cfset ProfileID=#arguments.ProfileID#>
		<cfset ProfileDescription=#ProfileDescription#>
		<cfset ProfileName=#ProfileName#>
		<cfset DateStarted=#arguments.DateStarted#>
		<cfset DateEnded=#DateEnded#>
		<cfset NoOfQsPerPage=#NoOfQsPerPage#>
		<cfset NoOfColumns=#NoOfColumns#>
		<cfset ProfileType=#ProfileType#>
		
		<cfif ProfileID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update questionaires set
				Description='#ProfileDescription#',
				Name='#ProfileName#',
				DateStarted='#DateStarted#',
				DateEnded='#DateEnded#',
				NoOfQsPerPage=#NoOfQsPerPage#,
				NoOfColumns=#NoOfColumns#,
				PositionID=#ProfileType#
				where ID=#arguments.ProfileID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into questionaires (Description,Name,DateStarted,DateEnded,NoOfQsPerPage,NoOfColumns,PositionID)
				values (
				'#ProfileDescription#',
				'#ProfileName#',
				'#DateStarted#',
				'#DateEnded#',
				#NoOfQsPerPage#,
				#NoOfColumns#,
				#ProfileType#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from questionaires
			</cfquery>
			<cfset ProfileID=#getMaxID.NewID#>
		</cfif>

		<cfreturn ProfileID>
	</cffunction>
	
	<cffunction name="getProfileQs" access="remote" returntype="query" output="true">
		<cfargument name="ProfileID" required="no" default="0" >
		<cfargument name="ProfileCatID" required="no" default="0" >
		<cfargument name="QuestionID" required="no" default="0">
		
		<cfquery name="Questions" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from Questions
			<cfif #arguments.ProfileID# neq 0>
			where WEbsiteID=#arguments.ProfileID#
			</cfif>
			<cfif #arguments.ProfileCatID# neq 0>
			where CategoryID=#arguments.ProfileCatID#
			</cfif>
			<cfif #arguments.QuestionID# neq 0>
			where id=#arguments.QuestionID#
			</cfif>
		</cfquery>
		<cfset AllQuestions=QueryNew("QuestionID,QuestionName,Question,DateStarted,DateEnded,DisplayTypeID,CategoryID,UseInSearch,PositionID,isRequired")>
		<cfoutput query="Questions">
			<cfset xDateStarted=#dateformat(DateStarted,"mm/dd/yyyy")#>
			<cfset xDateEnded=#dateFormat(DateEnded,"mm/dd/yyyy")#>
			<CFSET newRow  = QueryAddRow(AllQuestions, 1)>
			<CFSET temp = QuerySetCell(AllQuestions, "QuestionID",#Questions.id#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "QuestionName",#QuestionName#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "Question",#Question#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DateStarted",#xDateStarted#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DateEnded",#xDateEnded#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DisplayTypeID",#DisplayTypeID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "CategoryID",#CategoryID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "UseInSearch",#UseInSearch#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "PositionID",#PositionID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "isRequired",#isRequired#, #newRow#)>
		</cfoutput>
		<cfreturn AllQuestions>
	</cffunction>
	
	<cffunction name="deleteProfileQ" access="remote" output="true" returntype="string">
		<cfargument name="QuestionID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from Questions where ID=#arguments.QuestionID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveProfileQ" returntype="string" output="true">
		<cfargument name="QuestionID" type="string" required="yes">
		<cfargument name="QuestionName" type="string" required="yes">
		<cfargument name="Question" type="string" required="yes">
		<cfargument name="DateStarted" type="string" required="yes">
		<cfargument name="DateEnded" type="string" required="yes">
		<cfargument name="DisplayTypeID" type="string" required="yes">
		<cfargument name="CategoryID" type="string" required="yes">
		<cfargument name="UseInSearch" type="string" required="yes">
		<cfargument name="PositionID" type="string" required="yes">
		<cfargument name="isRequired" type="string" required="yes">
		<cfargument name="ProfileID" type="string" required="yes">
		
		<cfset QuestionID=#arguments.QuestionID#>
		<cfset QuestionName=#QuestionName#>
		<cfset Question=#Question#>
		<cfset DateStarted=#arguments.DateStarted#>
		<cfset DateEnded=#DateEnded#>
		<cfset DisplayTypeID=#DisplayTypeID#>
		<cfset CategoryID=#CategoryID#>
		<cfset UseInSearch=#UseInSearch#>
		<cfset PositionID=#PositionID#>
		<cfset isRequired=#isRequired#>
		<cfset ProfileID=#ProfileID#>
		
		<cfif QuestionID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update Questions set
				QuestionName='#QuestionName#',
				Question='#Question#',
				DateStarted='#DateStarted#',
				DateEnded='#DateEnded#',
				DisplayTypeID=#DisplayTypeID#,
				UseInSearch=#UseInSearch#,
				ProfileType=#ProfileType#,
				PositionID=#PositionID#,
				isRequired=#isRequired#
				where ID=#arguments.QuestionID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into Questions (WebSiteID,QuestionName,Question,DateStarted,DateEnded,DisplayTypeID,CategoryID,UseInSearch,PositionID,isRequired)
				values (
				#ProfileID#,
				'#QuestionName#',
				'#Question#',
				'#DateStarted#',
				'#DateEnded#',
				#DisplayTypeID#,
				#CategoryID#,
				#UseInSearch#,
				#PositionID#,
				#isRequired#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from ProfileQuestions
			</cfquery>
			<cfset QuestionID=#getMaxID.NewID#>
		</cfif>

		<cfreturn QuestionID>
	</cffunction>
	
	<cffunction name="getProfileCats" access="remote" returntype="query" output="true">
		<cfargument name="ProfileCatID" required="no" default="0" >
		<cfargument name="ProfileID" required="no" default="0" >
		<cfquery name="Categories" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from questionCats
			<cfif #arguments.ProfileCatID# neq 0>
			where ID=#arguments.ProfileCatID#
			</cfif>
			<cfif #arguments.ProfileID# neq 0>
			where tableID=#arguments.ProfileID#
			</cfif>
		</cfquery>
		<cfset AllCategories=QueryNew("ProfileCatID,CategoryName,PositionID,ProfileID,PutInColumn")>
		<cfoutput query="Categories">
			<CFSET newRow  = QueryAddRow(AllCategories, 1)>
			<CFSET temp = QuerySetCell(AllCategories, "ProfileCatID",#Categories.ID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "CategoryName",#CategoryName#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "PositionID",#connectid#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "ProfileID",#tableid#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "PutInColumn",#PutInColumn#, #newRow#)>
		</cfoutput>
		<cfreturn AllCategories>
	</cffunction>
	
	<cffunction name="deleteProfileCat" access="remote" output="true" returntype="string">
		<cfargument name="ProfileCatID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from profileCats where ID=#arguments.ProfileCatID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveProfileCat" returntype="string" output="true">
		<cfargument name="ProfileCatID" type="string" required="yes">
		<cfargument name="CategoryName" type="string" required="yes">
		<cfargument name="PositionID" type="string" required="yes">
		<cfargument name="PutInColumn" type="string" required="yes">
		<cfargument name="ProfileID" type="string" required="yes">
		
		<cfset ProfileCatID=#arguments.ProfileCatID#>
		<cfset CategoryName=#CategoryName#>
		<cfset PositionID=#PositionID#>
		<cfset PutInColumn=#PutInColumn#>
		<cfset ProfileID=#ProfileID#>
		
		<cfif ProfileCatID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update questionCats set
				CategoryName='#CategoryName#',
				PutInColumn=#PutInColumn#,
				TableID=#ProfileID#,
				connectID=#PositionID#
				where ID=#arguments.ProfileCatID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into profileCats (ConnectID,CategoryName,TableID,PutInColumn)
				values (
				#PositionID#,
				'#CategoryName#',
				#ProfileID#,
				#PutInColumn#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from profileCats
			</cfquery>
			<cfset ProfileCatID=#getMaxID.NewID#>
		</cfif>

		<cfreturn ProfileCatID>
	</cffunction>
	
	<cffunction name="getProfileAs" access="remote" returntype="query" output="true">
		<cfargument name="AnswerID" required="no" default="0" >
		<cfargument name="QuestionID" required="no" default="0" >
		<cfargument name="CategoryID" required="no" default="0" >
		<cfargument name="ProfileID" required="no" default="0" >
		
		<cfquery name="Answers" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from Answers
			<cfif #arguments.AnswerID# neq 0>
			where ID=#arguments.AnswerID#
			</cfif>
			<cfif #arguments.QuestionID# neq 0>
			where QuestionID=#arguments.QuestionID#
			</cfif>
		</cfquery>
		<cfset AllAnswers=QueryNew("AnswerID,Answer,QuestionID")>
		<cfoutput query="Answers">
			<CFSET newRow  = QueryAddRow(AllAnswers, 1)>
			<CFSET temp = QuerySetCell(AllAnswers, "AnswerID",#Answers.ID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "Answer",#Answer#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "QuestionID",#QuestionID#, #newRow#)>
		</cfoutput>
		<cfreturn AllAnswers>
	</cffunction>
	
	<cffunction name="deleteProfileA" access="remote" output="true" returntype="string">
		<cfargument name="AnswerID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from Answers where ID=#arguments.AnswerID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveProfileA" returntype="string" output="true">
		<cfargument name="AnswerID" type="string" required="yes">
		<cfargument name="Answer" type="string" required="yes">
		<cfargument name="QuestionID" type="string" required="yes">

		<cfset AnswerID=#arguments.AnswerID#>
		<cfset Answer=#arguments.Answer#>
		<cfset QuestionID=#arguments.QuestionID#>
		
		<cfif AnswerID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update Answers set
				Answer='#Answer#',
				QuestionID=#QuestionID#
				where ID=#arguments.AnswerID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into Answers (Answer,QuestionID)
				values (
				'#Answer#',
				#QuestionID#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from Answers
			</cfquery>
			<cfset AnswerID=#getMaxID.NewID#>
		</cfif>

		<cfreturn AnswerID>
	</cffunction>
	
	<cffunction name="getTests" access="remote" returntype="query" output="true">
		<cfargument name="TestID" required="no" default="0" >
		<cfquery name="Tests" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from tests
			<cfif #arguments.TestID# neq 0>
			where ID=#arguments.TestID#
			</cfif>
		</cfquery>
		<cfset AllTests=QueryNew("ID,description,name,NoOfColumns,NoOfQsPerPage,ClassID,LessonID")>
		<cfoutput query="Tests">
			<CFSET newRow  = QueryAddRow(AllTests, 1)>
			<CFSET temp = QuerySetCell(AllTests, "ID",#Tests.ID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "description",#description#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "name",#name#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "NoOfColumns",#NoOfColumns#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "NoOfQsPerPage",#NoOfQsPerPage#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "ClassID",#ClassID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllTests, "LessonID",#LessonID#, #newRow#)>
		</cfoutput>
		<cfreturn AllTests>
	</cffunction>
	
	<cffunction name="deleteTest" access="remote" output="true" returntype="string">
		<cfargument name="QuestionaireID" required="yes" type="string">
		<cfquery name="DeleteSets" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			delete from tests
			where ID = #QuestionaireID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveTest" returntype="string" output="true">
		<cfargument name="TestID" type="string" required="yes">
		<cfargument name="Testdescription" type="string" required="yes">
		<cfargument name="TestName" type="string" required="yes">
		<cfargument name="NoOfColumns" type="string" required="yes">
		<cfargument name="NoOfQsPerPage" type="string" required="yes">
		<cfargument name="ClassID" type="string" required="yes">
		<cfargument name="LessonID" type="string" required="yes">

		<cfset TestID=#arguments.TestID#>
		<cfset TestName=#arguments.TestName#>
		<cfset Testdescription=#arguments.Testdescription#>
		<cfset NoOfColumns=#arguments.NoOfColumns#>
		<cfset NoOfQsPerPage=#arguments.NoOfQsPerPage#>
		<cfset ClassID=#arguments.ClassID#>
		<cfset LessonID=#arguments.LessonID#>
		
		<cfif TestID gt 0>
			<cfquery name="UpdateSets" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
			update tests set
			name='#arguments.TestName#',
			Description='#arguments.Testdescription#',
			ClassID='#arguments.ClassID#',
			LessonID=#arguments.LessonID#,
			NoOfColumns=#arguments.NoOfColumns#,
			NoOfQsPerPage=#arguments.NoOfQsPerPage#
			where ID=#TestID#
		</cfquery>
		<cfelse>
			<cfquery name="Insert" datasource="#application.DSN#"  username="#application.DSNuName#" password="#application.DSNpWord#">
				insert into tests
				(description,
				name,
				NoOfColumns,
				NoOfQsPerPage,
				ClassID,
				LessonID)
				values(
				'#arguments.testdescription#',
				'#arguments.testname#',
				#arguments.NoOfColumns#,
				#arguments.NoOfQsPerPage#,
				'#arguments.ClassID#',
				#arguments.LessonID#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from tests
			</cfquery>
			<cfset testID=#getMaxID.NewID#>
		</cfif>

		<cfreturn TestID>
	</cffunction>
	
	<cffunction name="getTestCats" access="remote" returntype="query" output="true">
		<cfargument name="TestCatID" required="no" default="0" >
		<cfquery name="Categories" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from profileCats
			<cfif #arguments.ProfileCatID# neq 0>
			where ProfileCatID=#arguments.ProfileCatID#
			</cfif>
		</cfquery>
		<cfset AllCategories=QueryNew("ProfileCatID,CategoryName,PositionID,ProfileID,PutInColumn")>
		<cfoutput query="Categories">
			<CFSET newRow  = QueryAddRow(AllCategories, 1)>
			<CFSET temp = QuerySetCell(AllCategories, "ProfileCatID",#Categories.ProfileCatID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "CategoryName",#CategoryName#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "PositionID",#PositionID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "ProfileID",#ProfileID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllCategories, "PutInColumn",#PutInColumn#, #newRow#)>
		</cfoutput>
		<cfreturn AllCategories>
	</cffunction>
	
	<cffunction name="deleteTestCat" access="remote" output="true" returntype="string">
		<cfargument name="TestCatID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from testCategories
			where ID = #TestCatID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveTestCat" returntype="string" output="true">
		<cfargument name="TestCatID" type="string" required="yes">
		<cfargument name="CategoryName" type="string" required="yes">
		<cfargument name="OrderID" type="string" required="yes">
		<cfargument name="PutInColumn" type="string" required="yes">
		<cfargument name="ProfileID" type="string" required="yes">
		<cfargument name="TestID" type="string" required="yes">
		
		<cfset CategoryName=#arguments.CategoryName#>
		<cfset OrderID=#arguments.OrderID#>
		<cfset PutInColumn=#arguments.PutInColumn#>
		<cfset TestCatID=#arguments.TestCatID#>
		<cfset TestID=#arguments.TestID#>
		
		<cfif ProfileCatID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update testCategories set
				categoryname='#arguments.categoryname#',
				OrderID=#arguments.OrderID#,
				PutInColumn=#arguments.PutInColumn#,
				TestID=#arguments.TestID#
				where ID=#TestCatID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into testCategories
				(categoryname,
				TestID,
				OrderID,
				PutInColumn)
				values(
				'#arguments.categoryname#',
				#arguments.TestID#,
				#arguments.OrderID#,
				#arguments.PutInColumn#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from testCategories
			</cfquery>
			<cfset TestCatID=#getMaxID.NewID#>
		</cfif>

		<cfreturn TestCatID>
	</cffunction>
	
	<cffunction name="getTestQs" access="remote" returntype="query" output="true">
		<cfargument name="TestID" required="no" default="0" >
		<cfargument name="TestCatID" required="no" default="0" >
		<cfquery name="Questions" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from profileQuestions
			<cfif #arguments.TestID# neq 0>
			where TestID=#arguments.TestID#
			</cfif>
			<cfif #arguments.TestCatID# neq 0>
			where CategoryID=#arguments.TestCatID#
			</cfif>
		</cfquery>
		<cfset AllQuestions=QueryNew("QuestionID,QuestionName,Question,DateStarted,DateEnded,DisplayTypeID,CategoryID,UseInSearch,PositionID,isRequired")>
		<cfoutput query="Questions">
			<cfset xDateStarted=#dateformat(DateStarted,"mm/dd/yyyy")#>
			<cfset xDateEnded=#dateFormat(DateEnded,"mm/dd/yyyy")#>
			<CFSET newRow  = QueryAddRow(AllQuestions, 1)>
			<CFSET temp = QuerySetCell(AllQuestions, "QuestionID",#Questions.QuestionID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "QuestionName",#QuestionName#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "Question",#Question#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DateStarted",#xDateStarted#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DateEnded",#xDateEnded#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "DisplayTypeID",#DisplayTypeID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "CategoryID",#CategoryID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "UseInSearch",#UseInSearch#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "PositionID",#PositionID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllQuestions, "isRequired",#isRequired#, #newRow#)>
		</cfoutput>
		<cfreturn AllQuestions>
	</cffunction>
	
	<cffunction name="deleteTestQ" access="remote" output="true" returntype="string">
		<cfargument name="QuestionID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from profileQuestions where QuestionID=#arguments.QuestionID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveTestQ" returntype="string" output="true">
		<cfargument name="QuestionID" type="string" required="yes">
		<cfargument name="QuestionName" type="string" required="yes">
		<cfargument name="Question" type="string" required="yes">
		<cfargument name="DisplayTypeID" type="string" required="yes">
		<cfargument name="CategoryID" type="string" required="yes">
		<cfargument name="UseInSearch" type="string" required="yes">
		<cfargument name="PositionID" type="string" required="yes">
		<cfargument name="isRequired" type="string" required="yes">
		<cfargument name="TestCatID" type="string" required="yes">
		<cfargument name="TestID" type="string" required="yes">
		
		<cfset QuestionID=#arguments.QuestionID#>
		<cfset QuestionName=#QuestionName#>
		<cfset Question=#Question#>
		<cfset DisplayTypeID=#DisplayTypeID#>
		<cfset CategoryID=#CategoryID#>
		<cfset UseInSearch=#UseInSearch#>
		<cfset PositionID=#PositionID#>
		<cfset isRequired=#isRequired#>
		<cfset TestCatID=#TestCatID#>
		<cfset TestID=#TestID#>
		
		<cfif QuestionID gt 0>
			<cfquery name="AllProfiles" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update TestQuestions set
				QuestionName='#arguments.QuestionName#',
				Question='#arguments.Question#',
				CategoryID=#TestCatID#,
				DisplayTypeID=#arguments.DisplayTypeID#,
				UseInSearch=#arguments.UseInSearch#,
				PositionID=#arguments.PositionID#,
				isrequired=#arguments.isrequired#,
				TestID=#TestID#
				where ID=#QuestionID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into TestQuestions
				(Question,
				QuestionName,
				CategoryID,
				DisplayTypeID,
				UseInSearch,
				PositionID,
				isrequired.
				TestID)
				values(
				'#arguments.Question#',
				'#arguments.QuestionName#',
				#TestCatID#,
				#arguments.DisplayTypeID#,
				#arguments.UseInSearch#,
				#arguments.positionid#,
				#arguments.isrequired#,
				#arguments.TestID#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from TestQuestions
			</cfquery>
			<cfset QuestionID=#getMaxID.NewID#>
		</cfif>

		<cfreturn QuestionID>
	</cffunction>
	
	<cffunction name="getTestAs" access="remote" returntype="query" output="true">
		<cfargument name="AnswerID" required="no" default="0" >
		<cfquery name="Answers" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from profileAnswers
			<cfif #arguments.AnswerID# neq 0>
			where ProfileCatID=#arguments.AnswerID#
			</cfif>
		</cfquery>
		<cfset AllAnswers=QueryNew("AnswerID,Answer,QuestionID,ProfileID,CategoryID")>
		<cfoutput query="Answers">
			<CFSET newRow  = QueryAddRow(AllAnswers, 1)>
			<CFSET temp = QuerySetCell(AllAnswers, "AnswerID",#Answers.AnswerID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "Answer",#Answer#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "QuestionID",#QuestionID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "ProfileID",#ProfileID#, #newRow#)>
			<CFSET temp = QuerySetCell(AllAnswers, "CategoryID",#CategoryID#, #newRow#)>
		</cfoutput>
		<cfreturn AllAnswers>
	</cffunction>
	
	<cffunction name="deleteTestA" access="remote" output="true" returntype="string">
		<cfargument name="AnswerID" required="yes" type="string">
		<cfquery name="delete" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			delete from TestAnswers
			where ID = #AnswerID#
		</cfquery>
		<cfreturn "true">
	</cffunction>
	
	<cffunction access="remote" name="saveTestA" returntype="string" output="true">
		<cfargument name="AnswerID" type="string" required="yes">
		<cfargument name="Answer" type="string" required="yes">
		<cfargument name="QuestionID" type="string" required="yes">
		<cfargument name="CorrectAnswer" type="string" required="yes">
		<cfargument name="ResponseWeight" type="string" required="yes">
		<cfargument name="TestID" type="string" required="yes">
		
		<cfset AnswerID=#arguments.AnswerID#>
		<cfset Answer=#Answer#>
		<cfset QuestionID=#QuestionID#>
		<cfset CorrectAnswer=#CorrectAnswer#>
		<cfset ResponseWeight=#ResponseWeight#>
		<cfset TestID=#TestID#>
		
		<cfif AnswerID gt 0>
			<cfquery name="update" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				update TestAnswers set
				Answer='#arguments.Answer#',
				CorrectAnswer = #arguments.CorrectAnswer#,
				ResponseWeight = #arguments.ResponseWeight#,
				TestID=#TestID#
				where ID=#AnswerID#
			</cfquery>
		<cfelse>
			<cfquery name="insert" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				insert into TestAnswers
				(Answer,
				QuestionID,
				CorrectAnswer,
				ResponseWeight,
				TestID)
				values(
				'#form.Answer#',
				#QuestionID#,
				#CorrectAnswer#,
				#ResponseWeight#,
				#TestID#)
			</cfquery>
			<cfquery name="getMaxID" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
				select max(ID) as NewID from TestAnswers
			</cfquery>
			<cfset AnswerID=#getMaxID.NewID#>
		</cfif>

		<cfreturn AnswerID>
	</cffunction>
	
	<cffunction name="getTestResults" returntype="query" access="remote" output="true">
		<cfargument name="TestID" type="string" required="yes">
		<cfquery name="testResults" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select * from TestResponses
			where ResponseTestID=#arguments.TestID#
		</cfquery>
		<cfreturn testResults>		
	</cffunction>
	
	<cffunction name="getInvoice" access="remote" output="true" returntype="query">
		<cfargument name="invoiceNo" type="string" required="yes">
		
		<CFQUERY name="GetRecord" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#" maxRows=1>
			SELECT ORDERS.*, ORDERS.INVOICE AS ID_Field,
			members.*, addresses.*, email.*,
			CONVERT(CHAR(10),ORDERS.dateordered,101) as sdate
			FROM ORDERS, members, addresses, email
			WHERE members.memberid=orders.custid
			and addresses.connectid=members.memberid
			and addresses.tableid=15
			and addresses.addresstypeid=1
			and email.tableid=15
			and email.websiteid=1
			and email.connectid=members.memberid
			and ORDERS.INVOICE = #arguments.invoiceNo#
		</CFQUERY>
		<cfreturn getRecord>
	</cffunction>
	
	<cffunction name="getInvoiceDetails" access="remote" output="true" returntype="query">
		<cfargument name="invoiceNo" type="string" required="yes">
		
		<cfquery name="xGetDetails" datasource="#application.DSN#" password="#application.DSNpWord#" 
			username="#application.DSNuName#">
			Select OrdDtl.*, 
			CoursesPurchased.*
			from OrdDtl, CoursesPurchased
			where OrdDtl.Invoice = #arguments.invoiceNo#
			and CoursesPurchased.invoice=OrdDtl.invoice
		</cfquery>
		<cfif #xGetDetails.RecordCount# is 0>
			<cfquery name="xGetDetails" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
				Select OrdDtl.*
				from OrdDtl
				where OrdDtl.Invoice = #arguments.invoiceNo#
			</cfquery>
			<cfset CourseID=''>
		</cfif>
		<cfset getDetails=QueryNew("ID,Class,ClassDate,Schedule,Price")>
		<cfoutput query="xGetDetails">
			select * from courseSchedules
				where CourseID=#ProductID# and ClassID=#ClassTime#<br>
			<cfquery name="xSchedule" datasource="#application.dsn#" 
				username="#application.dsnuname#" password="#application.dsnpword#">
				select * from courseSchedules
				where CourseID=#ProductID# and ClassID=#ClassTime#
			</cfquery>
			<CFSET newRow  = QueryAddRow(getDetails, 1)>
			<CFSET temp = QuerySetCell(getDetails, "ID","#ProductID#", #newRow#)>
			<CFSET temp = QuerySetCell(getDetails, "Class","#ProdName#", #newRow#)>
			<CFSET temp = QuerySetCell(getDetails, "ClassDate","#dateformat(DateSTarted,"mm/dd/ yyyy")#", #newRow#)>
			<cfif #xSchedule.scheduleDay# neq ''><Cfset scheduleDate="#xSchedule.scheduleDay# #timeformat(xSchedule.startTime,'hh:mm')# EST"><cfelse><cfset scheduleDate="None"></cfif>
			<CFSET temp = QuerySetCell(getDetails, "Schedule","#scheduleDate#", #newRow#)>
			<CFSET temp = QuerySetCell(getDetails, "Price","#dollarformat(Price)#", #newRow#)>
		</cfoutput>
		<cfreturn getDetails>
	</cffunction>
	
	<cffunction access="remote" name="getClassPrices" output="true" returntype="query">
		<cfargument name="classPrice" required="false" type="string" default="all">
		<cfquery name="ClassPrices" datasource="#application.dsn#" username="#application.dsnuname#" password="#application.dsnpword#">
			select ClassID,ClassPrice,Description,Discount from classPrices
			<cfif #arguments.classPrice# neq "all">
				where classPrice=#arguments.classPrice#
			</cfif>
		</cfquery>
		<cfreturn ClassPrices>
	</cffunction>
	
	<cffunction name="getProfileResponses" access="remote" output="true" returntype="query">
		<cfargument name="QuestionID" required="yes" type="string">
		<cfargument name="UserID" required="yes" type="string">		
		<cfquery name="GetResponses" datasource="#application.DSN#"  
			username="#application.DSNuName#" password="#application.DSNpWord#">
			select responsetext from responses
			where connectid = #arguments.QuestionID#
			and userid=#arguments.UserID#
			order by connectid, responseid
		</cfquery>
		<cfreturn GetResponses>
	</cffunction>
	
</cfcomponent>