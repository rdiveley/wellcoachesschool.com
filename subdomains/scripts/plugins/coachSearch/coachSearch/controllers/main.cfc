<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

		Document:	/public/controllers/main.cfc
		Author:		Steve Withington | www.stephenwithington.com

--->
<cfcomponent extends="controller" output="false">

	<!--- ********************************* PAGES ******************************************* --->

	<cffunction name="default" output="false" returntype="any">
		<cfargument name="rc" required="true" />
        <cfparam name="rc.coachLname" default="" />
        <cfparam name="rc.coachState" default="" />
		<cfparam name="rc.coachCountry" default="" />
        <cfparam name="rc.coachZip" default="" />

      	<cfquery name="rc.getCoachesState" datasource="coachMarketing">
        	select
             city
            ,state
            ,zipcode
            from [marketingcontent]
            order by state
        </cfquery>

		<cfquery name="rc.getCoachesCountry" datasource="coachMarketing" result="local.results">
        	select
             country
           from [coachmarketing].[dbo].[marketingcontent]
			where country is not null
            order by country
        </cfquery>

		<cfquery name="rc.getCountries" datasource="coachMarketing">
        	select
             [countryName]
            from country
        </cfquery>

        <cfquery name="rc.getCoachesZip" datasource="coachMarketing">
        	select
             city
            ,state
            ,zipcode
            from [marketingcontent]
            order by zipcode
        </cfquery>

		<cfquery name="rc.getLicenses" datasource="coachMarketing">
				select
					licenseId,
					license
				 from licenses
				 order by license
			</cfquery>

			<cfquery name="rc.getEducation" datasource="coachMarketing">
				select
					educationId
					,education
				 from education
				order by education
			</cfquery>

			<cfquery name="rc.getcoachCertifications" datasource="coachMarketing">
				select
				coachCertificationId
				,certification
				from coachCertification
				order by certification desc
			</cfquery>

			<cfquery name="rc.getcoachingSpecialties" datasource="coachMarketing">
				select
				coachingspecialtyId
				,specialty
				from coachingSpecialties
				order by specialty
			</cfquery>

			<cfquery name="rc.getcoachingMethods" datasource="coachMarketing">
				select
				coachingMethodId
				,methods
				 from coachingMethods
				order by methods
			</cfquery>

			<cfquery name="rc.getCoachingRate" datasource="coachMarketing">
				select
				coachingRateId
				,rate
				from coachingRate
			</cfquery>

	</cffunction>

    <cffunction name="getCoaches" access="public" returntype="query" >

    	<cfquery name="getCoaches" datasource="coachMarketing" cachedwithin="#CreateTimeSpan(0, 0, 0, 0)#" result="rc.results">
        	select distinct
            t.filename
            ,u.fname
            ,u.lname
            ,u.userName
            ,m.zipcode
			,m.licenses
		  	,m.education
		  	,m.certification
		  	,m.specialties
		  	,m.coachingmethods
		  	,m.rate
            from [coachmarketing].[dbo].[tcontent] t
            inner join [coachmarketing].[dbo].[marketingcontent] m on m.user_id = t.remoteID
            inner join [coachmarketing].[dbo].[tusers] u on u.userID = m.user_id
			where  t.active = <cfqueryparam value="1">
			and t.approved = <cfqueryparam value="1">
            <cfif len(trim(rc.coachLname))>
            	AND u.lname like <cfqueryparam value="%#rc.coachLname#%">
            </cfif>
            <cfif len(trim(rc.coachState))>
           	 	AND  m.state like <cfqueryparam value="%#rc.coachState#%">
            </cfif>
			<cfif len(trim(rc.coachCountry)) AND rc.coachCountry NEQ 'United States'>
           	 	AND  m.country = <cfqueryparam value="#rc.coachCountry#">
			<cfelseif len(trim(rc.coachCountry))>
				AND  (m.country IS NULL OR m.country = <cfqueryparam value="#rc.coachCountry#">)
            </cfif>
            <cfif len(trim(rc.coachZip))>
            	AND	m.zipcode = <cfqueryparam value="#rc.coachZip#">
            </cfif>
			<cfif structKeyExists(rc,'licenses') AND len(trim(rc.licenses))>
				AND
				<cfloop list="#rc.licenses#" index="local.lic">
					(m.licenses like '%#local.lic#%' )<cfif listlast(rc.licenses) NEQ local.lic> OR</cfif>
				</cfloop>
			</cfif>
			<cfif structKeyExists(rc,'education') AND len(trim(rc.education))>
				AND
				<cfloop list="#rc.education#" index="local.edu">
					(m.education like '%#local.edu#%')<cfif listlast(rc.education) NEQ local.edu> OR</cfif>
				</cfloop>
			</cfif>
			<cfif structKeyExists(rc,'certification') AND len(trim(rc.certification))>
				AND
				<cfloop list="#rc.certification#" index="local.cert">
					 (m.certification like '%#local.cert#%')<cfif listlast(rc.certification) NEQ local.cert> OR</cfif>
				</cfloop>
			</cfif>
			<cfif structKeyExists(rc,'specialties') AND len(trim(rc.specialties))>
				AND
				<cfloop list="#rc.specialties#" index="local.spec">
					 (m.specialties like '%#local.spec#%')<cfif listlast(rc.specialties) NEQ local.spec> OR</cfif>
				</cfloop>
			</cfif>
			<cfif structKeyExists(rc,'coachingMethods') AND len(trim(rc.coachingMethods))>
				AND
				<cfloop list="#rc.coachingMethods#" index="local.methods">
					 (m.coachingmethods like '%#local.methods#%')<cfif listlast(rc.coachingMethods) NEQ local.methods> OR</cfif>
				</cfloop>
			</cfif>
			<cfif structKeyExists(rc,'rate') AND len(trim(rc.rate))>
				AND
				<cfloop list="#rc.rate#" index="local.rate">
					( m.rate like '%#local.rate#%')<cfif listlast(rc.rate) NEQ local.rate> OR</cfif>
				</cfloop>
			</cfif>
        </cfquery>
		<cfset variables.fw.setView('main.coachSearchResults')/>
		<cfset rc.getCoaches = getCoaches />
        <cfreturn rc.getCoaches  />
    </cffunction>

</cfcomponent>