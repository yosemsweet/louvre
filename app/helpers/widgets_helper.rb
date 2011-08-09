module WidgetsHelper
  
  def render_widget_section(section, widget = nil)
    render :partial => "widgets/sections/#{section}", :object => widget, :as => :widget
  end

end
