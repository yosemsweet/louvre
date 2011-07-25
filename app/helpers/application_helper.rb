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
  
end
