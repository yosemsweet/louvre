require 'spec_helper'

describe CanvaeController do

	describe "GET new" do
		it "should require authentication" do
			should_require_authentication do
				 get :new
			end
		end
		context "logged in" do
			before (:each) do
				@user = Factory.build(:user)
				controller.stubs(:current_user).returns(@user)
		  end
		
			it "should create a new canvas" do
				@canvas = Factory.build(:canvas, :name=>"stubbed canvas")
				Canvas.stubs(:new).returns(@canvas)
			
				get :new
				response.should return_status(302).with_location(canvas_path(@canvas))
			end
		end
	end

	describe "GET index" do
		it "should not require authentication" do
			should_not_require_authentication do
				 get :index
			end
		end
	end

	describe "POST create" do
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.build(:canvas)
				post :create, 
					:canvas => {
						:name => canvas.name, 
						:image => canvas.image,
						:open => canvas.open
					}
			end
		end
		
		it "should not require authorization to :create" do 
			canvas = Factory.build(:canvas)
			should_not_require_authorization_to(:action => :create, :object => canvas, :not_authorized_status => 302) do
				post :create, 
					:canvas => {
						:name => canvas.name, 
						:image => canvas.image,
						:open => canvas.open
					}
			end
		end
	
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
							:image => canvas.image,
							:open => canvas.open
						}

	        assigns(:canvas).name.should == canvas.name 
					assigns(:canvas).creator.should == @user
	      end
     
	      it "redirects to canvas" do
	        results = post :create, 
	          :canvas => {
								:name => canvas.name, 
								:image => canvas.image,
								:open => canvas.open
							}
					response.should return_status(302).with_location("canvae/#{assigns(:canvas).id}")
	      end
	    end
		end
		
	end
	
	describe "Put update" do
	
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.build(:canvas)
				post :create, 
					:canvas => {
						:name => canvas.name, 
						:image => canvas.image,
						:open => canvas.open
					}
			end
		end
		
		it "should require authorization to :update" do 
			canvas = Factory.create(:canvas)
			should_require_authorization_to(:action => :update, :object => canvas) do
				put :update, :id => canvas.id, :canvas => {:name => "test"}
			end
		end
	
		context "logged in with permissions" do
			
			let(:canvas) { Factory.create(:canvas) }
			
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
							:image => canvas.image,
							:open => canvas.open
						}

	        assigns(:canvas).name.should == canvas.name  + "foo"
					assigns(:canvas).creator.should == canvas.creator
	      end
    
	      it "redirects to canvas page" do
	        results = put :update, 
						:id => canvas.id,
	          :canvas => {
								:name => canvas.name, 
								:image => canvas.image,
								:open => canvas.open
							}
						
	        response.location.should include("canvae/#{assigns(:canvas).id}")
	      end
	    end

		end
	end
	
	describe "DELETE destroy" do
	
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.create(:canvas)
				delete :destroy, :id => canvas.id
			end
		end
		
		it "should require authorization to :delete" do
			canvas = Factory.create(:canvas)
			#don't actually destroy the canvas, we just want to ensure we call destroy on it.
			canvas.stubs(:destroy).returns(canvas)
			Canvas.stubs(:find).returns(canvas)
			should_require_authorization_to(:action => :delete, :object => canvas) do
				delete :destroy, :id => canvas.id
			end
		end
	
		context "logged in with permissions" do
			let(:canvas) { Factory.create(:canvas) }
			
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
	end
	
	describe "GET banned" do
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.create(:canvas)
				get :banned, :id => canvas.id
			end
		end
		
		it "should require authorization to :update" do 
			canvas = Factory.create(:canvas)
			should_require_authorization_to(:action => :update, :object => canvas) do
				get :banned, :id => canvas.id
			end
		end
		
		context "logged in with permissions" do
			let(:canvas) { Factory.create(:canvas) }
		
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
	end
	
	describe "POST banned_create" do
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.create(:canvas)
				post :banned_create,
					:id => canvas.id,
					:user_id => Factory.create(:user)
			end
		end
		
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
	end
	
	describe "DELETE banned_destroy" do
		before(:each) do
			@canvas = Factory.create(:canvas)
		end

		it "should require authentication" do
			should_require_authentication do
				banned = Factory.create(:user, :name => "banned")
				banned.set_canvas_role(@canvas, :banned)
				delete :banned_destroy, 
					:id => @canvas.id,
					:user_id => banned.id
			end
		end
		
		it "should require authorization to :update" do
			should_require_authorization_to(:action => :update, :object => @canvas) do
				banned = Factory.create(:user, :name => "banned")
				banned.set_canvas_role(@canvas, :banned)
				delete :banned_destroy, 
					:id => @canvas.id,
					:user_id => banned.id
			end
		end
	
			context "logged in with permissions" do
			let(:canvas) { Factory.create(:canvas) }
			
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
	        results.status.should == 200
	      end
	    end
	
			describe "with invalid params" do
	      it "should return a bad request if user doesn't exist" do
					results = delete :banned_destroy,
						:id => canvas.id,
						:user_id => User.last.id + 1
					results.status.should == 400
	      end
	    end
		end
	end
	
	describe "GET members" do
		it "should require authentication" do
			should_require_authentication do
				canvas = Factory.create(:canvas)
				get :banned, :id => canvas.id
			end
		end

		it "should require authorization to :update" do 
			canvas = Factory.create(:canvas)
			should_require_authorization_to(:action => :update, :object => canvas) do
				get :banned, :id => canvas.id
			end
		end
		context "logged in with permissions" do
			let(:canvas) { Factory.create(:canvas) }

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
	        results.status.should == 200
	      end
	    end
		end
	end
	
	
	context "put update" do
		
		describe "updating a canvas created by someone else" do
			before :each do
				@creator = Factory.create(:user)
				@canvas = Factory.create(:canvas, :creator => @creator, :editor => @creator)
				
		    @user = Factory.create(:user)
				@user.set_canvas_role(@canvas,:owner)
				@creator.set_canvas_role(@canvas,:owner)
				
		   	CanvaeController.any_instance.stubs(:current_user).returns(@user)
				
	      @attr = { :name => "New Name" }

	      put :update, :id => @canvas, :canvas => @attr
	
	      @canvas.reload
			end
			
			it "should update the canvas editor" do
				@canvas.editor.should == @user
			end
			
			it "should not update canvas creator" do
				@canvas.creator.should == @creator
			end
			
			it "creator and editor should be different people" do
				@canvas.creator.should_not == @canvas.editor
			end
			
		end
		
	end
	
	
	
end