$(document).on("turbolinks:load", function(){
  var $body = $("body");
  $("input").focus(function(){
    setTimeout(function() {
      $body.toggleClass('background-change');
    }, 100 );
    // $body.toggleClass('background-change', $(this).is(":focus"));
  });
  $("input").focusout(function(){
    setTimeout(function() {
      $body.toggleClass('background-change');
    }, 100 );
    // $body.toggleClass('background-change', $(this).is(":focus"));
  });
});
