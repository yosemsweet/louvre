module ApplicationHelper
  
  def render_form(model)
    name = model.class.name.underscore
    render :partial => "#{name.pluralize}/form", :locals => {name.to_sym => model}
  end
  
end
