

<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />

<cfparam name="url.email" default="mtilford54@yahoo.com,mtilford54@yahoo.com" />
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
<cfquery name="getAllEmails" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	select email_address
    from coachInPracticeEmailFix
    where email_address like '%#url.email#%'
</cfquery>

<cfif getAllEmails.recordCount GT 0>
	<cfset local.email = ReplaceNoCase(getAllEmails.email_address,"'","","all") />
<cfelse>
	<cfset local.email = ReplaceNoCase(url.email,"'","","all") />    
</cfif>


<cfoutput>
  <cfset columnList = "datesubmitted,id,lesson,email,surveyTitle,hours" />
 
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfset allsurveys = "1013764,1020531,1120644,1060665,1330743,1117522,1026874,1117550,1447572">
  <cfset group1 = "1013764,1020531,1120644,1060665,1330743" />
  <cfloop list="#allsurveys#" index="column">
		
 		<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#column#/surveyresponse">
     	
        <cfparam name="emailParam" default="[question(9)]" />
       
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
        </cfif>  
    	
        <cfhttp url="#SGurl#" result="myResult" method="get">
        <cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
      	<cfhttpparam type="url"  value="#emailParam#" name="filter[field][0]"/>
        <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
        <cfhttpparam type="url"  value="#local.email#" name="filter[value][0]"/>
        <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
        <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
        <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
      </cfhttp>
      
      <cfset jsonData = deserializeJSON(myResult.fileContent) />
     
	 
	 <cfif structKeyExists(jsonData,'data') and NOT arrayIsEmpty(jsondata.data)> 
   	
        <cfloop array="#jsonData.data#" index="field">
          
          <cfset queryAddRow(SurveyList)>
            <cfparam name="field['[question(9)]']" default="">
            <cfparam name="field['[question(8)]']" default="">
            <cfparam name="field['[question(29)]']" default="">
            <cfparam name="field['[question(11)]']" default="">
            <cfparam name="field['[question(3)]']" default="">
            <cfparam name="field['[question(17)]']" default="">
            <cfparam name="field['[question(6)]']" default="">
            <cfparam name="field['[question(3)]']" default="">
           
            <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
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
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
           	<cfelseif column eq 1117550>
                <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(6)]'] )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>
            <cfelseif column eq 1447572>
                <cfset temp = QuerySetCell(SurveyList,"lesson", 'Hours adjusted' )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>  
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(3)]'] )/>  
           	</cfif>
          	<cfset temp = QuerySetCell(SurveyList,"surveyTitle", column )/>
          </cfloop>
      </cfif>
  </cfloop>
   
    <cfquery name="results" dbtype="query">
      select * from SurveyList
      order by datesubmitted desc
    </cfquery>

	<cfset showHours = valueList(results.surveyTitle)/>
	<cfset CIPs = "1060665,1330743" />
    <cfset NoHours = "1013764,1020531" />
     <table width="100%" >
        <thead>
            <tr>
            	<th nowrap="nowrap" align="left">ID</th>
                <th nowrap="nowrap" align="left">Survey ##</th>
                <th nowrap="nowrap" align="left">Date</th>
                <th nowrap="nowrap" align="left">Hours</th>
            </tr>
        </thead>
        <tbody>
    
         <cfset total = 0>
    	 <cfloop query="results">
         <form action="./surveyPDF.cfm" name="openPDF#id#" method="post">	
         	<input type="hidden" name="id" value="#id#" />
            <input type="hidden" name="surveyTitle" value="#surveyTitle#" />
            	<tr>
                	<td>#id#</td>
                	<td>#surveyTitle#</td>
                	<td><a href="##" onclick="window.open('./regenerateSurvey_#surveyTitle#.cfm?id=#id#&lesson=#urlEncodedFormat(lesson)#&surveyTitle=#surveyTitle#','openPDF#id##currentrow#','width=750,height=750,menubar=no,resizable=no,directories=no,location=no')">#lesson#</a></td>
                	<td>#DateFormat(datesubmitted,'mm/dd/yyyy')#</td>
                </tr>
        </form>
         </cfloop>
        
    </tbody>
    </table>

  	
</cfoutput> 