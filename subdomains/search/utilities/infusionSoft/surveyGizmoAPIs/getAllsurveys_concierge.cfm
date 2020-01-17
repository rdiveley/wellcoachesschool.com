<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />
<cfif NOT isDefined("Application.sslfix")>
	<cfset objSecurity = createObject("java", "java.security.Security") />
	<cfset objSecurity.removeProvider("JsafeJCE") />
	<cfset Application.sslfix = true />
</cfif>

<cfparam name="url.email" default="Lamcgivern53@gmail.com,Lauramcgivern53@yahoo.com" />


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

 <cfset allsurveys = "1013764,1020531,1120644,1060665,1330743,1117522,1026874,1117550,1447572,1849174,1953823,1994464,1382009,2338773,1959806,1144369,2913540,3839954,4051290,4144821,4305174,4227686">
   <cfset group1 = "1020531,1120644,1060665,1330743,1849174,2338773,2913540,3839954" />

<cfloop list="#local.email#" index="local.emailUser" delimiters=",">
  <cfloop list="#allsurveys#" index="column">

 	   <cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#column#/surveyresponse">
        <cfif column eq 1026874>
        	<cfparam name="emailParam" default="[url('email')]" />
        <cfelse>
        	<cfparam name="emailParam" default="[question(9)]" />
        </cfif>
	   <cfif listFind(group1,column) >
        	<cfset emailParam = "[question(9), option(0)]" />
        <cfelseif Find(1117522,column)>
         	<cfset emailParam = "[question(11)]" />
		<cfelseif Find(1026874,column)>
         	<cfset emailParam = "[question(9), option(0)]" />
        <cfelseif Find(1117550,column)>
         	<cfset emailParam = "[question(17)]" />
        <cfelseif Find(1447572,column)>
         	<cfset emailParam = "[question(2)]" />
        <cfelseif Find(1144369,column)>
         	<cfset emailParam = "[question(32)]" />
        <cfelseif Find(1382009,column)>
         	<cfset emailParam = "[question(21)]" />
        <cfelseif Find(1959806,column) or Find(4305174,column)>
         	<cfset emailParam = "[question(37)]" />
		<cfelseif Find(4227686,column)>
         	<cfset emailParam = "[question(61)]" />
        </cfif>

        <cfhttp url="#SGurl#" result="myResult" method="get">
     		 <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
			 <cfhttpparam type="url"  value="#emailParam#" name="filter[field][0]"/>
             <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
             <cfhttpparam type="url"  value="#trim(lcase(local.emailUser))#" name="filter[value][0]"/>
             <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
             <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
             <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
             <cfhttpparam type="url"  value="300" name="resultsperpage"/>
      </cfhttp>

      <cfset jsonData = deserializeJSON(myResult.fileContent) />

	 <cfif structKeyExists(jsonData,'data') and NOT arrayIsEmpty(jsondata.data)>

		<cfset local.core = '' />
		<cfset local.residential = '' />
		<cfset local.habits = '' />

        <cfloop array="#jsonData.data#" index="field">

          <cfset queryAddRow(SurveyList)>
            <cfparam name="field['[question(9)]']" default="">
            <cfparam name="field['[question(8)]']" default="">
            <cfparam name="field['[question(29)]']" default="">
            <cfparam name="field['[question(30)]']" default="">
            <cfparam name="field['[question(32)]']" default="">
            <cfparam name="field['[question(33)]']" default="">
            <cfparam name="field['[question(11)]']" default="">
            <cfparam name="field['[question(3)]']" default="">
            <cfparam name="field['[question(17)]']" default="">
            <cfparam name="field['[question(6)]']" default="">
            <cfparam name="field['[question(43)]']" default="">
            <cfparam name="field['[question(35)]']" default="">
            <cfparam name="field['[question(21)]']" default="">
            <cfparam name="field['[question(37)]']" default="">
			<cfparam name="field['[question(61)]']" default="">
            <cfparam name="field['[question(16), option(0)]']" default="">

			<cfif column eq 1144369 AND len(field['[question(49)]'])>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['[question(49)]'] )/>
			<cfelse>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
			</cfif>

            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>

            <cfif column eq 1953823>
				 <cfset temp = QuerySetCell(SurveyList,"lesson", 'Core Coach Training - 4-day on-site program - Feedback Survey' )/>
				 <cfset temp = QuerySetCell(SurveyList,"hours", '0' )/>
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
            <cfelseif column eq 1026874>

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
				<cfset local.habits = listRemoveDuplicates(listAppend(local.habits,field['[question(89)]']))  />
				
                <cfset temp = QuerySetCell(SurveyList,"lesson", "Wellcoaches Habits Course: #field['[question(89)]']#" )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(9), option(0)]'] )/>
				
				<cfif listLen(local.habits) EQ 8>
					<cfset temp = QuerySetCell(SurveyList,"hours", '10' )/>
				<cfelse>
					<cfset temp = QuerySetCell(SurveyList,"hours", '0' )/>		
				</cfif>

			<cfelseif column eq 1013764>

				<cfset local.core = listRemoveDuplicates(listAppend(local.core,field['[question(8)]']))  />

				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]'])/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(9), option(0)]'] )/>
				
				<cfif listLen(local.core) EQ 18>
					<cfset temp = QuerySetCell(SurveyList,"hours", '27.5' )/>
				<cfelse>
					<cfset temp = QuerySetCell(SurveyList,"hours", '0' )/>		
				</cfif>


			<cfelseif column eq 4227686>
				<cfset local.residential = listRemoveDuplicates(listAppend(local.residential,field['[question(60)]']))  />
				<cfset temp = QuerySetCell(SurveyList,"lesson", "Core Coach Training - 4-day residential program day #field['[question(60)]']#" )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(61)]'] )/>
				<cfif listLen(local.residential) EQ 4>
					<cfset temp = QuerySetCell(SurveyList,"hours", '27.5' )/>
				<cfelse>
					<cfset temp = QuerySetCell(SurveyList,"hours", '0' )/>		
				</cfif>
		    <cfelseif column eq 4144821>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(9), option(0)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
		   <cfelseif column eq 4305174>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(39)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(37)]'] ) />
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
      select * from SurveyList
      <cfif isDate(renewedDate) AND isDate(REcertEndDate) AND !structKeyExists(url,'nofilter')>
      	where cast(datesubmitted AS DATE) >= <cfqueryparam cfsqltype="cf_sql_date" value="#renewedDate#">
           AND cast(datesubmitted AS DATE) <= <cfqueryparam cfsqltype="cf_sql_date" value="#REcertEndDate#">
      </cfif>
      order by datesubmitted asc
    </cfquery>


