require "spec_helper"

describe "Pages Requests" do
  
  before(:each) do
    @user = Factory.create(:user)
    # Stub the current_user method so it appears like a user is logged in.
    PagesController.any_instance.stubs(:current_user).returns(@user)
    @canvas = Factory.create(:canvas) 
    @page = Factory.create(:page, :canvas => @canvas)
  end
    
  describe "GET /canvae/:canvas_id/pages/new" do    
    
    it "should return 403 for a user" do
      get new_canvas_page_path(@canvas)
      response.status.should == 403
    end
    
    it "should return 200 for a member" do
      @user.set_canvas_role(@canvas, :member)
      get new_canvas_page_path(@canvas)
      response.status.should == 200
    end
    
  end
  
  describe "POST /canvae/:canvas_id/pages" do    
    
    it "should return 403 for a user" do
      post canvas_pages_path(@canvas)
      response.status.should == 403
    end
    
    it "should return 200 for a member" do
      @user.set_canvas_role(@canvas, :member)
      post canvas_pages_path(@canvas)
      response.status.should == 200
    end
    
  end  
  
  describe "PUT /canvae/:canvas_id/pages/:page_id" do
    
    it "should give a 403 for a user" do
      put canvas_page_path(@canvas, @page)
      response.status.should == 403
    end
    
  end      
  
end