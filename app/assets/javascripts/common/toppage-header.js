document.addEventListener("turbolinks:load", function() {
  var url = location.href;
  if (url == "https://just--do--it.com/" || url == "http://localhost:3000/"){
    var $win = $(window),
        $title = $('.toppage-title'),
        $back = $('.header-background');
    $win.on('load scroll', function() {
      var value = $(this).scrollTop();
      if ( value > 921 ) {
        $($back).fadeIn();
        $($title).hide();
      } else {
        $($back).fadeOut();
        $($title).fadeIn(2000);
      }
    });
  }
});
