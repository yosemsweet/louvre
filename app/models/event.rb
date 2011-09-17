class Event < ActiveRecord::Base
	
	belongs_to :loggable, :polymorphic => true
	belongs_to :canvas
	belongs_to :user

end
