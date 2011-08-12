var FollowHelper = {
	follow : function(type, id, callback){
		$.post("/follows/", {followable_type: type, followable_id: id}, function(response){ callback(response); }
	},
	stop_following : function()(type, id, callback){
		$.post("/follows/", {_method : "DELETE", followable_type: type, followable_id: id}, function(response){ callback(response); }
	}
}