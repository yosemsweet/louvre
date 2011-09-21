$(function(){
  
  var memberActions = {
    approve: function(user_id){
			$.post('/canvae/' + request.canvas_id + '/members', {user_id: user_id});
    },
    ban: function(user_id){
			$.post('/canvae/' + request.canvas_id + '/banned', {user_id: user_id});
    },
		unban: function(user_id){
			$.post('/canvae/' + request.canvas_id + '/banned', {user_id: user_id, _method: "DELETE"});
		},
    disapprove: function(user_id){
      $.post('/canvae/' + request.canvas_id + '/applicants/' + user_id, {_method: "DELETE"});
    },
	admin: function(user_id){
		$.post('/users/' + user_id, {user: {admin: true}, _method: "PUT"});
	},
	user: function(user_id){
		$.post('/users/' + user_id, {user: {admin: false}, _method: "PUT"});
	}
  }
  
  $(".member-item .tools a").click(function(event){
    event.preventDefault();
    
    var memberItem = $(this).parents(".member-item");
    
    var user_id = memberItem.data('user_id');

		    
    memberItem.fadeOut(); 
    // Run the appropriate action based on the class.
    eval("memberActions." + this.className + "(user_id);");

  });
  
});