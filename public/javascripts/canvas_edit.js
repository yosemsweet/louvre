$(function(){
  click_to_edit_text = 'click on canvas name to edit';
  hit_enter_to_save_text = 'hit enter to save changes';
  old_canvas_name = $("#canvas_name").val();    

  open_canvas_name_edit = function(){
    $("#canvas_name_text").hide();
    $("#canvas_name").fadeIn();
    $("#canvas_name").focus().val($("#canvas_name").val());
    $("#canvas_name_input_note").html(hit_enter_to_save_text);
  }

  cancel_canvas_name_edit = function(){
    if($("#canvas_name").is(":visible")){
      $("#canvas_name_text").fadeIn();
      $("#canvas_name").hide();
      $("#canvas_name_input_note").html(click_to_edit_text);
      $('#canvas_name').val(old_canvas_name);
    }
  }

  $("#canvas_name").hide()
  $("#canvas_name_input_note").html(click_to_edit_text)

  $("#canvas_name_text").click(function(){
    open_canvas_name_edit();
  });

  $(".edit_canvas").live("submit", function(){
    var canvas_form_params = $(this).serialize();
    var new_canvas_name = $("#canvas_name").val();
    if ($("[data-target=edit-title]").length){
	    $("[data-target=edit-title]").hide();
	  }
    $("#canvas_name").hide();
    $('#canvas_name_text').html('<img src="/images/loading-medium.gif">');
    $("#canvas_name_text").fadeIn();
    $("#canvas_name_input_note").html('saving changes...');
    $.post( $(this).attr("action"), canvas_form_params, function(){
      $("#canvas_name_text").html(new_canvas_name);
      $("#canvas_name_text").fadeIn();
      $("#canvas_name_input_note").html(click_to_edit_text);
      $("title").html(new_canvas_name);
      $("#logo a").text(new_canvas_name);
    });
    return false;
    event.preventDefault();
  });

  $("#canvas_name").blur(function(){
    cancel_canvas_name_edit();
  });
  
  $(document).keyup(function(e) {
    if (e.keyCode == 27) {
      if($("#canvas_name").is(":visible")){
        cancel_canvas_name_edit();
      }
    }
  });

});