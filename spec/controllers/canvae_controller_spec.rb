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
end