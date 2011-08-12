$(function() {

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

	  mixpanel_attributes.widget_id = widget_id;
	  mpq.push(["track","canvas_edit_widget", mixpanel_attributes]);
  
	  event.preventDefault();
	});

  close_widget_dialog = function(){
    $widget_dialog.close();
  }

});