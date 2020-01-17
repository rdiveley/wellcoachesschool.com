<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_header.cfm">
 <nav id="myNavmenu" class="navmenu navmenu-inverse navmenu-fixed-left offcanvas" role="navigation">
        <div class="navmenu-brand">Organize Your Emotions, Optimize Your Life</div>
        <ul class="nav navmenu-nav">
			<li><a href="/organize-your-emotions/">Home</a></li></li>
			<li><a href="/organize-your-emotions/resources/">Resources</a></li>
			<li class='active'><a href="/organize-your-emotions/press-and-praise/">Press &amp; Praise</a></li>
			<li><a href="/">Wellcoaches Home</a></li></li>
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
	 <div class="section section-site-title press-and-praise-title"></div>

<div class="section section-resources">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="super-header">Organize Your Emotions, Optimize Your Life</div>
					 <h1 class="page-title">Press &amp; Praise</h1>
                </div>
            </div>
        </div>
		<div>
			<div class="col-md-6 ">
				<cfset PRLinks=$.getBean('feed').loadBy(name='AllPRLinks')>
				<cfset iterator=PRLinks.getIterator()>
				<cfif iterator.recordcount() >
					<cfif iterator.hasNext()>
						<cfset currentrow = 1>
						<cfloop condition="iterator.hasNext()">
							<cfset item=iterator.next()>
								<cfif !isValid("email", item.getbody())>
									<p><a href="#item.getbody()#"  target="_blank"><span class="glyphicon glyphicon-link" aria-hidden="true"></span>#item.getTitle()#</a></p>
									<cfset currentrow++>
								</cfif>
						</cfloop>
					</cfif>
				</cfif>
			</div>
			<div class="col-sm-6 ">
				<img src="#$.getURLForImage(fileid=$.content('fileid'))#"  alt="">
			</div>
		</div>
<div class="container">
	<div class="row">
		&nbsp;
	</div>
</div>
<div class="container">
	<div class="row">
		&nbsp;
	</div>
</div>
<div class="container">
	<div class="row">
		&nbsp;
	</div>
</div>
	</cfoutput>
<!--- <div style="background: red; position: fixed;
    left: 60px;
    right: 0px;
    bottom: 0;
   "> --->
<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_footer.cfm">
<!--- </div> --->
