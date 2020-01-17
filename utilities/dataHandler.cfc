<cfcomponent>
	<cffunction access="remote" name="GetRecords" output="true" returntype="query">
		<cfargument name="SelectStatement" type="string" required="true">
		<cfargument name="FromStatement" type="string" required="true">
		<cfargument name="WhereStatement" type="string" required="false" default="">
		<cfargument name="OrderByStatement" type="string" required="false" default="">

		<CFQUERY name="GetAllRecords" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			#arguments.SelectStatement#
			#arguments.FromStatement#
			<cfif #Arguments.WhereStatement# neq ''>#preservesinglequotes(arguments.WhereStatement)#</cfif>
			<cfif #Arguments.OrderByStatement# neq ''>#arguments.OrderByStatement#</cfif>
		</CFQUERY>

		<cfreturn GetAllRecords>
	</cffunction>
	
	<cffunction access="remote" name="DeleteARecord" output="false">
		<cfargument name="TableName" type="string" required="true" default="0">
		<cfargument name="IDField" type="string" required="true">
		<cfargument name="IDFieldValue" type="numeric" required="true">
		
		<cftry>
		<CFQUERY name="DeleteRecord" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#" maxRows=1>
			DELETE
			FROM #arguments.Tablename#
			WHERE #arguments.Tablename#.#arguments.IDField# = #arguments.IDFieldValue#
		</CFQUERY>
		<cfcatch type="database">
		   <P>#CFCATCH.message#</P>
		   <P>Caught an exception, type = #CFCATCH.TYPE# </P>
		   <P>The contents of the tag stack are:</P>
		   <CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
				 <CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
					 <BR>#i# #sCurrent["ID"]# 
		(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) #sCurrent["TEMPLATE"]#
		   </CFLOOP>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction access="remote" name="UpdateARecord" output="false">
		<cfargument name="tablename" type="string" required="true" default=''>
		<cfargument name="fieldlist" type="string" required="true" default=''>
		<cfargument name="fieldvalues" type="string" required="true" default=''>
		<cfargument name="IDField" type="string" required="true" default=''>
		<cfargument name="IDValue" type="numeric" required="true" default=0>
	
		<cfset FieldList=#Arguments.FieldList#>
		<cfset FieldValues=#Arguments.FieldValues#>
		<cfset IDfield=#Arguments.IDField#>
		<cfset IDVAlue=#Arguments.IDValue#>

		<cfset UpdateStatement="update #Arguments.Tablename# set ">
		<cfloop index="ValueCount" from="2" to="#ListLen(FieldList)#">
			<cfset UpdateStatement="#UpdateStatement# #ListGetAt(FieldList,ValueCount)# = #ListGetAt(FieldValues,ValueCount)#" >
			<cfif #ValueCount# neq #ListLen(FieldList)#><cfset UpdateStatement="#UpdateStatement# , "></cfif>
		</cfloop>
		<cfset UpdateStatement="#UpdateStatement# where #IDField# = #IDValue#">
	
		<cftry>
		<cfquery datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			#PreserveSingleQuotes(UpdateStatement)#
		</cfquery>
		<cfcatch type="database">
		   <P>Error Message: #CFCATCH.message#</P>
		   <p>Error Detail: #Cfcatch.Detail#</p>
		   <P>Caught an exception, type = #CFCATCH.TYPE# </P>
		   <p>Native Error Code: #cfcatch.NativeErrorCode#</p>
		   <p>#CfCatch.ExtendedInfo#</p>
		   <P>The contents of the tag stack are:</P>
		   <CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
				 <CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
					 <BR>#i# #sCurrent["ID"]# 
		(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) #sCurrent["TEMPLATE"]#
		   </CFLOOP>
		</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction access="remote" name="InsertARecord" output="true" returntype="numeric">
		<cfargument name="Tablename" type="string" required="true" default="">
		<cfargument name="FieldList" type="string" required="true"default="">
		<cfargument name="FieldValues" type="string" required="true"default="">
		<cfargument name="IDField" type="string" required="true" default=0>
		<cfoutput>insert into #Arguments.tableName# (
				#FieldList#
				) values (
				#PreserveSingleQuotes(FieldValues)#</cfoutput>
		<cftry>
			<cfquery datasource="#application.DSN#" 
				password="#application.DSNpWord#" username="#application.DSNuName#">
				insert into #Arguments.tableName# (
				#FieldList#
				) values (
				#PreserveSingleQuotes(FieldValues)#
				)
			</cfquery>
			<cfcatch type="database">
			   <P>#CFCATCH.message#</P>
			   <P>Caught an exception, type = #CFCATCH.TYPE# </P>
			   <P>The contents of the tag stack are:</P>
			   <CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
					 <CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
						 <BR>#i# #sCurrent["ID"]# 
			(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) #sCurrent["TEMPLATE"]#
			   </CFLOOP>
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfquery name="GetNewID" datasource="#application.DSN#" 
				password="#application.DSNpWord#" username="#application.DSNuName#">
				select max(#arguments.IDField#) as NewID from #arguments.Tablename#
			</cfquery>
			<cfcatch type="database">
			   <P>#CFCATCH.message#</P>
			   <P>Caught an exception, type = #CFCATCH.TYPE# </P>
			   <P>The contents of the tag stack are:</P>
			   <CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
					 <CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
						 <BR>#i# #sCurrent["ID"]# 
			(#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) #sCurrent["TEMPLATE"]#
			   </CFLOOP>
			</cfcatch>
		</cftry>
		<cfif #GetNewID.RecordCount# is 0><cfoutput>The insert failed<br></cfoutput>
		<cfelse>
			<cfset ReturnID=#GetNewID.NewID#>
		</cfif>
		
		<cfreturn ReturnID>
	</cffunction>

	<cffunction access="remote" name="GetRecordCount" output="true" returntype="numeric">
		<cfargument name="TableName" type="string" required="true" default="">
		<cfargument name="WhereStatement" type="string" required="false" default="">

		<cfquery name="checkcount" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			select count(*) as RcdCnt from #Arguments.Tablename#
			<cfif #Arguments.WhereStatement# neq ''>
				#Arguments.WhereStatement#
			</cfif>
		</cfquery>
		<cfset RcdCnt=#checkcount.rcdcnt#>
		<cfreturn RcdCnt>
	</cffunction>
	
	<cffunction access="remote" name="GetFieldValue" output="true" returntype="string">
		<cfargument name="TableName" type="string" required="true" default="">
		<cfargument name="FieldName" type="string" required="true" default="">
		<cfargument name="IDFieldName" type="string" required="true" default="">
		<cfargument name="IDFieldVAlue" type="string" required="true" default="">
		
		<cfinvoke component="#Application.WebSitePath#.Utilities.AdminUtilities" method="InitWebSite" returnvariable="InitWebSiteRet">
		</cfinvoke>
		
		<cfquery name="GetName" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			select #Arguments.FieldName# as FieldValue from #Arguments.Tablename#
			Where #arguments.IDFieldName# = #IDFieldValue#
		</cfquery>
		<cfset FieldVAlue=#GetName.FieldVAlue#>
		<cfreturn FieldVAlue>
	</cffunction>
	
	<cffunction access="remote" name="GetMaxID" output="true" returntype="numeric">
		<cfargument name="TableName" type="string" required="true" default="">
		<cfargument name="FieldName" type="string" required="true" default="">

		<cfset FieldValue=1>

		<cfquery name="GetMax" datasource="#application.DSN#" password="#application.DSNpWord#" username="#application.DSNuName#">
			select max(#Arguments.FieldName#) as FieldValue from #Arguments.Tablename#
		</cfquery>
		<cfif #GetMax.FieldValue# gt 0>
			<cfset FieldVAlue=#GetMax.FieldVAlue#>
		</cfif>
		
		<cfreturn FieldVAlue>
	</cffunction>
</cfcomponent>