require 'spec_helper'

describe "widgets/_page_feed.html.haml" do
  
	before(:each) do
    controller.singleton_class.class_eval do
      private
        def current_user
          user ||= Factory.create(:user) 
        end
        helper_method :current_user
    end
		@canvas = Factory.create(:canvas)
	end
	
	context "widget" do
		
		before(:each) do
			@widget = Factory.create(:widget, :canvas => @canvas)
			render :partial => 'page_feed', :object => @widget, :as => :widget
		end
		
		it "should render widget elements" do
			rendered.should have_widget_elements_for(@widget)
		end
		
		it "should add page_feed_widget class" do
			rendered.should have_selector(".page_feed_widget")
		end
		
		it "should have facebook comment elements" do
			rendered.should have_selector(".comment_count")
		end
		
		it "should have an element with a tags class" do
			rendered.should have_selector(".tags")
		end
	
		it "should not have a widget_editable class" do
			rendered.should_not have_selector(".widget_editable")
		end	
	end
end