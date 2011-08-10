function countComments(comment_href, callback){
  
  
  FB.api('/comments?ids=' + comment_href, function(response) {
    length = 0;
    if( comment_href in response ){
      pageinfo = response[comment_href]; 
      if( "data" in pageinfo ){
        length = pageinfo["data"]["length"];
      }
    }
		
		callback(length);
  });
}