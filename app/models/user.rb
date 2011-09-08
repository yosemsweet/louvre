class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :uid, :presence => true
  validates :provider, :presence => true

	has_many :canvae, :class_name => "Canvas", :foreign_key => 'creator_id'
  has_many :canvas_follows
  has_many :followed_canvae, :through => :canvas_follows
  has_many :emails
  has_many :feedbacks

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
	
end
