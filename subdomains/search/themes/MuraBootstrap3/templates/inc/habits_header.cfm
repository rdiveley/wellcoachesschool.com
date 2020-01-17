<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<title>#$.content('title')#</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   		<link rel="stylesheet" type="text/css" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/_bootstrap-habits.css" media="screen">
	    <link rel="stylesheet" type="text/css" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/animate.css" media="screen">
   		<!-- <link href='https://fonts.googleapis.com/css?family=Ubuntu:400,300,500,700' rel='stylesheet' type='text/css'> -->
	    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,600i,700|Open+Sans:300,400,600,700" rel="stylesheet">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<body class="transTemp">
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
          	#$.dspPrimaryNav(contentID='#$.content().getContentID()#',viewDepth=0, closePortals= true)#
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
          <a href="/habits" class="navbar-brand"><img src="#$.siteConfig('themeAssetPath')#/images/well_logo.png" alt="wellcoaches logo" class="img-repsonsive"></a>
        </div>
        <div id="navbar-main">

          <ul class="nav navbar-nav navbar-right">
            <li>
                <a type="submit" href="##"><i class="fa fa-search" aria-hidden="true"></i></a>
            </li>
            <li><a href="/find-coach" target="_blank">Find a coach</a></li>
            <li><a class="btn btn-habitslogin btn-xs" href="/login/habits-login/" target="_blank"><i class="fa fa-user-o p-1r" aria-hidden="true"></i>habits login <i class="p-1l fa fa-angle-right" aria-hidden="true"></i></a></li>
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
	 <cfset feed=$.getBean('feed').loadBy(name='Habits')>
	<cfset iterator=feed.getIterator()>
	<cfset loopCount = iterator.recordcount()-1>


   <div id="mainCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
		<cfloop from="0" to="#loopCount#" index="item">
            <li data-target="##mainCarousel" data-slide-to="#item#" <cfif item EQ 0>class="active"</cfif>></li>
        </cfloop>
        </ol>

	<cfif iterator.hasNext()>
			<!--- Carousel items --->
			<div class="carousel-inner" role="listbox">
				<cfset idx = 0>
				<cfloop condition="iterator.hasNext()">
					<cfset item=iterator.next()>
						<cfset idx++>
						<div class="item<cfif idx eq 1> active</cfif>">
							<img src="#item.getImageURL()#" class="img-responsive">
				              <div class="container ">
			                	<div class="coverMe">
			                		<div class="carousel-caption">
					                 <h1>#item.getHeader()#</h1>
					                  <p>#item.getTagLine()#</p>
			                  			<a href="#item.getButtonLink()#" class="btn btn-lg btn-primary"  role="button">#item.getButtonText()#</a>
			                		</div>
			                	</div><!-- end coverMe -->
			              </div>
						</div>
				</cfloop>
			</div>
			<cfif idx>
				<!--- Carousel nav --->
				<cfif idx gt 1>
					  <a class="left carousel-control" href="##mainCarousel" role="button" data-slide="prev">
			            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			            <span class="sr-only">Previous</span>
			          </a>
			          <a class="right carousel-control" href="##mainCarousel" role="button" data-slide="next">
			            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			            <span class="sr-only">Next</span>
			          </a>
				</cfif>
			</cfif>
		</div>
	</cfif>
   <!-- end mainCarousel -->
</cfoutput>