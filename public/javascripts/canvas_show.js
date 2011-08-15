$(document).ready(function(){

	// Enable canvas following buttons.
	$("#follow button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.follow('canvas', request.canvas_id, reload_hud);
	});
	$("#stop_following button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.stop_following('canvas', request.canvas_id, reload_hud);    
	});
  
	// Enable bookmarklet toggler.
	$("#toggle_bookmarklet_video").click(function(){
	  $("#bookmarklet_video").toggle();
	});

	var reload_widgets = function(){
		// Reload all of the canvas feed widgets.
	  $("ul#feed").load("/widgets/for_canvas/" + request.canvas_id + "/canvas_feed", function(){
	     enable_widget_previews();     
			 update_widget_comment_counts();
	  });
	}  

	var load_new_widgets = function(){
	   // Get highest widget_id value on page.
	   var max_widget_id = 0;
	   $("ul#feed .widget").each(function(){
	     if ($(this).data("widget_id") * 1 > max_widget_id) {
	       max_widget_id = $(this).data("widget_id");
	     }
	   });
	   // Get html for any new widgets and append to the feed.
	   $.get('/widgets/for_canvas/' + request.canvas_id + '/canvas_feed?start=' + (1*max_widget_id + 1), function(data) {
	     if(data.length > 1){
	       $(data).appendTo("ul#feed");
	       enable_widget_previews();
				 update_widget_comment_counts();
	     }
	   });  
	 };

	update_after_edit = function(){
	  // close_widget_dialog();
	  reload_widgets();
	}
  
	// Look for new widgets every 15 seconds.
	setInterval(load_new_widgets, 15000); 

	// Load the canvas feed.
	reload_widgets();

	// Track the fact that the user got here.
	mpq.push(["track","hit_canvas_homepage"]);  

});