require 'spec_helper'

describe "Users Requests" do
  

	context "logged in as an admin" do
    before(:each) do
			user = Factory.create(:user, :admin => true)  
		  UsersController.any_instance.stubs(:current_user).returns(user)
		end
	
		describe "GET /users" do		
			it "should return successfully" do
				get users_path
				response.status.should == 200
			end
		end
		
		describe "PUT /users/:id" do		
			before(:each) do
				@user = Factory.create(:user)
			end
			
			it "should change the user's attributes" do
				target_name = @user.name + " Foo"
				put "/users/#{@user.id}", :user => {:name => target_name}
				response.status.should == 200
				@user.reload.name.should == target_name
			end
			
			context "changing admin status" do
				it "should change the user's attributes" do
					put "/users/#{@user.id}", :user => {:admin => true}
					response.status.should == 200
					@user.reload.admin.should be_true
				end
			end
			
		end
	end
end