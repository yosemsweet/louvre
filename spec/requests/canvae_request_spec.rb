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
		
    describe "GET /canvae/:canvas_id/join" do
      
      it "should allow user to join canvas" do
        get "/canvae/#{@canvas.id}/join"
        @user.canvas_role(@canvas).should == :member
        response.status.should == 302
				response.should redirect_to canvas_path(@canvas)
      end
      
    end
    
  end
  
  context "logged out user joining an open canvas" do
    
    before(:each) do
		  CanvaeController.any_instance.stubs(:current_user).returns(nil)
		  Canvas.any_instance.stubs(:open?).returns true
		end
		
    describe "GET /canvae/:canvas_id/join" do
      
      it "should redirect to login" do
        get "/canvae/#{@canvas.id}/join"
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
   
    describe "GET /canvae/:canvas_id/join" do
     
      it "should return forbidden" do
        get "/canvae/#{@canvas.id}/join"
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
							response.body.should have_selector("#banned-list .member-item[data-user_id='#{user_role.user.id}']")
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
						response.body.should have_selector("#member-list .member-item[data-user_id='#{user_role.user.id}']")
						end
						
					end
					
				end
				
				describe "GET /canvae/:canvas_id/applicants" do

          it "should work for owners" do
            get applicants_canvas_path(@canvas)
            response.status.should == 200
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
				
				describe "GET /canvae/:canvas_id/applicants" do
  			
  				it "should not work for non owners" do
            get applicants_canvas_path(@canvas)
            response.status.should == 403
          end
          
			  end
			  
			  describe "DELETE /canvae/:canvas_id/applicants/:user_id" do
			    
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

	  describe "GET /canvae/:canvas_id/join" do

	    context "for a closed canvas" do
	      before(:each) do
	        Canvas.any_instance.stubs(:open?).returns false
	        @applicant = Factory.create(:user)
	      end

	      it "it should work and return 200" do
	        @user.set_canvas_role(@canvas, :owner)
	        get members_canvas_path(@canvas, :user_id => @applicant.id)
	        response.status.should == 200
	      end
	
				# it "should make an applicant a member" do
				# 	        @user.set_canvas_role(@canvas, :owner)
				# 	        get members_canvas_path(@canvas, :user_id => @applicant.id)
				# 	        @applicant.canvas_role(@canvas).should == :member
				# end

	      it "should not work for non owners" do
	        get members_canvas_path(@canvas, :user_id => @applicant.id)
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
end