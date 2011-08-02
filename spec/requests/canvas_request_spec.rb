require "spec_helper"

describe "Canvae Requests" do

  describe "GET /canvae/[id]" do

    before(:each) do
      canvas = Factory.create(:canvas)
      get "/canvae/#{canvas.id}"
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