 <cfoutput>
            <cfinclude template="inc/wc2_header.cfm" />
          
              <div id="mainCarousel" class="carousel slide" data-ride="carousel">
          
                    <div class="carousel-inner" role="listbox">
                      <div class="item active">
          
                           <img src="#$.getURLForImage(fileid=$.content('fileid'))#"  alt="">
                        <div class="container">
                          <div class="coverMe">
                          <div class="still-caption">
                            #$.content('headerTagLine')#
                          </div>
                          </div><!-- end coverMe -->
                        </div>
                      </div>
                    </div>
          
              </div>

            <!-- end mainCarousel -->
            <div class="mainContent" style="margin-top:-72px;">
              <!-- SECONDARY NAV -->
              <div class="secondaryNav">
                <div class="container" >
                  #$.dspNestedNav(contentID='#$.getTopVar('contentid')#',liCurrentClass='active')#
                </div><!-- end contianer -->
            </div><!-- end secondaryNav -->
            <div class="subSection">
              <div class="container">
                <div class="row">
                  <!-- Nav tabs -->
                  
                    <cfif $.getparent().getContentID() EQ $.getTopVar('contentid')>
                      #$.dspNestedNav(contentID='#$.getContentID()#',viewDepth=0,openPortals=false,displayHome='never' ,class='nav nav-tabs',  liCurrentClass='active')#
                    <cfelseif $.getTopVar('contentid') NEQ $.getparent().getContentID() AND $.getparent().getTitle() NEQ 'Home'>
                      #$.dspNestedNav(contentID='#$.getparent().getContentID()#',viewDepth=0,openPortals=false,displayHome='never' ,class='nav nav-tabs',  liCurrentClass='active')#
                    </cfif>
               
               
                  </div>
                <!-- end row -->
              </div>
              <!-- end container-->
            </div>
          
          
              <div class="container pl-0">
                <div class="row">
                  <!-- end subSection -->
                  
                    <!-- Tab panes -->
                    <div class="tab-content">
                     
                      <div role="tabpanel" class="tab-pane active" id="publications">
                        <div class="col-md-8"> 
                          <p>#$.content('body')#</p>
                          
                      </div>
                      <!-- end col-md-8 -->
                      <div class="col-md-4">
                        <div class="text-center mt-2">
                          <!-- circle image -->
                          <img src="#$.getURLForImage(fileid=$.content('rightColumnImage'))#" alt="#$.content('title')#" class="img-responsive">
                        </div>
                        <!-- image block text-center -->
                        <p>#$.content('rightColumn')#</p>
                        <div class="gray-card p-2">
                          #$.content('rightColumnBox')#
                          
                        </div>
                      </div><!--  end col-md-4 -->  
                    </div><!-- end tabbed Panel -->
                    </div>
                    <!-- end tabbed content -->
                </div>
                <!-- end row -->
              </div>
              <!-- end container -->
              <cfinclude template="inc/wc2footer.cfm" />
            </cfoutput>
         
              
             
            </div><!-- end adjust -->
          </div><!-- closing divs for main content -->
        </div>
      </div>
    </div>
  </div>
  
  

</html>