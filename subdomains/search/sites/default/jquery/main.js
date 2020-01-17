//
// --------------------------------------------------------------------------
// Blog Filters
// --------------------------------------------------------------------------
//
$(function() {
    // newsletter dropdown
    $('.newsletter_signup').each(function() {
        var ele = $(this);
        $('.signup_button', ele).click(function() {
            $('.newsletter_form', ele).addClass("opener");
            $('html, body').animate({
                scrollTop: $(".newsletter_form").offset().top
            }, 400);
            $('#inf_field_FirstName').focus();
        });
    });
});