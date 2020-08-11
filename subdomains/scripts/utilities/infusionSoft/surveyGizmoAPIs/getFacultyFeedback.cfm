<link rel="stylesheet" type="text/css" href="../js/themes/blue/style.css">
<link rel="stylesheet" type="text/css" href="../js/addons/pager/jquery.tablesorter.pager.css">
<script type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.qtip-1.0.0-rc3.min.js"></script>

<script type="text/javascript" src="../js/jquery.tablesorter.js"></script>
<script type="text/javascript" src="../js/addons/pager/jquery.tablesorter.pager.js"></script>
<style>
.ui-tooltip, .qtip{
	position: absolute;
	left: -28000px;
	top: -28000px;
	display: none;

	max-width: 580px;
	min-width: 50px;

	font-size: 12.5px;
	line-height: 15px;
}
</style>
<script>
$(document).ready(function() {

    $("#myTable")
    .tablesorter({widthFixed: true, widgets: ['zebra']})

 	$('#content a[href][title]').qtip({

      content: {
         text: false // Use each elements title attribute
      },
      style: 'cream' // Give it some style
   });

 });

</script>





<cfset user = 'erika@wellcoaches.com' />
<cfset password= 'Well5050' />

<cfparam name="url.coachName" default="Pam Schmid" />
<cfparam name="URL.PageIndex" default="0">
<cfparam name="PageIndex" default="0">
<cfset coachName = '#listFirst(url.coachName,"_")# #listLast(url.coachName,"_")#' />


<cfoutput>
  <cfset columnList = "datesubmitted,id,lesson,surveyTitle,email,coaching_skills,facultyName,faculty_expertise,lesson_relevance,q5,q6,q7" />

  <cfset SurveyList = QueryNew("#columnList#","#REReplace(RepeatString('varchar,',listLen(columnList)), ",+$", "")#") />
  <cfparam name="form.survey" default="0" />
  <cfparam name="form.year_filter" default="#year(now())#" />


  <cfif month(now()) LT 10 >
  	<cfset theMonth = '0#month(now())#' />
  <cfelse>
  	<cfset theMonth = month(now()) />
  </cfif>

  <cfparam name="form.month_filter" default="#theMonth#" />

  <cfif structKeyExists(url,'month_filter')>
  	<cfset form.month_filter = url.month_filter />
  </cfif>

  <cfif structKeyExists(url,'year_filter')>
  	<cfset form.year_filter = url.year_filter />
  </cfif>


  <cfif structKeyExists(url,'survey')>
  	<cfset form.survey = url.survey />
  </cfif>


<form action="#cgi.SCRIPT_NAME#?coachName=#url.coachName#"  method="post">

  <select name="survey">
    <option value="0">--Please Select Feedback Survey --</option>
    <option value="4238384" <cfif form.survey EQ "4238384">Selected</cfif>>Module 2 courses</option>
    <option value="5121979" <cfif form.survey EQ "5121979">Selected</cfif>>Professional Coach Training Program (10-month) - Naples 2020</option>
    <option value="4543424" <cfif form.survey EQ "4543424">Selected</cfif>>Professional Coach Training Program (10-month) - LaJolla 2019</option>
    <option value="3839954" <cfif form.survey EQ "3839954">Selected</cfif>>Professional Coach Training Program (10-month) - Indianapolis Sept 2017 - May 2018</option>
 	  <option value="2913540" <cfif form.survey EQ "2913540">Selected</cfif>>Professional Coach Training Program (10-month) - LaJolla Sept 2016 - May 2017</option>
    <option value="2338773" <cfif form.survey EQ "2338773">Selected</cfif>>Professional Coach Training Program (10-month) - Minnesota Sept 2015 - June 2016</option>
    <option value="1849174" <cfif form.survey EQ "1849174">Selected</cfif>>Professional Coach Training Program (10-month) - Sept 2014 through June 2015</option>
    <option value="1330743" <cfif form.survey EQ "1330743">Selected</cfif>>Professional Coach Training Program (10-month) - Sept 2013 through June 2014</option>
    <option value="1060665" <cfif form.survey EQ "1060665">Selected</cfif>>Professional Coach Training Program (10-month) - October 2012 - June 2013</option>
  	<option value="1020531" <cfif form.survey EQ "1020531">Selected</cfif>>Health and Wellness Coach Training - 2012 through March 2013</option>
    <option value="1120644" <cfif form.survey EQ "1120644">Selected</cfif>>(Auditing Participants) Health and Wellness Coach Training - 2012 through March 2013</option>
    <option value="1013764" <cfif form.survey EQ "1013764">Selected</cfif>>Core Coach Training - 18-week program</option>


  </select>

  <cfset local.monthList = "January,February,March,April,May,June,July,August,September,October,November,December" />
  <select name="month_filter">
  	<cfloop from="1" to="12" index="month">
    	<cfif month LT 10>
        	<cfset month = '0#month#' />
       	</cfif>
    	<option value="#month#" <cfif isDefined("form.month_filter") AND form.month_filter eq month>selected</cfif> >#listGetAt(local.monthList,month)#</option>
    </cfloop>
  </select>

  <select name="year_filter">
  	 <option value="#year(now())#" <cfif isDefined("form.year_filter") AND form.year_filter eq year(now())>selected</cfif> >#year(now())#</option>
     <option value="#evaluate(year(now())-1)#" <cfif isDefined("form.year_filter") AND form.year_filter eq evaluate(year(now())-1)>selected</cfif> >#evaluate(year(now())-1)#</option>
 	 <option value="#evaluate(year(now())-2)#" <cfif isDefined("form.year_filter") AND form.year_filter eq evaluate(year(now())-2)>selected</cfif> >#evaluate(year(now())-2)#</option>

  </select>
  <button name="Go" value="Go" onclick="this.form.submit()" />Go</button>


