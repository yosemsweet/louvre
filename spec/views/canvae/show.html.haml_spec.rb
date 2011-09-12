require 'spec_helper'

describe "canvae/show.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
    Factory.create(:role, {:name => "owner", :xp => 800})
    Factory.create(:role, {:name => "user", :xp => 100})
    @new_widgets = []
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

	context "input feed" do
		it "displays the canvas input feed" do
			render
			rendered.should have_selector('#feed')
		end

		context "add widget links" do
			it "has a link to add text widgets" do
				render
				rendered.should have_selector("a.add_widget[data-content_type='text_content']")
			end
			
			it "has a link to add image widgets" do
				render
				rendered.should have_selector("a.add_widget[data-content_type='image_content']")
			end
			
			it "has a link to add link widgets" do
				render
				rendered.should have_selector("a.add_widget[data-content_type='link_content']")
			end
			
		end
	
	end
end