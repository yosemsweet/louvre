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
				
				it "contains all users each identified with data-user_id and an item class" do
					render
					@users.each do |u|
						rendered.should have_selector("#user-list .item[data-user_id='#{u.id}']")
					end
				end

				
				context "with admins" do
					before(:each) do
						Factory.create(:user, :admin => true)
						@users = User.all
					end
					
					it "should add an admin class to each admin" do
						render
						@users.each do |u|
							rendered.should have_selector("#user-list .item.admin[data-user_id='#{u.id}']") if u.admin?
						end
					end
				end
			end
		end
	end
end