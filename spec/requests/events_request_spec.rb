require "spec_helper"

describe "Pages Requests" do
  
  before(:each) do
    @user = Factory.create(:user)
    @canvas = Factory.create(:canvas)
  end

  describe "GET /event_count" do    

     it "should return 302 for a non logged in person" do
       get event_count_path
       response.status.should == 302
     end

     it "should return 200 for a logged in person" do
       # Stub the current_user method so it appears like a user is logged in.
       EventsController.any_instance.stubs(:current_user).returns(@user)
       @user.set_canvas_role(@canvas, :member)
       get event_count_path
       response.status.should == 200
     end

     it "should return 0 as the event count for a logged in person with no events" do
       # Stub the current_user method so it appears like a user is logged in.
        EventsController.any_instance.stubs(:current_user).returns(@user)
        @user.set_canvas_role(@canvas, :member)
        get event_count_path
        response.body.should == "0"
      end

   end
   
   describe "GET /events" do    

      it "should return 302 for a non logged in person" do
        get events_path
        response.status.should == 302
      end

      it "should return 200 for a logged in person" do
        EventsController.any_instance.stubs(:current_user).returns(@user)
        @user.set_canvas_role(@canvas, :member)
        get events_path
        response.status.should == 200
      end

    end

end