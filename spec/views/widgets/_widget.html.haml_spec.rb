require 'spec_helper'

describe "widgets/_widget.html.haml" do
  before (:each) do
    @widget = Factory.create(:widget)
    render @widget, :widget =>  @widget
  end
  
  context "facebook comments" do
    it "should show number of fb comments" do
      rendered.should contain("FB.api('/comments?ids=#{canvas_widget_url(@widget.canvas, @widget)}'") 
    end
    
    it "should show all comments" do
      rendered.should have_selector(".comments-view-add") 
      rendered.should contain("#{discussion_path(@widget.class.to_s.downcase, @widget.id)}?href=#{canvas_widget_url(@widget.canvas, @widget)}&width=600" ) 
    end
  end
end