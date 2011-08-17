require 'spec_helper'

describe 'CanvaeHelper' do
	describe '#bookmarklet' do
		before(:each) do
			@canvas = Factory.create(:canvas)
			@user = Factory.create(:user)
		end

		it "should respond to bookmarklet" do
			helper.should respond_to(:bookmarklet)
		end
		
		it "should accept 2 parameters, a canvas and a user and return javascript" do
			helper.should respond_to(:bookmarklet).with(2).arguments
			helper.bookmarklet(@canvas, @user).should match("^javascript:")
		end

		it "should set the canvas id to the passed in canvas' id" do
			helper.bookmarklet(@canvas, @user).should include("canvas_id=#{@canvas.id}")
		end
				
		it "should set the user id to the passed in user's id" do
			helper.bookmarklet(@canvas, @user).should include("user_id=#{@user.id}")
		end
		
		it "should have no spaces" do
			helper.bookmarklet(@canvas, @user).should_not match("\s")
		end
		
		it "should be html_safe" do
			helper.bookmarklet(@canvas, @user).should == raw(helper.bookmarklet(@canvas, @user))
		end
	end

	
end