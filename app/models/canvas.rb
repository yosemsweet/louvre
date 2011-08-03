class Canvas < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	has_many :pages
  has_many :widgets

	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :creator, :presence => true

  acts_as_opengraph :values => { :type => "cause" }

	def input_stream_widgets
		self.widgets.where(:page_id => nil)
	end

	def self.recently_updated(i)
		Canvas.order('updated_at desc').limit(i)
	end

end
