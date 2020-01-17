<cfoutput>
	<cfinclude template="inc/wc2_header.cfm" />


    <div id="mainCarousel" class="carousel slide" data-ride="carousel">

          <div class="carousel-inner" role="listbox">
            <div class="item active">

			<img src="#$.getURLForImage(fileid=$.content('fileid'))#"  alt="">
              <div class="container">
                <div class="coverMe">
                <div class="still-caption">
                	#$.content('headerTagLine')#
                </div>
                </div><!-- end coverMe -->
              </div>
            </div>
          </div>

        </div>
        <!-- end mainCarousel -->
  <div class="mainContent">
    <!-- SECONDARY NAV -->
   <div class="secondaryNav">
      	<div class="container" >
      		#$.dspNestedNav(contentID='#$.getTopVar('contentid')#',liCurrentClass='active')#
    	</div><!-- end contianer -->
    </div><!-- end secondaryNav -->
	<!-- firstrow -->
<div class="mbt-1 flex-container flex-center-items container">

      <div class="f-5 bio">
      	<p>#$.content('firstrow')#</p>
	  </div>

      <div class="f-5">
      	<img src="#$.getURLForImage(fileid=$.content('firstrowImage'))#" class="img-responsive center-block"   alt="">
    </div>

 </div><!-- .end flex-container -->
<!-- secondrow -->
<div class="flex-container flex-center-items container roundCallout mt-3 mb-3">
        <div class="f-2">
			<img src="#$.getURLForImage(fileid=$.content('secondrowImage'))#" class="img-responsive center-block"   alt="">
        </div>
        <div class="f-8">
          <p>#$.content('secondrow')#</p>
        </div>
 </div><!-- .end flex-container -->
<p>&nbsp;</p>
<p>&nbsp;</p>
 <!-- thirdrow -->
 <div class="mb-2 mt-5 flex-container flex-center-items container line-height-secondary">

  <div class="f-5">
    <img src="#$.getURLForImage(fileid=$.content('thirdrowImage'))#" class="img-responsive center-block"   alt="">
  </div>

  <div class="f-5">
  	<p>#$.content('thirdrow')#</p>
  </div>

</div><!-- .end flex-container -->

<!-- fourthrow -->
<div class="mbt-1 flex-container flex-center-items container line-height-secondary">

      <div class="f-5">
		<p>#$.content('fourthrow')#</p>
      </div>

      <div class="f-5">
      	<img src="#$.getURLForImage(fileid=$.content('fourthrowImage'))#" class="img-responsive center-block"   alt="">
      </div>

 </div><!-- .end flex-container -->

<!-- fifthrow -->
<div class="mbt-3 flex-container flex-center-items container line-height-secondary">

      <div class="f-5">
        #$.content('fifthrowimage')#
      </div>

      <div class="f-5">
		<p>#$.content('fifthrow')#</p>
      </div>

 </div><!-- .end flex-container -->
<!-- sixthrow -->
 <div class="mbt-3 flex-container  container line-height-secondary">

      <div class="f-5">
		<p>#$.content('sixthrow')#</p>
      </div>

      <div class="f-5">
     	<img src="#$.getURLForImage(fileid=$.content('sixthrowImage'))#" class="img-responsive center-block"   alt="">
      </div>

 </div><!-- .end flex-container -->
<!-- seventhrow -->
 <div class="mbt-3 flex-container flex-center-items container line-height-secondary">

  <div class="f-5">
    <img src="#$.getURLForImage(fileid=$.content('seventhrowImage'))#" class="img-responsive center-block"   alt="">
  </div>

  <div class="f-5">
 	<p>#$.content('seventhrow')#</p>
  </div>

</div><!-- .end flex-container -->
	<cfinclude template="inc/wc2footer.cfm" />
</cfoutput>
