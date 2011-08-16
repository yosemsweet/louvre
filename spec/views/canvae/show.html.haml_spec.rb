require 'spec_helper'

describe "canvae/show.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
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

	context "input stream" do
		it "displays the canvas input stream" do
			render
			rendered.should have_selector('#feed')
		end
	end
end