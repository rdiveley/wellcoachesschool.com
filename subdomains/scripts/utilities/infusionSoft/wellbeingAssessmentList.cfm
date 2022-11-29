<cfif isdefined("URL.fileName")>
    <cfheader name="Content-Disposition" value="attachment; filename=#URL.filename#" />
    <cfcontent file="C:\websites\wellcoaches.com\standalonewellbeing\temp\#URL.filename#" type="application/pdf" reset="true">
</cfif>

<cfquery name="getAllEmails" datasource="wellcoachesSchool" >
	select max(email_address) as email_address
    from coachInPracticeEmailFix
    where email_address like '%#url.email#%'
</cfquery>

<cfparam name="local.email" default="" />

<cfif getAllEmails.recordCount GT 0 AND Len(getAllEmails.email_address)>
	<cfset local.email = lcase(ReplaceNoCase(getAllEmails.email_address,"'","","all")) />
<cfelse>
	<cfset local.email = lcase(ReplaceNoCase(url.email,"'","","all")) />
</cfif>

<cfdirectory directory="C:\websites\wellcoaches.com\standalonewellbeing\temp"
        	action="list"
            filter="*.pdf"
            name="surveyList">
<cfoutput>



<table>
	<tr><td>Well-being Assessment</td></tr>
        <cfparam name="foundOne" default="0" />    
        <cfloop query="surveyList">
            <cfloop list="#local.email#" index="email">
                <cfset startEmail = listGetAt(name,1,"@") />
                <cfset endEmail = listGetAt(listGetAt(name,2,"@"),1,"_") />
                
                <cfif name contains email>
                    <cfset foundOne = 1 />
                    <cfset link = '<a href="#cgi.SCRIPT_NAME#?fileName=#URLEncodedFormat(ReplaceNoCase(surveyList.name,"^","_","all"))#" style="font-family:Arial, Helvetica, sans-serif;size:auto; text-decoration:none">#ListGetAt(URLDecode(surveyList.name),1,"_")# Wellbeing Assessment</a>'>
                    <tr><td><a href="#cgi.SCRIPT_NAME#?fileName=#URLEncodedFormat(ReplaceNoCase(surveyList.name,"^","_","all"))#" style="font-family:Arial, Helvetica, sans-serif;size:auto; text-decoration:none">#ListGetAt(URLDecode(surveyList.name),1,"_")# Wellbeing Assessment</a></td></tr>
                </cfif>
                
            </cfloop>    
        </cfloop>
</table>
<cfif !foundOne>
	No Assessments are available
</cfif>
</cfoutput>
