<cfoutput>
	<!DOCTYPE html>
	<html lang="en"<cfif $.hasFETools()> class="mura-edit-mode"</cfif>>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<!---<link href='https://fonts.googleapis.com/css?family=Ubuntu:400,300,500,700' rel='stylesheet' type='text/css'>
		<link href="https://fonts.googleapis.com/css?family=Roboto+Slab" rel="stylesheet"> --->

		<link href="https://fonts.googleapis.com/css?family=Ubuntu:500,700&display=swap" rel="stylesheet"> 

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
		<style>
			label {
				display: block;
				padding-left: 15px;
				text-indent: -15px;
				margin-bottom: 10px;
			}

			input {
				padding: 0;
				margin: 0;
				vertical-align: bottom;
				position: relative;
				top: -6px;
			}
			.mura-editable-label{
				display:none
			}
			.form-group{
				margin-bottom: 30px;
			}
		</style>
	</head>
	<body>
	
	
		 
	</cfoutput>