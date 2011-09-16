class Event < ActiveRecord::Base
	
  include	Rails.application.routes.url_helpers
	
	belongs_to :loggable, :polymorphic => true
	belongs_to :canvas
	belongs_to :user

	def url
	  case loggable.class.name
    when "Widget"
      widget_path(loggable)
    when "Page"
      canvas_page_path(loggable.canvas, loggable)
    when "Canvas"
      canvas_path(loggable)
    else
      root_path
    end
  end
	
end
