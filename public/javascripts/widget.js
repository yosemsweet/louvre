$(document).ready(function(){

	
	// Add widget links.
	$(".add_widget").click(function(event){
		var content_type = $(this).data("content_type");
		var widget = $("ul#inline_form li.widget." + content_type);
		
		// hide all new widgets before opening the one that was clocked on
		$("ul#inline_form").children().not(widget.parent()).hide();
		
		$(widget).removeClass('edit-mode');

		// Fire the edit event for the widget.
		$(".edit", widget).click();
						
		// Ensure that the content is hidden to make toggling work properly.
		$(".content", widget).hide();	
		
		// Toggle the display of the widget.
		widget.parent().toggle();
		
		return(false);
	  event.preventDefault();
	
	});

  $(".widget .widget_history").live("click", function(event){
	
  	var widget_id = $(this).parents(".widget").data("widget_id");
    $(".widget_history_content").dialog({
      width: 500,
      title: 'Snippet Edit History',
			modal: true,
			height: 400
    });
		
    $(".widget_history_content").html('<img src="/images/loading-medium.gif">');
    $(".widget_history_content").load("/widgets/" + widget_id + '/edit_history');

  });

	$(".cancel_edit").click(function(event){
		var widget_id = $(this).parents(".widget").data("widget_id");
		if(typeof widget_id === "undefined"){
			widget_id = 0;
		}
		var widget = $(this).parents(".widget");
	
		if (widget_id == 0){
			widget.parent().toggle();
		}
	});

	// Edit widget links.
	$(".widget .edit, .cancel_edit").live("click", function(event){

		var widget_id = $(this).parents(".widget").data("widget_id");
		if(typeof widget_id === "undefined"){
			widget_id = 0;
		}
		var widget = $(this).parents(".widget");
		
		$facebook_comments = $(this).parents(".widget").find(".facebook_comments");
		$facebook_comments.hide();
		
		$(widget).toggleClass('edit-mode');
		$(".content", widget).toggle();
		$(".controls", widget).toggle();
		$("form.edit_widget", widget).toggle();
		$("#widget_ckeditor_" + widget_id).ckeditor({toolbar : "Body"});
		
	  mpq.push(["track","canvas_edit_widget", {user_id : request.user_id, canvas_id : request.canvas_id, page_id : request.page_id, widget_id : widget_id}]);

    // hide hints
		if($("form.edit_widget", widget).is(":visible")){
			if ($("[data-target=edit-widget]").length){
	      $("[data-target=edit-widget]").hide();
	    }
		}

		event.preventDefault();
	
	});
	
	// Handle widget form saves.
	$(".widget form.edit_widget").live("submit", function(event){

		var widget_id = $(this).parents(".widget").data("widget_id");
		if(typeof widget_id === "undefined"){
			widget_id = 0;
		}
		
		var widget = $(this).parents(".widget");
		var widget_form_params = $(this).serialize();
		
		// Validate the form.
		var form_elements = $(this)[0].elements;
		var is_valid = true;
		
		// alert($(this)[0].elements["widget[content_type]"].value);
		var this_content_type = $(this)[0].elements["widget[content_type]"].value;
		//text_content
		
		$(this).find("input,textarea").each(function(){
				if(typeof $(this).attr("name") != 'undefined') {
					if($.trim($(this).attr("name")) !== "" && $(this).attr("name") !== "widget[tag_names]"){
						if(this_content_type == 'link_content' && $(this).attr("name") == "widget[text]"){
							
						} else {
							if($.trim($(this).val()) === ""){
								is_valid = false;
							}
						}
					}
				}
			}
		);
		
		if(is_valid){
			// On success
			$(".add_widget").removeClass("active");
			widget_form_params._method = "PUT";
			$(this).hide();
			
			$(widget).removeClass('edit-mode');
			$(".loading", widget).addClass('align-center');
			$(".loading", widget).html("<img src='/images/loading-medium.gif'>").show();
			$(".content", widget).hide();

			
			$("#widget_ckeditor_" + widget_id).ckeditor(function(){
				this.destroy();
			});
			$(this)[0].reset();
			//reset tags
			

			$.post( $(this).attr("action"), widget_form_params, function(){
				
				if(widget_id != 0){
				
					// get the tags for this widget
					$.getJSON('/widgets/'+widget_id+'/tags.json', function(data) {
						taglist = '';
						$.each(data, function(index,value) { 
						  if(index == 0){
								taglist = 'TAGS: ' + value.tag.name
							}else{
								taglist = taglist + ", " + value.tag.name;
							}
						});
						$("[data-widget_id="+widget_id+"] .content .tags").html(taglist);
					});
					
					// get the widget info and populate both the displays and the forms
					$.get('/feed_widget/'+widget_id, function(data) {
						$("[data-widget_id="+widget_id+"] .content").html(data);
						$(".loading", widget).hide();
						$(".content", widget).fadeIn();
						$("[data-widget_id="+widget_id+"] .text_here").ThreeDots({ max_rows:3 });
					});
					
					// $.getJSON('/widgets/'+widget_id+'.json', function(data) {
					// 										
					// 						if(data.widget.content_type == "text_content"){
					// 							$("[data-widget_id="+widget_id+"] .content .text .text_here").html(data.widget.text);
					// 							$("[data-widget_id="+widget_id+"] .content .text .text_here").attr("threedots",data.widget.text);
					// 							$("[data-widget_id="+widget_id+"] .content .text .text_here").ThreeDots({max_rows:3});
					// 							
					// 							$("form#edit_widget_"+widget_id+" textarea#widget_ckeditor_"+widget_id).val(data.widget.text);
					// 						
					// 						}else if(data.widget.content_type == "image_content"){
					// 							$("[data-widget_id="+widget_id+"] .content .widget_image_wrapper img").attr('src',data.widget.image);
					// 							$("[data-widget_id="+widget_id+"] .content .widget_image_wrapper img").attr('alt',data.widget.alt_text);
					// 							$("[data-widget_id="+widget_id+"] .content .widget_image_wrapper img").attr('title',data.widget.alt_text);
					// 							$("[data-widget_id="+widget_id+"] .content .widget_image_wrapper figcaption").html(data.widget.alt_text);
					// 							$("form#edit_widget_"+widget_id+" input#widget_image").val(data.widget.image);
					// 							$("form#edit_widget_"+widget_id+" input#widget_alt_text").val(data.widget.alt_text);
					// 						
					// 						}else if(data.widget.content_type == "link_content"){
					// 							$("[data-widget_id="+widget_id+"] .content a").attr('href',data.widget.link);
					// 							$("[data-widget_id="+widget_id+"] .content a cite").html(data.widget.title);
					// 							if(data.widget.text == ""){
					// 								$("[data-widget_id="+widget_id+"] .content blockquote").hide();
					// 							}else{
					// 								$("[data-widget_id="+widget_id+"] .content blockquote").show();
					// 								$("[data-widget_id="+widget_id+"] .content blockquote").attr('cite',data.widget.link);
					// 								$("[data-widget_id="+widget_id+"] .content blockquote").html(data.widget.text);
					// 							}
					// 							
					// 							$("form#edit_widget_"+widget_id+" input#widget_title").val(data.widget.title);
					// 							$("form#edit_widget_"+widget_id+" input#widget_link").val(data.widget.link);
					// 							$("form#edit_widget_"+widget_id+" textarea#widget_text").val(data.widget.text);
					// 						
					// 						}else if(data.widget.content_type == "question_content"){
					// 							$("[data-widget_id="+widget_id+"] .content .question .question_text").html(data.widget.question);
					// 							$("form#edit_widget_"+widget_id+" textarea#widget_question").val(data.widget.question);
					// 						
					// 						}
					// 						
					// 						$(".loading", widget).hide();
					// 						$(".content", widget).fadeIn();
					// 					});

				}else{
				  $(widget).parent().hide();
				  $(".loading", widget).hide();
					update_after_edit();
				}

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
		apprise('Are you sure you want to delete this snippet?', {'verify':true, 'animate':true}, function(r){
			if(r){ 
				$.post("/widgets/" + widget_id, { _method : 'DELETE' });
				$widget.fadeOut('slow', function() {
				    $widget.remove();
						if($("ul#page li").length == 0)
							$("ul#page").append('<div class="drag-snippets-here">Drag Snippets Here</div>');
					});
				mpq.push(["track","page_remove_widget", {user_id : request.user_id, canvas_id : request.canvas_id, page_id : request.page_id, widget_id : widget_id}]);
			}
		});
    event.preventDefault();
  });

	// Widget comment toggler links.
	$(".widget .toggle_facebook_comments").live('click', function(event){
		$facebook_comments = $(this).parents(".widget").find(".facebook_comments");
		$facebook_comments.toggle();
  	FB.XFBML.parse($facebook_comments.get(0));
		update_widget_comment_counts();
	  event.preventDefault();
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
	// $(".widget_editable")
	//     .live('mouseover', function(){$(this).find('.toolbox').show()})
	//     .live('mouseout', function(){$(this).find('.toolbox').hide()})
	
	
	
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
	
	clear_new_textbox_list = function(){
    $('.new_widget_form').siblings('.textboxlist').each(function(){$(this).remove();})
    new_widget_forms_tokenized = 0;
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
				var comments = n > 0 ? n : "0" ;
				if(comments == 1)
					var label = " comment"
				else
					var label = " comments"
				$('.comment_count', $widget).text( comments + label);
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