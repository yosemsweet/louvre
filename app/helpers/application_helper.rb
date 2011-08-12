module ApplicationHelper
  def host_uri
    
    protocol = request.ssl? ? "https://" : "http://"
    host = request.host
    port = request.port ? ":" + request.port.to_s : ""
    
    return protocol + host + port
  end
  
  def render_form(model)
    name = model.class.name.underscore
    render :partial => "#{name.pluralize}/form", :locals => {name.to_sym => model}

  end
  
  def render_widgets(widgets, display_type)
    html = ""
    widgets.each do |widget|
      html << render(:partial => "widgets/displays/#{display_type}_widget", :locals => {:widget => widget})
    end    
    return html.html_safe
  end
  
  def application_javascripts
    %w(
    https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js
    https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js
    http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.1.7/underscore-min.js
    http://connect.facebook.net/en_US/all.js
    http://texteditor.suite101.com.s3.amazonaws.com/ckeditor.js
    http://texteditor.suite101.com.s3.amazonaws.com/adapters/jquery.js
    jquery-qtip-1.0.0-rc3.min
    facebook_integration
    mixpanel_integration google_analytics
    jquery.tokeninput
    )
  end
  
  def application_stylesheets
    %w(
    http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/ui-lightness/jquery-ui.css
    application
    token-input-facebook
    )
  end
  
end
