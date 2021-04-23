<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />
<cfif NOT isDefined("Application.sslfix")>
	<cfset objSecurity = createObject("java", "java.security.Security") />
	<cfset objSecurity.removeProvider("JsafeJCE") />
	<cfset Application.sslfix = true />
</cfif>

<cfparam name="url.email" default="Lamcgivern53@gmail.com,Lauramcgivern53@yahoo.com" />

<!---

Health and Wellness Coach Training - 18-week program - Lesson Feedback Survey														surveyHWCT18Week			1013764 question(9),question(8)
Health and Wellness Coach Training - 2012 through March 2013 - Lesson Feedback Survey  Survey										surveyHWCT2012			1020531 question(9),question(8)
(For Auditing Participants ONLY) Health and Wellness Coach Training - 2012 through March 2013 - Lesson Feedback Survey  Survey		 surveyHWCTAudit2012	1120644 question(9),question(8)
Professional Coach Training Program (10-month) - October 2012 - June 2013															surveyPCTPOct2012  		1060665 question(9),question(8)
Professional Coach Training Program (10-month) - Sept 2013 through June 2014														surveyPCTPSept2013  	1330743 question(9),question(8)

Self-Coaching Course: Organize Your Mind - 2013					 																	surveyOYM2013  			1117522 question(11),question(3)
Wellcoaches Member and Coach-in-Practice Class Feedback Survey																		surveyCIPFeedback		1026874 question(9),question(24)
Wellcoaches Live Workshops - 2013 (for CiP Members Only)			 																surveyWCLiveWS 			1117550 question(17), question(6)--->
<cfset DSN = "wellcoachesSchool">
<cfset application.DSNuName = "sa">
<cfset application.dsnpword = "NHg5^u+iNuz[W{Y">
<cfquery name="getAllEmails" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	select top 1 email_address
    from coachInPracticeEmailFix
    where email_address like '%#url.email#%'
	order by date desc
</cfquery>



<cfif getAllEmails.recordCount GT 0 AND Len(getAllEmails.email_address)>
	<cfset local.email = lcase(ReplaceNoCase(getAllEmails.email_address,"'","","all")) />
<cfelse>
	<cfset local.email = lcase(ReplaceNoCase(url.email,"'","","all")) />
</cfif>


<cfoutput>
<cfinclude template="getUser.cfm">
<!--- <cfif isDate(renewedDate) AND isDate(REcertEndDate)> --->
<!---    <h2> Certification period for which you may claim continuing education hours: #renewedDate# to #REcertEndDate# </h2> --->
<!--- </cfif> --->
<!---<cftry>--->
  <cfset columnList = "datesubmitted,id,lesson,email,surveyTitle,hours,score,premiumHours,originaldate" />
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
<!--- Removed Practical skill assesment for now  1382009 --->
 <cfset allsurveys = "6174060,6174072,5820302,5121979,5769769,5664658,5508580,1013764,1020531,1120644,1060665,1330743,1117522,1026874,1117550,1447572,1849174,1953823,1994464,2338773,1959806,1144369,2913540,3839954,4229417,4051290,4144821,4305174,4227686,4320651,4543424,4776929,4144821,1959806,4238384">
   <cfset group1 = "1013764,1020531,1120644,1060665,1330743,1849174,2338773,2913540,3839954" />

