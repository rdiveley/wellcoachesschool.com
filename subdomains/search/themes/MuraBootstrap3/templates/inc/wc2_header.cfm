<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<title>#$.content('title')#</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/_bootstrap.css" media="screen">
	    <link rel="stylesheet" type="text/css" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/animate.css" media="screen">
   		<link href='https://fonts.googleapis.com/css?family=Ubuntu:400,300,500,700' rel='stylesheet' type='text/css'>
	    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,600i,700|Open+Sans:300,400,600,700" rel="stylesheet">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body class="transTemp header-footer">
    <div class="fixedRail">
	<!-- <span style="color:##ffffff; position:relative; left:15px; top:5px; font-size:15px">menu</span> -->
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
          	#$.dspPrimaryNav(contentID='#$.content().getContentID()#',viewDepth=0, closePortals= true)#
        </ul>
      </nav>
      <div class="st-content">
        <div class="st-content-inner">

        <!-- main content for all pages -->
    <div class="adjust">
    <div class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <a href="/habits" class="navbar-brand"><img src="#$.siteConfig('themeAssetPath')#/images/logo.png" alt="wellcoaches logo" class="img-repsonsive"></a><span>SCHOOL of COACHING</span>
        </div>
        <div id="navbar-main">
          <ul class="nav navbar-nav navbar-right">
			<li><a href="/login/habits-login/" target="_blank">Log in</a></li>
            <li><a class="btn btn-primary btn-xs" href="/find-coach" target="_blank">Find a Coach</a></li>
			<li>
            	 <a type="submit" href="##"><i class="glyphicon glyphicon-search" aria-hidden="true"></i></a>
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