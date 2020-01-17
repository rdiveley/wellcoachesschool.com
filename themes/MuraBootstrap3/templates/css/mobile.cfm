<cfoutput>
<!DOCTYPE html> 
<html>
<head>
	<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="description" content="#HTMLEditFormat($.getMetaDesc())#" />
	<meta name="keywords" content="#HTMLEditFormat($.getMetaKeywords())#" />
	<cfif len($.content('credits'))><meta name="author" content="#HTMLEditFormat($.content('credits'))#" /></cfif>
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#" />
	<meta name="robots" content="noindex, follow" />
	<title>#HTMLEditFormat($.content('HTMLTitle'))# - #HTMLEditFormat($.siteConfig('site'))#</title>

	<link rel="icon" href="#$.siteConfig('assetPath')#/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="#$.siteConfig('assetPath')#/images/favicon.ico" type="image/x-icon" />	
	
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.min.css?" />
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/jquery/mobile/jquery.mobile.min.css" />
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/mobile/mobile.css" />
	
	<script src="#$.siteConfig('assetPath')#/jquery/jquery.js"></script>
	
	<script type="text/javascript">
      $(document).bind("mobileinit", function(){
            $.extend(  $.mobile , { 
                  ajaxEnabled : false,
				  pushStateEnabled : false
             });
      });
	 	 $(window).bind("resize", function(){
			var orientation = window.orientation;
			var new_orientation = (orientation) ? 0 : 180 + orientation;
			
			$('body').css({
				"-webkit-transform": "rotate(" + new_orientation + "deg)"
			});
		});
	</script>

	<script src="#$.siteConfig('assetPath')#/jquery/mobile/jquery.mobile.min.js"></script>
	<cfset rs=$.getBean('feedManager').getFeeds($.event('siteID'),'Local',true,true) />

</head>

