$(document).ready(function(){

	reload_hud = function(){
	  $("#hud_content").load("/users/hud");  
	}

	var toggle_hud = function(){
  
	  if(parseInt($("#hud").css("right")) < 0){
	    $("#hud").toggle();
	    $("#hud").animate({
	      right: "+=" + hud_width
	    }, 300);
	  } else {
	    $("#hud").animate({
	      right: "-=" + hud_width
	    }, 300, function(){
	      $("#hud").toggle();
	    });
	  }
	}        

	$("#show_hud").click(function(event){
	  event.preventDefault();
	  toggle_hud();
	});  

	$("#hide_hud").click(function(event){
	  event.preventDefault();
	  toggle_hud();
	});
	
	$("#hud").hide();

	var hud_width = $("#hud").outerWidth();
	$("#hud").css("top", $("#header").outerHeight() + "px");
	$("#hud").css("right", -1 * hud_width + "px");
	
	if(request.user_id !== 0){
		reload_hud();        	
	}

	$('#flash').delay(500).fadeIn('normal', function() {
     $(this).delay(2500).fadeOut('slow');
  });

});