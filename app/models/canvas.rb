class Canvas < ActiveRecord::Base
	after_save :add_owner_role
	
	belongs_to :creator, :class_name => "User"
	has_many :pages
  has_many :widgets
  has_many :canvas_follows
	has_many :canvas_user_roles
	
	validates :name, :presence => true, :uniqueness => true
	validates :mission, :presence => true
	validates :creator, :presence => true

  acts_as_opengraph :values => { :type => "cause" }	
	acts_as_followable

	def self.recently_updated(i)
		Canvas.order('updated_at desc').limit(i)
	end
	
  def owned_by?(owner)
    return false unless owner.is_a? User
    return creator == owner
  end
	
	def open?
		open
	end
	
	def closed?
		!open?
	end
	
	def user_roles
		canvas_user_roles.not_banned
	end

	def members
		canvas_user_roles.members
	end
	
	def banned
		canvas_user_roles.banned
	end
	
	private
	
	def add_owner_role
		self.creator.set_canvas_role(self, :owner) unless self.creator.nil?
	end

end
