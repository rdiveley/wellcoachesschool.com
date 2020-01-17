<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/habits_header.cfm">

<cfoutput>
<div class="mainContent">
    <!-- SECONDARY NAV -->
    <div class="secondaryNav">
      	<div class="container" >
      		#$.dspNestedNav(contentID='#$.getTopVar('contentid')#',liCurrentClass='active')#
    	</div><!-- end contianer -->
    </div><!-- end secondaryNav -->

<div class="mbt-1 pb-2 flex-container flex-center-items container">
      <div class="f-5">
       <h2>#$.content('firstrowtitle')#</h2>
		<p>#$.content('firstrow')#</p>
      </div>
      <div class="f-5">
      <img src="#$.getURLForImage(fileid=$.content('firstrowimage'))#" class="img-responsive center-block" alt="">
    </div>
</div><!-- .end flex-container -->

<div class="mbt-1 pt-2 pb-2 flex-container container flex-center-items">
      <div class="f-4">
       	<h2 class="">#$.content('secondrowtitle')#</h2>
		<p>#$.content('secondrow')#</p>
      </div>
      <div class="f-6" >
       	<span class="center-block">#$.content('secondrowimage')#</span>
      	<p class="text-center mt-1">#$.content('secondrowVideoTitle')#</p>
    </div>
 </div><!-- .end flex-container -->

<div class="mbt-1 pt-2 pb-2 flex-container flex-center-items container">
      <div class="f-6">
        <span class="center-block">#$.content('thirdrowimage')#</span>
      	<p class="text-center mt-1">#$.content('thirdrowVideoTitle')#</p>
      </div>
      <div class="f-4">
      	<h2>#$.content('thirdrowtitle')#</h2>
      	<p>#$.content('thirdrow')#</p>
    </div>
 </div><!-- .end flex-container -->

<div class="mbt-1 pt-2 pb-2 flex-container flex-center-items container">
      <div class="f-4">
      	<h2>#$.content('fourthrowtitle')#</h2>
       	<p>#$.content('fourthrow')#</p>
      </div>
      <div class="f-6">
      	<span class="center-block">#$.content('fourthrowimage')#</span>
      	<p class="text-center mt-1">#$.content('fourthrowVideoTitle')#</p>
    </div>
</div><!-- .end flex-container -->

<div class="mb-2 pt-2 pb-2 flex-container flex-center-items container">
      <div class="f-6">
        <span class="center-block">#$.content('fifthrowimage')#</span>
        <p class="text-center mt-1">#$.content('fifthrowVideoTitle')#</p>
      </div>
      <div class="f-4">
      	<h2>#$.content('fifthrowtitle')#</h2>
      	<p>#$.content('fifthrow')#</p>
    </div>
</div><!-- .end flex-container -->

<div class="mbt-1 orangeBand">
  <div class="text-center p-2f">
      <div class="row text-center onSale mt-2 flex-container flex-center-items flex-column flex-center-justify">
        #$.content('sixthrow')#
	  </div>
  </div>
</div>
</cfoutput>
<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/habits_footer.cfm">