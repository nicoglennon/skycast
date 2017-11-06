$(document).on("turbolinks:load", function(){
  var $body = $("body");
  $("input").focus(function(){
    $body.toggleClass('background-change', $(this).is(":focus"));
  });
  $("input").focusout(function(){
    $body.toggleClass('background-change', $(this).is(":focus"));
  });
});
