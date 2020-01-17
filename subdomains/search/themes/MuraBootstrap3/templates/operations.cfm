<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<style>
		.morecontent span {
		    display: none;
		}
		.morelink {
		    display: block;
		}
		</style>
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

		<cfset feed=$.getBean('feed').loadBy(name='Operations')>
		<cfset iterator=feed.getIterator()>
		<cfif iterator.hasNext()>
			<cfloop condition="iterator.hasNext()">
				<cfset item=iterator.next()>
				<div class="row mt-1">
					<div class="col-md-4">
		  				<img src="#item.getImageURL()#" alt="#item.getTitle()#" class="img-responsive">
					</div><!-- end col-md-4 FACULTY IMAGE -->
					<div class="col-md-8">
		  				<h4 class="m-0">#item.getTitle()#</h4>
		  					<em>#item.getSummary()#</em>
		  					<div class="more customCollapse" id="#item.getURLTitle()#">
								<cfset newcontent = ReReplaceNoCase(item.getbody(),"/<p[^>]*?>/", "",'all') />
								<cfset newcontent = ReReplaceNoCase(item.getbody(),"<p>", "<br />",'all') />
								#left(newcontent,250)#<cfif len(newcontent) GT 250><span id="ellipses_#item.getURLtitle()#">...</span><span id="about_#item.getURLtitle()#" class="collapse">#mid(newcontent,251,len(newcontent))#</span></cfif>
							</div>
							<cfif len(newcontent) GT 250>
								<button type="button" id="more_#item.getURLTitle()#" data-toggle="collapse" data-target="##about_#item.getURLtitle()#" class="col-md-12 btn btn-expander">
								<span id="icon_#item.getURLTitle()#" class="pull-left collapseText" aria-hidden="true">EXPAND</span>
								<span id="text_#item.getURLTitle()#" class="glyphicon glyphicon-plus pull-right" aria-hidden="true"></span>
								</button>
							</cfif>

						<hr>
					</div><!-- end col-md-8 FACULTY PROFILE -->
				</div><!-- end row -->
			</cfloop>
		</cfif>
</div>



<!--- #$.getContentID()#<br />p:#$.getparent().getTitle()# --->
	<div class="col-sm-4">
		 <ul class="tert-nav">
			<cfif $.getparent().getContentID() EQ $.getTopVar('contentid')>
				#$.dspNestedNav(contentID='#$.getContentID()#',viewDepth=0,openPortals=false,displayHome='never')#
			<cfelseif $.getTopVar('contentid') NEQ $.getparent().getContentID() AND $.getparent().getTitle() NEQ 'Home'>
				#$.dspNestedNav(contentID='#$.getparent().getContentID()#',viewDepth=0,openPortals=false,displayHome='never',liCurrentClass='active')#
			</cfif>
		</ul>
		<!--- right panel --->
		 <div class="mt-2">
			 <img src="#$.getURLForImage(fileid=$.content('fileid'))#" alt="" class="img-responsive">
			    <div class="caption mt-1">
			     	#$.content('rightpanel')#
			    </div>
		 </div>
		 <!--- additional information --->
		 <cfif len(trim($.content('additionalrightpanel')))>
		  <div class="mt-1">
	      <div class="color-bar"></div>
			#$.content('additionalrightpanel')#
	  	 </div>
	  	 </cfif>
	</div><!-- end 4 -->
</div><!-- end container -->

	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>