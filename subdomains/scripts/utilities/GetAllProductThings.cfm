
	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllCategories">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductCategories">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllTypes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductTypes">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllHardware">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Hardware">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllMaterials">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Materials">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllVendors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Vendors">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllColors">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="Colors">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllSizes">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductSizes">
	</cfinvoke>


	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllStyles">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="ProductStyles">
	</cfinvoke>

	<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
		method="GetXMLRecords" returnvariable="AllUnits">
		<cfinvokeargument name="ThisPath" value="files">
		<cfinvokeargument name="ThisFileName" value="units">
	</cfinvoke>

