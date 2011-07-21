require 'spec_helper'

describe Thing do
  context "Validations" do
  	it "should be valid with valid parameters" do
  		thing = Factory.build(:thing)
  		thing.should be_valid
  	end

    it "should save properly to the database" do
      thing = Factory.build(:thing)
      thing.save!
    end
  
  	context "attribute validations" do
  		context "Content" do
  			it "should be required" do
  		  	thing = Factory.build(:thing, :content => "")
  		    thing.should_not be_valid
  		  end
		  
  		end
		  
  	  context "Creator" do
  			it "should have" do
  		  	thing = Factory.build(:thing)
  		    thing.should respond_to(:creator)
  		  end
		  
  		  it "should be required" do
  		    thing = Factory.build(:thing, :creator => nil)
  		    thing.should_not be_valid
  		  end
  		end
		
  		context "Canvas" do
  			it "should have" do
  		  	thing = Factory.build(:thing)
          thing.should respond_to(:canvas)
  		  end
		  
  		  it "should be required" do
  		    thing = Factory.build(:thing, :canvas => nil)
  		    thing.should_not be_valid
  		  end
  		end
  	end	
  end
end
