$(document).ready(function(){
  $("li#canvae-menu").click(function () {
		if($('li#canvae-menu ul').is(":hidden"))
			$("li#canvae-menu ul").slideToggle("fast"); 
  });
});

