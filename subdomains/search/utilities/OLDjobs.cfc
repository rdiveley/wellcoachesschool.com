<cfcomponent>

	<cffunction name="GetJobCategoryName" access="remote" returntype="string" output="true">
		<cfargument name="JobJobcategoryid" default="" required="true" type="numeric">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="JobCategories">
			<cfinvokeargument name="FieldName" value="JobCategoryname">
			<cfinvokeargument name="IDFieldName" value="JobJobcategoryid">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.Jobcategoryid#">
		</cfinvoke>
		<cfreturn Fieldname>
	</cffunction>

	<cffunction name="GetJobNamebyInvoiceInstructions" access="remote" returntype="string" output="true">
		<cfargument name="InvoiceInstructions" default="" required="true" type="string">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetFieldValue" returnvariable="JobName">
			<cfinvokeargument name="TableName" value="JobCategories">
			<cfinvokeargument name="FieldName" value="JobCategoryname">
			<cfinvokeargument name="IDFieldName" value="InvoiceInstructions">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.InvoiceInstructions#">
		</cfinvoke>

		<cfreturn JobName>

	</cffunction>

  	<cffunction access="remote" name="GetHotJobs" output="true" returntype="query">
		<cfset dateExpired= dateformat(DateAdd("d", -46, Now()),"yyyy/mm/dd")>
		<cfset WhereStatement="where  datecreated > '#dateExpired#'">
		<cfset WhereStatement="#WhereStatement# and (hotJob='1' or hotJob='0000000001') and (status='1' or status='Active')">
		<cfset OrderByStatement="order by datecreated desc">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetHotJobs">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#"/>
		  	<cfinvokeargument name="OrderByStatement" value="#OrderByStatement#">
		</cfinvoke>

		<cfreturn GetHotJobs>
  	</cffunction>
	
	<cffunction access="remote" name="GetCurrentJobs" output="true" returntype="query">
		<cfset dateExpired= dateformat(DateAdd("d", -46, Now()),"yyyy/mm/dd")>
		<cfset WhereStatement="where  datecreated > '#dateExpired#'">
		<cfset WhereStatement="#WhereStatement# and  status='1'">
		<cfset OrderByStatement="order by datecreated desc">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetHotJobs">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#"/>
		  	<cfinvokeargument name="OrderByStatement" value="#OrderByStatement#">
		</cfinvoke>

		<cfreturn GetHotJobs>
  	</cffunction>
  
  	<cffunction access="remote" name="GetJobDetails" output="true" returntype="query">
		<cfargument name="JobID" type="string" required="true" default="0">

		<cfset OrderByStatement=" order by Employerid,status">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetJob">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="IDFieldName" value="JobID">
			<cfinvokeargument name="IDFieldValue" value="#JobID#">
		</cfinvoke>
		<cfreturn GetJob>
  	</cffunction>
  
  	<cffunction access="remote" name="GetImage" output="true" returntype="string">
  		<cfargument name="TheImage" type="numeric" required="true" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" method="GetFieldValue" returnvariable="Fieldname">
			<cfinvokeargument name="TableName" value="Jobimages">
			<cfinvokeargument name="FieldName" value="imagename">
			<cfinvokeargument name="IDFieldName" value="imageid">
			<cfinvokeargument name="IDFieldVAlue" value="#Arguments.theimage#">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.AdminUtilities" method="InitWebSite" 
			returnvariable="InitWebSiteRet" />
		<cfset UploadPath=#InitWebSiteRet[1][5]#>
		<cfset ReturnPath=#InitWebSiteRet[1][4]#>
		
		<cfset ImageID=''>
		<cfset ImageIs=''>
		<cfset CatalogPath="catalog">
		<cfif #Fieldname# neq ''>
			<cfset qImage=#Fieldname#>
			<cfoutput>#uploadpath#\#CatalogPath#\images\#trim(qImage)#</cfoutput>
			<cfif FileExists("#uploadpath#\#CatalogPath#\images\#trim(qImage)#")>
				<cfset ImageIs="#CatalogPath#/images/#trim(qImage)#">
			<cfelse>
				<cfset qImage = "#trim(qImage)#.jpg">
				<cfif FileExists("#uploadpath#\#CatalogPath#\images\#trim(qImage)#")>
					<cfset ImageIs="#CatalogPath#/images/#trim(qImage)#">
				</cfif>
			</cfif>
		</cfif>
  		<cfreturn ImageIs>
  	</cffunction>
	
	<cffunction access="remote" name="GetCategories" output="true" returntype="query">
		<cfargument name="JobJobcategoryid" default=0 type="numeric" required="false">
		
		<Cfif #Arguments.JobJobcategoryid# neq 0>
			  <cfset WhereStatement=" Where Jobcategoryid=#arguments.Jobcategoryid# order by JobCategoryName">
		<cfelse>
			<cfset WhereStatement=" order by JobCategoryName">
		</cfif>
			
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="JobCategories">
			<cfinvokeargument name="SelectStatement" value="#WhereStatement#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  	</cffunction>
  
  	<cffunction access="remote" name="GetJobsbyInvoiceInstructions" output="true" returntype="query">
		<cfargument name="InvoiceInstructions" default=0 type="string" required="false">	
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="GetRecordsRet">
		  	<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Jobs">
		  <Cfif #Arguments.InvoiceInstructions# neq 0>
			<cfset InvoiceInstructions=#Arguments.InvoiceInstructions#>
			  <cfinvokeargument name="SelectStatement" value=" where InvoiceInstructions='#Trim(InvoiceInstructions)#'"/>
		  </cfif>
		  <cfinvokeargument name="OrderByStatement" value=" order by JobName">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  	</cffunction>
  
  	<cffunction access="remote" name="GetJobBoardConfiguration" output="true" returntype="array">
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler" 
			method="GetXMLRecords" returnvariable="JobBoardConfig">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="JobBoardConfig">
			<cfinvokeargument name="IDFieldName" value="JobConfigID">
			<cfinvokeargument name="IDFieldValue" value="0000000001">
		</cfinvoke>
		<cfreturn JobBoardConfig>
  	</cffunction>
  
  	<cffunction access="remote" name="GetCatalogItems" output="true" returntype="query">
		<cfargument name="JobJobcategoryid" default="0" required="true" type="string">

		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler"   
			method="GetXMLRecords"  returnvariable="GetAllJobs">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="OrderbyStatement" value="Order by JobName">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.#Application.UtilitiesPath#.XMLHandler"   
			method="GetXMLRecords"  returnvariable="GetAllCategories">
			<cfinvokeargument name="ThisPath" value="#application.TheFilesPath#">
			<cfinvokeargument name="ThisFileName" value="JobCategories">
			<cfinvokeargument name="OrderbyStatement" value="Order by JobCategoryName">
		</cfinvoke>
		<cfquery name="SelectSubCategories" dbtype="query">
			select * from GetAllCategories
			where parentcatid='#arguments.JobJobcategoryid#'
		</cfquery>
		<cfset SelectStatement=''>
		<cfif #selectSubCategories.recordcount# gt 0>
			<cfoutput query="SelectSubCategories">
				<cfset SelectStatement="#SelectStatement#  or JobJobcategoryid='#SelectSubCategories.JobJobcategoryid#'">
			</cfoutput>
		</cfif>
		<cfquery name="GetCatalogueItems" dbtype="query">
			select * from GetAllJobs
			where JobJobcategoryid='#arguments.JobJobcategoryid#' 
			<cfif #Selectstatement# neq ''>
			#preservesinglequotes(selectstatement)#
			order by JobJobcategoryid, Jobname
			<cfelse>
			order by Jobname
			</cfif>
			
		</cfquery>
		
		<cfreturn GetCatalog>
  	</cffunction>
	
	<cffunction access="remote" name="AddToFavorites" output="true">
		<cfargument name="ProdIDs" default="0" type="string" required="true">

		<cfset Today=dateformat(now(),"mm/dd/yyyy")>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="JobFavorites">
			<cfinvokeargument name="XMLFields" value="JobID,EmployeeID,DateCreated">
			<cfinvokeargument name="XMLFieldData" 	
				value="#arguments.ProdIDs#,#session.EmployeeID#,#Today#">
			<cfinvokeargument name="XMLIDField" value="FavoriteID">
		</cfinvoke>
	
 	</cffunction>
	
	<cffunction access="remote" name="GetFavorites" output="true">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="IDFieldName" value="EmployeeID">
			<cfinvokeargument name="IDFieldValue" value="#session.EmployeeID#">
		</cfinvoke>
	
 	</cffunction>
	
	<cffunction access="remote" name="DeleteFavorites" output="true">
		<cfargument name="FavoriteID" required="true" type="string" default="0">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Favorites">
			<cfinvokeargument name="XMLIDField" value="FavoriteID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.FavoriteID#">
		</cfinvoke>
	
 	</cffunction>
	
	<cffunction name="JobsAdmin" access="remote" returntype="string" output="true">
		<cfargument name="alphabet" required="true" type="string" default="a">
		<cfargument name="JobAction" required="true" type="string" default="List">

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
			<cfinvokeargument name="FileName" value="Jobs">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="selectstatement" value=" where jobtitle like '#alphabet#%'">
		</cfinvoke>

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllCategories">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="JobCategories">
			
		</cfinvoke>
	

		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllEmployers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Employers">
			<cfinvokeargument name="orderbystatement" value=" order by companyname asc">
		</cfinvoke>

		<cfparam name="searchDescription" default="">
		<cfparam name="searchEmployer" default=''>
		<cfparam name="searchCategory" default=''>
		<cfparam name="searchState" default=''>
		<cfparam name="JobID" default=0>
		<cfparam name="JobAction" default="List">
		<cfparam name="JobTitle" default="">
		<cfparam name="JobDescription" default="">
		<cfparam name="DateCreated" default="#now()#">
		<cfparam name="JobType" default="0">
		<cfparam name="JobImage" default="">
		<cfparam name="StateID" default=0>
		<cfparam name="tStateID" default=0>
		<cfparam name="LocationCity" default=0>
		<cfparam name="ContactName" default=0>
		<cfparam name="ContactAddress" default=0>
		<cfparam name="ContactCity" default=0>
		<cfparam name="Jobcategoryid" default="0">
		<cfparam name="ContactState" default=0>
		<cfparam name="InvoiceInstructions" default="">
		<cfparam name="ContactInstructions" default="">
		<cfparam name="JobStarts" default="#now()#">
		<cfparam name="JobEnds" default="#dateadd('y',1,now())#">
		<cfparam name="HotJob" default=0>
		<cfparam name="ContactZip" default=0>
		<cfparam name="ContactPhone" default=0>
		<cfparam name="ContactFax" default=0>
		<cfparam name="ContactEmail" default=0>
		<cfparam name="JobPay" default=0>
		<cfparam name="PayByInvoice" default = 0>
		<cfset tPayByInvoice=#PayByInvoice#>
		<cfparam name="Status" default=0>
		<cfparam name="EmployerID" default=0>
		<cfparam name="tEmployerID" default=0>
		<cfparam name="JobDetails" default="">
		<cfparam name="JobPayPer" default=0>
		
		<cfif JobAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Jobs">
				<cfinvokeargument name="XMLFields" value="JobID,JobDescription,JobTitle,DateCreated,JobType,JobImage,StateID,ContactState,LocationCity,ContactName,ContactAddress,Jobcategoryid,ContactCity,InvoiceInstructions,ContactInstructions,JobStarts,JobEnds,HotJob,ContactZip,ContactPhone,ContactFax,ContactEmail,JobPay,PayByInvoice,Status,EmployerID,JobDetails,JobPayPer">
				ACCOUNT_TYPE BILLING_NAME INVOICE_ADDRESS STATE   
				<cfinvokeargument name="XMLIDField" value="JobID">
				<cfinvokeargument name="XMLIDValue" value="#JobID#">
			</cfinvoke>
			<cfset JobID=0>
			<cfset JobAction="List">
		</cfif>
				
		<cfif JobAction is "Edit">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="Jobs">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="Jobs">
				<cfinvokeargument name="IDFieldName" value="JobID">
				<cfinvokeargument name="IDFieldValue" value="#JobID#">
			</cfinvoke>
			<cfoutput query="Jobs">
				<cfset JobTitle=#replace(JobTitle,"~",",","ALL")#>
				<cfset DateCreated=#DateCreated#>
				<cfset tJobDescription=#JobDescription#>
				<cfset JobDescription=replace(#tJobDescription#,"~",",","ALL")>
				<cfset JobType=#JobType#>
				<cfset JobImage=#JobImage#>
				<cfset StateID=#StateID#>
				<cfset tStateID=#StateID#>
				<cfset LocationCity=#LocationCity#>
				<cfset ContactName=#ContactName#>
				<cfset ContactAddress=#ContactAddress#>
				<cfset ContactCity=#ContactCity#>
				<cfset Jobcategoryid=#replace(Jobcategoryid,"~",",","ALL")#>
				<cfset ContactState=#ContactState#>
				<cfset InvoiceInstructions=#InvoiceInstructions#>
				<cfset ContactInstructions=#ContactInstructions#>
				<cfset JobStarts=#JobStarts#>
				<cfset JobEnds=#JobEnds#>
				<cfset HotJob=#HotJob#>
				<cfset ContactZip=#ContactZip#>
				<cfset ContactPhone=#ContactPhone#>
				<cfset ContactFax=#ContactFax#>
				<cfset ContactEmail=#ContactEmail#>
				<cfset JobPay=#JobPay#>
				<cfset tPayByInvoice=#replace(PayByInvoice,"~",",","ALL")#>
				<cfset Status=#Status#>
				<cfset EmployerID=#EmployerID#>
				<cfset tEmployerId=#EmployerID#>
				<cfset tJobDetails=#JobDetails#>
				<cfset JobDetails=replace(#tJobDetails#,"~",",","ALL")>
				<cfset JobPayPer=#JobPayPer#>
			</cfoutput>
			<cfset JobAction="Update">
		</cfif>
		
		<cfif isDefined('form.submit')>
			<cfif #form.image# neq ''>
				<cfset #curPath# = GetTemplatePath()>
				<cfset #curDirectory# = "#Application.UploadPath#\images\Jobs\">
				
				<cf_FileUpload
					directory="#curDirectory#"
					weight="100"
					nameofimages="image"
					nameConflict="overwrite"
					accept="image/*"
					default="na">
				<cfset Form.JobImage="images/Jobs/#image#">
			</cfif>
			<cfif #form.JobImage# is ''><cfset form.JobImage="none"></cfif>
			<cfif #isdate(form.datecreated)#>
				<cfset form.datecreated=dateformat(form.datecreated,"yyyy/mm/dd")>
			</cfif>
			<cfif #isdate(form.JobEnds)#>
				<cfset form.JobEnds=dateformat(form.JobEnds,"yyyy/mm/dd")></cfif>
			<cfif #isdate(form.JobStarts)#>
				<cfset form.JobStarts=dateformat(form.JobStarts,"yyyy/mm/dd")></cfif>
			<cfif #form.JobEnds# is ''><cfset form.JobEnds="none"></cfif>
			<cfif #form.JobStarts# is ''><cfset form.JobStarts="none"></cfif>
			<cfif #form.JobDescription# is ''><cfset form.JobDescription="none"></cfif>
			<cfset form.JobDescription=replace(#form.JobDescription#,",","~","ALL")>
			<cfif #form.JobTitle# is ''><cfset form.JobTitle="none"></cfif>
			<cfset form.JobTitle=replace(#form.JobTitle#,",","~","ALL")>
			
			<cfif not isdefined('form.LocationCity')><cfset form.LocationCity="0"></cfif>
			<cfif not isdefined('form.ContactName')><cfset form.ContactName="0"></cfif>
			<cfif not isdefined('form.ContactAddress')><cfset form.ContactAddress="0"></cfif>
			<cfif not isdefined('form.StateID')><cfset form.StateID="0"></cfif>
			<cfif not isdefined('form.ContactState')><cfset form.ContactState="0"></cfif>
			<cfif not isdefined('form.PayByInvoice')><cfset form.PayByInvoice="No"></cfif>
			
			<cfset form.LocationCity=replace(#form.LocationCity#,",","~","ALL")>
			<cfset form.ContactName=replace(#form.ContactName#,",","~","ALL")>
			<cfset form.ContactAddress=replace(#form.ContactAddress#,",","~","ALL")>
			<cfset form.StateID=replace(#form.StateID#,",","~","ALL")>
			<cfset form.ContactState=replace(#form.ContactState#,",","~","ALL")>
			<cfset form.ContactCity=replace(#form.ContactCity#,",","~","ALL")>
			
			<cfif #trim(form.ContactCity)# is ""><cfset form.ContactCity=0></cfif>
			<cfif #trim(form.ContactAddress)# is ""><cfset form.ContactAddress=0></cfif>
			<cfif #trim(form.ContactFax)# is ""><cfset form.ContactFax=0></cfif>
			<cfif #trim(form.ContactZip)# is ""><cfset form.ContactZip=0></cfif>
			<cfif #trim(form.ContactEmail)# is ""><cfset form.ContactEmail=0></cfif>
			<cfif #trim(form.JobPayPer)# is ""><cfset form.JobPayPer=0></cfif>
			<cfif #trim(form.JobPay)# is ""><cfset form.JobPay=0></cfif>
			<cfif #trim(form.ContactPhone)# is ""><cfset form.ContactPhone=0></cfif>
			<cfif #form.JobDetails# is ''><cfset form.JobDetails="none"></cfif>
			<cfset form.JobDetails=replace(#form.JobDetails#,",","~","ALL")>
			<cfif #form.ContactInstructions# is ''><cfset form.ContactInstructions="none"></cfif>
			<cfif #form.InvoiceInstructions# is ''><cfset form.InvoiceInstructions="none"></cfif>
			<cfset form.JobCategoryID=replace(#form.JobCategoryID#,",","~","ALL")>
			
			<cfset form.ContactCity=replace(#form.ContactCity#,",","~","ALL")>
			<cfset form.ContactInstructions=replace(#form.ContactInstructions#,",","~","ALL")>
			<cfset form.InvoiceInstructions=replace(#form.InvoiceInstructions#,",","~","ALL")>
			<cfset form.ContactZip=replace(#form.ContactZip#,",","~","ALL")>
			<cfset form.ContactFax=replace(#form.ContactFax#,",","~","ALL")>
			<cfset form.ContactPhone=replace(#form.ContactPhone#,",","~","ALL")>
			
			<cfif #JobAction# is "Update">
				<cfif #form.Datecreated# is ""><cfset form.datecreated=dateformat(now(),"yyyy/mm/dd")></cfif>

				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="Jobs">
					<cfinvokeargument name="XMLFields" value="JobDescription,JobTitle,DateCreated,JobType,JobImage,StateID,ContactState,LocationCity,ContactName,ContactAddress,Jobcategoryid,ContactCity,InvoiceInstructions,ContactInstructions,JobStarts,JobEnds,HotJob,ContactZip,ContactPhone,ContactFax,ContactEmail,JobPay,PayByInvoice,Status,employerID,JobDetails,JobPayPer">

					<cfinvokeargument name="XMLFieldData" value="#form.JobDescription#,#form.JobTitle#,#form.DateCreated#,#form.JobType#,#form.JobImage#,#form.StateID#,#form.ContactState#,#form.LocationCity#,#form.ContactName#,#form.ContactAddress#,#form.Jobcategoryid#,#form.ContactCity#,#form.InvoiceInstructions#,#form.ContactInstructions#,#form.JobStarts#,#form.JobEnds#,#form.HotJob#,#form.ContactZip#,#form.ContactPhone#,#form.ContactFax#,#form.ContactEmail#,#form.JobPay#,#form.PayByInvoice#,#form.Status#,#form.EmployerID#,#form.JobDetails#,#form.JobPayPer#">
					<cfinvokeargument name="XMLIDField" value="JobID">
					<cfinvokeargument name="XMLIDValue" value="#JobID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="Jobs">
					<cfinvokeargument name="XMLFields" value="JobDescription,JobTitle,DateCreated,JobType,JobImage,StateID,ContactState,LocationCity,ContactName,ContactAddress,Jobcategoryid,ContactCity,InvoiceInstructions,ContactInstructions,JobStarts,JobEnds,HotJob,ContactZip,ContactPhone,ContactFax,ContactEmail,JobPay,PayByInvoice,Status,employerID,JobDetails,JobPayPer">
					<cfinvokeargument name="XMLFieldData" value="#form.JobDescription#,#form.JobTitle#,#form.DateCreated#,#form.JobType#,#form.JobImage#,#form.StateID#,#form.ContactState#,#form.LocationCity#,#form.ContactName#,#form.ContactAddress#,#form.Jobcategoryid#,#form.ContactCity#,#form.InvoiceInstructions#,#form.ContactInstructions#,#form.JobStarts#,#form.JobEnds#,#form.HotJob#,#form.ContactZip#,#form.ContactPhone#,#form.ContactFax#,#form.ContactEmail#,#form.JobPay#,#form.PayByInvoice#,#form.Status#,#form.EmployerID#,#form.JobDetails#,#form.JobPayPer#">
					<cfinvokeargument name="XMLIDField" value="JobID">
				</cfinvoke>
			</cfif>
			
			<cfif isdefined('form.promotional')>
			<cf_ecMListExternal
				email=#form.ContactEmail#
				name=#form.contactname#
				AR=84169
				>
			</cfif>
			
			<cfset JobAction="list">
			<cfset JobTitle="">
			<cfset DateCreated = #now()#>
			<cfset JobID = 0>
			<cfset JobDescription=''>
			<cfset JobTitle=#JobTitle#>
			<cfset JobType='0'>
			<cfset JobImage=''>
			<cfset StateID = 0>
			<cfset LocationCity = 0>
			<cfset ContactName = 0>
			<cfset ContactAddress = 0>
			<cfset ContactCity = 0>
			<cfset Jobcategoryid = 0>
			<cfset ContactState = 0>
			<cfset InvoiceInstructions=''>
			<cfset ContactInstructions=''>
			<cfset JobStarts=''>
			<cfset JobEnds=''>
			<cfset HotJob = 0>
			<cfset ContactZip = 0>
			<cfset ContactPhone = 0>
			<cfset ContactFax = 0>
			<cfset ContactEmail = 0>
			<cfset JobPay = 0>
			<cfset PayByInvoice = 0>
			<cfset tPayByInvoice=#PayByInvoice#>
			<cfset Status = 0>
			<cfset EmployerID = 0>
			<cfset tEmployerId=0>
			<cfset JobDetails=''>
			<cfset JobPayPer = 0>
		</cfif>
	
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllTheJobs">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Jobs">
			<cfinvokeargument name="OrderByStatement" value=" order by JobTitle">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllStates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="states">
		</cfinvoke>
		
		<cfif isdefined('url.alphabet')><cfset alphabet=#url.alphabet#></cfif>
		<cfif isdefined('form.alphabet')><cfset alphabet=#form.alphabet#></cfif>
		
		<cfquery name="AllJobs" dbtype="query">
			select * from AllTheJobs 
			<Cfif #Alphabet# neq "all" and #SearchDescription# is "">
			where (JobTitle like '#ucase(left(alphabet,1))#%' 
			or JobTitle like '#lcase(left(alphabet,1))#%')
			<cfelseif #SearchDescription# neq "">
			where JobTitle like '%#SearchDescription#%' or JobDescription like '%#ucase(searchDescription)#%'
			<cfelseif #SearchEmployer# neq "">
			where employerid = '#trim(SearchEmployer)#'
			<cfelseif #Searchstate# neq "">
			where stateid = '#trim(Searchstate)#'
			<cfelseif #Searchcategory# neq "">
			where jobcategoryid = '#trim(Searchcategory)#'
			</cfif>
			<cfif #Alphabet# is "all">
			order by datecreated desc
			</cfif>
		</cfquery>
		
		<cfoutput>
		<h1>Jobs</h1>
		<cfoutput><a href= "adminheader.cfm?JobAction=Add&action=#action#">Add A New Job</a></cfoutput>
		<cfif JobAction is "Update" or #JobAction# is "Add">
		<cfform action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post" name="thisform">
		<input type="hidden" name="JobID" value="#JobID#">
		<input type="hidden" name="Action" value="#Action#">
		<input type="hidden" name="JobAction" value="#JobAction#">
		<cfset tJobImage=replace(#JobImage#,"images/","images/Jobs/")>
		<cfset tJobImage=replace(#JobImage#,"p/","images/Jobs/")>
		<input type="hidden" name="JobImage" value="#tJobImage#">
		<input type="hidden" name="alphabet" value="#alphabet#">
		<TABLE>
			<tr><td>Date Posted:</td><td><cfinput name="DateCreated" type="text" value="#dateformat(DateCreated,'mm/dd/yyyy')#" required="yes" message="Please enter a date created" validate="date"></td></tr>
			<TR>
			<TD valign="top"> Job Title: </TD>
			<TD>
			
				<INPUT type="text" name="JobTitle" value="#JobTitle#" size=40 >
				
			</TD>
			<TD valign="top"> Upload Job Image: </TD>
			<TD>
				<input type="file" name="image"><br><strong>#replacenocase(JobImage,"images/Jobs/","")#</strong>
		
				
			</TD>
			<!--- field validation --->
			</TR>
			<TR>
			<TD valign="top"> Contact Instructions: </TD>
			<TD valign=top>
			
				<textarea  name="ContactInstructions" cols=35 rows="5">#replace(ContactInstructions,"~",",","ALL")#</textarea>
				
			</TD>
			<TD valign="top"> Invoicing Instructions: </TD>
			<TD>
			
				<textarea name="InvoiceInstructions" cols=35 rows="5">#replace(InvoiceInstructions,"~",",","ALL")#</textarea>
				
			</TD>
			</TR>
			<tr>
			
			<td valign=top> Job Pay </td>
			<td><input type="text" value="#JobPay#" name="JobPay"></td>
			<td valign=top> This Job Pays Per</td>
			<td><select name="JobPayPer">
					<option value="day"<cfif #JobPayPer# is "day"> selected</cfif>>Day</option>
					<option value="week"<cfif #JobPayPer# is "week"> selected</cfif>>Week</option>
					<option value="semimonth"<cfif #JobPayPer# is "semimonth"> selected</cfif>>Semi-Monthly</option>
					<option value="twoweeks"<cfif #JobPayPer# is "twoweeks"> selected</cfif>>Two Weeks</option>
					<option value="month"<cfif #JobPayPer# is "month"> selected</cfif>>Monthly</option>
				</select>
			</td>
			</tr>
			
			<tr>
			<td valign=top> Job Type </td>
			<td><input type="text" value="#JobType#" name="JobType"></td>
			<td valign=top> Is This Item HotJob? </td>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="employerTypes">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="employerTypes">
				<cfinvokeargument name="orderbystatement" value=" order by typeprice">
			</cfinvoke>
			<td><select name="HotJob">
				<cfloop query="employerTypes">
				<option value="#employerTypeID#" <cfif #HotJob# is #employerTypeID#>selected</cfif>>#TypeName#
				</cfloop>
				</select></td>
			</tr>
			
			<tr>
			<td valign=top> Job Starts: </td>
			<cfif isdate(jobstarts)>
				<td><input type="text" value="#dateformat(JobStarts,'mm/dd/yyyy')#" name="JobStarts"> (i.e. mm/dd/yyyy)</td>
			<cfelse>
				<td><input type="text" value="#JobStarts#" name="JobStarts"> (i.e. mm/dd/yyyy)</td>
			</cfif>
			<td valign=top> Job Ends: </td>
			<cfif isdate(jobends)>
			<td><input type="text" value="#dateformat(JobEnds,'mm/dd/yyyy')#" name="JobEnds"> (i.e. mm/dd/yyyy)</td>
			<cfelse>
			<td><input type="text" value="#JobEnds#" name="JobEnds"> (i.e. mm/dd/yyyy)</td>
			</cfif>
			</tr>
		
			<tr>
			<td valign=top> Contact Email </td>
			<td><input type="text" name="ContactEmail" value="#ContactEmail#"></td>
			<td valign=top> Contact Postal Code </td>
			<td><input type="text" value="#ContactZip#" name="ContactZip"></td>
			</tr>
			<tr>
			<td valign=top> Contact Fax Number </td>
			<td><input type="text" value="#ContactFax#" name="ContactFax"></td>
			<td valign=top> Contact Phone </td>
			<td><input type="text" value="#ContactPhone#" name="ContactPhone"></td>
			</tr>
			
			<tr>
			<td valign=top> Contact City </td>
			<td><input type="text" name="ContactCity" value="#contactCity#"></td>
			<td valign=top> Job Category </td>
			<td><select name="Jobcategoryid" multiple>
				<option value="0" <cfif #Jobcategoryid# is 0>selected</cfif>>None</option>
				<cfloop query="AllCAtegories">
					<option value="#AllCAtegories.categoryid#" <cfif #listfind(Jobcategoryid,AllCAtegories.categoryid)#>selected</cfif>>#CategoryName#</option>
				</cfloop>
			</select>
			</td>
			</tr>
			<tr>
			<td valign=top> Employer </td>
			<td><select name="EmployerID">
				<option value="0" <cfif #EmployerID# is 0>selected</cfif>>None</option>
				<cfloop query="AllEmployers">
					<option value="#AllEmployers.EmployerID#" <cfif #tEmployerID# is #AllEmployers.EmployerID#>selected</cfif>>#companyname#</option>
				</cfloop>
			</select>
			</td>
			<td valign=top> Status </td>
			<td><select name="Status">
					<option value="Active" <cfif #Status# is "Active" or #Status# is 1>selected</cfif>>Active</option>
					<option value="Pending" <cfif #Status# is "Pending" or #status# is 0>selected</cfif>>Pending</option>
			</select>
			</td>
			</tr>
		
			
			<tr>
			<td valign=top> Location City </td>
			<td><input type="text" name="LocationCity" value="#locationcity#"></td>
			<td valign=top> Contact Address </td>
			<td><textarea name="ContactAddress" cols=35 rows="5">#contactAddress#</textarea></td>
			</tr>
			
			<tr>
			<td valign=top> Job State </td>
			<td><select name="StateID" size="5" multiple>
				<cfloop query="AllStates">
					<option value="#AllStates.StateID#" <cfif #ListFind(tStateID,AllStates.StateID,"~")#>selected</cfif>>#stateName#</option>
				</cfloop>
				<OPTION value="999" <cfif #ListFind(tStateID,"999","~")#>selected</cfif>>Nationwide</OPTION> 
				<OPTION value="Australia" <cfif #ListFind(tStateID,"Australia","~")#>selected</cfif>>Australia</OPTION>
				<OPTION value="Canada" <cfif #ListFind(tStateID,"Canada","~")#>selected</cfif>>Canada</OPTION> 
				<OPTION value="United Kingdom" <cfif #ListFind(tStateID,"United Kingdom","~")#>selected</cfif>>United Kingdom</OPTION>
				<OPTION value="Other Countries" <cfif #ListFind(tStateID,"Other Countries","~")#>selected</cfif>>Other Countries</OPTION>
			</select>
			</td>
			<td valign=top> Contact Name </td>
			<td valign=top><input type="text" name="ContactName" value="#contactName#"></td>
			</tr>
			
			<tr>
			<td valign=top> Contact State </td>
			<td valign=top>
			<select name="contactstate">
				<cfloop query="AllStates">
					<option value="#AllStates.StateID#" <cfif #ListFind(contactstate,AllStates.StateID,"~")#>selected</cfif>>#stateName#</option>
				</cfloop>
				<OPTION value="999" <cfif #ListFind(contactstate,"999","~")#>selected</cfif>>Nationwide</OPTION> 
				<OPTION value="Australia" <cfif #ListFind(contactstate,"Australia","~")#>selected</cfif>>Australia</OPTION>
				<OPTION value="Canada" <cfif #ListFind(contactstate,"Canada","~")#>selected</cfif>>Canada</OPTION> 
				<OPTION value="United Kingdom" <cfif #ListFind(contactstate,"United Kingdom","~")#>selected</cfif>>United Kingdom</OPTION>
				<OPTION value="Other Countries" <cfif #ListFind(contactstate,"Other Countries","~")#>selected</cfif>>Other Countries</OPTION>
			</select>
			</td>
			<td valign=top> Pay By Invoice #tPayByInvoice#</td>
			<td><select name="PayByInvoice">
					<option value="Yes"<cfif #trim(tPayByInvoice)# is "Yes" or #tPayByInvoice# is 1> selected</cfif>>Yes</option>
					<option value="No"<cfif #trim(tPayByInvoice)# is "No" or #tPayByInvoice# is 0> selected</cfif>>No</option>
			</select>
			</td>
			</tr>
			
			<TR>
			<TD valign="top"> Company Information: </TD>
			<TD colspan=3>
			<a href="javascript:GetEditor('thisform','JobDescription')" class=box>Click here for the editor</a><br>
				<TEXTAREA name="JobDescription" cols=50 rows=5>#JobDescription#</TEXTAREA>
			
			</TD>
			<!--- field validation --->
			</TR>
				<TR>
			<TD valign="top"> Job Description, Requirements, Qualifications, or any other information pertinent to job: </TD>
			<TD colspan=3>
				<a href="javascript:GetEditor('thisform','JobDetails')" class=box>Click here for the editor</a><br>
				<TEXTAREA name="JobDetails" cols=100 rows=10>#JobDetails#</TEXTAREA>
			
			</TD>
			<!--- field validation --->
			</TR>
			<cfif JobAction is "add">
			<tr><td>Is this a promotional job listing?</td>
			<td><input type="checkbox" name="promotional" value="1"></td></tr>
			</cfif>
		</TABLE>
			
		<!--- form buttons --->
		<INPUT type="submit" name="submit" value="    OK    ">
		
		</cfFORM></cfif>
		</CFOUTPUT>
			
		
		<cfif #TheFileExists# is "true" and #JobAction# is "List">
		<cfoutput>
		<form action="adminheader.cfm?Action=jobsAdmin&LID=0&alphabet=all" method="post" name="searchform">
		<p><font color="##000000">Search For A Job by Title or Description <input type="text" name="searchDescription"><input type="submit" name="searchSubmit" value="GO"> (this is case sensitive)<br>
		Search for a Job by Employer <select name="SearchEmployer">
		<option value="">NONE</option>
		<cfloop query="allemployers">
			<option value="#allemployers.employerid#">#allemployers.companyname#</option>
		</cfloop>
		</select><input type="submit" name="searchSubmit" value="GO"><br>
		Search for a Job by Category <select name="SearchCategory">
		<option value="">NONE</option>
		<cfloop query="allcategories">
			<option value="#allcategories.categoryid#">#allcategories.categoryname#</option>
		</cfloop>
		</select><input type="submit" name="searchSubmit" value="GO"><br>
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allstates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="states">
		</cfinvoke>
		Search for a Job by State <select name="Searchstate">
		<option value="">NONE</option>
		<cfloop query="allstates">
			<option value="#allstates.stateid#">#allstates.statename#</option>
		</cfloop>
		</select><input type="submit" name="searchSubmit" value="GO"><br>
		or click on the appropriate alphbetical character to list by job title</font>
		</form>
		or <a href="adminheader.cfm?Action=#action#&alphabet=all">Click Here</a> to see them all<br>
		<a href="adminheader.cfm?Action=#action#&alphabet=1">1</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=2">2</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=3">3</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=4">4</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=5">5</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=6">6</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=7">7</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=8">8</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=9">9</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=0">0</a> |
		<a href="adminheader.cfm?Action=#action#&alphabet=a">A</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=b">B</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=c">C</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=d">D</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=e">E</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=f">F</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=g">G</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=h">H</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=i">I</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=j">J</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=k">K</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=l">L</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=m">M</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=n">N</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=o">O</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=p">P</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=q">Q</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=r">R</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=s">S</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=t">T</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=u">U</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=v">V</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=w">W</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=x">X</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=y">Y</a> | 
		<a href="adminheader.cfm?Action=#action#&alphabet=z">Z</a></p></cfoutput>
		
		<table border="1" align="CENTER">
		<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Jobs</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Title</p></td>
		<td><p>Employer</p></td>
		<td><p>Category</p></td>
		<td><p>Date Posted</p></td>
		<td><p>Actions</p></td>
		</tr>
			<cf_nextrecords Records="#AllJobs.RecordCount#"
					 ThisPageName="adminheader.cfm"
					 RecordsToDisplay="25"
					 DisplayText="Record"
					 DisplayFont="Arial"
					 FontSize=2
					 UseBold="Yes"
					 ExtraURL="&action=#action#&alphabet=#alphabet#&searchstate=#searchstate#&searchcategory=#searchcategory#&searchEmployer=#searchemployer#">
		<cfoutput query="AllJobs" StartRow=#SR# MaxRows=25>
		
		<tr>
		<td><p>#int(JobID)#</p></td>
		<td><p>#JobTitle#</p></td>
		<cfquery name="getEmployer" dbtype="query">
			select companyname from allemployers
			where employerid='#trim(employerid)#'
		</cfquery>
		<td><p>#getEmployer.companyname#</p></td>
		<cfquery name="getCategory" dbtype="query">
			select categoryname from allcategories
			where categoryid='#trim(jobcategoryid)#'
		</cfquery>
		<td><p>#getcategory.categoryname#</p></td>
		<td><p>#Dateformat(datecreated,"mm/dd/yyyy")#</p></td>
		
		<td><a href= "adminheader.cfm?JobID=#trim(JobID)#&JobAction=Edit&action=#action#&alphabet=#alphabet#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:confirmDelete('adminheader.cfm?JobID=#JobID#&JobAction=Delete&action=#action#&alphabet=#alphabet#')">Delete</a></td>
		</tr>
		</cfoutput>
		</cfif>
		</table>

		<cfreturn JobAction>
	</cffunction>
	
	<cffunction access="remote" name="JobCategoryAdmin" output="true" returntype="string">
		<cfargument name="CategoryAction" type="string" default="list">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="AllPages">
			<cfinvokeargument name="ThisPath" value="pages">
			<cfinvokeargument name="ThisFileName" value="pages">
		</cfinvoke>
			
		<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
			method="CheckFileExists" returnvariable="TheFileExists">
				<cfinvokeargument name="FileName" value="JobCategories">
				<cfinvokeargument name="ThisPath" value="files">
		</cfinvoke>	
		
		<cfif #TheFileExists# is "true">
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCategories">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="JobCategories">
				<cfinvokeargument name="ORderbyStatement" value=" order by sortorder">
			</cfinvoke>
		</cfif>
		
		<cfparam name="CategoryID" default=0>
		<cfparam name="CategoryAction" default="List">
		<cfparam name="CategoryName" default="">
		<cfparam name="CategoryDescription" default="">
		<cfparam name="DateCreated" default="#now()#">
		<cfparam name="CategoryPageName" default="homepage">
		<cfparam name="SortOrder" default="0">
		<cfparam name="ParentCatID" default="">
		<cfparam name="Internship" default="0">
		
		<cfif CategoryAction is "delete">
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="JobCategories">
				<cfinvokeargument name="XMLFields" value="CAtegoryID,CategoryDescription,CategoryName,CategoryPageName,SortOrder,ParentCatID,Internship">
				<cfinvokeargument name="XMLIDField" value="CategoryID">
				<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
			</cfinvoke>
			<cfset CategoryID=0>
			<cfset CategoryAction="List">
		</cfif>
				
		<cfif CategoryID gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="JobCategories">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="JobCategories">
				<cfinvokeargument name="IDFieldName" value="CategoryID">
				<cfinvokeargument name="IDFieldValue" value="#CategoryID#">
			</cfinvoke>
			<cfoutput query="JobCategories">
				<cfset CategoryName=#CategoryName#>
				<cfset DateCreated=#DateCreated#>
				<cfset tCategoryDescription=#CategoryDescription#>
				<cfset CategoryDescription=replace(#tCategoryDescription#,"~",",","ALL")>
				<cfset CategoryPageName=#CategoryPageName#>
				<cfset SortOrder=#SortOrder#>
				<cfset ParentCatID=#ParentCatID#>
				<cfset Internship=#Internship#>
			</cfoutput>
			<cfset CategoryAction="update">
		</cfif>
		
		<cfif isDefined('form.submit')>
			
			<cfset form.CategoryDescription=replace(#form.CategoryDescription#,",","~","ALL")>
			<Cfif #trim(form.CategoryDescription)# is ''><cfset form.CategoryDescription="none"></Cfif>
			<cfif CategoryID gt 0>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="JobCategories">
					<cfinvokeargument name="XMLFields" value="CategoryDescription,CategoryName,CategoryPageName,SortOrder,ParentCatID,Internship">
				<cfinvokeargument name="XMLFieldData" value="#form.CategoryDescription#,#form.CategoryName#,#form.CategoryPageName#,#form.SortOrder#,#form.ParentCatID#,#form.Internship#">
					<cfinvokeargument name="XMLIDField" value="CategoryID">
					<cfinvokeargument name="XMLIDValue" value="#CategoryID#">
				</cfinvoke>
			<cfelse>
				<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="JobCategories">
					<cfinvokeargument name="XMLFields" value="CategoryDescription,CategoryName,CategoryPageName,SortOrder,ParentCatID,Internship">
					<cfinvokeargument name="XMLFieldData" value="#form.CategoryDescription#,#form.CategoryName#,#form.CategoryPageName#,#form.SortOrder#,#form.ParentCatID#,#form.Internship#">
					<cfinvokeargument name="XMLIDField" value="CategoryID">
				</cfinvoke>
			</cfif>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="AllCategories">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="JobCategories">
			</cfinvoke>
			<cfset TheFileExists="true">
			<cfset CategoryAction="list">
			<cfset CategoryName="">
			<cfset DateCreated = #now()#>
			<cfset CategoryID = 0>
			<cfset CategoryDescription=''>
			<cfset CategoryName=#CategoryName#>
			<cfset CategoryPageName='homepage'>
			<cfset SortOrder='0'>
			<cfset ParentCatID="none">
			<cfset Internship=0>
		</cfif>
		
		<cfoutput>
		<h1>JobCategories</h1>
		<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
		<input type="hidden" name="CategoryID" value="#CategoryID#">
		<input type="hidden" name="Action" value="#Action#">
		<input type="hidden" name="CategoryAction" value="#CategoryAction#">
		<input type="Hidden" name="DateCreated" value="#DateCreated#">
		<TABLE>
		
			<TR>
			<TD valign="top"> Job Category Name: </TD>
			<TD>
			
				<INPUT type="text" name="CategoryName" value="#CategoryName#" size=50 maxLength="125">
				
			</TD>
			<!--- field validation --->
			</TR>
			
			<TR>
			<TD valign="top"> Job Category Description: </TD>
			<TD>
			
				<TEXTAREA name="CategoryDescription" cols=50 rows=5>#CategoryDescription#</TEXTAREA>
			
			</TD>
			<!--- field validation --->
			</TR>
			
			<TR>
			<TD valign="top"> Sort Order: </TD>
			<TD><select name="sortorder">
				<cfloop index="counter" from="1" to="100">
					<option value="#counter#"<cfif #int(sortorder)# is #counter#> selected</cfif>>#counter#</option>
				</cfloop>
			</select>
			</TD>
			<!--- field validation --->
			</TR>
			
			<tr>
			<td valign=top> Job Category Status</td>
			<td>
				<cfif #CategoryPageName# is 1>
					<input type="radio" name="CategoryPageName" value="0"> Not Active<br>
					<input type="radio" name="CategoryPageName" value="1" checked>Active
				<cfelse>
					<input type="radio" name="CategoryPageName" value="0" checked> Not Active<br>
					<input type="radio" name="CategoryPageName" value="1">Active
				</cfif>
				</td>
			</tr>
			
			<cfif #TheFileExists# is "true">
				<tr>
				<td valign=top> If this is a sub-Category, please select the parent category</td>
				<td><select name="ParentCatID">
					<option value="0">None</option>
					<cfloop query="AllCategories">
						<option value="#AllCategories.CategoryID#" <cfif #ParentCatID# is #AllCategories.CategoryID#>selected</cfif>>#AllCategories.CategoryName#
					</cfloop>
					</select></td>
				</tr>
			<cfelse>
				<input type="hidden" name="ParentCatID" value="none">
			</cfif>
			<tr>
			<td valign=top> Is this an internship category?</td>
			<td>
				<cfif #Internship# is 1>
					<input type="radio" name="Internship" value="0"> No<br>
					<input type="radio" name="Internship" value="1" checked>Yes
				<cfelse>
					<input type="radio" name="Internship" value="0" checked> No<br>
					<input type="radio" name="Internship" value="1">Yes
				</cfif>
				</td>
			</tr>
		</TABLE>
			
		<!--- form buttons --->
		<INPUT type="submit" name="submit" value="    OK    ">
		
		</FORM>
		</CFOUTPUT>
		
		
		<cfif #TheFileExists# is "true">
		<table border="1" align="CENTER">
		<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Job Categories</p></th>
		<tr>
		<td><p>ID</p></td>
		<td><p>Name</p></td>
		<td><p>Sort Order</p></td>
		<td><p>Parent Category</p></td>
		<td><p>Internship</p></td>
		<td><p>Actions</p></td>
		</tr>
			
		<cfoutput query="AllCategories">
		<tr>
		<td><p align=right>#int(CategoryID)#</p></td>
		<td><p>#CategoryName#</p></td>
		<td><p align=right>#SortOrder#</p></td>
		<cfquery name="getParentCat" dbtype="query">
			select categoryname from allcategories where categoryid='#parentCatID#'
		</cfquery>
		<cfif getParentCat.recordcount gt 0><cfset ParentCatName=#getParentCat.Categoryname#><cfelse><cfset ParentCatName=''></cfif>
		<td><p>#ParentCatName#</p></td>
		<td><p>#Internship#</p></td>
		<td><a href= "adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Edit&&action=#action#">Edit</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?CategoryID=#CategoryID#&CategoryAction=Delete&action=#action#">Delete</a></td>
		</tr>
		</cfoutput>
		</cfif>
		</table>
		<p>&nbsp;</p>
		<cfreturn CategoryAction>
	</cffunction>
	
	<cffunction name="AddResources" access="remote" returntype="numeric" output="true">
		<cfargument name="ResourceID" type="string" required="true" default=0>
		<cfargument name="ADDRESS" type="string" required="true" default=''>
		<cfargument name="APPROVED" type="string" required="true" default="0">
		<cfargument name="CITY" type="string" required="true" default="">
		<cfargument name="CONTACT" type="string" required="true" default="">
		<cfargument name="DATE_POSTED" type="string" required="true" default="">
		<cfargument name="DEPARTMENT" type="string" required="true" default="">
		<cfargument name="EMAIL" type="date" required="true" default="">
		<cfargument name="FAX" type="string" required="true" default="">
		<cfargument name="LINK" type="string" required="true" default="">
		<cfargument name="NAME" type="string" required="true" default="">
		<cfargument name="OFFICE" type="string" required="true" default="">
		<cfargument name="STATE" type="string" required="true" default="0">
		<cfargument name="TELEPHONE" type="string" required="true" default="">
		<cfargument name="WEBSITE" type="string" required="true" default="">

		<cfset ADDRESS="#XMLFormat(arguments.ADDRESS)# ">
		<cfset CITY="#XMLFormat(arguments.CITY)# ">
		<cfset OFFICE="#XMLFormat(arguments.OFFICE)# ">
		<cfset NAME="#XMLFormat(arguments.NAME)# ">
		<cfset DEPARTMENT="#XMLFormat(arguments.DEPARTMENT)# ">
		<cfset EMAIL="#XMLFormat(arguments.EMAIL)# ">
		<cfset APPROVED=#XMLFormat(arguments.APPROVED)#>
		<Cfif APPROVED is ""><cfset APPROVED=0></Cfif>
		<cfset CONTACT=#XMLFormat(arguments.CONTACT)#>
		<cfset DATE_POSTED="#XMLFormat(arguments.DATE_POSTED)# ">
		<cfset FAX=#XMLFormat(arguments.FAX)#>
		<cfset STATE="#XMLFormat(arguments.STATE)# ">
		<cfset TELEPHONE="#XMLFormat(arguments.TELEPHONE)# ">
		<cfset LINK="#XMLFormat(arguments.LINK)# ">
		<cfset WEBSITE="#XMLFormat(arguments.WEBSITE)# ">
		
		<CFSET FieldList = "ADDRESS, APPROVED, CITY, CONTACT, DATE_POSTED, DEPARTMENT, EMAIL, FAX, LINK, NAME, OFFICE, STATE, TELEPHONE, WEBSITE ">
		<CFSET FieldValues = "#ADDRESS#,#APPROVED#,#CITY#,#CONTACT#,#DATE_POSTED#,#DEPARTMENT#,#EMAIL#,#FAX#,#LINK#,#NAME#,#OFFICE#,#STATE#,#TELEPHONE#,#WEBSITE#">
		
		<cfif #arguments.resourceID# eq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="newID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="jobResources">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="ResourceID">
			</cfinvoke>
		<cfelse>
			<cfset NewID=#arguments.resourceid#>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="jobResources">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="ResourceID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.ResourceID#">
			</cfinvoke>
		</cfif>
		<cfreturn newid>
	</cffunction>
	
	<cffunction name="SendMessage" access="remote" returntype="numeric" output="true">
		<cfargument name="MessageID" type="string" required="true" default=0>
		<cfargument name="EmployeeID" type="string" required="true" default=0>
		<cfargument name="DateCreated" type="string" required="true" default="0">
		<cfargument name="Message" type="string" required="true" default="">
		<cfargument name="JobID" type="string" required="true" default=0>
		<cfargument name="Originator" type="string" required="true" default=0>
		<cfargument name="AttachResume" type="string" required="true" default=0>
		<cfargument name="RepliedTo" type="date" required="true" default=0>
		<cfargument name="subject" type="string" required="true" default="">
		<cfargument name="EmployerID" type="string" required="true" default="">
		
		<cfif #arguments.MessageID# is "0">
			<cfset datecreated=dateformat(now(),"yyyy/mm/dd")>
		</cfif>
		<CFSET FieldList = "EmployeeID,DateCreated,Message,JobID,Originator,AttachResume,RepliedTo,subject,EmployerID">
		<CFSET FieldValues = "#EmployeeID#,#DateCreated#,#Message#,#JobID#,#Originator#,#AttachResume#,#RepliedTo#,#subject#,#EmployerID#">
		<cfif #arguments.MessageID# eq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="newID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="messages">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="MessageID">
			</cfinvoke>
		<cfelse>
			<cfset NewID=#arguments.MessageID#>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="updateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="messages">
				<cfinvokeargument name="XMLFields" value="#FieldList#">
				<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
				<cfinvokeargument name="XMLIDField" value="MessageID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.MessageID#">
			</cfinvoke>
		</cfif>
		<cfreturn newid>
	</cffunction>
	
</cfcomponent>