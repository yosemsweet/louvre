class Canvas < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
end
