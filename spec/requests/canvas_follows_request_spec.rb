require "spec_helper"

describe "Canvas Follows Requests" do
  
  describe "POST /canvae/[canvas_id]/canvas_follow" do
    
    before(:each) do
      @canvas = Factory.create(:canvas)
      @user = Factory.create(:user)
      # Stub the current_user method so it appears like a user is logged in.
      CanvasFollowsController.any_instance.stubs(:current_user).returns(@user)
      post "/canvae/#{@canvas.id}/canvas_follow"
    end
    
    it "should work" do
      response.status.should == 200
    end
      
    it "should make the current user follow the canvas" do
      @user.followed_canvae.should include(@canvas)
    end
    
  end
    
      
end