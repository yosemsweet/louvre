require 'spec_helper'

describe Widget do
  
  context "validations" do
  
    it "should be able to have a page" do
      Factory.build(:widget).should respond_to(:page)
    end
  
    it "should be able to have content" do
      Factory.build(:widget).should respond_to(:content)
    end
  
    it "should be able to have a canvas" do
      Factory.build(:widget).should respond_to(:canvas)
    end
  
    it "should require a canvas" do
      Factory.build(:widget, :canvas_id => nil).should_not be_valid
    end
  
  end
  
  describe "#build_empty_content" do
    it "should build a text content with type of TextContent" do
      content = Factory.build(:widget).build_empty_content("TextContent")
      content.class.name.should == "TextContent"
    end
    
    it "should build a text content with random type" do
      content = Factory.build(:widget).build_empty_content("Random")
      content.class.name.should == "TextContent"
    end
  end
  
end
