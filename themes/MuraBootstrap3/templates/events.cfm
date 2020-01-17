<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<div class="container-fluid secondary-header row mb-2">
	<img alt="" src="/themes/MuraBootstrap3/images/events.jpg" />
		<div class="content">
			<h2>Events &amp; Classes</h2>
	   <p>The Latest Techniques. The Largest Coaching Network</p>
	   </div>

	</div>


	<div class="container mbt-1">
	  <div class="col-sm-9">
		   #$.dspBody(
			body=$.content('body')
			, crumbList=false
			, showMetaImage=false
		)#
		<cfif len(#$.dspObjects(2)#)>
			#$.dspObjects(2)#
		</cfif>
	  </div>
		   <!-- end col-sm-9 -->
		   <div class="col-sm-3">
		      <div class="mt-1">
		     <img src="#$.getURLForImage(fileid=$.content('fileid'))#" alt="" class="img-responsive">
		      <div class="caption mt-1">
		       	#$.content('rightpanel')#
		      </div><!-- end caption -->
		      </div>
			      <!--- additional information --->
			 <cfif len(trim($.content('additionalrightpanel')))>
			  <div class="mt-1">
		      <div class="color-bar"></div>
				#$.content('additionalrightpanel')#
		  	 </div>
		  	 </cfif>
		   </div>
      </div>
   </div><!-- end col-sm-3 -->

 </div>


	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>