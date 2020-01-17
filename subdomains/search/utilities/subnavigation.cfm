<cfinvoke component="#Application.WebSitePath#.utilities.navigation" method="getNavigation"></cfinvoke>

<h1>Build Site Navigation</h1>

<cfoutput>
<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=6,0,0,0"
 WIDTH="250" HEIGHT="400" id="navBuilder" ALIGN="">
 <PARAM NAME=movie VALUE="#application.returnpath#/utilities/navBuilder.swf"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=##EAEAF4> <EMBED src="#application.returnpath#/utilities/navBuilder.swf" quality=high bgcolor=##EAEAF4  WIDTH="250" HEIGHT="400" NAME="navBuilder" ALIGN=""
 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
</OBJECT>
</cfoutput>