class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :uid, :presence => true
  validates :provider, :presence => true
	
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
end
