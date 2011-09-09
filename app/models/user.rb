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
  has_many :roles, :through => :canvas_user_roles

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
	
	def role(canvas)
	  roles = canvas_user_roles.where(:canvas_id => canvas.id)
	  if roles.length > 0
	    return roles.first
	  else
	    return  Role.where(:name => 'visitor').first
	  end
	end

  def role?(canvas,role)
    if not canvas
      raise "invalid canvas"
    end
    if not role
      raise "invalid role"
    end
    
    roles = canvas_user_roles.where(:canvas_id => canvas.id)
    if roles.length > 0
      canvas_user_role = roles.first.role
    else 
      canvas_user_role = Role.where(:name => 'user').first
    end
    
    canvas_user_role.xp >= Role.where(:name => role).first.xp
  end
  
  def set_role(canvas,role_name)
    role = Role.where(:name=>role_name).first || return
    transaction do
      CanvasUserRole.where(:canvas_id => canvas.id, :user_id => self.id).delete_all
      CanvasUserRole.create!(:canvas_id => canvas.id, :user_id => self.id, :role_id => role.id)
    end
  end
	
end
