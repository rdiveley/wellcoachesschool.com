<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_header.cfm">
 <nav id="myNavmenu" class="navmenu navmenu-inverse navmenu-fixed-left offcanvas" role="navigation">
        <div class="navmenu-brand">Organize Your Emotions, Optimize Your Life</div>
		<cfoutput>
        <ul class="nav navmenu-nav">
			<li><a href="/organize-your-emotions/">Home</a></li></li>
            <li class='active'><a href="/organize-your-emotions/resources/">Resources</a></li>
			<li ><a href="/organize-your-emotions/press-and-praise/">Press &amp; Praise</a></li>
			<li><a href="/">Wellcoaches Home</a></li></li>
		</ul>
		</cfoutput>
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
					 <h1 class="page-title">#$.content('title')#</h1>
                </div>
            </div>
        </div>

        <div class="container">
			<cfset feed=$.getBean('feed').loadBy(name='Book Resources')>
			<cfset iterator=feed.getIterator()>
			<cfif iterator.hasNext()>
				<cfset idx = 0>
				<cfloop condition="iterator.hasNext()">
					<cfset item=iterator.next()>
	        		<cfset idx++>
					 <cfif idx mod 2 EQ 0 ><div class="row"></cfif>
			                <div class="col-sm-6">
			                    <div class="thumbnail">
									<img src="#item.getImageURL()#" style="height: auto; width: 100%; display: block;">
			                        <div class="caption">
			                            <h3>#item.getTitle()#</h3>
										<p>#item.getBody()#</p>
										<cfif len(item.getbuttonLink())>
											<p><a href="#item.getbuttonLink()#" target="_blank" class="btn btn-primary" role="button">#item.getButtonText()#</a></p>
			                        	<cfelse>
											<p><a href="#$.getURLForFile(fileid=item.getuploadfile(),method='attachment')#" target="_blank" class="btn btn-primary" role="button">#item.getButtonText()#</a></p>
			                        	</cfif>
									</div>
			                    </div>
			                </div>
						<cfif idx mod 2 EQ 0 ></div></cfif>
				</cfloop>
			</cfif>
         </div>
    </div>

</cfoutput>

<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_footer.cfm">
