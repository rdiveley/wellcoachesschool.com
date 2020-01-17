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
<cfquery name="getAllEmails" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	select max(email_address) as email_address
    from coachInPracticeEmailFix
    where email_address like '%#url.email#%'
</cfquery>



<cfif getAllEmails.recordCount GT 0 AND Len(getAllEmails.email_address)>
	<cfset local.email = lcase(ReplaceNoCase(getAllEmails.email_address,"'","","all")) />
<cfelse>
	<cfset local.email = lcase(ReplaceNoCase(url.email,"'","","all")) />    
</cfif>
<cfoutput>
<!---<cfinclude template="getUser.cfm">
<cfif isDate(renewedDate) AND isDate(REcertEndDate)>
    Hours are for Certification period: #renewedDate# to #REcertEndDate#
</cfif>--->


<!---<cftry>--->
  <cfset columnList = "datesubmitted,id,lesson,email,surveyTitle,hours,score" />
 
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfset allsurveys = "1013764,1020531,1120644,1060665,1330743,1117522,1026874,1117550,1447572,1144369,1849174,1953823,1994464,1382009,2338773,1959806">
  <cfset group1 = "1013764,1020531,1120644,1060665,1330743,1849174,2338773" />
  
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
        <cfelseif Find(1144369,column)>
         	<cfset emailParam = "[question(32)]" /> 
        <cfelseif Find(1382009,column)>
         	<cfset emailParam = "[question(21)]" />  
        <cfelseif Find(1959806,column)>
         	<cfset emailParam = "[question(37)]" />            
        </cfif>  
    	
        <cfhttp url="#SGurl#" result="myResult" method="get">
        	   <cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
      	   <cfhttpparam type="url"  value="#emailParam#" name="filter[field][0]"/>
             <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
             <cfhttpparam type="url"  value="#lcase(local.email)#" name="filter[value][0]"/>
             <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
             <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
             <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
             <cfhttpparam type="url"  value="300" name="resultsperpage"/>
      </cfhttp>
      
      <cfset jsonData = deserializeJSON(myResult.fileContent) />
     
     
    
	 <cfif structKeyExists(jsonData,'data') and NOT arrayIsEmpty(jsondata.data)> 
   	
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
            <cfparam name="field['[question(16), option(0)]']" default="">
            
         
            <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
            
            <cfif column eq 1953823>
         		<cfset temp = QuerySetCell(SurveyList,"lesson", 'Core Coach Training - 4-day on-site program - Feedback Survey' )/>
            </cfif>
            
            <cfif column eq 1994464>
         		<cfset temp = QuerySetCell(SurveyList,"lesson", 'organize your mind online+mobile course - Feedback Survey' )/>
            </cfif>
            <!---Practical Skills Assessment--->
            <cfif column eq 1382009>
           	<cfset temp = QuerySetCell(SurveyList,"lesson", 'Practical Skills Assessment' )/>
               <cfset temp = QuerySetCell(SurveyList,"score", field['[question(16), option(0)]'] )/>
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
                <cfset temp = QuerySetCell(SurveyList,"lesson", 'Hours adjusted' )/>
                <cfset temp = QuerySetCell(SurveyList,"email", field['#emailParam#'] )/>  
                <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(3)]'] )/>  
           </cfif>
          	<cfset temp = QuerySetCell(SurveyList,"surveyTitle", column )/>
               <cfset temp =  QuerySetCell(SurveyList,"id", field['id']  )/>
              
              
          </cfloop>
      </cfif>
  </cfloop> 
  
    <cfquery name="results" dbtype="query">
      select * from SurveyList
     <!--- <cfif isDate(renewedDate) AND isDate(REcertEndDate)>
      	where cast(datesubmitted AS DATE) >= <cfqueryparam cfsqltype="cf_sql_date" value="#renewedDate#">
           AND cast(datesubmitted AS DATE) <= <cfqueryparam cfsqltype="cf_sql_date" value="#REcertEndDate#"> 
      </cfif>--->
      order by datesubmitted desc
    </cfquery>

	<cfset showHours = valueList(results.surveyTitle)/>
	<cfset CIPs = "1060665,1330743,1849174" />
    <cfset NoHours = "1013764,1020531,2338773" />
     <table id="myTable" class="tablesorter" width="100%" >
        <thead>
            <tr>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left">Date</th>
                <th nowrap="nowrap" align="left">Hours.</th>
            </tr>
        </thead>
        <tbody>
    
         <cfset total = 0>
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
                           <cfelseif surveyTitle eq 1994464>
                                10    
						<cfset total = total + 10>  
                            <cfelseif surveyTitle eq 1026874 OR surveyTitle eq 1447572 OR surveyTitle eq 1144369 OR surveyTitle eq 1959806>
                                 #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)> 
                           <!--- <cfelseif surveyTitle eq 1447572>
                                 #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)>  
                            <cfelseif surveyTitle eq 1144369>
                                 #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)> --->
                            <cfelseif surveyTitle eq 1117522>
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
                
                    
                    <td>#DateFormat(datesubmitted,'mm/dd/yyyy')#</td>
					<cfif !listFind(NoHours,surveyTitle)>
                        <td>
                            <cfif surveyTitle eq 1120644 OR surveyTitle eq 1117522>
                                1.5
                                <cfset total = total + 1.5>
                            <cfelseif surveyTitle eq 1994464>
                                10    
						<cfset total = total + 10>    
                            <cfelseif surveyTitle eq 1117550>
                                7.5
                                <cfset total = total + 7>
                          <cfelseif surveyTitle eq 1026874 OR surveyTitle eq 1447572 OR surveyTitle eq 1144369 OR surveyTitle eq 1959806>
                                  #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)>	
                           <!--- <cfelseif surveyTitle eq 1447572>
                                 #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)>  
                            <cfelseif surveyTitle eq 1144369>
                                 #iif(len(hours),hours,0)#
                                 <cfset total = total + iif(len(hours),hours,0)> 
                            <cfelseif surveyTitle eq 1117522>
                                  1.5
                            	 <cfset total = total + 1.5>   --->  
                            <cfelseif surveyTitle eq 1382009>
                            		&mdash;
                            	<cfset total = total + 0>              
                            <cfelse>
                                	1    
                                <cfset total = total + 1>
                            </cfif>
                        </td>
                    <cfelse>
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
			<option  value="40">40</option>
		</select>
        See more results (default display is 10 records)
	</form>
</div>
<!---  	<cfcatch type="any" >
    	We are currently down for maintenance.  Please check back soon!
        <cfif isdefined('url.debug')>
        	
              <cfdump var="#cfcatch#"><cfabort>
             
        </cfif>
        
    </cfcatch>
</cftry>--->
</cfoutput> 
