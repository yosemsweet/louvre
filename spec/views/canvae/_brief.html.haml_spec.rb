require 'spec_helper'

describe "canvae/_brief.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
		render :partial => 'brief', :object => @canvas, :as => :canvas
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

	it "should use a div for the canvas" do
		rendered.should have_selector("div.canvas#canvas_#{@canvas.id}")
	end

	it "should add a brief class to the parent div" do
		rendered.should have_selector(":first-child.brief")
	end
	

	it "should display canvas name" do
		rendered.should include(@canvas.name)
	end

	it "should display the canvas' mission" do
		rendered.should include(@canvas.mission)
	end

end