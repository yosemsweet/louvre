function getHighlightedText(){
	var text;
	try {
	  text = ((window.getSelection && window.getSelection()) || (document.getSelection && document.getSelection()) || (document.selection && document.selection.createRange && document.selection.createRange().text));
	}
	catch(e){ 
		// Access denied on https sites.
	  text = "";
	}
	return text.toString();
}

function appendToHead(dom_element){
	document.getElementsByTagName("head")[0].appendChild(dom_element);
}

function removeDialog(){
	$("#loorp_bookmarklet").remove();
}

function createBookmarkletDialog(){
	
	// Get the current url.
	var bookmarkURL = jQuery(location).attr('href');

	// Generate the dialog markup.
	var dialog_element = document.createElement('div');
	dialog_element.id = 'loorp_bookmarklet';
	dialog_element.innerHTML = "\
		<h2>Add to Canvas</h2>\
		<form action='" + host_uri + "/canvae/" + canvas_id + "/widgets.json'> \
			<textarea name='widget[content]' rows='10' cols='36'>" + bookmarkURL + "\n" + getHighlightedText() + "</textarea> <br> \
			<input type='hidden' name='widget[content_type]' value='text_content'/> \
			<input type='hidden' name='widget[creator_id]' value='" + user_id + "'/> \
			<input type='submit' value='OK'> \
			<a id='cancel' href='#'>Cancel</a> \
		</form> \
	";
	
	// Append the dialog markup to the current page body.
	var page_body = document.getElementsByTagName('body')[0];
	page_body.appendChild(dialog_element);
	
	var $form = $("#loorp_bookmarklet form");
	
	// On form submit, send an ajax request to our loorp to create a new text widget.
 	$form.submit(function(event) {
		event.preventDefault(); 
    
		// Submit the form.
    $.post( $form.attr("action"), $form.serialize());

		removeDialog();
		
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
	var c = document.createElement("link"); c.type = 'text/css'; c.rel = 'stylesheet'; c.href = host_uri + '/stylesheets/bookmarklet_dialog.css';
	appendToHead(c);
	
	// Load jQuery.
	var e = document.createElement('SCRIPT'); e.type = 'text/javascript'; e.src = 'https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js';
	appendToHead(e);
	
	// Create the bookmarklet dialog.
	setTimeout(createBookmarkletDialog, 500);
})();



