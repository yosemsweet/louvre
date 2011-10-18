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
	
	describe '#join_link_for' do
		before(:each) do
			@canvas = Factory.create(:canvas)
			@user = Factory.create(:user)
		end
		
		it "should respond to join_link_for" do
			helper.should respond_to(:join_link_for)
		end
		
		it "should accept a canvas and an optional user" do
			helper.should respond_to(:join_link_for).with(2).arguments
		end
		
		it "should return an html safe string" do
			helper.join_link_for(@canvas, @user).should be_html_safe
		end
		
		context "as not logged in" do
			before(:each) do
				@user = nil
				helper.stubs(:current_user).returns(@user)
			end
			
			context "open canvas" do
				before(:each) do
					@canvas.open = true
				end
				
				it "should return a join button" do
					Capybara.string(helper.join_link_for(@canvas, @user)).should have_selector("#join.button")
				end
			end
			
			context "closed canvas" do
				before(:each) do
					@canvas.open = false
				end

				it "should return an apply button" do
					Capybara.string(helper.join_link_for(@canvas, @user)).should have_selector("#apply.button")
				end
			end
		end
		
		context "as logged in" do
			before(:each) do
				@user = Factory.create(:user)
				helper.stubs(:current_user).returns(@user)
			end
			
			context "open canvas" do
				before(:each) do
					@canvas.open = true
				end
				
				it "should return a join button" do
					Capybara.string(helper.join_link_for(@canvas, @user)).should have_selector("#join.button")
				end
			end
			
			context "closed canvas" do
				before(:each) do
					@canvas.open = false
				end

				it "should return an apply button" do
					Capybara.string(helper.join_link_for(@canvas, @user)).should have_selector("#apply.button")
				end
			end
		end
		
		context "as a member" do
			before(:each) do
				@user = Factory.create(:user)
				@user.set_canvas_role(@canvas, :member)
				helper.stubs(:current_user).returns(@user)
			end
			
			context "open canvas" do
				before(:each) do
					@canvas.open = true
				end
				
				it "should return an empty string" do
					helper.join_link_for(@canvas, @user).should == ""
				end
			end
			
			context "closed canvas" do
				before(:each) do
					@canvas.open = false
				end

				it "should return an empty string" do
					helper.join_link_for(@canvas, @user).should == ""
				end
			end
		end
	end
end