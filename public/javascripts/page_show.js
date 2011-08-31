$(function(){
	// Enable page following buttons.
	$("#follow").click(function(event){
		event.preventDefault();
	  FollowHelper.toggle_follow_status();
	  FollowHelper.follow('page', request.page_id, reload_hud);
	});
	$("#unfollow").click(function(event){	
		event.preventDefault();
	  FollowHelper.toggle_follow_status();
	  FollowHelper.unfollow('page', request.page_id, reload_hud);    
	});

	$("a.related_page_link").click(function(){
	  mpq.push(["track_links",$(".login-link"),"click_login"]);
	});
	
});