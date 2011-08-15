require 'spec_helper'

describe "widgets/sections/_content.html.haml" do
  
	context "text widget" do
		before(:each) do
			@widget = FactoryGirl.build(:text_widget)
		end
		
		it "should display widget text" do
			render :partial => "widgets/sections/content", :object => @widget, :as => :widget
			rendered.should include(@widget.text)
		end
		
		context "html in text" do
			let(:html) {"<h2>this is html</h2>"}
			before(:each) do
				@widget = FactoryGirl.build(:text_widget, :text => html)
			end
			
			it "should include html tags" do
				render :partial => "widgets/sections/content", :object => @widget, :as => :widget
				rendered.should include(html)
			end
		end
		
		context "large amounts of text" do
			before(:each) do
				@widget = FactoryGirl.build(:long_text_widget)
			end

			it "should display all the widget text" do
				render :partial => "widgets/sections/content", :object => @widget, :as => :widget
				rendered.strip.should == @widget.text.strip
			end
		end
	end

  context "image widget" do
		before(:each) do
			@widget = FactoryGirl.build(:image_widget)
			render :partial => "widgets/sections/content", :object => @widget, :as => :widget
		end
		
    it "should display the image" do
			rendered.should have_selector("img[src='#{@widget.image}']")
    end

		it "should use the alt text for the image" do
			rendered.should have_selector("img[alt='#{@widget.alt_text}']")
		end
  end
end