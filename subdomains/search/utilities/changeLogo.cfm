<html>
<head>
<title>Select Graphic</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Graphics">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>

<cfoutput query="Graphics">
	<cfif #GraphicsTypeID# is 5 or #GraphicsTypeID# is 6 or #GraphicsTypeID# is 7>
		<img src="#Filename#"><br>
	</cfif>
</cfoutput>
</body>
</html>
