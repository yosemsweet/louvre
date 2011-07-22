function loadJquery()
{
	var jquery=document.createElement('SCRIPT');
	jquery.type='text/javascript';
	jquery.src='http://code.jquery.com/jquery-latest.js';
	element=document.getElementsByTagName('head')[0];
	element.appendChild(jquery);
}

function buildCommentForm()
{
	element=document.getElementsByTagName('body')[0];
	new_div=document.createElement('div');
	new_div.id='saucy_book_input_stream_form';
	new_div.innerHTML="<div id='saucy-result'></div> \
		<form id='saucy-input-form' action='http://localhost:3000/canvae/1/things.json'> \
		Input: <input type='text' name='thing-content'> \
		<input type='submit' value='Submit'></form>";
	element.appendChild(new_div);
	
	/* attach a submit handler to the form */
  	$("#saucy-input-form").submit(function(event) {

    /* stop form from submitting normally */
    event.preventDefault(); 

    /* get some values from elements on the page: */
    var $form = $( this ),
        content = $form.find( 'input[name="thing-content"]' ).val(),
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
(function(){
	loadJquery();
	buildCommentForm();
	alert("Hey Baby - this rocks");})();



