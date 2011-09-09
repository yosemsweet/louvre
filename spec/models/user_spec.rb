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
  			user.emails.map(&:address).include?(@valid_auth["user_info"]["email"]).should == true
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
  
  describe "#primary_email" do
    
    it "should return the primary email" do
      user = Factory.create(:user)
      email = Factory.create(:email, :user_id => nil, :primary => 1)
      user.emails << email
      user.primary_email.id.should == email.id 
    end
    
  end
  
  describe "#primary_email=" do
    
    it "should set primary email to given email" do
      user = Factory.create(:user)
      email = Factory.create(:email, :user_id => user.id, :primary => nil)
      user.primary_email=email
      user.primary_email.id.should == email.id
    end
    
    it "should unset other emails to non-primary" do
      user = Factory.create(:user)
      email = Factory.create(:email, :user_id => user.id, :primary => 1)
      email2 = Factory.create(:email, :user_id => user.id, :primary => 0) 
      user.primary_email = email2
      email.reload.primary.should == 0
    end
       
  end  
  
  describe "#role?" do
    before(:each) do
      Factory.create(:role, {:name => "owner", :xp => 800})
      Factory.create(:role, {:name => "member", :xp => 200})
      Factory.create(:role, {:name => "user", :xp => 100})
    end
    
    it "should exist" do
      Factory.create(:user).should respond_to(:role?).with(2).arguments
    end
    
    it "should return false if they don't have a role" do
      Factory.create(:user).role?(Factory.create(:canvas),:member).should be_false
    end
    
    context "an owner of canvas" do

      it "should return true if asked if they are the owner" do
        user = Factory.create(:user)
        canvas = Factory.create(:canvas)
        user.set_role(canvas,:owner)
        user.role?(canvas, :owner).should be_true
      end
      
      it "should return true if asked if they are a member" do
        user = Factory.create(:user)
        canvas = Factory.create(:canvas)
        user.set_role(canvas,:owner)
        user.role?(canvas, :member).should be_true
      end
      
    end
  end
  
  describe "#role" do
    before(:each) do
      Factory.create(:role, {:name => "member", :xp => 200})
      Factory.create(:role, {:name => "visitor", :xp => 0})
    end
    
    it "should exist" do
      Factory.create(:user).should respond_to(:role).with(1).argument
    end
    
    it "should return :visitor if they don't have a role" do
      Factory.create(:user).role(Factory.create(:canvas)).should == Role.where(:name => "visitor").first
    end
  end
  
  describe "#set_role" do
    it "should exist" do
      Factory.create(:user).should respond_to(:set_role).with(2).arguments
    end
    
    before(:each) do
      Factory.create(:role, {:name => "member", :xp => 200})
      Factory.create(:role, {:name => "admin", :xp => 900})
    end
    
    it "should create a role for a user that does not have a role for this canvas" do
      user = Factory.create(:user)
      canvas = Factory.create(:canvas)
      user.set_role(canvas,:member)
      canvas_role = user.canvas_user_roles.where(:canvas_id => canvas.id)
      canvas_role.length.should == 1
      canvas_role.first.role.name.should == 'member'
    end

    it "should update a role for a user that already has a role for this canvas" do
      user = Factory.create(:user)
      canvas = Factory.create(:canvas)
      user.set_role(canvas,:admin)
      user.set_role(canvas,:member)
      canvas_role = user.canvas_user_roles.where(:canvas_id => canvas.id)
      canvas_role.length.should == 1
      canvas_role.first.role.name.should == 'member'
    end

  end
  
end


