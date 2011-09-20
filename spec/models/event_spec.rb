require 'spec_helper'

describe Event do
	context "attributes" do

		it "should respond to url" do
			event = Factory.build(:event)
			event.should respond_to(:url)
		end

	end
end