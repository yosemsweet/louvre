require 'spec_helper'

describe CanvaeController do

	describe "Post create" do
	
		context "logged in" do
		  before (:each) do
				@user = Factory.build(:user)
		    controller.stubs(:current_user).returns(@user)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.build(:canvas) }
     
	      it "assigns a newly created canvas as @canvas" do
					results = post :create, 
						:canvas => {
							:name => canvas.name, 
							:mission => canvas.mission, 
							:image => canvas.image,
							:open => canvas.open
						}

	        assigns(:canvas).name.should == canvas.name 
					assigns(:canvas).creator.should == @user
					assigns(:canvas).mission.should == canvas.mission
	      end
     
	      it "redirects to canvas" do
	        results = post :create, 
	          :canvas => {
								:name => canvas.name, 
								:mission => canvas.mission, 
								:image => canvas.image,
								:open => canvas.open
							}
							
	        response.location.should include("canvae/#{assigns(:canvas).id}")
	      end
	    end
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.build(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.build(:canvas) }
     
	      it "redirects to login page" do
					results = post :create, 
						:canvas => {
							:name => canvas.name, 
							:mission => canvas.mission, 
							:image => canvas.image,
							:open => canvas.open
						}

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "Put update" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
				end
				
			 	describe "with valid params" do
		      
		      it "updates the canvas" do
						results = put :update,
							:id => canvas.id, 
							:canvas => {
								:name => canvas.name + "foo", 
								:mission => canvas.mission, 
								:image => canvas.image,
								:open => canvas.open
							}

		        assigns(:canvas).name.should == canvas.name  + "foo"
						assigns(:canvas).creator.should == canvas.creator
						assigns(:canvas).mission.should == canvas.mission
		      end
     
		      it "redirects to canvas page" do
		        results = put :update, 
							:id => canvas.id,
		          :canvas => {
									:name => canvas.name, 
									:mission => canvas.mission, 
									:image => canvas.image,
									:open => canvas.open
								}
							
		        response.location.should include("canvae/#{assigns(:canvas).id}")
		      end
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					it "returns a 403 code" do
		        results = put :update, 
							:id => canvas.id,
		          	:canvas => {
									:name => canvas.name, 
									:mission => canvas.mission, 
									:image => canvas.image,
									:open => canvas.open
								}
						
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = put :update, 
						:id => canvas.id,
						:canvas => {
							:name => canvas.name, 
							:mission => canvas.mission, 
							:image => canvas.image,
							:open => canvas.open
						}

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "DELETE delete" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
				end
				
			 	describe "with valid params" do
		      
		      it "deletes the canvas" do
						results = delete :destroy, :id => canvas.id
						
						assigns(:canvas).should be_destroyed
		      end
     
		      it "redirects to homepage" do
		        results = delete :destroy, :id => canvas.id
							
		        response.location.should ==(root_url)
		      end
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					
	     	 it "returns a 403 code" do
		        results = delete :destroy, :id => canvas.id
						
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = delete :destroy, :id => canvas.id

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "GET banned" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
				end
				
			 	describe "with valid params" do
		      
		      it "returns the canvas" do
						results = get :banned,
							:id => canvas.id
							
		        assigns(:canvas) == canvas
		      end
     
		      it "returns a 200" do
		        results = get :banned, 
							:id => canvas.id
							
		        response.status.should == 200
		      end
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					it "returns a 403 code" do
		        results = get :banned, 
							:id => canvas.id
							
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = get :banned, 
						:id => canvas.id

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "POST banned_create" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
					@member = Factory.create(:user, :name => "member")
					@member.set_canvas_role(canvas, :member)
				end
				
			 	describe "with valid params" do
		      
		      it "give member a banned role for canvas" do
						results = post :banned_create,
							:id => canvas.id,
							:user_id => @member.id
							
						@member.canvas_role(canvas).should == :banned
		      end
     
		      it "returns a 200" do
		        results = post :banned_create, 
							:id => canvas.id,
							:user_id => @member.id
							
		        response.status.should == 200
		      end
		    end
		
				describe "with invalid params" do

		      it "should return a bad request if user doesn't exist" do
						results = post :banned_create,
							:id => canvas.id,
							:user_id => User.last.id + 1

							response.status.should == 400
		      end
		
		      it "should return a forbidden if user is canvas owner" do
						results = post :banned_create,
							:id => canvas.id,
							:user_id => @user.id

							response.status.should == 403
		      end

		      
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					it "returns a 403 code" do
		        results = post :banned_create, 
							:id => canvas.id,
							:user_id => @user.id
							
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = post :banned_create, 
						:id => canvas.id,
						:user_id => @user.id

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "DELETE banned_destroy" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
					@banned = Factory.create(:user, :name => "banned")
					@banned.set_canvas_role(canvas, :banned)
				end
				
			 	describe "with valid params" do
		      
		      it "give removes the banned role for canvas" do
						results = delete :banned_destroy,
							:id => canvas.id,
							:user_id => @banned.id
							
						@banned.canvas_role(canvas).should_not == :banned
		      end
     
		      it "returns a 200" do
		        results = delete :banned_destroy, 
							:id => canvas.id,
							:user_id => @banned.id
							
		        response.status.should == 200
		      end
		    end
		
				describe "with invalid params" do

		      it "should return a bad request if user doesn't exist" do
						results = delete :banned_destroy,
							:id => canvas.id,
							:user_id => User.last.id + 1

							response.status.should == 400
		      end
		
		      it "should return a forbidden if user is canvas owner" do
						results = delete :banned_destroy,
							:id => canvas.id,
							:user_id => @user.id

							response.status.should == 403
		      end

		      
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					it "returns a 403 code" do
		        results = delete :banned_destroy, 
							:id => canvas.id,
							:user_id => @user.id
							
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = delete :banned_destroy, 
						:id => canvas.id,
						:user_id => @user.id

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
	
	describe "GET members" do
	
		context "logged in" do
		
			let(:canvas) { Factory.create(:canvas) }
			
			context "with permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :owner)
				end
				
			 	describe "with valid params" do
		      
		      it "returns the canvas" do
						results = get :members,
							:id => canvas.id
							
		        assigns(:canvas) == canvas
		      end
     
		      it "returns a 200" do
		        results = get :members, 
							:id => canvas.id
							
		        response.status.should == 200
		      end
		    end
		
		
			end
			
			context "without permissions" do
				before(:each) do
					@user = Factory.create(:user)
			    controller.stubs(:current_user).returns(@user)
					@user.set_canvas_role(canvas, :member)
				end
				
				describe "with valid params" do    
					it "returns a 403 code" do
		        results = get :members, 
							:id => canvas.id
							
						results.status.should == 403
		      end
	    	end
			end
		
		end
		
		context "logged out" do
		  before (:each) do
				@user = Factory.create(:user)
		    controller.stubs(:current_user).returns(nil)
		   end
			
		 	describe "with valid params" do
	      let(:canvas) { Factory.create(:canvas) }
     
	      it "redirects to login page" do
					results = get :members, 
						:id => canvas.id

	        response.location.should include("auth/")
	      end
	    end
		end
		
	end
end