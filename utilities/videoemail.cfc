<cfcomponent>
	<cffunction name="getMyAccount" access="remote" returntype="query">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VECustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#VECustomerID#">
		</cfinvoke>
		<cfreturn VECustomer>
	</cffunction>
	
	<cffunction name="getAssociateAccount" access="remote" returntype="query">
		<cfargument name="VEAssociateID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociate">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="SelectStatement" 
			value=" where VEAssociateID='#trim(arguments.VEAssociateID)#'">
		</cfinvoke>
		<cfreturn VEAssociate>
	</cffunction>
	
	<cffunction name="getAllCustomers" access="remote" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allVECustomers">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
		</cfinvoke>
		<cfreturn allVECustomers>
	</cffunction>
	
	<cffunction name="getAllBandwidth" access="remote" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allBandwidth">
			<cfinvokeargument name="ThisPath" value="files/bandwidth">
			<cfinvokeargument name="ThisFileName" value="VEBandwidth">
		</cfinvoke>
		<cfreturn allBandwidth>
	</cffunction>
	
	<cffunction name="getCustomerBandwidth" access="remote" returntype="query">
		<cfargument name="CustomerID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allBandwidth">
			<cfinvokeargument name="ThisPath" value="files/bandwidth">
			<cfinvokeargument name="ThisFileName" value="VEBandwidth">
			<cfinvokeargument name="selectStatement" 
				value=" where VEUserID='#trim(arguments.CustomerID)#' and usertype='C'">
		</cfinvoke>
		
		<cfinvoke method="getMyVideos" access="remote" returnvariable="allVideos">
			<cfinvokeargument name="VEUserID" value="#arguments.CustomerID#">
			<cfinvokeargument name="userType" value="C">
		</cfinvoke>
		
		<cfset customerBandwidth=QueryNew("BandwidthID,DateWatched,TimeWatched,bandwidthCharge,NoOfMinutes,VideoFilename,associateID,VideoID")>
		<cfoutput query="allBandwidth">
			<CFSET newRow  = QueryAddRow(customerBandwidth, 1)>
			<CFSET temp = QuerySetCell(customerBandwidth, "BandwidthID","#BandwidthID#", #newRow#)>
			<CFSET temp = QuerySetCell(customerBandwidth, "DateWatched","#DateWatched#", #newRow#)>
			<CFSET temp = QuerySetCell(customerBandwidth, "TimeWatched","#TimeWatched#", #newRow#)>
			<CFSET temp= QuerySetCell(customerBandwidth, "bandwidthCharge","#bandwidthCharge#", #newRow#)>
			<CFSET temp = QuerySetCell(customerBandwidth, "NoOfMinutes","#NoOfMinutes#", #newRow#)>
			<cfquery name="GetVideo" dbtype="query">
				select title from allVideos where VideoID='#allBandwidth.VideoID#'
			</cfquery>
			<CFSET temp = QuerySetCell(customerBandwidth, "VideoFilename","#GetVideo.title#", #newRow#)>
			<CFSET temp = QuerySetCell(customerBandwidth, "associateID","none", #newRow#)>
			<CFSET temp = QuerySetCell(customerBandwidth, "VideoID","#VideoID#", #newRow#)>
		</cfoutput>
		
		<cfinvoke method="getMyAssociates" returnvariable="allAssociates">
			<cfinvokeargument name="VECustomerID" value="#arguments.CustomerID#">
		</cfinvoke>
		<cfoutput query="allAssociates">
			associateID=#VEAssociateID#<br>
			<cfinvoke method="getAssociateBandwidth" returnvariable="assocBandwidth">
				<cfinvokeargument name="AssociateID" value="#allAssociates.VEAssociateID#">
			</cfinvoke>
			<cfif #assocBandwidth.recordcount# gt 0>
				<cfinvoke method="getMyVideos" returnvariable="assocVideos">
					<cfinvokeargument name="VEUserID" value="#allAssociates.VEAssociateID#">
					<cfinvokeargument name="userType" value="A">
				</cfinvoke>
				<cfloop query="assocBandwidth">
					<CFSET newRow  = QueryAddRow(customerBandwidth, 1)>
					<CFSET temp = QuerySetCell(customerBandwidth, "BandwidthID","#BandwidthID#", #newRow#)>
					<CFSET temp = QuerySetCell(customerBandwidth, "DateWatched","#DateWatched#", #newRow#)>
					<CFSET temp = QuerySetCell(customerBandwidth, "TimeWatched","#TimeWatched#", #newRow#)>
					<CFSET temp= QuerySetCell(customerBandwidth, "bandwidthCharge","#bandwidthCharge#", #newRow#)>
					<CFSET temp = QuerySetCell(customerBandwidth, "NoOfMinutes","#NoOfMinutes#", #newRow#)>
					<cfquery name="GetVideo" dbtype="query">
						select title from assocVideos where VideoID='#assocBandwidth.VideoID#'
					</cfquery>
					<CFSET temp = QuerySetCell(customerBandwidth, "VideoFilename","#GetVideo.title#", #newRow#)>
					<CFSET temp = QuerySetCell(customerBandwidth, "associateID","#allAssociates.VEAssociateID#", #newRow#)>
					<CFSET temp = QuerySetCell(customerBandwidth, "VideoID","#VideoID#", #newRow#)>
				</cfloop>
			</cfif>
		</cfoutput>
		<cfreturn customerBandwidth>
	</cffunction>
	
	<cffunction name="getAssociateBandwidth" access="remote" returntype="query">
		<cfargument name="AssociateID" type="string" required="true">
		
		<cfset assocBandwidth=QueryNew("BandwidthID,DateWatched,TimeWatched,bandwidthCharge,NoOfMinutes,VideoFilename,associateID,VideoID")>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allBandwidth">
			<cfinvokeargument name="ThisPath" value="files/bandwidth">
			<cfinvokeargument name="ThisFileName" value="VEBandwidth">
			<cfinvokeargument name="selectStatement" 
				value=" where VEUserID='#trim(arguments.AssociateID)#' and usertype='A'">
		</cfinvoke>
		<cfoutput>allbandwidth.recordcount=#allBandwidth.recordcount#<br></cfoutput>
		<cfinvoke method="getMyVideos" access="remote" returnvariable="assocVideos">
			<cfinvokeargument name="VEUserID" value="#arguments.AssociateID#">
			<cfinvokeargument name="userType" value="A">
		</cfinvoke>
		<cfloop query="allBandwidth">
			<CFSET newRow  = QueryAddRow(assocBandwidth, 1)>
			<CFSET temp = QuerySetCell(assocBandwidth, "BandwidthID","#BandwidthID#", #newRow#)>
			<CFSET temp = QuerySetCell(assocBandwidth, "DateWatched","#DateWatched#", #newRow#)>
			<CFSET temp = QuerySetCell(assocBandwidth, "TimeWatched","#TimeWatched#", #newRow#)>
			<CFSET temp= QuerySetCell(assocBandwidth, "bandwidthCharge","#bandwidthCharge#", #newRow#)>
			<CFSET temp = QuerySetCell(assocBandwidth, "NoOfMinutes","#NoOfMinutes#", #newRow#)>
			<cfquery name="GetVideo" dbtype="query">
				select title from assocVideos where VideoID='#VideoID#'
			</cfquery>
			<CFSET temp = QuerySetCell(assocBandwidth, "VideoFilename","#GetVideo.title#", #newRow#)>
			<CFSET temp = QuerySetCell(assocBandwidth, "associateID","#arguments.AssociateID#", #newRow#)>
			<CFSET temp = QuerySetCell(assocBandwidth, "VideoID","#VideoID#", #newRow#)>
		</cfloop>
		<cfreturn assocBandwidth>
	</cffunction>
	
	<cffunction name="getMyInvoices" access="remote" returntype="query">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEInvoices">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="selectStatement" value=" where VEUserID='#VECustomerID#' and userType='C'">
		</cfinvoke>
		<cfreturn VEInvoices>
	</cffunction>
	
	<cffunction name="getInvoice" access="remote" returntype="query">
		<cfargument name="InvoiceID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEInvoices">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="IDFieldName" value="InvoiceID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.InvoiceID#">
		</cfinvoke>
		<cfreturn VEInvoices>
	</cffunction>
	
	<cffunction name="getInvoiceDetail" access="remote" returntype="query">
		<cfargument name="InvoiceID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEInvoiceDetails">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoiceDetail">
			<cfinvokeargument name="IDFieldName" value="InvoiceID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.InvoiceID#">
		</cfinvoke>
		<cfreturn VEInvoiceDetails>
	</cffunction>
	
	<cffunction name="getAllInvoices" access="remote" returntype="query">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="allVEInvoices">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
		</cfinvoke>
		<cfreturn allVEInvoices>
	</cffunction>
	
	<cffunction name="getMyAssociates" access="remote" returntype="query">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#VECustomerID#">
		</cfinvoke>
		<cfreturn VEAssociates>
	</cffunction>
	
	<cffunction name="getVideoList" access="remote" returntype="query">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideos">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#arguments.userType##trim(arguments.VEUserID)#">
		</cfinvoke>
		<cfreturn VEVideos>
	</cffunction>
	
	<cffunction name="getMyVideos" access="remote" returntype="query">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideos">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#arguments.userType##trim(arguments.VEUserID)#">
		</cfinvoke>
		<Cfif VEVideos.recordcount is 0>
			<cfset VEVideos = QueryNew("VideoID,VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode")>
		</Cfif>
		<cfreturn VEVideos>
	</cffunction>
	
	<cffunction name="getAssociateInvoices" access="remote" returntype="query">
		<cfargument name="VEAssociateID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEInvoices">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="selectStatement" value=" where VEUserID='#VEAssociateID#' and userType='A'">
		</cfinvoke>
		<cfreturn VEInvoices>
	</cffunction>
	
	<cffunction name="getVideo" access="remote" returntype="query">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideos">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="IDFieldName" value="VideoID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.VideoID#">
		</cfinvoke>
		<cfoutput query="VEVideos">
			#videofilename#
		</cfoutput>
		<cfreturn VEVideos>
	</cffunction>
	
	<cffunction name="getEmail" access="remote" returntype="query">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEEmail">
			<cfinvokeargument name="ThisPath" value="files/emails">
			<cfinvokeargument name="ThisFileName" value="VEEmail#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="IDFieldName" value="EmailID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmailID#">
		</cfinvoke>
		<cfreturn VEEmail>
	</cffunction>
	
	<cffunction name="getSendEmail" access="remote" returntype="query">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEEmail">
			<cfinvokeargument name="ThisPath" value="files/emails">
			<cfinvokeargument name="ThisFileName" value="VEEmail#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="IDFieldName" value="EmailID">
			<cfinvokeargument name="IDFieldVAlue" value="#trim(arguments.EmailID)#">
		</cfinvoke>
		<cfreturn VEEmail>
	</cffunction>
	
	<cffunction name="deleteAllEmails" access="remote" returntype="string" output="true">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cffile action="delete" file="#applications.uploadpath#/files/emails/VEEmail#arguments.userType##trim(arguments.VEUserID)#">
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="deleteEmail" access="remote" returntype="query">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files/emails">
				<cfinvokeargument name="ThisFileName" value="VEEmail#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="XMLFields" value="EmailID,VEUserID,EmailBody,EmailSubject,AttachVideo,DateCreated,DateSent,EmailFooter,EmailHeader,EmailServer,ReturnAddress,ListID,ToEmail,bandwidthCharge,status,usertype">
			<cfinvokeargument name="XMLIDField" value="EmailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>
		<cfreturn VEEmail>
	</cffunction>
	
	<cffunction name="getMyEmails" access="remote" returntype="query">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEEmail">
			<cfinvokeargument name="ThisPath" value="files/emails">
			<cfinvokeargument name="ThisFileName" value="VEEmail#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="IDFieldName" value="VEUserID">
			<cfinvokeargument name="IDFieldVAlue" value="#VEUserID#">
		</cfinvoke>
		<cfreturn VEEmail>
	</cffunction>
	
	<cffunction name="saveMyAccount" access="remote" returntype="string">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfargument name="CompanyName" type="string" required="true">
		<cfargument name="ContactName" type="string" required="true">
		<cfargument name="address" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="zip" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="officephone" type="string" required="true">
		<cfargument name="cellphone" type="string" required="true">
		<cfargument name="faxphone" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="balance" type="string" required="true" default="0">
		<cfargument name="status" type="string" required="true" default="active">
		<cfargument name="username" type="string" required="true" default=" ">
		<cfargument name="password" type="string" required="true" default=" ">
		
		<cfset fields="Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
		<cfset NewID=#arguments.VECustomerID#>
		<cfset Companyname=#arguments.Companyname#>
		<cfset ContactName=#arguments.ContactName#>
		<cfset address=#arguments.address#>
		<cfset city=#arguments.city#>
		<cfset state=#arguments.state#>
		<cfset zip=#arguments.zip#>
		<cfset country=#arguments.country#>
		<cfset email=#arguments.email#>
		<cfset officephone=#arguments.officephone#>
		<cfset cellphone=#arguments.cellphone#>
		<cfset faxphone=#arguments.faxphone#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset status=#arguments.status#>
		<cfset balance=#arguments.balance#>
		<cfset username=#arguments.username#>
		<cfset password=#arguments.password#>
		
		<cfif #int(newID)# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VECustomer">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="IDFieldName" value="VECustomerID">
				<cfinvokeargument name="IDFieldValue" value="#arguments.VECustomerID#">
			</cfinvoke>
			
			<cfset fielddata="#Companyname#,#contactname#,#address#,#city#,#state#,#zip#,#country#,#email#,#officephone# ,#cellphone# ,#faxphone# ,#bandwidthCharge#,#username#,#password#,Active,#VECustomer.balance# ">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VECustomerID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VECustomerID#">
			</cfinvoke>
		<cfelse>
			<cfset fielddata="#Companyname#,#contactname#,#address#,#city#,#state#,#zip#,#country#,#email#,#officephone# ,#cellphone# ,#faxphone# ,#bandwidthCharge#,#username#,#password#,Active,#balance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VECustomerID">
			</cfinvoke>
			
			<cfmail to="#email#" from="#application.email#"
				subject="Welcome to #application.websitename# Video Email" 
				bcc="scheri@musesforge.com" type="html" 
				server="#application.mailserver#">
				User name: #username#<br>
				Password : #password#<br>
				
			</cfmail>
		</cfif>
		
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="saveMyAssociate" access="remote" returntype="string">
		<cfargument name="VEAssociateID" type="string" required="true">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfargument name="CompanyName" type="string" required="true">
		<cfargument name="ContactName" type="string" required="true">
		<cfargument name="address" type="string" required="true">
		<cfargument name="city" type="string" required="true">
		<cfargument name="state" type="string" required="true">
		<cfargument name="zip" type="string" required="true">
		<cfargument name="country" type="string" required="true">
		<cfargument name="email" type="string" required="true">
		<cfargument name="officephone" type="string" required="true">
		<cfargument name="cellphone" type="string" required="true">
		<cfargument name="faxphone" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="balance" type="string" required="true" default="0">
		<cfargument name="status" type="string" required="true" default="active">
		<cfargument name="username" type="string" required="true" default="0">
		<cfargument name="password" type="string" required="true" default="active">
		
		<cfset fields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
		<cfset Companyname=#arguments.Companyname#>
		<cfset ContactName=#arguments.ContactName#>
		<cfset address=#arguments.address#>
		<cfset city=#arguments.city#>
		<cfset state=#arguments.state#>
		<cfset zip=#arguments.zip#>
		<cfset country=#arguments.country#>
		<cfset email=#arguments.email#>
		<cfset officephone=#arguments.officephone#>
		<cfset cellphone=#arguments.cellphone#>
		<cfset faxphone=#arguments.faxphone#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset status=#arguments.status#>
		<cfset balance=#arguments.balance#>
		<cfset username=#arguments.username#>
		<cfset password=#arguments.password#>
		
		<cfif #arguments.VEAssociateID# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VEAssociate">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="IDFieldName" value="VEAssociateID">
				<cfinvokeargument name="IDFieldVAlue" value="#arguments.VEAssociateID#">
			</cfinvoke>
			
			<cfset fielddata="#arguments.VECustomerID#,#Companyname#,#contactname#,#address#,#city#,#state#,#zip#,#country#,#email#,#officephone# ,#cellphone# ,#faxphone# ,#bandwidthCharge#,#username#,#password#,#status#,#VEAssociate.balance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VEAssociateID#">
			</cfinvoke>
		
		<cfelse>
			<cfset fielddata="#arguments.VECustomerID#,#Companyname#,#contactname#,#address#,#city#,#state#,#zip#,#country#,#email#,#officephone# ,#cellphone# ,#faxphone# ,#bandwidthCharge#,#username#,#password#,#status#,#balance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
			</cfinvoke>
			
			<cfmail to="#email#" from="#application.email#"
				subject="Welcome to #application.websitename# Video Email" 
				bcc="scheri@musesforge.com" type="html" 
				server="#application.mailserver#">
				User name: #username#<br>
				Password : #password#<br>
				
			</cfmail>
		</cfif>
	</cffunction>
	
	<cffunction name="saveMyEmail" access="remote" returntype="string">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="EmailBody" type="string" required="true">
		<cfargument name="EmailSubject" type="string" required="true">
		<cfargument name="AttachVideo" type="string" required="true">
		<cfargument name="DateCreated" type="string" required="true">
		<cfargument name="DateSent" type="string" required="true">
		<cfargument name="EmailFooter" type="string" required="true">
		<cfargument name="EmailHeader" type="string" required="true">
		<cfargument name="EmailServer" type="string" required="true">
		<cfargument name="ReturnAddress" type="string" required="true">
		<cfargument name="ListID" type="string" required="true">
		<cfargument name="ToEmail" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="status" type="string" required="true" default="pending">
		
		<cfset fields="VEUserID,EmailBody,EmailSubject,AttachVideo,DateCreated,DateSent,EmailFooter,EmailHeader,EmailServer,ReturnAddress,ListID,ToEmail,bandwidthCharge,status,usertype">
		<cfset VEUserID=#arguments.VEUserID#>
		<cfset EmailBody=#arguments.EmailBody#>
		<cfset EmailSubject=#arguments.EmailSubject#>
		<cfset AttachVideo=#arguments.AttachVideo#>
		<cfset DateCreated=#arguments.DateCreated#>
		<cfset DateSent=#arguments.DateSent#>
		<cfset EmailFooter=#arguments.EmailFooter#>
		<cfset EmailHeader=#arguments.EmailHeader#>
		<cfset EmailServer=#arguments.EmailServer#>
		<cfset ReturnAddress=#arguments.ReturnAddress#>
		<cfset ListID=#arguments.ListID#>
		<cfset ToEmail=#arguments.ToEmail#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset status=#arguments.status#>
		<cfset UserType=#ucase(arguments.UserType)#>
		
		<cfif #arguments.EmailID# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VEAssociate">
				<cfinvokeargument name="ThisPath" value="files/emails">
				<cfinvokeargument name="ThisFileName" value="VEEmail#UserType##VEUserID#">
				<cfinvokeargument name="IDFieldName" value="EmailID">
				<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmailID#">
			</cfinvoke>
			
			<cfset fielddata="#arguments.VEUserID#,#EmailBody#,#EmailSubject#,#AttachVideo#,#DateCreated#,#DateSent#,#EmailFooter#,#EmailHeader#,#EmailServer#,#ReturnAddress#,#ListID#,#ToEmail#,#bandwidthCharge#,#status#,#UserType#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files/emails">
				<cfinvokeargument name="ThisFileName" value="VEEmail#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="EmailID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
			</cfinvoke>
		
		<cfelse>
			<cfset fielddata="#arguments.VEUserID#,#EmailBody#,#EmailSubject#,#AttachVideo#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,#EmailFooter#,#EmailHeader#,#EmailServer#,#ReturnAddress#,0,0,#bandwidthCharge#,#status#,#UserType#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files/emails">
				<cfinvokeargument name="ThisFileName" value="VEEmail#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="EmailID">
			</cfinvoke>
		</cfif>
	</cffunction>
	
	<cffunction name="checkCustomerLogin" access="remote" returntype="query">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VECustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="SelectStatement" value=" where username='#trim(arguments.username)#' and password='#Trim(arguments.password)#'">
		</cfinvoke>
		<cfif VECustomer.recordcount is 0>
			<cfset VECustomer=QueryNew("status,VECustomerID")>
		</cfif>
		<cfreturn VECustomer>
	</cffunction>
	
	<cffunction name="checkAssociateLogin" access="remote" returntype="query">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="SelectStatement" value=" where username='#trim(arguments.username)#' and password='#Trim(arguments.password)#'">
		</cfinvoke>
		<cfif VEAssociates.recordcount is 0>
			<cfset VEAssociates=QueryNew("status,VEAssociatesID")>
		</cfif>
		<cfreturn VEAssociates>
	</cffunction>
	
	<cffunction name="checkAdminLogin" access="remote" returntype="string">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfif #trim(arguments.username)# is #application.username# and #trim(arguments.password)# is #application.pword#>
			<cfset status="true">
		<cfelse>
			<cfset status="false">
		</cfif>
		
		<cfreturn status>
	</cffunction>
	
	<cffunction name="saveRecording" access="remote" returntype="string" output="true">
		<cfargument name="CustomerID" type="string" required="true">
		<cfargument name="VideoFilename" type="string" required="true" default="none">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="Title" type="string" required="true">
		<cfargument name="NoOfMinutes" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="productCode" type="string" required="true">
		
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VECustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.CustomerID#">
		</cfinvoke>
		<cfset bandwidthCharge=#VECustomer.bandwidthCharge#>
		
		<cfset NewID="0000000000">
		<cfset fields="VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode,views">
		<cfset VEUserID=#arguments.CustomerID#>
		<cfset VideoFilename=#arguments.VideoFilename#>
		<cfset Description=#arguments.Description#>
		<cfset Title=#arguments.Title#>
		<cfset NoOfMinutes=#int(arguments.NoOfMinutes)#>
		<cfset NoOfMinutes=#NoOfMinutes# / 100>
		<cfset bandwidthCharge=#bandwidthCharge#>
		<cfset status="active">
		<cfset productCode=#arguments.productCode#>
		<cfset UserType=#ucase(arguments.UserType)#>
		<cfset views="0">

		<cfset fielddata="#VEUserID#,#VideoFilename#,#Description#,#Title#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,0,0,#NoOfMinutes#,#status#,#UserType#,#bandwidthCharge#,#productCode#,#views#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="VideoID">
		</cfinvoke>

		<cfreturn NewID>
	</cffunction>

	<cffunction name="saveMyVideo" access="remote" returntype="string">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="VideoFilename" type="string" required="true" default="none">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="Title" type="string" required="true">
		<cfargument name="DateCreated" type="string" required="true">
		<cfargument name="DateLastSent" type="string" required="true">
		<cfargument name="ListLastSent" type="string" required="true">
		<cfargument name="EmailLastSent" type="string" required="true">
		<cfargument name="NoOfMinutes" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="productCode" type="string" required="true">
		<cfargument name="views" type="string" required="true" default=0>
		<cfargument name="status" type="string" required="true" default="pending">
		
		<cfset NewID=#arguments.VideoID#>
		<cfset fields="VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode,views">
		<cfset VEUserID=#arguments.VEUserID#>
		<cfset VideoFilename=#arguments.VideoFilename#>
		<cfset Description=#arguments.Description#>
		<cfset Title=#arguments.Title#>
		<cfset DateCreated=#arguments.DateCreated#>
		<cfset DateLastSent=#arguments.DateLastSent#>
		<cfset ListLastSent=#arguments.ListLastSent#>
		<cfset EmailLastSent=#arguments.EmailLastSent#>
		<cfset NoOfMinutes=#arguments.NoOfMinutes#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset status=#arguments.status#>
		<cfset productCode=#arguments.productCode#>
		<cfset UserType=#ucase(arguments.UserType)#>
		<cfset views=#arguments.views#>
		
		<cfif #arguments.VideoID# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VEVideo">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="IDFieldName" value="VideoID">
				<cfinvokeargument name="IDFieldVAlue" value="#arguments.VideoID#">
			</cfinvoke>
			
			<cfset fielddata="#arguments.VEUserID#,#VideoFilename#,#Description#,#Title#,#DateCreated#,#DateLastSent#,#ListLastSent#,#EmailLastSent#,#NoOfMinutes#,#status#,#UserType#,#bandwidthCharge#,#productCode#,#views#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VideoID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VideoID#">
			</cfinvoke>
		
		<cfelse>
			<cfset fielddata="#arguments.VEUserID#,#VideoFilename#,#Description#,#Title#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,0,0,#NoOfMinutes#,#status#,#UserType#,#bandwidthCharge#,#productCode#,#views#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VideoID">
			</cfinvoke>
		</cfif>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="deleteAllVideos" access="remote" returntype="string" output="true">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cffile action="delete" file="#applications.uploadpath#/files/videos/VEVideo#arguments.userType##trim(arguments.VEUserID)#">
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="deleteVideo" access="remote" returntype="string">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#arguments.userType##trim(arguments.VEUserID)#">
			<cfinvokeargument name="XMLFields" value="VideoID,VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode,views">
			<cfinvokeargument name="XMLIDField" value="VideoID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.VideoID#">
		</cfinvoke>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="changeAssociateStatus" access="remote" returntype="string">
		<cfargument name="VEAssociateID" type="string" required="true">
		<cfargument name="Status" type="string" required="true">
		
		<cfset fields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status">
		<cfset status=#arguments.status#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociate">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="IDFieldName" value="VEAssociateID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.VEAssociateID#">
		</cfinvoke>
		
		<cfset fielddata="#arguments.VECustomerID#,#VEAssociate.Companyname#,#VEAssociate.contactname#,#VEAssociate.address#,#VEAssociate.city#,#VEAssociate.state#,#VEAssociate.zip#,#VEAssociate.country#,#VEAssociate.email#,#VEAssociate.officephone#,#VEAssociate.cellphone#,#VEAssociate.faxphone#,#VEAssociate.bandwidthCharge#,#VEAssociate.username#,#VEAssociate.password#,#arguments.status#">
			
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="VEAssociateID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.VEAssociateID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="changeAssociatePassword" access="remote" returntype="string">
		<cfargument name="VEAssociateID" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="oldusername" type="string" required="true">
		<cfargument name="oldpassword" type="string" required="true">
		
		<cfset fields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status">
		<cfset password=#arguments.password#>
		<cfset username=#arguments.username#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociate">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="IDFieldName" value="VEAssociateID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.VEAssociateID#">
		</cfinvoke>
		
		<Cfif oldpassword is #VEAssociate.password# and oldusername is #VEAssociate.username#>
			<cfset fielddata="#VEAssociate.VECustomerID#,#VEAssociate.Companyname#,#VEAssociate.contactname#,#VEAssociate.address#,#VEAssociate.city#,#VEAssociate.state#,#VEAssociate.zip#,#VEAssociate.country#,#VEAssociate.email#,#VEAssociate.officephone#,#VEAssociate.cellphone#,#VEAssociate.faxphone#,#VEAssociate.bandwidthCharge#,#arguments.username#,#arguments.password#,#VEAssociate.status#">
				
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VEAssociateID#">
			</cfinvoke>
		<Cfreturn "true">
		<cfelse>
			<cfreturn "false">
		</cfif>
	</cffunction>
	
	<cffunction name="changeCustomerStatus" access="remote" returntype="string">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfargument name="Status" type="string" required="true">
		
		<cfset fields="Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status">
		<cfset status=#arguments.status#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VECustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.VECustomerID#">
		</cfinvoke>
		
		<cfset fielddata="#VECustomer.Companyname#,#VECustomer.contactname#,#VECustomer.address#,#VECustomer.city#,#VECustomer.state#,#VECustomer.zip#,#VECustomer.country#,#VECustomer.email#,#VECustomer.officephone#,#VECustomer.cellphone#,#VECustomer.faxphone#,#VECustomer.bandwidthCharge#,#VECustomer.username#,#VECustomer.password#,#status#">
			
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="VECustomerID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.VECustomerID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="changeCustomerPassword" access="remote" returntype="string">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="oldusername" type="string" required="true">
		<cfargument name="oldpassword" type="string" required="true">
		
		<cfset fields="Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status">
		<cfset password=#arguments.password#>
		<cfset username=#arguments.username#>
		<cfset oldpassword=#arguments.oldpassword#>
		<cfset oldusername=#arguments.oldusername#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VECustomer">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VECustomers">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.VECustomerID#">
		</cfinvoke>
		
		<Cfif oldpassword is #VECustomer.password# and oldusername is #VECustomer.username#>
			<cfset fielddata="#VECustomer.Companyname#,#VECustomer.contactname#,#VECustomer.address#,#VECustomer.city#,#VECustomer.state#,#VECustomer.zip#,#VECustomer.country#,#VECustomer.email#,#VECustomer.officephone#,#VECustomer.cellphone#,#VECustomer.faxphone#,#VECustomer.bandwidthCharge#,#username#,#password#,#VECustomer.status#">
				
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord" returnvariable="NewID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VECustomerID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VECustomerID#">
			</cfinvoke>
			<Cfreturn "true">
		<cfelse>
			<cfreturn "false">
		</cfif>
	</cffunction>
	
	<cffunction name="deleteCustomer" access="remote" returntype="string" output="true">
		<cfargument name="VECustomerID" type="string" required="true">
		
		<cfinvoke method="changeCustomerStatus">
			<cfinvokeargument name="VECustomerID" value="#arguments.VECustomerID#">
			<cfinvokeargument name="Status" value="deleted">
		</cfinvoke>
		
		<cfinvoke method="deleteAllEmails">
			<cfinvokeargument name="VEUserID" value="#arguments.VECustomerID#">
			<cfinvokeargument name="userType" value="C">
		</cfinvoke>
		
		<cfinvoke method="deleteAllVideos">
			<cfinvokeargument name="VEUserID" value="#arguments.VECustomerID#">
			<cfinvokeargument name="userType" value="C">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="sendMyEmail" access="remote" returntype="string">
		<cfargument name="EmailID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="EmailBody" type="string" required="true">
		<cfargument name="EmailSubject" type="string" required="true">
		<cfargument name="AttachVideo" type="string" required="true">
		<cfargument name="DateCreated" type="string" required="true">
		<cfargument name="DateSent" type="string" required="true">
		<cfargument name="EmailFooter" type="string" required="true">
		<cfargument name="EmailHeader" type="string" required="true">
		<cfargument name="EmailServer" type="string" required="true">
		<cfargument name="ReturnAddress" type="string" required="true">
		<cfargument name="ListID" type="string" required="true">
		<cfargument name="ToEmail" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="status" type="string" required="true" default="pending">
		
		<cfset fields="VEUserID,EmailBody,EmailSubject,AttachVideo,DateCreated,DateSent,EmailFooter,EmailHeader,EmailServer,ReturnAddress,ListID,ToEmail,bandwidthCharge,status,usertype">
		<cfset VEUserID=#arguments.VEUserID#>
		<cfset EmailBody=#arguments.EmailBody#>
		<cfset EmailSubject=#arguments.EmailSubject#>
		<cfset AttachVideo=#arguments.AttachVideo#>
		<cfset DateCreated=#arguments.DateCreated#>
		<cfset DateSent=#arguments.DateSent#>
		<cfset EmailFooter=#arguments.EmailFooter#>
		<cfset EmailHeader=#arguments.EmailHeader#>
		<cfset EmailServer=#arguments.EmailServer#>
		<cfset ReturnAddress=#arguments.ReturnAddress#>
		<cfset ListID=#arguments.ListID#>
		<cfset ToEmail=#arguments.ToEmail#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset status=#arguments.status#>
		<cfset UserType=#ucase(arguments.UserType)#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociate">
			<cfinvokeargument name="ThisPath" value="files/emails">
			<cfinvokeargument name="ThisFileName" value="VEEmail#UserType##VEUserID#">
			<cfinvokeargument name="IDFieldName" value="EmailID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.EmailID#">
		</cfinvoke>
		
		<Cfset toEmailList=replace(toEmail,",","~","ALL")>
		<cfset toEmail=replace(toEmail,"~",",","ALL")>
		
		<cfset fielddata="#arguments.VEUserID#,#EmailBody#,#EmailSubject#,#AttachVideo#,#DateCreated#,#dateformat(now(),'yyyy/mm/dd')#,#EmailFooter#,#EmailHeader#,#EmailServer#,#ReturnAddress#,#ListID#,#toEmailList#,#bandwidthCharge#,#status#,#UserType#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="UpdateXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files/emails">
			<cfinvokeargument name="ThisFileName" value="VEEmail#UserType##VEUserID#">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="EmailID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.EmailID#">
		</cfinvoke>

		<cftry>
		<cfloop index="theAddress" list="#toEmail#">
			<cfmail to="#theAddress#" from="#returnAddress#" server="#emailserver#"
				subject="#EmailSubject#" bcc="scheri@musesforge.com" type="html">
				<p>#emailheader#</p>
				<p>#emailbody#</p>
				<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" 
				codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,19,0" 
				width="640" 
				height="700" 
				id="videoemail" 
				align="middle">
				<param name="movie" 
					value="#application.returnpath#/images/flash/playvideo.swf?VID=#attachvideo#&AID=#VEUserID#&TID=#usertype#&PM=1" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="##ffffff" />
				<embed src="#application.returnpath#/images/flash/playvideo.swf?VID=#attachvideo#&AID=#VEUserID#&TID=#usertype#&PM=1" 
				quality="high" 
				bgcolor="##ffffff" 
				width="640" 
				height="700" 
				name="videoemail" 
				align="middle"  
				type="application/x-shockwave-flash" 
				pluginspage="http://www.macromedia.com/go/getflashplayer" />
				</object>
				<p>#emailfooter#</p>
			</cfmail>
		</cfloop>
		<cfcatch type="Any">
			<cfreturn "false">
		</cfcatch>
		</cftry>
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="saveBandwidth" access="remote" returntype="string">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="BandwidthCharge" type="string" required="true">
		<cfargument name="NoOfMinutes" type="string" required="true">
		
		<cfset fields="VideoID,VEUserID,UserType,DateWatched,TimeWatched,NoOfMinutes,BandwidthCharge">
		<cfset VEUserID=#arguments.VEUserID#>
		<cfset VideoID=#arguments.VideoID#>
		<cfset NoOfMinutes=#arguments.NoOfMinutes#>
		<cfset BandwidthCharge=#arguments.BandwidthCharge#>
		<cfset DateWatched=#dateformat(now(),"yyyy/mm/dd")#>
		<cfset UserType=#ucase(arguments.UserType)#>
		<cfset TimeWatched=#timeformat(now(),"HH:mm")#>
		
		<cfset fielddata="#VideoID#,#VEUserID#,#UserType#,#DateWatched#,#timeWatched#,#NoOfMinutes#,#BandwidthCharge#">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files/bandwidth">
			<cfinvokeargument name="ThisFileName" value="VEBandwidth">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="BandwidthID">
		</cfinvoke>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideo">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
			<cfinvokeargument name="selectStatement" value=" where videoID='#VideoID#'">
		</cfinvoke>
		<cfset OldViews=#VEVideo.views#>
		<cfset newViews=#OldViews# + 1>
		<cfinvoke method="updateMyVideo" returnvariable="VideoID">
			<cfinvokeargument name="VideoID" value="#VideoID#">
			<cfinvokeargument name="VEUserID" value="#VEVideo.VEuserID#">
			<cfinvokeargument name="VideoFilename" value="#VEVideo.VideoFilename#">
			<cfinvokeargument name="Description" value="#VEVideo.Description#">
			<cfinvokeargument name="Title" value="#VEVideo.Title#">
			<cfinvokeargument name="DateCreated" value="#VEVideo.DateCreated#">
			<cfinvokeargument name="DateLastSent" value="#VEVideo.DateLastSent#">
			<cfinvokeargument name="ListLastSent" value="#VEVideo.ListLastSent#">
			<cfinvokeargument name="EmailLastSent" value="#VEVideo.EmailLastSent#">
			<cfinvokeargument name="NoOfMinutes" value="#VEVideo.NoOfMinutes#">
			<cfinvokeargument name="UserType" value="#VEVideo.UserType#">
			<cfinvokeargument name="bandwidthCharge" value="#VEVideo.bandwidthCharge#">
			<cfinvokeargument name="productCode" value="#VEVideo.productCode#">
			<cfinvokeargument name="views" value="#newViews#">
			<cfinvokeargument name="status" value="#VEVideo.VEuserID#">
		</cfinvoke>
		
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="updateMyVideo" access="remote" returntype="string">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="VideoFilename" type="string" required="true">
		<cfargument name="Description" type="string" required="true">
		<cfargument name="Title" type="string" required="true">
		<cfargument name="DateCreated" type="string" required="true">
		<cfargument name="DateLastSent" type="string" required="true">
		<cfargument name="ListLastSent" type="string" required="true">
		<cfargument name="EmailLastSent" type="string" required="true">
		<cfargument name="NoOfMinutes" type="string" required="true">
		<cfargument name="UserType" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="productCode" type="string" required="true">
		<cfargument name="views" type="string" required="true" default=0>
		<cfargument name="status" type="string" required="true" default="pending">
		
		<cfset fields="VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode,views">
		<cfset NewID=#arguments.VideoID#>
		<cfset VEUserID=#arguments.VEUserID#>
		<cfset VideoFilename=#arguments.VideoFilename#>
		<cfset Description=#arguments.Description#>
		<cfset Title=#arguments.Title#>
		<cfset DateCreated=#arguments.DateCreated#>
		<cfset DateLastSent=#dateformat(arguments.DateLastSent,"yyyy/mm/dd")#>
		<cfset ListLastSent=#arguments.ListLastSent#>
		<cfset EmailLastSent=#arguments.EmailLastSent#>
		<cfset NoOfMinutes=#arguments.NoOfMinutes#>
		<cfset bandwidthCharge=#arguments.bandwidthCharge#>
		<cfset productCode=#arguments.productCode#>
		<cfset status=#arguments.status#>
		<cfset UserType=#ucase(arguments.UserType)#>
		<cfset views=#arguments.views#>
					
		<cfif #int(arguments.VideoID)# neq 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VEVideo">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="orderByStatement" value=" order by VideoID desc">
			</cfinvoke>
			
			<cfset fielddata="#arguments.VEUserID#,#VideoFilename#,#Description#,#Title#,#DateCreated#,#DateLastSent#,#ListLastSent#,#EmailLastSent#,#NoOfMinutes#,#status#,#UserType#,#bandwidthCharge#,#productCode#,#views#">

			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VideoID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.VideoID#">
			</cfinvoke>
		
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VEVideo">
				<cfinvokeargument name="ThisPath" value="files/videos">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="IDFieldName" value="VideoID">
				<cfinvokeargument name="IDFieldVAlue" value="#arguments.VideoID#">
			</cfinvoke>
			
			<cfset fielddata="#arguments.VEUserID#,#VEVideo.VideoFilename#,#Description#,#Title#,#VEVideo.DateCreated#,#DateLastSent#,#ListLastSent#,#EmailLastSent#,#NoOfMinutes#,#status#,#UserType#,#bandwidthCharge#,#productCode#,#views#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/emails">
				<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VideoID">
				<cfinvokeargument name="XMLIDValue" value="#VEVideo.VideoID#">
			</cfinvoke>

		</cfif>
		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="assignVideo" access="remote" returntype="string">
		<cfargument name="VideoID" type="string" required="true">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfargument name="VEAssociateID" type="string" required="true">
		
		<cfset fields="VEUserID,VideoFilename,Description,Title,DateCreated,DateLastSent,ListLastSent,EmailLastSent,NoOfMinutes,status,usertype,bandwidthCharge,productcode,views">
		<cfset VideoID=#trim(arguments.VideoID)#>
		<cfset VECustomerID=#trim(arguments.VECustomerID)#>
		<cfset VEAssociateID=#trim(arguments.VEAssociateID)#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociate">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="selectstatement" value=" where VEAssociateID='#VEAssociateID#'">
		</cfinvoke>
		<cfset bandwidthCharge=#VEAssociate.bandwidthCharge#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideo">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideoC#VECustomerID#">
			<cfinvokeargument name="selectstatement" value=" where VideoID='#VideoID#'">
		</cfinvoke>
		
		<cfset fielddata="#arguments.VEAssociateID#,#VEVideo.VideoFilename#,#VEVideo.Description#,#VEVideo.Title#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,0,0,#VEVideo.NoOfMinutes#,#VEVideo.status#,A,#bandwidthCharge#,#VEVideo.productCode#,#VEVideo.views#">

		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="InsertXMLRecord" returnvariable="NewID">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideoA#VEAssociateID#">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="VideoID">
		</cfinvoke>

		<cfreturn NewID>
	</cffunction>
	
	<cffunction name="deleteAssociate" access="remote" returntype="string" output="true">
		<cfargument name="VEAssociateID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="XMLFields" value="VEAssociateID,VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
			<cfinvokeargument name="XMLIDField" value="VEAssociateID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.VEAssociateID#">
		</cfinvoke>
		
		<cfinvoke method="deleteAllEmails">
			<cfinvokeargument name="VEUserID" value="#arguments.VEAssociateID#">
			<cfinvokeargument name="userType" value="A">
		</cfinvoke>
		
		<cfinvoke method="deleteAllVideos">
			<cfinvokeargument name="VEUserID" value="#arguments.VEAssociateID#">
			<cfinvokeargument name="userType" value="A">
		</cfinvoke>
		
	</cffunction>
	
	<cffunction name="getAssociateList" access="remote" returntype="query">
		<cfargument name="VECustomerID" type="string" required="true">
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEAssociates">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEAssociates">
			<cfinvokeargument name="IDFieldName" value="VECustomerID">
			<cfinvokeargument name="IDFieldVAlue" value="#VECustomerID#">
		</cfinvoke>
		<cfreturn VEAssociates>
	</cffunction>
	
	<cffunction name="sendInvoice" access="remote" returntype="query">
		<cfargument name="VEUserID" type="string" required="true">
		<cfargument name="userType" type="string" required="true">
		
		<cfset VEUserID=#trim(arguments.VEUserID)#>
		<cfset userType=#trim(arguments.userType)#>
		
		<Cfif #userType# is "C">
			<cfinvoke method="getCustomerBandwidth" returnvariable="customerBandwidth">
				<cfinvokeargument name="CustomerID" value="#VEUserID#">
			</cfinvoke>
			<cfinvoke method="getMyAccount" returnvariable="customerAccount">
				<cfinvokeargument name="VECustomerID" value="#VEUserID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="getAssociateBandwidth" returnvariable="customerBandwidth">
				<cfinvokeargument name="AssociateID" value="#VEUserID#">
			</cfinvoke>
			<cfinvoke method="getAssociateAccount" returnvariable="customerAccount">
				<cfinvokeargument name="VEAssociateID" value="#VEUserID#">
			</cfinvoke>
		</Cfif>
		
		<!--- calculate bandwidth and cost --->
		<Cfset totalBandwidth=0>
		<cfset TotalAmount=0>
		<cfloop query="customerBandwidth">
			<cfset totalbandwidth=totalbandwidth + NoOfMinutes>
			<cfset Amount=#NoOfMinutes# * #bandwidthCharge#>
			<cfset Amount= Amount / 100>
			<cfset totalAmount=totalAmount + #Amount#>
		</cfloop>
		<!--- create invoice header --->
		<cfset Fields="VEUserID,userType,DateCreated,DatePaid,TotalAmount,TotalBandwidth">
		<cfset FieldData="#VEUserID#,#userType#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,#totalAmount#,#totalBandwidth#">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
			method="insertXMLREcord" returnvariable="InvoiceID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="InvoiceID">
		</cfinvoke>
		
		<cfif #userType# is "C">
			<cfinvoke method="getMyAccount" returnvariable="customer">
				<cfinvokeargument name="VECustomerID" value="#VEUserID#">
			</cfinvoke>
			<cfset newbalance=#customer.balance# + #totalAmount#>
			<cfset fields="Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
			<cfset fielddata="#customer.Companyname#,#customer.contactname#,#customer.address#,#customer.city#,#customer.state#,#customer.zip#,#customer.country#,#customer.email#,#customer.officephone# ,#customer.cellphone# ,#customer.faxphone# ,#customer.bandwidthCharge#,#customer.username#,#customer.password#,#customer.status#,#newbalance# ">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VECustomerID">
				<cfinvokeargument name="XMLIDValue" value="#VEUserID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="getAssociateAccount" returnvariable="associate">
				<cfinvokeargument name="VEAssociateID" value="#VEUserID#">
			</cfinvoke>
			<cfset newbalance=#associate.balance# + #totalAmount#>
			<cfset fields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
			<cfset fielddata="#associate.VECustomerID#,#associate.Companyname#,#associate.contactname#,#associate.address#,#associate.city#,#associate.state#,#associate.zip#,#associate.country#,#associate.email#,#associate.officephone# ,#associate.cellphone# ,#associate.faxphone# ,#associate.bandwidthCharge#,#associate.username#,#associate.password#,#associate.status#,#newbalance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
				<cfinvokeargument name="XMLIDValue" value="#VEUserID#">
			</cfinvoke>
		</cfif>
		
		<!--- create invoice detail --->
		<cfset Fields="InvoiceID,VEUserID,userType,DateCreated,DatePaid,Amount,BandwidthUsed,BandwidthCharge,VideoID,DateWatched,TimeWatched">
		<cfoutput query="customerBandwidth">
			<cfset Amount=#NoOfMinutes# * #bandwidthCharge#>
			<Cfset Amount=Amount / 100>
			<cfset BandwidthUsed=#noOfMinutes#>
			<cfset FieldData="#InvoiceID#,#customerBandwidth.VEUserID#,#customerBandwidth.userType#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,#Amount#,#BandwidthUsed#,#bandwidthCharge#,#VideoID#,#datewatched#,#timeWatched#">
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLREcord" returnvariable="DetailID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEInvoiceDetail">
				<cfinvokeargument name="XMLFields" value="#Fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="DetailID">
			</cfinvoke>
			<!--- delete bandwidth --->
			<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
				<cfinvokeargument name="ThisPath" value="files/bandwidth">
					<cfinvokeargument name="ThisFileName" value="VEBandwidth">
				<cfinvokeargument name="XMLFields" value="BandwidthID,VideoID,VEUserID,UserType,DateWatched,TimeWatched,NoOfMinutes,BandwidthCharge">
				<cfinvokeargument name="XMLIDField" value="BandwidthID">
				<cfinvokeargument name="XMLIDValue" value="#BandwidthID#">
			</cfinvoke>
		</cfoutput>
		
		<cfinvoke method="resendInvoice" returnvariable="associate">
			<cfinvokeargument name="InvoiceID" value="#InvoiceID#">
		</cfinvoke>
		
		<cfinvoke method="sendAssocInvoices" returnvariable="newID">
			<cfinvokeargument name="invoiceID" value="#InvoiceID#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="resendInvoice" access="remote" returntype="string" output="true">
		<cfargument name="InvoiceID" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="Invoice">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="IDFieldName" value="InvoiceID">
			<cfinvokeargument name="IDFieldVAlue" value="#InvoiceID#">
		</cfinvoke>
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="InvoiceDetail">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoiceDetail">
			<cfinvokeargument name="IDFieldName" value="InvoiceID">
			<cfinvokeargument name="IDFieldVAlue" value="#InvoiceID#">
		</cfinvoke>
		<cfinvoke method="getMyVideos" returnvariable="allvideos">
			<cfinvokeargument name="VEUserID" value="#Invoice.VEUserID#">
			<cfinvokeargument name="userType" value="#Invoice.usertype#">
		</cfinvoke>
		<Cfif #Invoice.usertype# is "C">
			<cfinvoke method="getMyAccount" returnvariable="customerAccount">
				<cfinvokeargument name="VECustomerID" value="#Invoice.VEUserID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="getAssociateAccount" returnvariable="customerAccount">
				<cfinvokeargument name="VEAssociateID" value="#Invoice.VEUserID#">
			</cfinvoke>
		</cfif>
		
		<cfmail to="#customerAccount.email#" from="#application.email#" 
			subject="Invoice #invoiceid#" 
			type="html" server="#application.MailServer#">
				
			<table class=blank width="100%"><tr><td valign=top>
			<table class=blank width="100%"><tr class=tableheader><th><p>Customer:</th></tr>
			<tr class=tableheader><td><p>#customerAccount.companyname#</p></td></tr>
			<tr class=tableheader><td><p>#customerAccount.contactname#</p></td></tr>
			<tr class=tableheader><td><p>#trim(customerAccount.address)#</p></td></tr>
			<tr class=tableheader><td><p>#trim(customerAccount.city)# #trim(customerAccount.state)# #trim(customerAccount.zip)#</td></tr>
			<tr class=tableheader><td><p>#trim(customerAccount.country)#</td></tr>
			<tr class=tableheader><td><p>Email Address: #trim(customerAccount.email)#</td></tr>
			<tr class=tableheader><td><p>Phone Number: #trim(customerAccount.officephone)#</td></tr>
			</table></td>
			
			<td valign=top>
			<table class=blank width="100%"><tr class=tableheader><th><p>From:</th></tr>
			<tr class=tableheader><td><p>#application.WEBSITENAME#</p></td></tr>
			<tr class=tableheader><td><p>#application.OWNERNAME#</p></td></tr>
			<tr class=tableheader><td><p>#trim(application.address1)# #trim(application.address2)#</p></td></tr>
			<tr class=tableheader><td><p>#trim(application.city)# #trim(application.state)# #trim(application.zip)#</td></tr>
			<tr class=tableheader><td><p>#trim(application.country)#</td></tr>
			<tr class=tableheader><td><p>Email Address: #trim(application.email)#</td></tr>
			<tr class=tableheader><td><p>Phone Number: #trim(application.phonenumber)#</td></tr>
			</table></td>
			
			</tr></table>
			
			<table class=blank width="100%">
			<tr class=tableheader><th><p>Video:</th><th>Date Viewed</th><th><p>Bandwidth Used:</th><th><p>Bandwidth Charge Per Minute:</th><th>Cost:</th></tr>
			<cfset GrandTotal=0>
			<cfloop query="InvoiceDetail">
				<cfquery name="getVideo" dbtype="query">
					select title from allvideos where videoid='#videoid#'
				</cfquery>
				<tr class=tableheader><td><p>#getVideo.title#</td>
				<td><p>#dateformat(datewatched,"mm/dd/yyyy")#</td>
				<td style="text-align: center;"><p>#bandwidthUsed# </td>
				<td style="text-align: right;"><p>#bandwidthCharge# cents</td>
				<td style="text-align: right;"><p>#dollarformat(amount)#</p></td>
				</tr>
			
			</cfloop>
			
			<tr class=tableheader><td></td><th class=tableheader><p>Total</th><th style="text-align: right;" class=tableheader><p>#dollarformat(Invoice.TotalAmount)#</th></tr>

			</table>
			
		</cfmail>
	</cffunction>
	
	<cffunction name="sendAssocInvoices" access="remote" returntype="string">
		<cfargument name="oldInvoiceID" type="string" required="true">
		
		<cfset oldInvoiceID=#trim(arguments.oldInvoiceID)#>
		
		<cfinvoke method="getInvoiceDetail" returnvariable="allDetail">
			<cfinvokeargument name="InvoiceID" value="#oldInvoiceID#">
		</cfinvoke>
		<cfquery name="associateIDs" dbtype="query">
			select distinct VEUserID from allDetail where userType='A'
		</cfquery>
		
		<cfset HeaderFields="VEUserID,userType,DateCreated,DatePaid,TotalAmount,TotalBandwidth">
		<cfset DetailFields="InvoiceID,VEUserID,userType,DateCreated,DatePaid,Amount,BandwidthUsed,BandwidthCharge,VideoID,DateWatched,TimeWatched">
		<cfset associateFields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
		
		<cfloop query="associateIDs">
			<Cfset totalBandwidth=0>
			<cfset TotalAmount=0>
			<cfquery name="associateDetail" dbtype="query">
				select * from allDetail where VEUserID='#VEUserID#' and userType='A'
			</cfquery>
			<cfloop query="associateDetail">
				<cfset totalbandwidth=totalbandwidth + BandwidthUsed>
				<cfset Amount=#BandwidthUsed# * #bandwidthCharge#>
				<cfset totalAmount=totalAmount + #Amount#>
			</cfloop>
			<cfset HeaderData="#VEUserID#,A,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,#totalAmount#,#totalBandwidth#">
			<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
				method="insertXMLREcord" returnvariable="newInvoiceID">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEInvoices">
				<cfinvokeargument name="XMLFields" value="#HeaderFields#">
				<cfinvokeargument name="XMLFieldData" value="#HeaderData#">
				<cfinvokeargument name="XMLIDField" value="InvoiceID">
			</cfinvoke>
			<cfoutput query="associateDetail">
				<cfset DetailData="#newInvoiceID#,#VEUserID#,#userType#,#dateformat(now(),'yyyy/mm/dd')#,1900/01/01,#Amount#,#BandwidthUsed#,#bandwidthCharge#,#VideoID#,#datewatched#,#timeWatched#">
				<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
					method="insertXMLREcord" returnvariable="DetailID">
					<cfinvokeargument name="ThisPath" value="files">
					<cfinvokeargument name="ThisFileName" value="VEInvoiceDetail">
					<cfinvokeargument name="XMLFields" value="#DetailFields#">
					<cfinvokeargument name="XMLFieldData" value="#DetailData#">
					<cfinvokeargument name="XMLIDField" value="DetailID">
				</cfinvoke>
			</cfoutput>
			<cfinvoke method="resendInvoice" returnvariable="associate">
				<cfinvokeargument name="InvoiceID" value="#newInvoiceID#">
			</cfinvoke>
			
			<cfinvoke method="getAssociateAccount" returnvariable="associate">
				<cfinvokeargument name="VEAssociateID" value="#VEUserID#">
			</cfinvoke>
			<cfset newbalance=#associate.balance# + #totalAmount#>
			
			<cfset associateData="#associate.VECustomerID#,#associate.Companyname#,#associate.contactname#,#associate.address#,#associate.city#,#associate.state#,#associate.zip#,#associate.country#,#associate.email#,#associate.officephone# ,#associate.cellphone# ,#associate.faxphone# ,#associate.bandwidthCharge#,#associate.username#,#associate.password#,#associate.status#,#newbalance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#associateFields#">
				<cfinvokeargument name="XMLFieldData" value="#associateData#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
				<cfinvokeargument name="XMLIDValue" value="#VEUserID#">
			</cfinvoke>
		</cfloop>
		<cfreturn OldInvoiceID>
	</cffunction>

	<cffunction name="payInvoice" access="remote" returntype="string" output="true">
		<cfargument name="InvoiceID" type="string" required="true">
		<cfargument name="iAmount" type="string" required="true">
		<cfargument name="iDate" type="string" required="true">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="theInvoice">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="IDFieldName" value="InvoiceID">
			<cfinvokeargument name="IDFieldVAlue" value="#arguments.InvoiceID#">
		</cfinvoke>
		
		<cfset amount=replace(#arguments.iamount#,"$","")>
		<cfset amount=replace(#amount#,",","","ALL")>
		<cfset paydate=dateformat(#arguments.iDate#,"yyyy/mm/dd")>
		
		<cfset Fields="VEUserID,userType,DateCreated,DatePaid,TotalAmount,TotalBandwidth">
		<cfset FieldData="#theInvoice.VEUserID#,#theInvoice.userType#,#dateformat(now(),'yyyy/mm/dd')#,#paydate#,#theInvoice.totalAmount#,#theInvoice.totalBandwidth#">
		<cfinvoke component="#application.websitepath#.utilities.XMLHandler" 
			method="updateXMLREcord" returnvariable="InvoiceID">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="VEInvoices">
			<cfinvokeargument name="XMLFields" value="#Fields#">
			<cfinvokeargument name="XMLFieldData" value="#fielddata#">
			<cfinvokeargument name="XMLIDField" value="InvoiceID">
			<cfinvokeargument name="XMLIDValue" value="#arguments.InvoiceID#">
		</cfinvoke>
		
		<cfif #theInvoice.userType# is "C">
			<cfinvoke method="getMyAccount" returnvariable="customer">
				<cfinvokeargument name="VECustomerID" value="#theInvoice.VEUserID#">
			</cfinvoke>
			<cfset newbalance=#customer.balance# - #amount#>
			<cfset fields="Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
			<cfset fielddata="#customer.Companyname#,#customer.contactname#,#customer.address#,#customer.city#,#customer.state#,#customer.zip#,#customer.country#,#customer.email#,#customer.officephone# ,#customer.cellphone# ,#customer.faxphone# ,#customer.bandwidthCharge#,#customer.username#,#customer.password#,#customer.status#,#newbalance# ">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VECustomerID">
				<cfinvokeargument name="XMLIDValue" value="#theInvoice.VEUserID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke method="getAssociateAccount" returnvariable="associate">
				<cfinvokeargument name="VEAssociateID" value="#theInvoice.VEUserID#">
			</cfinvoke>
			<cfset newbalance=#associate.balance# - #amount#>
			<cfset fields="VECustomerID,Companyname,contactname,address,city,state,zip,country,email,officephone,cellphone,faxphone,bandwidthCharge,username,password,status,balance">
			<cfset fielddata="#associate.VECustomerID#,#associate.Companyname#,#associate.contactname#,#associate.address#,#associate.city#,#associate.state#,#associate.zip#,#associate.country#,#associate.email#,#associate.officephone# ,#associate.cellphone# ,#associate.faxphone# ,#associate.bandwidthCharge#,#associate.username#,#associate.password#,#associate.status#,#newbalance#">
			
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VEAssociates">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="VEAssociateID">
				<cfinvokeargument name="XMLIDValue" value="#theInvoice.VEUserID#">
			</cfinvoke>
		</cfif>
		<cfreturn #arguments.invoiceid#>
	</cffunction>
	
	<cffunction name="changeVideoStatus" access="remote" output="true" returntype="string">
		<cfargument name="VideoID" required="true" type="string">
		<cfargument name="newStatus" required="true" type="string">
		<cfargument name="UserType" required="true" type="string">
		<cfargument name="VEUserID" required="true" type="string">
		
		<cfset VideoID=#trim(arguments.VideoID)#>
		<cfset UserType=#trim(arguments.UserType)#>
		<cfset VEUserID=#trim(arguments.VEUserID)#>
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
			method="GetXMLRecords" returnvariable="VEVideo">
			<cfinvokeargument name="ThisPath" value="files/videos">
			<cfinvokeargument name="ThisFileName" value="VEVideo#UserType##VEUserID#">
			<cfinvokeargument name="selectStatement" value=" where videoID='#VideoID#'">
		</cfinvoke>
		<cfinvoke method="updateMyVideo" returnvariable="VideoID">
			<cfinvokeargument name="VideoID" value="#VideoID#">
			<cfinvokeargument name="VEUserID" value="#VEVideo.VEuserID#">
			<cfinvokeargument name="VideoFilename" value="#VEVideo.VideoFilename#">
			<cfinvokeargument name="Description" value="#VEVideo.Description#">
			<cfinvokeargument name="Title" value="#VEVideo.Title#">
			<cfinvokeargument name="DateCreated" value="#VEVideo.DateCreated#">
			<cfinvokeargument name="DateLastSent" value="#VEVideo.DateLastSent#">
			<cfinvokeargument name="ListLastSent" value="#VEVideo.ListLastSent#">
			<cfinvokeargument name="EmailLastSent" value="#VEVideo.EmailLastSent#">
			<cfinvokeargument name="NoOfMinutes" value="#VEVideo.NoOfMinutes#">
			<cfinvokeargument name="UserType" value="#VEVideo.UserType#">
			<cfinvokeargument name="bandwidthCharge" value="#VEVideo.bandwidthCharge#">
			<cfinvokeargument name="productCode" value="#VEVideo.productCode#">
			<cfinvokeargument name="views" value="#VEVideo.views#">
			<cfinvokeargument name="status" value="#arguments.newStatus#">
		</cfinvoke>
		
	</cffunction>
	
	<cffunction name="saveFLVMovie" access="remote" output="true" returntype="string">
		<cfargument name="FLVID" type="string" required="true">
		<cfargument name="videoname" type="string" required="true">
		<cfargument name="description" type="string" required="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="bandwidthCharge" type="string" required="true">
		<cfargument name="playTime" type="string" required="true">
		<cfargument name="video_folder" type="string" required="true">
		<cfargument name="userid" type="string" required="true">
		<cfargument name="usertype" type="string" required="true">
		<cfargument name="pm" type="string" required="true">
		<cfargument name="seekTime" type="string" required="true">
		<cfargument name="buffer_time" type="string" required="true">
		<cfargument name="eventid" type="string" required="true">

		<cfset FLVID=#arguments.FLVID#>
		<cfif #int(arguments.bandwidthCharge)# is 0>
			<cfinvoke component="#Application.WebSitePath#.Utilities.XMLHandler" 
				method="GetXMLRecords" returnvariable="VECustomer">
				<cfinvokeargument name="ThisPath" value="files">
				<cfinvokeargument name="ThisFileName" value="VECustomers">
				<cfinvokeargument name="IDFieldName" value="VECustomerID">
				<cfinvokeargument name="IDFieldVAlue" value="#arguments.CustomerID#">
			</cfinvoke>
			<cfset arguments.bandwidthCharge=#VECustomer.bandwidthCharge#>
		</cfif>
		<cfset Fields="videoname,description,website,bandwidthCharge,playTime,video_folder,userid,usertype,pm,seekTime,buffer_time,eventid">
		<cfset FieldData="#arguments.videoname#,#arguments.description#,#arguments.website#,#arguments.bandwidthCharge#,#arguments.playTime#,#arguments.video_folder#,#arguments.userid#,#arguments.usertype#,#arguments.pm#,#arguments.seekTime#,#arguments.buffer_time#,#arguments.eventid#">
		
		<cfif int(#arguments.FLVID#) gt 0>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" method="UpdateXMLRecord">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="FLVMovies">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="FLVID">
				<cfinvokeargument name="XMLIDValue" value="#arguments.FLVID#">
			</cfinvoke>
		<cfelse>
			<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
				method="InsertXMLRecord" returnvariable="FLVID">
				<cfinvokeargument name="ThisPath" value="data">
				<cfinvokeargument name="ThisFileName" value="FLVMovies">
				<cfinvokeargument name="XMLFields" value="#fields#">
				<cfinvokeargument name="XMLFieldData" value="#fielddata#">
				<cfinvokeargument name="XMLIDField" value="FLVID">
			</cfinvoke>
		</cfif>
		
		<cfreturn FLVID>
	</cffunction>
	
</cfcomponent>