<cfcomponent>
  <cffunction access="remote" name="GetAllArticles" output="true" returntype="query">
  
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
			
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="OrderbyStatement" value=" order by title">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetAllArticleTypes" output="true" returntype="query">
  
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
			
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="OrderbyStatement" value=" order by description">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  
  <cffunction access="remote" name="GetArticleContent" output="true" returntype="query">
  		<cfargument name="ArticleID" type="string" required="true" default="">
		
 		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		
    	<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetAllRecords">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="IDFieldName" value="articleID">
			<cfinvokeargument name="IDFieldValue" value="#Arguments.ArticleID#">
    	</cfinvoke>
		<cfreturn GetAllRecords>
  </cffunction>
  
   <cffunction access="remote" name="GetArticle" output="true" returntype="query">
		<cfargument name="ArticleID" type="numeric" required="true" default="0">
		
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="IDFieldName" value="articleID">
			<cfinvokeargument name="IDFieldValue" value="#Arguments.ArticleID#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  <cffunction access="remote" name="GetArticleType" output="true" returntype="query">
		<cfargument name="ArticleTypeID" type="numeric" required="true" default="0">
		
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="IDFieldName" value="TypeID">
			<cfinvokeargument name="IDFieldValue" value="#Arguments.ArticleTypeID#">
		</cfinvoke>
		<cfreturn GetRecordsRet>
  </cffunction>
  
  
  <cffunction access="remote" name="DeleteAnArticle" output="false">
		<cfargument name="ArticleID" type="numeric" required="true" default="0">
		<!--- Delete the Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="#thispath#">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLIDField" value="ArticleID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.ArticleID#">
		</cfinvoke>
		<!--- Get the No Of Articles from the specified Article Type for this Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="TableName" value="Articles"/>
			<cfinvokeargument name="SelectStatment" value="select ArticleTypeID,NoOfArticles"/>
			<cfinvokeargument name="FromStatement" value="from Articles,ArticleTypes"/>
			<cfinvokeargument name="WhereStatement" value="where ArticleID=#arguments.ArticleID# and Articles.Articletypeid=ArticleTypes.TypeID"/>
		</cfinvoke>
		<cfset TypeID=#GetRecordsRet.ArticleTypeID#>
		<cfset NoOfArticles=#GetRecordsRet.NoOfArticles#>
		<cfset NoOfArticles=#NoOfArticles# - 1>
	
		<!--- Update the No Of Articles for the Article Type --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="IDFieldName" value="TypeID">
			<cfinvokeargument name="IDFieldValue" value="#TypeID#">
		</cfinvoke>
		<cfset NoOfArticles=#GetRecordsRet.NoOfArticles#>
		<cfset NoOfArticles=#NoOfArticles# - 1>
		<cfset Description=#getRecordsRet.Description#>
		<cfset Summary=#getRecordsRet.Summary#>
		<cfset PageID=#getRecordsRet.PageID#>
		<cfset Username=#getRecordsRet.Username#>
		<cfset Password=#getRecordsRet.Password#>
		<cfset filename=#getRecordsRet.filename#>
		<cfset theFieldList="Description,NoOfArticles,Summary,PageID,Username,Password,filename">
		<cfset theFieldValues="#Description#^#NoOfArticles#^#Summary#^#PageID#^#Username#^#Password#^#filename#">
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="UpdateXMLRecord">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#TypeID#">
		</cfinvoke>
  </cffunction>
  
  <cffunction access="remote" name="DeleteAnArticleType" output="false">
		<cfargument name="TypeID" type="numeric" required="true" default="0">
		<!--- Delete the Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="DeleteXMLRecord">
			<cfinvokeargument name="ThisPath" value="#thispath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLIDField" value="typeID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.TypeID#">
		</cfinvoke>

  </cffunction>
  
  <cffunction access="remote" name="UpdateAnArticle" output="false">
		<cfargument name="ArticleID" default=0 type="numeric" required="true">
		<cfargument name="ArticleTypeID" default=0 type="numeric" required="true">
		<cfargument name="Title" default="" type="string" required="true">
		<cfargument name="Author" default="" type="string" required="true">
		<cfargument name="DateStarted" default="" type="string" required="true">	
		<cfargument name="DateEnded" default="" type="string" required="true">	
		<cfargument name="PageID" default="" type="string" required="true">	
		<cfargument name="Summary" default="" type="string" required="true">	
		<cfargument name="Content" default="" type="string" required="true">	
		<cfargument name="Keywords" default="" type="string" required="true">
		<cfargument name="ImageID" default="0" type="numeric" required="true">
		<cfargument name="UserID" default="0" type="numeric" required="true">
		<cfargument name="LinkType" default="0" type="numeric" required="true">
		
		<cfset theFieldList="ArticleID,DateStarted,Title,Content,Author,ImageID,DateEnded,">
		<cfset theFieldList="#TheFieldList#ArticleTypeID,PageID,Summary,UserID,LinkType,Keywords">
		<cfset Article=#Arguments.ArticleID#>
		<cfset Title=#replace(arguments.Title,"'","`","ALL")#>
		<cfset Author=#replace(arguments.Author,"'","`","ALL")#>
		<cfset Summary=#replace(arguments.Summary,"'","`","ALL")#>
		<cfset Keywords=#replace(arguments.Keywords,"'","`","ALL")#>
		<cfset PageID=#arguments.PageID#>
		<cfset DateStarted=#createodbcdatetime(DateStarted)#>
		<cfset DateEnded=#createodbcdatetime(DateEnded)#>
		<cfset Content=#replace(arguments.Content,"'","`","ALL")#>
		<cfset ArticleTypeID=#arguments.ArticleTypeID#>
		<cfset UserID=#arguments.UserID#>
		<cfset LinkType=#arguments.LinkType#>
		<cfset ImageID=#arguments.ImageID#>
		<cfset theFieldValues="#ArticleID#^#DateStarted#^#Title#^#Content#^#Author#^#Imageid#^#DateEnded#^#ArticleTypeID#^#PageID#^#Summary#^#UserID#^#LinkType#^#Keywords#">
	
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		<!--- Update the Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="UpdateXMLRecord">
		  <cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articles">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLFieldData" value="#theFieldValues#">
			<cfinvokeargument name="XMLIDField" value="ArticleID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.ArticleID#">
		</cfinvoke>
  </cffunction>
  
   <cffunction access="remote" name="UpdateAnArticleType" output="false">
		<cfargument name="TypeID" default=0 type="numeric" required="true">
		<cfargument name="Description" default="" type="string" required="true">
		<cfargument name="NoOfArticles" default="0" type="numeric" required="true">	
		<cfargument name="Summary" default="" type="string" required="true">	
		<cfargument name="PageID" default="" type="string" required="true">
		<cfargument name="Username" default="" type="string" required="true">
		<cfargument name="Password" default="" type="string" required="true">	
		<cfargument name="filename" default="" type="string" required="true">		

		<cfset theFieldList="Description,NoOfArticles,Summary,PageID,Username,Password,filename">
		<cfset TypeID=#Arguments.TypeID#>
		<cfset Description=#replace(arguments.Description,"'","`","ALL")#>
		<cfset filename=#arguments.filename#>
		<cfset Summary=#replace(arguments.Summary,"'","`","ALL")#>
		<cfset Username=#arguments.Username#>
		<cfset PageID=#arguments.PageID#>
		<cfset Password=#arguments.Password#>
		<cfset NoOfArticles=#arguments.NoOfArticles#>
		<cfset theFieldValues="#Description#^#NoOfArticles#^#Summary#^#PageID#^#Username#^#Password#^#filename#">
	
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		<!--- Update the Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="UpdateXMLRecord">
		  <cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLFieldData" value="#theFieldValues#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.TypeID#">
		</cfinvoke>
 	</cffunction>
  
 	<cffunction access="remote" name="InsertAnArticle" output="true" returntype="numeric">
		<cfargument name="ArticleTypeID" default=0 type="numeric" required="true">
		<cfargument name="Title" default="" type="string" required="true">
		<cfargument name="Author" default="" type="string" required="true">
		<cfargument name="DateStarted" default="" type="string" required="true">	
		<cfargument name="DateEnded" default="" type="string" required="true">	
		<cfargument name="PageID" default="" type="string" required="true">	
		<cfargument name="Summary" default="" type="string" required="true">	
		<cfargument name="Content" default="" type="string" required="true">	
		<cfargument name="Keywords" default="" type="string" required="true">
		<cfargument name="ImageID" default="0" type="numeric" required="true">
		<cfargument name="UserID" default="0" type="numeric" required="true">
		<cfargument name="LinkType" default="0" type="numeric" required="true">
		
		<cfset theFieldList="DateStarted,Title,Content,Author,ImageID,DateEnded,">
		<cfset theFieldList="#TheFieldList#ArticleTypeID,PageID,Summary,UserID,LinkType,Keywords">
		<cfset Title=#replace(arguments.Title,"'","`","ALL")#>
		<cfset Author=#replace(arguments.Author,"'","`","ALL")#>
		<cfset Summary=#replace(arguments.Summary,"'","`","ALL")#>
		<cfset Keywords=#replace(arguments.Keywords,"'","`","ALL")#>
		<cfset PageID=#arguments.PageID#>
		<cfset DateStarted=#createodbcdatetime(DateStarted)#>
		<cfset DateEnded=#createodbcdatetime(DateEnded)#>
		<cfset Content=#replace(arguments.Content,"'","`","ALL")#>
		<cfset ArticleTypeID=#arguments.ArticleTypeID#>
		<cfset UserID=#arguments.UserID#>
		<cfset LinkType=#arguments.LinkType#>
		<cfset ImageID=#arguments.ImageID#>
		<cfset theFieldValues="#DateStarted#^#Title#^#Content#^#Author#^#Imageid#^#DateEnded#^#ArticleTypeID#^#PageID#^#Summary#^#UserID#^#LinkType#^#Keywords#">
		
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		
		<!--- Add the Article --->
    	<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="UpdateXMLRecord">
		  <cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLFieldData" value="#theFieldValues#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.TypeID#">
		</cfinvoke>
	
		<!--- Update No Of Articles contained in the Article Type --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="GetXMLRecords"
			 returnvariable="GetRecordsRet">
			<cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="IDFieldName" value="TypeID">
			<cfinvokeargument name="IDFieldValue" value="#Arguments.ArticleTypeID#">
		</cfinvoke>
		<cfset NoOfArticles=#GetRecordsRet.NoOfArticles#>
		<cfset NoOfArticles=#NoOfArticles# + 1>
		<cfset Description=#getRecordsRet.Description#>
		<cfset Summary=#getRecordsRet.Summary#>
		<cfset PageID=#getRecordsRet.PageID#>
		<cfset Username=#getRecordsRet.Username#>
		<cfset Password=#getRecordsRet.Password#>
		<cfset filename=#getRecordsRet.filename#>
		<cfset FieldList="Description,NoOfArticles,Summary,PageID,Username,Password,filename">
		<cfset FieldValues="#Description#^#NoOfArticles#^#Summary#^#PageID#^#Username#^#Password#^#filename#">
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="UpdateXMLRecord">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#FieldList#">
			<cfinvokeargument name="XMLFieldData" value="#FieldValues#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
			<cfinvokeargument name="XMLIDValue" value="#Arguments.ArticleTypeID#">
		</cfinvoke>
		
		<cfreturn ArticleID>
  </cffunction>
  
  <cffunction access="remote" name="InsertAnArticleType" output="false">
		<cfargument name="Description" default="" type="string" required="true">
		<cfargument name="NoOfArticles" default="0" type="numeric" required="true">	
		<cfargument name="Summary" default="" type="string" required="true">	
		<cfargument name="PageID" default="" type="string" required="true">
		<cfargument name="Username" default="" type="string" required="true">
		<cfargument name="Password" default="" type="string" required="true">	
		<cfargument name="filename" default="" type="string" required="true">		

		<cfset theFieldList="Description,NoOfArticles,Summary,PageID,Username,Password,filename">
		<cfset Description=#replace(arguments.Description,"'","`","ALL")#>
		<cfset filename=#arguments.filename#>
		<cfset Summary=#replace(arguments.Summary,"'","`","ALL")#>
		<cfset Username=#arguments.Username#>
		<cfset PageID=#arguments.PageID#>
		<cfset Password=#arguments.Password#>
		<cfset NoOfArticles=#arguments.NoOfArticles#>
		<cfset theFieldValues="#Description#^#NoOfArticles#^#Summary#^#PageID#^#Username#^#Password#^#filename#">
	
		<cfinvoke 
			 component="KOTW.Wunderlichad.AdminUtilities"
			 method="GetThePath"
			 returnvariable="ThisPath">
			 <cfinvokeargument name="ThisModule" value="articles">
		</cfinvoke>
		<!--- Update the Article --->
		<cfinvoke 
			 component="KOTW.Wunderlichad.dataHandler"
			 method="InsertXMLRecord">
		  <cfinvokeargument name="ThisPath" value="#ThisPath#">
			<cfinvokeargument name="ThisFileName" value="articletypes">
			<cfinvokeargument name="XMLFields" value="#theFieldList#">
			<cfinvokeargument name="XMLFieldData" value="#theFieldValues#">
			<cfinvokeargument name="XMLIDField" value="TypeID">
		</cfinvoke>
  </cffunction>
  
</cfcomponent>
