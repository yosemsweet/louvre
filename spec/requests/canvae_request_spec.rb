require "spec_helper"

describe "Canvae Requests" do
  
  before(:each) do
    @user = Factory.create(:user)  
    @canvas = Factory.create(:canvas) 
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
							response.body.should have_selector("#ban-list *[data-user='#{user_role.user.id}']")
						end
						
					end
				end
				
				describe "POST /canvae/:canvas_id/banned/" do
					before(:each) do
						@owner = Factory.create(:user).set_canvas_role(@canvas, :owner).user					
						@member = Factory.create(:user).set_canvas_role(@canvas, :member).user
						@banned = Factory.create(:user).set_canvas_role(@canvas, :banned).user
					end
					
					it "should should add banned roler to user for canvas" do
						post banned_canvas_path(@canvas), :user_id => @member.id
						@member.canvas_role(@canvas).should == :banned
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