$(function(){
	// Enable page following buttons.
	$("#follow button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.follow('page', request.page_id, reload_hud);
	});
	$("#stop_following button").click(function(){
	  FollowHelper.toggle_follow_status();
	  FollowHelper.stop_following('page', request.page_id, reload_hud);    
	});

	$("a.related_page_link").click(function(){
	  mpq.push(["track_links",$(".login-link"),"click_login"]);
	});
	
});