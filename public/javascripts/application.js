$(document).ready(function(){

	var reload_event_count = function(){
		$.get('/event_count', function(data) {
			$('#event_count').html(data);
			if (data == 0){
				$('#event_count').addClass("no_new_events")
			}else{
				$('#event_count').addClass("new_events")
			}
		});
	}

	setInterval(function() {
			reload_event_count()
	}, 15000);
	reload_event_count()

	$('#event_list_container').hide();
	$('#event_count').click(function(){
		$('#event_count').html("0");
		$('#event_count').removeClass("new_events");
		$('#event_count').addClass("no_new_events");
		if($('#event_list_container').html() == '')
			$('#event_list_container').addClass("loading_events_container");
		$('#event_list_container').fadeToggle(function(){
			$.get('/events', function(data) {
				$('#event_list_container').removeClass("loading_events_container");
				$('#event_list_container').html(data);
			});
		});
	})


	$("body").mouseup(function(){ 
  	if($('#event_list_container').is(":visible"))
			$('#event_list_container').fadeToggle();
	});

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