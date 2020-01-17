<!DOCTYPE html>
<html>
<head>
<title>Organize Your Mind - Online Course</title>
	<script src="//use.typekit.net/zqb7bht.js"></script>
	<script>try{Typekit.load();}catch(e){}</script>

<style>

<cfinclude template="css/oym_style.css" />
<cfinclude template="css/oym_normalize.css" />

</style>

</head>

<body >

	<cfset templatewidth = '1440px' />

<div style="width: 100%;">
	<div id="header_container">
        <div id="header">
            <div class="left">
                <div class="left-inner">
            	    <a href="/"><img src="/themes/MuraBootstrap3/images/oym/wellcoaches.gif" /></a>
                </div>
            </div>
            <div class="right">
                <div class="right-inner">
    				<p>An organized mind is intentional, deep, agile, diverse, and energized. It's productive, creative, and strategic &#8212; every day.</p>
    				<span id="login"> 
                    	<a href="/login"><img src="/themes/MuraBootstrap3/images/oym/oym_login_btn.png" /></a><br />
                        <a href="http://my982.infusionsoft.com/app/orderForms/Organize-Your-Mind-onlinemobile-course"><img src="/themes/MuraBootstrap3/images/oym/register.png" /></a>
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>     
 
<div style="clear: both;"></div>
<cfoutput>
<div ">#$.content('banner')#</div>
<div ">#$.content('Section1')#</div>
<div style="clear: both;"></div>
<div ">#$.content('Section2')#</div>
<div ">#$.content('Section3')#</div>
<div ">#$.content('Section4')#</div>
<div ">#$.content('Section5')#</div>
<div ">#$.content('Section6')#</div>
<div ">#$.content('Section7')#</div>
<cfif len($.dspObjects(2))>
	#$.dspObjects(2)#
</cfif>	
</cfoutput>
<div style="min-width:<cfoutput>#templatewidth#</cfoutput> !important">
<div id="footer_container">
	<div id="footer">
		<a class="home_btn" href="/">&#8592; Return to Wellcoaches Home</a><br />
        <a class="home_btn" href="/organize-your-mind/">&#8592; Return to OYM Home</a>
        
			<div class="footer_nav">
				<a href="/organize-your-mind/on-line-course">Course Description</a>
				<a href="/organize-your-mind/organize-your-mind-organize-your-life/">The Book</a>
				<a href="/organize-your-mind/see-what-people-are-saying">Testimonials</a>
				<a href="/organize-your-mind/more-resources/">Resources</a>
			</div>
		<div style="clear: both;"></div>
		<p>Wellcoaches&copy;2014 All rights reserved.<p>
			<div class="social_nav">
				<a target="_blank" href="https://www.facebook.com/coachmegwellcoaches"><img src="/default/images/oym/facebook.png" /></a>
				<a target="_blank" href="https://twitter.com/coachmeg"><img src="/default/images/oym/twitter.png" /></a>
				<a target="_blank" href="http://www.linkedin.com/in/coachmeg"><img src="/default/images/oym/linkedin.png" /></a>
			</div>
		<div style="clear: both;"></div>
	</div>
</div>
</div>
   <script type="text/javascript">
		adroll_adv_id = "S3GVWRMRD5ATPNEGQSY2GE";
		adroll_pix_id = "GG3SIKDTWZEYLKXRSEW7S4";
		(function () {
		var oldonload = window.onload;
		window.onload = function(){
		   __adroll_loaded=true;
		   var scr = document.createElement("script");
		   var host = (("https:" == document.location.protocol) ? "https://s.adroll.com" : "http://a.adroll.com");
		   scr.setAttribute('async', 'true');
		   scr.type = "text/javascript";
		   scr.src = host + "/j/roundtrip.js";
		   ((document.getElementsByTagName('head') || [null])[0] ||
			document.getElementsByTagName('script')[0].parentNode).appendChild(scr);
		   if(oldonload){oldonload()}};
		}());
	</script>
    <script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  ga('create', 'UA-50129128-1', 'auto');
	  ga('send', 'pageview');
	
	</script>
</body>
</p>
