require 'spec_helper'

describe "canvae/_brief.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
		controller.stubs(:like_button_for).returns("<fb:like url='#{@canvas.id}/>".html_safe)
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
	
	it "should link to the canvas homepage" do
		rendered.should have_selector("a[href='#{canvas_path(@canvas)}']")
	end

	context "image present" do

		it "should show the canvas' image" do
			rendered.should have_selector("img[src='#{@canvas.image}']")
		end
	end
	
	context "no image present" do
		before(:each) do
			@canvas.image = nil
		end
		
		it "shouldn't show the canvas' image" do
			rendered.should_not have_selector("img[src='#{@canvas.image}']")
		end
	end

	context "facebook tools" do
		
		it "should provide facebook like for canvas" do
			pending "Ran into troubles getting like_button_for stub to work with the view."
		end
	end

end