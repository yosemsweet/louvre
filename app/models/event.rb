class Event < ActiveRecord::Base
	
  include	Rails.application.routes.url_helpers
  
	belongs_to :loggable, :polymorphic => true
	belongs_to :canvas
	belongs_to :user

	def url
	  
	  case loggable.class.name
    when "Widget"
      if loggable.page.nil?
        Rails.application.config.thehost+canvas_path(loggable.canvas)
      else
        Rails.application.config.thehost+canvas_page_path(loggable.canvas, loggable.page)
      end
    when "Page"
      Rails.application.config.thehost+canvas_page_path(loggable.canvas, loggable)
    when "Canvas"
      Rails.application.config.thehost+canvas_path(loggable)
    else
      Rails.application.config.thehost+root_path
    end
  end
	
end
