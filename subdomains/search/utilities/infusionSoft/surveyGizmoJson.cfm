<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />
<cfset survey=1013764 />
<cfset url.email='rdiveley@hotmail.com' />

<cfoutput>
  <cfset SurveyList = QueryNew("datesubmitted,id,fName,lName,lesson,email,faculty_member,cohort,coachingSkills,faculty,valuable,lessonObj,summarize,aware","VarChar,VarChar,VarChar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar") />
  <cfset surveys = "1013764,1020531,1120644,1060655,1330743,106874,1117522,1117550" />
  <cfset SGurl = "https://restapi.surveygizmo.com/head/survey/1013764/surveyresponse">
  <cfhttp url="#SGurl#" result="myResult" method="get">
    <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
    <cfhttpparam type="url"  value="datesubmitted" name="filter[field][0]"/>
    <cfhttpparam type="url"  value=">=" name="filter[operator][0]"/>
    <cfhttpparam type="url"  value="2013-10-19+00:00:00" name="filter[value][0]"/>
    <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
    <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
    <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
  </cfhttp>
  <cfset jsonData = deserializeJSON(myResult.fileContent) />
  <cfloop array="#jsonData.data#" index="field">
    <cfset queryAddRow(SurveyList)>
    <cfparam name="field['[question(22)]']" default="">
    <cfparam name="field['[question(25)]']" default="">
    <cfparam name="field['[question(2)]']" default="">
    <cfparam name="field['[question(3)]']" default="">
    <cfparam name="field['[question(4)]']" default="">
    <cfparam name="field['[question(5)]']" default="">
    <cfparam name="field['[question(7)]']" default="">
    <cfparam name="field['[question(12)]']" default="">
    <cfparam name="field['[question(26)]']" default="">
    <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
    <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
    <cfset temp = QuerySetCell(SurveyList,"fName", field['[question(22)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lName", field['[question(25)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"email", field['[url("email")]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"faculty_member", field['[question(12)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"cohort", field['[question(26)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"coachingSkills", field['[question(2)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"faculty", field['[question(3)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"valuable", field['[question(5)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lessonObj", field['[question(4)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"summarize", field['[question(6)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"aware", field['[question(7)]'] )/>
  </cfloop>
  <cfquery name="results" dbtype="query">
select * from SurveyList
order by datesubmitted desc
</cfquery>
  <cfloop query="results">
    <table>
      <form action="surveyGizmo8.cfm?debug=1" method="get">
        <tr>
          <td><input type="hidden" name="lesson" value="#lesson#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="email" value="#email#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="faculty_member" value="#faculty_member#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="cohort" value="#cohort#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="coachingSkills" value="#coachingSkills#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="faculty" value="#faculty#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="valuable" value="#valuable#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="summarize" value="#summarize#" /></td>
        </tr>
        <tr>
          <td><input type="hidden" name="aware" value="#aware#" /></td>
        </tr>
        <input type="submit" value="#email#-#lesson#" />
      </form>
    </table>
  </cfloop>
</cfoutput>