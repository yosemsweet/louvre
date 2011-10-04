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
				rendered.strip.should include(@widget.text.strip)
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
		
		it "should have a caption" do
			rendered.should have_selector("figcaption")
		end
  end

  context "link widget" do
		
		before(:each) do
			@widget = FactoryGirl.build(:link_widget)
		end
		
    it "should display the link" do
			render :partial => "widgets/sections/content", :object => @widget, :as => :widget
			rendered.should have_selector("a.link[href='#{@widget.link}']", :content => @widget.title)
    end

		context "without a quote" do
			before(:each) do
				@widget = FactoryGirl.build(:quoted_link_widget, :text => nil)
			end
			
			it "should not add a source class to the link" do
				render :partial => "widgets/sections/content", :object => @widget, :as => :widget
				rendered.should_not have_selector("a.link.source[href='#{@widget.link}']")
			end
			
			context "with an empty quote" do
				before(:each) do
					@widget.text = ""
				end
				
				it "should not add a source class to the link" do
					render :partial => "widgets/sections/content", :object => @widget, :as => :widget
					rendered.should_not have_selector("a.link.source[href='#{@widget.link}']")
				end
				
			end
			
		end

		context "with a quote" do
			before(:each) do
				@widget = FactoryGirl.build(:quoted_link_widget)
			end
			
			it "should display the quote" do
				render :partial => "widgets/sections/content", :object => @widget, :as => :widget
				rendered.should have_selector("blockquote", :content => @widget.text)				
			end
			
			it "should add a source class to the link" do
				render :partial => "widgets/sections/content", :object => @widget, :as => :widget
				rendered.should have_selector("a.link.source[href='#{@widget.link}']")
			end
		end

  end


end