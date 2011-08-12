var FollowHelper = {
	follow : function(type, id, callback){
		$.post("/follows/", {followable_type: type, followable_id: id}, function(){ callback(); });
	},
	stop_following : function(type, id, callback){
		$.post("/follows/", {_method : "DELETE", followable_type: type, followable_id: id}, function(){ callback(); });
	},
	toggle_follow_status : function(){
    $("#follow").toggle();
    $("#stop_following").toggle();
  }
}