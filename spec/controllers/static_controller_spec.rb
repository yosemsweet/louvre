require 'spec_helper'

describe StaticController do
	describe "GET login" do
		it "should return a 200" do
			get :login
			response.should return_status(200)
		end
	end
end
