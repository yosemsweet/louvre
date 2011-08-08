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
  
  describe "POST /canvae/[canvas_id]/widgets/[widget_id]/clone_widget" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      @page = Factory.create(:page)  
      @widget = Factory.create(:widget, :canvas => canvas, :page_id => nil, :content => "Happy Feet")
      post "/canvae/#{canvas.id}/widgets/#{@widget.id}/clone_widget", :position => 1, :page_id => @page.id
      @latest_widget = Widget.last
    end
    
    it "should create a new widget" do
      Widget.all.length.should == 2
      @latest_widget.id.should_not == @widget.id
    end
    
    it "should copy the cloned widget's content" do
      @latest_widget.content.should == @widget.content
    end
      
    it "should set the new widget's page" do
      @latest_widget.page_id.should == @page.id
    end
    
    it "should set the new widget's position" do
      @latest_widget.position.should == 1
    end
    
  end
  
  describe "PUT /canvae/[canvas_id]/widgets/[widget_id]/update_position" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      p = Factory.create(:page)  
      @w1 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 1)
      @w2 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 2)
      put "/canvae/#{canvas.id}/widgets/#{@w2.id}/update_position", :position => 1
    end
    
    it "should update the widget's position" do
      @w2.reload.position.should == 1
    end
    
    it "should update the position of other widgets on the page appropriately" do
      @w1.reload.position.should == 2
    end
    
  end
  
  # describe "DELETE /canvae/[canvas_id]/widgets/[widget_id]" do
  #   
  #   before(:each) do
  #     canvas = Factory.create(:canvas)
  #     widget = Factory.create(:widget, :canvas => canvas, :position => 1)
  #     delete "/canvae/#{canvas.id}/widgets/#{widget.id}"
  #   end
  #   
  #   it "should delete the widget" do
  #     Widget.all.length.should == 0
  #   end
  #   
  # end

	describe "GET /next_scroll_widgets" do
		
		before(:each) do
			canvas = Factory.create(:canvas)
			@widgets = []
			10.times do |i|
				@widgets << Factory.create(:widget, :canvas => canvas, :page => nil, :content => "#{i}")
			end				
			get "/next_scroll_widgets"
		end
		
		it "should render html for 10 widgets" do
			response.body.should have_css("li.widget", :count => 10)
		end
		
		it "should work" do
      response.status.should be(200)
		end
				
	end
end