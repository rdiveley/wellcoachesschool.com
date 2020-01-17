<cfdirectory directory="C:\websites\wellcoaches\standalonewellbeing\temp"
        	action="list"
            filter="*.pdf"
            name="surveyList">
<cfoutput>
<cfparam name="URL.email" default="" /> 
<cfparam name="foundOne" default="0" />

<table>   
	<tr><td>Well-being Assessment</td></tr>        
<cfloop query="surveyList">
	<cfset startEmail = listGetAt(name,1,"@") />
	<cfset endEmail = listGetAt(listGetAt(name,2,"@"),1,"_") />
    
	<cfif '#startEmail#@#endEmail#' EQ URL.email OR FindNoCase(URL.email,name)>
    	 <cfset foundOne = 1 />
         <cfset link = '<a href="#cgi.SCRIPT_NAME#?fileName=#URLEncodedFormat(ReplaceNoCase(surveyList.name,"^","_","all"))#" style="font-family:Arial, Helvetica, sans-serif;size:auto; text-decoration:none">#ListGetAt(URLDecode(surveyList.name),1,"_")# Wellbeing Assessment</a>'>
         <tr><td>#link#</td></tr>    
    </cfif>
</cfloop>
</table>
<cfif !foundOne>
	No Assessments are available
</cfif>


<cfif isdefined("URL.fileName")>
    <cfheader name="Content-Disposition" value="attachment; filename=#URL.filename#" />
    <cfcontent file="C:\websites\wellcoaches\standalonewellbeing\temp\#URL.filename#" type="application/pdf" reset="true">
</cfif>
</cfoutput>
