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
        <div class="container">

            <div class="row">
                <div class="col-sm-12 col-md-9 text-left">
				<cfset feed=$.getBean('feed').loadBy(name='Testimonials')>
					<cfset iterator=feed.getIterator()>
					<cfif iterator.hasNext()>
						<cfloop condition="iterator.hasNext()">
							<cfset item=iterator.next()>
		           			   <div class="row author-avatar-sm">
			                        <div class="col-xs-2"><img src="#item.getImageURL(size='medium')#" class="img-responsive" /></div>
			                        <div class="col-xs-10 col-sm-10 col-md-9">
			                            <h4>#item.getTitle()#</h4>
			                            #item.getSummary()#
			                            <p>#item.getBody()#</p>
			                        </div>
			                    </div>

			                     <hr/>
							</cfloop>
					</cfif>

				</div>
				<cfset PRLinks=$.getBean('feed').loadBy(name='PRLinks')>

				<cfset iterator=PRLinks.getIterator()>
				<cfif iterator.recordcount() >
	                <div class="col-md-3">
	                    <h3>Press</h3>
	                    <ul class="list-unstyled list-pr">

							<cfif iterator.hasNext()>
								<cfset currentrow = 1>
								<cfloop condition="iterator.hasNext()">
									<cfset item=iterator.next()>
				           			 <cfif isValid("email", item.getbody()) >
					           	      <cfif ! structKeyExists(local,'showPressInqueries')>
					           		  	<h3>Press Inquiries</h3>
					           		  </cfif>
										<cfset local.showPressInqueries = 1>
				           			   <li><a href="mailto:#item.getbody()#"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> Contact #item.getTitle()#</a></li>
									<cfelse>
										<cfif currentrow LTE 10>
											<li><a href="#item.getbody()#"  target="_blank"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> #item.getTitle()#</a></li>
										<cfelse>
											<cfif !structKeyExists(local,'showMoreButton')>
												<br />
												<a href="../press-and-praise-continued/" class="btn btn-primary m-1" target="_blank">More Press</a>
						           		  	</cfif>
											<cfset local.showMoreButton = 1>
										</cfif>
										<cfset currentrow++>
									</cfif>

								</cfloop>
							</cfif>
						  </ul>
	                </div>
				</cfif>
            </div>


        </div>
    </div>
	</cfoutput>

<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_footer.cfm">
