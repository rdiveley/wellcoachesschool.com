<cfoutput>
<!DOCTYPE html>
<html lang="en"<cfif $.hasFETools()> class="mura-edit-mode"</cfif>>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--- <meta name="description" content="#HTMLEditFormat($.getMetaDesc())#" />
	<meta name="keywords" content="#HTMLEditFormat($.getMetaKeywords())#" /> --->
	<cfif request.contentBean.getCredits() neq ""><meta name="author" content="#HTMLEditFormat($.content('credits'))#" /></cfif>
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#" />

	<title>#$.content('HTMLTitle')#</title>
	<!--- Mura CMS Base Styles--->
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.6.2.min.css">
	<!--- Optional: Mura CMS Skin Styles. Duplicate to your theme to customize, changing 'assetPath' to 'themeAssetPath' below. Don't forget to move, remove or replace sprite.png. --->
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.6.2.skin.css">

	<!--- Bootstrap core CSS --->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/animate.css"  media="screen">
	<!--- Font Awesome --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/font-awesome/css/font-awesome.css">
 	<!--- add Ubuntu  --->
	<link href='https://fonts.googleapis.com/css?family=Ubuntu:400,300,500,700' rel='stylesheet' type='text/css'>
	<!---
				THEME CSS
				This has been compiled using a pre-processor such as CodeKit or Prepros
	--->
	<!--- <link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/theme/theme.min.css"> --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/_bootstrap.css"  media="screen">
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/animate.css"  media="screen">
	<link href='https://fonts.googleapis.com/css?family=Ubuntu:400,300,500,700' rel='stylesheet' type='text/css'>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<!--[if IE]>
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/ie/ie.min.css">
	<![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="#$.siteConfig('themeAssetPath')#/js/html5shiv/html5shiv.js"></script>
	<script src="#$.siteConfig('themeAssetPath')#/js/respond/respond.min.js"></script>
	<![endif]-->

	<!--- jQuery --->

	<script src="#$.siteConfig('assetPath')#/jquery/jquery.js"></script>

	<!--- FAV AND TOUCH ICONS --->
	<link rel="shortcut icon" href="#$.siteConfig('assetPath')#/images/logo.jpg">
	<!--- <link rel="apple-touch-icon-precomposed" sizes="144x144" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-57-precomposed.png"> --->

	<!--- MURA FEEDS --->
<!---
	<cfset rs=$.getBean('feedManager').getFeeds($.event('siteID'),'Local',true,true) />
	<cfset apiEndpoint=$.siteConfig().getApi('feed','v1').getEndpoint() />
	<cfloop query="rs"><link rel="alternate" type="application/rss+xml" title="#esapiEncode('html_attr', $.siteConfig('site'))# - #esapiEncode('html_attr', rs.name)#" href="#XMLFormat('#apiEndpoint#/?feedID=#rs.feedID#')#"></cfloop>
 --->
	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-50129128-1', 'auto');
	  ga('send', 'pageview');

	</script>
	<!-- Global site tag (gtag.js) - Google Ads: 967526309 --> 
	<script async src="https://www.googletagmanager.com/gtag/js?id=AW-967526309"></script> 
	<script> window.dataLayer = window.dataLayer || []; 
			function gtag(){dataLayer.push(arguments);} 
			gtag('js', new Date()); 
			gtag('config', 'AW-967526309'); 
	</script>
</head>
<body>
<div class="fixedRail"><span style="color:##ffffff; position:relative; left:15px; top:5px; font-size:15px">menu</span>
    <div id="trigger">
      <a href="##" id="nav-icon1">
        <span></span>
        <span></span>
        <span></span>
    </a>
    </div>
    </div>
    <div id="st-container" class="st-container">
    <div class="st-pusher">
      <nav class="st-menu st-effect-3" id="menu-3">
        <ul>
          #$.dspPrimaryNav(contentID='#$.content().getContentID()#',viewDepth=0, closePortals= true, displayHome='always')#
        </ul>
      </nav>

      <div class="st-content">
        <div class="st-content-inner">
          <!-- <div id="st-trigger-effects" class="column">
            <button data-effect="st-effect-3" class="hnav">Click me</button>
          </div> -->
        <!-- main content for all pages -->
    <div class="adjust">
    <div class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <a href="/" class="navbar-brand"><img src="#$.siteConfig('themeAssetPath')#/images/Logo.png" alt="wellcoaches logo" class="img-repsonsive"></a><span>SCHOOL of COACHING</span>
        </div>
        <div id="navbar-main">

          <ul class="nav navbar-nav navbar-right">
            <li><a href="/login/">Log in</a></li>
            <li><a class="btn btn-primary btn-xs" href="/find-coach">Find a Coach</a></li>
            <li>
                <a type="submit" href="##"><i class="glyphicon glyphicon-search"></i></a>
            </li>
          </ul>

          <form action="/search-results/" id="searchForm">
              <legend class="sr-only">Form title</legend>
				 <input type="hidden" name="display" value="search" />
                  <input type="hidden" name="newSearch" value="true" />
                  <input type="hidden" name="noCache" value="1" />

              <div class="row col-xs-11 col-sm-11 col-md-11 col-lg-11 p-0 mainSearchContainer">
                  <label for="mainSearch" class="sr-only">Search</label>
                  <input type="text" class="form-control mb-1" id="mainSearch" name="Keywords" placeholder="Search...">
              </div>
          </form>
		</div>
      </div>
    </div>
</cfoutput>