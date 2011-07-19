require 'spec_helper'

describe Canvas do
  context "Validations" do
	
		context "Canvas Name" do
			it "should be required" do
		  	canvas = Factory.build(:canvas, :name => "")
		    canvas.should_not be_valid
		  end
		
			it "should be unique" do
				canvas = Factory.build(:canvas, :name =>"foo")
				canvas.should be_valid
				canvas.save #uniqueness only tests against saved values - is this appropriate?
				canvas_duplicate_name = Factory.build(:canvas, :name =>"foo")
				canvas_duplicate_name.should_not be_valid
			end
		end
	
	end
end
