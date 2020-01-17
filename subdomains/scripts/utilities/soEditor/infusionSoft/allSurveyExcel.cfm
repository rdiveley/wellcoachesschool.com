<cfset DSN = "wellcoachesSchool">
<cfquery name="getAllResults" datasource="#DSN#" username="#application.DSNuName#" password="#application.dsnpword#" >
	SELECT 
       [Lesson]
      ,[cohort]
      ,[email]
      ,[faculty]
      ,[coachingSkills]
      ,[facultyExpertise]
      ,[valuableSkills]
      ,[lessonRelevant]
      ,[summarize]
      ,[awareOf]
      ,[attendLive]
      ,[infusionSoftID]
      ,[dateSubmitted]
  FROM [wellcoachesSchool].[dbo].[SurveyResults]
  where faculty like '#URL.coach#'
</cfquery>
<cfheader name="Content-Disposition" value="inline; filename=coachReport.xls">
<cfcontent type="application/vnd.ms-excel">

<table border="2">
  <tr>
    <th>Lesson</th>
    <th>Cohort</th>
    <th>Email</th>
    <th>Faculty</th>
    <th>Coaching Skills</th>
    <th>Faculty Expertise</th>
    <th>Valuable Skills</th>
    <th>Lesson Relevant</th>
    <th>Summarize</th>
    <th>Aware Of</th>
    <th>Attended Live</th>
    <th>Date Submitted</th>
  </tr>
  <cfoutput query="getAllResults">
    <tr>
      <td>#Lesson#</td>
      <td>#cohort#</td>
      <td>#email#</td>
      <td>#faculty#</td>
      <td>#coachingSkills#</td>
      <td>#facultyExpertise#</td>
      <td>#valuableSkills#</td>
      <td>#lessonRelevant#</td>
      <td>#summarize#</td>
      <td>#awareOf#</td>
      <td>#attendLive#</td>
      <td>#DateFormat(dateSubmitted,'mm/dd/yyyy')#</td>
    </tr>
  </cfoutput>
</table>
</cfcontent>
