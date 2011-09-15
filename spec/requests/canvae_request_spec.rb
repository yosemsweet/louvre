require "spec_helper"

describe "Canvae Requests" do
  
  before(:each) do
    @user = Factory.create(:user)  
    @canvas = Factory.create(:canvas) 
  end

  context "logged in user joining an open canvas" do
    before(:each) do
		  CanvaeController.any_instance.stubs(:current_user).returns(@user)
		  Canvas.any_instance.stubs(:open?).returns true
		end
    describe "POST /canvae/:canvas_id/members" do
      it "should allow user to join canvas" do
        post "/canvae/#{@canvas.id}/members"
        @user.canvas_role(@canvas).should == :member
        response.status.should == 200
      end
    end
  end
  
  context "logged out user joining an open canvas" do
    before(:each) do
		  CanvaeController.any_instance.stubs(:current_user).returns(nil)
		  Canvas.any_instance.stubs(:open?).returns true
		end
    describe "POST /canvae/:canvas_id/members" do
      it "should redirect to login" do
        post "/canvae/#{@canvas.id}/members"
        response.location.should include("auth/")
        response.status.should == 302
      end
    end
  end

  context "trying to join a closed canvas" do
    before(:each) do
		  CanvaeController.any_instance.stubs(:current_user).returns(@user)	
		  Canvas.any_instance.stubs(:open?).returns false
		end
    describe "POST /canvae/:canvas_id/members" do
      it "should return forbidden" do
        post "/canvae/#{@canvas.id}/members"
        @user.canvas_role(@canvas).should_not == :member
        response.status.should == 403
      end
    end
  end
  
	context "community management requests" do
		context "logged in" do

			before(:each) do
		  	# Stub the current_user method so it appears like a user is logged in.
			  CanvaeController.any_instance.stubs(:current_user).returns(@user)	
			end

			context "with canvas owner role" do
				before(:each) do
					@user.set_canvas_role(@canvas, :owner)
				end
			
				describe "GET /canvae/:canvas_id/banned" do
					it "should return 200" do
						get banned_canvas_path(@canvas)
						response.status.should == 200
					end
				
					it "should list all banned members" do
						Factory.create(:user).set_canvas_role(@canvas, :banned)
						get banned_canvas_path(@canvas)
						@canvas.banned.should_not be_empty
						
						@canvas.banned.each do |user_role|
							response.body.should have_selector("#ban-list .user[data-user_id='#{user_role.user.id}']")
						end
						
					end
				end
				
				describe "POST /canvae/:canvas_id/banned/" do
					before(:each) do
						@owner = Factory.create(:user).set_canvas_role(@canvas, :owner).user					
						@member = Factory.create(:user).set_canvas_role(@canvas, :member).user
						@banned = Factory.create(:user).set_canvas_role(@canvas, :banned).user
					end
					
					it "should should add banned role to user for canvas" do
						post banned_canvas_path(@canvas), :user_id => @member.id
						@member.canvas_role(@canvas).should == :banned
					end
				end
				
				describe "DELETE /canvae/:canvas_id/banned/" do
					before(:each) do
						@owner = Factory.create(:user).set_canvas_role(@canvas, :owner).user					
						@member = Factory.create(:user).set_canvas_role(@canvas, :member).user
						@banned = Factory.create(:user).set_canvas_role(@canvas, :banned).user
					end
					
					it "should should user's role for canvas from :banned to :user" do
						delete banned_canvas_path(@canvas), :user_id => @banned.id
						@banned.canvas_role(@canvas).should == :user
					end
				end
				
				describe "GET /canvae/:canvas_id/members" do
					it "should return 200" do
						get members_canvas_path(@canvas)
						response.status.should == 200
					end
				
					it "should list all members" do
						Factory.create(:user).set_canvas_role(@canvas, :member)
						get members_canvas_path(@canvas)
						@canvas.members.should_not be_empty
						
						@canvas.members.each do |user_role|
							response.body.should have_selector("#member-list .user[data-user_id='#{user_role.user.id}']")
						end
						
					end
				end
				
				
				
			end
			
			context "without canvas owner role" do
				before(:each) do
					@user.set_canvas_role(@canvas, :member)
				end
			
				describe "GET /canvae/:canvas_id/banned" do
					it "should return 403" do
						get banned_canvas_path(@canvas)
						response.status.should == 403
					end
				end
			end
			
			context "logged out" do
				before(:each) do
			  	# Stub the current_user method so it appears like a user is logged in.
				  CanvaeController.any_instance.stubs(:current_user).returns(nil)	
				end
				
				describe "GET /canvae/:canvas_id/banned" do
					it "should redirect to login" do
						get banned_canvas_path(@canvas)
						response.status.should == 302
						response.location.should include('auth')
					end
				end
			end
			
		end
	end
	
end