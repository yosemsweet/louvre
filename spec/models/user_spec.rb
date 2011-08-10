require 'spec_helper'

describe User do
  
  context "validations" do
  
    it "should require a name" do
      user = Factory.build(:user, :name => "")
      user.should_not be_valid
    end
  
    it "should require a provider" do
      user = Factory.build(:user, :provider => "")
      user.should_not be_valid
    end
  
    it "should require a uid" do
      user = Factory.build(:user, :uid => "")
      user.should_not be_valid
    end
  
  end
  
  describe "#create_with_omniauth" do
    it "should exist" do
      User.should respond_to(:create_with_omniauth)
    end
    
    context "with valid auth data" do
      
      before(:each) do
        @valid_auth = {
            "provider"=>"facebook",
            "appid"=>"196297497094752",
      			"app_secret" => "f2b1ddb79af75dbd498752f37fddc013", 
      			"uid"=>"12345", 
            "user_info"=> {
      					"image"=>"http://www.carniola.org/theglory/images/McHammer.gif", 
      					"email"=>"test@xxxx.com", 
      					"first_name"=>"Test", 
      					"last_name"=>"User", 
      					"name"=>"Test User"
      				}
        }
      end
      
      it "should create a user with the correct data" do
        user = User.create_with_omniauth(@valid_auth)
        user.provider.should == @valid_auth["provider"]  
        user.uid.should == @valid_auth["uid"]  
        user.name.should == @valid_auth["user_info"]["name"]  
  			user.image.should == @valid_auth["user_info"]["image"]
  			user.email.should == @valid_auth["user_info"]["email"]
      end
    end
    
    context "with invalid auth data" do
      before(:each) do
        @invalid_auth = {}
      end
      
      it "should throw an active record error" do
        expect {
          user = User.create_with_omniauth(@invalid_auth)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
      
    end
    
  end
  
	context "Methods" do
	  describe "it should show its name when called with to_s" do
			user = Factory.build(:user)
			user.to_s.should == user.name
		end  
	end
  
end
