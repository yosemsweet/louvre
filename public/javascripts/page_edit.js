$(document).ready(function(){
  
	// $('#tag_ids').tokenInput('/tags', { 
	//   crossDomain: false,
	//   theme: 'facebook',
	//   onDelete : function(){ reload_feed_widgets()},
	//   onAdd : function(){ reload_feed_widgets()}
	// });
	
	var drag_in_progress = false;
	var reload_feed_widgets = function(){
  	if(!drag_in_progress){
	  	// Get the tags to filter by
		  var tag_names = $("#tag_names").val();
		  $("ul#feed").load("/widgets/for_canvas/" + request.canvas_id + "/page_feed?tag_names=" + tag_names, function(){
    
		    // Make the widgets draggable.
		    $("li.widget", $(this)).draggable({
		      appendTo: "body",
		      helper: "clone",
		      connectToSortable: 'ul#page',
		      opacity: 0.6,
		      revert: 'invalid',
		      revertDuration: 200,
					start: function(){drag_in_progress=true;},
					stop: function(){drag_in_progress=false;}
		    });
    
		    enable_widget_previews();
	 			update_widget_comment_counts();
	  });
		}
	}
	
	var t = new $.TextboxList("#tag_names", { 
    unique: true,
    plugins: {
      autocomplete: {
        minLength: 2,
        queryRemote: true,
        remote: {
          url: '/tags'}
        }
      }
    });
	t.addEvent('bitBoxAdd', reload_feed_widgets );
	t.addEvent('bitBoxRemove', reload_feed_widgets);	
    
	var reload_page_widgets = function(){
	  $("ul#page").load("/widgets/for_page/" + request.page_id + "/editable/", function(){
			reset_new_widget_forms(); 
		});
	}



	reload_page_widgets();
	reload_feed_widgets();
	// setInterval(reload_feed_widgets, 15000); 

	$("ul#page").sortable({
	   axis: 'y',
	   containment: "ul#page",
	   tolerance: 'pointer',
	   placeholder: 'placeholder',
	   forcePlaceholderSize: true,
		 start: function(event, ui){
				$(".placeholder").css("height", ui.item.css("height"));
		 },
	   update: function(event, ui){     
	      // Get the dragged widget id.
	      var widget_id = ui.item.data("widget_id");
	      // Compute the new position of this widget.
	      var position = ui.item.index() + 1;
      
	      if (ui.item.hasClass("page_feed_widget")) {
        	
					ui.item.removeClass("page_feed_widget").addClass("editable_widget").addClass("loading");	
          
	        // Clone the widget.
	        $.post("/widgets/" + widget_id + "/copy_to_page/" + request.page_id, { position : position }, function(data){               
	            reload_page_widgets();
	          }
	        );
        
	        mpq.push(["track","page_add_widget_from_feed", {page_id : request.page_id, user_id : request.user_id, comment_count : ui.item.attr("comments")}]);      
      
	      } else {
        
	        // Update the widget's position on the server.
	        $.post("/widgets/" + widget_id + "/move/" + position, { _method : 'PUT' });
      
	        mpq.push(["track","page_reorder_widgets", {page_id : request.page_id, user_id : request.user_id}]);
      
	      }
      
	    }
	 });
	
	$(".add_widget_mock").click(function(){
		// We don't actually add widgets from the page edit page,
		// but instead track the event so that we know if people
		// want to.
		mpq.push(["track","add_widget_from_edit_page", {page_id : request.page_id, user_id : request.user_id}]);
	});      
    
	mpq.push(["track","hit_edit_page", {page_id : request.page_id, user_id : request.user_id}]);
	mpq.push(["track_forms",$("form#update_page"),"page_change_title", {page_id : request.page_id, user_id : request.user_id}]);
	
	// PUBLIC METHODS
	
	update_after_edit = function(){
		reload_page_widgets();
	}
	
});