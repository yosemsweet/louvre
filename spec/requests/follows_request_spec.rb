require "spec_helper"

describe "Follows Requests" do
  
  before(:each) do
    @canvas = Factory.create(:canvas)
		@page = Factory.create(:page)
    @user = Factory.create(:user)
    # Stub the current_user method so it appears like a user is logged in.
    FollowsController.any_instance.stubs(:current_user).returns(@user)
  end
  
  describe "POST /follows" do
    
		context "user follows a canvas" do
	    before(:each) do
	      post "/follows/", {:followable_type => 'canvas', :followable_id => @canvas.id}
	    end
    
	    it "should work" do
	      response.status.should == 200
	    end
      
	    it "should make the current user follow the canvas" do
	      @user.following?(@canvas).should == true
	    end
		end
		
		context "user follows a page" do
	    before(:each) do
	      post "/follows/", {:followable_type => 'page', :followable_id => @page.id}
	    end
    
	    it "should work" do
	      response.status.should == 200
	    end
      
	    it "should make the current user follow the page" do
	      @user.following?(@page).should == true
	    end
		end
		
		context "user follows a thing that should not be" do
			
			it "should fail if the followable_id doesn't exist" do
				post "/follows/", {:followable_type => 'page', :followable_id => 999999999999999}
				response.status.should == 400
			end
			
			it "should fail if the object type doesn't exist" do
				post "/follows/", {:followable_type => 'george', :followable_id => @page.id}
				response.status.should == 400
			end
			
		end
    
  end
  
  describe "DELETE /follows" do
    
    context "when the current user stops following a canvas" do
    
      before(:each) do
        @user.follow(@canvas)
        delete "/follows/", {:followable_type => 'canvas', :followable_id => @canvas.id}
      end
    
      it "should work" do
        response.status.should == 200
      end
    
      it "should make the current user no longer follow the canvas" do
        @user.reload.following?(@canvas).should == false
      end
      
    end
    
  end
    
      
end