require 'spec_helper'

describe 'SessionsHelper' do
	describe '#login_link' do
	
		it "should respond to login_link" do
			helper.should respond_to(:login_link)
		end
	
		it "should output a link to login with facebook" do
			helper.login_link.should have_selector("a[href='/auth/facebook']")
		end
	
		context "optional parameters" do
			it "should accept an optional hash of options" do
				helper.should respond_to(:login_link).with(0).arguments
				helper.should respond_to(:login_link).with(1).argument
			end
		
			it "should set the link text based on options[:text]" do
				helper.login_link(:text=>"Foo").should contain("Foo")
			end
		
			it "should default the link text to 'click here'" do
				helper.login_link().should contain("click here")
			end
		
			it "should add class login-link to the link" do
				helper.login_link.should have_selector("a.login-link")
			end
			
			it "should set contents using optional block" do
				
				link = helper.login_link do
					"Block Rock"
				end
				link.should contain("Block Rock")
				
			end
		end
		
		context "mixpanel tracking" do
			it "should track_links" do
				helper.login_link.should contain(%(mpq.push(["track_links",$(".login-link"),"click_login"]);))
			end
		end
	
	end

	
end