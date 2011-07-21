require 'spec_helper'

describe "pages/edit.html.haml" do
  before(:each) do
    @page = Factory.create(:page)
  end
  
  before do
     controller.singleton_class.class_eval do
       private
         def current_user
           nil
         end
         helper_method :current_user
     end
   end
  

  it "displays the canvas name for the logo" do
    pending "https://www.pivotaltracker.com/story/show/16051937"
    #render
    #view.content_for(:header).should have_selector('h1#logo', :content => @page.canvas.name) 
  end

  it "displays the page title" do
    pending "https://www.pivotaltracker.com/story/show/16051937"
		#render
    #page.should have_content(@page.title)
  end
  
end