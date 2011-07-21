require 'spec_helper'

describe Canvas do
  context "Validations" do
		it "should be valid with valid parameters" do
			canvas = Factory.build(:canvas)
			canvas.should be_valid
		end
	
	  it "should save properly to the database" do
	    canvas = Factory.build(:canvas)
	    canvas.save!
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
			
			context "Things" do
				it "should have Things" do
					canvas = Factory.build(:canvas)
					canvas.should respond_to(:things)
				end
			end
			
		end
	
	end
end
