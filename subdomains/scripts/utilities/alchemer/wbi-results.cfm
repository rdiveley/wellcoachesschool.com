<cfscript>
    param name="local.response" default="";
    local.dsn = 'wellcoachesschool';
    legend={"background-color":"transparent,white","margin-top":"80","position":"relative","margin-left":"50px"};
</cfscript>

<cfset local.email = url.email />
<cfquery name="local.getWBA" datasource="#local.dsn#">
    SELECT wba.json, wba.submitted
        FROM wba
        JOIN (
            SELECT MAX(submitted) AS max_submitted
            FROM wba
            WHERE email = <cfqueryparam value="#local.email#" cfsqltype="CF_SQL_NVARCHAR">
            GROUP BY convert(date,submitted)
        ) AS latest_submissions
        ON wba.submitted = latest_submissions.max_submitted
        where email = <cfqueryparam value="#local.email#" cfsqltype="CF_SQL_NVARCHAR">
        ORDER BY wba.submitted ASC;

</cfquery> 

<cfset local.results = {} />
<cfloop query="local.getWBA">
    <cfset local.results[currentrow] = deserializeJSON(local.getWBA.json).survey_data />
    <cfset local.submitted[currentrow] = DateFormat(local.getWBA.submitted,'mm/dd/yyyy') />
</cfloop>


<cfoutput>
<cfloop from="1" to="#structCount(local.results)#" index="local.count">

    <cfset myquery[local.count] = queryNew("id,question,answer,section_id", "integer,varchar,integer,integer") />

    <cfloop collection="#local.results[local.count]#" item="local.item">

        <cfset local.questionNumber = local.item />
        <cfset local.question = local.results[local.count][local.item]['question'] />
        <cfset local.section_Id = local.results[local.count][local.item]['section_Id'] />

        <cfif structKeyExists(local.results[local.count][local.item], 'answer') and isNumeric(local.results[local.count][local.item]['answer'])>
            <cfset local.answer = local.results[local.count][local.item]['answer'] />
        <cfelse>
            <cfset local.answer = 0  />
        </cfif>
        
        <cfscript>
            queryAddRow(myquery[local.count]);
            querySetCell(myquery[local.count], "id", local.questionNumber);
            querySetCell(myquery[local.count], "question", local.question);
            querySetCell(myquery[local.count], "answer", local.answer);
            querySetCell(myquery[local.count], "section_id", local.section_Id);
           
        </cfscript>

    </cfloop>
    
</cfloop>

  <!--- Section_id:
            1 = mind
            3 = body
            4 = work
            5 = life --->

<cfloop from="1" to="#structCount(local.results)#" index="local.count">
    <cfset qoq = myquery[local.count] />
    <cfquery name="getMind_#local.count#" dbtype="query">
       select * 
       from qoq
       where section_id = 1 
       and id not in (72,85,87,88,89,90)
       order by question desc
    </cfquery>

    <cfquery name="getBody_#local.count#" dbtype="query">
       select * 
       from qoq
       where section_id = 3 
       and id not in (72,85,87,88,89,90)
       order by question desc
    </cfquery>
    <cfquery name="getWork_#local.count#" dbtype="query">
       select * 
       from qoq
       where section_id = 4 
       and id not in (72,85,87,88,89,90)
       order by question desc
    </cfquery>
    <cfquery name="getLife_#local.count#" dbtype="query">
       select * 
       from qoq
       where section_id = 5 
       and id not in (72,85,87,88,89,90)
       order by question desc
    </cfquery>

    <cfset local.qoqGetMind = evaluate('getMind_#local.count#') />
    <cfset local.qoqGetBody = evaluate('getBody_#local.count#') />
    <cfset local.qoqGetWork = evaluate('getWork_#local.count#') />
    <cfset local.qoqGetLife = evaluate('getLife_#local.count#') />

    <cfscript>
        local.mind[local.count] = {};
        local.body[local.count] = {};
        local.work[local.count] = {};
        local.life[local.count] = {};

        cfloop(query=local.qoqGetMind){
            local.mind[local.count][id] = evaluate('getMind_#local.count#.answer');
        }
        cfloop(query=local.qoqGetBody){
            local.body[local.count][id] = evaluate('getBody_#local.count#.answer');
        }
        cfloop(query=local.qoqGetWork){
            local.work[local.count][id] = evaluate('getWork_#local.count#.answer');
        }
        cfloop(query=local.qoqGetLife){
            local.life[local.count][id] = evaluate('getLife_#local.count#.answer');
        }
    </cfscript>

