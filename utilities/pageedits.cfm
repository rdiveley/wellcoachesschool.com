<script language="JavaScript1.1">

function AddScript(form) {
	var txt= thisform.thescript.options[thisform.thescript.selectedIndex].value;
	var AddTxt="ScriptIs="+txt; 
	soEditor.insertText("[" + AddTxt + "]","", false, true);
}
function AddForm(form) {
	var txt= thisform.theform.options[thisform.theform.selectedIndex].value;
	var AddTxt="ScriptIs="+txt; 
	soEditor.insertText("[" + AddTxt + "]","", false, true);
}
</script>

<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllForms">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="forms">
</cfinvoke>

<table width="100%" align="CENTER" bgcolor="Silver" border=1>

	<tr>
	<td colspan=4>
	<cfmodule template="../utilities/soeditor/soeditor_lite.cfm" 		
			form="thisform"
          	field="D19"
          	scriptpath="../utilities/soeditor/">
	</td>
	</tr>
	
	
	<tr>
	<td colspan="4" bgcolor="#d4d0c8">
	<cfoutput>
	<select name="theform" size="1" onChange="AddForm('thisform')" class="inputs">
		<option value="0">--- Select a Custom Form ---</option>
		<cfloop query="Allforms">
			<option value="#formfilename#">#formtitle#</option>
		</cfloop>
	</select>
	<img src="../images/b.gif" width=20 height=16 alt="" border="0">
	<select name="thescript" size="1" onChange="AddScript('thisform')" class="inputs">
		<option value="0">--- Select A Function ---</option>
		<option value="0">--- Basic Scripts ---</option>
		<option value="moreoverfeed">News Feed from MoreOver.com</option>
		<option value="emailfriend">Email Page to Friend</option>
		<option value="inforequest">Request for Information</option> 
		<option value="inforequest2">Request for Reports</option>
		<option value="guestbook">Guest Book</option>
		<option value="linkslist">Links Listing</option>
		<option value="useraddlink">Add Links</option>
		<option value="sitemap">Site Map</option>
		<option value="sitesearch">Drop down for all pages</option>
		<option value="hitcounter">Hit Counter</option>
		<option value="addtofavorites">Add To Favorites</option>
		<option value="JSdateTime">Date and Time</option>
		<option value="popInit">Popup Page Init</option>
		<option value="JSDatePop">Date and Time and Popup Page Init</option>
		<option value="chat">Live Chat</option>
		<option value="vidConfSignUp">Video Conference SignUp</option>
		
		<option value="0">--- Memberships Scripts ---</option>
		<option value="memberrules">Member Rules</option>
		<option value="memberconduct">Member Conduct</option>
		<option value="memberprivacy">Member Privacy Policy</option>
		<option value="memberlogin">Member Login</option>
		<option value="forgotpassword">Member Forgot Password</option>
		<option value="membersignup">Member SignUp</option>
		<option value="membercheckout">Member Check Out</option>
		<option value="myprofile">Member Start Page</option>
		<option value="memberdirectory">Member Directory</option>
		<option value="membersearch">Member Search</option>
		<option value="membersurvey">Member Surveys</option>
		<option value="memberpoll">Member Polls</option>
		
			<!--- Product Catalog and Auction Section --->
		<option value="0">--- Product Catalog ---</option>
		<option value="productsearch">Product Search</option>
		<option value="prodsearchresults">Product Search Results</option>
		<option value="catalog">Product Categories Listing Page</option>
		<option value="products">Product Items Listing Page</option>
		<option value="prodnotifyme">Product Notify Page</option>
		<option value="prodcheckout">Check Out</option>
		<option value="cartbuttons">View Cart, Check Out Buttons</option>
		<option value="viewcart">View Cart Script</option>
		<option value="smallviewcart">Small View Cart Script</option>
		<option value="productspecs">Product Specifications Script</option>
		<option value="prodspecials">Product Specials</option>
		<option value="newproducts">New Products</option>
		<option value="customerlogin">Customer Login</option>
		<option value="custforgotpword">Customer Forgot Password</option>
		<option value="customerhome">Customer Start Page</option>
		<option value="customersurvey">Customer Surveys</option>
		<option value="buygiftcertificate">Buy A Gift Certificate</option>
		<option value="shiptracker">Shipping Tracker</option>
		
		<option value="0">--- Articles & Newsletters Scripts ---</option>
		<option value="listarticles">List Article Titles</option>
		<option value="listuserarticles">List User Articles</option>
		<option value="useraddarticles">Users add an articles</option>
		<option value="newsletter">Newsletter Sign Up</option>
		<option value="newsletter2">Large Newsletter Sign Up</option>
		<option value="ecJobLetter">EC Job Letter Sign Up</option>
		<option value="newsarchives">Show Newsletters Archive</option>
		<option value="specialNewsletter">Special Newsletter Sign Up</option>
		<option value="requesttopci">Article/Newsletter/Interview Topic Requests</option>
		
		<option value="0">--- Other Scripts ---</option>
		<option value="mycalendar">Calendar</option>
		<option value="photogallery">Photo Gallery</option>
		<option value="dboard">Discussion Forums</option>
		<option value="currentpoll">Non-Member Polls</option>
		<option value="currentsurvey">Non-Member Surveys</option>
		<option value="userpanel">Video User Panel</option>
		<option value="salesAudioKit">Sales Audio Kit</option>
		<option value="publicityAudioKit">Publicity Audio Kit</option>
		<option value="videouserpanel">Video User Panel</option>
		
		<option value="0">--- Reservation Scripts ---</option>
		<option value="resvcusthome">Customer Home page</option>
		<option value="resvCustLogin">Customer Login</option>
		<option value="resvSearchResults">Search Results for Locations</option>
		<option value="locationsDropDown">Drop down of Locations for searching</option>
		<option value="reservations">Reservation Form</option>
		<option value="resvCheckOut">Resrvation Check Out</option>
		
		<option value="0">--- Job Board Scripts ---</option>
		<option value="employerhome">Employer Home page</option>
		<option value="employerLogin">Employer Login</option>
		<option value="employeehome">Employee Home page</option>
		<option value="employeeLogin">Employee Login</option>
		<option value="jobSearch">Job Search</option>
		<option value="smalljobsearch">Small Job Search - Horizontal</option>
		<option value="homejobsearch">Small Job Search  - Vertical</option>
		<option value="employeesearchresults">Employer Search</option>
		<option value="employeesearch">Employees/Resumes Search</option>
		<option value="getHotJobs">Hot Jobs Search/Listing</option>
		<option value="getCurrentJobs">Current Jobs Search/Listing</option>
		<option value="postajob">Employer/Job Posting</option>
		<option value="postaresume">Employee/Resume Posting</option>
		<option value="postinternship">Internship/Job Posting</option>
		<option value="postcompany">Career Resources Sign Up Form</option>
		<option value="employersearch">Career Resources Search</option>
		<option value="featuredcompanies">Featured Companies</option>
		<option value="internships">Internships</option>
		<option value="internshipcompanies">Internship Companies</option>
		
		<option value="0">--- Affiliate Scripts ---</option>
		<option value="AffiliateSignup">Affiliate Registration</option>
		<option value="AffLogin">Affiliate Login</option>
		<option value="AffForgotPWord">Affiliate Forgot Password</option>
		<option value="AFfHome">Affiliate Start Page</option>
		<option value="AffSurvey">Affiliate Surveys</option>
		
		<option value="0">--- Banner Advertising Scripts ---</option>
		<option value="bannerSignup">Advertiser Registration</option>
	</select>
	</cfoutput>
	</td>
	</tr>
	</table>
</td></tr></table>