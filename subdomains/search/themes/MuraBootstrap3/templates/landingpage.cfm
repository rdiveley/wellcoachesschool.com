<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<div class="container">
		<cfif len($.dspNestedNav(contentID='#$.getTopVar('contentid')#'))>
		    <!-- secondary navigation -->
		    <nav class="navbar navbar-secondary">
			  <div class="container-fluid">
			    <!-- Brand and toggle get grouped for better mobile display -->
			    
			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div  id="secondary-nav">
					#$.dspNestedNav(contentID='#$.getTopVar('contentid')#',viewDepth=0,openPortals=false,displayHome='never',class='nav navbar-nav',liCurrentClass='active')#
				</div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>
		</cfif>
		<!--- <img alt="" src="/themes/MuraBootstrap3/images/get-started.jpg" /> --->
	 </div><!-- end container -->

<div class="container">

		#$.dspBody(
			body=$.content('body')
			, crumbList=false
			, showMetaImage=false
		)#

</div>

<!--- #$.getContentID()#<br />p:#$.getparent().getTitle()# --->
</div><!-- end container -->

	
</cfoutput>