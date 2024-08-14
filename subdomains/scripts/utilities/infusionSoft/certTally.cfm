
<style>

div.scroll
{
	background-color:#FFFFFF;
	width:800px;
	height:500px;
	overflow-y:scroll;
	overflow-x: hidden
}
table {
	font: 11px/24px Verdana, Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 800px;
	}

th {
	padding: 0 0.5em;
	text-align: left;
	}

tr.yellow td {
	border-top: 1px solid #FB7A31;
	border-bottom: 1px solid #FB7A31;
	background: #FFC;
	}

td {
	border-bottom: 1px solid #CCC;
	padding: 0 0.5em;
	}

td:first-child {
	width: 150px;
	}

td+td {
	border-left: 1px solid #CCC;
	text-align: left;
	}

h2{
	color:#0080ff;
	border-top:1px dotted #0080ff;
	border-bottom:1px dotted #0080ff;
	padding:3px;
	width:100%
}
</style>

<cfinclude template="cfLib/QueryToCSV.cfc">

<cfif structKeyExists(form,'toEmail')>
	<cfset CrLf = Chr(13) & Chr(1)>
	<cfset l = "#FORM.toEmail#">
    <cfset qGetData = queryNew("")>
    <cfset queryAddColumn(qGetData, "Email", listToArray(l))>

    <cfset csvData = QueryToCSV(qGetData,"Email",0,",") />


    <cfset fPath = expandPath('/') & "userEmails.csv" />

    <cffile action="write" file="#fPath#" output="#csvData#" />
    <cfheader name="Content-Disposition" value="filename=userEmails.csv" />
    <cfcontent file="#fPath#" deletefile="true" type="application/csv" />



</cfif>



<cfscript>
	function listRemoveDupes(inList,delim)
	{
		var listStruct = {};
		var i = 1;

		for(i=1;i<=listlen(inList, delim);i++)
		{
			listStruct[listgetat(inList,i)] = listgetat(inList,i);
		}

		return structkeylist(listStruct);
	}
</cfscript>
<cfparam name="form.tagName" default="">
<form method="post">
	Please choose Class: <br />
	<select name="tagName" onChange="submit()">
    <option value="">--select--</option>
        <option value="2363" <cfif form.tagName is 2363>selected</cfif>>HWCT May 2013</option>
        <option value="2147" <cfif form.tagName is 2147>selected</cfif>>Trainee Coach Training-HWCT Jan 2013</option>
        <option value="2233" <cfif form.tagName is 2233>selected</cfif>>Trainee Coach Training-HWCT Mar 2013</option>
    </select>
</form>


<cfoutput>

<cfset key = "KeapAK-5dc860633b018e8de6df08eefc3f549d521ca66e84411f714e" />
<cfif structKeyExists(form,'tagName') and len(FORM.tagName)>
		<cfset selectedFieldStruct =structNew()>

		<cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["GroupId"]='#FORM.tagName#'><!---tag ID--->

        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "ContactId">


        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='ContactGroupAssign'>
        <cfset myArray[4]='(int)100'>
        <cfset myArray[5]='(int)0'>
        <cfset myArray[6]=selectedFieldStruct>
        <cfset myArray[7]=selectedFieldsArray>

        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">


        <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult3">
            <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>

          <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData3">

		  <table id="myTable" class="tablesorter" style="width:800px">
                <thead>
                	<tr class="yellow">
                        <td>First Name</td>
                        <td>Last Name</td>
                        <td>Email</td>
                        <td>HWCT Feedback Surveys Complete</td>
                        <td>Completed</td>
                        <td>Mark Completed</td>
                    </tr>
                    <tbody>
            		<form method="post">
                        <cfloop array="#theData3.Params[1]#" index="idx">

                            <cfset memberID =  idx['ContactId']>

                            <cfset selectedFieldStruct =structNew()>
                            <cfset selectedFieldStruct["Id"]=memberID>

                            <cfset selectedFieldsArray = ArrayNew(1)>
                            <cfset selectedFieldsArray[1] = "_HWCTFeedbackSurveysComplete3">
                            <cfset selectedFieldsArray[2] = "FirstName">
                            <cfset selectedFieldsArray[3] = "LastName">
                            <cfset selectedFieldsArray[4] = "Email">

                            <cfset myArray = ArrayNew(1)>
                            <cfset myArray[1]="DataService.query">
                            <cfset myArray[2]=key>
                            <cfset myArray[3]='Contact'>
                            <cfset myArray[4]='(int)10'>
                            <cfset myArray[5]='(int)0'>
                            <cfset myArray[6]=selectedFieldStruct>
                            <cfset myArray[7]=selectedFieldsArray>

                            <cfinvoke component="utilities/XML-RPC"
                                method="CFML2XMLRPC"
                                data="#myArray#"
                                returnvariable="myPackage">

                            <cfhttp method="post" url="https://api.infusionsoft.com/crm/xmlrpc/" result="myResult3">
                                <cfhttpparam type="HEADER" name="X-Keap-API-Key" value="#key#"/>
                                <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                            </cfhttp>

                            <cfinvoke component="utilities/XML-RPC"
                                    method="XMLRPC2CFML"
                                    data="#myResult3.Filecontent#"
                                    returnvariable="theData">

                            <cfif structKeyExists(theData.Params[1][1],'_HWCTFeedbackSurveysComplete3')>
                                <cfset  newList = listRemoveDupes(theData.Params[1][1]['_HWCTFeedbackSurveysComplete3'],',') />
                                  <tr>
                                      <td>#theData.Params[1][1]['FirstName']#</td>
                                      <td>#theData.Params[1][1]['LastName']#</td>
                                      <td><a href="mailto:#theData.Params[1][1]['Email']#">#theData.Params[1][1]['Email']#</a></td>
                                      <td>#newList#</td>
                                      <td>#listLen(newList)#</td>
                                      <td><input type="checkbox" name="toEmail" value="#theData.Params[1][1]['Email']#" /></td>
                                  </tr>
                           </cfif>
                       </cfloop>
                       <tr>
                            <td colspan="6" align="right"><input type="submit" value=" Create Email csv " /></td>
                       </tr>

                  </form>
                   </tbody>
                </thead>
           </table>
   	</cfif>
 </cfoutput>

