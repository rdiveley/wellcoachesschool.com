<!---
NAME:
CF_DumpQuery

DESCRIPTION:
Cold Fusion custom tag to display the columns and contents of a
specified query in an HTML table.

ATTRIBUTES:
QUERY   - (required) query to be displayed.
BORDER  - (optional) table border value (defaults to 0).
MAXROWS - (optional) maximum number of rows to be displayed (defaults
          to all).

NOTES:
This tag displays a simple HTML table containing the columns and
data in a passed query. This tag is useful for debugging query
results.

USAGE:
To use just call <CF_DumpQuery QUERY="queryname"> passing the name
of the query to be displayed. BORDER and MAXROWS may optionally
be specified.

AUTHOR:
Ben Forta (ben@stoneage.com) 8/1/97
--->

<!--- Initialize variables --->
<CFSET proceed = "Yes">
<CFSET table_border = 0>
<CFIF IsDefined("ATTRIBUTES.border")>
 <CFSET table_border = ATTRIBUTES.border>
</CFIF>

<!--- Check query was passed --->
<CFIF IsDefined("ATTRIBUTES.query") IS "No">
 <CFSET proceed = "No">
</CFIF>

<!--- Build useable query name and columnlist variable --->
<CFIF proceed IS "Yes">
 <CFSET query_name = "CALLER." & #ATTRIBUTES.query#>
 <CFSET query_columns = "CALLER." & #ATTRIBUTES.query# & ".columnlist">
</CFIF>

<!--- Query was passed, check it is a valid query --->
<CFIF proceed IS "Yes">
 <CFIF IsQuery(Evaluate(query_name)) IS "No">
  <CFSET proceed = "No">
 </CFIF>
</CFIF>

<!--- If okay to proceed, start processing --->
<CFIF proceed IS "Yes">

 <!--- How many rows are there in this query? --->
 <CFSET num_rows = Evaluate(query_name & ".RecordCount")>
 
 <!--- If MAXROWS exists and is number less that num_rows, use it instead --->
 <CFIF IsDefined("ATTRIBUTES.maxrows")>
  <CFIF (IsNumeric(ATTRIBUTES.maxrows)) AND (ATTRIBUTES.maxrows LT num_rows)>
   <CFSET num_rows = ATTRIBUTES.maxrows>
  </CFIF>
 </CFIF>

 <!--- Create table --->
 <CFOUTPUT><TABLE BORDER="#table_border#"></CFOUTPUT>

 <!--- Write columns names as headers --->
 <TR>
  <!--- Loop through the column list to get column names --->
  <CFLOOP INDEX="col" LIST="#Evaluate(query_columns)#">
   <CFOUTPUT><TH>#col#</TH></CFOUTPUT>
  </CFLOOP>
 </TR>

 <!--- Loop through rows in query --->
 <CFLOOP INDEX="row" FROM="1" TO="#num_rows#">

  <!--- For each row in query, create a new table row <TR> --->
  <TR>
  <!--- Loop through columns --->
  <CFLOOP INDEX="col" LIST="#Evaluate(query_columns)#">
  
   <!--- Get column value --->
   <CFSET col_value = #Evaluate(query_name & "." & col & "[" & row & "]")#>
   
   <!--- Write each column (and format if possible) --->
   <CFIF IsDate(col_value)>
    <!--- It's a date, so format as date (and time) --->
    <CFOUTPUT><TD>#DateFormat(col_value)# #TimeFormat(col_value)#</TD></CFOUTPUT>
   <CFELSEIF IsNumeric(col_value)>
    <!--- It's a number, so right align --->
    <CFOUTPUT><TD ALIGN="RIGHT">#col_value#</TD></CFOUTPUT>
   <CFELSE>
    <!--- Unknown, right out as is --->
    <CFOUTPUT><TD>#col_value#</TD></CFOUTPUT>
   </CFIF>
   
  </CFLOOP>
  </TR>

 </CFLOOP>

 </TABLE>

</CFIF>
