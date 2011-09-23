require 'spec_helper'

describe "pages/edit.html.haml" do
  
  before(:each) do
    @page = Factory.create(:page)
    @widgets = Widget.for_page(@page.id)
		@canvas = @page.canvas
		@new_widgets = {
			:text_widget => Widget.new(:content_type => "text_content", :page => @page),
			:image_widget => Widget.new(:content_type => "image_content", :page => @page)
		}
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

	context "page feed" do
		it "should have a #feed element" do
			render
			rendered.should have_selector("#feed")
		end
		
		context "with widgets" do
			before(:each) do
				Factory.create(:widget, :canvas => @canvas)
			end
			
			it "should list all widgets" do
				render
				@canvas.widgets.each do |w|
					rendered.should have_selector("#feed .widget[data-widget_id='#{w.id}']")
				end
			end
		end
	end
 
end