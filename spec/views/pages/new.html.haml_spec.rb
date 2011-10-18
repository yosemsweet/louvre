require 'spec_helper'

describe "pages/new.html.haml" do
  
  before(:each) do
		view.stubs(:current_user).returns(@user)
		view.controller.stubs(:current_user).returns(@user)
		render
  end
  

	context "page header" do
	end
 
end