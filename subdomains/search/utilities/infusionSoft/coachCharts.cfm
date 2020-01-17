<cfif url.coach NEQ "Pam Schmid">
	Coming Soon
<cfabort>
<cfelse>
<cfset DSN = "wellcoaches">

<cfoutput><h3>Coach: #URL.coach#: </h3> </cfoutput>
<form name="coachStats" method="post">


<cfquery name="getLessons" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	select distinct 
        lesson, 
    	cohort
    FROM [wellcoachesSchool].[dbo].[SurveyResults]
    where faculty like '%#URL.coach#%'
    group by cohort, lesson
</cfquery>


<cfparam name="FORM.lessonCohort" default="#getLessons.lesson#">


<select name="lessonCohort" onchange="submit()">
	<cfoutput query="getLessons" group="cohort">
    	<option value="0">-- Please select a Lesson -- </option>
    	<optgroup label="#cohort#">
        	<cfoutput>
			<option  value="#lesson#_#cohort#" <cfif FORM.lessonCohort EQ '#lesson#_#cohort#'>selected</cfif>> #lesson# #cohort#</option>
        	</cfoutput>
        </optgroup>    
    </cfoutput>
</select>

<input type="hidden" name="submittedForm" value="1" />
<cfif structkeyExists(form,'submittedForm')>

<cfset questions = "coachingSkills,facultyExpertise,lessonRelevant">
<table>

<cfloop list="#questions#" index="question">
    <cfquery name="coachStats" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
        select
           Sum(CASE WHEN #question# = 5 THEN 1 Else 0 End) excellent,  
           Sum(CASE WHEN #question# = 4  THEN 1 Else 0 End) good,
           Sum(CASE WHEN #question# = 3  THEN 1 Else 0 End) average,
           Sum(CASE WHEN #question# = 2  THEN 1 Else 0 End) below,
           Sum(CASE WHEN #question# = 1  THEN 1 Else 0 End) improvement,
           Sum(CASE WHEN #question# = 'NA'  THEN 1 Else 0 End) notapplicable
           
        FROM [wellcoachesSchool].[dbo].[SurveyResults]
        where faculty like '%#URL.coach#%' 
       <cfif isDefined("FORM.lessonCohort")>
            and lesson like '#listFirst(FORM.lessonCohort,"_")#' AND cohort like '%#listLast(FORM.lessonCohort,"_")#%'
        </cfif>
    </cfquery>
   
   <tr>
   	<td>
    <cfif question EQ 'coachingSkills'>
    	<h3>I learned new coaching skills by participating in this Lesson</h3>
     <cfelseif question EQ 'facultyExpertise'>
     	<h3>The faculty member demonstrated expertise regarding the content. </h3>
     <cfelseif question EQ 'lessonRelevant'>  
     	<h3>This Lesson was relevant to the objective of the course</h3> 
     </cfif>
            <cfchart
                 format="png"
                 scalefrom="0"
                 scaleto="1200000"
                 pieslicestyle="solid"
                 chartheight="300">
            <cfchartseries
                         type="pie"
                         serieslabel="Coaching Stats"
                         seriescolor="blue">
                <cfloop query="coachStats">         
                    <cfchartdata item="Strongly disagree" value="#val(improvement)#">
                    <cfchartdata item="Disagree" value="#val(below)#">
                    <cfchartdata item="Neutral" value="#val(average)#">
                    <cfchartdata item="Agree" value="#val(good)#">
                    <cfchartdata item="Strogly Agree" value="#val(excellent)#">
                    <cfchartdata item="Not Applicable" value="#val(notapplicable)#">
                    
                </cfloop>
                
                
            </cfchartseries>
        </cfchart>
        </td>
      </tr>  
</cfloop>
</table>
</cfif>
</form>
</cfif>
