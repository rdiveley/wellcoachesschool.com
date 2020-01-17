
<cfif structkeyExists(rc,'getCoaches') AND rc.getCoaches.recordcount>
<div >
	<div class="row"><!-- Table goes in the document BODY -->
			 <div class="form-group col-md-4 hidden-xs">
				 Name
			 </div>
			  <div class="form-group col-md-4 col-xs-12">
				  Website
			 </div>
			 <!--- <div class="form-group col-md-3 col-xs-12">
				  Specialty
			 </div> --->
			 <div class="form-group col-md-3 hidden-xs">
				  Email
			 </div>

             <cfoutput query="rc.getCoaches">
				<div class="row">
		            <div class="form-group col-md-4 hidden-xs">
		            	#rc.getCoaches.fname# #rc.getCoaches.lname#
		            </div>

					<div class="form-group col-md-4 col-xs-12">
						<a href="http://coach.wellcoach.com/#rc.getCoaches.filename#/" target="_new">#rc.getCoaches.filename#</a>
					</div>
					<!--- <div class="form-group col-md-3 hidden-xs">
		            	#rc.getCoaches.licenses#
		            </div> --->
					<div class="form-group col-md-4 hidden-xs">
						<a href="mailto:#rc.getCoaches.username#">#rc.getCoaches.username#</a>
					</div>
				</div>
             </cfoutput>
	</div>
</div>
<cfelse>
	No results. Please try again.
</cfif>
<br /><br />
<div class="row">
	<a href="/find-coach"><input class="btn btn-primary" value="Back to Search" type="submit"></a>
</div>