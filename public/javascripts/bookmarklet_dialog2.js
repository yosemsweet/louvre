function getText()
{
  var txt = '';
  if (window.getSelection){
    txt = window.getSelection();
  }
  else if (document.getSelection){
    txt = document.getSelection();
  }
  else if (document.selection){
    txt = document.selection.createRange().text;
  }
  
  return txt;
}

function loadcss(){
  var fileref=document.createElement("link");
  fileref.setAttribute("rel", "stylesheet");
  fileref.setAttribute("type", "text/css");
  fileref.setAttribute("href", host_uri+"/stylesheets/bookmarklet_style.css?"+Math.floor(Math.random()*99999));
  document.getElementsByTagName("head")[0].appendChild(fileref);
}

function bookmarkletbox() {
  // bookmarklet is not opened already
  if (typeof bookmarklet_loaded=="undefined" || !bookmarklet_loaded ){
    // get the URL of current page
    var bookmarkURL = document.location.href;
    
    //add css
    loadcss()
    
    // get highlighted text
    var highlighted_text = getText();
    
    // create bookmarklet div
    var bookmarklet = document.createElement('div');
    bookmarklet.id = 'bookmarklet';
    bookmarklet.innerHTML = '\
    <div class="bookmarklet-heading">Add a link snippet to your community</div>\
    <div class="bookmarklet-body" id="bookmarklet_body">\
      <form id="snippet" name="snippet">\
        <div class="bookmarklet-field"><label class="bookmarklet-field-label" for="snippet-title">Title</label>\
        <input id="snippet_title" name="snippet_title" type="text" class="bookmarklet-input-field" /></div>\
        <div class="bookmarklet-field"><label class="bookmarklet-field-label" for="snippet-url">Url</label>\
        <input type="text" class="bookmarklet-input-field" name="snippet_link" id="snippet_link" value="' + bookmarkURL + '"/> \
        <div class="bookmarklet-field"><label value="snippet-text">Quote from site</label><br>\
          <TEXTAREA id="snippet_text" name="snippet_text" rows="20" cols="40" class="bookmarklet-input-field">'
          + highlighted_text +'</TEXTAREA></div>\
        <input type="button" onclick="closeBookmarklet()" value="cancel" class="bookmarklet-button" />\
        <input type="button" onclick="ajaxPostBookmarklet()"  value="add to community" class="bookmarklet-button" />\
        </form></div>';
    page_body.appendChild(bookmarklet);
    
    // remove bookmarklet loading message
    if(document.getElementById('loading')!=""){
      // destory loading text
      document.getElementById('loading').style.visibility = 'hidden'; 
    }
  }
}

// close created dialog box
function closeBookmarklet(){
  var bookmarklet = document.getElementById("bookmarklet");
  page_body.removeChild(bookmarklet);
  bookmarklet_loaded = false;
}


// function post using ajax
function ajaxPostBookmarklet(){
	var ajaxRequest;  // The variable that makes Ajax possible!
	
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create action after post
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
		  // success message
			var bookmarklet_body = document.getElementById('bookmarklet_body');
      bookmarklet_body.innerHTML = "Snippet Successfully added to your canvas.<br>\
        Go to <a href='" + host_uri+"/canvae/"+ canvas_id +"'>your canvas</a>.<br>\
        <input type='button' onclick='closeBookmarklet()' value='close' class='bookmarklet-button' />";
		}
	}
	
	// fetch information to send
	var snippet_title = encodeURIComponent(document.snippet.snippet_title.value);
	var snippet_text = encodeURIComponent(document.snippet.snippet_text.value);
	var snippet_link = encodeURIComponent(document.snippet.snippet_link.value);
	var parameters = "widget[title]=" + snippet_title + "&widget[text]=" + snippet_text + 
	"&widget[content_type]=link_content" + "&widget[link]=" + snippet_link + 
	"&widget[creator_id]=" + user_id+ "&canvas_id=" + canvas_id;
  var send_url = host_uri+'/widgets';
  ajaxRequest.open("POST",send_url, true);
  ajaxRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  ajaxRequest.send(parameters);
}

page_body = document.getElementsByTagName('body')[0];
bookmarkletbox();
bookmarklet_loaded = true;