<body id="#$.getTopID()#" class="depth#arrayLen($.event('crumbdata'))#">
<div data-role="page" data-theme="b">
	<cfif $.content('contentID') eq "00000000000000000000000000000000001">
		<h1 id="site-title">#HTMLEditFormat($.siteConfig('site'))#</h1>
	<cfelse>
	<div data-role="header" data-position="inline" data-theme="a">
		<a href="##" id="btn-back" data-icon="arrow-l">Back</a>
		<h1>#HTMLEditFormat($.siteConfig('site'))#</h1>
		<div><a href="#$.createHREF(filename='')#" rel="external" data-role="button" class="ui-btn-right">#$.rbKey("mobile.home")#</a></div>
	</div>
	<!-- /header -->
	</cfif>

	<div data-role="content" id="main">
		<cfif $.content('contentID') neq "00000000000000000000000000000000001"><h2>#HTMLEditFormat($.content('title'))#</h2></cfif>
		<cfif yesNoFormat($.content('hasMobileBody'))>
			#$.dspBody(body=$.content('mobileBody'),pageTitle='',crumbList=0,showMetaImage=0)#
		<cfelse>
			#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=0)#
		</cfif>
		<div id="block_land">Turn your device in landscape mode.</div>
		<!---#$.dspObjects($.siteConfig('primaryColumn'))#--->
		<cfif len(#$.content('firstRow')#)>
            <div id="firstRow" style="margin-right:50px;margin-left:30px;font-family:Arial, Helvetica, sans-serif">#$.content('firstRow')#</div>
        </cfif>
        <cfif len(#$.content('secondRow')#)>
          <div class="divider" ><img src="/default/images/space.gif" width="20" height="1" /></div>
          <div id="secondRow" style="margin-right:50px;margin-left:30px;font-family: Arial, Helvetica, sans-serif;">#$.content('secondRow')#</div>
        </cfif>
        <cfif len(#$.content('thirdRow')#)>
          <div class="divider" ><img src="/default/images/space.gif" width="20" height="1" /></div>
          <div id="thirdRow" style="margin-right:50px;margin-left:30px;font-family: Arial, Helvetica, sans-serif;">#$.content('thirdRow')#</div>
        </cfif>
        <cfif len(#$.content('fourthRow')#)>
          <div class="divider" ><img src="/default/images/space.gif" width="20" height="1" /></div>
          <div id="fourthRow" style="margin-right:50px;margin-left:30px;font-family: Arial, Helvetica, sans-serif;">#$.content('fourthRow')#</div>
        </cfif>
        <cfif len(#$.content('fifthRow')#)>
          <div class="divider" ><img src="/default/images/space.gif" width="20" height="1" /></div>
          <div id="fifthRow" style="margin-right:50px;margin-left:30px;font-family: Arial, Helvetica, sans-serif;">#$.content('fifthRow')#</div>
        </cfif>
        <cfif len(#$.dspObjects(2)#)>
          <cfif len(#$.content('firstRow')#)>
              <div class="divider" ><img src="/default/images/space.gif" width="20" height="1" /></div>
          </cfif>
          <div id="sixthRow" style="width:550px;margin-right:-10px;margin-left:10px;font-family: Arial, Helvetica, sans-serif;">#$.dspObjects(2)#</div>
        </cfif>
        <cfif len(#$.content('banner')#)>
        	<div style="min-width:1440px !important">#$.content('banner')#</div>
        </cfif>
        <cfif len(#$.content('Section1')#)>
        	<div style="min-width:1440px !important">#$.content('Section1')#</div>
        </cfif>
        	<div style="clear: both;"></div>
        <cfif len(#$.content('Section2')#)>
        	<div style="min-width:1440px !important">#$.content('Section2')#</div>
        </cfif>
        <cfif len(#$.content('Section3')#)>
        	<div style="min-width:1440px !important">#$.content('Section3')#</div>
        </cfif>
        <cfif len(#$.content('Section4')#)>
        	<div style="min-width:1440px !important">#$.content('Section4')#</div>
        </cfif>
        <cfif len(#$.content('Section5')#)>
        	<div style="min-width:1440px !important">#$.content('Section5')#</div>
        </cfif>
        <cfif len(#$.content('Section6')#)>
        	<div style="min-width:1440px !important">#$.content('Section6')#</div>
        </cfif>
        <cfif len(#$.content('OYM_Course_Description')#)>
       	 #$.content('OYM_Course_Description')#
        </cfif>
		
		<cfif $.content('contentID') eq "00000000000000000000000000000000001">
		<!---
		<div id="navHeader" class="header-fullscreen" data-role="header" data-nobackbtn="true" data-theme="a">
		<h1>More</h1>
		</div>
		--->
		
		<cf_CacheOMatic key="dspMobilePrimaryNav#$.content('contentID')#">
			#$.dspPrimaryNav(
				viewDepth="0",
				id="navPrimary",
				displayHome="never",
				closePortals="true",
				showCurrentChildrenOnly="false"
				)#
		</cf_cacheomatic>
		<cfelseif not listFindNoCase('Gallery,Portal',$.content('type'))>
		<!---
		<div id="navHeader" class="header-fullscreen" data-role="header" data-nobackbtn="true" data-theme="a">
		<h1>More</h1>
		</div>
		--->
		<div id="navSub">#$.dspSubNav()#</div>
		</cfif>
		
		
	</div><!-- /content -->

		<div data-role="footer"  data-theme="a" class="ui-bar">
				<a href="./?mobileFormat=false" rel="external">#$.rbKey("mobile.fullversion")#</a>
		</div><!-- /footer -->
	
</div><!-- /page -->

<script>
	$('body').live('pagebeforecreate',init);
	
	function init() {
	
	<!--- Primary Nav on Home Screen --->
	$('##navPrimary').attr({
 		'data-role': 'listview',
  		'data-inset': 'false',
  		'data-theme': 'c',
  		'data-dividertheme': 'b',
	});
	
	<!--- Secondary Nav --->
	$('##navSub ul').attr({
 		'data-role': 'listview',
  		'data-inset': 'false',
  		'data-theme': 'c',
  		'data-dividertheme': 'b'
	});
	
	$('##navSub li').attr({
 		'role': 'option',
 		'data-theme': 'c',
 		'tabindex': '0'
	});
	
	<!--- Indexes --->	
	$('.svIndex ul:first').attr({
 		'data-role': 'listview',
  		'data-inset': 'true',
  		'data-theme': 'c',
  		'data-dividertheme': 'b'
	});
	
	$('.svIndex .moreResults ul').attr({
			'data-role': 'controlgroup',
			'data-type': 'horizontal',
	});
	
	$('.svIndex .moreResults ul li').attr({
			'data-role': 'button',
			'data-theme': 'c'
	});
	<!--- Forms --->
	$('form ul, form ol').attr({
			'data-role': 'fieldcontain'
	});
	
	$('form li').attr({
			'data-role': 'controlgroup'
	});
	
	$('##btn-back').live('tap',function() {
	  history.back(); return false;
	}).live('click',function() {
	  history.back(); return false;
	});
	
}	
</script>

</body>	
</html>
</cfoutput>