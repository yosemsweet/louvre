require 'spec_helper'

describe "canvae/_header.html.haml" do
	before(:each) do
	  @canvas = Factory.create(:canvas)
		view.stubs(:current_user).returns(nil)
		view.controller.stubs(:current_user).returns(nil)
	end


	context "#canvas_header" do
		it "should exist" do
			render :partial => 'header', :object => @canvas, :as => :canvas
			rendered.should have_selector('#canvas_header')
		end

		context "canvas name" do
			
			it "should display the canvas name" do
				render :partial => 'header', :object => @canvas, :as => :canvas
				rendered.should have_selector('#canvas_header #canvas_name_text')
			end
	
			context "logged in" do
				
				before(:each) do
					@user = Factory.create(:user)
					view.stubs(:current_user).returns(@user)
					view.controller.stubs(:current_user).returns(@user)
				end
				
				context "as a canvas owner" do
					
					before(:each) do
						@user.set_canvas_role(@canvas, :owner)
					end
		
					it "should have a canvas edit form" do
						render :partial => 'header', :object => @canvas, :as => :canvas
						rendered.should have_selector("#canvas_header #edit_canvas_#{@canvas.id}")
					end
					
				end
				
			end
			
		end
		
	end
end