require 'spec_helper'

describe Comment do
  context "Validation" do
		let(:comment) {Factory.build(:comment)}
		
		it "should be valid with valid params" do
			puts comment.creator
			comment.should be_valid
		end
		
		it "should have a creator" do
			comment.should respond_to(:creator)
		end
		
		it "should require a creator" do
			comment.creator = nil
			comment.should_not be_valid
		end
		
		it "should belong to a widget" do
			comment.should respond_to(:widget)
		end
				
		it "should require a widget" do
			comment.widget = nil
			comment.should_not be_valid
		end
		
		it "should have content" do
			comment.should respond_to(:content)
		end
				
		context "content validation" do
			it "should require content not nil" do
				comment.content = nil
				comment.should_not be_valid
			end
			
			it "should require content not empty string" do
				comment.content = ""
				comment.should_not be_valid
			end
		end
	end
end
