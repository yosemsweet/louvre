$(document).ready(function(){

	reload_event_count = function(){
		if($('#event_count').html() == '')
			$('#event_count').html('<img src="/images/loading-small.gif">');
		$.get('/event_count', function(data) {
			$('#event_count').html(data);
	
			if (data == 1){
				$('#event_count').attr('title',data + ' new notification');
			}else{
				$('#event_count').attr('title',data + ' new notifications');
			}
			
			if (data == 0){
				$('#event_count').addClass("no_new_events")
			}else{
				$('#event_count').addClass("new_events")
			}
		});
	}

	$('#event_list_container').hide();
	$('#event_count').click(function(){
		$('#event_count').html("0");
		$('#event_count').removeClass("new_events");
		$('#event_count').addClass("no_new_events");
		$('#event_list_container').html('');
		$('#event_list_container').addClass("loading_events_container");
		$('#event_list_container').slideToggle(function(){
			$.get('/events', function(data) {
				$('#event_list_container').removeClass("loading_events_container");
				$('#event_list_container').html(data);
			});
		});
	})

	$("body").mouseup(function(){ 
  	if($('#event_list_container').is(":visible"))
			$('#event_list_container').fadeToggle();
	});

	
	


	$('#flash').delay(500).fadeIn('normal', function() {
     $(this).delay(2500).fadeOut('slow');
  });

});