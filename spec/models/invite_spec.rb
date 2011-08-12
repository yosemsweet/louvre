require 'spec_helper'

describe Invite do
  context "Validations" do
		it "should be valid with valid parameters" do
			invite = Factory.build(:invite)
			invite.should be_valid
		end
	
	  it "should save properly to the database" do
	    invite = Factory.build(:invite)
	    invite.save!
	  end
	  
		context "attribute validations" do
			
			context "Inviter" do
				it "should have a inviter" do
					invite = Factory.build(:invite)
					invite.should respond_to(:inviter)
				end
				
				it "should be required" do
					invite = Factory.build(:invite, :inviter => nil)
					invite.should_not be_valid
				end
			end
			
			context "Invitee" do
				it "should have a Invitee" do
					invite = Factory.build(:invite)
					invite.should respond_to(:invitee)
				end
				
				it "should be required" do
					invite = Factory.build(:invite, :invitee => nil)
					invite.should_not be_valid
				end
			end

			context "Canvas" do
				it "should have a canvas" do
					invite = Factory.build(:invite)
					invite.should respond_to(:canvas)
				end

				it "should be required" do
					invite = Factory.build(:invite, :canvas => nil)
					invite.should_not be_valid
				end
			end

		end
	
	end
	
end
