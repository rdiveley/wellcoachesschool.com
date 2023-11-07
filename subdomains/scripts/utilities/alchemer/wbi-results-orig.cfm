<cfscript>
    param name="local.response" default="";
    local.dsn = 'wellcoachesschool';
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
        ORDER BY convert(date,wba.submitted) ASC;
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

<cfif ! isDefined('getMind_1')>
    There are no records. <cfabort />
</cfif>
<table border=1>
    <h1>Mind</h1>
    <cfloop query="getMind_1">
        <cfif currentrow EQ 1>
            <tr>
                <td style="width:800px"></td>
                <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                    <td>#local.submitted[local.count2]#</td>
                </cfloop>
            </tr>
        </cfif>
        <tr>
            <td>#evaluate('getMind_1.question')#</td>
            
            <cfloop from="1" to="#structCount(local.results)#" index="local.count">
                <td>
                    <cfif structKeyExists(local.mind[local.count],'#getMind_1.id#')>
                        #local.mind[local.count][getMind_1.id]#
                    </cfif>
                </td>
            </cfloop>
        </tr>
    </cfloop>
</table>

<table border=1>
    <h1>Body</h1>
    <cfloop query="getBody_1">
        <cfif currentrow EQ 1>
            <tr>
                <td style="width:800px"></td>
                <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                    <td>#local.submitted[local.count2]#</td>
                </cfloop>
            </tr>
        </cfif>
        <tr>
            <td>#evaluate('getBody_1.question')#</td>
            
            <cfloop from="1" to="#structCount(local.results)#" index="local.count">
                <td>
                    <cfif structKeyExists(local.body[local.count],'#getBody_1.id#')>
                        #local.body[local.count][getBody_1.id]#
                    </cfif>
                </td>
            </cfloop>
        </tr>
    </cfloop>
</table>

<table border=1>
    <h1>Work</h1>
    <cfloop query="getWork_1">
        <cfif currentrow EQ 1>
            <tr>
                <td style="width:800px"></td>
                <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                    <td>#local.submitted[local.count2]#</td>
                </cfloop>
            </tr>
        </cfif>
        <tr>
            <td>#evaluate('getWork_1.question')#</td>
            
            <cfloop from="1" to="#structCount(local.results)#" index="local.count">
                <td>
                    <cfif structKeyExists(local.work[local.count],'#getWork_1.id#')>
                        #local.work[local.count][getWork_1.id]#
                    </cfif>
                </td>
            </cfloop>
        </tr>
    </cfloop>
</table>

<table border=1>
    <h1>Life</h1>
    <cfloop query="getLife_1">
        <cfif currentrow EQ 1>
            <tr>
                <td style="width:800px"></td>
                <cfloop from="1" to="#structCount(local.results)#" index="local.count2">
                    <td>#local.submitted[local.count2]#</td>
                </cfloop>
            </tr>
        </cfif>
        <tr>
            <td>#evaluate('getLife_1.question')#</td>
            
            <cfloop from="1" to="#structCount(local.results)#" index="local.count">
                <td>
                    <cfif structKeyExists(local.life[local.count],'#getLife_1.id#')>
                        #local.life[local.count][getLife_1.id]#
                    </cfif>
                   
                </td>
            </cfloop>
        </tr>
    </cfloop>
</table>


</cfoutput>