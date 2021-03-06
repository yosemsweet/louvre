$(function(){
  var ANIMATE = true;
  var MAX_SCROLLIES = 7;
 
  start_animation = function(){
    ANIMATE = true;
  }
  
  pause_animation = function(){
    ANIMATE = false;
  }
  
  enableWidgetTooltips = function(){
    $("a.toggle_preview").each(function(){
      $(this).qtip({
        content: $(this).parents().filter(".widget").find(".content").html(),
        show: 'mouseover',
        hide: 'mouseout',
        show: { delay: 0 },
        position: {
          corner: { 
            target: 'bottomLeft', 
            tooltip: 'topRight'
          },
          adjust: { screen: true }
        },
        style: {
          width: 572,
          border: {
            width: 5,
            radius: 10
          },
          padding: 10, 
          tip: true,
          name: 'light' 
        }
      });
    });
  }
  
  var getMoreWidgets = function(){
    var number_of_waiting_scrollies = $("#scrollyHider").children(".widget").length;
    
    if(number_of_waiting_scrollies < MAX_SCROLLIES) {  
    	$.get('/widgets', function(data) {
       	$(data).appendTo("#scrollyHider");
       	enableWidgetTooltips();
      });   
    }
  }
  
  // Widget hover / click handling
  $(".widget")
    .live('mouseover', pause_animation)
    .live('mouseout', start_animation);
  
  // function settings
  var window_width = $(window).width();
  var window_height = $(window).height();
  var header_height = $("#header").outerHeight();
  var drag_start = header_height + 75;
  var bottom_y = window_height + 200;
  var top_y = -50;
  var fps = 60;
  var animation_interval = 1000. / fps;
  var garbage_collection_interval = 1000;
  var insertion_interval = 1000;
  var collision_detection_interval = 50;
  var bubbles = {};
  var next_bubbles_index = 1;
  var more_widgets_interval = MAX_SCROLLIES * insertion_interval;
  
  var getBubbleId = function(bubble){
    return bubble.selector.data("bubble_id");
  }
  
  var insertNextBubble = function(){
    
    var number_of_scrollies = $("#scrolly").children(".widget").length;

    if(ANIMATE && number_of_scrollies <= MAX_SCROLLIES ){
      // Store the new bubble.
      var selector = $('#scrollyHider .widget:first-child');
      if(selector.length !== 0){
            
        // Insert the scrolly into the dom so we can calculate its dimensions.
        selector.prependTo("#scrolly");
      
        // Choose start parameters.
        var height = selector.outerHeight();
        var width = selector.outerWidth();
        var mass = height * width;
        var start_velocity = .1 + Math.random()*.2;
        var start_left = Math.floor( Math.random() * (window_width - width) );
        var start_right = start_left + width;
        var drag = 0;
				
        // Compute the right blocker.
        var blocker_right_y = -100000;
        var blocker_right = false;
        
        _.each(bubbles, function(b){
          if(start_left <= b.left && start_right > b.left){    
            var b_y = b.selector.position().top; 
            if(b_y > blocker_right_y){
              blocker_right = getBubbleId(b);
              blocker_right_y = b_y;
            }
          }
        });
        
        // Compute the left blocker.
        var blocker_left_y = -100000;
        var blocker_left = false;
        
        _.each(bubbles, function(b){
          if(start_right >= b.right && start_left < b.right){
            var b_y = b.selector.position().top; 
            if(b_y > blocker_left_y){
              blocker_left = getBubbleId(b);
              blocker_left_y = b_y;
            }
          }
        });

        // Save the bubble data.
        bubbles[next_bubbles_index] = {
          selector : selector, 
          blocker_left : blocker_left,
          blocker_right : blocker_right,
          left : start_left,
          right : start_right,
          velocity : start_velocity,
          mass : mass,
          height : height,
          drag : drag,
          dom_el : selector.get(0)
        }
        
        // Save bubble id in dom.
        selector.data("bubble_id", next_bubbles_index); 
        
        selector.css('left', start_left).css('top', bottom_y + 'px');

        next_bubbles_index = next_bubbles_index + 1;
        
      }
    }
  }
  
  var animateBubbles = function(){
    if(ANIMATE){
      _.each(bubbles, function(b){
        // Update the widget's position.
        var old_top = parseInt(b.dom_el.style.top.substring(0, b.dom_el.style.top.length - 2));
        b.dom_el.style.top = (old_top - (b.velocity * animation_interval)) + "px";
        
        // Update velocity for gravity.
        if(old_top < 500){
          // Accelerate up near the top of the page.
          b.velocity = b.velocity + 0.002;
        }
      
        // Update velocity for drag.
        b.velocity = b.velocity * (1 - b.drag);
        
        // Add drag at the top of the page.
        if(old_top < drag_start){
          b.drag = 0.98;
        }
        
      });
    }
  }
  
  var collectGarbage = function(){
    // Remove any bubbles that are above the top or below the bottom of the page.
    _.each(bubbles, function(b){
      var top = b.selector.position().top;
      if(top <= top_y || top > bottom_y + 200){
        delete bubbles[getBubbleId(b)];
        b.selector.empty().remove();
      }
    });
  }
  
  var adjustVelocity = function(b1,b2){
    var b2_bottom = parseInt(b2.dom_el.style.top.substring(0, b2.dom_el.style.top.length - 2)) + b2.height;
    var b1_top = parseInt(b1.dom_el.style.top.substring(0, b1.dom_el.style.top.length - 2));

    if(b1_top < b2_bottom){
      
      v1_i = b1.velocity;
      v2_i = b2.velocity;
      m1 = b1.mass;
      m2 = b2.mass;
      
      var v1_f = ((m1 - m2)*v1_i + 2*m2*v2_i)/(m1 + m2);
      var v2_f = ((2*(m1*v1_i) - (m1 - m2)*v2_i))/(m1 + m2);

      b1.velocity = 0.9*v1_f;
      b2.velocity = 0.9*v2_f;
      b2.dom_el.style.top = b1_top - b2.height + "px";
    }
  }
  
  var handleCollisions = function(){
    _.each(bubbles, function(b){
      var bubble_id = getBubbleId(b);

      // Check if this bubble has collided.
      if(b.blocker_left && bubbles[b.blocker_left] !== undefined){
        adjustVelocity(b,bubbles[b.blocker_left])
      }
      if(b.blocker_right && bubbles[b.blocker_right] !== undefined){
        adjustVelocity(b,bubbles[b.blocker_right])
      }
    });
  }
  
  getMoreWidgets();
  
  setInterval(getMoreWidgets, more_widgets_interval);
  setInterval(animateBubbles, animation_interval);
  setInterval(insertNextBubble, insertion_interval);
  setInterval(handleCollisions, collision_detection_interval);
  setInterval(collectGarbage, garbage_collection_interval);

});