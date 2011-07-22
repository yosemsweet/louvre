require 'spec_helper'

describe Widget do
  
  context "validations" do
  
    it "should be valid with valid attributes" do
      Factory.build(:widget, @canvas).should be_valid
    end
  
    it "should be able to have a page" do
      Factory.build(:widget).should respond_to(:page)
    end
  
    it "should be able to have a canvas" do
      Factory.build(:widget).should respond_to(:canvas)
    end
  
    it "should require a canvas" do
      Factory.build(:widget, :canvas_id => nil).should_not be_valid
    end
    
    it "should be able to have a creator" do
      Factory.build(:widget).should respond_to(:creator)
    end
  
    it "should require a creator" do
      Factory.build(:widget, :creator_id => nil).should_not be_valid
    end
  
  end
  
end
