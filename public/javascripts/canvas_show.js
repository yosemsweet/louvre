$(document).ready(function(){
	
	// $("#feed .widget.canvas-feed-snippet").hover(function(){
	// 	widget_id = $(this).data("widget_id")
	// 	$("[data-widget_id="+widget_id+"] .controls").show();
	// })
	
	$("#feed .widget.canvas-feed-snippet").hover(
		function(){
			widget_id = $(this).data("widget_id")
			if($("form#edit_widget_"+widget_id).is(":hidden"))
				$("[data-widget_id="+widget_id+"] .controls").fadeIn("fast");
		},
		function(){
			widget_id = $(this).data("widget_id")
			$("[data-widget_id="+widget_id+"] .controls").fadeOut("fast");
		}
	)
	
	// Enable canvas following buttons.
	$("#follow").click(function(event){
		event.preventDefault();
	  FollowHelper.toggle_follow_status();
	  FollowHelper.follow('canvas', request.canvas_id);
	});
	$("#unfollow").click(function(event){
		event.preventDefault();
	  FollowHelper.toggle_follow_status();
	  FollowHelper.unfollow('canvas', request.canvas_id);    
	});

	// Enable help text toggler
	$('[class^=link-help]').click(function() {
		var $this = $(this);
		var x = $this.attr("class");
		$('.toggle-' + x).toggle();
		return false;
	});

	var reload_widgets = function(){
		// Reload all of the canvas feed widgets.
	  $("ul#feed").load("/widgets/for_canvas/" + request.canvas_id + "/canvas_feed", function(){
	    enable_widget_previews();     
			update_widget_comment_counts();
			reset_new_widget_forms();
			clear_new_textbox_list();
			make_textbox_list();
			
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
	       $(data).prependTo("ul#feed");
	       enable_widget_previews();
				 update_widget_comment_counts();
	     }
	   });  
	 };
	
	// Look for new widgets every 15 seconds.
	setInterval(load_new_widgets, 15000); 

	// Track the fact that the user got here.
	mpq.push(["track","hit_canvas_homepage"]);  
	
	// PUBLIC METHODS
	update_after_edit = function(){
	  if ($("[data-target=edit-widget]").length){
	    $("[data-target=edit-widget]").hide();
	  }
	    
		reload_widgets();
	}
	update_widget_comment_counts();
});