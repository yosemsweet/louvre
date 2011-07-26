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
  

  context "header" do
	  it "displays the canvas name for the logo" do
	    render
	    view.content_for(:header).should have_selector('h1#logo', :content => @canvas.name) 
	  end
	end
  

	context "input stream" do
		it "displays the canvas input stream" do
			render
			rendered.should have_selector('#input-stream')
		end
		
		context "with widgets" do
			before(:each) do
				10.times do
					@canvas.widgets.create( Factory.create(:widget) )
				end
			end
			
			it "displays all widgets in the widget stream" do
				render
				@canvas.widgets.each do |widget|
					rendered.should have_selector(".widget .content", :content => widget.content)
				end
			end
		end
	end
	
	
end