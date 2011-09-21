require 'spec_helper'

describe "users/index.html.haml" do
	before(:each) do
		@users = User.all
	end
  
	context "logged in with permissions" do
	  before do
			user = Factory.create(:user, :admin => true)
	    controller.singleton_class.class_eval do
	      private
	        def current_user
	           user
	        end
	        helper_method :current_user
	    end
	  end

		context "#user-list" do
			it "exists" do
				render
				rendered.should have_selector('#user-list')
			end
			
			context "with users" do
			  before(:each) do
					5.times do
				    Factory.create(:user)
					end
					@users = User.all
			  end
				
				it "contains all users each identified with user_id" do
					render
					@users.each do |u|
						rendered.should have_selector("#user-list #user_#{u.id}")
					end
				end
			end
		end
	end
end