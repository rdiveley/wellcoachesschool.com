<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<div class="container">
		<cfif len($.dspNestedNav(contentID='#$.getTopVar('contentid')#'))>
		    <!-- secondary navigation -->
		    <nav class="navbar navbar-secondary">
			  <div class="container-fluid">
			    <!-- Brand and toggle get grouped for better mobile display -->
			    <div class="navbar-header">
			      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##secondary-nav" aria-expanded="false">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </div>

			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="secondary-nav">
					#$.dspNestedNav(contentID='#$.getTopVar('contentid')#',viewDepth=0,openPortals=false,displayHome='never',class='nav navbar-nav',liCurrentClass='active')#
				</div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>
		</cfif>
	 </div><!-- end container -->

<hr>

 <div class="container-fluid secondary-header row mb-2">
    <img src="#$.getURLForImage(fileid=$.content('banner'))#" alt="">
   <div class="content">
   <h2>#$.content('bannerText')#</h2>
   <p>#$.content('bannerTagLine')#</p>
   </div>
 </div>
 <div class="container mbt-1">

   <div class="col-md-9 ">
<!---     <cfif len($.content('customtitle'))>
			<h3 class="mt-0">#$.content('customtitle')# </h3>
		<cfelse>
			<h3 class="mt-0">#$.content('title')# </h3>
		</cfif> --->
    	#$.content('body')#
   </div>

   <div class="col-md-3">
     <img src="#$.getURLForImage(fileid=$.content('fileid'))#" alt="" class="img-responsive">
    <div class="caption mt-1">
     	#$.content('rightpanel')#
    </div>
    <div class="mt-2 red-panel">
      <div class="panel-heading"><strong>Our Team</strong></div>
     	#$.content('additionalrightpanel')#
    </div>
   </div>

 </div>

	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>