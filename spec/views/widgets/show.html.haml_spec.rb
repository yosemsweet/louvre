require 'spec_helper'

describe "widgets/show.html.haml" do
  
  before(:each) do
    @widget = Factory.create(:widget)
		view.stubs(:current_user).returns(@user)
		view.controller.stubs(:current_user).returns(@user)
  end

  context "opengraph_meta_tags" do
		before(:each) do
			render
		end
		
	  it "renders opengraph_meta_tags" do
			view.content_for?(:opengraph_meta_tags).should be_true
	  end
	
		it "sets the opengraph title to widget opengraph title" do
			view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:title'][content='#{@widget.opengraph_title}']")
		end
		
		it "sets the opengraph type to widget.opengraph_type" do
			view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:type'][content='#{@widget.opengraph_type}']")
		end
	
		it "og:url should show up in meta tags" do
		  view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:url'][content='#{widget_url(@widget)}']")
	  end
	end
end