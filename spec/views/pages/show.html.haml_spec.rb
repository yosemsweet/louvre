require 'spec_helper'

describe "pages/show.html.haml" do
  
  before(:each) do
    @page = Factory.create(:page)
    @canvas = @page.canvas
    @widgets = Widget.for_page(@page.id)
		view.stubs(:current_user).returns(@user)
		view.controller.stubs(:current_user).returns(@user)
  end
  
  # before do
  #    controller.singleton_class.class_eval do
  #      private
  #        def current_user
  #          nil
  #        end
  #        helper_method :current_user
  #    end
  #  end
  
  context "opengraph_meta_tags" do
		before(:each) do
			render
		end
		
	  it "renders opengraph_meta_tags" do
			view.content_for?(:opengraph_meta_tags).should be_true
	  end
	
		it "sets the opengraph title to page title" do
			view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:title'][content='#{@page.title}']")
		end
		
		it "sets the opengraph type to page.opengraph_type" do
			view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:type'][content='#{@page.opengraph_type}']")
		end
	
		it "og:url should show up in meta tags" do
		  view.content_for(:opengraph_meta_tags).should have_selector("meta[property='og:url'][content='#{canvas_page_url(@page.canvas, @page)}']")
	  end
	end
end