<cfloop list="#local.email#" index="local.emailUser" delimiters=",">
  <cfloop list="#allsurveys#" index="column">

 	   <cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/#column#/surveyresponse">
       
	   <cfif listFind(group1,column) >
        	<cfset emailParam = "[question(9), option(0)]" />
        <cfelseif Find(1117522,column)>
         	<cfset emailParam = "[question(11)]" />
		<cfelseif Find(1026874,column) OR Find(5664658, column)>
         	<cfset emailParam = "[question(9), option(0)]" />
        <cfelseif Find(1117550,column)>
         	<cfset emailParam = "[question(17)]" />
        <cfelseif Find(1447572,column)>
         	<cfset emailParam = "[question(2)]" />
        <cfelseif Find(1144369,column)>
         	<cfset emailParam = "[question(32)]" />
        <cfelseif Find(1382009,column)>
			 <cfset emailParam = "[question(21)]" />
		<cfelseif Find(4543424,column) OR Find(5121979,column) >
				<cfset emailParam = "[question(26)]" />		 
        <cfelseif Find(1959806,column) or Find(4305174,column) OR find(4776929,column)>
         	<cfset emailParam = "[question(37)]" />
		<cfelseif Find(4227686,column) OR find(4320651,column)>
			 <cfset emailParam = "[question(61)]" />
		<cfelseif Find(4144821,column) OR Find(6174072,column)>
				<cfset emailParam = "[question(35)]" />	 
		<cfelseif Find(1959806,column) OR Find(4238384,column) OR Find(6174060,column) >
				<cfset emailParam = "[question(37)]" />	 
		<cfelseif Find(4229417,column)  >
				<cfset emailParam = "[question(90)]" />		
		<cfelseif Find(4051290,column)  >
				<cfset emailParam = "[question(93)]" />		
		<cfelseif Find(5508580,column)  OR Find(5664658,column) OR Find(5769769,column) >
				<cfset emailParam = "[question(35)]" />	
		<cfelseif Find(5820302,column)  >
				<cfset emailParam = "[question(93)]" />											
        </cfif>
		<!--- https://apihelp.surveygizmo.com/help/surveyresponse-sub-object#filtering --->

        <cfhttp url="#SGurl#" result="myResult" method="get">
     		 <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
			 <cfhttpparam type="url"  value="#emailParam#" name="filter[field][0]"/>
             <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
             <cfhttpparam type="url"  value="#trim(local.emailUser)#" name="filter[value][0]"/>
             <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
             <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
			 <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
			 
             <cfhttpparam type="url"  value="500" name="resultsperpage"/>
      </cfhttp>

      <cfset jsonData = deserializeJSON(myResult.fileContent) />

	 <cfif structKeyExists(jsonData,'data') and NOT arrayIsEmpty(jsondata.data)>

        <cfloop array="#jsonData.data#" index="field">

		  <cfset queryAddRow(SurveyList)>
		    <cfparam name="field['[question(3)]']" default="">
		    <cfparam name="field['[question(6)]']" default="">
            <cfparam name="field['[question(8)]']" default="">
			<cfparam name="field['[question(9)]']" default="">
			<cfparam name="field['[question(9), option(0)]']" default="">
			<cfparam name="field['[question(11)]']" default="">
			<cfparam name="field['[question(16), option(0)]']" default="">
			<cfparam name="field['[question(17)]']" default="">
			<cfparam name="field['[question(21)]']" default="">
          	<cfparam name="field['[question(29)]']" default="">
			<cfparam name="field['[question(30)]']" default="">
			<cfparam name="field['[question(31)]']" default="">
            <cfparam name="field['[question(32)]']" default="">
			<cfparam name="field['[question(33)]']" default="">
			<cfparam name="field['[question(35)]']" default="">
			<cfparam name="field['[question(37)]']" default="">
			<cfparam name="field['[question(39)]']" default="">
            <cfparam name="field['[question(43)]']" default="">
          	<cfparam name="field['[question(61)]']" default="">
			<cfparam name="field['[question(93)]']" default="">
			<cfparam name="field['[question(80)]']" default="">

			<cfif column eq 1144369 AND len(field['[question(49)]'])>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['[question(49)]'] )/>
			<cfelse>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
			</cfif>

            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>

            <cfif column eq 1953823>
				 <cfset temp = QuerySetCell(SurveyList,"lesson",  field['[question(39)]'] )/>
				 <cfset temp = QuerySetCell(SurveyList,"hours",  field['[question(31)]'] )/>
			</cfif>

			<cfif column eq 1959806>
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Core Coach Training - 4-day on-site program - Feedback Survey' )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", '0' )/>
		   </cfif>

			<cfif column eq 4776929>
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Burnout Prevention Program for Physicians: Feedback' )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", '4.5' )/>
		   </cfif>

		   <cfif column eq 4144821>
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]']  )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			</cfif>
			   
			<cfif column eq 4238384 >
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(43)]']  )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
			</cfif>

			<cfif column eq 5820302 >
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Wellcoaches Behavior Change Agent'  )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
			</cfif>
			
		
            <cfif column eq 1994464>
         		<cfset temp = QuerySetCell(SurveyList,"lesson", 'organize your mind online+mobile course - Feedback Survey' )/>
            </cfif>
            <!---Practical Skills Assessment--->
            <cfif column eq 1382009>
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Practical Skills Assessment' )/>
               	<cfset temp = QuerySetCell(SurveyList,"score", field['[question(16), option(0)]'] )/>
				<!--- set datesubmitted to today, so will always display in tally--->
			 	<cfset temp = QuerySetCell(SurveyList,"originalDate", DateFormat(field['datesubmitted'],'yyyy-mm-dd') )>
			   	<cfset temp = QuerySetCell(SurveyList,"datesubmitted", DateFormat(now(),'yyyy-mm-dd') )>
            </cfif>

		  <cfif listFind(group1,column)>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
            <cfelseif column eq 1117522>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(3)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
            <cfelseif column eq 1026874 OR column eq 5664658>

            	 <cfif (field['[question(29)]'] eq 'Other' OR field['[question(29)]'] eq '') AND len(field['[question(30)]'])>
                	<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(30)]'] )/>
                <cfelseif field['[question(29)]'] NEQ ''>
               	 <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfelseif field['[question(24)]'] NEQ ''>
                	<cfset temp = QuerySetCell(SurveyList,"lesson",  field['[question(24)]'] )/>
                <cfelse>
                	<cfset temp = QuerySetCell(SurveyList,"lesson",  'Other' )/>
                </cfif>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
				<cfif !LEN(field['[question(31)]'])>
					<cfset temp = QuerySetCell(SurveyList,"hours", 1 )/>
				</cfif> 
				
                <cfset temp = QuerySetCell(SurveyList,"PremiumHours", field['[question(80)]'] )/>

                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>

            <cfelseif column eq 1117550>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(6)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
            <cfelseif column eq 1959806>

          		<cfset lesson = '' />
                <cfloop from="10126" to="10135" index="i">
                    <cfif structKeyExists(field,'[question(29), option(#i#)]')>
                    	<cfset lesson  = listappend(lesson,field['[question(29), option(#i#)]']) />
                    </cfif>
               </cfloop>
               <cfif listLen(lesson) EQ 0>
               <cfset temp = '' />
               	<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(39)]']  )/>
               <cfelse>
                	<cfset temp = QuerySetCell(SurveyList,"lesson", REReplace(lesson, ",$", "") )/>
               </cfif>
			 <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>

            <cfelseif column eq 1144369>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(30)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email",  field['#emailParam#'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(33)]'] )/>
            <cfelseif column eq 1447572>
                <cfset temp = QuerySetCell(SurveyList,"lesson", "Hours adjusted-#field['[question(4)]']#" )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(3)]'] )/>
		   <cfelseif column eq 4051290>
                <cfset temp = QuerySetCell(SurveyList,"lesson", "Wellcoaches Habits #field['[question(89)]']#"  )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", '10' )/>
			<cfelseif column eq 4229417>
                <cfset temp = QuerySetCell(SurveyList,"lesson", "Wellcoaches Habits #field['[question(88)]']#"  )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(90)]'] )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", '10' )/>	
				
			<cfelseif column eq 4227686>
				<cfset temp = QuerySetCell(SurveyList,"lesson", "Core Coach Training - 4-day residential program day #field['[question(60)]']#" )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(61)]'] )/>
			<cfelseif column eq 4320651>
                <cfset temp = QuerySetCell(SurveyList,"lesson", "Lifestyle Medicine for Coaches" )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(61)]'] )/>	
			<cfelseif column eq 4543424 or column eq 5121979>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]']  )/>
               
		    <cfelseif column eq 4144821 >
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(9), option(0)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
		   <cfelseif column eq 4305174 OR column eq 6174060>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(39)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(37)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			<cfelseif column eq 5508580 OR column eq 6174072>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(120)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			<cfelseif column eq 5664658 >
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			<cfelseif column eq 5769769 >
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(124)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>	
		   </cfif>
           <cfset temp = QuerySetCell(SurveyList,"surveyTitle", column )/>
           <cfset temp =  QuerySetCell(SurveyList,"id", field['id']  )/>
          </cfloop>
      </cfif>
  </cfloop>
