<cffile action="READ" 
			file="#Application.UploadPath#\utilities\NavigationXML.xml" 
			variable="navXML">
<cfinvoke component="#Application.WebSitePath#.utilities.navigation" method="setnavigation">
	<cfinvokeargument name="XMLString" value="#NavXML#">
</cfinvoke>