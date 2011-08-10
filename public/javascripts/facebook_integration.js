function getCommentCount(comment_href){
  
  var number_of_comments = 0;
  FB.api('/comments?ids=' + comment_href, function(response) {
    length = 0;
    if( comment_href in response ){
      pageinfo = response[comment_href]; 
      if( "data" in pageinfo ){
        length = pageinfo["data"]["length"];
      }
    }
    number_of_comments = length;
  });
  return number_of_comments;
}