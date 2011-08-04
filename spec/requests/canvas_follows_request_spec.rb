require "spec_helper"

describe "Canvas Follows Requests" do
  
  describe "POST /canvae/[canvas_id]/canvas_follow" do
    
    before(:each) do

    end
    
    it "should work" do
      canvas = Factory.create(:canvas)
      user = Factory.create(:user)
      CanvasFollowsController.any_instance.stubs(:current_user).returns(user)
      post "/canvae/#{canvas.id}/canvas_follow"
      response.status.should == 200
    end
      
    # it "should make the current user follow the canvas" do
    #   canvas = Factory.create(:canvas)
    #   post "/canvae/#{canvas.id}/canvas_follow"
    # end
    
  end
    
      
end