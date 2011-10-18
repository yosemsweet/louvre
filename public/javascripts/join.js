$(document).ready(function(){

	$("#join").click(function(event){
		event.preventDefault();
		$("#join").remove();    
    $.post('/canvae/' + request.canvas_id + '/members');
 		console.log('i joined');
	});

});