</cfloop>

	<cfif isDate(REcertEndDate)>
		<cfset REcertEndDate = dateAdd('h',24,REcertEndDate)>
	</cfif>
    <cfquery name="results" dbtype="query" result="local.results">
      select distinct email, hours, id, lesson, premiumhours, score, surveyTitle, originaldate, datesubmitted
	  from SurveyList
      <cfif isDate(renewedDate) AND isDate(REcertEndDate) AND !structKeyExists(url,'concierge')>
      <!---	where cast(datesubmitted AS DATE) >= <cfqueryparam cfsqltype="cf_sql_date" value="#renewedDate#">
           AND cast(datesubmitted AS DATE) <= <cfqueryparam cfsqltype="cf_sql_date" value="#REcertEndDate#"> --->
      </cfif> 
      order by datesubmitted desc
    </cfquery>


<cfif local.results.recordcount EQ 0>
     You currently have no records.
     <cfabort>
</cfif>
	<cfset showHours = valueList(results.surveyTitle)/>
	<cfset CIPs = "1060665,1330743,1849174,2913540,2338773,3839954" />
    <cfset NoHours = "1013764,1020531" />
     <table id="myTable" class="tablesorter" width="100%" >
        <thead>
            <tr>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left" class="sortInitialOrder-desc">Date</th>
                <th nowrap="nowrap" align="left">Hours</th>
            </tr>
        </thead>
        <tbody>

         <cfset total = 0>
         <cfset subTotal = 0 />
         <cfset currentMonthYear = '' />

		<cfset local.habits = 0>
		<cfset local.module1 = 0>
		<cfset local.module2 = 0>
    	 <cfloop query="results" group="lesson">


	         <form action="./surveyPDF.cfm" name="openPDF#id#" method="post">
	         	<input type="hidden" name="id" value="#id#" />
	            <input type="hidden" name="surveyTitle" value="#surveyTitle#" />

	            <cfif listFind(CIPS,surveyTitle)>
	         		<tr>
	                	<!---<td>#id#</td>
	                	<td>#surveyTitle#</td>--->
	                	<td><a href="##" onclick="window.open('./surveyGizmoAPIs/surveyPDF.cfm?id=#urlencodedformat(encrypt(id,'pdf'))#&surveyTitle=#urlencodedformat(encrypt(surveyTitle,'pdf'))#','openPDF#id#','width=750,height=750,menubar=no,resizable=no,directories=no,location=no')">#lesson#</a></td>
	                	<td>#DateFormat(datesubmitted,'mm/dd/yyyy')#</td>

						<cfif !listFind(NoHours,surveyTitle)>
	                        <td>
	                        <cfif lesson contains 'residential'>
	                                21
								<cfset total = total + 21>
	                        <cfelseif surveyTitle eq 1117550>
	                                7.5
								<cfset total = total + 7>
							<cfelseif surveyTitle eq 4776929>
								4.5
								<cfset total = total + 4.5>	
	                        <cfelseif surveyTitle eq 4229417  OR surveyTitle eq 4051290>
	                                10
								<cfset total = total + 10>
							<cfelseif surveyTitle eq 1994464>
								 4
								<cfset total = total + 4>
	                        <cfelseif surveyTitle eq 1447572 OR surveyTitle eq 1144369 OR surveyTitle eq 1959806 or surveyTitle eq 4144821>
	                                 #iif(len(hours),hours,0)#
	                                 <cfset total = total + iif(len(hours),hours,0)>

	                        <cfelseif surveyTitle eq 1117522 OR surveyTitle eq 2913540 OR surveyTitle EQ 5121979>
	                                  1.5
	                            	 <cfset total = total + 1.5>
	                        <cfelse>
	                                1.5
						   		<cfset total = total + 1.5>
	                        </cfif>
	                        </td>
	                    <cfelse>
	                    	<td>-</td>
	                    </cfif>
	                </tr>
	        	<cfelse>
	            	<tr>
	                <cfif isDefined('url.debug')>
	                	<td>#id#</td>
	                    <td>#surveyTitle#</td>
	                </cfif>
	                <!---Practical Skills--->

	                 	<cfif surveyTitle EQ '1382009' AND score GTE 80>
	                 		 <td><a href="/utilities/infusionsoft/practicalResults.cfm?surveyTitle=#surveyTitle#&id=#id#" target="_blank" />#lesson#</a></td>
	                     <cfelse>
	                     	<td>#lesson#</td>
	                	 </cfif>


						<td>
							<cfif len(originalDate) AND isDate(originalDate)>
								#DateFormat(originalDate,'mm/dd/yyyy')#

							<cfelse>
								<cfif isDate(datesubmitted)>
									#DateFormat(datesubmitted,'mm/dd/yyyy')#
								<cfelse>
									--	
								</cfif>
							</cfif>
						</td>
						<cfif !listFind(NoHours,surveyTitle)>
	                        <td>
								<cfif surveyTitle eq 1120644 OR surveyTitle eq 1117522 OR surveyTitle eq 2913540 or surveyTitle eq 5508580 OR surveyTitle EQ 5121979>
									<cfif findNoCase('Residential', lesson) AND surveyTitle EQ 5121979>
										20
										<cfset total = total + 20 />
									<cfelse>
										1.5
										<cfset total = total + 1.5>
									</cfif>	
								<cfelseif  surveyTitle eq 4229417 OR surveyTitle eq 4051290 >
									<cfset local.habits++>
									
	                            	<cfif (habitsComplete EQ "Y" OR habitsComplete EQ 'STANDALONE') AND (local.habits eq 8 AND !structKeyExists(local, 'habitsAdded'))>
		                                10
										<cfset total = total + 10>
										<cfset local.habitsAdded  = 1 />
									<cfelse>
										&mdash;
	                            		<cfset total = total + 0>
									</cfif>
								<cfelseif  surveyTitle eq 4238384 >
	                            	<cfset local.module2++>
	                            	<cfif Module2Complete EQ "Y" AND (local.module2 gte 4 AND !structKeyExists(local, 'mod2Added'))>
		                                10
										<cfset total = total + 10>
										<cfset local.mod2Added  = 1 />
									<cfelse>
										&mdash;
	                            		<cfset total = total + 0>
									</cfif>	
								<cfelseif surveyTitle eq 4227686 OR surveyTitle eq 1953823>
										&mdash;
										<cfset total = total + 0>
								<cfelseif surveyTitle eq 4320651 >
										21.5
										<cfset total = total + 21.5>		
								<cfelseif surveyTitle eq 5820302 >
										5.5
	                            		<cfset total = total + 5.5>		
								<cfelseif surveyTitle eq 1994464>
								 	4
									<cfset total = total + 4>
								<cfelseif surveyTitle eq 4776929>
									4.5
									<cfset total = total + 4.5>		
								<cfelseif surveyTitle eq 1117550>
	                                7.5
	                                <cfset total = total + 7>
	                            <cfelseif (surveyTitle eq 1026874 OR surveyTitle eq 5664658) AND datePart('yyyy',datesubmitted) GTE '2016' >
								 <!---clear the subtotal when it's a new month--->
	                                    <cfif currentMonthYear NEQ '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'>
	                                        <cfset subtotal = 0 />
	                                        <cfset currentMonthYear = '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'  />
	                                    </cfif>

	                                    <!---if month is the same add up subtotal--->
	                                    <cfif currentMonthYear EQ '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'>

	                                        <cfset currentMonthYear = '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'  />
	                                        <!---<cfset subtotal = subtotal + iif(len(hours),hours,0) />--->
	                                        <cfset subtotal++/>

	                                        <!---always show premium hours--->
	                                        <cfif len(premiumHours)>
	                                             #premiumHours#
	                                             <cfset total = total + premiumHours />

	                                        <cfelse>
												<!--- survey 1144369  CE Approval - Internal Use--->
	                                             <cfif subtotal LTE 4 >
	                                                  #iif(len(hours),hours,0)#
	                                                  <cfset total = total + iif(len(premiumHours), premiumHours, iif(len(hours),hours,0)) />
	                                             <cfelse>
	                                                  [over allotted classes for #monthasstring(datePart('m',datesubmitted))#]
	                                             </cfif>
	                                        </cfif>
	                                     </cfif>

							  <cfelseif surveyTitle eq 1026874 AND datePart('yyyy',datesubmitted) LTE '2015'>
	 								 #iif(len(hours),hours,0)#
	                                 <cfset total = total + iif(len(hours),hours,0)>
	                          <cfelseif surveyTitle eq 1447572 OR surveyTitle eq 1959806 OR surveyTitle eq 1144369 or surveyTitle eq 4144821 or surveyTitle eq 4305174 or surveyTitle eq 5769769 or surveyTitle eq 6174072 OR surveyTitle eq 6174060>
	                                  #iif(len(hours),hours,0)#
	                                 <cfset total = total + iif(len(hours),hours,0)>
	                            <cfelseif surveyTitle eq 1382009>
	                            		&mdash;
	                            	<cfset total = total + 0>
	                            <cfelse>
	                                	1
	                                <cfset total = total + 1>
	                            </cfif>
	                        </td>
	                    <cfelse><strong></strong>
	                    	<td>-</td>
	                    </cfif>
	                </tr>
	        	</cfif>
	         </form>

         </cfloop>
         <!---<cfif total GT 0>
         	<tr><td colspan="5" align="right">Total Hours: #total#</td></tr>
         </cfif>--->
    </tbody>
    <cfif total GT 0>
         	<tr><td colspan="5" align="right">Total Hours: #total#</td></tr>
         </cfif>
</table>
<div id="pager" class="pager" style="font-size:11px;font-family:Verdana, Geneva, sans-serif">
	<form>
		First <img src="js/addons/pager/icons/first.png" class="first"/>
		Previous <img src="js/addons/pager/icons/prev.png" class="prev"/>
		<input type="text" class="pagedisplay"/>
		Next <img src="js/addons/pager/icons/next.png" class="next"/>
		Last <img src="js/addons/pager/icons/last.png" class="last"/>
		<select class="pagesize">
			<option selected="selected"  value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
			<option value="50">50</option>
			<option value="60">60</option>
			<option value="70">70</option>
			<option value="80">80</option>
			<option value="90">90</option>
			<option value="100">100</option>
		</select>
        See more results (default display is 10 records)
	</form>
</div>
  	<!---<cfcatch type="any" >
    	We are currently down for maintenance.  Please check back soon!
        <cfif isdefined('url.debug')>

              <cfdump var="#cfcatch#"><cfabort>

        </cfif>

    </cfcatch>
</cftry>--->
</cfoutput>
