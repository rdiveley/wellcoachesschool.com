<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />
<cfset survey=1013764 />
<cfset url.email='rdiveley@hotmail.com' />

<cfoutput>
  <cfset columnList = "datesubmitted,id,fName,lName,lesson,faculty_member,presentation,bestparts,opportunities,valuable,feedback,email" />
 
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfset survey = "1117522" />
  
  <cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#survey#/surveyresponse">
  <cfhttp url="#SGurl#" result="myResult" method="get">
    <cfhttpparam type="url"  value="erika@wellcoaches.com:Well5050" name="user:pass"/>
    <cfhttpparam type="url"  value="[question(11), option(0)]" name="filter[field][0]"/>
    <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
    <cfhttpparam type="url"  value="michele.dutton@selecthealth.org" name="filter[value][0]"/>
    <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
    <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
    <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
  </cfhttp>
  <cfset jsonData = deserializeJSON(myResult.fileContent) />

  <cfloop array="#jsonData.data#" index="field">
    <cfset queryAddRow(SurveyList)>
    <cfparam name="field['[question(2)]']" default="">
    <cfparam name="field['[question(13)]']" default="">
    <cfparam name="field['[question(14)]']" default="">
    <cfparam name="field['[question(3)]']" default="">
  	<cfparam name="field['[question(4)]']" default="">
    <cfparam name="field['[question(5)]']" default="">
    <cfparam name="field['[question(6)]']" default="">
    <cfparam name="field['[question(7)]']" default="">
    <cfparam name="field['[question(8)]']" default="">
    <cfparam name="field['[question(9)]']" default="">
    <cfparam name="field['[question(11)]']" default="">
    <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
    <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
    <cfset temp = QuerySetCell(SurveyList,"fName", field['[question(2)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lName", field['[question(13)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(3)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"faculty_member",field['[question(4)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"presentation", field['[question(5)]'] )/>
   	<cfset temp = QuerySetCell(SurveyList,"bestparts", field['[question(6)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"opportunities", field['[question(7)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"valuable", field['[question(8)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"feedback", field['[question(9)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"email", field['[question(11), option(0)]'] )/>
  </cfloop>
  <cfquery name="results" dbtype="query">
select * from SurveyList
order by datesubmitted desc
</cfquery>
 
    <table>
    	 <cfloop query="results">
         	<tr><td>#id#</td><td>#email#</td><td>#lesson#</td></tr>
         </cfloop>
    </table>
  
</cfoutput> 