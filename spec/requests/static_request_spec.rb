require "spec_helper"

describe "Static Requests" do

  describe "GET /" do

    before(:each) do
      @canvas = Factory.create(:canvas)
      get "/"
    end

    it "should work" do
      response.status.should be(200)
    end

    it "lists the most recent canvases on the page" do
      response.body.should include(@canvas.name)  
    end

  end
  
end