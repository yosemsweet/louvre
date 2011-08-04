require "spec_helper"

describe "Pages Requests" do
  
  describe "GET /canvae/[canvas_id]/pages/[page_id]/widgets" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      page = Factory.create(:page)
      @w1 = Factory.create(:widget, :canvas => canvas, :page => page, :position => 1, :content => "FirstGuy")
      @w2 = Factory.create(:widget, :canvas => canvas, :page => page, :position => 2, :content => "IAmLast")
      get "/canvae/#{canvas.id}/pages/#{page.id}/widgets"
    end
    
    it "should work" do
      response.status.should == 200
    end
    
    it "should render the widgets for the page" do
      response.body.should have_css(".widget", :count => 2)
    end
    
    it "should list the widgets in order of position" do
      css_select(".widget .content").first.should match(/FirstGuy/)
      css_select(".widget .content").last.should match(/IAmLast/)
    end
    
  end
  
  
end