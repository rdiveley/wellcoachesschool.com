<cfcomponent>
  <cffunction access="remote" name="GetAllMailingLists" output="true" returntype="query">
  
  	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>	
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="GetXMLRecords"
		 returnvariable="GetRecordsRet">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="MailingLists"/>
    </cfinvoke>
    <cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetOneList" output="true" returntype="query">
  	<cfargument name="MailingListID" type="numeric" required="true" default="0">
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="GetXMLRecords"
		 returnvariable="GetRecordsRet">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="MailingLists"/>
	  <cfinvokeargument name="IDFieldName" value="MailingListID"/>
	  <cfinvokeargument name="IDFieldVAlue" value="#arguments.MailingListID#"/>
    </cfinvoke>
    <cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="DeleteAList" output="false">
    <cfargument name="MailingListID" type="string" required="true" default="0">
    
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
	<cfset theFieldList='Name,Description,DateCreated,DateModified,DateLastSent,NoOfSubscribers,NewsletterIDLastSent'>
	<cfset MailingListID="#arguments.MailingListID#">
	<cfset theFieldValues="#Name#,#Description#,#DateCreated#,#Datestarted#,#DateModified#,#DateLastSent#,#NoOfSubscribers#,#NewsletterIDLastSent#">
	
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="DeleteXMLRecord">
      	<cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
		<cfinvokeargument name="ThisFileName" value="MailingLists"/>
		<cfinvokeargument name="XMLFields" value="#theFieldList#"/>
		<cfinvokeargument name="XMLIDField" value="MailingListID"/>
		<cfinvokeargument name="XMLIDValue" value="#MailingListID#"/>
    </cfinvoke>
  </cffunction>
  
  <cffunction access="remote" name="UpdateAList" output="false">
  	<cfargument name="MailingListID" default=0 type="string" required="true">
    <cfargument name="Name" default=0 type="string" required="true">
	<cfargument name="Description" default="" type="string" required="true">
	<cfargument name="DateCreated" default="" type="date" required="true">
	<cfargument name="DateLastSent" default="" type="date" required="true">	
	<cfargument name="NoOfSubscribers" default="" type="string" required="true">	
	<cfargument name="NewsletterIDLastSent" default="" type="string" required="true">	
	
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
	<cfset theFieldList='Name,Description,DateCreated,DateModified,DateLastSent,NoOfSubscribers,NewsletterIDLastSent'>
	<cfset Name="#arguments.Name#">
	<cfset Description="#arguments.Description#">
	<cfset DateCreated="#arguments.datecreated#">
	<cfset DateModified="#now()#">
	<cfset DateLastSent="#arguments.DateLastSent#">
	<cfset NoOfSubscribers="#arguments.NoOfSubscribers#">
	<cfset NewsletterIDLastSent="#arguments.NewsletterIDLastSent#">
	<cfset MailingListID="#arguments.MailingListID#">
	<cfset theFieldValues="#Name#,#Description#,#DateCreated#,#Datestarted#,#DateModified#,#DateLastSent#,#NoOfSubscribers#,#NewsletterIDLastSent#">

    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="UpdateXMLRecord">
      	<cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      	<cfinvokeargument name="ThisFileName" value="MailingLists"/>
      	<cfinvokeargument name="XMLFields" value="#theFieldList#"/>
	  	<cfinvokeargument name="XMLFieldData" value="#theFieldValues#" />
	  	<cfinvokeargument name="XMLIDField" value="MailingListID" />
		<cfinvokeargument name="XMLIDValue" value="#MailingListID#" />
    </cfinvoke>
  </cffunction>
  
  <cffunction access="remote" name="InsertAList" output="true" returntype="string">
	<cfargument name="Name" default="" type="string" required="true">
	<cfargument name="Description" default="" type="string" required="true">
	
	<cfset theFieldList='Name,Description,DateCreated,DateModified,DateLastSent,NoOfSubscribers,NewsletterIDLastSent'>
	<cfset Name="#arguments.Name#">
	<cfset Description="#arguments.Description#">
	<cfset DateCreated="#now()#">
	<cfset DateModified="#DateCreated#">
	<cfset DateLastSent="">
	<cfset NoOfSubscribers=0>
	<cfset NewletterIDLastSent="0">
	<cfset theFieldValues="#Name#,#Description#,#DateCreated#,#Datestarted#,#DateModified#,#DateLastSent#,#NoOfSubscribers#,#NewsletterIDLastSent#">
    
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="InsertXMLRecord"
		 returnvariable="NewID">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="MailingLists"/>
      <cfinvokeargument name="XMLFields" value="#theFieldList#"/>
	  <cfinvokeargument name="XMLFieldData" value="#theFieldValues#" />
	  <cfinvokeargument name="XMLIDField" value="MailingListID" />
    </cfinvoke>
	<cfreturn NewID>
  </cffunction>
  
  <!--- Subscribers --->
  <cffunction access="remote" name="GetAllsubscribers" output="true" returntype="query">
  	<cfargument name="MailingListName" required="true" type="string">
	
  	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>

    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="GetXMLRecords"
		 returnvariable="GetRecordsRet">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="#arguments.MailingListName#"/>
    </cfinvoke>
    <cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetOneSubscriber" output="true" returntype="query">
  	<cfargument name="MailingListID" type="numeric" required="true" default="0">
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="GetXMLRecords"
		 returnvariable="GetRecordsRet">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="MailingLists"/>
	  <cfinvokeargument name="IDFieldName" value="MailingListID"/>
	  <cfinvokeargument name="IDFieldVAlue" value="#arguments.MailingListID#"/>
    </cfinvoke>
    <cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="DeleteASubscriber" output="false">
	<cfargument name="MailingListName" required="true" type="string">
    <cfargument name="SubscriberID" type="string" required="true" default="0">
    
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
	<cfset theFieldList='Firstname,Lastname,EmailAddress,Status,DateSubscribed'>
	<cfset SubscriberID="#arguments.SubscriberID#">
	<cfset MailingListName="#arguments.MailingListName#">
	
    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="DeleteXMLRecord">
      	<cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
		<cfinvokeargument name="ThisFileName" value="#arguments.MailingListName#"/>
		<cfinvokeargument name="XMLFields" value="#theFieldList#"/>
		<cfinvokeargument name="XMLIDField" value="SubscriberID"/>
		<cfinvokeargument name="XMLIDValue" value="#SubscriberID#"/>
    </cfinvoke>
  </cffunction>
  
  <cffunction access="remote" name="UpdateASubscriber" output="false">
  	<cfargument name="MailingListName" required="true" type="string">
  	<cfargument name="SubscriberID" default=0 type="string" required="true">
    <cfargument name="Firstname" default=0 type="string" required="true">
	<cfargument name="LastName" default="" type="string" required="true">
	<cfargument name="EmailAddress" default="" type="date" required="true">
	<cfargument name="DateSubscribed" default="" type="date" required="true">		
	<cfargument name="Status" default="" type="date" required="true">
	
	<cfinvoke 
		 component="#Application.WebSitePath#.Utilities.AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
	<cfset theFieldList='Firstname,Lastname,EmailAddress,Status,DateSubscribed'>
	<cfset Firstname="#arguments.Firstname#">
	<cfset Lastname="#arguments.Lastname#">
	<cfset EmailAddress="#arguments.EmailAddress#">
	<cfset Status="#arguments.Status#">
	<cfset DateSubscribed="#arguments.DateSubscribed#">
	<cfset MailingListName="#arguments.MailingListName#">
	<cfset theFieldValues="#Firstname#,#Lastname#,#EmailAddress#,#Status#,#DateSubscribed#">

    <cfinvoke 
		 component="#Application.WebSitePath#.Utilities.dataHandler"
		 method="UpdateXMLRecord">
      	<cfinvokeargument name="ThisPath" value="#MailingListPath#" />
      	<cfinvokeargument name="ThisFileName" value="#MailingListName#" />
      	<cfinvokeargument name="XMLFields" value="#theFieldList#" />
	  	<cfinvokeargument name="XMLFieldData" value="#theFieldValues#" />
	  	<cfinvokeargument name="XMLIDField" value="SubscriberID" />
		<cfinvokeargument name="XMLIDValue" value="#arguments.SubscriberID#" />
    </cfinvoke>
  </cffunction>
  
  <cffunction access="remote" name="InsertASubscriber" output="true" returntype="string">
	<cfargument name="MailingListName" required="true" type="string">
    <cfargument name="Firstname" default=0 type="string" required="true">
	<cfargument name="LastName" default="" type="string" required="true">
	<cfargument name="EmailAddress" default="" type="string" required="true">
	
	<cfset theFieldList="Firstname,Lastname,EmailAddress,Status,DateSubscribed">
	<cfset Firstname="#Firstname#">
	<cfset Lastname="#Lastname#">
	<cfset EmailAddress="#EmailAddress#">
	<cfset Status="1">
	<cfset MailingListName="#MailingListName#">
	<cfset DateSubscribed="#now()#">
	<cfset theFieldValues="#Firstname#,#Lastname#,#EmailAddress#,#Status#,#DateSubscribed#">
    
    <cfinvoke 
		 component="AdminUtilities"
		 method="GetThePath"
		 returnvariable="ThisPath">
		 <cfinvokeargument name="ThisModule" value="mailinglists">
	</cfinvoke>
	<cfset MailingListPath=#ThisPath#>
	
    <cfinvoke 
		 component="#Application.WebSitePath#.utilities.dataHandler"
		 method="InsertXMLRecord"
		 returnvariable="NewID">
      <cfinvokeargument name="ThisPath" value="#MailingListPath#"/>
      <cfinvokeargument name="ThisFileName" value="#MailingListName#"/>
      <cfinvokeargument name="XMLFields" value="#theFieldList#"/>
	  <cfinvokeargument name="XMLFieldData" value="#theFieldValues#" />
	  <cfinvokeargument name="XMLIDField" value="SubscriberID" />
    </cfinvoke>
	
	<cfreturn NewID>
  </cffunction>
</cfcomponent>
