function appendToHead(dom_element){
	document.getElementsByTagName("head")[0].appendChild(dom_element);
}

function removeDialog(){
	$("#loorp_bookmarklet").remove();
}

function createBookmarkletDialog(){
	
	// Get the current url.
	var bookmarkURL = jQuery(location).attr('href');
	rangy.init();
	rangy.getSelection().refresh();

	// Generate the dialog markup.
	var dialog_element = document.createElement('div');
	dialog_element.id = 'loorp_bookmarklet';
	dialog_element.title = "Add to Canvas";
	dialog_element.innerHTML = "\
		<form action='" + host_uri + "/widgets'> \
			<input type='text' name='widget[title]' value='" + document.title + "'/> \
			<textarea name='widget[text]' rows='10' cols='36'>" + rangy.getSelection().toHtml() + "</textarea> <br> \
			<input type='hidden' name='widget[content_type]' value='link_content'/> \
			<input type='hidden' name='widget[link]' value='" + bookmarkURL + "'/> \
			<input type='hidden' name='widget[creator_id]' value='" + user_id + "'/> \
			<input type='hidden' name='canvas_id' value='" + canvas_id + "'/> \
			<input type='submit' value='OK'> \
			<a id='cancel' href='#'>Cancel</a> \
		</form> \
	";
	
	// Append the dialog markup to the current page body.
	var page_body = document.getElementsByTagName('body')[0];
	page_body.appendChild(dialog_element);
	var bookmark_dialog = $( "#loorp_bookmarklet" ).dialog({minHeight:300, minWidth:500});
	bookmark_dialog.dialog('open');
	
	var $form = $("#loorp_bookmarklet form");
	
	// On form submit, send an ajax request to our loorp to create a new text widget.
 	$form.submit(function(event) {
		event.preventDefault(); 
    
		// Submit the form.
    $.post( $form.attr("action"), $form.serialize());
		dialog_element.title = "Link added";
		dialog_element.innerHTML = "<p><strong>Success!</strong></p><p><a id='close' href='#'>Close</a></p>";
		$("#loorp_bookmarklet #close").click(removeDialog);
		
				
		// Track submit via bookmarklet event.
		loorp_mpq.push(["track","click_save_bookmarklet"]);
  });

	$("#loorp_bookmarklet #cancel").click(removeDialog);
	
}

(function() {
	// Initialize mixpanel.
	loorp_mpq = [];
	loorp_mpq.push(["init", "514bbd502c105398458bf10f8b686b0d"]);
	(function() {
		var mp = document.createElement("script"); 
		mp.type = "text/javascript"; 
		mp.async = true;
	 	mp.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + "//api.mixpanel.com/site_media/js/api/mixpanel.js";
	 	var s = document.getElementsByTagName("script")[0]; 
		s.parentNode.insertBefore(mp, s);
	})();
	
	// Track bookmarklet click event.
	loorp_mpq.push(["track","hit_form_bookmarklet"]);

	// Load bookmarklet dialog styles.
	var c = document.createElement("link"); c.type = 'text/css'; c.rel = 'stylesheet'; c.href = host_uri + '/stylesheets/compiled/bookmarklet_dialog.css';
	appendToHead(c);
	
	// Load jQuery.
	if( typeof jQuery == 'undefined'){
		var e = document.createElement('SCRIPT'); e.type = 'text/javascript'; e.src = 'https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js';
		appendToHead(e);
	}
	
	if (typeof jQuery.ui == 'undefined') {
	  	var f = document.createElement('SCRIPT'); f.type = 'text/javascript'; f.src = 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js';
		appendToHead(f);
	}
	
	if (typeof rangy == 'undefined') {
		var g = document.createElement('SCRIPT'); g.type = 'text/javascript'; g.src = host_uri + '/javascripts/rangy/rangy-core.js';
		appendToHead(g);
	}

	// Create the bookmarklet dialog.
	setTimeout(createBookmarkletDialog, 500);
})();



