<cfparam name="ResourceID" default=0>
<cfparam name="PEAction" default="List">
<cfparam name="Website" default="none">
<cfparam name="DEPARTMENT" default="none">
<cfparam name="date_posted" default="#now()#">
<cfparam name="LINK" default="">
<cfparam name="EMAIL" default="none">
<cfparam name="tName" default="none">
<cfparam name="approved" default="1">
<cfparam name="ADDRESS" default="">
<cfparam name="CITY" default="">
<cfparam name="CONTACT" default="">
<cfparam name="FAX" default="">
<cfparam name="OFFICE" default="">
<cfparam name="STATE" default="">
<cfparam name="TELEPHONE" default="">

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AlljobResources">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="jobResources">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllStates">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="states">
</cfinvoke>

<cfif PEAction is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="jobResources">
		<cfinvokeargument name="XMLFields" value="ResourceID,ADDRESS, APPROVED, CITY, CONTACT, DATE_POSTED, DEPARTMENT, EMAIL, FAX, LINK, NAME, OFFICE, STATE, TELEPHONE, WEBSITE">
		<cfinvokeargument name="XMLIDField" value="ResourceID">
		<cfinvokeargument name="XMLIDValue" value="#ResourceID#">
	</cfinvoke>
	<cfset ResourceID=0>
	<cfset PEAction="List">
</cfif>
		
<cfif ResourceID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="jobResources">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="jobResources">
		<cfinvokeargument name="IDFieldName" value="ResourceID">
		<cfinvokeargument name="IDFieldValue" value="#ResourceID#">
	</cfinvoke>
	<cfoutput query="jobResources">
		<cfset Website=#replace(Website,"~",",","ALL")#>
		<cfset date_posted=#date_posted#>
		<cfset DEPARTMENT=#replace(DEPARTMENT,"~",",","ALL")#>
		<cfset LINK=#replace(LINK,"~",",","ALL")#>
		<cfset EMAIL=#EMAIL#>
		<cfset tName=#replace(Name,"~",",","ALL")#>
		<cfset ADDRESS=#replace(ADDRESS,"~",",","ALL")#>
		<cfset APPROVED=#APPROVED#>
		<cfset CITY=#replace(CITY,"~",",","ALL")#>
		<cfset CONTACT=#replace(CONTACT,"~",",","ALL")#>
		<cfset FAX=#FAX#>
		<cfset OFFICE=#replace(OFFICE,"~",",","ALL")#>
		<cfset STATE=#STATE#>
		<cfset TELEPHONE=#TELEPHONE#>
	</cfoutput>
	<cfset PEAction="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfset Website=#replace(Website,",","~","ALL")#>
	<cfset date_posted=#date_posted#>
	<cfset DEPARTMENT=#replace(DEPARTMENT,",","~","ALL")#>
	<cfset LINK=#replace(LINK,",","~","ALL")#>
	<cfset EMAIL=#EMAIL#>
	<cfset tName=#replace(tName,",","~","ALL")#>
	<cfset ADDRESS=#replace(ADDRESS,",","~","ALL")#>
	<cfset APPROVED=#APPROVED#>
	<cfset CITY=#replace(CITY,",","~","ALL")#>
	<cfset CONTACT=#replace(CONTACT,",","~","ALL")#>
	<cfset FAX=#FAX#>
	<cfset OFFICE=#replace(OFFICE,",","~","ALL")#>
	<cfset STATE=#STATE#>
	<cfset TELEPHONE=#TELEPHONE#>
	<cfif ResourceID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="jobResources">
<cfinvokeargument name="XMLFields" value="ADDRESS, APPROVED, CITY, CONTACT, DATE_POSTED, DEPARTMENT, EMAIL, FAX, LINK, NAME, OFFICE, STATE, TELEPHONE, WEBSITE">
		<cfinvokeargument name="XMLFieldData" value="#form.ADDRESS#,#XMLformat(form.APPROVED)#,#XMLformat(form.CITY)#,#form.CONTACT#,#form.DATE_POSTED#,#XMLformat(form.DEPARTMENT)#,#form.EMAIL#,#form.FAX#,#form.LINK#,#form.tName#,#form.OFFICE#,#form.STATE#,#form.TELEPHONE#,#form.WEBSITE#">
			<cfinvokeargument name="XMLIDField" value="ResourceID">
			<cfinvokeargument name="XMLIDValue" value="#ResourceID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="jobResources">
<cfinvokeargument name="XMLFields" value="ADDRESS, APPROVED, CITY, CONTACT, DATE_POSTED, DEPARTMENT, EMAIL, FAX, LINK, NAME, OFFICE, STATE, TELEPHONE, WEBSITE">
		<cfinvokeargument name="XMLFieldData" value="#form.ADDRESS#,#XMLformat(form.APPROVED)#,#XMLformat(form.CITY)#,#form.CONTACT#,#form.DATE_POSTED#,#XMLformat(form.DEPARTMENT)#,#form.EMAIL#,#form.FAX#,#form.LINK#,#form.tName#,#form.OFFICE#,#form.STATE#,#form.TELEPHONE#,#form.WEBSITE#">
			<cfinvokeargument name="XMLIDField" value="ResourceID">
		</cfinvoke>
	</cfif>
	<cfset PEAction="list">
	<cfset Website=''>
	<cfset date_posted = #now()#>
	<cfset ResourceID = 0>
	<cfset DEPARTMENT=''>
	<cfset LINK=''>
	<cfset EMAIL=''>
	<cfset tName=''>
	<cfset approved=1>
	<cfset ADDRESS=''>
	<cfset CITY=''>
	<cfset CONTACT=''>
	<cfset FAX=''>
	<cfset OFFICE=''>
	<cfset STATE=''>
	<cfset TELEPHONE=''>
