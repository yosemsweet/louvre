require 'spec_helper'


describe "widgets/_editable.html.haml" do
  
	before(:each) do
    controller.singleton_class.class_eval do
      private
        def current_user
          user ||= Factory.create(:user) 
        end
        helper_method :current_user
    end
		@canvas = Factory.create(:canvas)
		@page = Factory.create(:page, :canvas => @canvas)
	end
	
	context "widget" do
		
		before(:each) do
			@widget = Factory.create(:widget, :canvas => @canvas, :page => @page)
			render :partial => 'editable', :object => @widget, :as => :widget
		end
		
		it "should render widget elements" do
			rendered.should have_widget_elements_for(@widget)
		end
		
		it "should add page_feed_widget class" do
			rendered.should have_selector(".editable_widget")
		end

		it "should have a widget_editable class" do
			rendered.should have_selector(".widget_editable")
		end
	end
end