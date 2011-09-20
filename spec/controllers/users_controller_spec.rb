require 'spec_helper'

describe UsersController do

	describe "GET index" do
		it "should require authentication" do
			should_require_authentication do
				 get :index
			end
		end
	
		it "should require authorization to :make_admin" do
			should_require_authorization_to(:action => :make_admin, :object => User) do
				get :index
			end
		end
		
		describe "logged in with authorization" do
			before(:each) do
				@user = Factory.create(:user, :admin => true)
		    controller.stubs(:current_user).returns(@user)
			end
			
			it "should assign User.all to @users" do
				get :index
				assigns(:users).should == User.all
			end
		end
	end
end


