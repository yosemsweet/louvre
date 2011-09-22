$(document).ready(function(){

	// Add widget links.
	$(".add_widget").click(function(event){
	  event.preventDefault();
	
		var content_type = $(this).data("content_type");
		var widget = $("ul#inline_form li.widget." + content_type);
		
		// hide all new widgets before opening the one that was clocked on
		$("ul#inline_form").children().not(widget.parent()).hide();
		
		// Control the look of the tabs
		var is_active = $(this).hasClass("active");
		$(".add_widget").removeClass("active");
		if(! is_active){
			$(this).addClass("active");
		}
		// Fire the edit event for the widget.
		$(".edit", widget).click();
		// Ensure that the content is hidden to make toggling work properly.
		$(".content", widget).hide();	
		// Toggle the display of the widget.
		widget.parent().toggle();
		
	});

	// Edit widget links.
	$(".widget .edit").live("click", function(event){
		event.preventDefault();
	  var widget_id = $(this).parents(".widget").data("widget_id");
		if(typeof widget_id === "undefined"){
			widget_id = 0;
		}
		
		var widget = $(this).parents(".widget");
		
		$(".content", widget).toggle();
		
		$("form.edit_widget", widget).toggle();
		
		$("#widget_ckeditor_" + widget_id).ckeditor({toolbar : "Body"});
		
	  mpq.push(["track","canvas_edit_widget", {user_id : request.user_id, canvas_id : request.canvas_id, page_id : request.page_id, widget_id : widget_id}]);
	
	});
	
	// Handle widget form saves.
	$(".widget form.edit_widget").live("submit", function(){

		var widget_id = $(this).parents(".widget").data("widget_id");
		if(typeof widget_id === "undefined"){
			widget_id = 0;
		}
		
		var widget = $(this).parents(".widget");
		var widget_form_params = $(this).serialize();
		
		// Validate the form.
		var form_elements = $(this)[0].elements;
		var is_valid = true;
		
		for(var i=0; i < form_elements.length ; i++){
			var element = form_elements[i];
			if(element.name.trim() !== "" && element.name !== "widget[tag_names]"){
				// Require the field to be filled out.
				if(element.value.trim() === ""){
					is_valid = false;
				}
			}
		}
		if(is_valid){
			// On success
			$(".add_widget").removeClass("active");
			widget_form_params._method = "PUT";
			$(this).hide();
			$(".content", widget).html("<img src='/images/loorping.gif'>").show();
			$("#widget_ckeditor_" + widget_id).ckeditor(function(){
				this.destroy();
			});
			$(this)[0].reset();
		
			$.post( $(this).attr("action"), widget_form_params, function(){
				update_after_edit();
			});	
		} else {
			$("#flash").html("<div class='error'>Form inputs are invalid. Please check your form and try again.</div>").show();
			
			setTimeout(function(){$('#flash').fadeOut('slow')}, 2000);
		}
		
		return(false);
    event.preventDefault();

	});

	// Delete widget links.
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

	// Widget comment toggler links.
	$(".widget .toggle_facebook_comments").live('click', function(event){
	  event.preventDefault();
	
		$facebook_comments = $(this).parents(".widget").find(".facebook_comments");
		$facebook_comments.toggle();
  	FB.XFBML.parse($facebook_comments.get(0));
	});
	
	$(".widget .delete_answer").live('click', function(event){
		event.preventDefault();
		if(confirm("Are you sure?")){
			var widget_id = $(this).parents(".widget").data("widget_id");
			var answer_id = $(this).parent("li").index() ;
			$(this).parent("li").fadeOut(500, function(){$(this).remove()});
			
			$.post("/widgets/" + widget_id + "/remove_answer/" + answer_id, {_method: "PUT"});
		}
	});

	// Handle comment added events.
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
	
	// Show the widget toolbox when we hover over widgets.
	$(".widget_editable")
    .live('mouseover', function(){$(this).find('.toolbox').show()})
    .live('mouseout', function(){$(this).find('.toolbox').hide()})
	
	
	
	// PUBLIC METHODS
	
	// Make the widget_tag_ids field into a tokenized field.
	new_widget_forms_tokenized = 0;
	
	make_textbox_list = function(){
		$('.widget_tag_ids').each(function(){
			if (new_widget_forms_tokenized == 0 || !$(this).hasClass('new_widget_form')){
				var t = new $.TextboxList($(this), { 
			    unique: true,
			    addKeys: [],
			    plugins: {
			      autocomplete: {
			        minLength: 2,
			        queryRemote: true,
			        remote: {
			          url: '/tags'}
			        }
			      }
			    });

				var tag_names = $(this).data('current_tags');

			  _.each(tag_names, function(tag){
			    t.add(tag);
			  });
			}
		});
		
		new_widget_forms_tokenized = 1;
		
	}
	
	reset_new_widget_forms = function(){
		var $widget = $("ul#inline_form li.widget");
		// Fire the edit event for new form widgets.
		$(".edit", $widget).click();
		// Hide the new form widgets.
		$widget.parent().hide();
		// Ensure the content for new form widgets is hidden,
		// so that toggling works properly.
		$(".content", $widget).hide();	
	}
	
	update_widget_comment_counts = function(){
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
	        width: {min:200, max:900},
	        border: { width: 5, radius: 10 },
	        padding: 10, 
	        tip: true,
	        name: 'light' 
	      }
	    });
	  });
	}
});