require 'spec_helper'

describe "canvae/new.html.haml" do
	before(:each) do
    @canvas = Factory.build(:canvas)
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

	context "form fields" do
		it "should ask for canvas name" do
			render
			rendered.should have_selector('form #canvas_name')
		end
		
		it "should ask for canvas mission" do
			render
			rendered.should have_selector('form #canvas_mission')
		end
		
		it "should ask for an image to associate with the canvas" do
			render
			rendered.should have_selector('form #canvas_image')
		end
		
		it "should ask if the canvas will allow contribtions from the public" do
			render
			rendered.should have_selector('form #canvas_open')
		end
		
		
	end
  
end