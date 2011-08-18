require 'spec_helper'

describe Email do
  
  it "should require an email address" do
    Factory.build(:email, :address => nil).should_not be_valid
  end

  describe "#primary_address?" do
    
    it "should return true if primary email address" do
      Factory.build(:email, :primary => 1).primary_address?.should == true
    end
    
    it "should return false if not primary email" do
      Factory.build(:email, :primary => 0).primary_address?.should == false
    end
    
  end

end
