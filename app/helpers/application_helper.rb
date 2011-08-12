module ApplicationHelper

  def application_javascripts
    %w(
    https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js
    https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js
    http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.1.7/underscore-min.js
    http://connect.facebook.net/en_US/all.js
    http://texteditor.suite101.com.s3.amazonaws.com/ckeditor.js
    http://texteditor.suite101.com.s3.amazonaws.com/adapters/jquery.js
    jquery-qtip-1.0.0-rc3.min
    application
    widget
    facebook_integration
    mixpanel_integration google_analytics
    jquery.tokeninput
    FollowHelper
    )
  end
  
  def application_stylesheets
    %w(
    http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/ui-lightness/jquery-ui.css
    application
    token-input-facebook
    )
  end

  def host_uri    
    protocol = request.ssl? ? "https://" : "http://"
    host = request.host
    port = request.port ? ":" + request.port.to_s : ""
    
    return protocol + host + port
  end
  
  def hidden_if(condition)
    condition ? "display: none;" : ""
  end
  
end
