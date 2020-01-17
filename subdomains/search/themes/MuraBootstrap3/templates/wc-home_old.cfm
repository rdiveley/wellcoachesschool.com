<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<cfset feed=$.getBean('feed').loadBy(name='Home Page Carousel')>
	<cfset iterator=feed.getIterator()>
	<cfset loopCount = iterator.recordcount()-1>


    <div id="mainCarousel" class="carousel slide" data-ride="carousel">
          <!-- Indicators -->
          <ol class="carousel-indicators">
			<cfloop from="0" to="#loopCount#" index="item">
	            <li data-target="##mainCarousel" data-slide-to="#item#" <cfif item EQ 0>class="active"</cfif>></li>
	        </cfloop>
          </ol>

		<cfif iterator.hasNext()>
				<!--- Carousel items --->
				<div class="carousel-inner" role="listbox">
					<cfset idx = 0>
					<cfloop condition="iterator.hasNext()">
						<cfset item=iterator.next()>
						<cfif listFindNoCase('jpg,jpeg,gif,png', ListLast(item.getImageURL(), '.'))>
							<cfset idx++>
							<div class="item<cfif idx eq 1> active</cfif>">
								<img src="#item.getImageURL()#" class="img-responsive">
					              <div class="container">
					                <div class="carousel-caption">
					                  <h1>#item.getHeader()#</h1>
					                  <p>#item.getTagLine()#</p>
					                  <p><a class="btn btn-lg btn-primary" href="#item.getButtonLink()#" role="button">#item.getButtonText()#</a></p>
					                </div>
					              </div>
							</div>
						</cfif>
					</cfloop>
				</div>
				<cfif idx>
					<!--- Carousel nav --->
					<cfif idx gt 1>
						  <a class="left carousel-control" href="##mainCarousel" role="button" data-slide="prev">
				            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				            <span class="sr-only">Previous</span>
				          </a>
				          <a class="right carousel-control" href="##mainCarousel" role="button" data-slide="next">
				            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				            <span class="sr-only">Next</span>
				          </a>
					</cfif>
				</cfif>
			</div>
		</cfif>

		<cfif len($.content('firstRow'))>
				#$.content('firstRow')#
		</cfif>
		<!-- end container -->

		<!--- create content index to loop --->
		<cfset feed=$.getBean('feed').loadBy(name='Learn how to coach')>
		<cfset iterator=feed.getIterator()>
		<cfif iterator.hasNext()>
			<div class="container-fluid bg-gray-lighter">
      			<div class="row m-2">
          			<div class="col-md-12">
			      		<h2 class="text-center mb-1">Learn how to coach</h2>
					      <div class="container">
					          <div class="row front-page-color-small">
					          <cfset local.colors = 'blue,green,orange,red,blue,green,orange,red'>
					          <cfset local.count = 1>
								<cfloop condition="iterator.hasNext()">
									<cfset item=iterator.next()>
									 <div class="col-sm-6 col-md-3">
										<div class="#listgetat(local.colors,count++)#">
								           <a href="#item.getButtonLink()#">
								           <!--- <img class="img-responsive" src="#item.getImageURL()#" alt="" width="1000" height="550" > --->
								            <span class="carousel-caption">
								            <h2>#item.getHeader()#</h2>
								            <hr>
								            <p>#item.getTagLine()#</p>
								            </a>
								            </span>
							            </div><!-- /.blue -->
							         </div><!-- /.col-md-3 -->
								</cfloop>
					          		</div><!-- end row -->
					         	</div><!-- end container -->
			      			</div><!-- end col-md-12 -->
			    		</div><!-- end row -->
			</div><!-- end container fluid-->
		</cfif>

		<!--- create content index to loop --->
		<cfset feed=$.getBean('feed').loadBy(name='What is New')>
		<cfset iterator=feed.getIterator()>
		<cfif iterator.hasNext()>
		<h2 class="text-center m-2 special"><span>What's New</span></h2>
		<div id="secondaryCarousel" class="carousel slide" data-ride="carousel">
		          <div class="carousel-inner" role="listbox">
					<cfset idx = 0>
					<cfloop condition="iterator.hasNext()">
					<cfset item=iterator.next()>
			           <cfset idx++>
						  <div class="item<cfif idx eq 1> active</cfif>">
			                <div class="col-md-3">
			                    <img class="img-responsive center-block" src="#item.getImageURL(size='whatsnew')#" alt="#item.getHeader()#" >
			                </div>
			              <div>
			              <div class="col-md-9">
			                   <div class="carousel-caption">
			                  <h3>#item.getHeader()#</h3>
			                 <p>#item.getTagLine()#</p>
			                    <p>This course includes a mobile self-coaching platform, built on the bestselling Harvard Health book, <em>Organize Your Mind, Organize Your Life</em>, and coaches you to coach yourself to an organized mind.</p>
			                 <p><a class="btn btn-primary" href="#item.getButtonLink()#" role="button">#item.getButtonText()#</a></p>
			                </div>
			              </div>
			              </div>
			            </div><!-- end item -->
			        </cfloop>

		          </div>
		          <a class="left carousel-control" href="##secondaryCarousel" role="button" data-slide="prev">
		            <i class="fa fa-angle-left"></i>
		            <span class="sr-only">Previous</span>
		          </a>
		          <a class="right carousel-control" href="##secondaryCarousel" role="button" data-slide="next">
		            <i class="fa fa-angle-right"></i>
		            <span class="sr-only">Next</span>
		          </a>
		        </div><!-- end scondaryCarousel -->
		</cfif>

       <!--- membership coaching science --->
		<cfif len($.content('secondRow'))>
				#$.content('secondRow')#
		</cfif>

		<cfif len($.content('thirdRow'))>
				#$.content('thirdRow')#
		</cfif>

	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>