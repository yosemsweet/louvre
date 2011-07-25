require 'spec_helper'

describe Comment do
  context "Validations" do
  	it "should be valid with valid parameters" do
  		comment = Factory.build(:comment)
  		comment.should be_valid
  	end

    it "should save properly to the database" do
      comment = Factory.build(:comment)
      comment.save!
    end
  
  	context "attribute validations" do
  		context "Content" do
  			it "should be required" do
  		  	comment = Factory.build(:comment, :content => "")
  		    comment.should_not be_valid
  		  end
		  
  		end
		  
  	  context "Creator" do
  			it "should have" do
  		  	comment = Factory.build(:comment)
  		    comment.should respond_to(:creator)
  		  end
		  
  		  it "should be required" do
  		    comment = Factory.build(:comment, :creator => nil)
  		    comment.should_not be_valid
  		  end
  		end
		
  		context "Thing" do
  			it "should have" do
  		  	comment = Factory.build(:comment)
          comment.should respond_to(:thing)
  		  end
		  
  		  it "should be required" do
  		    comment = Factory.build(:comment, :thing => nil)
  		    comment.should_not be_valid
  		  end
  		end
  		
  	end	
  end
end

