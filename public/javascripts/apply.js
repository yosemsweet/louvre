$(document).ready(function(){
	
	$("#apply-form").dialog({
		autoOpen:false,
		modal:true,
		width:435,
		height:225,
		title:"Apply to This Community",
		buttons:{
			"ok":function(){
				$("#apply").remove();
				$(".ui-dialog-buttonset").remove();
				$.post("/canvae/" + request.canvas_id + "/applicants", { note:$("#note").val() }, function(){
						$("#apply-form").text("Thank you for applying.");
						setTimeout('$("#apply-form").dialog("close")',2000);
					});
			},
			"cancel":function(){
				$("#note").val('');
				$("#apply-form").dialog("close");
				}
			},
		show:"scale",
		hide:"puff"
	});
	
	$("#apply").click(function(event){
		event.preventDefault();
		$("#apply-form").dialog("open");
	});
	
});