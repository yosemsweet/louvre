class Canvas < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"

	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :creator, :presence => true

end
