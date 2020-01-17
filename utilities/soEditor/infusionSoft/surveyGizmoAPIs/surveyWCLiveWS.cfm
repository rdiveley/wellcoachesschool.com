<cfset local.user = 'erika@wellcoaches.com' />
<cfset local.password= 'Well5050' />

<cfset url.email='denise.hasegawa@chomp.org' />

<cfoutput>
  <cfset columnList = "datesubmitted,id,lesson,facilitator,reason,helpful,meetExpectations,whatways,facilitator,quality,comments,email" />
 
  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfset survey = "1117550" />
  
  <cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#survey#/surveyresponse">
  <cfhttp url="#SGurl#" result="myResult" method="get">
    <cfhttpparam type="url"  value="#local.user#:#local.password#" name="user:pass"/>
    <cfhttpparam type="url"  value="[question(17), option(0)]" name="filter[field][0]"/>
    <cfhttpparam type="url"  value="in" name="filter[operator][0]"/>
    <cfhttpparam type="url"  value="#url.email#" name="filter[value][0]"/>
    <cfhttpparam type="url"  value="status" name="filter[field][1]"/>
    <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
    <cfhttpparam type="url"  value="Complete" name="filter[value][1]"/>
  </cfhttp>
  <cfset jsonData = deserializeJSON(myResult.fileContent) />
<cfdump var="#jsondata#"><cfabort>
  <cfloop array="#jsonData.data#" index="field">
    <cfset queryAddRow(SurveyList)>
    <cfparam name="field['[question(6)]']" default="">
    <cfparam name="field['[question(7)]']" default="">
    <cfparam name="field['[question(14)]']" default="">
    <cfparam name="field['[question(9)]']" default="">
  	<cfparam name="field['[question(10)]']" default="">
    <cfparam name="field['[question(11)]']" default="">
    <cfparam name="field['[question(12)]']" default="">
    <cfparam name="field['[question(13)]']" default="">
    <cfparam name="field['[question(14)]']" default="">
    <cfparam name="field['[question(11), option(0)]']" default="">
    
    <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
    <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
    <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(6)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"facilitator", field['[question(7)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"reason", field['[question(14)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"helpful",field['[question(9)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"meetExpectations", field['[question(10)]'] )/>
   	<cfset temp = QuerySetCell(SurveyList,"whatways", field['[question(11)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"facilitator", field['[question(12)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"quality", field['[question(13)]'] )/>
    <cfset temp = QuerySetCell(SurveyList,"comments", field['[question(14)]'] )/>
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