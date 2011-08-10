require 'spec_helper'

describe "widgets/sections/_comments.html.haml" do
  before (:each) do
    @widget = Factory.create(:widget)
    render :partial => "widgets/sections/comments", :object => @widget, :as => :widget
  end
  
  context "facebook comments" do
    it "should show number of fb comments" do
      rendered.should have_selector(".comment_count") 
    end
    
    # it "should track when people read comments" do
    #   rendered.should include("\"track\",\"comment_added\"") 
    # end
    # 
    # it "should track when people read comments" do
    #   rendered.should include("\"track\",\"comment_removed\"")
    # end
  end
end