<cfif isdefined('form.submit')>

<cfif #form.forWhat# is "navigation">
	<cfif #form.Anchor# is "">
		<p>You have chosen for this button to be "navigation" but you have not filled in the URL that this navigation button will be going to when clicked on.<br><BR>please hit your browsers back button and correct this.</p>
		<cfabort>
	</cfif>
	<cfif #form.PositionID# is 0>
		<p>You have chosen for this button to be "navigation" selected a position for this button.<br><BR>please hit your browsers back button and correct this.</p>
		<cfabort>
	</cfif>
	<cfif not isdefined('form.Level')>
		<p>You have chosen for this button to be "navigation" but you have not selected a level for this button.<br><BR>please hit your browsers back button and correct this.</p>
		<cfabort>
	</cfif>
</cfif>
<!--- ============================== SIMPLE ======================================
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />
<!--- open the image to inspect --->
<cfset myImage.readImage("#application.uploadpath#\images\samples\#form.theOldImage#") />
<!--- set the font --->
<cfset useThisFont = myImage.loadSystemFont("#form.theFont#", #form.theFontSize#, "#form.theFontStyle#") />
<!--- create a string to write into the image --->
<cfset myString = #form.mystring#>
<Cfset stringLen=len(myString)>
<cfset advancedString = myImage.createString(myString) />
<!--- create some colors --->
<cfset colorWhite = myImage.createColor(255,255, 255) />
<cfset myImage.setStringForeground(advancedString, colorWhite, 0,stringLen) />
<!---
      Find the metrics (width, height, etc) for the string.
      We will use this to center the string in the image.
--->
<cfset metrics = myImage.getSimpleStringMetrics(myString, useThisFont) />
<!--- determine the X coordinate so we can center the text in the image --->
<cfset x = (myImage.getWidth() - metrics.width) / 2 />
<!--- draw the text, centered at the top of the image --->
<cfset myImage.drawString(advancedString, x, 30) />
<!--- output the new image --->
<cfset myImage.writeImage("#application.uploadpath#\images\#form.newImage#.png", "png") /> --->
<!--- ============================== ADVANCED ====================================== --->
<cfset form.theOldimage="navbutton.jpg">
<!--- create the object --->
<cfset myImage = CreateObject("Component","Image") />
<!--- open the image to inspect --->
<cfset myImage.readImage("#application.uploadpath#\images\samples\#form.theOldImage#") />
<!--- create some colors --->
<cfset colorWhite = myImage.createColor(255,255,255) />
<!--- create three random fonts --->
<cfoutput>#form.theFont#, #form.theFontSize#, #form.theFontStyle#<br></cfoutput>
<cfset useThisFont = myImage.loadsystemFont(#form.theFont#, #form.theFontSize#, #form.theFontStyle#) />
<!--- create a new image --->
<!--- create some strings write into the image --->
<cfset myString = "#ucase(form.mystring)#" />
<Cfset stringLen=len(myString)>
<cfset advancedString = myImage.createString(myString) />
<!--- some font and size --->
<cfset myImage.setStringFont(advancedString, useThisFont, 0, stringLen) />
<!--- set some example formatting --->
<cfset myImage.setStroke(2, colorWhite) />
<cfset myImage.setFill(colorWhite) />
<cfset myImage.setStringForeground(advancedString, #colorWhite#, 0, stringLen) />
<!--- get the string's metrics --->
<cfset metrics = myImage.getStringMetrics(advancedString) >
<!--- create an image the width and height of the text
<cfset myImage.createImage(metrics.width, metrics.height) /> --->
<!--- draw the text into the image --->
<cfset x = (myImage.getWidth() - metrics.width) / 2 />
<cfset myImage.drawString(advancedString, x, 15) />
<!--- output the new image --->


<cfif #form.forWhat# is "navigation">
	<cfset myImage.writeImage("#application.uploadpath#\images\#form.newImage#.png", "png") />
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" 
		method="InsertXMLRecord">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="navigation">
		<cfinvokeargument name="XMLFields" 
			value="FileName,NavTypeID,AltText,LinkText,Anchor,PositionID,Level">
		<cfinvokeargument name="XMLFieldData" 
			value="images/#form.newImage#.png,1,#form.MyString#,#form.MyString#,#form.Anchor#,#form.PositionID#,#form.Level#">
		<cfinvokeargument name="XMLIDField" value="NavID">
	</cfinvoke>
<cfelse>
	<cfset myImage.writeImage("#application.uploadpath#\images\products\#form.newImage#.png", "png") />
	<cfinvoke component="#Application.WebSitePath#.utilities.xmlhandler" method="InsertXMLRecord">
		<cfinvokeargument name="ThisPath" value="utilities">
		<cfinvokeargument name="ThisFileName" value="graphics">
		<cfinvokeargument name="XMLFields" value="FileName,GraphicsTypeID,description">
		<cfinvokeargument name="XMLFieldData" 
			value="images/products/#form.newImage#.png,1,#form.MyString#">
		<cfinvokeargument name="XMLIDField" value="GraphicsID">
	</cfinvoke>
</cfif>
<!--- the new images --->
<cfoutput><p>
<b>#form.newimage#:</b><br>
<img src="/images/#form.newImage#.png"><br>
</p></cfoutput>
<cfelse>
	<cfoutput><form action="../files/adminheader.cfm?action=imageeditor" method="post">
		<p><font color=black>The Font: <select name="theFont">
			<option value="Arial">Arial</option>
			<option value="Comic Sans MS">Comic Sans MS</option>
			<option value="Georgia">Georgia</option>
			<option value="Times New Roman">Times New Roman</option>
			<option value="Courier">Courier</option>
			<option value="Courier New">Courier New</option>
			<option value="Verdana">Verdana</option>
			<option value="MS Sans Serif">MS Sans Serif</option>
			<option value="Trebuchet MS">Trebuchet MS</option>
			<option value="Palatino Linotype">Palatino Linotype</option>
			<option value="Tahoma">Tahoma</option>
			<option value="Impact">Impact</option>
			<option value="Lucinda Console">Lucinda Console</option>
		</select><br>
		The Font Size: <select name="theFontSize">
			<cfloop index="XX" from="1" to="30">
				<option value="#XX#">#XX#</option>
			</cfloop>
		</select><br>
		The Font Weight: <select name="theFontStyle">
			<option value="Plain">Normal</option>
			<option value="Bold">Bold</option>
			<option value="Italic">Italic</option>
			<option value="BoldItalic">Bold Italic</option>
		</select><br>
		For: <select name="forWhat">
			<option value="products">Products</option>
			<option value="navigation">Navigation</option>
		</select><br>
		The Text: <input type="text" name="mystring"><br>
		The New Image Name: <input type="text" name="newimage"><br>
		<strong>If you chose navigation, please fillout the following:</strong><br>
		<b>URL</b> (If you are linking to a page on <b>YOUR</b>Website that was created by you,just type the <b>single word</b> page name in as you did when you created the page. If it is a link to a different Website then type in the full URL i.e. http://www.website.com): : <input type="text" name="Anchor"><br>
		<b>Navigation Position:</b><br>Whether your navigation links go across the page, or top to bottom down the side, you must define the order that the Navigation links will appear on the page when you're selecting navigation for a horizontal or vertial navigation list. The number 1 position will appear first/top and the number 2 position will appear second/next, and so on. All Navigation links <b>MUST</b> have a unique Navigation Position. <select name="PositionID">
			<option value="0">None</option>
			<cfloop index="I" from="1" to="300">
				<cfset tLen=Len(I)>
				<cfset NewID=I>
				<cfloop index="XX" from="#tLen#" to="9">
					<cfset NewID="0#NewID#">
				</cfloop>
				<option value="#NewID#">#I#</option>
			</cfloop>
		</select><br>
		<b>Link Level</b>:
		Top Level: <input type="Radio" name="Level" value="Folder"><br>
		Sub Level: <input type="Radio" name="Level" value="Leaf">
		<input type="submit" name="submit" value="GO"></font></p>
	</form></cfoutput>
</cfif>