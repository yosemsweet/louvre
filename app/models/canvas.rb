class Canvas < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	has_many :pages
  has_many :widgets
  has_many :canvas_follows
  
	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :creator, :presence => true

  acts_as_opengraph :values => { :type => "cause" }


	def self.recently_updated(i)
		Canvas.order('updated_at desc').limit(i)
	end

end
