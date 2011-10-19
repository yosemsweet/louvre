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
		
					it "should have a canvas edit link" do
						render :partial => 'header', :object => @canvas, :as => :canvas
						rendered.should have_selector("#canvas_header a[href='#{edit_canvas_path(@canvas)}']")
					end
					
					context "links to canvas management tools" do

					  it "has a link to applicants page" do
							render :partial => 'header', :object => @canvas, :as => :canvas
					    rendered.should have_link("Applicants")
					  end

					  it "has a link to members page" do
							render :partial => 'header', :object => @canvas, :as => :canvas
					    rendered.should have_link("Members")
					  end 
					end
					
				end
				
				context "as a canvas member" do
						before(:each) do
							@user.set_canvas_role(@canvas, :member)
						end

						it "should not have a canvas edit link" do
							render :partial => 'header', :object => @canvas, :as => :canvas
							rendered.should_not have_selector("#canvas_header a[href='#{edit_canvas_path(@canvas)}']")
						end

						context "doesn't link to canvas management tools" do

						  it "has a link to applicants page" do
								render :partial => 'header', :object => @canvas, :as => :canvas
						    rendered.should_not have_link("Applicants")
						  end

						  it "doesn't have a link to members page" do
								render :partial => 'header', :object => @canvas, :as => :canvas
						    rendered.should_not have_link("Members")
						  end 
						end
				end
				
			end
			
		end
		
		context "canvas join" do
			context "it should call join_link_for" do
				before(:each) do
					view.stubs(:join_link_for).returns("Join Link For helper")
					view.controller.stubs(:join_link_for).returns("Join Link For helper")
				end
				
				it "should have a join link" do
					render :partial => 'header', :object => @canvas, :as => :canvas
					rendered.should have_content("Join Link For helper")
				end
			end
		end
		
	end
end