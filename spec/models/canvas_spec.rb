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
		
			context "Mission" do
				it "should be required" do
					canvas = Factory.build(:canvas, :mission => "")
					canvas.should_not be_valid
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
					page.should respond_to(:opengraph_data)
				end

				it "should return cause as opengraph type" do
					page.opengraph_type.should == 'cause'
				end

				it "should return page title as opengraph title" do
					page.opengraph_title.should == canvas.name
				end

				it "should return canvas image as opengraph image" do
					page.opengraph_image.should == canvas.image
				end
			end
		end
	
	end
end
