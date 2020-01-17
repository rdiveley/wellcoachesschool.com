<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />
<cfset survey=1013764 />
<cfset url.email='kip@kipmcclure.com' />

<cfoutput>
  <cfset columnList = "datesubmitted,id,fName,lName,emailSentTo,lesson,other,class,hours,year,email,coachingSkills,businessDev,facultyExpertise,valuable,summarize,awareOf" />
 
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfset survey = "1026874" />
  <cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#survey#/surveyresponse">
  <cfhttp url="#SGurl#" result="myResult" method="get">
    <cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
    <cfhttpparam type="url"  value="[question(9), option(0)]" name="filter[field][0]"/>
    <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
    <cfhttpparam type="url"  value="#url.email#" name="filter[value][0]"/>
    <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
    <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
    <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
  </cfhttp>
  
  <cfset jsonData = deserializeJSON(myResult.fileContent) />
 
  <cfloop array="#jsonData.data#" index="field">
    <cfset queryAddRow(SurveyList)>
    <cfparam name="field['[question(33)]']" default="">
    <cfparam name="field['[question(34)]']" default="">
    <cfparam name="field['[question(35)]']" default="">
    <cfparam name="field['[question(22)]']" default="">
    <cfparam name="field['[question(29)]']" default="">
    <cfparam name="field['[question(30)]']" default="">
    <cfparam name="field['[question(8)]']" default="">
    <cfparam name="field['[question(31)]']" default="">
    <cfparam name="field['[question(28)]']" default="">
    <cfparam name="field['[question(2)]']" default="">
    <cfparam name="field['[question(25)]']" default="">
    <cfparam name="field['[question(3)]']" default="">
    <cfparam name="field['[question(5)]']" default="">
    <cfparam name="field['[question(6)]']" default="">
    <cfparam name="field['[question(7)]']" default="">
    <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
    <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
    <cfset temp = QuerySetCell(SurveyList,"fName", field['[question(33)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lName", field['[question(34)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"emailSentTo", field['[question(35)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(29)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"other", field['[question(30)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"class", field['[question(8)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"hours", field['[question(22)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"year", field['[question(28)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"email", field['[url("email")]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"coachingSkills", field['[question(2)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"businessDev", field['[question(25)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"facultyExpertise", field['[question(3)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"valuable", field['[question(5)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"summarize", field['[question(6)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"awareOf", field['[question(7)]'] )/>
  </cfloop>
  <cfquery name="results" dbtype="query">
    select * from SurveyList
    order by datesubmitted desc
</cfquery>
<table>
 <cfloop query="results">
 	<tr><td>#email#</td></tr>
 </cfloop>
</table> 
</cfoutput> 