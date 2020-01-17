<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/habits_header.cfm">
 <cfoutput>
<div class="mainContent">
    <!-- SECONDARY NAV -->
    <div class="secondaryNav">
      	<div class="container" >
      		#$.dspNestedNav(contentID='#$.getTopVar('contentid')#',liCurrentClass='active')#
    	</div><!-- end contianer -->
    </div><!-- end secondaryNav -->
	<div class="mbt-1 flex-container flex-center-items container">
	      <div class="f-5">
	       <h2>#$.content('firstrowtitle')#</h2>
			<p>#$.content('firstrow')#</p>
	      </div>
	      <div class="f-5">
			 <img src="#$.getURLForImage(fileid=$.content('firstrowimage'))#" class="img-responsive center-block" alt="">
	    </div>
	 </div><!-- .end flex-container -->

	<h2 class="text-center m-2 special"><span>How it Works</span></h2>

	<div class="mbt-1 flex-container flex-center-items container">

	      <div class="f-5">
	        <img src="#$.getURLForImage(fileid=$.content('secondrowimage'))#" class="img-responsive center-block" alt="">
	      </div>

	      <div class="f-5">
	      <h2>#$.content('secondrowtitle')#</h2>
	     	#$.content('secondrow')#
	    </div>

	 </div><!-- .end flex-container -->

	<div class="mbt-1 flex-container flex-center-items container">

	      <div class="f-5">
	       <h2>#$.content('thirdrowtitle')#</h2>
	     	#$.content('thirdrow')#
	      </div>

	      <div class="f-5">
	      <img src="#$.getURLForImage(fileid=$.content('thirdrowimage'))#" class="img-responsive center-block" alt="">
	    </div>

	 </div><!-- .end flex-container -->


	<div class="mb-2 mt-5 flex-container flex-center-items container">

      <div class="f-5">
        <img src="#$.getURLForImage(fileid=$.content('fourthrowimage'))#" class="img-responsive center-block" alt="">
      </div>

      <div class="f-5">
      	<h2>#$.content('fourthrowtitle')#</h2>
      	#$.content('fourthRow')#
      </div>

 	</div><!-- .end flex-container -->

	 <div class="mbt-1 flex-container  container">
	      <div class="f-5">
	       <h2>#$.content('fifthrowtitle')#</h2>
	      	#$.content('fifthRow')#
	      </div>
	      <div class="f-5">
	      <img src="#$.getURLForImage(fileid=$.content('fifthrowimage'))#" class="img-responsive center-block" alt="">
	    </div>

	 </div><!-- .end flex-container -->
	<div class="mbt-1 bg-gray-light-blended">
	  <div class="text-center p-2f">
	    <img src="#$.getURLForImage(fileid=$.content('sixthrowimage'))#" alt="" class="img-responsive center-block" style="padding-right:100px;" >
	     <cfif len($.content('sixthrowtitle'))>
	      <!-- <div class="p-2f"> -->
	        <h2>#$.content('sixthrowtitle')#</h2>
	      <!-- </div> -->
	      </cfif>
			<cfset feed=$.getBean('feed').loadBy(name='Habits-keystone')>
			<cfset iterator=feed.getIterator()>
			<cfif iterator.hasNext()>
			<cfset idx = 0>
			<div class="numberSeries row">
				<cfloop condition="iterator.hasNext()">
					<cfset item=iterator.next()>
					<cfset idx++>
			      	<div class="col-xs-12 <cfif idx EQ 1>col-sm-2 col-sm-offset-2<cfelseif idx EQ 2>col-sm-3<cfelse>col-sm-2</cfif>">
						#item.getTitle()#
						<cfif idx EQ 3><span></span></cfif>
				      <small>#item.getSummary()#</small>
				    </div>
				</cfloop>
			 </div><!-- end numberSeries -->
			</cfif>
		#$.content('sixthrow')#
	  </div>
	</div>
</div>
<!-- end mainContent -->
</cfoutput>
<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/habits_footer.cfm">