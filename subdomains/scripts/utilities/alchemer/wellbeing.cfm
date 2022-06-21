<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<cfscript>
    param name="local.response" default="";
    local.dsn = 'wellcoachesschool';
</cfscript>

<cfif structKeyExists(url, 'email')>

    <cfset local.email = url.email />
    <cfquery name="local.getWBA" datasource="#local.dsn#">
        select top 1 json 
        from wba
        where email = <cfqueryparam value="#local.email#" cfsqltype="CF_SQL_NVARCHAR">
        order by submitted desc
    </cfquery> 

    <cfset local.results = deserializeJSON(local.getWBA.json).survey_data />
    
<cfelse>

    <cfscript>
        local.requestBody = urlDecode(toString( getHttpRequestData().content ));
        local.requestBody = listLast(local.requestBody,'=');
        local.info = deserializeJSON(local.requestBody);
        local.email = local.info["survey_data"]["72"]["answer"];
    </cfscript>

    <cftransaction>
        <cfquery name="wba"  datasource="#local.dsn#">
            insert into wba 
            (
                email
                ,json
                ,submitted
                )
            values
            (
                <cfqueryparam value="#trim(local.email)#" cfsqltype="CF_SQL_NVARCHAR">
                ,<cfqueryparam value="#local.requestBody#" cfsqltype="CF_SQL_LONGNVARCHAR">
                ,<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
            )
        </cfquery>

         <cfset local.results = deserializeJSON(local.requestBody).survey_data />
        
    </cftransaction>

</cfif>

<cfset local.high = {} />
<cfset local.medium = {} />
<cfset local.low = {} />
<cfset local.average = {} />

<cfoutput>
    <cfset myquery = queryNew("id,question,answer", "integer,varchar,integer") />
    <cfloop collection="#local.results#" item="local.item">
        <cfset local.questionNumber = local.item />
        <cfset local.question = local.results[local.item]['question'] />
    
        <cfif structKeyExists(local.results[local.item], 'answer') and isNumeric(local.results[local.item]['answer'])>
            <cfset local.answer = local.results[local.item]['answer'] />
        <cfelse>
            <cfset local.answer = 0  />
        </cfif>
        
        <cfscript>
            queryAddRow(myquery);
            querySetCell(myquery, "id", local.questionNumber);
            querySetCell(myquery, "question", local.question);
            querySetCell(myquery, "answer", local.answer);
        </cfscript>
        
    </cfloop>

   <cfquery name="getHigh" dbtype="query">
       select * 
       from myquery
       where answer >= 7 and id not in (72,85,87,88,89,90)
       order by answer desc
   </cfquery>


    <cfquery name="getMedium" dbtype="query">
       select * 
       from myquery
       where answer >= 4 AND answer <=6 and id not in (72,85,87,88,89,90)
       order by answer desc
   </cfquery>
    <cfquery name="getLow" dbtype="query">
       select * 
       from myquery
       where answer >=1 and answer <=3 and id not in (72,85,87,88,89,90)
       order by answer desc
   </cfquery>


   <cfquery name="getAverage" dbtype="query">
       select * 
       from myquery
       where id in (85,87,88,89,90)
       order by id asc
   </cfquery>

    <cfset filePath = GetTempDirectory() & "#local.email#.pdf">

    <cfhtmltopdf destination="#filePath#" orientation="portrait"  pagetype="A4" margintop="1" marginbottom="1"  overwrite="yes">
        <cfif getHigh.recordcount>
            <table border="1" width="1000px">
                <thead >
                    <tr style="background-color:black;color:white">
                        <th colspan="2" scope="col" style="text-align:center">High</th>
                    </tr>
                    <tr>
                        <th scope="col">Question</th>
                        <th scope="col" style="text-align:center">Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <cfset local.count = 0 />
                    <cfloop query="getHigh">
                        <cfset local.count ++ />
                        <tr style="#iif(local.count MOD 2,DE('background-color:lightGrey'),DE('background-colr:EEEE'))#">
                            <td>#getHigh.question#</td>
                            <td style="text-align:center">#getHigh.answer#</td>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
            <cfhtmltopdfitem  type="pagebreak" />
        </cfif>
        <cfif getMedium.recordcount>
            <table border="1" width="1000px">
                <thead >
                    <tr style="background-color:black;color:white">
                        <th colspan="2" scope="col" style="text-align:center">Medium</th>
                    </tr>
                    <tr>
                        <th scope="col">Question</th>
                        <th scope="col">Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <cfset local.count = 0 />
                    <cfloop query="getMedium">
                        <cfset local.count ++ />
                        <tr style="#iif(local.count MOD 2,DE('background-color:lightGrey'),DE('background-colr:EEEE'))#">
                            <td>#getMedium.question#</td>
                            <td style="text-align:center">#getMedium.answer#</td>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
            <cfhtmltopdfitem  type="pagebreak" />
        </cfif>
        <cfif getLow.recordcount>
            <table border="1" width="1000px">
                <thead >
                    <tr style="background-color:black;color:white">
                        <th colspan="2" scope="col" style="text-align:center">Low</th>
                    </tr>
                    <tr>
                        <th scope="col">Question</th>
                        <th scope="col">Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <cfset local.count = 0 />
                    <cfloop query="getLow">
                        <cfset local.count ++ />
                        <tr style="#iif(local.count MOD 2,DE('background-color:lightGrey'),DE('background-colr:EEEE'))#">
                            <td>#getLow.question#</td>
                            <td style="text-align:center">#getLow.answer#</td>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
            <cfhtmltopdfitem  type="pagebreak" />
        </cfif>
        <cfif getAverage.recordcount>
            <table border="1" width="1000px">
                <thead >
                    <tr style="background-color:black;color:white">
                        <th colspan="2" scope="col" style="text-align:center">Average</th>
                    </tr>
                    <tr>
                        <th scope="col">Average</th>
                        <th scope="col">Result</th>
                    </tr>
                </thead>
                <tbody>
                    <cfset local.count = 0 />
                    <cfloop query="getAverage">
                        <cfset local.count ++ />
                        <tr style="#iif(local.count MOD 2,DE('background-color:lightGrey'),DE('background-colr:EEEE'))#">
                            <td>#getAverage.question#</td>
                            <td style="text-align:center">#getAverage.answer#</td>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
            <cfhtmltopdfitem  type="pagebreak" />
        </cfif>
       
        <cfhtmltopdfitem type="header">
            Page: _PAGENUMBER of _LASTPAGENUMBER
        </cfhtmltopdfitem>    
    </cfhtmltopdf>

    <cfmail to="#local.email#" bcc="rdiveley@wellcoaches.com" subject="Well-being Self-Assessment Results" from="wellcoaches@wellcoaches.com" >
        <cfmailparam file="#filePath#" disposition="attachment" type="#fileGetMimeType(filePath)#" remove="true">
        <cfmailpart type="html">Your Well-being Self-Assessment results are attached.  </cfmailpart>
    </cfmail>

</cfoutput>
