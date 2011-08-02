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

	context "input stream" do
		it "displays the canvas input stream" do
			render
			rendered.should have_selector('#input_stream')
		end
     
     
     it "loads widgets" do
       render
       rendered.should contain("load(\"#{canvas_widgets_path(@canvas)}\"")
     end

	end
	
	context "discussions" do
	  before(:each) do
      render
    end
    
    it "displays the canvas discussions" do
			rendered.should have_selector('#discussions')
		end
		
		it "loads discussions" do
		  rendered.should contain("load(\"#{canvas_discussions_path(@canvas)}?width=600\"")
		end
	end
	
end