<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<div class="container-fluid secondary-header row mb-2">
	<!--- <img alt="" src="/themes/MuraBootstrap3/images/get-started.jpg" /> --->
	</div>
	<div class="container ">
	  
		   #$.dspBody(
			body=$.content('body')
			, crumbList=false
			, showMetaImage=false
		)#
		<cfif len(#$.dspObjects(2)#)>
			#$.dspObjects(2)#
		</cfif>
	 
		   <!-- end col-sm-9 -->
		  
      </div>
   </div><!-- end col-sm-3 -->

 </div>

</cfoutput>