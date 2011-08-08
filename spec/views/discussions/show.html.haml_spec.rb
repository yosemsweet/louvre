require 'spec_helper'

describe "discussions/show.html.haml" do
  
  before (:each) do
    @obj = Factory.create(:canvas)
    assign(:href, canvas_url(@obj))
    render :template => "discussions/show.html"
  end
  
  it "should call fbxml parse" do
    rendered.should include("FB.XFBML.parse();")
  end
end