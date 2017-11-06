$(document).ready(function(){
  $(window).scroll(function(){
    var y = $(window).scrollTop();
    var $nav = $("nav");
    if( y > 0 ){
      $nav.toggleClass('scrolled', $(this).scrollTop() < $nav.height());
    }
  });
})
