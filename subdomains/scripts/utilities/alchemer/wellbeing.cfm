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
            querySetCell(myquery, "section_id", local.section_Id);
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
    <!--- Section_id:
            1 = mind
            3 = body
            4 = work
            5 = life --->

   <cfquery name="getAverage" dbtype="query">
       select * 
       from myquery
       where id in (85,87,88,89,90)
       order by section_id asc
   </cfquery>

   <cfset averageStruct = {} />

   <cfloop query="getAverage">
       <cfif section_id eq 1>
            <cfset averageStruct.Mind = getAverage.answer />
       </cfif>
       <cfif section_id eq 3>
            <cfset averageStruct.Body = getAverage.answer />
       </cfif>
       <cfif section_id eq 4>
            <cfset averageStruct.Work = getAverage.answer />
       </cfif>
       <cfif section_id eq 5>
            <cfset averageStruct.Life = getAverage.answer />
       </cfif>
       <cfif section_id eq 5 and id eq 90>
            <cfset averageStruct.wellbeing = getAverage.answer />
       </cfif>
   </cfloop>

    <cfset filePath = GetTempDirectory() & "#local.email#.pdf">

    <!---<cfhtmltopdf destination="#filePath#" orientation="portrait"  pagetype="A4" margintop="1" marginbottom="1"  overwrite="yes"> --->
       <!doctype html>
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
                <table border="0" width="600px" cellpadding="0" cellspacing="0" style="text-align: left; color: white; font-family: 'DM Sans', 'Open Sans', Arial, sans-serif;">
                <thead style="background-color: ##4B3EEC;">
                    <tr>
                        <th style="padding: 28px;">
                            <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-logo-white.png" width="135" height="16" alt="Wellcoaches Logo">
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background-color: ##4B3EEC">
                        <td style="padding: 56px 56px 28px 28px; font-size: 24px;">Here are your personal Health and Well-being Assessment results.</td>
                    </tr>
                    <tr style="background-color: ##4B3EEC;">
                        <td style="padding: 0 28px 84px 28px;">
                            <table border="0" width="544" cellpadding="0" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th colspan="4" style="font-size: 40px; font-weight: normal; padding: 14px 0; text-align: left;">Averages</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    <tr>
                                        <td style="font-size: 96px; font-weight: 500; line-height: 100% !important; padding: 14px 14px 14px 0; text-align: center;" valign="bottom">#averageStruct['mind']#</td>
                                        <td style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; padding: 0 28px 28px 0; font-weight: 300;" valign="bottom">Mind Assessment</td>
                                       
                                        <td style="font-size: 96px; font-weight: 500; line-height: 100% !important; padding: 14px 14px 14px 0; text-align: center;" valign="bottom">#averageStruct['body']#</td>
                                        <td style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; padding: 0 28px 28px 0; font-weight: 300;" valign="bottom">Body Assessment</td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 96px; font-weight: 500; line-height: 100% !important; padding: 14px 14px 14px 0; text-align: center;" valign="bottom">#averageStruct['work']#</td>
                                        <td style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; padding: 0 28px 28px 0; font-weight: 300;" valign="bottom">Work Assessment</td>
                                        
                                        <td style="font-size: 96px; font-weight: 500; line-height: 100% !important; padding: 14px 14px 14px 0; text-align: center;" valign="bottom">#averageStruct['life']#</td>
                                        <td style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; padding: 0 28px 28px 0; font-weight: 300;" valign="bottom">Life Score Assessment</td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 96px; font-weight: 500; line-height: 100% !important; padding: 14px 14px 14px 0; text-align: center;" valign="bottom">#averageStruct['wellbeing']#</td>
                                        <td style="font-size: 24px; font-family: 'Open Sans', Arial, sans-serif; line-height: 100% !important; padding: 0 28px 28px 0; font-weight: 300;" valign="bottom">Well-Being Assessment</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/doing-well-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC;">
                            <!--[if gte mso 9]>
                            <v:rect xmlns:v="urn:schemas-microsoft-com:vml" fill="true" stroke="false" style="width:600px;height:640px;">
                            <v:fill type="frame" src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/doing-well-bg.png" color="##4B3EEC" />
                            <v:textbox inset="0,0,0,0">
                            <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td style="padding: 28px;">
                                            <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" widtd="16" height="14" alt="Wellcoaches Logo Icon">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 28px 215px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important;">Areas where you are <b style="white-space: nowrap;">doing well.</b></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif;" valign="top">40<span style="font-size: 120px; vertical-align: top; line-height: 100% !important;">%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 28px 56px 28px; line-height: 100% !important; font-size: 18px; text-transform: uppercase; font-weight: 400;">of your answers were <b>7 or higher</b></td>
                                    </tr>
                                </thead>
                            </table>
                            <!--[if gte mso 9]>
                            </v:textbox>
                            </v:rect>
                            <![endif]-->
                        </td>
                    </tr>
                    <tr>
				        <td style="padding: 50px 0 14px 28px;">
                            <table border="0" cellpadding="0" cellspacing="0" style="color: ##221E49;table-layout: fixed;">
                                <tbody>
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
                                    <cfloop from="1" to="#gethigh.recordcount#" index="currentrow" >
                                        <tr>
                                            <cfif ArrayIsDefined(col1,currentrow) AND LEN(col1[currentrow]['question'])>
                                                <td style="width: 50%; height: 104px;" valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 100% !important; min-width: 42px; text-align: center;" valign="top">#col1[currentrow]['answer']#</td>
                                                                <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 2px 28px 28px 14px; font-weight: 300; width: 100%;" valign="top">#col1[currentrow]['question']#</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </cfif>
                                            <cfif ArrayIsDefined(col2,currentrow) AND LEN(col2[currentrow]['question'])>
                                                <td style="width: 50%; height: 104px;" valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 100% !important; min-width: 42px; text-align: center;" valign="top">#col2[currentrow]['answer']#</td>
                                                                <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 2px 28px 28px 14px; font-weight: 300; width: 100%;" valign="top">#col2[currentrow]['question']#</td>
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
                        <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/improvement-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC;">
                            <!--[if gte mso 9]>
                            <v:rect xmlns:v="urn:schemas-microsoft-com:vml" fill="true" stroke="false" style="width:600px;height:640px;">
                            <v:fill type="frame" src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/improvement-bg.png" color="##4B3EEC" />
                            <v:textbox inset="0,0,0,0">
                            <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td style="padding: 28px;">
                                            <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" widtd="16" height="14" alt="Wellcoaches Logo Icon">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 28px 215px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important;">Potential opportunities <b style="white-space: nowrap;">for improvement.</b></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif;" valign="top">50<span style="font-size: 120px; vertical-align: top; line-height: 100% !important;">%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 28px 56px 28px; line-height: 100% !important; font-size: 18px; text-transform: uppercase; font-weight: 400;">of your answers were <b>4 to 6</b></td>
                                    </tr>
                                </thead>
                            </table>
                            <!--[if gte mso 9]>
                            </v:textbox>
                            </v:rect>
                            <![endif]-->
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
                        <td style="padding: 50px 0 14px 28px;">
                            <table border="0" cellpadding="0" cellspacing="0" style="color: ##221E49;table-layout: fixed;">
                                <tbody>
                                    <cfloop from="1" to="#gethigh.recordcount#" index="currentrow" >
                                        <tr>
                                            <cfif ArrayIsDefined(col1,currentrow) AND LEN(col1[currentrow]['question'])>
                                                <td style="width: 50%; height: 104px;" valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 100% !important; min-width: 42px; text-align: center;" valign="top">#col1[currentrow]['answer']#</td>
                                                                <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 2px 28px 28px 14px; font-weight: 300; width: 100%;" valign="top">#col1[currentrow]['question']#</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </cfif>
                                            <cfif ArrayIsDefined(col2,currentrow) AND LEN(col2[currentrow]['question'])>
                                                <td style="width: 50%; height: 104px;" valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="color: ##4B3EEC; font-weight: bold; font-size: 40px; line-height: 100% !important; min-width: 42px; text-align: center;" valign="top">#col2[currentrow]['answer']#</td>
                                                                <td style="font-size: 14px; font-family: 'Open Sans', Arial, sans-serif; padding: 2px 28px 28px 14px; font-weight: 300; width: 100%;" valign="top">#col2[currentrow]['question']#</td>
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
                        <td background="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/burnout-bg.png" width="600" height="640" valign="top" style="background-color: ##4B3EEC;">
                            <!--[if gte mso 9]>
                            <v:rect xmlns:v="urn:schemas-microsoft-com:vml" fill="true" stroke="false" style="width:600px;height:640px;">
                            <v:fill type="frame" src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/burnout-bg.png" color="##4B3EEC" />
                            <v:textbox inset="0,0,0,0">
                            <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td style="padding: 28px;">
                                            <img src="https://prcr-misc.sfo3.cdn.digitaloceanspaces.com/wellcoaches-alchemer-email/wellcoaches-icon-white.png" widtd="16" height="14" alt="Wellcoaches Logo Icon">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 28px 215px 28px 28px; font-size: 40px; font-weight: 400; line-height: 120% !important;">Areas that may contribute to <b style="white-space: nowrap;">burnout.</b></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 0 0 20px; font-size: 240px; line-height: 90% !important; font-weight: bold; font-family: 'DM Sans', Arial, sans-serif;" valign="top">10<span style="font-size: 120px; vertical-align: top; line-height: 100% !important;">%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0 28px 56px 28px; line-height: 100% !important; font-size: 18px; text-transform: uppercase; font-weight: 400;">of your answers were <b>3 or lower</b></td>
                                    </tr>
                                </thead>
                            </table>
                            <!--[if gte mso 9]>
                            </v:textbox>
                            </v:rect>
                            <![endif]-->
                        </td>
                    </tr>
            <!--- end rows --->
                </table>
            </body>
        </html>
        
       
      <!---   <cfhtmltopdfitem type="header">
            Page: _PAGENUMBER of _LASTPAGENUMBER
        </cfhtmltopdfitem>    
    </cfhtmltopdf>

   <cfmail to="#trim(local.email)#" bcc="rdiveley@wellcoaches.com" subject="Well-being Self-Assessment Results" from="wellcoaches@wellcoaches.com" >
        <cfmailparam file="#filePath#" disposition="attachment" type="#fileGetMimeType(filePath)#" remove="true">
        <cfmailpart type="html">
            Your Well-being Self-Assessment results are attached. <br /><br />
            This self-assessment is a quick way to examine your well-being in work and life.  Scores of 8 and higher indicate that you are doing well; keep it up!  Scores below 7 may be opportunities for improvement, enhanced by working with a well-being coach. 
        </cfmailpart>
    </cfmail> --->

</cfoutput>
