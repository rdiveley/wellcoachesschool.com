<!-- end mainContent -->
<cfoutput>
<!--- <hr class="mb-2"> --->
		<div class="bg-gray-light mt-2 newsletter">
<div class="container">
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
<div class="row">
    <h3 class="text-center mb-1">Sign up for our newsletter</h3>
  <form accept-charset="UTF-8" action="https://my982.infusionsoft.com/app/form/wellcoaches-newsletter-opt-in" class="form-inline" method="POST">
		<input name="inf_form_xid" type="hidden" value="da7bf1eb9d25eba1bc0b0eb3fa7e8b7a" />
		<input name="inf_form_name" type="hidden" value="Newsletter - Sign me up!" />
		<input name="infusionsoft_version" type="hidden" value="1.38.0.37" />

  <div class="form-group col-md-3">
    <label class="sr-only" for="firstNameNewsLetter">First Name</label>
    <input type="text" class="form-control" id="inf_field_FirstName" name="inf_field_FirstName" type="text" placeholder="First Name">
  </div>
  <div class="form-group col-md-3">
    <label class="sr-only" for="lastNameNewsLetter">Last Name</label>
    <input type="text" class="form-control" id="inf_field_LastName" name="inf_field_LastName"  placeholder="Last Name">
  </div>
  <div class="form-group col-md-3">
    <label class="sr-only" for="emailNewsLetter">Email address</label>
    <input type="text" class="form-control" id="inf_field_Email" name="inf_field_Email" placeholder="Email Address">
  </div>
   <div class="form-group col-md-3">
  	<a href="javascript:void(0)" type="submit" onclick="$(this).closest('form').submit()" class="btn btn-secondary">Submit</a>
  </div>

</form>
		<script type="text/javascript" src="https://my982.infusionsoft.com/app/webTracking/getTrackingCode?trackingId=a3e87cccd4cb1f32fa69d8ac6e2010dd"></script>

</div><!-- end row -->
</div><!-- end col-md-12 -->
</div><!-- end container -->
</div><!-- end bg-lighter -->
</div>
<!-- end mainContent -->
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
            <a href="https://twitter.com/coachmeg" class=""><img src="#$.siteConfig('themeAssetPath')#/images/social-twitter.png" alt="Well coaches twitter"></a>
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

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/bootstrap.min.js"></script>


</cfoutput>
  <script type="text/javascript">
  $(document).ready(function() {
    $(function(){
      $('#trigger > a#nav-icon1').click(function(event) {
        $('#st-container').toggleClass('st-effect-3 st-menu-open');
            event.stopPropagation();
            $(this).toggleClass('open');
        });
       });
       $('.glyphicon-search').click(function(){
            $(".mainSearchContainer").slideToggle("slow");
       });
       $('.split-lg-boxes  a .content').hover(function(){
           $(this).toggleClass('animated pulse');
       });
       $('.front-page-color-small a .content').hover(function(){
           $(this).toggleClass('animated pulse');
       });
       $('body').click(function(){
          $('#st-container').removeClass('st-effect-3 st-menu-open');
          $('#nav-icon1').removeClass('open');
        });
    });
</script>