class Canvas < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	has_many :pages
  has_many :widgets

	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :creator, :presence => true

end
