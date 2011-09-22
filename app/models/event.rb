class Event < ActiveRecord::Base
	
  include	Rails.application.routes.url_helpers
	
	belongs_to :loggable, :polymorphic => true
	belongs_to :canvas
	belongs_to :user

	def url
	  case loggable.class.name
    when "Widget"
      if loggable.page.nil?
        canvas_path(loggable.canvas)
      else
        canvas_page_path(loggable.canvas, loggable.page)
      end
    when "Page"
      canvas_page_path(loggable.canvas, loggable)
    when "Canvas"
      canvas_path(loggable)
    else
      root_path
    end
  end
	
end
