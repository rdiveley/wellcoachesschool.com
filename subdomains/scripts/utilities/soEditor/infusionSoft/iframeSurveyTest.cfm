<link rel="stylesheet" type="text/css" href="js/themes/blue/style.css">
<link rel="stylesheet" type="text/css" href="js/addons/pager/jquery.tablesorter.pager.css">
<script type="text/javascript" src="js/jquery-latest.js"></script> 
<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
<script type="text/javascript" src="js/addons/pager/jquery.tablesorter.pager.js"></script>
<script>
$(document).ready(function() 
    { 
    $("table") 
    .tablesorter({widthFixed: true, widgets: ['zebra']}) 
    .tablesorterPager({container: $("#pager")}); 
    } 
); 
</script>

<cfparam name="URL.email" default="erika@wellcoaches.com">
<cfparam name="admins" default="0">
<cfparam name="FORM.email" default="">

	<cfif URL.email EQ "Erika@wellcoaches.com" OR FORM.email EQ "Erika@wellcoaches.com">
    	<cfset admins = 1>
    </cfif>
 
<cfif NOT isDefined("URL.surveyList")>
    <cfif admins>
    	<cfoutput> <form action="#cgi.SCRIPT_NAME#" method="post"></cfoutput>
        <input type="hidden" name="email" value="#URL.email#" />
        <p>
        	Survey Name:<br />
        	<input type="text" name="surveyName" />
        </p>
        <p>
            Survey Link:<br />
            <input type="text" name="SurveyLink" />
        </p>   
            <input type="submit" name="submit" value="Create Survey Link" />
        </form>
       
    	<cfif isdefined("FORM.submit") AND len(FORM.surveyLink) NEQ 0>
            <cfquery name="insertSurvey" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
           		INSERT INTO Surveys
                (
                 SurveyLink
                 ,SurveyName
                 ,createDate
                 )
                VALUES
                (
                  <cfqueryparam value="#FORM.surveyLink#" cfsqltype="cf_sql_varchar" />
                 ,<cfqueryparam value="#FORM.surveyName#" cfsqltype="cf_sql_varchar" />
                 ,#CreateODBCDate(now())#
                 )
            </cfquery>
        </cfif>
        <cfif isDefined("URL.delete")>
            <cfquery name="insertSurvey" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
                    DELETE FROM  Surveys
                    WHERE id = <cfqueryparam value="#URL.delete#" cfsqltype="cf_sql_varchar" />
                </cfquery>
            </cfif>
        
    </cfif>
   
    
    <cfquery name="getSurveys"  datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
           SELECT * FROM Surveys
    </cfquery>
    
     	<cfif getSurveys.recordcount>
         <cfloop query="getSurveys">
           <cfoutput> <a href="#surveyLink#?email=#url.email#">#SurveyName#</a> <cfif admins><a href="#cgi.SCRIPT_NAME#?delete=#id#&email=#URL.email#">Delete</a></cfif><br /></cfoutput>
         </cfloop>
        </cfif> 
 <cfelse>
 		<cfdirectory directory="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp"
        	action="list"
            filter="*.pdf"
            name="surveyList">
         
        <cfset facultyTable = QueryNew("Lesson,  Date", "VarChar, Varchar")>
        <cfset rowCount = 0>
        <cfoutput>
        <cfloop query="surveyList">
        	<cfif ListGetAt(URLDecode(name),1,"_") EQ URL.email>
				<cfset rowCount = rowCount + 1> 
                <cfset surveyDate = ListGetAt(URLDecode(name),3,"_")>
                <cfset surveyDate = ListFirst(surveyDate,".")>
                <cfset link = '<a href="#cgi.SCRIPT_NAME#?surveyList=1&fileName=#URLEncodedFormat(name)#" style="font-family:Arial, Helvetica, sans-serif;size:auto">#ListGetAt(URLDecode(name),2,"_")#</a>'>
            	<cfset newRow = QueryAddRow(facultyTable,1)>
				<cfset temp = QuerySetCell(facultyTable, "Lesson", link, rowCount)>
                <cfset temp = QuerySetCell(facultyTable, "Date",surveyDate , rowCount)>
        		
            </cfif>
        </cfloop>
        </cfoutput>
      <cfif  facultyTable.recordcount>
       <table id="myTable" class="tablesorter" width="750" >
        <thead>
            <tr>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left">Date</th>
            </tr>
        </thead>
        <tbody>
	<cfset eventcount=0 >   
	<cfoutput query="facultyTable">
	<cfset eventcount = eventcount + 1 >
	<tr>
		<td valign="top">
			#facultyTable.lesson[eventcount]#
		</td>
		<td valign="top">
			#facultyTable.date[eventcount]#
		</td>
		
	</tr>
 </cfoutput>
</tbody>
</table>

<div id="pager" class="pager">
	<form>
		<img src="js/addons/pager/icons/first.png" class="first"/>
		<img src="js/addons/pager/icons/prev.png" class="prev"/>
		<input type="text" class="pagedisplay"/>
		<img src="js/addons/pager/icons/next.png" class="next"/>
		<img src="js/addons/pager/icons/last.png" class="last"/>
		<select class="pagesize">
			<option selected="selected"  value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option  value="40">40</option>
		</select>
	</form>
</div>
      
        <cfif isdefined("URL.fileName")>
            <cfheader name="Content-Disposition" value="attachment; filename=#URL.filename#" />
			<cfcontent file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#URL.filename#" type="application/pdf" reset="true">
        </cfif>

<cfelse>
	No records exist
</cfif> 

        <cfif isdefined("URL.fileName")>
            <cfheader name="Content-Disposition" value="attachment; filename=#URL.filename#" />
			<cfcontent file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#URL.filename#" type="application/pdf" reset="true">
        </cfif>
 </cfif> 
