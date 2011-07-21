require 'spec_helper'

describe TextContent do
  
  it "should be able to have a widget" do
    Factory.build(:text_content).should respond_to(:widget)
  end
  
end
