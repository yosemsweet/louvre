/*
 * jQuery Bookmarklet - version 1.0
 * Originally written by: Brett Barros
 * With modifications by: Paul Irish
 *
 * If you use this script, please link back to the source
 *
 * Copyright (c) 2010 Latent Motion (http://latentmotion.com/how-to-create-a-jquery-bookmarklet/)
 * Released under the Creative Commons Attribution 3.0 Unported License,
 * as defined here: http://creativecommons.org/licenses/by/3.0/
 *
 */
 
window.bookmarklet = function(opts){fullFunc(opts)};
 
// These are the styles, scripts and callbacks we include in our bookmarklet:
window.bookmarklet({
    css : ['http://localhost:3000/stylesheets/bookmarklet_style.css'],
    js  : ['http://localhost:3000/javascripts/bookmarklet_dialog2.js?123'],    
//	jqpath : 'myCustomjQueryPath.js', <-- option to include your own path to jquery
    ready : function(){
           bookmarkletbox();
   	    }
 
})
 
function fullFunc(a){
  function d(b)
  {
    if(b.length===0){a.ready();return false}
    $.getScript(b[0],function(){d(b.slice(1))})
  }
  function e(b)
  {
    $.each(b,function(c,f){
                            $("<link>").attr({href:f,rel:"stylesheet"}).appendTo("head")
                          }
            )
  }
  a.jqpath=a.jqpath||"https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js";
    (
      function(b)
      {
        var c=document.createElement("script");
        c.type="text/javascript";
        c.src=b;
        c.onload=function(){
                              e(a.css);
                              d(a.js)
                            };
        document.body.appendChild(c)
      }
      )
      (a.jqpath)
    };