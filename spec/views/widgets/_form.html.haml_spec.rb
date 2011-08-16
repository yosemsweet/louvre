require 'spec_helper'

describe "widgets/_form.html.haml" do
  
	before do
    controller.singleton_class.class_eval do
      private
        def current_user
          user ||= Factory.create(:user) 
        end
        helper_method :current_user
    end

		@canvas = Factory.create(:canvas)
	end
	
	context "text widget" do
		
		before(:each) do
			@widget = @canvas.widgets.new(:content_type => 'text_content')
			render :partial => 'form', :object => @widget, :as => :widget
		end
		
		it "should render a form" do
			rendered.should have_selector("form")
		end
		
		it "should set the content_type" do
			rendered.should have_selector("input[name='widget[content_type]'][value='text_content']")
		end
		
		it "should have a field for text" do
			rendered.should have_selector("textarea[name='widget[text]']")			
		end
	end
		
	context "image widget" do
		before(:each) do
			@widget = @canvas.widgets.new(:content_type => 'image_content')
			render :partial => 'form', :object => @widget, :as => :widget
		end
		
		it "should render a form" do
			rendered.should have_selector("form")
		end
		
		it "should set the content_type" do
			rendered.should have_selector("input[name='widget[content_type]'][value='image_content']")
		end
		
		it "should have a field for image" do
			rendered.should have_selector("input[name='widget[image]']")
		end

		it "should have a field alt text" do
			rendered.should have_selector("input[name='widget[alt_text]']")
		end		
	end

	context "link widget" do
		before(:each) do
			@widget = @canvas.widgets.new(:content_type => 'link_content')
			render :partial => 'form', :object => @widget, :as => :widget
		end
		
		it "should render a form" do
			rendered.should have_selector("form")
		end
		
		it "should set the content_type" do
			rendered.should have_selector("input[name='widget[content_type]'][value='link_content']")
		end
		
		it "should have a field for link" do
				rendered.should have_selector("input[name='widget[link]']")
			end

		it "should have a field for title" do
			rendered.should have_selector("input[name='widget[title]']")
		end

		it "should have a field for text" do
			rendered.should have_selector("input[name='widget[title]']")
		end
	end
end