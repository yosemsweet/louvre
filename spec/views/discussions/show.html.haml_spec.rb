require 'spec_helper'

describe "discussions/show.html.haml" do
  
  before (:each) do
    @canvas = Factory.create(:canvas)
    render
  end
  
  it "should call fbxml parse" do
    rendered.should contain("FB.XFBML.parse();")
  end
end