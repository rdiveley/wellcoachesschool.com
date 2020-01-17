<cfinclude template="surveyGizmoAPIs/getUser.cfm">
<cfoutput>
<table  style="font-size: 16px; font-family:verdana,Arial,Helvetica,sans-serif; border:none; width:600px;color: ##555" >

	<tr>
		<td>
               <strong>Number</strong>
               <br />
               #certNo#
          </td>
	</tr>
	<tr>
		<td>
          	<strong>Designation</strong>
               <br />
          	#certDesignation#
          </td>
	</tr>
	<tr>
		<td>
               <strong>Name on formal Certificates</strong>
               <br />
               #nameAppears#
          </td>
	</tr>
     <cfif len(certStartDate)>
     <tr>
		<td>
               <strong>Start Date</strong>
               <br  />
               #certStartDate#
          </td>
	</tr>
     </cfif>
     <!---if not '' and not same as start show--->
     <cfif len(renewedDate) AND renewedDate NEQ certStartDate>
          <tr>
               <td><strong>Certification Renewed Date</strong><br />
               #renewedDate#
               </td>
          </tr>
     </cfif>
     <cfif len(REcertEndDate)>
	<tr>
		<td>
          	<strong>Expiration Date</strong><br />
               #REcertEndDate#
		</td>
	</tr>
     </cfif>
     <cfif len(certInactive)>
          <tr>
               <td><strong>Inactive Date</strong><br />
                    #certInactive#
               </td>

          </tr>
     </cfif>
     <cfif len(certInvalid)>
          <tr>
               <td><strong>Invalid Date</strong><br />
               #certInvalid#
               </td>
          </tr>
     </cfif>
	<tr>
		<td><strong>CCEH for Current Period</strong><br />
          	<cfif len(previousPeriod)>
				#previousPeriod#
			<cfelse>
				See Completed Survey’s page
			</cfif>
		</td>
	</tr>
     <tr>
		<td><strong>Opted out of Recertification because</strong><br />
			<cfif optedOut does not contain 'select'>#optedOut#</cfif>
          </td>

	</tr>
</table>
</cfoutput>