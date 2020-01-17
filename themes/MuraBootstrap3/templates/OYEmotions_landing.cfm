<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_header.cfm">
 <nav id="myNavmenu" class="navmenu navmenu-inverse navmenu-fixed-left offcanvas" role="navigation">
        <div class="navmenu-brand">Organize Your Emotions, Optimize Your Life</div>
        <ul class="nav navmenu-nav">
			<li><a href="/">Wellcoaches Home</a></li></li>
			<li><a href="/organize-your-emotions/">Home</a></li></li>
			<li><a href="/organize-your-emotions/resources/">Resources</a></li>
			<li><a href="/organize-your-emotions/press-and-praise/">Press &amp; Praise</a></li>
        </ul>
    </nav>
    <div class="navbar navbar-default navbar-fixed-left">
        <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-target="#myNavmenu" data-canvas="body">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>
 <cfoutput>
<div class="section section-site-title">
        <div class="container">
            <div class="row site-title">
                <div class="col-lg-12">
                    <h2><a href="/resources/"><i>Organize Your Emotions, Optimize Your Life</i></a></h2>
                </div>
            </div>
        </div>
    </div>
	<div class="col-md-12">

		<div class="col-md-6">
			<h3>#$.content('title')#</h3>
			#$.content('body')#
		</div>
		<div class="col-md-3">
			<div>&nbsp;</div>
			<cfif len($.content('fileid'))>
				<img class='shadowed' src="#$.getURLForImage(fileid=$.content('fileid'),size='authorimage')#">
			</cfif>
		</div>
	</div>

</cfoutput>
<div style="position: fixed;
Width: 100%;
bottom: 0;">
<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_footer.cfm">
</div>