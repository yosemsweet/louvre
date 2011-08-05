function loadjscssfile(filename, filetype){
 if (filetype=="js"){ 
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
 }
 else if (filetype=="css"){
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
 }
 if (typeof fileref!="undefined")
  document.getElementsByTagName("head")[0].appendChild(fileref)
}

function loadJquery()
{
	var jquery=document.createElement('SCRIPT');
	jquery.type='text/javascript';
	jquery.src='http://code.jquery.com/jquery-latest.js';
	element=document.getElementsByTagName('head')[0];
	element.appendChild(jquery);
}

function getHighlightText(){
	var t;
	  try {
	    t= ((window.getSelection && window.getSelection()) ||
	(document.getSelection && document.getSelection()) ||
	(document.selection && 
	document.selection.createRange && 
	document.selection.createRange().text));
	  }
	  catch(e){ // access denied on https sites
	    t = "";
	  }
	return t;
}

function buildCommentForm()
{
	element=document.getElementsByTagName('body')[0];
	new_div=document.createElement('div');
	new_div.id='saucy_book_input_stream_form';
	
	highlighted = getHighlightText();	
	var bookmarkURL = jQuery(location).attr('href');
	
	new_content="<style>#saucy_book_input_stream_form{position:fixed;right:0; top:200px; width: 300px; height: 400px;\
			z-index:1000000000; \
			line-height: 1.5; \
			font-family: 'Helvetica Neue', Arial, Helvetica, sans-serif; \
			color: #333333; \
			font-size: 81.25%; \
			background-color: #fafaff;} \
		#title_content{ padding: 10px; background-color: #6991dc;text-align: center;margin-bottom:10px;box-shadow: 0 1px 2px #173162; \
		}</style>\
		\
		<div id='saucy-result'>\
		<div id='title_content'>Add to Canvas:</div>\
		<form id='saucy-input-form' action='" + host_uri + "/canvae/"+canvas_id+"/widgets.json'> \
		Text: <br> <textarea name='widget-content' rows='10' cols='20'>"+ bookmarkURL + "\n" +  highlighted.toString() +"</textarea> <br> \
		<input type='submit' value='Loorp It!'></form></div>";
	new_div.innerHTML = new_content;
	element.appendChild(new_div);
	
	/* attach a submit handler to the form */
  	$("#saucy-input-form").submit(function(event) {

    /* stop form from submitting normally */
    event.preventDefault(); 

    /* get some values from elements on the page: */
    var $form = $( this ),
        content = $form.find( 'textarea[name="widget-content"]' ).val(),
        url = $form.attr( 'action' );
    /* Send the data using post and put the results in a div */
    $.post( url, {widget:{content: content, creator_id: user_id, content_type: 'text_content'} }, function(data) {});
	$( "#saucy_book_input_stream_form" ).empty();
	mpq.push(["track","click_save_bookmarklet"]);
  });
}
(function() {
	mpq = [];
	mpq.push(["init", "514bbd502c105398458bf10f8b686b0d"]);
	(function() {
	 var mp = document.createElement("script"); mp.type = "text/javascript"; mp.async = true;
	 mp.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + "//api.mixpanel.com/site_media/js/api/mixpanel.js";
	 var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(mp, s);
	})();
	
	mpq.push(["track","hit_form_bookmarklet"]);

	loadjscssfile(host_uri + "/stylesheets/bookmarklet_form.css","css");
	loadJquery();
	setTimeout(buildCommentForm, 500);
})();



