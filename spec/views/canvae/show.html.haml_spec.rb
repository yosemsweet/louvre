require 'spec_helper'

describe "canvae/show.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
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
    render
    puts view.content_for(:header).to_yaml
    view.content_for(:header).should have_selector('h1#logo', :content => @canvas.name) 
  end
  
end