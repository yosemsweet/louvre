$(document).ready(function(){

	$("#follow button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.follow('canvas', request.canvas_id, reload_hud);
	});

	$("#stop_following button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.stop_following('canvas', request.canvas_id, reload_hud);    
	});
  
	var reload_widgets = function(){
	  $("ul#feed").load("/widgets/for_canvas/" + request.canvas_id + "/canvas_feed", function(){
	     enable_widget_previews();     

	     $("ul#feed .widget").each(function(){
       
	       var $widget = $(this);
	       var widget_url = request.root_url + "widgets/" + $widget.data("widget_id");
       
	       countComments(widget_url, function(n){
	         var text = "";
	         if(n == 0){
	           text = "";
	         } else {
	           text = n;
					 }
	         $('.toggle_facebook_comments', $widget).text( text );
         
	       });
       
	     })
	  });
	}  
	reload_widgets();

	update_after_edit = function(){
	  close_widget_dialog();
	  reload_widgets();
	}
  
	var load_new_widgets = function(){
	   // Get highest widget_id value on page.
	   var max_widget_id = 0;
	   $("#feed .widget").each(function(){
	     if ($(this).data("widget_id") * 1 > max_widget_id) {
	       max_widget_id = $(this).data("widget_id");
	     }
	   });
	   // Get html for any new widgets and append to the feed.
	   $.get('/widgets/for_canvas/' + request.canvas_id + '/canvas_feed?start=' + (1*max_widget_id + 1), function(data) {
	     if(data.length > 1){
	       $(data).appendTo("#feed");
	       enable_widget_previews();
	     }
	   });  
	 };
	setInterval(load_new_widgets, 15000); 

	FB.Event.subscribe('comment.create',
	    function(response) {
	        var widget_id = _.last(response.href.split('/')) * 1;
	        if (request.user_id !== 0){
	          FollowHelper.follow('widget', widget_id, reload_hud);
	        }
	        mpq.push(["track","comment_added", {type: "facebook", widget: widget_id, user_id : request.user_id} ]);
	    }
	);

	FB.Event.subscribe('comment.remove',
	    function(response) {
	        mpq.push(["track","comment_removed" , {type: "facebook", widget : widget_id, user_id : request.user_id} ]);
	    }
	);

	mpq.push(["track","hit_canvas_homepage"]);  

	$("#toggle_bookmarklet_video").click(function(){
	  $("#bookmarklet_video").toggle();
	});
  
	$(".widget .toggle_facebook_comments").live('click', function(event){
	  event.preventDefault();
	
		$facebook_comments = $(this).parents(".widget").find(".facebook_comments");
		$facebook_comments.toggle();
  	FB.XFBML.parse($facebook_comments.get(0));
  
	});

});