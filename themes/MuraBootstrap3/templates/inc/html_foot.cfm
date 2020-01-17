<cfoutput>
	<div class="bg-gray-light mt-2 newsletter">
	<div class="container">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="row">
				<h3 class="text-center mb-1">Sign up for our newsletter</h3>
				<!--- https://my982.infusionsoft.com/app/form/process/da7bf1eb9d25eba1bc0b0eb3fa7e8b7a --->
				<form accept-charset="UTF-8" action="https://my982.infusionsoft.com/app/form/wellcoaches-newsletter-opt-in" class="form-inline" method="POST">
					<input name="inf_form_xid" type="hidden" value="da7bf1eb9d25eba1bc0b0eb3fa7e8b7a" />
					<input name="inf_form_name" type="hidden" value="Newsletter - Sign me up!" />
					<input name="infusionsoft_version" type="hidden" value="1.38.0.37" />

					<div class="form-group col-md-3">
						<label class="sr-only" for="firstNameNewsLetter">First Name</label>
						<input class="form-control" id="inf_field_FirstName" name="inf_field_FirstName" placeholder="First Name" type="text" />
					</div>

					<div class="form-group col-md-3">
						<label class="sr-only" for="lastNameNewsLetter">Last Name</label>
						<input class="form-control" id="inf_field_LastName" name="inf_field_LastName" placeholder="Last Name" type="text" />
					</div>

					<div class="form-group col-md-3">
						<label class="sr-only" for="emailNewsLetter">Email address</label>
						<input class="form-control" id="inf_field_Email" name="inf_field_Email" placeholder="Email Address" type="text" />
					</div>

					<div class="form-group col-md-3">
						<a href="javascript:void(0)" type="submit" onclick="$(this).closest('form').submit()" class="btn btn-secondary btn-lg">Submit</a>

					</div>
				</form>
				<script type="text/javascript" src="https://my982.infusionsoft.com/app/webTracking/getTrackingCode?trackingId=a3e87cccd4cb1f32fa69d8ac6e2010dd"></script>
			</div>
		</div>
		<!-- end row --></div>
	<!-- end col-md-12 --></div>

<footer>
    <div class="container">
        <div class="col-sm-12 col-md-3 col-lg-3">
            <ul class="list-unstyled">
                <li>Wellcoaches Corporation</li>
                <li>PO Box 581</li>
                <li>Lancaster, OH 43130</li>
                <li class="last">866-932-6224</li>
            </ul>
        </div>

         <div class="col-sm-12 col-md-3 col-lg-3">
             <ul class="list-unstyled">
                 <li><a href="/privacy-policy">Privacy Policy</a></li>
                 <li><a href="/contact-us/">Training Inquiry</a></li>
             </ul>
         </div>
		 
         <div class="col-sm-12 col-md-3 col-lg-3 meds">
             <ul class="list-unstyled">
                 <li><a href="http://www.acsm.org/" ><img src="#$.siteConfig('themeAssetPath')#/images/acsm-logo.png" alt="American College of Sports Medicine"></a></li>
                 <li class="last"><a href="http://lifestylemedicine.org/"><img src="#$.siteConfig('themeAssetPath')#/images/aclm-logo.png" alt="American College of Lifestyle Medicine"></a></li>
             </ul>
         </div>
         <div class="col-sm-12  col-md-3 col-lg-3 social">
            <a href="https://www.facebook.com/Wellcoaches-Corporation-282418045286/" class=""><img src="#$.siteConfig('themeAssetPath')#/images/social-facebook.png" alt="Well coaches facebook"></a>
            <a href="https://twitter.com/Wellcoaches" class=""><img src="#$.siteConfig('themeAssetPath')#/images/social-twitter.png" alt="Well coaches twitter"></a>
            <a href="https://www.linkedin.com/groups/888267/profile" class=""><img src="#$.siteConfig('themeAssetPath')#/images/social-linkedin.png" alt="Well coaches linkedin"></a>
            <p class="m-3">&copy; 2019 Wellcoaches</p>
         </div>

    </div><!-- end container!-->
</footer>
</div><!-- end adjust -->
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