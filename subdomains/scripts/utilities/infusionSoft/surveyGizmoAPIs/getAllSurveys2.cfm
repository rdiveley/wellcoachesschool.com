
<!--- Your Original Business Logic with Modern Presentation --->
<cfinclude template="css\surveys.css" />
<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />

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

<cfset columnList = "datesubmitted,id,lesson,email,surveyTitle,hours,score,premiumHours,originaldate" />
<cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />

<cfset allsurveys = "8478679,8458513,8344775,7820856,8126766,8126787,8126788,8126776,8107114,7716175,6439452,7135970,7649972,7668732,7668729,7668720,7668724,7668749,7473115,7518337,7394404,7135970,7188154,7188173,7188169,7188120,7178225,7080225,6738809,6756318,6734022,6697766,6697769,6697765,6657242,6634902,6439452,6350222,6307281,6174060,6174072,5820302,5121979,5769769,5664658,5508580,1013764,1020531,1120644,1060665,1330743,1117522,1026874,1117550,1447572,1849174,1953823,1994464,2338773,1959806,1144369,2913540,3839954,4229417,4051290,4144821,4305174,4227686,4320651,4543424,4776929,4144821,1959806,4238384">
<cfset group1 = "1013764,1020531,1120644,1060665,1330743,1849174,2338773,2913540,3839954" />

<cfloop list="#local.email#" index="local.emailUser" delimiters=",">
  <cfloop list="#allsurveys#" index="column">

 	   <cfset SGurl = "https://restapi.surveygizmo.com/v4/survey/#column#/surveyresponse">
       <cfset emailParam = "[question(9), option(0)]" />

	   <cfif listFind(group1,column) >
        	<cfset emailParam = "[question(9), option(0)]" />
			<cfif findNoCase(1013764, column)>
				<cfset emailParam = "[question(50)]" />
			</cfif>
        <cfelseif Find(1117522,column)>
         	<cfset emailParam = "[question(11)]" />
		<cfelseif listFind("1013764,1020531,1120644,1060665,1330743,1849174,2338773,2913540,3839954", column)>
         	<cfset emailParam = "[question(50)]" />
        <cfelseif Find(1117550,column)>
         	<cfset emailParam = "[question(17)]" />
        <cfelseif Find(1447572,column)>
         	<cfset emailParam = "[question(2)]" />
        <cfelseif Find(1144369,column)>
         	<cfset emailParam = "[question(32)]" />
        <cfelseif Find(1382009,column)>
			 <cfset emailParam = "[question(21)]" />
		<cfelseif listFind("7820856,6439452,7135970,7649972,7135970,4543424,5121979,6439452", column) >
			<cfset emailParam = "[question(26)]" />		 
        <cfelseif Find(4227686,column) OR find(4320651,column)>
			 <cfset emailParam = "[question(61)]" />
		<cfelseif listFind("8458513,8126788,8126787,8126776,8107114,5664658,1026874,7716175,7668732,7668729,7668720,7668724,7473115,7394404,7188154,5508580,7188173,7188169,7188120,7080225,5769769,4144821,6174072,6350222,6657242,6697765,6697769,6738809,6756318,6734022", column)>
			<cfset emailParam = "[question(35)]" />	 
		<cfelseif listFind("8126766,7668749,7518337,1959806,4305174,4776929,6634902,5664658,6697766,7178225,4238384,6174060,6307281", column) >
			<cfset emailParam = "[question(37)]" />	 
		<cfelseif Find(4229417,column)  >
			<cfset emailParam = "[question(90)]" />		
		<cfelseif ListFind("4051290,8344775,5820302",column)  >
			<cfset emailParam = "[question(93)]" />		
		</cfif>

	  <cfset local.params = "filter[field][0]=#urlEncodedFormat(emailParam)#&filter[operator][0]=in&filter[value][0]=#trim(urlEncodedFormat(local.emailUser))#&filter[field][1]=status&filter[operator][1]==&filter[value][1]=complete&resultsperpage=500" />

	  <cfhttp url="#SGurl#" method="GET" timeout="60" result="httpResult">
         <cfhttpparam type="url" name="api_token" value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca">
         <cfhttpparam type="url" name="filter[field][0]" value="#emailParam#">
         <cfhttpparam type="url" name="filter[operator][0]" value="in">
         <cfhttpparam type="url" name="filter[value][0]" value="#trim(local.emailUser)#">
         <cfhttpparam type="url" name="filter[field][1]" value="status">
         <cfhttpparam type="url" name="filter[operator][1]" value="=">
         <cfhttpparam type="url" name="filter[value][1]" value="complete">
         <cfhttpparam type="url" name="resultsperpage" value="500">
      </cfhttp>

