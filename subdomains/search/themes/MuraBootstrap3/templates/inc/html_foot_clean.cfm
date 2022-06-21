<cfoutput>
	
</div><!-- closing divs for main content -->
      </div>
    </div>
  </div>
</div>

		<!--- Bootstrap JavaScript --->
		<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/bootstrap.min.js"></script>
		<!--- <script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/bootstrap.sprockets.js"></script>
		<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/jquery.backstretch.min.js"></script>
		<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/readmore.js"></script>--->
    	<!--- Theme JavaScript --->
   		 <script src="#$.siteConfig('themeAssetPath')#/js/theme/theme.min.js"></script>
		 <script type="text/javascript">
			  $(document).ready(function() {
			  	$('button[id^="more_"]').click(function(){
			     	var id = this.id.split('_');
			     	$('##ellipses_'+id[1]).toggle();
			     });
			    $(function(){
			      $('##trigger > a##nav-icon1').click(function(event) {
			        $('##st-container').toggleClass('st-effect-3 st-menu-open');
			            event.stopPropagation();
			            $(this).toggleClass('open');

			        });
			       });

			       $('.glyphicon-search').click(function(){
			            $(".mainSearchContainer").slideToggle("slow");
			       });
			       $('.split-lg-boxes .content').hover(function(){
			           $(this).toggleClass('animated pulse');
			       });
			       $('.front-page-color-small .content').hover(function(){
			           $(this).toggleClass('animated pulse');
			       });
			       $('body').click(function(){
			          $('##st-container').removeClass('st-effect-3 st-menu-open');
			          $('##nav-icon1').removeClass('open');
			        });

				    $('.customCollapse').on('hidden.bs.collapse', function () {
				       $(this).parent().find(".glyphicon").removeClass("glyphicon-remove").addClass("glyphicon-plus");
				       $(this).parent().find(".collapseText").text("EXPAND");
				    });

				    $('.customCollapse').on('show.bs.collapse', function () {
				       $(this).parent().find(".glyphicon").removeClass("glyphicon-plus").addClass("glyphicon-remove");
				       $(this).parent().find(".collapseText").text("CLOSE");
				    });


			    });
			</script>
	</body>
</html>
</cfoutput>