</cfloop>

<cfif !isDefined('getMind_1')>
    There are no records. <cfabort />
</cfif>
<!--- focusing on perhaps the top 5 areas of the greatest change in each of the four categories --->

    <cfset qoq_mind = queryNew("id,question,total", "varchar,varchar,integer") />
    <cfloop query="getMind_1">
        <cfset local.question = evaluate('getMind_1.question') />
        <cfset local.answers = "" />
        <cfloop from="1" to="#structCount(local.results)#" index="local.count">
                <cfif structKeyExists(local.mind[local.count],'#getMind_1.id#')>
                    <cfset local.answers = listAppend(local.answers, local.mind[local.count][getMind_1.id]) />
                    <cfset local.min = arrayMin(listToArray(local.answers)) />
                    <cfset local.max = arrayMax(listToArray(local.answers)) />
                    <cfset local.total = local.max - local.min />
                </cfif>
        </cfloop>
        <cfscript>
            queryAddRow(qoq_mind);
            querySetCell(qoq_mind, "id", createUUID());
            querySetCell(qoq_mind, "question", local.question);
            querySetCell(qoq_mind, "total", local.total);
        </cfscript>
    </cfloop>
    
    <cfquery name="getMindTop5" dbtype="query" maxrows="5">
       select *
       from qoq_mind
       order by total desc
    </cfquery>

    <cfset local.mindTop5 = valueList(getMindTop5.question,"|") />
    <cfset local.mindTop5 = REReplaceNoCase(local.mindTop5, "<[^[:space:]][^>]*>", "", "ALL") />
    
  
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Mind areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getMind_1">
            <cfif listFindNoCase(local.mindTop5, evaluate('getMind_1.question'),"|")>
                <cfchartseries type="curve" serieslabel="#evaluate('getMind_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata  item="#local.submitted[local.count2]#" value="#local.mind[local.count2][getMind_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Mind areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getMind_1">
            <cfif listFindNoCase(local.mindTop5, evaluate('getMind_1.question'),"|")>
                <cfchartseries type="line" serieslabel="#evaluate('getMind_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata  item="#local.submitted[local.count2]#" value="#local.mind[local.count2][getMind_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Mind areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getMind_1">
            <cfif listFindNoCase(local.mindTop5, evaluate('getMind_1.question'),"|")>
                <cfchartseries type="cylinder" serieslabel="#evaluate('getMind_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata  item="#local.submitted[local.count2]#" value="#local.mind[local.count2][getMind_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Mind areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getMind_1">
            <cfif listFindNoCase(local.mindTop5, evaluate('getMind_1.question'),"|")>
                <cfchartseries type="bar" serieslabel="#evaluate('getMind_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata  item="#local.submitted[local.count2]#" value="#local.mind[local.count2][getMind_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
    <cfabort />
    <br />
    <!--- Start Body Section --->
    <cfset qoq_body = queryNew("id,question,total", "varchar,varchar,integer") />
    <cfloop query="getBody_1">
        <cfset local.question = evaluate('getBody_1.question') />
        <cfset local.answers = "" />
        <cfloop from="1" to="#structCount(local.results)#" index="local.count">
            <cfif structKeyExists(local.body[local.count],'#getBody_1.id#')>
                <cfset local.answers = listAppend(local.answers, local.body[local.count][getBody_1.id]) />
                <cfset local.min = arrayMin(listToArray(local.answers)) />
                <cfset local.max = arrayMax(listToArray(local.answers)) />
                <cfset local.total = local.max - local.min />
            </cfif>
        </cfloop>
        <cfscript>
            queryAddRow(qoq_body);
            querySetCell(qoq_body, "id", createUUID());
            querySetCell(qoq_body, "question", local.question);
            querySetCell(qoq_body, "total", local.total);
        </cfscript>
    </cfloop>

     <cfquery name="getBodyTop5" dbtype="query" maxrows="5">
       select *
       from qoq_body
       order by total desc
    </cfquery>

    <cfset local.bodyTop5 = valueList(getBodyTop5.question,"|") />
    <cfset local.bodyTop5 = REReplaceNoCase(local.bodyTop5, "<[^[:space:]][^>]*>", "", "ALL") />
    
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Body areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getBody_1">
            <cfif listFindNoCase(local.bodyTop5, evaluate('getBody_1.question'),"|")>
                <cfchartseries type="curve" serieslabel="#evaluate('getBody_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata item="#local.submitted[local.count2]#" value="#local.body[local.count2][getBody_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>

    <br />
    <!--- Start Work Section --->
    <cfset qoq_work = queryNew("id,question,total", "varchar,varchar,integer") />
    <cfloop query="getWork_1">
        <cfset local.question = evaluate('getWork_1.question') />
        <cfset local.answers = "" />
        <cfloop from="1" to="#structCount(local.results)#" index="local.count">
            <cfif structKeyExists(local.work[local.count],'#getWork_1.id#')>
                <cfset local.answers = listAppend(local.answers, local.work[local.count][getWork_1.id]) />
                <cfset local.min = arrayMin(listToArray(local.answers)) />
                <cfset local.max = arrayMax(listToArray(local.answers)) />
                <cfset local.total = local.max - local.min />
            </cfif>
        </cfloop>
        <cfscript>
            queryAddRow(qoq_work);
            querySetCell(qoq_work, "id", createUUID());
            querySetCell(qoq_work, "question", local.question);
            querySetCell(qoq_work, "total", local.total);
        </cfscript>
    </cfloop>

     <cfquery name="getWorkTop5" dbtype="query" maxrows="5">
       select *
       from qoq_Work
       order by total desc
    </cfquery>

    <cfset local.WorkTop5 = valueList(getWorkTop5.question,"|") />
    <cfset local.WorkTop5 = REReplaceNoCase(local.WorkTop5, "<[^[:space:]][^>]*>", "", "ALL") />
    
    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Work areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getWork_1">
            <cfif listFindNoCase(local.workTop5, evaluate('getWork_1.question'),"|")>
                <cfchartseries type="curve" serieslabel="#evaluate('getWork_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfchartdata item="#local.submitted[local.count2]#" value="#local.work[local.count2][getWork_1.id]#"/>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
    <br />
    <!--- Start Life Section --->
 
    <cfset qoq_life = queryNew("id,question,total", "varchar,varchar,integer") />
    <cfloop query="getLife_1">
        <cfset local.question = evaluate('getLife_1.question') />
        <cfset local.answers = "" />
        <cfloop from="1" to="#structCount(local.results)#" index="local.count">
            <cfif structKeyExists(local.Life[local.count],'#getLife_1.id#')>
                <cfset local.answers = listAppend(local.answers, local.Life[local.count][getLife_1.id]) />
                <cfset local.min = arrayMin(listToArray(local.answers)) />
                <cfset local.max = arrayMax(listToArray(local.answers)) />
                <cfset local.total = local.max - local.min />
            </cfif>
        </cfloop>
        <cfscript>
            queryAddRow(qoq_life);
            querySetCell(qoq_life, "id", createUUID());
            querySetCell(qoq_life, "question", local.question);
            querySetCell(qoq_life, "total", local.total);
        </cfscript>
    </cfloop>

     <cfquery name="getLifeTop5" dbtype="query" maxrows="5">
       select *
       from qoq_life
       order by total desc
    </cfquery>

    <cfset local.LifeTop5 = valueList(getLifeTop5.question,"|") />
    <cfset local.LifeTop5 = REReplaceNoCase(local.LifeTop5, "<[^[:space:]][^>]*>", "", "ALL") />


    <cfchart format="html" 
        xaxistitle="Date"
        yaxistitle="Score"
        style="wbi.json"
        title="Top 5 Life areas of the greatest change" 
        chartHeight="500" 
        chartWidth="1500" 
        showLegend="yes" 
        scalefrom="0"
        scaleto="11"
        seriesplacement="default"
        legend="#legend#">
        <cfloop query="getLife_1">
            <cfif listFindNoCase(local.LifeTop5, evaluate('getLife_1.question'),"|")>
                <cfchartseries type="curve" serieslabel="#evaluate('getLife_1.question')#" markerstyle="circle" >
                    <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                        <cfif arrayLen(structFindKey(local.Life[local.count2],getLife_1.id))>
                        <cfchartdata item="#local.submitted[local.count2]#" value="#local.Life[local.count2][getLife_1.id]#"/>
                        </cfif>
                    </cfloop>
                </cfchartseries>
            </cfif>
        </cfloop>
    </cfchart>
</cfoutput>