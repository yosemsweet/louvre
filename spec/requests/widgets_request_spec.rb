require "spec_helper"

describe "Widgets Requests" do
  
  before(:each) do
    @user = Factory.create(:user)
    # Stub the current_user method so it appears like a user is logged in.
    WidgetsController.any_instance.stubs(:current_user).returns(@user)
  end
  
  describe "POST /widgets/[widget_id]/copy_to_page/[page_id]" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      @page = Factory.create(:page)  
      @widget = Factory.create(:widget, :canvas => canvas, :page_id => nil, :content => "Happy Feet")
      post "/widgets/#{@widget.id}/copy_to_page/#{@page.id}", :position => 1
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
  
    describe "PUT /widgets/[widget_id]/move/[position]" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        p = Factory.create(:page)  
        @w1 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 1)
        @w2 = Factory.create(:widget, :canvas => canvas, :page_id => p.id, :position => 2)
        put "/widgets/#{@w2.id}/move/1"
      end
      
      it "should update the widget's position" do
        @w2.reload.position.should == 1
      end
      
      it "should update the position of other widgets on the page appropriately" do
        @w1.reload.position.should == 2
      end
      
    end
    
    describe "DELETE /widgets/[widget_id]" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        widget = Factory.create(:widget, :canvas => canvas, :position => 1)
        delete "/widgets/#{widget.id}"
      end
      
      it "should delete the widget" do
        Widget.all.length.should == 0
      end
      
    end
  
  describe "GET /widgets" do
    
    before(:each) do
      canvas = Factory.create(:canvas)
      @widgets = []
      10.times do |i|
        @widgets << Factory.create(:widget, :canvas => canvas, :page => nil, :content => "#{i}")
      end       
      get "/widgets"
    end
    
    it "should render html for 10 widgets" do
      response.body.should have_css(".widget", :count => 10)
    end
    
    it "should work" do
        response.status.should be(200)
    end
        
  end
  
  describe "GET /widgets/for_page/[page_id]/editable" do
      
      before(:each) do
        canvas = Factory.create(:canvas)
        page = Factory.create(:page)
        @w1 = Factory.create(:widget, :canvas => canvas, :page => page, :position => 1, :content => "FirstGuy")
        @w2 = Factory.create(:widget, :canvas => canvas, :page => page, :position => 2, :content => "IAmLast")
        get "/widgets/for_page/#{page.id}/editable"
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
    
    describe "GET /widgets/for_canvas/[id]/canvas_feed" do
  
      before(:each) do
        canvas = Factory.create(:canvas)
        page = Factory.create(:page)
        @w_on_page = Factory.create(:widget, :canvas => canvas, :page => page, :content => "Happy Feet")
        @w_not_on_page = Factory.create(:widget, :canvas => canvas, :page => nil, :content => "Hungry Almas")
        get "/widgets/for_canvas/#{canvas.id}/canvas_feed"
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