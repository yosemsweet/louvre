require "spec_helper"

describe "Canvas Requests" do
  
  before(:each) do
     @user = Factory.create(:user)
     # Stub the current_user method so it appears like a user is logged in.
     CanvaeController.any_instance.stubs(:current_user).returns(@user)
     @canvas = Factory.create(:canvas)
  end
  
  describe "GET /canvae/:canvas_id/applicants" do
    
    it "should work for owners" do
      @user.set_canvas_role(@canvas, :owner)
      get applicants_canvas_path(@canvas)
      response.status.should == 200
    end
    
    it "should not work for non owners" do
      get applicants_canvas_path(@canvas)
      response.status.should == 403
    end
    
  end
  
  describe "POST /canvae/:canvas_id/members" do
    
    context "for an open canvas" do
      
      before(:each) do
        Canvas.any_instance.stubs(:open?).returns true
        @applicant = Factory.create(:user)
        CanvasApplicant.create(:canvas_id => @canvas.id, :user_id => @applicant.id)
      end
      
      it "should set the given user as a canvas member and remove them as an applicant for this canvas" do
        @user.set_canvas_role(@canvas, :owner)
        @canvas.applicants.exists?(:id => @applicant.id).should == true
        post members_canvas_path(@canvas, :user_id => @applicant.id)
        response.status.should == 200
        @applicant.canvas_role?(@canvas, :member).should == true
        @canvas.applicants.exists?(:id => @applicant.id).should == false
      end

    end

    context "for a closed canvas" do
      before(:each) do
        Canvas.any_instance.stubs(:open?).returns false
        @applicant = Factory.create(:user)
      end
        
      it "it should work and return 200" do
        @user.set_canvas_role(@canvas, :owner)
        post members_canvas_path(@canvas, :user_id => @applicant.id)
        response.status.should == 200
      end
      
      it "should not work for non owners" do
        post members_canvas_path(@canvas, :user_id => @applicant.id)
        response.status.should == 403
      end
    end

  end

  describe "DELETE /canvae/:canvas_id/applicants/:user_id" do
    it "should remove the applicant from the applicant list if you are an owner" do
      @user.set_canvas_role(@canvas, :owner)
      Canvas.any_instance.stubs(:open?).returns false
      @applicant = Factory.create(:user)
      CanvasApplicant.create(:canvas_id => @canvas.id, :user_id => @applicant.id)
      @canvas.applicants.exists?(:id => @applicant.id).should == true
      delete applicants_delete_path(@canvas, @applicant)
      response.status.should == 200
      @canvas.applicants.exists?(:id => @applicant.id).should == false
    end
    
     it "should fail if you are not an owner" do
        Canvas.any_instance.stubs(:open?).returns false
        @applicant = Factory.create(:user)
        CanvasApplicant.create(:canvas_id => @canvas.id, :user_id => @applicant.id)
        @canvas.applicants.exists?(:id => @applicant.id).should == true
        delete applicants_delete_path(@canvas, @applicant)
        response.status.should == 403
      end
  end
  
end