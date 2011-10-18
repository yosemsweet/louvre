$(window).load(function(){
  $(".hint").each(function(index) {
    $(this).css("display", "block")
    
    targetSelector = $(this).data("target");
    target = $(targetSelector);
    
    typeElement = $(this).children(".get-started");
    x = target.offset().left;
    if(typeElement.hasClass("left")) {
      x += target.width() + 10;
    }
    else {
      x -= $(this).width() + 10;
    }

    typeElement = $(this).children(".get-started");
    y = target.offset().top;
    if(typeElement.hasClass("up")) {
      y += target.height();
    }
    y -= $(this).height() / 2;
    
    $(this).offset(
        { left : x, top: y }
    );
  });
});