<cfif structKeyExists(form, 'survey') and form.survey NEQ 0>

		<cfif findNoCase('Martin',coachName)>
        	<cfset coachName = ReplaceNoCase(coachName,'-',' ','all') />
    </cfif>
    
    <cfif structKeyExists(url,coachName)>
      <cfset coachName = url.coachName />
     
    </cfif>
    <cfset coachName = ListRemoveDuplicates(coachName, " ") />

 		

        <cfparam name="questionParam" default="[question(12)]" />

        <cfset currentPage = evaluate(pageIndex + 1) />

        <cfset params = arrayNew(1) />

       
        <cfset arrayappend(params,"filter[field][0]=datesubmitted") />
        <cfset arrayappend(params,"filter[operator][0]=>") />
        <cfset arrayappend(params,"filter[value][0]=#form.year_filter#-#form.month_filter#-01") />

        <cfset arrayappend(params,"filter[field][1]=[question(12)]") />
        <cfset arrayappend(params,"filter[operator][1]==") />
        <cfset arrayappend(params,"filter[value][1]=#coachName#") />

        <cfset arrayappend(params,"filter[field][2]=datesubmitted") />
        <cfset arrayappend(params,"filter[operator][2]=<") />
        <cfset arrayappend(params,"filter[value][2]=#form.year_filter#-#form.month_filter#-31") />
        <cfset arrayappend(params,"resultsperpage=500") />
        <CFSET local.body=ArrayToList(Params, "&")>
       
    <cfset sGurl = "https://restapi.surveygizmo.com/v4/survey/#form.survey#/surveyresponse" />

          
          <cfhttp url="#SGurl#" result="myResult" method="get">
            <cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>

			      <cfhttpparam type="url"  value="datesubmitted" name="filter[field][0]"/>
            <cfhttpparam type="url"  value=">" name="filter[operator][0]"/>
            <cfhttpparam type="url"  value="#form.year_filter#-#form.month_filter#-01" name="filter[value][0]"/>
            
            <cfhttpparam type="url"  value="[question(12)]" name="filter[field][1]"/>
            <cfhttpparam type="url"  value="=" name="filter[operator][1]"/>
            <cfhttpparam type="url"  value="#coachName#" name="filter[value][1]"/>
            
            <cfhttpparam type="url"  value="datesubmitted" name="filter[field][2]"/>
            <cfhttpparam type="url"  value="<" name="filter[operator][2]"/>
            <cfhttpparam type="url"  value="#form.year_filter#-#form.month_filter#-31" name="filter[value][2]"/>
            <cfhttpparam type="url"  value="500" name="resultsperpage"/>
			 
           
          </cfhttp>


      <cfset jsonData = deserializeJSON(myResult.fileContent) />


	 <cfif structKeyExists(jsonData,'data') and NOT arrayIsEmpty(jsondata.data)>

        <cfloop array="#jsonData.data#" index="field">
          <cfset queryAddRow(SurveyList)>

       
            <cfparam name="field['survey_data'][9]['answer']" default="" />
            <cfparam name="field['survey_data'][8]['answer']" default="" />
            <cfparam name="field['survey_data'][2]['answer']" default="" />
            <cfparam name="field['survey_data'][3]['answer']" default="" />
            <cfparam name="field['survey_data'][4]['answer']" default="" />
            <cfparam name="field['survey_data'][5]['answer']" default="" />
            <cfparam name="field['survey_data'][6]['answer']" default="" />
            <cfparam name="field['survey_data'][7]['answer']" default="" />
            <cfparam name="field['question(8)']" default="" />

            <cfset temp = QuerySetCell(SurveyList,"dateSubmitted", field['datesubmitted'] )/>
            <cfset temp = QuerySetCell(SurveyList,"Id", field['id'] )/>
            <cfset temp = QuerySetCell(SurveyList,"lesson", field['[question(8)]'] )/>
            <cfset temp = QuerySetCell(SurveyList,"email", field['[question(9)]'])/>
            <cfset temp = QuerySetCell(SurveyList,"coaching_skills", field['[question(2)]'] )/>
            <cfset temp = QuerySetCell(SurveyList,"faculty_expertise",field['[question(3)]'])/>
            <cfif structKeyExists(field,'[question(4)]')>
              <cfset temp = QuerySetCell(SurveyList,"lesson_relevance", field['[question(4)]'] )/>
            </cfif>
            <cfif structKeyExists(field,'[question(5)]')>
              <cfset temp = QuerySetCell(SurveyList,"q5",field['[question(5)]'])/>
            </cfif>
            <cfset temp = QuerySetCell(SurveyList,"q6",field['[question(6)]'])/> 
            <cfset temp = QuerySetCell(SurveyList,"q7",field['[question(7)]'])/>
          </cfloop>
      </cfif>


    <cfquery name="DataSet" dbtype="query">
      select * from SurveyList
      order by datesubmitted desc
    </cfquery>

    <cfset RecordsPerPage = 500>
	<cfset TotalPages = (DataSet.Recordcount/RecordsPerPage)-1>
    <cfset StartRow = (URL.PageIndex*RecordsPerPage)+1>
    <cfset EndRow = StartRow+RecordsPerPage-1>


	<cfif DataSet.recordcount><div id="content" class="default">

    <table id="myTable" class="tablesorter" width="80%" >
        <thead>
            <tr>
            	<th nowrap="nowrap" align="left">##</th>
                <th nowrap="nowrap" align="left">Skills</th>
                <th nowrap="nowrap" align="left">Lessons</th>
                <th nowrap="nowrap" align="left">Aware</th>
            	  <th nowrap="nowrap" align="left">Email</th>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left">Coaching</th>
                <th nowrap="nowrap" align="left">Expertise</th>
                <!---<th nowrap="nowrap" align="left">Relevance</th>--->
                <th nowrap="nowrap" align="left">Date</th>
            </tr>
        </thead>
        <tbody>

         <cfset total = 0>
    	 <cfloop query="DataSet">
         	<cfif CurrentRow gte StartRow >
                <tr>
                	<td>#currentrow#</td>
                    <td><div id="content"><a title="#q5#" href="facultyFeedbackDetails.cfm?surveyTitle=#form.survey#&id=#ID#">Skills</a></div></td>
                    <td><div id="content"><a title="#q6#" href="facultyFeedbackDetails.cfm?surveyTitle=#form.survey#&id=#ID#">Learned</a></div></td>
                    <td><div id="content"><a title="#q7#" href="facultyFeedbackDetails.cfm?surveyTitle=#form.survey#&id=#ID#">Aware</a></div></td>
                	<td>#email#</td>
                	<td>#lesson#</td>
                    <td>#coaching_skills#</td>
                    <td>#faculty_expertise#</td>
                    <!---<td>#lesson_relevance#</td> --->
                	<td>#datesubmitted#</td> 

            	</tr>
            </cfif>

         </cfloop>
         <tr>
      <td colspan="10">
      <cfloop index="Pages" from="0" to="#TotalPages#">
      <cfoutput>
         |
         <cfset DisplayPgNo = Pages+1>
         <cfif URL.PageIndex eq pages>
            <strong>#DisplayPgNo#</strong>
         <cfelse>
            <a href="?PageIndex=#Pages#&coachName=#url.coachname#&survey=#form.survey#&month_filter=#form.month_filter#&year_filter=#form.year_filter#">#DisplayPgNo#</a>
         </cfif>
         |
      </cfoutput>
      </cfloop>
      </td>
   </tr>
   </tbody>
</table>
<cfelse>
	<br />
	No Records Exist
</cfif>


</form>
</cfif>
</cfoutput>