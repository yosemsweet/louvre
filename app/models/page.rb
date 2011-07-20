class Page < ActiveRecord::Base

	belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	
end
