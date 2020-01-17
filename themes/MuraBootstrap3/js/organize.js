$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});

$(document).mousemove( function(e) {    
    var mouseX = e.pageX - $('#Map').offset().left - 60;
    var mouseY = e.pageY - $('#Map').offset().top + -40;
    $('.tooltip').css({'top':mouseY,'left':mouseX}).fadeIn('slow');
}); 