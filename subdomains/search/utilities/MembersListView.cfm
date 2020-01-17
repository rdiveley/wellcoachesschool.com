<cfparam name="MemberAction" default="list">
<cfparam name="TypeID" default=0>
<cfparam name="alphabet" default="a">
<cfif #memberAction# is "delete">
	<cfinclude template="../utilities/members_recordaction.cfm">
</cfif>
	<cfinvoke method="GetAllMember" component="#Application.WebSitePath#.utilities.membersSQL" 
		returnvariable="Members">
		<cfinvokeargument name="TypeID" value="#typeID#">
		<cfinvokeargument name="Alphabet" value="#Alphabet#">
	</cfinvoke>
	<cfset RcdCnt = #Members.RecordCount#>



<cfoutput>
<h2><a href="adminheader.cfm?Action=membersedit&LID=#LID#&MemberAction=add&alphabet=#Alphabet#&TypeID=#TypeID#">Add A New Member</a><br>Total Members: #RcdCnt#<BR><br><a href="adminheader.cfm?Action=#Action#&LID=#LID#&TypeID=#TypeID#&alphabet=all">Click here to see all members</a></h2>
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=a">A</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=b">B</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=c">C</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=d">D</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=e">E</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=f">F</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=g">G</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=h">H</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=i">I</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=j">J</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=k">K</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=l">L</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=m">M</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=n">N</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=o">O</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=p">P</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=q">Q</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=r">R</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=s">S</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=t">T</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=u">U</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=v">V</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=w">W</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=x">X</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=y">Y</a> | 
<a href="adminheader.cfm?Action=#action#&LID=#LID#&TypeID=#TypeID#&alphabet=z">Z</a></cfoutput>

<TABLE class=toptable>

	
	<TR>
	<Th valign="top"> Member Name: </Th>
	<Th valign="top"> E-Mail: </Th>
	<Th valign="top"> Start Date: </Th>
	<Th valign="top"> Rebill Date: </Th>
	<Th valign="top"> Phone number: </Th>
	<Th valign="top"> Member Type: </Th>
	<Th valign="top"> Active: </Th>
	<Th valign="top"> Actions </Th>
	<th>&nbsp;</th>
	</tr><tr>
	<cf_nextrecords Records="#Members.RecordCount#"
			 ThisPageName="adminheader.cfm"
			 RecordsToDisplay="25"
			 DisplayText="Record"
			 DisplayFont="Arial"
			 FontSize=2
			 UseBold="Yes"
			 ExtraURL="&action=#action#&alphabet=#alphabet#">
	<cfoutput query="Members" StartRow=#SR# MaxRows=25>

	<TD><p>#trim(replace(firstName,"~",",","ALL"))# #Trim(replace(lastname,"~",",","ALL"))#</p></TD>
	<cfinvoke component="#Application.WebSitePath#.utilities.membersSQL" 
		method="GetMemberEmail" returnvariable="MemberEmail">
		<cfinvokeargument name="MemberID" value="#memberid#">
		<cfinvokeargument name="EMAILTYPEID" value="1">
	</cfinvoke>
    <TD><a href="mailto:#trim(MemberEmail.EmailAddress)#">#MemberEmail.EMailAddress#</a></TD>
    <TD><p><cfif isdate(startdate)>#dateformat(StartDate)#</cfif></p></TD>
    <TD><p><cfif isdate(enddate)>#dateformat(enddate)#</cfif></p></TD>
	<cfinvoke component="#Application.WebSitePath#.utilities.membersSQL" 
		method="GetMemberPhone" returnvariable="MemberPhone">
		<cfinvokeargument name="MemberID" value="#memberid#">
		<cfinvokeargument name="PhoneTypeID" value="1">
	</cfinvoke>
    <TD><p>#MemberPhone.PhoneNumber#</p></TD>
	<cfinvoke component="#Application.WebSitePath#.Utilities.membersSQL" 
		method="GetFieldValue" returnvariable="TypeName">
		<cfinvokeargument name="ThisFileName" value="subscriptiontype">
		<cfinvokeargument name="FieldName" value="SUBDESCRIPTION">
		<cfinvokeargument name="IDFieldName" value="subTypeID">
		<cfinvokeargument name="IDFieldValue" value="#Members.subtypeID#">
	</cfinvoke>
    <TD><p><cfif isnumeric(members.subtypeID)>#int(Members.subtypeID)# - </cfif>#TypeName#</p></TD>
    <cfif #Active# is 1>
	<td><p>YES</p></td>
	<cfelse>
    <TD><p>No</p></TD>
	</cfif>
	
	<td nowrap><a href= "adminheader.cfm?MemberID=#MemberID#&MemberAction=edit&Action=membersedit&LID=#LID#&TypeID=#subtypeID#&alphabet=#Alphabet#">Edit</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:confirmDelete('adminheader.cfm?MemberID=#MemberID#&MemberAction=delete&Action=#action#&LID=#LID#&TypeID=#subtypeID#&alphabet=#Alphabet#')">Delete</a>
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?MemberID=#MemberID#&&MemberAction=delete&Action=#action#&LID=#LID#&TypeID=#subtypeID#&alphabet=#Alphabet#">Profile</a><br><a href="adminheader.cfm?MemberID=#MemberID#&&MemberAction=delete&Action=#action#&LID=#LID#&TypeID=#subtypeID#&alphabet=#Alphabet#">Affiliate Referrals</a>
</td><td>
<form action="../scripts/signinlogic.cfm" method="Post">
<input type="hidden" name="action" value="#action#">
<input type="hidden" name="pword" value="#trim(password)#">
<input type="hidden" name="uName" value="#trim(logon)#">
<Input type="submit" name="submit" value="Login" style="font-size: 8pt;">
</form>
</td>
	</tr></CFOUTPUT>
		
</TABLE>

