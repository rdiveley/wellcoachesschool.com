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

<div class="container">
	<!-- breadcrumb -->
	<ol class="breadcrumb">
	  #$.dspCrumbListLinks("crumblist","","1")#
	</ol><!-- end breadcrumb -->
	<div class="col-sm-8">
		<cfif len($.content('customtitle'))>
			<h2 class="mt-0">#$.content('customtitle')# </h2>
		<cfelse>
			<h2 class="mt-0">#$.content('title')# </h2>
		</cfif>

		#$.dspBody(
			body=$.content('body')
			, crumbList=false
			, showMetaImage=false
		)#
</div>

	<div class="col-sm-4">
		 <ul class="tert-nav">
			<cfif $.getparent().getContentID() EQ $.getTopVar('contentid')>
				#$.dspNestedNav(contentID='#$.getContentID()#',viewDepth=0,openPortals=false,displayHome='never')#
			<cfelseif $.getTopVar('contentid') NEQ $.getparent().getContentID() AND $.getparent().getTitle() NEQ 'Home'>
				#$.dspNestedNav(contentID='#$.getparent().getContentID()#',viewDepth=0,openPortals=false,displayHome='never',liCurrentClass='active')#
			</cfif>
		</ul>

	</div><!-- end 4 -->
</div><!-- end container -->

  <div class="container-fluid bg-gray-lighter row mbt-1">
    <!-- photo left - text right -->
    <div class="col-sm-12 col-md-5 col-lg-5 row">
       <img src="#$.getURLForImage(fileid=$.content('facultyImage'))#" class="img-responsive center-block" alt="">
    </div>
      <div class="col-sm-12 col-md-6 col-lg-6 p-2f">
       	#$.content('faculty')#
      </div>

</div><!-- end container fluid-->
<!-- text left - photo right -->
  <div class="container-fluid bg-gray-lighter row mbt-1">
	  <div class="col-sm-12 col-md-4 col-md-offset-1">
       	#$.content('operations')#
	 </div>
	 <div class="col-sm-12 col-md-7 pull-right">
      <img src="#$.getURLForImage(fileid=$.content('operationsImage'))#" class="img-responsive center-block" alt="">
    </div>

</div><!-- end container fluid-->


	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>