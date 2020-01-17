<cfoutput>
	<cfinclude template="inc/html_head.cfm" />

<div class="container">
    <!-- secondary navigation -->
	<cfif len($.dspNestedNav(contentID='#$.getTopVar('contentid')#')) >
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

 <div class="container-fluid secondary-header row mb-2">
	<img src="#$.getURLForImage(fileid=$.content('headerimage'))#"  alt="">
   <div class="content">
   <h2><cfif len($.content('bannerText'))>#$.content('bannerText')#<cfelse>#$.content('title')#</cfif></h2>
   <p>#$.content('headertext')#</p>
   </div>
 </div>

 <div class="container mbt-1">
	<div class="col-md-7 ">
     <h3 class="m-0">#$.content('firstrowtitle')#</h3>
    	#$.content('firstrow')#
	</div>

	<div class="col-md-4 red-panel">
		     <div class=""></div>
		    	#$.content('firstrowregistration')#
		    </div>
	  </div>



	<!--- <div class="col-md-4 red-panel">
     <div class="panel-heading"><strong>Registration</strong></div>
     <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sit unde eius iure praesentium, quibusdam maxime in omnis quaerat. Omnis voluptates fugit dignissimos magni perspiciatis aperiam, nulla ratione commodi aliquam aspernatur.</p>
     <p><a href="##">Learn More &##10095;</a></p>
   </div>

</div> --->
</div>
	<!--- what you'll learn --->
  <div class="container-fluid bg-gray-lighter row mbt-1">
    <!-- photo left - text right -->
     <div class="col-sm-12 col-md-7 col-lg-7">
       <img src="#$.getURLForImage(fileid=$.content('secondrowimage'))#" class="img-responsive center-block" alt="">
    </div>
      <div class="col-sm-12 col-md-5 col-lg-5 row">
       #$.content('secondrow')#
      </div>
</div>
<!-- end container fluid-->
<!-- text left - photo right -->
<!--- Cirriculum  --->
<cfif len($.content('thirdrow'))>
  <div class="container-fluid bg-gray-lighter row mbt-1">

      <div class="col-sm-12 col-md-5 col-lg-5">
       #$.content('thirdrow')#
      </div>

      <div class="col-sm-12 col-md-7 pull-right">
	    <img src="#$.getURLForImage(fileid=$.content('thirdrowimage'))#" class="img-responsive center-block" alt="">
    </div>

 </div><!-- end container fluid-->
</cfif>
<!--- Pre-requisite --->
<cfif len($.content('fourthrow'))>
  <div class="container-fluid bg-gray-lighter row mbt-1">
      <div class="col-sm-12 col-md-6 col-lg-6">
		<cfif len($.content('video'))>
			 <div class="img-responsive col-md-offset-1">#$.content('video')#</div>
		<cfelse>
      		<img src="#$.getURLForImage(fileid=$.content('fourthrowimage'))#" class="img-responsive center-block" alt="">
		</cfif>
      </div>
	 <div class="col-sm-12 col-md-5 col-lg-5 row">
      #$.content('fourthrow')#
    </div>
 </div><!-- end container fluid-->
</cfif>
<!--- Core certificatino --->
<cfif len($.content('fifthrow'))>
	  <div class="container-fluid bg-gray-lighter row mbt-1">

	      <div class="col-sm-12 col-md-4 col-md-offset-1">
	      #$.content('fifthrow')#
	      </div>

	    <div class="col-sm-12 col-md-7 pull-right">
			<img src="#$.getURLForImage(fileid=$.content('fifthrowimage'))#" class="img-responsive center-block" alt="">
	    </div>
	</div><!-- end container fluid-->
</cfif>
<cfif len($.content('sixthrow'))>
  <div class="container-fluid bg-gray-lighter row mbt-1">
    <!-- photo left - text right -->
    <div class="col-sm-12 col-md-5 col-lg-5 row">
       <img src="#$.getURLForImage(fileid=$.content('sixthrowimage'))#" class="img-responsive center-block" alt="">
    </div>
      <div class="col-sm-12 col-md-6 col-lg-6 col-md-offset-1">
       #$.content('sixthrow')#
      </div>
</div>
</cfif>

	<cfif $.getTopVar('contentid') NEQ $.getContentID()>
		#$.dspNestedNav(contentID='#$.getContentID()#',viewDepth=1,openPortals=false,displayHome='never')#
	</cfif>
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>