<cfif local.results.recordcount EQ 0>
     You currently have no records.
     <cfabort>
</cfif>
	<cfset showHours = valueList(results.surveyTitle)/>
	<cfset CIPs = "1060665,1330743,1849174,2913540,2338773,3839954" />
    <cfset NoHours = "1020531" />
     <table id="myTable" class="tablesorter" width="100%"  >
        <thead>
            <tr>
                <th nowrap="nowrap" align="left">SG ID</th>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left" class="sortInitialOrder-desc">Date</th>
                <th nowrap="nowrap" align="left">Wellcoaches CEHours</th>
            </tr>
        </thead>
        <tbody>

         <cfset total = 0>
         <cfset subTotal = 0 />
         <cfset currentMonthYear = '' />


		<cfset local.module1 = 0>

    	 <cfloop query="results">


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
	                        <cfelseif surveyTitle eq 4051290 >
	                                10
								<cfset total = total + 10>
							<cfelseif surveyTitle eq 1994464>
								 4
								<cfset total = total + 4>
	                        <cfelseif surveyTitle eq 1447572 OR surveyTitle eq 1144369 OR surveyTitle eq 1959806 or surveyTitle eq 4144821>
	                                 #iif(len(hours),hours,0)#
	                                 <cfset total = total + iif(len(hours),hours,0)>

	                        <cfelseif surveyTitle eq 1117522 OR surveyTitle eq 2913540>
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
	                
	                	
	                    <td>#surveyTitle#</td>
	                
	                <!---Practical Skills--->

	                 	<cfif surveyTitle EQ '1382009' AND score GTE 80>
	                 		 <td><a href="/utilities/infusionsoft/practicalResults.cfm?surveyTitle=#surveyTitle#&id=#id#" target="_blank" />#lesson#</a></td>
	                     <cfelse>
	                     	<td>#lesson#</td>
	                	 </cfif>


	                    <td><cfif len(originalDate)>#DateFormat(originalDate,'mm/dd/yyyy')#<cfelse>#DateFormat(datesubmitted,'mm/dd/yyyy')#</cfif></td>
						<cfif !listFind(NoHours,surveyTitle)>
	                        <td>
	                            <cfif surveyTitle eq 1120644 OR surveyTitle eq 1117522 OR surveyTitle eq 2913540>
	                                1.5
									<cfset total = total + 1.5>
								<cfelseif surveyTitle eq 1013764>
									<cfif val(hours) EQ 0>&mdash;<cfelse>#val(hours)#</cfif>
										<cfset total = total + val(hours)>	

								<cfelseif  surveyTitle eq 4051290 >
									    <cfif hours EQ 0>&mdash;<cfelse>#hours#</cfif>
										<cfset total = total + hours>	
								<cfelseif surveyTitle eq 4227686 OR surveyTitle eq 1953823>
									<cfif hours EQ 0>&mdash;<cfelse>#hours#</cfif>
	                            		<cfset total = total + hours>
								<cfelseif surveyTitle eq 1994464>
								 	4
									<cfset total = total + 4>
								<cfelseif surveyTitle eq 1117550>
	                                7.5
	                                <cfset total = total + 7>
	                            <cfelseif surveyTitle eq 1026874 AND datePart('yyyy',datesubmitted) GTE '2016' >
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
	                          <cfelseif surveyTitle eq 1447572 OR surveyTitle eq 1959806 OR surveyTitle eq 1144369 or surveyTitle eq 4144821 or surveyTitle eq 4305174>
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
         
    </tbody>
    	<cfif total GT 0>
			 <tr>
				<td colspan="3"></td>
				<td >Total Hours: #total#</td>
			</tr>
         </cfif>
</table>

 
</cfoutput>
