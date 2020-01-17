	<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_header.cfm">
    <nav id="myNavmenu" class="navmenu navmenu-inverse navmenu-fixed-left offcanvas" role="navigation">
        <div class="navmenu-brand">Organize Your Emotions, Optimize Your Life</div>
        <ul class="nav navmenu-nav">
			<li class="active"><a href="/organize-your-emotions/">Home</a></li>
            <li><a href="/organize-your-emotions/resources/">Resources</a></li>
			<li><a href="/organize-your-emotions/press-and-praise/">Press &amp; Praise</a></li>
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
    <div class="section section-top section-book-cover">
		<div class="container">
            <div class="row row-book-cover">
                <div class="col-lg-5 col-lg-offset-1 col-md-5 col-sm-5 book-cover-col">
                     <img src="#$.getURLForImage(fileid=$.content('fileid'))#" alt="" class="img-responsive book-cover">
					 <div align="center">#$.content('summary')#</div>

                </div>
                <div class="col-lg-5 col-md-6 col-sm-7 book-information">
                    #$.content('body')#
				 <p><a href="#$.content('buttonLink')#" target="_blank"  class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> &nbsp; #$.content('buttonText')#</a></p>
                </div>
            </div>
		</div>
        </div>
    </div>
    <div class="section section-lessons">
        <div class="container">
		<cfset feed=$.getBean('feed').loadBy(name='Lessons from the book')>
		<cfset iterator=feed.getIterator()>
            <h2>#iterator.getRecordcount()# Lessons From the Book</h2>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
              <!-- Indicators -->
              <ol class="carousel-indicators">
				<cfloop from="0" to="#iterator.getRecordcount()-1#" index="count">
                	<li data-target="##carousel-example-generic" data-slide-to="0" <cfif count EQ 0>class="active"</cfif>></li>
                </cfloop>
              </ol>
              <!-- Wrapper for slides -->
              <div class="carousel-inner" role="listbox">
					<cfif iterator.hasNext()>
						<cfset idx = 0>
						<cfloop condition="iterator.hasNext()">
							<cfset item=iterator.next()>
		           			<cfset idx++>
							   <div class="item<cfif idx eq 1> active</cfif>">
									<h3 class="numb">#idx#</h3>
									  <h4>#item.getTitle()#</h4>
								   <div class="carousel-caption">#item.getBody()#</div>
								</div>
							</cfloop>
					</cfif>
			  </div>

              <!-- Controls -->
              <a class="left carousel-control" href="##carousel-example-generic" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
              </a>
              <a class="right carousel-control" href="##carousel-example-generic" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
              </a>
            </div>
        </div>
    </div>
    <div class="section section-table">
        <div class="container">
            <h2>Meet Your Inner Family</h2>

            <div class="row">
                <div class="col-sm-6 col-lg-6">
                    <img src="#$.siteConfig('themeAssetPath')#/images/wheel3.png" alt="" class="img-responsive img-wheel" usemap="##Map" />
                    <map name="Map" id="Map">
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Relational"  shape="rect"  />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Curious Adventuer" shape="rect"/>
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Executive Manager" shape="rect" />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Creative" shape="rect"  />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Confidence" shape="rect"  />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Body Regulator" shape="rect" />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Autonomy"  shape="rect"  />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Meaning Maker" shape="rect" />
                        <area alt="" data-toggle="tooltip" data-placement="top" title="Standard-Setter" shape="rect" />
                    </map>
                </div>
                <div class="col-sm-6 col-lg-6">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                          <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseOne" aria-expanded="true" aria-controls="collapseOne">
                              Meaning Maker
                            </a>
                          </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                          <div class="panel-body">
                            Transcendence, Benevolence, Peacemaker, Harmony, Gratitude, Meaning, Purpose, Wholeness, Congruence
                          </div>
                        </div>
                      </div>
                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                              Standard-Setter
                            </a>
                          </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                          <div class="panel-body">
                            Achievement, Contribution, Respect, To matter, To be valued, To be validated, To be heard, Acknowledgement, Justice, Fairness, Integrity
                          </div>
                        </div>
                      </div>
                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingThree">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseThree" aria-expanded="false" aria-controls="collapseThree">
                              Relational
                            </a>
                          </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                          <div class="panel-body">
                            Love, Empathy, Support, Connection, Interdependence, Belonging, Community, Cooperation, Soothing
                          </div>
                        </div>
                      </div>
                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFour">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseFour" aria-expanded="false" aria-controls="collapseFour">
                              Curious Adventurer
                            </a>
                          </h4>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                          <div class="panel-body">
                            Openness, Sensory stimulation, Adventure, Wonder, Exploration, Discovery, Novelty, Challenge, Learning, Consumption, Risk
                          </div>
                        </div>
                      </div>

                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFive">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseFive" aria-expanded="false" aria-controls="collapseive">
                              Executive Manager
                            </a>
                          </h4>
                        </div>
                        <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                          <div class="panel-body">
                            Clarity, Productivity, Reliability, Work, Problem-solving, Organization, Order
                          </div>
                        </div>
                      </div>

                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingSix">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseSix" aria-expanded="false" aria-controls="collapseSix">
                              Autonomy
                            </a>
                          </h4>
                        </div>
                        <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                          <div class="panel-body">
                            Authenticity, Individuality, Responsibility, Self-determination, Choice, Control, Freedom, Independence, Space
                          </div>
                        </div>
                      </div>

                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingSeven">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                              Body Regulator
                            </a>
                          </h4>
                        </div>
                        <div id="collapseSeven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeven">
                          <div class="panel-body">
                            Physical survival, Safety, Sustenance, Security, Sleep, Relaxation, Exercise, Nutrition, Balance, Familiarity, Conservation, Health, Healing
                          </div>
                        </div>
                      </div>

                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingEight">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseEight" aria-expanded="false" aria-controls="collapseEight">
                              Confidence
                            </a>
                          </h4>
                        </div>
                        <div id="collapseEight" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEight">
                          <div class="panel-body">
                            Self-efficacy, Competence, Strength, Power, Protect, Competitive
                          </div>
                        </div>
                      </div>

                      <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingNine">
                          <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="##accordion" href="##collapseNine" aria-expanded="false" aria-controls="collapseNine">
                              Creative
                            </a>
                          </h4>
                        </div>
                        <div id="collapseNine" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingNine">
                          <div class="panel-body">
                            Creativity, Beauty, Celebration, Flow, Play, Leisure, Humor, Self-expression, Procreation
                          </div>
                        </div>
                      </div>

                    </div>
                </div>


            </div>

        </div>
    </div>
    <div class="section section-praise">
        <div class="container text-center">
            <h2>Authors</h2>
            <div class="row">
			<cfset feed=$.getBean('feed').loadBy(name='Authors')>
					<cfset iterator=feed.getIterator()>
					<cfif iterator.hasNext()>
						<cfloop condition="iterator.hasNext()">
							<cfset item=iterator.next()>
		           			   <div class="col-sm-4 col-md-4 text-left">

								     <div class="row author-avatar-sm">
				                        <div class="col-xs-5"><img src="#item.getImageURL(size='medium')#" class="img-responsive" /></div>
				                        <div class="col-xs-7"><h4>#item.getTitle()#</h4>
				                        <p><a target="_blank" href="#item.getauthorlink()#"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> Author Bio</a></p></div>
				                    </div>

				                    <p class="quote">
					                    <cfset cleanHTML = ReReplaceNoCase(item.getBody(),'<(?!\/?a(?=>|\s.*>))\/?.*?>', '', 'ALL') >
					                   #cleanHTML#
									</p>
				                </div>
							</cfloop>
					</cfif>

            </div>
            <!--<p>&nbsp;</p>
            <p><a href="##" class="btn btn-default">Read more testimonials</a></p>-->
        </div>
    </div>
	<cfinclude template="#$.siteConfig('themeAssetPath')#/templates/inc/OYEmotions_footer.cfm">
</cfoutput>

