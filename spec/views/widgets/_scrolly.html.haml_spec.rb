require 'spec_helper'

describe "widgets/_scrolly.html.haml" do
  before (:each) do
    @widget = Factory.create(:widget)
    render :partial => "widgets/scrolly", :object => @widget, :as => :widget
  end
  
	context "preview" do
		it "should have a preview element as a child of the widget" do
			rendered.should have_selector(".widget > .preview")
		end
		
		it "should have a link to expand the widget" do
			rendered.should have_selector("a.toggle_preview[href='#']")
		end
	end
		
	context "content" do
		it "should have a content element as a child of the widget" do
			rendered.should have_selector(".widget > .content")
		end
	end

  context "facebook comments" do
    it "should show number of fb comments" do
      pending #rendered.should have_selector(".comment_count")
    end
  end

	context "styling" do
		it "should add the content_type as a class on the widget" do
			rendered.should have_selector(".widget.#{@widget.content_type}")
		end
	end
end