<cfif isDefined("httpResult.fileContent") AND len(httpResult.fileContent)>
    <cfset myResult = httpResult.fileContent>
<cfelse>
    <cfset myResult = "{}">
</cfif>

      <cfset jsonData = deserializeJSON(myResult) />

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
			<cfparam name="field['[question(50)]']" default="">
          	<cfparam name="field['[question(61)]']" default="">
			<cfparam name="field['[question(93)]']" default="">
			<cfparam name="field['[question(80)]']" default="">
			<cfparam name="field['[question(24)]']" default="">
			<cfparam name="field['[question(49)]']" default="">
			<cfparam name="field['[question(60)]']" default="">
			<cfparam name="field['[question(88)]']" default="">
			<cfparam name="field['[question(89)]']" default="">
			<cfparam name="field['[question(119)]']" default="">
			<cfparam name="field['[question(120)]']" default="">
			<cfparam name="field['[question(122)]']" default="">
			<cfparam name="field['[question(123)]']" default="">
			<cfparam name="field['[question(124)]']" default="">
			<cfparam name="field['[question(129)]']" default="">
			<cfparam name="field['[question(4)]']" default="">

			<cfif column eq 1144369 AND len(field['[question(49)]'])>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['[question(49)]'] )/>
			<cfelse>
				<cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
			</cfif>

            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>

            <cfif column eq 1953823 or column eq 6174060>
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

			 <cfif column eq 7080225>
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(120)]']  )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			</cfif>

			<cfif listfind("8126766,6697766,7178225",column)>
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(40)]']  )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			</cfif>
			   
			<cfif column eq 4238384 >
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(43)]']  )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
			</cfif>

			<cfif column eq 8344775>
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Wellcoaches Sept 2025 fwd. habits survey'  )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
				<cfset temp = QuerySetCell(SurveyList,"hours", "10" )/>	
			</cfif>

			<cfif column eq 5820302 >
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Wellcoaches Behavior Change Agent'  )/>
				<cfset temp = QuerySetCell(SurveyList,"email", field['[question(93)]'] )/>
			</cfif>

			<cfif listFind("8126787,8126776,7473115",column)>
				
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(123)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", "9" )/>	
				<cfif findNoCase('specialty', field['[question(123)]']) >
					<cfset temp = QuerySetCell(SurveyList,"hours", "5" )/>
				<cfelseif findNoCase('weight', field['[question(123)]']) >
					<cfset temp = QuerySetCell(SurveyList,"hours", "9" )/>
				<cfelseif findNoCase('noise', field['[question(123)]']) >
					<cfset temp = QuerySetCell(SurveyList,"hours", "3" )/>
				<cfelseif findNoCase('motivational', field['[question(123)]']) >
					<cfset temp = QuerySetCell(SurveyList,"hours", "10" )/>	
				<cfelseif findNoCase('medications', field['[question(123)]']) >
					<cfset temp = QuerySetCell(SurveyList,"hours", "6" )/>		
				</cfif>
				<cfif listfind("8126787,8126776",column) >
					<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(119)]'] )/>
				</cfif>
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
			<cfelseif column eq 6634902>
				<cfset temp = QuerySetCell(SurveyList,"lesson", 'Holiday Credit' )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(37)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"premiumHours", field['[question(31)]'] )/>
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
			<cfelseif listFind("7820856,6439452,7135970,7649972,4543424,5121979,6439452,7135970",column)>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]']  )/>
				<cfif listFind('7820856,6439452,7135970,7649972,7135970', column) and field['[question(8)]'] contains 'Residential'>
					<cfset temp = QuerySetCell(SurveyList,"hours", '20' )/>
				<cfelse>
					<cfset temp = QuerySetCell(SurveyList,"hours", '1.5' )/>
				</cfif>
		    <cfelseif column eq 4144821 >
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(9), option(0)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
		   <cfelseif listFind("7668749,7518337,4305174,4305174,6307281",column)>
				<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(39)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(37)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
				<cfif listFind("7668749", column)>
					<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(40)]'] )/>
				</cfif>
			<cfelseif column eq 5508580 OR column eq 6174072 or column eq 6350222>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(120)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			<cfelseif listFind("8107114,7668732,7668729,7668724,7668720,5664658",column)>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
				<cfif column eq 8107114>
					<cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(129)]'] )/>
				</cfif>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
				<cfif listFInd("7668729,7668732",column)>
					<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(119)]'] )/>
					<cfset temp = QuerySetCell(SurveyList,"hours", 1 )/>
				</cfif>
			<cfelseif column eq 7080225 >
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(120)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
			<cfelseif  listFind("8478679,8458513,8126788,5769769",column)>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(124)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
				<cfif column EQ 8126788>
					<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(119)]'] )/>
				</cfif>
				<cfif listFind("8478679,8458513",column)>
					<cfset temp = QuerySetCell(SurveyList,"hours", 1 )/>
				</cfif>
                	
			<cfelseif listFind("7716175,7394404,7188154,7188173,7188169,7188120,6657242,6697765,6697769,6734022,6756318,6738809",column)>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['[question(35)]'] ) />
				<cfif listFind("7716175,6697765,6738809",column)>
					<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(122)]'] )/>
				<cfelseif listFind("7188173,7188169,6697769,6756318", column)>
					<cfset temp = QuerySetCell(SurveyList,"hours", field['[question(31)]'] )/>
				<cfelseif listFind("7394404", column)>
					<cfset temp = QuerySetCell(SurveyList,"hours", 8 )/>
				<cfelse>
					<cfset temp = QuerySetCell(SurveyList,"hours", 1 )/>
				</cfif>
                	
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
     <div class="container">
        <div class="header">
            <h1>Continuing Education Tracker</h1>
            <p>Professional Development Hours Summary</p>
        </div>
        <div class="no-results">
            <h3>No Records Found</h3>
            <p>You currently have no continuing education records.</p>
        </div>
     </div>
     <cfabort>
