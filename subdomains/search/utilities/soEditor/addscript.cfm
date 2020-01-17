<cfinclude template="GetPath.cfm">
<cfinclude template="#HomePath#GetDSN.cfm">
<cfinclude template="#homepath##CommonPath#/breakvars.cfm">
<cfinclude template="sidtest.cfm">
<cfinclude template="#homepath##CommonPath#/GetWeb.Cfm">
<cfparam name="ScriptType" default=0>
<cfparam name="TypeID" default=0>
<cfparam name="TemplateID" default=0>
<cfparam name="PositionID" default=0>
<cfparam name="ThisForm" default="thisform">
<cfparam name="ThisContent" default="thiscontent">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Add Script</title>
<script language="JavaScript" src="../jscripts/browsercheck.js">
</script>
<script language="JavaScript1.1">

function AddScript(form) {
	var txt= form.thescript.options[form.thescript.selectedIndex].value;
	var AddTxt="<ScriptIs="+txt+">\n"; 
  if (window.opener && !window.opener.closed) {
    window.opener.document.<cfoutput>#ThisForm#.#ThisContent#</cfoutput>.value = window.opener.document.<cfoutput>#ThisForm#.#ThisContent#</cfoutput>.value + AddTxt;
  window.close();
  }
}
</script>
</head>
<body>
<form name="ThisForm" Method="Post">
<input type="hidden" name="SiteID" value="#SiteID#">
<cfif #ScriptType# is 1>
Select a script:
<select name="thescript" size="1">

	<!--- Basic Site Functions --->
	<option value=001>News Feed from MoreOver.com</option>
	<option value=002>News Feed from Headliner</option>
	<option value=003>Weather Feed from the WeatherGuys</option>
	<option value=004>Weather Feed from Weather.com</option>
	<option value=005>Email Page to Friend</option>
	<option value=006>Search the Internet with Google</option>
	<option value=007>Yahoo Webrings</option>
	<option value=008>Request for Information</option>
	<option value=009>Request for Information Thank You</option>
	<option value=010>Guest Book</option>
	<option value=011>Guest Book Thank You</option>
	<option value=012>Site Map</option>
	<option value=149>Hit Counter</option>
</select>
</cfif>
<cfif #ScriptType# is 3>
Select a script:
<select name="thescript" size="1">
	<!--- Product Catalog and Auction Section --->
	<option value=013>Product Search</option>
	<option value=014>Product Search Results</option>
	<option value=103>Product Categories Listing Page</option>
	<option value=104>Product Items Listing Page</option>
	<option value=105>Product Notify Page</option>
	<option value=015>Product Check Out</option>
	<option value=017>Product View Cart, Check Out Buttons</option>
	
	<option value=018>Auction Vendor Pages</option>
	<option value=019>Auction Bidding Page</option>
	<option value=020>Auction Search</option>
	<option value=021>Auction Search Results</option>
	<option value=022>Auction Rules</option>
	<option value=023>Auction Conduct</option>
	<option value=024>Auction Information</option>
	<option value=025>Auction Privacy Policy</option>
	<option value=026>Auction Registration</option>
	<option value=027>Auction Bid Hisotry</option>
	<option value=028>New Auction Items Listing</option>
	<option value=029>Ending Auction Items Listing</option>
	<option value=030>Auction Categories Listing Page</option>
	<option value=031>Auction Items Listing Page</option>
	<option value=032>Auction Confirmation Page</option>
	<option value=033>Individual Vendor Page with Auction Items Listing</option>
	<option value=106>Auction Check Out</option>
	<option value=107>Auction Check Out Results</option>
	<option value=108>Auction Check Out Bad</option>
	<option value=109>Auction Check Out Error</option>
	<option value=110>Auction Check Out Try Later</option>
	<option value=111>Auction View Cart, Check Out Buttons</option>
