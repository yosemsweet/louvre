require 'spec_helper'

describe "canvae/apply.html.haml" do
	before(:each) do
	  @canvas = Factory.create(:canvas, :open => false )
		view.stubs(:current_user).returns(nil)
		view.controller.stubs(:current_user).returns(nil)
	end


	context "#apply" do
	  context "not logged in" do
	     it "should exist" do
   			render :partial => 'apply', :object => @canvas, :as => :canvas
   			rendered.should have_selector('#apply')
   		end
   		
   		it "should ask user to sign up to apply" do
   		  render :partial => 'apply', :object => @canvas, :as => :canvas
   			rendered.should include("Sign In to Apply")
   		end
   		
   		it "should link to sign in page" do
   		  render :partial => 'apply', :object => @canvas, :as => :canvas
   			rendered.should have_selector("a#apply[href='/auth/facebook']")
   		end
  	end
    
    
	  context "logged in" do
	    before(:each) do
	      @user = Factory.create(:user)
    		view.stubs(:current_user).returns(@user)
    		view.controller.stubs(:current_user).returns(@user)
    	end
    	
	    it "should exist" do
  			render :partial => 'apply', :object => @canvas, :as => :canvas
  			rendered.should have_selector('#apply')
  		end
  		
  		it "should ask user to sign up to apply" do
   		  render :partial => 'apply', :object => @canvas, :as => :canvas
   			rendered.should include("Apply Now")
   		end
	  end
	  
	 
	end
end