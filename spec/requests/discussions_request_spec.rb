require "spec_helper"

describe "Dicussions Requests" do

  describe "GET discussions" do

    before(:each) do
      @canvas = Factory.create(:canvas)
      get "/discussions/canvas/#{@canvas.id}", :href => canvas_url(@canvas)
    end

    it "should work" do
      response.status.should be(200)
    end

    it "renders the discussions on the canvas" do
      response.body.should have_selector("comments[href='#{CGI.escape(canvas_url(@canvas))}']")
    end
   end
end