</cfif>

	<cfset showHours = valueList(results.surveyTitle)/>
	<cfset CIPs = "1060665,1330743,1849174,2913540,2338773,3839954" />
    <cfset NoHours = "1013764,1020531" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Continuing Education Hours Tracker</title>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Continuing Education Tracker</h1>
            <p>Professional Development Hours Summary</p>
        </div>
        
        <!-- Dashboard Section -->
        <div class="dashboard">
            <div class="dashboard-grid">
                <div class="stat-card">
                    <span class="stat-number" id="totalHours">0</span>
                    <span class="stat-label">Total Hours</span>
                </div>
                <div class="stat-card">
                    <span class="stat-number" id="totalRecords">#results.recordCount#</span>
                    <span class="stat-label">Total Records</span>
                </div>
                
            </div>
            
            <cfif isDate(renewedDate) AND isDate(REcertEndDate)>
                <div class="certification-period">
                    <h3>Certification Period</h3>
                    <p>Hours may be claimed from <strong>#dateFormat(renewedDate, "mm/dd/yyyy")#</strong> 
                    to <strong>#dateFormat(REcertEndDate, "mm/dd/yyyy")#</strong></p>
                </div>
            </cfif>
        </div>
        
        <!-- Controls Section -->
        <div class="controls">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search lessons, dates, or hours...">
            </div>
            <div class="pagination-controls">
                <label>Show:</label>
                <select id="pageSize">
                    <option value="10">10</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                </select>
                <button id="firstPage" onclick="changePage('first')">First</button>
                <button id="prevPage" onclick="changePage('prev')">Previous</button>
                <span id="pageInfo">Showing records</span>
                <button id="nextPage" onclick="changePage('next')">Next</button>
                <button id="lastPage" onclick="changePage('last')">Last</button>
            </div>
        </div>
        
        <div class="table-container">
            <table class="modern-table" id="surveyTable">
                <thead>
                    <tr>
                        <th class="sortable">Lesson</th>
                        <th class="sortable">Date</th>
                        <th class="sortable" align="center">Hours</th>
                        <cfif isDefined('url.debug')>
                            <th class="sortable">ID</th>
                            <th class="sortable">Survey Title</th>
                        </cfif>
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

	         <cfif listFind(CIPS,surveyTitle)>
	         		<tr>
	                	<td><a href="##" onclick="window.open('./surveyPDF.cfm?id=#urlencodedformat(ID)#&surveyTitle=#urlencodedformat(surveyTitle)#','openPDF#id#','width=750,height=750,menubar=no,resizable=no,directories=no,location=no')" class="lesson-link">#lesson#</a></td>
	                	<td class="date-cell">#DateFormat(datesubmitted,'mm/dd/yyyy')#</td>

						<cfif !listFind(NoHours,surveyTitle)>
	                        <td class="hours-cell">
	                        <cfif lesson contains 'residential'>
	                                <span class="hours-positive">21</span>
								<cfset total = total + 21>
	                        <cfelseif surveyTitle eq 1117550>
	                                <span class="hours-positive">7.5</span>
								<cfset total = total + 7>
							<cfelseif surveyTitle eq 4776929>
								<span class="hours-positive">4.5</span>
								<cfset total = total + 4.5>	
	                        <cfelseif surveyTitle eq 4229417  OR surveyTitle eq 4051290>
	                                <span class="hours-positive">10</span>
								<cfset total = total + 10>
							<cfelseif surveyTitle eq 1994464>
								<span class="hours-positive">4</span>
								<cfset total = total + 4>
	                        <cfelseif listFind("1447572,1144369,1959806,4144821",surveyTitle)>
	                                 <span class="hours-positive">#iif(len(hours),hours,0)#</span>
	                                 <cfset total = total + iif(len(hours),hours,0)>
	                        <cfelseif listFind("1117522,2913540,5121979",surveyTitle)>
	                                  <span class="hours-positive">1.5</span>
	                            	 <cfset total = total + 1.5>
	                        <cfelse>
	                                <span class="hours-positive">1.5</span>
						   		<cfset total = total + 1.5>
	                        </cfif>
	                        </td>
	                    <cfelse>
	                    	<td class="hours-cell"><span class="hours-zero">-</span></td>
	                    </cfif>
	                    <cfif isDefined('url.debug')>
	                        <td>#id#</td>
	                        <td>#surveyTitle#</td>
	                    </cfif>
	                </tr>
	        	<cfelse>
	            	<tr>
	                 	<cfif surveyTitle EQ '1382009' AND score GTE 80>
	                 		 <td><a href="/utilities/infusionsoft/practicalResults.cfm?surveyTitle=#surveyTitle#&id=#id#" target="_blank" class="lesson-link">#lesson#</a></td>
	                     <cfelse>
	                     	<td>#lesson#</td>
	                	 </cfif>

						<td class="date-cell">
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
	                        <td class="hours-cell">
								<cfif listFind("1120644,1117522,2913540,5508580,5121979", surveyTitle)>
									<cfif findNoCase('Residential', lesson) AND surveyTitle EQ 5121979>
										<span class="hours-positive">20</span>
										<cfset total = total + 20 />
									<cfelse>
										<span class="hours-positive">1.5</span>
										<cfset total = total + 1.5>
									</cfif>	
									
								<cfelseif listFind("4229417,4051290", surveyTitle) >
									<cfset local.habits++>
									
	                            	<cfif (habitsComplete EQ "Y" OR habitsComplete EQ 'STANDALONE') AND (local.habits eq 8 AND !structKeyExists(local, 'habitsAdded'))>
		                                <span class="hours-positive">10</span>
										<cfset total = total + 10>
										<cfset local.habitsAdded  = 1 />
									<cfelse>
										<span class="hours-zero">&mdash;</span>
	                            		<cfset total = total + 0>
									</cfif>
								<cfelseif  surveyTitle eq 4238384 >
	                            	<cfset local.module2++>
	                            	<cfif Module2Complete EQ "Y" AND (local.module2 gte 4 AND !structKeyExists(local, 'mod2Added'))>
		                                <span class="hours-positive">10</span>
										<cfset total = total + 10>
										<cfset local.mod2Added  = 1 />
									<cfelse>
										<span class="hours-zero">&mdash;</span>
	                            		<cfset total = total + 0>
									</cfif>	
								<cfelseif listFind("4227686,1953823", surveyTitle)>
										<span class="hours-zero">&mdash;</span>
										<cfset total = total + 0>
								<cfelseif surveyTitle eq 4320651 >
										<span class="hours-positive">21.5</span>
										<cfset total = total + 21.5>		
								<cfelseif surveyTitle eq 5820302 >
										<span class="hours-positive">5.5</span>
	                            		<cfset total = total + 5.5>		
								<cfelseif surveyTitle eq 1994464>
								 	<span class="hours-positive">4</span>
									<cfset total = total + 4>
								<cfelseif surveyTitle eq 4776929>
									<span class="hours-positive">4.5</span>
									<cfset total = total + 4.5>		
								<cfelseif surveyTitle eq 1117550>
	                                <span class="hours-positive">7.5</span>
	                                <cfset total = total + 7>
									
	                            <cfelseif listFind("8126766,1026874,5664658,6634902,7668729,7668720,7668732,4144821,5769769,6298191,6756318,6738809,6697769,6734022,7188169,7716175,7188154,6657242,6697765,7668724,7188173,7188120", surveyTitle) AND datePart('yyyy',datesubmitted) GTE '2016' >
								 <!---clear the subtotal when it's a new month--->
	                                    <cfif currentMonthYear NEQ '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'>
	                                        <cfset subtotal = 0 />
	                                        <cfset currentMonthYear = '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'  />
	                                    </cfif>

	                                    <!---if month is the same add up subtotal--->
	                                    <cfif currentMonthYear EQ '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'>

	                                        <cfset currentMonthYear = '#datePart('m',datesubmitted)##datePart('yyyy',datesubmitted)#'  />
	                                        <cfset subtotal++/>

	                                        <!---always show premium hours--->
	                                        <cfif len(premiumHours)>
	                                             <span class="hours-positive">#premiumHours#</span>
	                                             <cfset total = total + premiumHours />

	                                        <cfelse>
	                                             <cfif subtotal LTE 4 >
	                                                  <span class="hours-positive">#iif(len(hours),hours,0)#</span>
	                                                  <cfset total = total + iif(len(premiumHours), premiumHours, iif(len(hours),hours,0)) />
	                                             <cfelse>
	                                                  <span class="hours-zero">[over allotted classes for #monthasstring(datePart('m',datesubmitted))#]</span>
	                                             </cfif>
	                                        </cfif>
	                                     </cfif>

							  <cfelseif surveyTitle eq 1026874 AND datePart('yyyy',datesubmitted) LTE '2015'>
	 								 <span class="hours-positive">#iif(len(hours),hours,0)#</span>
	                                 <cfset total = total + iif(len(hours),hours,0)>
	                          <cfelseif listFind("8478679,8458513,8344775,7820856,7716175,6439452,7135970,7649972,7668732,7668729,7668720,7668724,7668749,7473115,7518337,7394404,7135970,7188173,7188169,7178225,6697766,1447572,1959806,1144369,4144821,4305174,5769769,6174072,6174060,6307281,6350222,6697765,6697769,6756318,6657242,6738809", surveyTitle)>
	                                  <span class="hours-positive">#iif(len(hours),hours,0)#</span>
	                                 <cfset total = total + iif(len(hours),hours,0)>
	                          <cfelseif surveyTitle eq 1382009>
	                            		<span class="hours-zero">&mdash;</span>
	                            	<cfset total = total + 0>

	                            <cfelse>
	                                	<span class="hours-positive">1</span>
	                                <cfset total = total + 1>
	                            </cfif>
	                        </td>
	                    <cfelse>
	                    	<td class="hours-cell"><span class="hours-zero">-</span></td>
	                    </cfif>
	                    <cfif isDefined('url.debug')>
	                        <td>#id#</td>
	                        <td>#surveyTitle#</td>
	                    </cfif>
	                </tr>
	        	</cfif>

         </cfloop>
                </tbody>
                <cfif total GT 0>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="3" style="text-align: right;">
                                <strong>Total Hours: #total#</strong>
                            </td>
                            <cfif isDefined('url.debug')>
                                <td colspan="2"></td>
                            </cfif>
                        </tr>
                    </tfoot>
                </cfif>
            </table>
        </div>
    </div>
</cfoutput>
   <cfinclude template="js/survey.js" />
</body>
</html>
