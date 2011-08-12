$(function() {

	var $widget_dialog = $("#widget_dialog").dialog({
	  minHeight:250, 
	  minWidth:500, 
	  autoOpen:false
	});
    
	$(".add_widget").click(function(event){
	  event.preventDefault();
	  if(request.page_id === 0){
		  var page_query = '';
	  } else {
		  var page_query = '&page_id=' + request.page_id;
	  }
	  $("iframe", $widget_dialog).attr("src", "/widgets/new?content_type=" + $(this).data("content_type") + "&canvas_id=" + request.canvas_id + page_query);
	  $widget_dialog.dialog("option","title", "New Widget");
	  $widget_dialog.dialog("open");
	});

	$(".widget .edit").live("click", function(event){
	  var widget_id = $(this).parents(".widget").data("widget_id");
	  $("iframe", $widget_dialog).attr("src", "/widgets/" + widget_id + "/edit");
	  $widget_dialog.dialog("option","title", "Edit Widget");
	  $widget_dialog.dialog("open");
  
	  mixpanel_attributes.widget_id = widget_id;
	  mpq.push(["track","canvas_edit_widget", mixpanel_attributes]);
  
	  event.preventDefault();
	});

  close_widget_dialog = function(){
    $widget_dialog.dialog("close");
  }

});