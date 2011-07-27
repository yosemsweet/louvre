require "spec_helper"

describe "Widgets Requests" do

  describe "GET /canvae/[id]/widgets" do

    before(:each) do
      canvas = Factory.create(:canvas)
      page = Factory.create(:page)
      @w_on_page = Factory.create(:widget, :canvas => canvas, :page => page, :content => "Happy Feet")
      @w_not_on_page = Factory.create(:widget, :canvas => canvas, :page => nil, :content => "Hungry Almas")
      get "/canvae/#{canvas.id}/widgets"
    end

    it "should work" do
      response.status.should be(200)
    end

    it "renders the widgets on the canvas" do
      response.body.should include(@w_not_on_page.content)  
    end
    
    it "doesn't render any widgets that are on a page" do
      response.body.should_not include(@w_on_page.content)  
    end
    
  end
end