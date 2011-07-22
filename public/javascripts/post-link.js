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
	
	new_content="<style>#saucy_book_input_stream_form{\
			position:fixed;\
			right:0; top:200px; width: 300px; height: 400px;\
			z-index:1000000000; \
		background-color: grey; } </style>\
	<div id='saucy-result'> \
		Add to Canvas Name: <br> \
		<form id='saucy-input-form' action='http://localhost:3000/canvae/1/things.json'> \
		Text: <br> <textarea name='thing-content' rows='10' cols='20'>"+ bookmarkURL + "\n" +  highlighted.toString() +"</textarea> <br> \
		Comment: <input type='text' name='thing-comment'> <br> \
		<input type='submit' value='Get Sauced'></form></div>";
	new_div.innerHTML = new_content;
	element.appendChild(new_div);
	
	/* attach a submit handler to the form */
  	$("#saucy-input-form").submit(function(event) {

    /* stop form from submitting normally */
    event.preventDefault(); 

    /* get some values from elements on the page: */
    var $form = $( this ),
        content = $form.find( 'textarea[name="thing-content"]' ).val(),
        url = $form.attr( 'action' );
    /* Send the data using post and put the results in a div */
    $.post( url, { thing:{content: content, creator_id: 1} },
      function( data ) {
          var content = $( data ).find( '#content' );
          $( "#saucy-result" ).empty().append( content );
      }
    );
  });
}
(function() {
	loadJquery();
	 setTimeout(buildCommentForm, 500)
})();



