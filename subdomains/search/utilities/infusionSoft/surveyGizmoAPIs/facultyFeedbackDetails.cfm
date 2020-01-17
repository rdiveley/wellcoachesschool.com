<cfparam name="form.surveyTitle" default="0" />
<cfparam name="form.id" default="0" />

<link rel="stylesheet" type="text/css" href="../js/themes/blue/style.css">
<link rel="stylesheet" type="text/css" href="../js/addons/pager/jquery.tablesorter.pager.css">
<script type="text/javascript" src="../js/jquery-latest.js"></script>
<script type="text/javascript" src="../js/jquery.tablesorter.js"></script>
<script type="text/javascript" src="../js/addons/pager/jquery.tablesorter.pager.js"></script>
<cfoutput>

<cfset SGurl = "https://restapi.surveygizmo.com/head/survey/#url.surveyTitle#/surveyresponse/#url.id#">

<cfhttp url="#sGurl#" result="myResult" method="get">
		<cfhttpparam type="url"  value="b372e5a8eef26991d36bbebb354d285defb60f913b0f645aca" name="api_token"/>
 </cfhttp>

  <cfset jsonData = deserializeJSON(myResult.fileContent) />


	<cfset q1 = jsonData.data['[question(5)]'] />
    <cfset q2 = jsonData.data['[question(6)]'] />
    <cfset q3 = jsonData.data['[question(7)]'] />

    <button onClick="history.go(-1)">Back </button>
  	<table id="myTable" class="tablesorter" width="100%" >
         <thead>
        	<tr>
            	<td>What are the most valuable skills and behaviors demonstrated by the faculty member? *</td>
            </tr>
         </thead>
            <tr><td>#q1#</td></tr>
        <thead>
            <tr>
            	<td>Please summarize the two most valuable elements learned from this lesson and how you will apply them to your coaching practice or other coaching activities. </td>
           </tr>
        </thead>
           <tr>
                <td>#q2#</td>
            </tr>
             <thead>
            <tr>
                <td>What else would you like for us to be aware of? </td>
            </tr>
            </thead>
           <tr>
                <td>#q3#</td>
            </tr>

        </table>
 </cfoutput>


