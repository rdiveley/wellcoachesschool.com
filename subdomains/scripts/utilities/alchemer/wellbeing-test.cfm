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

    <cfset myquery = queryNew("id,question,answer,section_id", "integer,varchar,integer,integer") />
    <cfloop collection="#local.results#" item="local.item">
        <cfset local.questionNumber = local.item />
        <cfset local.question = local.results[local.item]['question'] />
        <cfset local.section_Id = local.results[local.item]['section_Id'] />
    
        <cfset local.answer = 0  />
        <cfif structKeyExists(local.results[local.item], 'answer') and isNumeric(local.results[local.item]['answer'])>
            <cfset local.answer = local.results[local.item]['answer'] />
        </cfif>
        
        <cfscript>
            queryAddRow(myquery);
            querySetCell(myquery, "id", local.questionNumber);
            querySetCell(myquery, "question", local.question);
            querySetCell(myquery, "answer", local.answer);
            querySetCell(myquery, "section_id", local.section_Id);
        </cfscript>
        
    </cfloop>


   <cfquery name="getHigh" dbtype="query">
       select * 
       from myquery
       where answer >= 7 
       and id not in (72,85,87,88,89,90,150,151,152,153)
       order by answer desc
   </cfquery>

    <cfquery name="getMedium" dbtype="query">
       select * 
       from myquery
       where answer >= 4 AND answer <=6 
       and id not in (72,85,87,88,89,90,150,151,152,153)
       order by answer desc
   </cfquery>

    <cfquery name="getLow" dbtype="query">
       select * 
       from myquery
       where answer >=0 and answer <=3 
       and id not in (72,85,87,88,89,90,150,151,152,153)
       order by answer desc
   </cfquery>

   <cfset local.totalanswers = val(getHigh.recordcount) + val(getMedium.recordcount)+ val(getLow.recordcount) />

   <cfset local.highAverage = round(val(getHigh.recordcount)/local.totalanswers*100) />
   <cfset local.mediumAverage = round(val(getMedium.recordcount)/local.totalanswers*100) />
   <cfset local.lowAverage = round(val(getLow.recordcount)/local.totalanswers*100) />

    <!--- Section_id:
            1 = mind
            3 = body
            4 = work
            5 = life --->

  <cfquery name="getAverageMind" dbtype="query">
       select answer
       from myquery
       where section_id = 1 
       and id in (101,103,105,107,109)
   </cfquery>

   <cfset section_mind_sum = arraySum(listToArray(valueList(getAverageMind.answer))) />
   <cfset section_mind_average = round(val(section_mind_sum) / val(getAverageMind.recordcount)) /> 
   <cfset averageStruct.Mind = val(section_mind_average) />

    <cfquery name="getAverageBody" dbtype="query">
       select answer
       from myquery
       where section_id = 3 and id  in (116,117,118,121)
   </cfquery>

   <cfset section_body_sum = arraySum(listToArray(valueList(getAverageBody.answer))) />
   <cfset section_body_average = round(val(section_body_sum) / val(getAverageBody.recordcount)) /> 
   <cfset averageStruct.Body = val(section_body_average) />

   <cfquery name="getAverageWork" dbtype="query">
       select answer
       from myquery
       where section_id = 4 and id  in (124,125,126,128,129,134,136)
   </cfquery>

   <cfset section_work_sum = arraySum(listToArray(valueList(getAverageWork.answer))) />
   <cfset section_work_average = round(val(section_work_sum) / val(getAverageWork.recordcount)) /> 
   <cfset averageStruct.Work = val(section_work_average) />

   <cfquery name="getAverageLife" dbtype="query">
       select answer
       from myquery
       where section_id = 5 and id  in (140,142,144,148)
   </cfquery>

   <cfset section_life_sum = arraySum(listToArray(valueList(getAverageLife.answer))) />
   <cfset section_life_average = round(val(section_life_sum) / val(getAverageLife.recordcount)) /> 
   <cfset averageStruct.Life = val(section_life_average) />

   <cfset averageStruct.wellbeing = round(averageStruct.body + averageStruct.mind + averageStruct.work + averageStruct.life) / 4> 

    <cfset filePath = GetTempDirectory() & "#local.email#.pdf">

      <cfsavecontent variable="results">
        <html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title></title>

                <style type="text/css">
                    @import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&display=swap');

                    body {
                        margin: 0;
                    }
                    table {
                        margin: auto;
                    }
                </style>

            </head>
            <body>

                <table border="0" width="600" cellpadding="0" cellspacing="0" style="text-align: left; color: white; font-family: 'DM Sans', 'Open Sans', Arial, sans-serif; width: 600px; background-color: ##4B3EEC;">
                    <thead style="background-color: ##4B3EEC; width: 600px;" width="600">
                        <tr>
                            <th style="padding: 28px; text-align: left;">
                                <a href="https://wellcoachesnetwork.com/" title="Click to visit https://wellcoachesnetwork.com/"><img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-logo-white.png" width="135" height="16" alt="Wellcoaches Logo"></a>
                            </th>
                        </tr>
                    </thead>
                    <tbody style="width: 600px;" width="600">
                        <tr style="background-color: ##4B3EEC;">
                            <td style="padding: 56px 56px 28px 28px; font-size: 24px; color: white;">Here are your scores from the 20 most validated items in the Wellcoaches Well-being Inventory.</td>
                        </tr>
                        <tr style="background-color: ##4B3EEC;">
                            <td style="padding: 0 28px 28px 28px; page-break-inside: avoid; break-inside: avoid;">
                                <table border="0" width="400" cellpadding="0" cellspacing="0" style="margin-left: 0; width: 400px; background-color: ##4B3EEC;">
                                    <thead style="width: 400px;" width="400">
                                        <tr>
                                            <th style="font-size: 40px; font-weight: normal; padding: 14px 0; text-align: left; color: white;">Overall Average <span style="font-size: 16px; font-weight: normal;">(out of 10)</span></th>
                                        </tr>
                                    </thead>
                                    <tbody style="width: 300px;" width="300">
                                        <tr>
                                            
                                            <td height="96" style="font-size: 96px; font-weight: 500; line-height: 100% !important; mso-line-height-rule:exactly; padding: 0 14px 14px 0; color: white; height: 96px;" valign="bottom"><span style="display: inline-block; min-width: 60px; text-align: center;">#averageStruct['wellbeing']#</span> <span style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; mso-line-height-rule: exactly; font-weight: 300; color: white;">Well-Being</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr style="background-color: ##4B3EEC;">
                            <td style="padding: 0 28px 0 28px; page-break-inside: avoid; break-inside: avoid;">
                                <table border="0" width="544" cellpadding="0" cellspacing="0" style="width: 544px; border: none; background-color: ##4B3EEC; margin-left: 0;">
                                    <thead style="width: 544px;" width="544">
                                        <tr>
                                            <th colspan="2" style="font-size: 40px; font-weight: normal; padding: 14px 0; text-align: left; color: white;">Section Averages <span style="font-size: 16px; font-weight: normal;">(out of 10)</span></th>
                                        </tr>
                                    </thead>
                                    <tbody style="width: 544px;" width="544" style="border: none;">
                                        <tr>
                                            <td height="96" style="font-size: 96px; font-weight: 500; line-height: 100% !important; mso-line-height-rule:exactly; padding: 0 14px 14px 0; color: white; height: 96px;" valign="bottom"><span style="display: inline-block; min-width: 60px; text-align: center;">#averageStruct['mind']#</span> <span style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; mso-line-height-rule: exactly; font-weight: 300; color: white;">Mind</span></td>
                                            <td height="96" style="font-size: 96px; font-weight: 500; line-height: 100% !important; mso-line-height-rule:exactly; padding: 0 14px 14px 0; color: white; height: 96px;" valign="bottom"><span style="display: inline-block; min-width: 60px; text-align: center;">#averageStruct['body']#</span> <span style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; mso-line-height-rule: exactly; font-weight: 300; color: white;">Body</span></td>
                                        </tr>
                                        <tr>
                                            <td height="96" style="font-size: 96px; font-weight: 500; line-height: 100% !important; mso-line-height-rule:exactly; padding: 0 14px 0 0; color: white; height: 96px;" valign="bottom"><span style="display: inline-block; min-width: 60px; text-align: center;">#averageStruct['work']#</span> <span style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; mso-line-height-rule: exactly; font-weight: 300; color: white;">Work</span></td>
                                            <td height="96" style="font-size: 96px; font-weight: 500; line-height: 100% !important; mso-line-height-rule:exactly; padding: 0 14px 0 0; color: white; height: 96px;" valign="bottom"><span style="display: inline-block; min-width: 60px; text-align: center;">#averageStruct['life']#</span> <span style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; mso-line-height-rule: exactly; font-weight: 300; color: white;">Life</span></td>
                                        </tr>
                                        <tr>
                                            <td height="28"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="21" style="background-color: white;"></td>
                        </tr>
                         <tr style="background-color: ##4B3EEC;">
                            <td style="padding: 56px 56px 28px 28px; font-size: 24px; color: white;">Below are your scores on all 49 items.</td>
                        </tr>
                        <tr>
                            <td height="21" style="background-color: white;"></td>
                        </tr>
                        <tr>
                            <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/doing-well-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC; background-size: cover; page-break-inside: avoid; break-inside: avoid; width: 600px; height: 640px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td style="padding: 28px;">
                                                <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" width="16" height="14" alt="Wellcoaches Logo Icon">
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td style="padding: 28px 215px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important; color: white;">Areas where you are <b style="white-space: nowrap;">doing well.</b></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif; color: white;" valign="top">#local.highAverage#<span style="font-size: 120px; vertical-align: top; line-height: 100% !important; mso-line-height-rule:exactly;">%</span></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 28px 56px 28px; line-height: 100% !important; mso-line-height-rule:exactly; font-size: 18px; text-transform: uppercase; font-weight: 400; color: white;">of your answers were <b>7 or higher</b></td>
                                        </tr>
                                    </thead>
                                </table>
                            </td>
                        </tr>
                        <cfset col1 = [] />
                        <cfset col2 = [] />

                        <cfloop query="getHigh">
                            <cfset item = {} />
                            <cfset item.question = getHigh.question> 
                            <cfset item.answer = getHigh.answer>
                            <cfif currentrow mod 2 is 1> 
                                <cfset arrayAppend(col1, item )> 
                            <cfelse> 
                                <cfset arrayAppend(col2, item)> 
                            </cfif> 
                        </cfloop>
                        <tr>
                            <td style="padding: 50px 0 14px 28px; page-break-inside: avoid; break-inside: avoid; text-align: left; background-color: white;">
                                <table border="0" cellpadding="0" cellspacing="0" style="color: ##221E49; width: 100%; background-color: white;">
                                    <tbody>
                                        <cfloop from="1" to="#gethigh.recordcount#" index="currentrow" >
                                            <tr>
                                                <cfif ArrayIsDefined(col1,currentrow) AND LEN(trim(col1[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col1[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col1[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                                <cfif ArrayIsDefined(col2,currentrow) AND LEN(trim(col2[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col2[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col2[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                        
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/improvement-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC; background-size: cover; page-break-inside: avoid; break-inside: avoid; width: 600px; height: 640px;">
                                <table border="0" cellpadding="0" cellspacing="0" width="600" style="width: 600px;">
                                    <tbody>
                                        <tr>
                                            <td style="padding: 28px;">
                                                <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" width="16" height="14" alt="Wellcoaches Logo Icon">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 28px 145px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important; color: white;">Potential opportunities <b style="white-space: nowrap;">for improvement.</b></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif; color: white;" valign="top">#local.mediumAverage#<span style="font-size: 120px; vertical-align: top; line-height: 100% !important; mso-line-height-rule:exactly;">%</span></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 28px 56px 28px; line-height: 100% !important; mso-line-height-rule:exactly; font-size: 18px; text-transform: uppercase; font-weight: 400; color: white;">of your answers were <b>4 to 6</b></td>
                                        </tr>
                                    </thead>
                                </table>
                            </td>
                        </tr>
                        <cfset col1 = [] />
                        <cfset col2 = [] />

                        <cfloop query="getMedium">
                            <cfset item = {} />
                            <cfset item.question = getMedium.question> 
                            <cfset item.answer = getMedium.answer>
                            <cfif currentrow mod 2 is 1> 
                                <cfset arrayAppend(col1, item )> 
                            <cfelse> 
                                <cfset arrayAppend(col2, item)> 
                            </cfif> 
                        </cfloop>
                        <tr>
                            <td style="padding: 50px 0 14px 28px; page-break-inside: avoid; break-inside: avoid; text-align: left; background-color: white;">
                                <table border="0" cellpadding="0" cellspacing="0" width="600" style="color: ##221E49; width: 600px; background-color: white;">
                                    <tbody>
                                        <cfloop from="1" to="#getMedium.recordcount#" index="currentrow" >
                                            <tr>
                                                <cfif ArrayIsDefined(col1,currentrow) AND LEN(trim(col1[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col1[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col1[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                                <cfif ArrayIsDefined(col2,currentrow) AND LEN(trim(col2[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col2[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col2[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/burnout-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC; background-size: cover; page-break-inside: avoid; break-inside: avoid; width: 600px; height: 640px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td style="padding: 28px;">
                                                <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" width="16" height="14" alt="Wellcoaches Logo Icon">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 28px 145px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important; color: white;">Areas that may contribute to <b style="white-space: nowrap;">burnout.</b></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif; color: white;" valign="top">#local.lowAverage#<span style="font-size: 120px; vertical-align: top; line-height: 100% !important; mso-line-height-rule:exactly;">%</span></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0 28px 56px 28px; line-height: 100% !important; mso-line-height-rule:exactly; font-size: 18px; text-transform: uppercase; font-weight: 400; color: white;">of your answers were <b>3 or lower</b></td>
                                        </tr>
                                    </thead>
                                </table>
                            </td>
                        </tr>
                        <cfset col1 = [] />
                        <cfset col2 = [] />

                        <cfloop query="getLow">
                            <cfset item = {} />
                            <cfset item.question = getLow.question> 
                            <cfset item.answer = getLow.answer>
                            <cfif currentrow mod 2 is 1> 
                                <cfset arrayAppend(col1, item )> 
                            <cfelse> 
                                <cfset arrayAppend(col2, item)> 
                            </cfif> 
                        </cfloop>
                        <tr>
                            <td style="padding: 50px 0 14px 28px; page-break-inside: avoid; break-inside: avoid; text-align: left; background-color: white;">
                                <table border="0" cellpadding="0" cellspacing="0" style="color: ##221E49; width: 100%; background-color: white;">
                                    <tbody>
                                        <cfloop from="1" to="#getLow.recordcount#" index="currentrow" >
                                            <tr>
                                                <cfif ArrayIsDefined(col1,currentrow) AND LEN(trim(col1[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col1[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col1[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                                 <cfif ArrayIsDefined(col2,currentrow) AND LEN(trim(col2[currentrow]['question']))>
                                                    <td style="width: 50%; height: 104px;" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 300px;">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 90% !important; mso-line-height-rule:exactly; width: 42px; min-width: 42px; text-align: center;" valign="top">#trim(col2[currentrow]['answer'])#</td>
                                                                    <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 0 28px 28px 14px; font-weight: 300; width: 100%;" valign="middle">#trim(col2[currentrow]['question'])#</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        
                    </tbody>
                    <tfoot style="width: 600px;" width="600">
                        <tr>
                            <td style="page-break-inside: avoid; break-inside: avoid;">
                                <table border="0" width="600" cellpadding="0" cellspacing="0" style="background-color: ##4B3EEC; text-align: left; width: 600px;">
                                    <tfoot>
                                        <tr>
                                            <th style="padding: 28px;">
                                                <a href="https://wellcoachesnetwork.com/" title="Click to visit https://wellcoachesnetwork.com/"><img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-logo-white.png" width="135" height="16" alt="Wellcoaches Logo"></a>
                                            </th>
                                            <td style="text-align: right; padding: 28px; color: white; font-family: 'DM Sans', 'Open Sans', Arial, sans-serif;"><a href="https://wellcoachesnetwork.com/" title="Click to visit https://wellcoachesnetwork.com/" style="color: white !important; font-family: 'DM Sans', 'Open Sans', Arial, sans-serif; font-size: 13px; text-decoration: none !important; border-bottom: 1px solid white;">wellcoachesnetwork.com</a></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </body>
        </html>
    </cfsavecontent>

   <cfmail to="#trim(local.email)#"  subject="Your Well-being Inventory" from="wellcoaches@wellcoaches.com" type="html" >
            #results#
    </cfmail>

</cfoutput>
