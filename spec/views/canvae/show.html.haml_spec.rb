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

	context "canvas name" do
		it "should display the canvas name" do
			rendered.should have_selector('#canvas_name_text')
		end
		
		context "as a canvas owner" do
			before(:each) do
				@user.set_canvas_role(@canvas, :owner)
				render
			end
			
			it "should have a canvas edit form" do
				rendered.should have_selector("#edit_canvas_#{@canvas.id}")
			end
		end
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
	
	context "links to canvas management tools for owners" do
	  before(:each) do
      @user.set_canvas_role(@canvas, :owner)
      render
	  end
	  
	  it "has a link to applicants page" do
	    rendered.should have_link("Applicants")
	  end

	  it "has a link to members page" do
	    rendered.should have_link("Members")
	  end 
	end
	
	
end