$(document).ready(function(){
  $("li#canvae-menu").click(function () {
    event.preventDefault();
		$("li#canvae-menu ul").slideToggle("fast"); 
  });
});

$("body").mouseup(function(){ 
	if($('li#canvae-menu ul').is(":visible"))
		$('li#canvae-menu ul').fadeToggle();
});