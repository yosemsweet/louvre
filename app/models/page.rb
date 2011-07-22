class Page < ActiveRecord::Base

	belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	has_many :widgets
		
	validates_presence_of :title
	validates_presence_of :creator
	validates_presence_of :canvas
	
end
