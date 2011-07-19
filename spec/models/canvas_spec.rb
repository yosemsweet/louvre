require 'spec_helper'

describe Canvas do
  context "Validations" do
		it "should be valid with valid parameters" do
			canvas = Factory.build(:canvas)
			canvas.should be_valid
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
			
			context "Owner" do
				it "should have an owner" do
					canvas = Factory.build(:canvas)
					canvas.should respond_to(:owner)
				end
				
				it "should be required" do
					canvas = Factory.build(:canvas, :owner => nil)
					canvas.should_not be_valid
				end
			end
		end
	
	end
end