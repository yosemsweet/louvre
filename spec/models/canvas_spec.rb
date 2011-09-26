require 'spec_helper'

describe Canvas do
	
	context "attributes" do
		let(:canvas) { Factory.build(:canvas) }
		
		it "should respond to name" do
			canvas.should respond_to(:name)
		end
				
		it "should respond to image" do
			canvas.should respond_to(:image)
		end
		
		it "should respond to open" do
			canvas.should respond_to(:open)
		end

		
	end
	
	context "#open?" do
		let(:canvas) { Factory.build(:canvas) }
		
		it "should exist" do
			canvas.should respond_to(:open?)
		end
		
		it "should return true if canvas.open is set to true" do
			canvas.open = true
			canvas.open?.should be_true
		end
		
		it "should return false if canvas.open is set to false" do
			canvas.open = true
			canvas.open?.should be_true
		end
	end
	
	context "#closed?" do
		let(:canvas) { Factory.build(:canvas) }
		
		it "should exist" do
			canvas.should respond_to(:closed?)
		end
		
		it "should return false if canvas.open is set to true" do
			canvas.open = true
			canvas.closed?.should be_false
		end
		
		it "should return true if canvas.open is set to false" do
			canvas.open = false
			canvas.closed?.should be_true
		end
	end
	
  context "Validations" do
		it "should be valid with valid parameters" do
			canvas = Factory.build(:canvas)
			canvas.should be_valid
		end
	
	  it "should save properly to the database" do
	    canvas = Factory.build(:canvas)
	    canvas.save!
	  end
	  
	  it "should be able to have widgets" do
	    Factory.build(:canvas).should respond_to(:widgets)
    end
	  
		context "attribute validations" do
			context "Name" do
				it "should be required" do
			  	canvas = Factory.build(:canvas, :name => "")
			    canvas.should_not be_valid
			  end
		
				it "should be unique" do
					canvas = Factory.create(:canvas, :name =>"foo")
					canvas.should be_valid
					canvas_duplicate_name = Factory.build(:canvas, :name =>"foo")
					canvas_duplicate_name.should_not be_valid
				end
			end
			
			context "Open" do
				it "should default to true" do
					canvas = Canvas.new
					canvas.open?.should be_true
				end
			end
			
			context "Creator" do
				it "should have a creator" do
					canvas = Factory.build(:canvas)
					canvas.should respond_to(:creator)
				end
				
				it "should be required" do
					canvas = Factory.build(:canvas, :creator => nil)
					canvas.should_not be_valid
				end
			end
			
			context "Pages" do
				it "should have Pages" do
					canvas = Factory.build(:canvas)
					canvas.should respond_to(:pages)
				end
			end
			
		end
		
		context "facebook integration" do
			context 'opengraph meta data' do
				let(:canvas) { FactoryGirl.build(:canvas) }

				it "should respond to opengraph_data" do
					canvas.should respond_to(:opengraph_data)
				end

				it "should return cause as opengraph type" do
					canvas.opengraph_type.should == 'cause'
				end

				it "should return page title as opengraph title" do
					canvas.opengraph_title.should == canvas.name
				end

				it "should return canvas image as opengraph image" do
					canvas.opengraph_image.should == canvas.image
				end
			end
		end
		
		context "#recently_updated" do
			
			before :each do
				@canvas12 = Factory.create(:canvas)
				11.times do |i| 
					Factory.create(:canvas)
				end
				@canvas12.name = 'My awesome canvas1234'
				@canvas12.save
			end
				
			it "should return the n most recently updated canvases" do
				Canvas.recently_updated(10).length.should == 10
			end
			
			it "should return a list of canvases" do
				Canvas.recently_updated(10).first.class.name.should == 'Canvas'
			end
			
			it "should have the most recent edited canvas first" do
				Canvas.recently_updated(10).first.id.should == @canvas12.id
			end
					
		end
	
	end
	
	context "community management" do
		let(:canvas) { Factory.create(:canvas) }
		
		before(:each) do
			Factory.create(:user).set_canvas_role(canvas, :owner)
			Factory.create(:user).set_canvas_role(canvas, :member)
			Factory.create(:user).set_canvas_role(canvas, :banned)
		end
		
		context "#user_roles" do
			it "should exist" do
				canvas.should respond_to(:user_roles)
			end
			
			it "should include all users who have an explicit role on this canvas that aren't banned" do
				CanvasUserRole.not_banned.where(:canvas_id => canvas.id).each do |canvas_user_role|
					canvas.user_roles.should include(canvas_user_role)
				end
			end			
		end
		
		context "#members" do
			it "should exist" do
				canvas.should respond_to(:members)
			end
			
			it "should return all users with a member role" do
				CanvasUserRole.members.where(:canvas_id => canvas.id).each do |canvas_user_role|
					canvas.members.should include(canvas_user_role)
				end
			end
		end
		
		context "#banned" do
			it "should exist" do
				canvas.should respond_to(:banned)
			end
			
			it "should return all banned users" do
				CanvasUserRole.banned.where(:canvas_id => canvas.id).each do |canvas_user_role|
					canvas.banned.should include(canvas_user_role)
				end
			end
		end
	end
	
	context "after_validation callbacks" do
		context "on create" do
			it "should add a canvas owner role for the new creator" do
				user = Factory.create(:user)
				canvas = Factory.create(:canvas, :creator => user)
				user.canvas_role?(canvas, :owner).should be_true
			end
		end

		context "on update" do
			it "should add a canvas owner role for the new creator and leave the old owner with an :owner role" do
				user = Factory.create(:user)
				canvas = Factory.create(:canvas)
				old_owner = canvas.creator
				user.canvas_role?(canvas, :owner).should be_false
				canvas.creator = user
				canvas.save
				user.canvas_role?(canvas, :owner).should be_true
				old_owner.canvas_role?(canvas, :owner).should be_true
			end
		end
	end
	
end
