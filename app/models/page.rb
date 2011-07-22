class Page < ActiveRecord::Base

	belongs_to :canvas
	belongs_to :creator, :class_name => "User"
	has_many :widgets
	
	
	validates :title, :presence => true
	validates :creator_id, :presence => true
	validates :canvas_id, :presence => true
	
end
