require 'spec_helper'

describe 'TrackingHelper' do
	describe '#track_email' do
	
		it "should respond to tracked_canvas_link" do
			helper.should respond_to(:track_email)
		end
		
		it "should require three arguments" do
			helper.should respond_to(:track_email).with(3).arguments
		end
	
		let(:body) { 
			<<-BODY
			Hi,
			Please come join 
			
			<a href="http://asuacybook.com/canvae/1">http://asuacybook.com/canvae/1</a>
			
			and help me rule RSPEC!
			
			Cheers,
			y
			
			BODY
			}
		let(:canvas) {Factory.create(:canvas)}
		let(:user) {Factory.create(:user)}
		it "should return a tracked email" do
			helper.track_email(body, canvas, user).should_not == body
		end
	end
end