</cfif>
 
<cfoutput>
<style>p {color: black;}</style>
<h1>Career Resources</h1>

<cfif PEAction is "Add" or PEAction is "Update">
<cfform name="formmain" action="adminheader.cfm?action=#action#" method="post">
<TABLE border=0 align="center" cellpadding=0 cellspacing=0>

  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Name of Company or University </B><BR>
		<INPUT size=50 name="tName" maxlength=100 value="#tName#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Link to your website</B> (optional)<BR>
  <B>http://
		</B>
		<INPUT size=41 name=website maxlength=100 value="#website#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Link to your career page</B> (optional)<BR>
  <B>http://
		</B>
		<INPUT size=41 name=link maxlength=100 value="#link#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Department </B><BR>
		<INPUT size=50 name="department" maxlength=100 value="#department#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Contact person or Dept. Chair if listing a University </B><BR>
		<INPUT size=50 name="contact" maxlength=100 value="#contact#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Address</B><BR>
		
		<TEXTAREA name="address" rows=4 wrap=PHYSICAL cols=70>#address#</TEXTAREA>
</P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>City</B><BR>
		<INPUT size=50 name="city" maxlength=100 value="#city#">
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 height=41 CLASS="body">
	  <P><B>Location: State or Country</B><BR>
		<SELECT size=1 name=state>
		<cfloop query="allstates">
			<option value="#stateID#"<cfif #state# is #stateid#> selected</cfif>>#statename#</option>
		</cfloop>
		  <OPTION value="Australia"<cfif #state# is "Australia"> selected</cfif>>Australia</OPTION>
		  <OPTION value="Canada"<cfif #state# is "Canada"> selected</cfif>>Canada</OPTION>
		  <OPTION value="United Kingdom"<cfif #state# is "United Kingdom"> selected</cfif>>United Kingdom</OPTION>
		  <OPTION value="Other Countries"<cfif #state# is "Other Countries"> selected</cfif>>Other Countries</OPTION>
		</SELECT>
   </P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><BR>
  <B>Office</B> (optional)<BR>
		<INPUT size=50 value="#office#" name="office" maxlength=50>
   </P>
	</TD>
  </TR>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Telephone</B> (optional)<BR>
		<INPUT size=50 maxlength=50 name="telephone" value="#telephone#">
</P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Fax</B> (optional)<B><BR>
		<INPUT maxlength=50 size=50 name="fax" value="#fax#">
</B></P>
	</td>
  </tr>
  <TR>
	<TD colSpan=2 CLASS="body">
	  <P><B>Email<BR><INPUT size=50 name="email" maxlength=100 value="#email#">
   </B></P>
	</td>
  </tr>
  <TR>
	<TD CLASS="body" colSpan=2>
		
	  <INPUT TYPE=submit VALUE="Submit Listing" NAME=submit>
</td>
  </TR>
</TABLE>
</cfFORM>

</cfif>
</CFOUTPUT>

<cfif PEAction is "list">
<cfoutput>
<style>p {color: black;}</style>
<a href="adminheader.cfm?Action=#Action#&PEAction=Add">Add A Career Resource</a></cfoutput><br>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="jobResources">
			<cfinvokeargument name="ThisPath" value="files">
	</cfinvoke>	
	
	<cfif #TheFileExists# is "true">
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AlljobResources">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="jobResources">
		</cfinvoke>
	<table border="1" align="CENTER">
	<th colspan="7" align="CENTER" bgcolor="Maroon"><p>Your Career Resources</p></th>
	<tr>
	<td><p>ID</p></td>
	<td><p>Name</p></td>
	<td><p>Website</p></td>
	<td><p>Authorized</p></td>
	<td><p>Date to Start</p></td>
	<td><p>Actions</p></td>
	</tr>
		
	<cfoutput query="AlljobResources">
	<tr>
	<td><p>#ResourceID#</p></td>
	<td><p>#Name#</p></td>
	<td><p>#Website#</p></td>
	<td align=center><p><cfif #approved# is 1>Yes<cfelse>No</cfif></p></td>
	<td><p>#dateformat(date_posted,'mm/dd/yyyy')#</p></td>
	<td><a href= "adminheader.cfm?ResourceID=#ResourceID#&PEAction=Edit&&action=#action#">Edit</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ResourceID=#ResourceID#&PEAction=Delete&action=#action#">Delete</a></td>
	</tr>
	</cfoutput>
	</cfif>
</cfif>
</table>

