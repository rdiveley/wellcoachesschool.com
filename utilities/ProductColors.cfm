
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPages">
	<cfinvokeargument name="ThisPath" value="pages">
	<cfinvokeargument name="ThisFileName" value="pages">
</cfinvoke>
	
<cfparam name="ColorID" default=0>
<cfparam name="ColorACtion" default="List">
<cfparam name="ColorName" default="">
<cfparam name="ColorDescription" default="">
<cfparam name="DateCreated" default="#now()#">
<cfparam name="PriceAdjustment" default="0">
<cfparam name="ColorImage" default="">

<cfif ColorACtion is "delete">
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="DeleteXMLRecord">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Colors">
		<cfinvokeargument name="XMLFields" value="ColorID,ColorDescription,ColorName,DateCreated,PriceAdjustment,ColorImage">
		<cfinvokeargument name="XMLIDField" value="ColorID">
		<cfinvokeargument name="XMLIDValue" value="#ColorID#">
	</cfinvoke>
	<cfset ColorID=0>
	<cfset ColorACtion="List">
</cfif>
		
<cfif ColorID gt 0>
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="Colors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Colors">
		<cfinvokeargument name="IDFieldName" value="ColorID">
		<cfinvokeargument name="IDFieldValue" value="#ColorID#">
	</cfinvoke>
	<cfoutput query="Colors">
		<cfset ColorName=#ColorName#>
		<cfset DateCreated=#DateCreated#>
		<cfset ColorDescription=#ColorDescription#>
		<cfset PriceAdjustment=#PriceAdjustment#>
		<cfset ColorImage=#ColorImage#>
	</cfoutput>
	<cfset ColorACtion="update">
</cfif>

<cfif isDefined('form.submit')>
	<cfif #form.image# neq ''>
		<cfset #curPath# = GetTemplatePath()>
		<cfset #curDirectory# = "#Application.UploadPath#\images\Products\">
		
		<cf_FileUpload
			directory="#curDirectory#"
			weight="100"
			nameofimages="image"
			nameConflict="overwrite"
			accept="image/*"
			default="na">
		<cfset Form.ColorImage="images/Products/#image#">
	</cfif>
	<cfif #form.ColorImage# is ''><cfset form.ColorImage="none"></cfif>
	<cfif ColorID gt 0>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="UpdateXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Colors">
			<cfinvokeargument name="XMLFields" value="ColorDescription,ColorName,DateCreated,PriceAdjustment,ColorImage">
		<cfinvokeargument name="XMLFieldData" value="#form.ColorDescription#,#form.ColorName#,#form.DateCreated#,#form.PriceAdjustment#,#form.ColorImage#">
			<cfinvokeargument name="XMLIDField" value="ColorID">
			<cfinvokeargument name="XMLIDValue" value="#ColorID#">
		</cfinvoke>
	<cfelse>
		<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
			<cfinvokeargument name="ThisPath" value="files">
			<cfinvokeargument name="ThisFileName" value="Colors">
			<cfinvokeargument name="XMLFields" value="ColorDescription,ColorName,DateCreated,PriceAdjustment,ColorImage">
			<cfinvokeargument name="XMLFieldData" value="#form.ColorDescription#,#form.ColorName#,#form.DateCreated#,#form.PriceAdjustment#,#form.ColorImage#">
			<cfinvokeargument name="XMLIDField" value="ColorID">
		</cfinvoke>
	</cfif>
	<cfset ColorACtion="list">
	<cfset ColorName="">
	<cfset DateCreated = #now()#>
	<cfset ColorID = 0>
	<cfset ColorDescription=''>
	<cfset ColorName=#ColorName#>
	<cfset PriceAdjustment='0'>
	<cfset ColorImage=''>
</cfif>

<cfoutput>
<h1>Colors</h1>
<form action="adminheader.cfm?uploadfile=true" enctype="multipart/form-data" method="post">
<input type="hidden" name="ColorID" value="#ColorID#">
<input type="hidden" name="Action" value="#Action#">
<input type="hidden" name="ColorACtion" value="#ColorACtion#">
<input type="hidden" name="ColorImage" value="#ColorImage#">
<input type="Hidden" name="DateCreated" value="#DateCreated#">
<TABLE>

	<TR>
	<TD valign="top"> Color Name: </TD>
    <TD>
	
		<INPUT type="text" name="ColorName" value="#ColorName#" size=50 maxLength="125">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Color Description: </TD>
    <TD>
	
		<TEXTAREA name="ColorDescription" cols=50 rows=5>#ColorDescription#</TEXTAREA>
	
	</TD>
	<!--- field validation --->
	</TR>
	
	<TR>
	<TD valign="top"> Upload Color Image: </TD>
    <TD>
		<input type="file" name="image"><br>#ColorImage#

		
	</TD>
	<!--- field validation --->
	</TR>
	
	<tr>
	<td valign=top> Price Adjustment </td>
	<td><input type="text" value="#PriceAdjustment#" name="PriceAdjustment"></td>
	</tr>
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="submit" value="    OK    ">

</FORM>
</CFOUTPUT>


<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="CheckFileExists" returnvariable="TheFileExists">
		<cfinvokeargument name="FileName" value="Colors">
		<cfinvokeargument name="ThisPath" value="files">
</cfinvoke>	

<cfif #TheFileExists# is "true">
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllColors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Colors">
	</cfinvoke>
<table border="1" align="CENTER">
<th colspan="5" align="CENTER" bgcolor="Maroon"><p>Your Product Colors</p></th>
<tr>
<td><p>ID</p></td>
<td><p>Name</p></td>
<td><p>Price Adj</p></td>
<td><p>Image</p></td>
<td><p>Actions</p></td>
</tr>
	
<cfoutput query="AllColors">
<tr>
<td><p>#ColorID#</p></td>
<td><p>#ColorName#</p></td>
<td><p>#dollarformat(PriceAdjustment)#</p></td>
<td><p><img src="../#ColorImage#"></p></td>

<td><a href= "adminheader.cfm?ColorID=#ColorID#&ColorACtion=Edit&&action=#action#">Edit</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminheader.cfm?ColorID=#ColorID#&ColorACtion=Delete&action=#action#">Delete</a></td>
</tr>
</cfoutput>
</cfif>
</table>

