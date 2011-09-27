class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :uid, :presence => true
  validates :provider, :presence => true

	has_many :canvae, :class_name => "Canvas", :foreign_key => 'creator_id'
  has_many :canvas_follows
  has_many :followed_canvae, :through => :canvas_follows
  has_many :emails
  has_many :feedbacks
  has_many :canvas_user_roles
	has_many :events

	acts_as_follower
	
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]
      if auth["user_info"]  
        user.name = auth["user_info"]["name"]  
  			user.image = auth["user_info"]["image"]
  			email = Email.create(:address => auth["user_info"]["email"], :primary => 1)
  			user.emails << email
  			user.last_action = Time.now
  			user.notifications_viewed_at = Time.now
  			user.can_email = true
			end
    end  
  end

	def to_s
		name
	end

  def primary_email
    emails.where(:primary => 1).first
  end
	
	def primary_email=(email)
    if emails.map(&:id).include?(email.id)
      emails.each {|email| email.update_attributes(:primary => 0)}
      email.update_attributes(:primary => 1)
      return email
    else
      return false
    end
  end
	
	def self.find_by_email(address)
	  email = Email.where(:address => address).first
	  if email
	    email.user
	  else
	    nil
	  end
	end
	
	def admin?
	  admin || false
  end
	  
	# canvas_role
	#
	# @params
	#   canvas : A canvas object
	# @returns
	#   a role object representing this user's role for the given canvas.
	#   if the user is an
	def canvas_role(canvas)
	  # If they are admin, give them the admin role.
	  if admin?
	    role = Role.new(:admin)
    else
      # If they have a role, return that.
  	  user_roles = canvas_user_roles.where(:canvas_id => canvas.id)
  	  if user_roles.length > 0
  	    role = Role.new(user_roles.first.role)
  	  else
  	    # If they are logged in, give them the user role.
        if persisted?
          role = Role.new(:user)
        else
          role = Role.new(:visitor)
        end
  	  end
	  end
	  return role
	end

  # canvas_role?
  #
  # @params
  #   canvas      : A canvas object
  #   role_name   : The name of a role as a symbol
  # @returns
  #   true if this user has at least the given role for the given canvas
  #   false otherwise
  def canvas_role?(canvas, role_name)  
    if not canvas
      raise "invalid canvas"
    end
    if not role_name
      raise "invalid role"
    end
      
    canvas_role(canvas) >= role_name

  end
  
  # set_canvas_role
  #
  # @params
  #   canvas      : A canvas object
  #   role_name   : The name of a role as a symbol
  # @after
  #   The user is removed from any role they previously had for the given canvas.
  #   The user is assigned the given role for the given canvas.
  def set_canvas_role(canvas, role_name)
    transaction do
      CanvasUserRole.where(:canvas_id => canvas.id, :user_id => self.id).delete_all
      CanvasUserRole.create!(:canvas_id => canvas.id, :user_id => self.id, :role => role_name)
    end
  end
  
  def canvas_roles
    canvas_user_roles.not_banned
  end

	
end
