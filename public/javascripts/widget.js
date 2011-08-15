$(document).ready(function(){

	var $widget_dialog = $("#widget_dialog").dialog({
	  minHeight:250, 
	  minWidth:500, 
	  autoOpen:false
	});
	$widget_dialog.open = function(title, src){
		$("iframe", $(this)).attr("src", src);
		$(this).dialog("option","title", title);
		$(this).dialog("open");
	}
	$widget_dialog.close = function(){
		$(this).dialog("close");
	}
    
	$(".add_widget").click(function(event){
	  event.preventDefault();
	
		// Canvas id and content type are required.
		var canvas_id = $(this).data("canvas_id");
		var content_type = $(this).data("content_type");
		
		// If page id is defined, we attach the widget to that page.
		var page_query = '';
		var page_id = $(this).data("page_id");	
	  if(typeof page_id !== "undefined"){
		  var page_query = '&page_id=' + request.page_id;
	  }
	
		$widget_dialog.open("New Widget", "/widgets/new?content_type=" + content_type + "&canvas_id=" + canvas_id + page_query);
		
	});

	$(".widget .edit").live("click", function(event){
	  var widget_id = $(this).parents(".widget").data("widget_id");
  
		$widget_dialog.open("Edit Widget", "/widgets/" + widget_id + "/edit")
		
	  mpq.push(["track","canvas_edit_widget", {user_id : request.user_id, canvas_id : request.canvas_id, page_id : request.page_id, widget_id : widget_id}]);
  
	  event.preventDefault();
	});

	$(".widget .delete").live("click", function(event){
    var $widget = $(this).parents(".widget");
    var widget_id = $widget.data("widget_id");
    
    // Delete from the server.
    $.post("/widgets/" + widget_id, { _method : 'DELETE' });
    
    // Remove from the DOM.
    $widget.remove();
    
    // Track the event.
    mpq.push(["track","page_remove_widget", {user_id : request.user_id, canvas_id : request.canvas_id, page_id : request.page_id, widget_id : widget_id}]);
    
    event.preventDefault();
  });

	$(".widget .toggle_facebook_comments").live('click', function(event){
	  event.preventDefault();
	
		$facebook_comments = $(this).parents(".widget").find(".facebook_comments");
		$facebook_comments.toggle();
  	FB.XFBML.parse($facebook_comments.get(0));
	});

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
	
	update_widget_comment_counts = function(){
		console.log("herte");
		$(".widget").each(function(){
    	var $widget = $(this);
      countComments(request.root_url + "widgets/" + $widget.data("widget_id"), function(n){
       var comments = n > 0 ? n : "" ;
       $('.toggle_facebook_comments', $widget).text( comments );
     });
    });
	}

	enable_widget_previews = function(){
		// Enable the toggle preview qtips.
	  $(".widget .toggle_preview").each(function(){
	    $(this).qtip({
	      content: $(this).parents().filter(".widget").find(".content").html(),
	      show: 'mouseover', hide: 'mouseout',
	      position: { corner: { target: 'bottomLeft', tooltip: 'topRight' }, adjust: { screen: true } },
	      style: {
	        width: 572,
	        border: { width: 5, radius: 10 },
	        padding: 10, 
	        tip: true,
	        name: 'light' 
	      }
	    });
	  });
	}

  close_widget_dialog = function(){
    $widget_dialog.close();
  }



});