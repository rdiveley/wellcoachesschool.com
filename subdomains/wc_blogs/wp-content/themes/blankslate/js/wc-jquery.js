jQuery(document).ready(function($) {
	
	$('#s').attr('placeholder','SEARCH');
	$('#s').css('font-weight','bold');
	$('#s').css('font-weight','bold');
	$('#cat').css('font-weight','bold');
	$('#user').css('font-weight','bold');
	$('#s').attr('onfocus','this.placeholder=""');
	$('#s').attr('onblur','this.placeholder="SEARCH"');
	
});


//
// --------------------------------------------------------------------------
// Blog Filters
// --------------------------------------------------------------------------
//
jQuery(document).ready(function($) {
    // category filter
    $('.blog-filter').each(function() {
        var ele = $(this);
        $('.blog-filter-button', ele).click(function() {
            $('.blog-filter-button', ele).toggleClass("open");
        });
        $(ele).mouseleave(function() {
            $('.blog-filter-menu', ele).removeClass("opener");
        });
    });
});