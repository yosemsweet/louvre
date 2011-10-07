$(function(){


	$("a.related_page_link").click(function(){
	  mpq.push(["track_links",$(".login-link"),"click_login"]);
	});
	
	// versions dialog
	var $versions_dialog = $("<div></div>")
		.html('May we contact you about this feature?')
		.dialog({
		  minHeight:250, 
		  minWidth:500,
			title:"Versions Feature Coming Soon",
			buttons: [
		    { text: "Yes", click: function() {
						$.post("/feedbacks/", "interested_in=versions");
						$(this).dialog("close");
					}
				},
				{ text: "No", click: function() { $(this).dialog("close"); } }
			],
			resizable: false,
		  autoOpen:false
	});

	$("a#versions").click(function() {
		mpq.push(["track","click_versions"]);
		$versions_dialog.dialog('open');
		// prevent the default action, e.g., following a link
		return false;
	});	
	
});