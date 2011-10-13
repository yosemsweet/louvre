require 'spec_helper'

describe 'layouts/application.html.haml' do

	before(:each) do
		stub_template "canvae/_header.html.haml" => "canvas header partial"
		view.stubs(:current_user).returns(nil)
		view.controller.stubs(:current_user).returns(nil)
	end

	context '@canvas not defined' do
		before(:each) do
			@canvas = nil
		end
		
		it "should not render the canvae/_header partial" do
			render
			rendered.should_not =~ /canvas header partial/
		end
	end

	context '@canvas defined' do
		before(:each) do
		  @canvas = Factory.create(:canvas)
		end

		it "should render the canvae/_header partial" do
			render
			rendered.should =~ /canvas header partial/
		end
	end
	
end