</select>
</cfif>
<cfif #ScriptType# is 2>
Select a script:
<select name="thescript" size="1">
	<!--- Advanced Site Functions --->
	<option value=091>Newsletter Sign Up Script</option>
	<option value=034>Chat Login</option>
	<option value=150>Links</option>
	
	<option value=036>Member Rules</option>
	<option value=037>Member Conduct</option>
	<option value=038>Member Information</option>
	<option value=039>Member Login</option>
	<option value=040>Member SignUp</option>
	<option value=041>Member SignUp Thank You</option>
	<option value=112>Member Check Out</option>
	<option value=113>Member Check Out Results</option>
	<option value=114>Member Check Out Bad</option>
	<option value=115>Member Check Out Error</option>
	<option value=116>Member Check Out Try Later</option>
	<option value=117>Member View Cart, Check Out Buttons</option>
	<option value=130>Member Privacy Policy</option>
	<option value=129>Member Profile</option>
	
	<option value=042>Site Search</option>
	<option value=043>Site Search Results</option>
	
	<option value=044>Survey Script</option>
	<option value=045>Survey Results</option>
	
	<option value=046>Full Glossary</option>
	<option value=047>One Glossary Item Popup</option>
	
	<option value=048>Discussion Board Start Page</option>
	<option value=050>Discussion Board Rules</option>
	<option value=051>Discussion Board Conduct</option>
	<option value=052>Discussion Board Information</option>
	<option value=053>Discussion Board Privacy</option>
	
	<option value=058>Classified Disclaimer</option>
	<option value=059>Classified Rules</option>
	<option value=060>Classified Conduct</option>
	<option value=061>Classified Information</option>
	<option value=062>Classified Privacy Policy</option>
	<option value=063>Classified Search</option>
	<option value=064>Classified Search Results</option>
	<option value=065>Classified Categories Listing Page</option>
	<option value=066>Classified Items Listing Page</option>
	<option value=088>Classified Registration</option>
	<option value=089>Classified Login Page</option>
	<option value=090>Classified Add Item Page</option>
 	<option value=094>Classified Add Item Tku Page</option>
	<option value=092>Classifieds My Ads Page</option>
	<option value=093>Classifieds Notify Page</option>
	<option value=101>Classifieds Check Out</option>
	<option value=102>Classifieds Check Out Good</option>
	<option value=098>Classifieds Check Out Bad</option>
	<option value=099>Classifieds Check Out Error</option>
	<option value=100>Classifieds Check Out Try Later</option>
	<option value=154>Classifieds Answer Blind Email</option>

	<option value=150>Links List from Link Manager</option>
	<option value=164>User Add Links</option>
	
	<option value=067>Calendar Rules</option>
	<option value=131>Add Calendars </option>
	<option value=132>User Registration </option>
	<option value=133>Calendar Manager Registration</option>
	<option value=134>Insert A Calendar</option>
	<option value=135>Manager Log In</option>
	<option value=143>My Calendar Page</option>
	<option value=144>Create Manager Profile</option>
	<option value=145>View Manager Profile</option>
	<option value=146>Search for Managers by Category</option>
	<option value=147>Search Results</option>
	<option value=161>Enter Events</option>
	<option value=162>Search for Events</option>
	<option value=163>Event Search Results</option>
	<option value=174>themed event listing</option>
	<option value=175>Show One Themed Event</option>
	<option value=176>Show One Event Component</option>

	<option value=068>Graffiti Wall</option>

	<option value=152>Affiliate registration</option>
	<option value=153>Affiliate Log In</option>
	<option value=155>Affiliate Checkout</option>	
	<option value=156>Affiliate Checkout Good</option>
	<option value=157>Affiliate Checkout Bad</option>
	<option value=158>Affiliate Checkout Try Later</option>	
	<option value=159>Affiliate Checkout Error</option>
	<option value=160>Affiliate Agents Page</option>
	<option value=166>Email Affliate</option>	
	<option value=168>List Affliate Programs</option>	

	<option value=087>E-Zine Start Page</option>
	
	
</select>
</cfif>
<cfif #ScriptType# is 4>
Select a script:
<select name="thescript" size="1">
	<!--- Photo Gallery Functions --->
	<option value=036>Member Rules</option>
	<option value=037>Member Conduct</option>
	<option value=038>Member Information</option>
	<option value=039>Member Login</option>
	<option value=040>Member SignUp</option>
	<option value=041>Member SignUp Thank You</option>
	
	<option value=069>Photo Search</option>
	<option value=070>Photo Search Results</option>
	<option value=071>Photo Categories Listing Page</option>
	<option value=072>Photos Listing Page</option>
	<option value=074>Photo CDs Listing Page</option>
	<option value=076>Photo Sets Listing Page</option>
	<option value=078>Other Media Listing Page</option>
	<option value=118>Photo Check Out</option>
	<option value=119>Photo Check Out Results</option>
	<option value=120>Photo Check Out Bad</option>
	<option value=121>Photo Check Out Error</option>
	<option value=122>Photo Check Out Try Later</option>
	<option value=123>Photo View Cart, Check Out Buttons</option>
	<option value=126>Image Submitters Sign In Page</option>
	<option value=127>Image Submitters Image Editing Page</option>
	<option value=127>ECards - All scripts (self contained)</option>
</select>
</cfif>
<cfif #ScriptType# is 5>
Select a script:
<select name="thescript" size="1">
	<!--- Human Resources Functions --->
	<option value=036>Member Rules</option>
	<option value=037>Member Conduct</option>
	<option value=038>Member Information</option>
	<option value=039>Member Login</option>
	<option value=040>Member SignUp</option>
	<option value=041>Member SignUp Thank You</option>
	
	<option value=079>Job Board Start Page</option>
	<option value=080>Job Board Submit Resume</option>
	<option value=081>Job Board Search Resumes</option>
	<option value=082>Job Board Submit Job Offering</option>
	<option value=083>Job Board Submit Company</option>
	<option value=084>Job Board Search Companies</option>
	<option value=085>Job Board Search Job Offerings</option>
	<option value=125>Job Board Submit RFP</option>
	<option value=135>Job Board List Projects</option>
	<option value=136>Job Board List Projects Categories</option>
	<option value=137>Job Board Private Messages Script</option>
	<option value=138>Job Board Public Messages Script</option>
	<option value=138>Job Board My Projects Page</option>
	<option value=140>Job Board My Bids Page</option>
	<option value=141>Job Board MyProfile Page </option>
	<option value=142>Job Board Login</option>
	<option value=148>Job Board Search Job Applicants</option>
	<option value=167>Job Board Search Job Applicants Results</option>
	<option value=165>Job Board Quick Search Job Applicants Results</option>
	<option value=169>Job Board Show One Project</option>
	<option value=170>Job Board Email Resume</option>
	<option value=171>Job Board Submit Resume to Job</option>
	<option value=172>Job Board Bid on RFP</option>
	<option value=173>Job Board Show One Profile</option>

	<option value=086>Project Management Start Page</option>
		
</select>
</cfif>
<input type="button" name="submit" value="Add This Script" onClick="AddScript(this.form)">
</form>
</body>
</html>