require "spec_helper"

describe "Canvas Follows Requests" do
  
  before(:each) do
    @canvas = Factory.create(:canvas)
    @user = Factory.create(:user)
    # Stub the current_user method so it appears like a user is logged in.
    CanvasFollowsController.any_instance.stubs(:current_user).returns(@user)
  end
  
  describe "POST /canvae/[canvas_id]/canvas_follow" do
    
    before(:each) do
      post "/canvae/#{@canvas.id}/canvas_follow"
    end
    
    it "should work" do
      response.status.should == 200
    end
      
    it "should make the current user follow the canvas" do
      @user.reload.followed_canvae.should include(@canvas)
    end
    
  end
  
  describe "DELETE /canvae/[canvas_id]/canvas_follow" do
    
    context "when the current user is following the canvas" do
    
      before(:each) do
        @user.followed_canvae << @canvas
        @user.save
        @user.reload.followed_canvae.should include(@canvas)
        delete "/canvae/#{@canvas.id}/canvas_follow"
      end
    
      it "should work" do
        response.status.should == 200
      end
    
      it "should make the current user no longer follow the canvas" do
        @user.reload.followed_canvae.should_not include(@canvas)
      end
      
    end
    
  end
    
      
end