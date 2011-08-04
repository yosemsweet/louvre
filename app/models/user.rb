class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :uid, :presence => true
  validates :provider, :presence => true

	has_many :canvae, :class_name => "Canvas", :foreign_key => 'creator_id'
  has_many :canvas_follows
  has_many :followed_canvae, :through => :canvas_follows
	
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]
      if auth["user_info"]  
        user.name = auth["user_info"]["name"]  
  			user.image = auth["user_info"]["image"]
  			user.email = auth["user_info"]["email"]
			end
    end  
  end

	def to_s
		name
	end
	
	def following_canvas?(canvas)
	  followed_canvae.include?(canvas)
  end
end
