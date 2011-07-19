class Canvas < ActiveRecord::Base
	belongs_to :owner, :class_name => "User"

	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :owner, :presence => true
end
