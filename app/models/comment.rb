class Comment < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	belongs_to :widget
	
	validates :creator, :presence => true
	validates :widget, :presence => true
	validates :content, :presence => true
end
