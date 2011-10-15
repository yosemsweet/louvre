require 'spec_helper'

describe "canvae/show.html.haml" do
  before(:each) do
	  @canvas = Factory.create(:canvas)
	  @user = Factory.create(:user)
		@user.set_canvas_role(@canvas,:member)
    @new_widgets = []	
		view.stubs(:current_user).returns(@user)
		view.controller.stubs(:current_user).returns(@user)
		render
  end

	context "input feed" do
		it "displays the canvas input feed" do
			rendered.should have_selector('#feed')
		end

		context "add widget links" do
			it "has a link to add text widgets" do
				rendered.should have_selector(".add_widget[data-content_type='text_content']")
			end
			
			it "has a link to add image widgets" do
				rendered.should have_selector(".add_widget[data-content_type='image_content']")
			end
			
			it "has a link to add link widgets" do
				rendered.should have_selector(".add_widget[data-content_type='link_content']")
			end
			
		end
	
	end
	
end