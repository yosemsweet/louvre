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

	describe "GET /next_scroll_widgets" do
		
		before(:each) do
			canvas = Factory.create(:canvas)
			@widgets = []
			10.times do |i|
				@widgets << Factory.create(:widget, :canvas => canvas, :page => nil, :content => "#{i}")
			end				
			visit "/next_scroll_widgets"
		end
		
		it "should render html for 10 widgets" do
			response.body.should have_css("li.widget", :count => 10)
		end
		
		it "should work" do
      response.status.should be(200)
		end
				
	end

end