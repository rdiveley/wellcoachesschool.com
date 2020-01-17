<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<div class="container-fluid secondary-header row mb-2">
	<cfif len($.content('bannerImage'))>
		<img src="#$.getURLForImage(fileid=$.content('bannerImage'))#" alt="" class="img-responsive">
	<cfelse>
		<img alt="" src="/themes/MuraBootstrap3/images/events.jpg" />
	</cfif>
		<div class="content">
			<h2>#$.content('bannerText')#</h2>
	   		<cfif len($.content('bannerSubText'))><p>#$.content('bannerSubText')#</p></cfif>
	   </div>

	</div>
	<!--- <div class="container">
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

<hr> --->

<div class="container">

	<!--- <!-- breadcrumb -->
	<ol class="breadcrumb">
	  #$.dspCrumbListLinks("crumblist","","1")#
	</ol><!-- end breadcrumb --> --->
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

		<cfset feed=$.getBean('feed').loadBy(name='Events')>
		<cfset iterator=feed.getIterator()>
		<cfif iterator.hasNext()>
			<cfloop condition="iterator.hasNext()">
				<cfset item=iterator.next()>
				<div class="mt-2 col-md-12">

					<div class="col-md-4 bg-gray-lighter event-block">
					  <span>#item.getTitle()#</span>
					  <date>#item.getSummary()#</date>
					</div><!-- end event-block -->

					<div class="col-md-8 event-detail">
						#item.getbody()#
					</div><!-- end event-detail -->

					</div><!-- end mt-2 -->
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