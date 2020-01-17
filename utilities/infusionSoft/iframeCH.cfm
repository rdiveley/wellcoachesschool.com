<style>
a {
	text-decoration:none;
	font-family:Arial, Helvetica, sans-serif;
	font-size:14px
  }
 #title{
	margin-bottom:5px;
	}
body{
	font-family:Arial, Helvetica, sans-serif;
}
</style>
<link rel="stylesheet" type="text/css" href="js/themes/blue/style.css">
<link rel="stylesheet" type="text/css" href="js/addons/pager/jquery.tablesorter.pager.css">
<script type="text/javascript" src="js/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
<!-- <script type="text/javascript" src="js/addons/pager/jquery.tablesorter.pager.js"></script> -->
<script>
$(document).ready(function()
    {
	    $("table").tablesorter({
	    	widthFixed: true,
	    	widgets: ['zebra'],
	    	sortList: [[1, 1]]

	    }).tablesorterPager({
	    	container: $("#pager")

	    });
});
</script>

<cfparam name="URL.email" default="erika@wellcoaches.com">
<cfparam name="admins" default="0">
<cfparam name="FORM.email" default="">
<cfparam name="id" default="0">
<cfparam name="containsUnderScore" default="0">


	<cfif URL.email EQ "Erika@wellcoaches.com" OR FORM.email EQ "Erika@wellcoaches.com">
    	<cfset admins = 1>
    </cfif>

<cfif NOT isDefined("URL.surveyList")>
        <style>
		a {
		font-family:Arial, Helvetica, sans-serif;
		font-size:14px;
		}
		</style>
    <cfoutput>
		<span id="title"><b>CORE COACH TRAINING SURVEYS</b></span><br />
               <a href="http://www.surveygizmo.com/s3/1013764/Health-and-Wellness-Coach-Training-Lesson-Feedback-Survey?email=#URL.email#" >Core Coach Training - 18-week teleclass program - Lesson Feedback Survey</a><br />
               <a href="http://www.surveygizmo.com/s3/1953823/Core-Coach-Training-4-day-on-site-program-Feedback-Survey?email=#URL.email#" >Core Coach Training - 4-day program - Feedback Survey</a><br />
           <br />
           <span id="title"><b>LIVE WORKSHOP SURVEYS</b></span><br />
           	<a href="http://www.surveygizmo.com/s3/1117550/Wellcoaches-Live-Workshops-FeedbackSurvey?email=#URL.email#" >Wellcoaches Live Workshops - (Member Feedback) </a><br />
         	 <br />
            <span id="title"><b>MEMBER CLASS SURVEYS</b></span><br />
           		<a href="http://www.surveygizmo.com/s3/1026874/Wellcoaches-Member-and-Coach-in-Practice-Class-Feedback-Survey?email=#URL.email#" >Wellcoaches Member and Coach-in-Practice Class Feedback Survey</a><br />
				<a href="http://www.surveygizmo.com/s3/4144821/Coach-in-Action-Guide-Feedback-Survey?email=#URL.email#" >Coach-in-Action Guide Series Feedback Survey</a><br />
        	 	<a href="http://www.surveygizmo.com/s3/4051290/wellcoaches-habits-course?email=#URL.email#">Wellcoaches Habits Course</a><br />
			<br />
            <span id="title"><b>OYM</b></span><br />
           	<a href="http://www.surveygizmo.com/s3/1994464/organize-your-mind-online-mobile-course?email=#URL.email#" >organize your mind online+mobile course</a><br />
         	 <br />
		 <span id="title"><b>PROFESSIONAL COACH TRAINING SURVEYS</b></span><br />
            <!---  <a href="http://www.surveygizmo.com/s3/1330743/Professional-Coach-Training-Program-10-month-Sept-2013-June-2014?email=#URL.email#" >2013 Professional Coah Training Program (10-month) - Sept 2013 - June 2014</a><br />
             <a href="http://www.surveygizmo.com/s3/1849174/Professional-Coach-Training-Program-10-month-Sept-2014-June-2015?email=#URL.email#" >Professional Coach Training Program (10-month) - Sept 2014 - June 2015</a><br />
         	 <a href="http://www.surveygizmo.com/s3/2338773/Professional-Coach-Training-Program-10-month-Sept-2015-June-2016?email=#URL.email#">Professional Coach Training Program (10-month) - Sept 2015 - June 2016</a><br />
  	   		 --->
			<a href="http://www.surveygizmo.com/s3/2338773/Professional-Coach-Training-Program-10-month-Sept-2015-June-2016?email=#URL.email#">Professional Coach Training Program (10-month) - Minnesota Sept 2015 - June 2016</a><br />
			<a href="http://www.surveygizmo.com/s3/2913540/Professional-Coach-Training-Program-10-month-LaJolla-Sept-2016-May-2017?email=#URL.email#" >Professional Coach Training Program (10-month) - LaJolla Sept 2016 - May 2017</a><br />
            <a href="http://www.surveygizmo.com/s3/3839954/Professional-Coach-Training-Program-10-month-Indianapolis-Sept-2017-May-2018?email=#URL.email#" >Professional Coach Training Program (10-month) - Indianapolis Sept 2017 - May 2018</a>
			<br />
	</cfoutput>
 <cfelse>
 		<cfinclude template="surveyGizmoAPIs/getAllSurveys.cfm" />

 </cfif>
