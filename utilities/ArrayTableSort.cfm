
<!--- ArrayTable.cfm
DESCRIPTION: sorts a 2D Array either Asc or Desc on a given column. Can handle numeric, text and date values.

ATTRIBUTES:

arrayname	- the array to be sorted, must be a filled table.
sortcolumn 	- the column number to sort on, 1st by default
sortorder 	- "Asc" or "Desc", desc by default.

dateformat - OPTIONAL field for when dates are supplied in format dd/mm/yyyy  or mm/dd/yyyy.
			a value of 'e' indicates a European dd/mm/yyyy format, a value of 'a' indicates American
			mm/dd/yyyy.

USAGE:

To use put <CF_ArrayTable> in a page, supplying a valid 2D array to sort.
The newly sorted array is referenced as 'arraysorted' in the calling template.

EXAMPLE:

<cf_ArrayTableSort 
	sortcolumn=6
	sortorder='asc'
	arrayname=#aryTest#
>

n.b. must enclose the name of the array in hashes to pass the object to the Custom tag.

--->



<cfset sortedarray=ArrayNew(2)>

<Cfif  IsDefined("ATTRIBUTES.sortcolumn")>
	<cfset sortcol = ATTRIBUTES.sortcolumn>
<cfelse>
	<cfset sortcol = 1>
</cfif>


<cfif not IsDefined("ATTRIBUTES.arrayname")>

	You have not supplied an array to sort.
	<cfabort>

<cfelse>

	<cfset testarray = ATTRIBUTES.arrayname>



	<Cfif  IsDefined("ATTRIBUTES.sortcolumn")>
		<cfset sortcol = ATTRIBUTES.sortcolumn>
	
		<cfif IsBoolean(sortcol)>
		<cfset sortcol = int(sortcol)>
		
			<cfif (sortcol gt ArrayLen(testarray[1])) OR (sortcol lt 1)>
			The sortcolumn is outside the bounds of the array
			<cfabort>	
			</cfif>
		
		
		<cfelse>
		You have not supplied a valid integer for the sortcolumn.
		<cfabort>
		</cfif>
	
	<cfelse>
		<cfset sortcol = 1>
	</cfif>

	<Cfif  IsDefined("ATTRIBUTES.sortorder")>
		<cfset sortorder = ATTRIBUTES.sortorder>
	
		<cfif not ListFindNoCase("asc,desc",sortorder) >
		You must define the sortorder as either 'asc' or 'desc'.
		<cfabort>
		</cfif>
	<cfelse>
		<cfset sortorder = "desc">
	</cfif>

	
	<cfif IsDefined("ATTRIBUTES.dateformat")>
		<cfset dateformat = ATTRIBUTES.dateformat>
	<cfelse>
		<cfset dateformat = 'na'>
	</cfif>
	
</cfif>

<!--- testlist is the unsorted LIST --->
<cfset checklist = "">
<cfloop from = 1 to =#ArrayLen(testarray)# index = "j">
<cfif IsDate(testarray[j][sortcol])>

	<!--- check to see whether a dateformat flag applies--->
	<cfif dateformat neq 'na'>
		<cfif Find('/',testarray[j][sortcol])>
			<cfset aryDate = ListToArray(testarray[j][sortcol],'/')>
		
			<cfif dateformat eq 'e'>
				<cfset newDate = CreateDate(aryDate[3], aryDate[2], aryDate[1])>
			<cfelse>
				<cfset newDate = CreateDate(aryDate[3], aryDate[1], aryDate[2])>
			</cfif>
			<cfset checklist = ListAppend(checklist,CreateODBCDate(newDate))>
		<cfelse>
			<cfset checklist = ListAppend(checklist,CreateODBCDate((testarray[j][sortcol])))>
		</cfif>
	<cfelse>
		<cfset checklist = ListAppend(checklist,CreateODBCDate((testarray[j][sortcol])))>
	</cfif>



	
<cfelse>
	<cfset checklist = ListAppend(checklist,(testarray[j][sortcol]))>
</cfif>
</cfloop>

<!--- create array copy of unsorted list --->
<cfset checkarray = ListToArray(checklist)>

<!--- checkagainstarray becomes... --->
<cfset checkagainstarray = checkarray>


<cfif not IsDefined("ATTRIBUTES.method")>
<cfif IsBoolean(checkarray[1])>
	<cfset mode="numeric">
<cfelse>
	<cfset mode="text">
</cfif>
<cfelse>
<cfset mode = ATTRIBUTES.method>
</cfif>


<!--- the SORTED array --->
<cfset sorted = ArraySort(checkagainstarray, mode, sortorder )>

<!--- the SORTED LIST --->
<cfset checkagainstlist = ArrayToList(checkagainstarray)>

<cfset counter = 1>
<cfloop list="#checkagainstlist#" index = "i">


<cfset itemposition = ListFind(checklist,i)>

<cfset checklist = ListSetAt(checklist,itemposition,"ZZZZZZZZZ")>

<cfloop from="1" to=#ArrayLen(testarray[itemposition])# index = "j">
<cfset sortedarray[counter][j] = testarray[itemposition][j]>
</cfloop>

<cfset counter = counter + 1>
</cfloop>




<CFSET CALLER.arraysorted = sortedarray>

