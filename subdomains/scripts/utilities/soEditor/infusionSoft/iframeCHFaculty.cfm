
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
<cfoutput>
<cfparam name="URL.faculty" default="Erika_Jackson">

 		<cfdirectory directory="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp"
        	action="list"
            filter="*.pdf"
            name="surveyList">
        
        <cfset facultyTable = QueryNew("Lesson, Email, Date", "VarChar, Varchar, Varchar")>
        <cfset rowCount = 0>
        <cfloop query="surveyList">
        	<cfif listLen(name,"_") GT 1>
           		<cfset coachName = "#ListGetAt(name,1,"_")#_#ListGetAt(name,2,"_")#">
            </cfif>
           <cfif coachName EQ URL.faculty>
           		<cfset surveyDate = listLast(URLDecode(name),"_")>
           		<cfset rowCount = rowCount + 1> 
                <cfset link = '<a href="#cgi.SCRIPT_NAME#?surveyList=1&fileName=#URLEncodedFormat(name)#" style="font-family:Arial, Helvetica, sans-serif;size:auto">#ListGetAt(URLDecode(name),3,"_")#</a>'>
                <cfset newRow = QueryAddRow(facultyTable,1)>
           		<cfset temp = QuerySetCell(facultyTable, "Lesson", link, rowCount)>
                <cfset temp = QuerySetCell(facultyTable, "Email",ListGetAt(URLDecode(name),4,"_") , rowCount)>
                <cfset temp = QuerySetCell(facultyTable, "Date",listFirst(surveyDate,".") , rowCount)>
           </cfif>
        </cfloop>
 </cfoutput>       
      
    <cfif  facultyTable.recordcount>
    <p><a href="http://wellcoachesschool.com/utilities/infusionSoft/allSurveyExcel.cfm?coach=<cfoutput>#URL.faculty#</cfoutput>">Export to Excel</a></p>
    <p style="font-family:Arial, Helvetica, sans-serif;font-size:12px">
        Direction on sorting excel document:<br />
        1.	Click the top left corner of the sheet - once all cells are selected they will "turn grey".<br />
        2.	Then right click anywhere in the "greyed out area" and select "Format Cells" - from there select "Alignment Tab".<br />
        3.	Click on "Merge Cells" until the box is empty (e.g. unticked), you may have to tick twice - I did - as the program knew that some cells had been merged and others hand not!<br />
        4.	Finally click on "OK" and then perform your data sort as normal.
	</p>
    
       <table id="myTable" class="tablesorter" width="750" >
        <thead>
            <tr>
                <th nowrap="nowrap" align="left">Lesson</th>
                <th nowrap="nowrap" align="left">Email</th>
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
			#facultyTable.email[eventcount]#
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
<cfoutput>       
        <cfif isdefined("URL.fileName")>
            <cfheader name="Content-Disposition" value="attachment; filename=#URL.filename#" />
			<cfcontent file="C:\websites\wellcoachesschool.com\utilities\infusionSoft\temp\#URL.filename#" type="application/pdf" reset="true">
        </cfif>

  </cfoutput>
<cfelse>
	No records exist
    
</cfif>  
  
  
