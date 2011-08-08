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
  
end
